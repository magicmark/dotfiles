#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Creates the PS1 string for zsh.
"""
import os
import pwd
import subprocess
import sys
from collections import namedtuple
from functools import lru_cache
from getpass import getuser
from socket import gethostname

from colors import color as ansicolor


Part = namedtuple('Part', ('colored_output', 'raw_length'))

class Color:
    WHITE = 0
    RED = 9
    GREY = 6
    YELLOW = 82
    BLUE = 4
    GREEN = 3
    CYAN = 36
    PURPLE = 139
    UHOH = 202


def run_command(command):
    process = subprocess.check_output(
        command,
        stdin=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )

    return process.decode('UTF-8').strip()


def colorize(color, text, bold=True):
    params = {}
    if bold:
        params['style'] = 'bold'

    return ansicolor(text, fg=color, **params)


def get_git_part():
    try:
        git_dir = run_command(('git', 'rev-parse', '--git-dir'))
    except subprocess.CalledProcessError:
        return None

    if not os.path.isdir(git_dir):
        return None

    branch_name = run_command(('git', 'symbolic-ref', '--short', '-q', 'HEAD'))

    branch_info = ''

    if os.path.isdir(os.path.join(git_dir, '..', '.dotest')):
        branch_info = '|AM/REBASE'
    elif os.path.isfile(os.path.join(git_dir, '.dotest-merge', 'interactive')):
        branch_info = '|REBASE-i'
    elif os.path.isdir(os.path.join(git_dir, '.dotest-merge')):
        branch_info = '|REBASE-m'
    elif os.path.isfile(os.path.join(git_dir, 'MERGE_HEAD')):
        branch_info = '|MERGING'
    elif os.path.isfile(os.path.join(git_dir, 'BISECT_LOG')):
        branch_info = '|BISECTING'

    git_status = run_command(('git', 'status'))
    is_clean = 'nothing to commit, working' in git_status.split('\n')[-1]

    bits = ['git:(', branch_name, ')']
    if not is_clean:
        bits.extend([' ', '✗'])

    colored_output = ''.join((
        colorize(Color.BLUE, bits[0]),
        colorize(Color.RED, bits[1]),
        colorize(Color.BLUE, bits[2]),
    ))

    if len(bits) > 3:
        colored_output += bits[3]
        colored_output += colorize(Color.UHOH, bits[4])

    return Part(
        colored_output=colored_output,
        raw_length=sum([len(bit) for bit in bits]),
    )


def get_venv_part():
    if not os.environ.get('VIRTUAL_ENV'):
        return None

    venv = os.path.basename(os.environ.get('VIRTUAL_ENV'))
    bits = ('virtualenv:(', venv, ')')

    colored_output = ''.join((
        colorize(Color.BLUE, bits[0]),
        colorize(Color.RED, bits[1]),
        colorize(Color.BLUE, bits[2]),
    ))

    return Part(
        colored_output=colored_output,
        raw_length=sum([len(bit) for bit in bits]),
    )


def get_parts():
    parts = {}
    parts['top_brace'] = Part(
        colored_output=colorize(Color.PURPLE, '╔═') + ' ',
        raw_length=3,
    )

    username = getuser()
    parts['user'] = Part(
        colored_output=colorize(Color.BLUE, username),
        raw_length=len(username),
    )

    hostname = gethostname()
    parts['host'] = Part(
        colored_output=colorize(Color.GREEN, hostname),
        raw_length=len(hostname),
    )

    parts['at'] = Part(
        colored_output=colorize(Color.WHITE, '@', False),
        raw_length=1,
    )

    home_dir = os.path.expanduser('~')
    curr_dir = os.getcwd().replace(home_dir, '~')
    parts['dir'] = Part(
        colored_output=colorize(Color.GREY, curr_dir),
        raw_length=len(curr_dir),
    )

    git_part = get_git_part()
    if git_part:
        parts['git'] = git_part

    venv_part = get_venv_part()
    if venv_part:
        parts['venv'] = venv_part

    return parts


def construct_ps1(parts, seperator):
    ps1 = '\n{top_brace}{user}{at}{host}:{seperator}{dir}'.format(
        top_brace=parts.get('top_brace').colored_output,
        seperator=seperator,
        user=parts.get('user').colored_output,
        at=parts.get('at').colored_output,
        host=parts.get('host').colored_output,
        dir=parts.get('dir').colored_output,
    )

    if parts.get('git'):
        ps1 += '{seperator}{git}'.format(
            seperator=seperator,
            git=parts.get('git').colored_output,
        )

    if parts.get('venv'):
        ps1 += '{seperator}{venv}'.format(
            seperator=seperator,
            venv=parts.get('venv').colored_output,
        )

    ps1 += '\n{bottom_brace} {u2253} '.format(
        bottom_brace=colorize(Color.PURPLE, '╚═'),
        u2253=colorize(Color.WHITE, '≓'),
    )

    return ps1


def main():
    parts = get_parts()

    top_line_length = sum([part.raw_length for part in parts.values()]) + 3
    window_width = int(sys.argv[1])

    if top_line_length >= window_width:
        seperator = '\n' + colorize(Color.PURPLE, '╠═') + ' '
    else:
        seperator = ' '

    sys.stdout.write(construct_ps1(parts, seperator))
    sys.stdout.flush()


if __name__ == '__main__':
    main()
