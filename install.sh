#!/bin/bash

# Flags to determine if the arguments were passed
cp_hist_flag=false
noninteractive_flag=false

# Loop through all arguments
for arg in "$@"
do
    case $arg in
        --cp-hist|-c)
            cp_hist_flag=true
            ;;
        --non-interactive|-n)
            noninteractive_flag=true
            ;;
        *)
            # Handle any other arguments or provide an error message
            ;;
    esac
done

if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v wget &> /dev/null; then
    echo -e "ZSH and Git are already installed\n"
else
    if sudo apt install -y zsh git wget autoconf || sudo pacman -S zsh git wget || sudo dnf install -y zsh git wget || sudo yum install -y zsh git wget || sudo brew install git zsh wget || pkg install git zsh wget ; then
        echo -e "zsh wget and git Installed\n"
    else
        echo -e "Please install the following packages first, then try again: zsh git wget \n" && exit
    fi
fi

if mv -n ~/.zshrc ~/.zshrc-backup-$(date +"%Y-%m-%d"); then # backup .zshrc
    echo -e "Backed up the current .zshrc to .zshrc-backup-date\n"
fi

echo -e "The setup will be installed in '~/.config/ezsh'\n"
echo -e "Place your personal zshrc config files under '~/.config/ezsh/zshrc/'\n"
mkdir -p ~/.config/ezsh/zshrc

if [ -d ~/.quickzsh ]; then
    echo -e "\n PREVIOUS SETUP FOUND AT '~/.quickzsh'. PLEASE MANUALLY MOVE ANY FILES YOU'D LIKE TO '~/.config/ezsh' \n"
fi

echo -e "Installing oh-my-zsh\n"
if [ -d ~/.config/ezsh/oh-my-zsh ]; then
    echo -e "oh-my-zsh is already installed\n"
    git -C ~/.config/ezsh/oh-my-zsh remote set-url origin https://github.com/ohmyzsh/ohmyzsh.git
elif [ -d ~/.oh-my-zsh ]; then
    echo -e "oh-my-zsh in already installed at '~/.oh-my-zsh'. Moving it to '~/.config/ezsh/oh-my-zsh'"
    export ZSH="$HOME/.config/ezsh/oh-my-zsh"
    mv ~/.oh-my-zsh ~/.config/ezsh/oh-my-zsh
    git -C ~/.config/ezsh/oh-my-zsh remote set-url origin https://github.com/ohmyzsh/ohmyzsh.git
else
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.config/ezsh/oh-my-zsh
fi

cp -f .zshrc ~/
cp -f ezshrc.zsh ~/.config/ezsh/

mkdir -p ~/.config/ezsh/zshrc         # PLACE YOUR ZSHRC CONFIGURATIONS OVER THERE
mkdir -p ~/.cache/zsh/                # this will be used to store .zcompdump zsh completion cache files which normally clutter $HOME
mkdir -p ~/.fonts                     # Create .fonts if doesn't exist

if [ -f ~/.zcompdump ]; then
    mv ~/.zcompdump* ~/.cache/zsh/
fi

if [ -d ~/.config/ezsh/oh-my-zsh/plugins/zsh-autosuggestions ]; then
    cd ~/.config/ezsh/oh-my-zsh/plugins/zsh-autosuggestions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.config/ezsh/oh-my-zsh/plugins/zsh-autosuggestions
fi

