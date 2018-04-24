#!/bin/bash

if command -v zsh &> /dev/null && command -v git &> /dev/null ; then
	echo -e "ZSH and Git are already installed\n"
else
	if sudo apt install -y zsh git || sudo dnf install -y zsh git || sudo yum install -y zsh git || sudo brew install git zsh ; then
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


if git clone --depth=1 https://github.com/powerline/fonts.git --depth=1 ~/powerline_fonts; then :
else
	cd ~/powerline_fonts && git pull
fi

if ~/powerline_fonts/install.sh && rm -rf ~/powerline_fonts; then
	echo -e "\npowerline_fonts Installed\n"
else
	echo -e "\npowerline_fonts Installation Failed\n"
fi

if git clone --depth=1 https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k; then :
else
	cd ~/.oh-my-zsh/custom/themes/powerlevel9k && git pull
fi

if git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; then :
else
	cd ~/.fzf && git pull
fi
~/.fzf/install --all --key-bindings --completion --no-update-rc --64

if git clone https://github.com/supercrabtree/k $HOME/.oh-my-zsh/custom/plugins/k; then :
else
	cd ~/.oh-my-zsh/custom/plugins/k && git pull
fi

if git clone https://github.com/pindexis/marker ~/marker; then :
else
	cd ~/marker && git pull
fi

if ~/marker/install.py; then
	echo -e "Installed Marker"
else
	echo -e "Marker Installation Had Issues"
fi
# source ~/.zshrc
echo -e "\nSudo access is needed to change default shell\n"

if chsh -s $(which zsh) && /bin/zsh -i -c upgrade_oh_my_zsh; then
	echo -e "Installation Successful, exit terminal and enter a new session"
else
	echo -e "Something is wrong"
fi
exit
