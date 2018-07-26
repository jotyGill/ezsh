# quickz-sh
A simple script to setup an awesome shell environment.
Quickly install and setup zsh and oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh) with
* powerlevel9k theme (https://github.com/bhilburn/powerlevel9k/)
* Powerline fonts(https://github.com/powerline/fonts)
* zsh-completions (https://github.com/zsh-users/zsh-completions)
* zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions)
* zsh-syntax-highlighting (https://github.com/zsh-users/zsh-syntax-highlighting)
* history-substring-search (https://github.com/zsh-users/zsh-history-substring-search)
* fzf (https://github.com/junegunn/fzf)
* k (https://github.com/supercrabtree/k)
* marker (https://github.com/pindexis/marker)
* todotxt (https://github.com/todotxt/todo.txt-cli)

All oh-my-zsh plugins are installed under ~/.oh-my-zsh
Other tools (fzf,marker,todo) are installed in ~/.quickzsh

NOTE: marker's shortcut "Ctr+t" clashed with fzf so I rebound it to "Ctr +b"

## Demo
Watch this to get an idea of what your shell (well, life!) could be like!!
[![asciicast](https://asciinema.org/a/DWdnOayem0yUCgQH5UrVZryM4.png)](https://asciinema.org/a/DWdnOayem0yUCgQH5UrVZryM4)

## Installation
Requirements:
`python3` or `python` is required to run option '--cp-hist'

``` bash
git clone https://github.com/jotyGill/quickz-sh.git
cd quickz-sh
./quickz.sh
```
First time run it with '--cp-hist' instead, to copy command history from .bash_history to .zsh_history.
``` bash
./quickz.sh --cp-hist  # running multiple times will duplicate history entries
```

Suggestions about more cool tools are always welcome :)
