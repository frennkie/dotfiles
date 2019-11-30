#!/usr/bin/env bash
############################
# makesymlinks.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                  # dotfiles directory
olddir=~/dotfiles_old           # old dotfiles backup directory
files="zshrc vimrc tmux.conf tmux.conf.local gitconfig"   # list of files to symlink in homedir
folders="vim zsh"               # list of folders to symlink in homedir
fabric_dir="fabric"
##########

# create dotfiles_old in homedir
if [[ -d $olddir ]];
then
    echo "Removing old backup directory $olddir ..."
    rm -rf $olddir
    echo "done"
fi

echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    if [[ -f ~/.$file ]];
    then
        echo "File ~/.$file exists. Moving to $olddir."
        mv ~/."$file" "$olddir"
    else
        echo "File ~/.$file did not yet exist. No need to create backup."
    fi
    echo "Creating symlink to $file in home directory."
    ln -s "$dir"/"$file" ~/."$file"
done

for folder in $folders; do
    if [[ -L ~/.$folder ]];
    then
        echo "Symlink named ~/.$folder exists. Removing."
        rm -f ~/."$folder"
    fi

    if [[ -d ~/.$folder ]];
    then
        echo "Folder ~/.$folder exists. Moving to $olddir."
        mv ~/."$folder" "$olddir"
    fi

    echo "Creating symlink to folder $folder in home directory."
    ln -s "$dir"/"$folder" ~/."$folder"
done

if [[ -L ~/$fabric_dir ]];
then
    echo "Fabric symlink $fabric_dir exists."
else
    ln -s "$dir"/"$fabric_dir" ~/"$fabric_dir"
fi
# make sure ~/.ssh exists
if [[ -d ~/.ssh ]];
then
    echo "~/.ssh exists."
else
    mkdir ~/.ssh
fi

#echo -e "\e[33mPlease run the following to enable zsh as default shell: \e[32mchsh -s `which zsh`\e[0m"

echo -e "\e[33mIf you use Putty remember to set Terminal -> Keyboard -> Function Keys: \e[31mXterm R6\e[0m"
echo -e "\e[33mPlease add a tmux alias to your bash, e.g. by running:\n\e[32mecho \"alias tmux='TERM=xterm-256color tmux'\" >> ~/.bashrc\e[0m"
