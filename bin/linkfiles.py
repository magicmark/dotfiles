#!/usr/bin/python3
import os
import sys

HOME = os.path.expanduser("~")
DOTFILES_DIR = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))


def link_file(file_path, symlink_path):
    readable_path = symlink_path.replace(HOME, '~')
    target_dir = os.path.dirname(symlink_path)

    if not os.path.exists(target_dir):
        if target_dir == HOME:
            raise Exception('target_dir cannot be $HOME')
        else:
            os.makedirs(target_dir)

    if os.path.exists(symlink_path) or os.path.lexists(symlink_path):
        answer = input(' '.join((
            '\n{file} already exists!',
            'Delete it and symlink? [y/N] ',
        )).format(file=readable_path))

        if answer != 'y' and answer != 'Y':
            print(' '.join((
                'Skipping {file}',
                '(you might want to move it and rerun this script!)',
            )).format(file=readable_path))
            return

        os.remove(symlink_path)

    print('\nLinking {}'.format(readable_path))
    os.symlink(file_path, symlink_path)


def main():
    dirs = [os.path.join(DOTFILES_DIR, 'dotfiles/home')]
    if len(sys.argv) >= 2 and sys.argv[1] == 'arch':
        dirs.append(os.path.join(DOTFILES_DIR, 'dotfiles/home.arch'))

    for dir in dirs:
        for (dirpath, dirnames, filenames) in os.walk(dir):
            for filename in filenames:
                file_path = os.path.join(dirpath, filename)
                symlink_path = file_path.replace(dir, HOME);
                link_file(file_path, symlink_path)

    print('\nDone!')

if __name__ == '__main__':
    main()
