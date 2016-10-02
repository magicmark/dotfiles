#!/bin/bash

# Let's make sure we execute from the correct directory
# http://stackoverflow.com/a/246128
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DOTFILES_DIR/dotfiles

# Make all the folders we need to link into
folders=$(find . -type d)
for folder in $folders; do
    mkdir -p $HOME/$folder
done

files=$(find . -type f && find . -type l)
for file in $files; do
    fullpath="$HOME/$file"
    linkfile=true

    if [ -f $fullpath ] || [ -h $fullpath ]; then
        readinput=true

        while $readinput; do
            read -p "$file already exists! Delete it and symlink? [y/N] " result
            if [ "$result" == 'y' ] || [ "$result" == 'yes' ]; then
                readinput=false
            else
                linkfile=false
                readinput=false
            fi
        done
    fi

    if $linkfile; then
        echo -e "Symlinking $fullpath -> $file\n"
        # ln -bfrs "$file" "$fullpath"
        ln -frs "$file" "$fullpath"
    else
        echo -e "Skipping $file (you might want to move it and rerun this script!)\n"
    fi
done

echo "Done!"

cd $OLDPWD
