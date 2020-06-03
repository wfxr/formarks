#!/usr/bin/env zsh
#===============================================================================
#   Author: Wenxuan
#    Email: wenxuangm@gmail.com
#  Created: 2018-04-15 10:24
#===============================================================================

[ -z "${PATHMARKS_FILE}" ] && export PATHMARKS_FILE=$HOME/.pathmarks
[ ! -f $PATHMARKS_FILE ] && mkdir -p "$(dirname "$PATHMARKS_FILE")" && touch "$PATHMARKS_FILE"

wfxr::pathmarks-fzf() {
    local list
    (( $+commands[exa] )) && list='exa -lbhg --git' || list='ls -l'
    fzf --border \
        --ansi \
        --cycle \
        --reverse \
        --height '40%' \
        --preview="echo {}|sed 's#.*->  ##'| xargs $list --color=always" \
        --preview-window="right:50%" \
        "$@"
}

function mark() {
    [[ "$#" -eq 0 ]] && wfxr::mark_usage && return 1
    local mark_to_add
    mark_to_add=$(echo "$*: $(pwd)")
    echo "${mark_to_add}" >> "${PATHMARKS_FILE}"

    echo "** The following mark has been added **"
    echo "${mark_to_add}"
}

function dmarks()  {
    local lines
    lines=$(lmarks| wfxr::pathmarks-fzf --query="$*" -m)

    wfxr::pathmarks-delete "$lines"
}

# List all marks
function wfxr::lmarks() {
    sed 's#: # -> #' "$PATHMARKS_FILE"| nl| column -t
}

function lmarks() {
    wfxr::lmarks | wfxr::pathmarks-colorize
}

function wfxr::pathmarks-colorize() {
    local field='\(\S\+\s*\)'
    local esc=$(printf '\033')
    local N="${esc}[0m"
    local R="${esc}[31m"
    local G="${esc}[32m"
    local Y="${esc}[33m"
    local B="${esc}[34m"
    local pattern="s#^${field}${field}${field}${field}#$Y\1$R\2$N\3$B\4$N#"
    # Use GNU sed if possible
    # BSD sed(default sed on mac) can not display color by this pattern
    (( $+commands[gsed] )) && gsed "$pattern" || sed "$pattern"
}

# Prompt user to delete invalid marks
function cmarks() {
    local invalid_marks
    invalid_marks=$(wfxr::lmarks |
        wfxr::pathmarks-invalid |
        wfxr::pathmarks-colorize |
        wfxr::pathmarks-fzf -0 -m --header='** The following marks are not invalid anymore **')
    wfxr::pathmarks-delete "$invalid_marks"
}

# Delete selected pathmarks
function wfxr::pathmarks-delete() {
    local lines
    lines="$*"
    if [[ -n $lines ]]; then
        echo "$lines" |awk '{print $1}'| sed 's/$/d/'| paste -sd';'| xargs -I{} sed -i "{}" "$PATHMARKS_FILE"
        echo "** The following marks have been deleted **"
        echo "$lines"
    fi
}

# Show usage for function mark
function wfxr::mark_usage() {
    echo "Usage: mark <bookmark>" >&2
    echo "   eg: mark downloads"
}

# List invalid marks
function wfxr::pathmarks-invalid() {
    local line
    local directory
    while read line; do
        directory=$(echo "$line" |sed 's#.*->  ##')
        test -d "$directory" || echo "$line"
    done
}

function jump() {
    local target
    target=$(lmarks |
        wfxr::pathmarks-colorize |
        wfxr::pathmarks-fzf --query="$*" -1|
        sed 's#.*->  ##')
    if [[ -d "$target" ]]; then
        cd "$target" 
        local precmd
        for precmd in $precmd_functions; do
            $precmd
        done
        zle reset-prompt
    else
        zle redisplay # Just redisplay if no jump to do
    fi
}

zle -N jump
bindkey ${FZF_MARKS_JUMP:-'^g'} jump