if [ -d ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    cd ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

if [ -d ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-completions ]; then
    cd ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-completions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-completions ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-completions
fi

if [ -d ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-history-substring-search ]; then
    cd ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-history-substring-search && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-history-substring-search
fi


# INSTALL FONTS

echo -e "Installing Nerd Fonts version of Hack, Roboto Mono, DejaVu Sans Mono\n"

wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf -P ~/.fonts/
wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/RobotoMonoNerdFont-Regular.ttf -P ~/.fonts/
wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/DejaVuSansMNerdFont-Regular.ttf -P ~/.fonts/

fc-cache -fv ~/.fonts

if [ -d ~/.config/ezsh/oh-my-zsh/custom/themes/powerlevel10k ]; then
    cd ~/.config/ezsh/oh-my-zsh/custom/themes/powerlevel10k && git pull
else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/ezsh/oh-my-zsh/custom/themes/powerlevel10k
fi

if [ -d ~/.~/.config/ezsh/fzf ]; then
    cd ~/.config/ezsh/fzf && git pull
    ~/.config/ezsh/fzf/install --all --key-bindings --completion --no-update-rc
else
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.config/ezsh/fzf
    ~/.config/ezsh/fzf/install --all --key-bindings --completion --no-update-rc
fi

if [ -d ~/.config/ezsh/oh-my-zsh/custom/plugins/k ]; then
    cd ~/.config/ezsh/oh-my-zsh/custom/plugins/k && git pull
else
    git clone --depth 1 https://github.com/supercrabtree/k ~/.config/ezsh/oh-my-zsh/custom/plugins/k
fi

if [ -d ~/.config/ezsh/oh-my-zsh/custom/plugins/fzf-tab ]; then
    cd ~/.config/ezsh/oh-my-zsh/custom/plugins/fzf-tab && git pull
else
    git clone --depth 1 https://github.com/Aloxaf/fzf-tab ~/.config/ezsh/oh-my-zsh/custom/plugins/fzf-tab
fi

if [ -d ~/.config/ezsh/marker ]; then
    cd ~/.config/ezsh/marker && git pull
else
    git clone --depth 1 https://github.com/jotyGill/marker ~/.config/ezsh/marker
fi

if ~/.config/ezsh/marker/install.py; then
    echo -e "Installed Marker\n"
else
    echo -e "Marker Installation Had Issues\n"
fi

# if git clone --depth 1 https://github.com/todotxt/todo.txt-cli.git ~/.config/ezsh/todo; then :
# else
#     cd ~/.config/ezsh/todo && git fetch --all && git reset --hard origin/master
# fi
# mkdir ~/.config/ezsh/todo/bin ; cp -f ~/.config/ezsh/todo/todo.sh ~/.config/ezsh/todo/bin/todo.sh # cp todo.sh to ./bin so only it is included in $PATH
# #touch ~/.todo/config     # needs it, otherwise spits error , yeah a bug in todo
# ln -s ~/.config/ezsh/todo ~/.todo
if [ ! -L ~/.config/ezsh/todo/bin/todo.sh ]; then
    echo -e "Installing todo.sh in ~/.config/ezsh/todo\n"
    mkdir -p ~/.config/ezsh/bin
    mkdir -p ~/.config/ezsh/todo
    wget -q --show-progress "https://github.com/todotxt/todo.txt-cli/releases/download/v2.12.0/todo.txt_cli-2.12.0.tar.gz" -P ~/.config/ezsh/
    tar xvf ~/.config/ezsh/todo.txt_cli-2.12.0.tar.gz -C ~/.config/ezsh/todo --strip 1 && rm ~/.config/ezsh/todo.txt_cli-2.12.0.tar.gz
    ln -s -f ~/.config/ezsh/todo/todo.sh ~/.config/ezsh/bin/todo.sh     # so only .../bin is included in $PATH
    ln -s -f ~/.config/ezsh/todo/todo.cfg ~/.todo.cfg     # it expects it there or ~/todo.cfg or ~/.todo/config
else
    echo -e "todo.sh is already instlled in ~/.config/ezsh/todo/bin/\n"
fi
if [ "$cp_hist_flag" = true ]; then
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

if [ "$noninteractive_flag" = true ]; then
    echo -e "Installation complete, exit terminal and enter a new zsh session\n"
    echo -e "Make sure to change zsh to default shell by running: chsh -s $(which zsh)"
    echo -e "In a new zsh session manually run: build-fzf-tab-module"
else
    # source ~/.zshrc
    echo -e "\nSudo access is needed to change default shell\n"

    if chsh -s $(which zsh) && /bin/zsh -i -c 'omz update'; then
        echo -e "Installation complete, exit terminal and enter a new zsh session"
        echo -e "In a new zsh session manually run: build-fzf-tab-module"
    else
        echo -e "Something is wrong"

    fi
fi
exit
