#!/bin/bash

if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v wget &> /dev/null; then
	echo -e "ZSH and Git are already installed\n"
else
	if sudo apt install -y zsh git wget || sudo dnf install -y zsh git wget || sudo yum install -y zsh git wget || sudo brew install git zsh wget ; then
		echo -e "ZSH and Git Installed\n"
	else
		echo -e "Can't install ZSH or Git\n" && exit
	fi
fi


if mv -n ~/.zshrc ~/.zshrc-backup; then	# if already have zshrc-backup, keep it, don't overwrite
	echo -e "Backed up the current .zshrc to .zshrc-backup\n"
fi


echo -e "Installing oh-my-zsh\n"
if git clone --depth=1 git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh; then
	echo -e "Installed OH-MY-ZSH\n"
fi

cp -f .zshrc ~/


mkdir ~/.quickzsh		# external plugins, things, will be instlled in here


if git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions; then :
else
	cd ~/.oh-my-zsh/plugins/zsh-autosuggestions && git pull
fi

if git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting; then :
else
	cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
fi

if git clone --depth=1 https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions; then :
else
	cd ~/.oh-my-zsh/custom/plugins/zsh-completions && git pull
fi

if git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search; then :
else
	cd ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search && git pull
fi

# INSTALL FONTS

if git clone --depth=1 https://github.com/powerline/fonts.git --depth=1 ~/.quickzsh/powerline_fonts; then :
else
	cd ~/.quickzsh/powerline_fonts && git pull
fi

if ~/.quickzsh/powerline_fonts/install.sh && rm -rf ~/.quickzsh/powerline_fonts; then
	echo -e "\npowerline_fonts Installed\n"
else
	echo -e "\npowerline_fonts Installation Failed\n"
fi


wget -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
wget -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/complete/Roboto%20Mono%20Nerd%20Font%20Complete.ttf -P ~/.fonts/

fc-cache -fv ~/.fonts

# if git clone --depth=1 https://github.com/gabrielelana/awesome-terminal-fonts.git --depth=1 ~/.quickzsh/awesome_terminal_fonts; then :
# else
# 	cd ~/.quickzsh/awesome_terminal_fonts && git pull
# fi
#
# if ~/.quickzsh/awesome_terminal_fonts/install.sh; then
# 	echo -e "\nawesome_terminal_fonts Installed\n"
# else
# 	echo -e "\nawesome_terminal_fonts Installation Failed\n"
# fi

if git clone --depth=1 https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k; then :
else
	cd ~/.oh-my-zsh/custom/themes/powerlevel9k && git pull
fi

if git clone --depth 1 https://github.com/junegunn/fzf.git ~/.quickzsh/fzf; then :
else
	cd ~/.quickzsh/fzf && git pull
fi
~/.quickzsh/fzf/install --all --key-bindings --completion --no-update-rc --64

if git clone --depth 1 https://github.com/supercrabtree/k $HOME/.oh-my-zsh/custom/plugins/k; then :
else
	cd ~/.oh-my-zsh/custom/plugins/k && git pull
fi

if git clone --depth 1 https://github.com/pindexis/marker ~/.quickzsh/marker; then :
else
	cd ~/.quickzsh/marker && git pull
fi

if ~/.quickzsh/marker/install.py; then
	echo -e "Installed Marker\n"
else
	echo -e "Marker Installation Had Issues\n"
fi

# if git clone --depth 1 https://github.com/todotxt/todo.txt-cli.git ~/.quickzsh/todo; then :
# else
# 	cd ~/.quickzsh/todo && git fetch --all && git reset --hard origin/master
# fi
# mkdir ~/.quickzsh/todo/bin ; cp -f ~/.quickzsh/todo/todo.sh ~/.quickzsh/todo/bin/todo.sh # cp todo.sh to ./bin so only it is included in $PATH
# #touch ~/.todo/config		# needs it, otherwise spits error , yeah a bug in todo
# ln -s ~/.quickzsh/todo ~/.todo
if [ ! -L ~/.quickzsh/todo/bin/todo.sh ]; then
    echo -e "Installing todo.sh in ~/.quickzsh/todo\n"
		mkdir -p ~/.quickzsh/todo/bin
		wget "https://github.com/todotxt/todo.txt-cli/releases/download/v2.11.0/todo.txt_cli-2.11.0.tar.gz" -P ~/.quickzsh/
		tar xvf ~/.quickzsh/todo.txt_cli-2.11.0.tar.gz -C ~/.quickzsh/todo --strip 1 && rm ~/.quickzsh/todo.txt_cli-2.11.0.tar.gz
		ln -s ~/.quickzsh/todo/todo.sh ~/.quickzsh/todo/bin/todo.sh 	# so only .../bin is included in $PATH
		ln -s ~/.quickzsh/todo/todo.cfg ~/.todo.cfg		# it expects it there or ~/todo.cfg or ~/.todo/config
else
	echo -e "todo.sh is already instlled in ~/.quickzsh/todo/bin/\n"
fi

if [[ $1 == "--cp-hist" ]]; then
    echo -e "\nCopying bash_history to zsh_history\n"
    if command -v python &>/dev/null; then
        wget https://gist.githubusercontent.com/muendelezaji/c14722ab66b505a49861b8a74e52b274/raw/49f0fb7f661bdf794742257f58950d209dd6cb62/bash-to-zsh-hist.py
        cat ~/.bash_history | python bash-to-zsh-hist.py >> ~/.zsh_history
    else
		if command -v python3 &>/dev/null; then
			wget https://gist.githubusercontent.com/muendelezaji/c14722ab66b505a49861b8a74e52b274/raw/49f0fb7f661bdf794742257f58950d209dd6cb62/bash-to-zsh-hist.py
			cat ~/.bash_history | python3 bash-to-zsh-hist.py >> ~/.zsh_history
		else
    		echo "Python is not installed, can't copy bash_history to zsh_history\n"
		fi
    fi
else
    echo -e "\nNot copying bash_history to zsh_history, as --cp-hist is not supplied\n"
fi


# source ~/.zshrc
echo -e "\nSudo access is needed to change default shell\n"

if chsh -s $(which zsh) && /bin/zsh -i -c upgrade_oh_my_zsh; then
	echo -e "Installation Successful, exit terminal and enter a new session"
else
	echo -e "Something is wrong"
fi
exit
