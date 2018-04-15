# formarks

`formarks` is a zsh plugin for quickly navigating your work path

## Installation

Make sure you have [`fzf`](https://github.com/junegunn/fzf) installed.

### for [zplug](https://github.com/zplug/zplug) (Recommend)

``` zsh
zplug 'wfxr/formarks'
```

### for [zgen](https://github.com/tarjoilija/zgen)
```
    zgen load wfxr/formarks
```

### for [antigen](https//github.com/zsh-users/antigen)

```
    antigen bundle wfxr/formarks
```

### Manually

Clone this repo somewhere and source the `formarks.plugin.zsh` at ~/.zshrc.

## Usage

| Commond  | Action                        |
| -------- | ----------------------------- |
| `mark`   | **m**ark current path             |
| `jump`   | **J**ump to the selected bookmark |
| `dmarks` | **D**elete the selected bookmarks |
| `lmarks` | **L**ist all registered bookmarks |
| `cmarks` | **C**lean invalid bookmarks       |

## Credits

*  [urbainvaes](https://github.com/urbainvaes): The project is originally forked from his [fzf-marks](https://github.com/urbainvaes/fzf-marks). Merging seams not possible for now because there are too many different commits between them. I do lots of modifications on `zsh` part but don't want to keep update with the `bash` part. So I migrate the [forked repo](https://github.com/wfxr/fzf-marks) to this new repo.

[MIT](LICENSE.txt)
