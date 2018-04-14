#!/bin/bash

if command -v zsh &> /dev/null && command -v git &> /dev/null ; then
	echo -e "ZSH and Git are already installed\n"
else
	if sudo apt install -y zsh git || sudo dnf install -y zsh git || sudo yum install -y zsh git || brew install git zsh ; then
		echo -e "ZSH and Git Installed\n"
	else
		echo -e "Can't install ZSH or Git\n" && exit
	fi
fi


#if [ -d ~/.oh-my-zsh ]; then
#    printf "You already have Oh My Zsh installed.\n"
#    printf "Moving that to .oh-my-zsh-backup\n"
#    mv ~/.oh-my-zsh ~/.oh-my-zsh-backup
#fi

if mv ~/.zshrc ~/.zshrc-backup; then	# if already have zshrc-backup, keep it, don't overwrite
	echo -e "\nBacked up the current .zshrc to .zshrc-backup\n"
fi

echo -e "\nInstalling oh-my-zsh\n"
if git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh; then
	echo -e "Installed OH-MY-ZSH\n"
fi

cp -f .zshrc ~/


#if sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"; then
#	echo "Installed OH-MY-ZSH\n"
#else
#	echo "Installation of OH-MY-ZSH Failed"
#	exit
#fi


if git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions; then :
else
	cd ~/.oh-my-zsh/plugins/zsh-autosuggestions && git pull
fi


if git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting; then :
else
	cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
fi

if git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions; then :
else
	cd ~/.oh-my-zsh/custom/plugins/zsh-completions && git pull
fi

if git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search; then :
else
	cd ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search && git pull
fi


if git clone https://github.com/powerline/fonts.git --depth=1 ~/powerline_fonts; then :
else
	cd ~/powerline_fonts && git pull
fi

if ~/powerline_fonts/install.sh && rm -rf ~/powerline_fonts; then
	echo -e "powerline_fonts Installed\n"
else
	echo -e "powerline_fonts Installation Failed\n"
fi

if git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k; then :
else
	cd ~/.oh-my-zsh/custom/themes/powerlevel9k && git pull
fi

#rsync -ra .zshrc ~/ && rsync -ra .oh-my-zsh ~/ && rsync -ra .fz* ~/

# source ~/.zshrc

if chsh -s $(which zsh) && /bin/zsh -i -c upgrade_oh_my_zsh; then
	echo -e "\nInstallation Successful, exit terminal and enter a new session"
else
	echo -e "\nSomething is wrong"
fi
exit
