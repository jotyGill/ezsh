#!/bin/bash

if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v wget &> /dev/null; then
    echo -e "ZSH and Git are already installed\n"
else
    if sudo apt install -y zsh git wget || sudo pacman -S zsh git wget || sudo dnf install -y zsh git wget || sudo yum install -y zsh git wget || sudo brew install git zsh wget || pkg install git zsh wget ; then
        echo -e "zsh wget and git Installed\n"
    else
        echo -e "Please install the following packages first, then try again: zsh git wget \n" && exit
    fi
fi


if mv -n ~/.zshrc ~/.zshrc-backup-$(date +"%Y-%m-%d"); then # backup .zshrc
    echo -e "Backed up the current .zshrc to .zshrc-backup-date\n"
fi


echo -e "Installing oh-my-zsh\n"
if [ -d ~/.config/oh-my-zsh ]; then
    echo -e "oh-my-zsh is already installed\n"
else
    git clone --depth=1 git://github.com/robbyrussell/oh-my-zsh.git ~/.config/oh-my-zsh
fi

cp -f .zshrc ~/


mkdir -p ~/.config/quickzsh       # external plugins, things, will be instlled in here

if [ -d ~/.config/oh-my-zsh/plugins/zsh-autosuggestions ]; then
    cd ~/.config/oh-my-zsh/plugins/zsh-autosuggestions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.config/oh-my-zsh/plugins/zsh-autosuggestions
fi

if [ -d ~/.config/oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    cd ~/.config/oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

if [ -d ~/.config/oh-my-zsh/custom/plugins/zsh-completions ]; then
    cd ~/.config/oh-my-zsh/custom/plugins/zsh-completions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-completions ~/.config/oh-my-zsh/custom/plugins/zsh-completions
fi

if [ -d ~/.config/oh-my-zsh/custom/plugins/zsh-history-substring-search ]; then
    cd ~/.config/oh-my-zsh/custom/plugins/zsh-history-substring-search && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search ~/.config/oh-my-zsh/custom/plugins/zsh-history-substring-search
fi


# INSTALL FONTS

echo -e "Installing Nerd Fonts version of Hack, Roboto Mono, DejaVu Sans Mono\n"

wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/complete/Roboto%20Mono%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf -P ~/.fonts/

fc-cache -fv ~/.fonts

if [ -d ~/.config/oh-my-zsh/custom/themes/powerlevel10k ]; then
    cd ~/.config/oh-my-zsh/custom/themes/powerlevel10k && git pull
else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/oh-my-zsh/custom/themes/powerlevel10k
fi

if [ -d ~/.~/.config/quickzsh/fzf ]; then
    cd ~/.config/quickzsh/fzf && git pull
    ~/.config/quickzsh/fzf/install --all --key-bindings --completion --no-update-rc --64
else
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.config/quickzsh/fzf
    ~/.config/quickzsh/fzf/install --all --key-bindings --completion --no-update-rc --64
fi

if [ -d ~/.config/oh-my-zsh/custom/plugins/k ]; then
    cd ~/.config/oh-my-zsh/custom/plugins/k && git pull
else
    git clone --depth 1 https://github.com/supercrabtree/k ~/.config/oh-my-zsh/custom/plugins/k
fi

if [ -d ~/.config/quickzsh/marker ]; then
    cd ~/.config/quickzsh/marker && git pull
else
    git clone --depth 1 https://github.com/pindexis/marker ~/.config/quickzsh/marker
fi

if ~/.config/quickzsh/marker/install.py; then
    echo -e "Installed Marker\n"
else
    echo -e "Marker Installation Had Issues\n"
fi

# if git clone --depth 1 https://github.com/todotxt/todo.txt-cli.git ~/.config/quickzsh/todo; then :
# else
#     cd ~/.config/quickzsh/todo && git fetch --all && git reset --hard origin/master
# fi
# mkdir ~/.config/quickzsh/todo/bin ; cp -f ~/.config/quickzsh/todo/todo.sh ~/.config/quickzsh/todo/bin/todo.sh # cp todo.sh to ./bin so only it is included in $PATH
# #touch ~/.todo/config     # needs it, otherwise spits error , yeah a bug in todo
# ln -s ~/.config/quickzsh/todo ~/.todo
if [ ! -L ~/.config/quickzsh/todo/bin/todo.sh ]; then
    echo -e "Installing todo.sh in ~/.config/quickzsh/todo\n"
    mkdir -p ~/.config/quickzsh/todo/bin
    wget -q --show-progress "https://github.com/todotxt/todo.txt-cli/releases/download/v2.11.0/todo.txt_cli-2.11.0.tar.gz" -P ~/.config/quickzsh/
    tar xvf ~/.config/quickzsh/todo.txt_cli-2.11.0.tar.gz -C ~/.config/quickzsh/todo --strip 1 && rm ~/.config/quickzsh/todo.txt_cli-2.11.0.tar.gz
    ln -s ~/.config/quickzsh/todo/todo.sh ~/.config/quickzsh/todo/bin/todo.sh     # so only .../bin is included in $PATH
    ln -s ~/.config/quickzsh/todo/todo.cfg ~/.todo.cfg     # it expects it there or ~/todo.cfg or ~/.todo/config
else
    echo -e "todo.sh is already instlled in ~/.config/quickzsh/todo/bin/\n"
fi

if [[ $1 == "--cp-hist" ]] || [[ $1 == "-c" ]]; then
    echo -e "\nCopying bash_history to zsh_history\n"
    if command -v python &>/dev/null; then
        wget -q --show-progress https://gist.githubusercontent.com/muendelezaji/c14722ab66b505a49861b8a74e52b274/raw/49f0fb7f661bdf794742257f58950d209dd6cb62/bash-to-zsh-hist.py
        cat ~/.bash_history | python bash-to-zsh-hist.py >> ~/.zsh_history
    else
        if command -v python3 &>/dev/null; then
            wget -q --show-progress https://gist.githubusercontent.com/muendelezaji/c14722ab66b505a49861b8a74e52b274/raw/49f0fb7f661bdf794742257f58950d209dd6cb62/bash-to-zsh-hist.py
            cat ~/.bash_history | python3 bash-to-zsh-hist.py >> ~/.zsh_history
        else
            echo "Python is not installed, can't copy bash_history to zsh_history\n"
        fi
    fi
else
    echo -e "\nNot copying bash_history to zsh_history, as --cp-hist or -c is not supplied\n"
fi


# source ~/.zshrc
echo -e "\nSudo access is needed to change default shell\n"

if chsh -s $(which zsh) && /bin/zsh -i -c upgrade_oh_my_zsh; then
    echo -e "Installation Successful, exit terminal and enter a new session"
else
    echo -e "Something is wrong"
fi
exit
