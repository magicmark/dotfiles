#!/usr/bin/env python3

# Copyright (C) 2015 Vibhav Pant <vibhavp@gmail.com>
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

import json
import os
import shutil
from sys import stderr
import argparse


def ask_user(prompt):
    valid = {"yes":True, 'y':True, '':True, "no":False, 'n':False}
    while True:
        print(prompt, end=" ")
        choice = input().lower()
        if choice in valid:
            return valid[choice]
        else:
            print("Enter a correct choice.", file=stderr)


def create_symlink(src, dest, replace):
    if not os.path.exists(src):
        raise Exception(src + ' does not exist!')

    if os.path.exists(dest):
        if os.path.islink(dest) and os.readlink(dest) == src:
            print("Skipping existing {0} -> {1}".format(dest, src))
            return
        elif replace or ask_user(dest+" exists, delete it? [Y/n]"):
            if os.path.isfile(dest):
                os.remove(dest)
            else:
                shutil.rmtree(dest)
        else:
            return

    print("Linking {0} -> {1}".format(dest, src))
    os.symlink(src, dest)


def run_command(command):
    os.system(command)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("config", help="the JSON file you want to use")
    parser.add_argument("-r", "--replace", action="store_true",
                        help="replace files/folders if they already exist")

    args = parser.parse_args()
    js = json.load(open(args.config))
    
    dotfiles_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

    symlinks = js.get("symlink")
    commands = js.get("commands")

    for file in symlinks:
        file_path = os.path.join(dotfiles_path, file)
        symlink_path = os.path.join(os.path.expanduser('~'), file)

        create_symlink(file_path, symlink_path, args.replace)

    if commands: [run_command(command) for command in commands]

    print("Done!")

if __name__ == "__main__":
    main()
