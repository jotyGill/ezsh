# quickz-sh
A simple script to setup an awesome shell environment.
Quickly install and setup zsh and oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh) with
* powerlevel9k theme (https://github.com/bhilburn/powerlevel9k/),
* Powerline fonts(https://github.com/powerline/fonts),
* zsh-completions (https://github.com/zsh-users/zsh-completions),
* zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions),
* zsh-syntax-highlighting (https://github.com/zsh-users/zsh-syntax-highlighting),
* history-substring-search (https://github.com/zsh-users/zsh-history-substring-search),
* fzf (https://github.com/junegunn/fzf),
* k (https://github.com/supercrabtree/k)
* marker (https://github.com/pindexis/marker)


## Installation
Requirements:
`wget git zsh` will be Automatically installed if not present. `python` is required to run '--cp-hist'

``` bash
git clone https://github.com/jotyGill/quickz-sh.git
cd quickz-sh
./quickz.sh
```
Optionally run it with '--cp-hist' to copy command history from .bash_history to .zsh_history.
``` bash
./quickz.sh --cp-hist  # don't run multiple times
```
