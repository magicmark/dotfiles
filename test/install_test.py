#!/usr/bin/env python3
import os
import sys
import pexpect
import subprocess
from contextlib import contextmanager

# TODO: Make this not sad

@contextmanager
def seperator():
    print('==========================')
    yield
    print('==========================\n')


def run_bash_command(command):
    process = subprocess.check_output(
        command,
        stdin=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )

    return process.decode('UTF-8').strip()


def run_zsh_command(command):
    process = subprocess.check_output(
        ('/usr/bin/zsh', '-c', '. ~/.zshrc && {}'.format(command)),
        stdin=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )

    return process.decode('UTF-8').strip()


def test_thing(name, test):
    with seperator():
        print('[+] Testing {}:'.format(name))
        print('$ {}'.format(test))
        result = run_zsh_command(test).splitlines()[0]
        print('✓ {}'.format(result))


def check_dep(name, test):
    with seperator():
        print('[+] Testing {}:'.format(name))
        print('$ {}'.format(' '.join(test)))
        result = run_bash_command(test).splitlines()[0]
        print('✓ {}'.format(result))


def message(message):
    with seperator():
        print('[+] {}'.format(message))


def make(target):
    process = subprocess.Popen(
        (('make', target)),
        env=dict(os.environ, IN_DOCKER_TEST='absofruitly'),
        stdin=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )

    bootstrap_output = process.communicate()[0]

    if process.returncode != 0:
        print('make {} did not return 0'.format(target))
        sys.exit(1)


def main():
    check_dep('Git',
        ('git', '--version')
    )

    check_dep('neovim',
        ('nvim', '--version')
    )

    check_dep('zsh',
        ('zsh', '--version')
    )

    message('Running bootstrap script...')
    make('bootstrap')

    message('Running linkfiles script...')
    make('linkfiles-force')

    test_thing('oh my zsh',
        'ls {}'.format(os.path.expanduser('~/.oh-my-zsh'))
    )

    test_thing('node version manager',
        'nvm --version',
    )

    test_thing('tmux',
        'tmux -V',
    )

    test_thing('virtualenv',
        'virtualenv --version',
    )

if __name__ == '__main__':
    main()
