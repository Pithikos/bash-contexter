import os
import sys
import subprocess
import shlex
import pickle

# Initialize structs
commands = []
if os.path.isfile('commands.pik'):
    commands = pickle.load(open('commands.pik', 'r'))
prechecks = {}
if os.path.isfile('prechecks.pik'):
    prechecks = pickle.load(open('prechecks.pik', 'r'))


def run_shell_command(cmd):
    """ Run a command inside shell environment """
    proc = subprocess.Popen(shlex.split(cmd), shell=True)
    proc.wait()
    return proc


def run_under_chain(cmd):
    """ Will try to run command under the current chain """
    for cmd in reversed(commands):
        if cmd in prechecks:
            for precheck in prechecks[cmd]:
                # If precheck fails then we go to next command in chain
                if run_shell_command(precheck).returncode != 0:
                    break
                return run_shell_command(precheck)
        else:
            return run_shell_command(cmd)


if __name__ == '__main__':
    action = sys.argv[1]

    if action == '--register':
        command = sys.argv[2]
        if command not in commands:
            commands.append(command)
        pickle.dump(commands, open('commands.pik', 'w'))

    elif action == '--register-precheck':
        # Will assume that precheck_<command> exists
        command = sys.argv[2]
        precheck_command = sys.argv[3]
        try:
            prechecks[precheck_command] += precheck_command
        except KeyError:
            prechecks[precheck_command] = [precheck_command]
        pickle.dump(prechecks, open('prechecks.pik', 'w'))

    elif action == '--run':
        run_under_chain(sys.argv[2])

    else:
        print('Usage: %s <action> <args>' % __file__)
        exit(1)
