Bash Contexter
==============

The script will let's you cut down commands depending on the context. For example
if you're inside a Django project you can type `makemigrations` instead of `python manage.py makemigrations`.

This is accomplished by taking advantage of `command_not_found_handle` in Bash 4.4 to
fallback to different commands depending on the context a command is given in
the shell.

Example (Django)

    $> makemigrations
    $> migrate


Installation
------------

Simply run

    wget -O - https://raw.githubusercontent.com/Pithikos/bash-contexter/master/install | bash


The installion script will clone everything under ~/.bash_contexter and a `source` entry will be appended
to your ~/.bash_profile or ~/.profile if only that exists.


Usage
-----

The fastest way is to `source` some of the examples that suit you.

You can ofcourse always add your own custom context like below:

    function activate_virtualenv {
      echo 'Activating virtualenv..'
      source venv/bin/activate
    }

    function precheck_activate_virtualenv {
      return ls venv/bin/activate &> /dev/null
    }

    bash_contexter_register 'activate_virtualenv'

The `precheck_` function is a prerequisite for the main registered function. For this
reason the precheck functions should return 0 if the main function should be executed.


Uninstall
---------

    rm -r ~/.bash_contexter

You also need to manually remove the source line in your ~/.bashrc


Helpers
-------

You can use these helper scripts in your prechecks

`_upfind_dir` - find a specific directory from current path up to the root
`_upfind_file` - find a specific file from current path up to the root
