# formarks

`formarks` is a zsh plugin for quickly navigating your work path

![screenshot](https://raw.githubusercontent.com/wfxr/i/master/formarks.gif)

## Installation

Make sure you have [`fzf`](https://github.com/junegunn/fzf) installed.

### for [zplug](https://github.com/zplug/zplug) (Recommend)

``` zsh
zplug 'wfxr/formarks'
```

### for [zgen](https://github.com/tarjoilija/zgen)

``` zsh
zgen load wfxr/formarks
```

### for [antigen](https//github.com/zsh-users/antigen)

``` zsh
antigen bundle wfxr/formarks
```

### Manually

Clone this repo somewhere and source the `formarks.plugin.zsh` at ~/.zshrc.

## Usage

| Command  | Action                        |
| -------- | ----------------------------- |
| `mark`   | **m**ark current path             |
| `jump`   | **j**ump to the selected bookmark |
| `dmarks` | **d**elete the selected bookmarks |
| `lmarks` | **l**ist all registered bookmarks |
| `cmarks` | **c**lean invalid bookmarks       |

Default key-binding for `jump` is `ctrl - g`.

## Env variable

You can set a different directory to your marks than $HOME/.pathmarks exporting $PATHMARKS_FILE before loading this plugin.

Eg: `export $PATHMARKS_FILE=$XDG_DATA_HOME/pathmarks/file`

## Credits

*  [urbainvaes](https://github.com/urbainvaes): The project is originally forked from his [fzf-marks](https://github.com/urbainvaes/fzf-marks). Merging seams not possible for now because there are too many different commits between them. I do lots of modifications on `zsh` part but don't want to keep update with the `bash` part. So I migrate the [forked repo](https://github.com/wfxr/fzf-marks) to this new repo.

## [License](LICENSE.txt)

The MIT License (MIT)

Copyright (c) 2018 Wenxuan Zhang
