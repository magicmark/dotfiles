#!/usr/bin/env python3
import pexpect
import subprocess
from contextlib import contextmanager

@contextmanager
def seperator():
    print('==========================')
    yield
    print('==========================\n')


def run_command(command):
    process = subprocess.check_output(
        command,
        stdin=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )

    return process.decode('UTF-8').strip().splitlines()[0]


def test_thing(name, test):
    with seperator():
        print('[+] Testing {}:'.format(name))
        print('$ {}'.format(' '.join(test)))
        result = run_command(test)
        print('✓ {}'.format(result))


def message(message):
    with seperator():
        print('[+] {}'.format(message))


def main():
    test_thing('Git',
        ('git', '--version')
    )

    test_thing('neovim',
        ('nvim', '--version')
    )

    test_thing('zsh',
        ('zsh', '--version')
    )

    message('Running bootstrap script...')

    child = pexpect.spawnu('make bootstrap')
    child.expect('Password: ')
    child.sendline('2X4B')

    test_thing('oh my zsh',
        ('ls', '~/.oh-my-zsh')
    )

if __name__ == '__main__':
    main()
