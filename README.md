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


The installion script will clone everything under `~/.bash_contexter` and a `source` entry will be appended
to your `~/.bashrc`.


Usage
-----

After installation you don't have any contexters available. The fastest way is
to use one of the existing examples.

To source the Django contexter for example you add this to your `.bashrc`:

    source ~/.bash_contexter/examples/django.sh

Then whenever you are in a Django project you can skip the `python manage.py` of
the command you want to run.


Custom contexters
-----------------

You can create your own contexters like below:

    function custom_command_not_found {
      echo "Could not find command '$@'"
    }

    function precheck_custom_command_not_found {
      return 0
    }

    bash_contexter_register 'custom_command_not_found'

The `precheck_` function is a prerequisite for every contexter and should return 0
if the contexter is to run or 1 for it not to run.


Uninstall
---------

    rm -fr ~/.bash_contexter

You also need to manually remove the source line in your ~/.bashrc


Helpers
-------

You can use these helper scripts in your prechecks

`_upfind_dir` - find a specific directory from current path up to the root
`_upfind_file` - find a specific file from current path up to the root
