Bash Contexter
==============

The Bash Contexter will let you do things depending on where you run them. It takes
advantage of `command_not_found_handle` in Bash 4.4. With it you can do things like
below.

Example (Docker)

    $> docker run -it ubuntu bash
    root@7a14657624bf:/#
    $> 7a1
    root@7a14657624bf:/#

Example (Django)

    $> ls
    db.sqlite3  manage.py  myproj
    $> makemigrations
    Detected django project.
    No changes detected


Installation
------------

Simply run

    wget -O - https://raw.githubusercontent.com/Pithikos/bash-contexter/master/install | bash


The installion script will clone everything under `~/.bash_contexter` and a `source` entry will be appended
to your `~/.bashrc`.

You will need to manually `source` any of the examples you want. For example your
 `~/.bashrc` can look like this if you use Docker and Django


    source ~/.bash_contexter/bash_contexter.sh
    source ~/.bash_contexter/examples/django.sh
    source ~/.bash_contexter/examples/docker.sh



Usage
-----

The fastest way is to `source` directly one of the existing examples.

You can however create custom contexters that suit your needs. See example below


    function custom_command_not_found {
      echo "Could not find command '$@'"
    }

    function precheck_custom_command_not_found {
      return 0
    }

    bash_contexter_register 'custom_command_not_found'

The `precheck_` function is a prerequisite for every contexter. Its only job is
to determine if the context function should run or not - and for that it has to return
0 or 1.


Uninstall
---------

    rm -fr ~/.bash_contexter

You also need to manually remove the source line in your ~/.bashrc


Helpers
-------

You can use these helper scripts in your prechecks

`_upfind_dir` - find a specific directory from current path up to the root
`_upfind_file` - find a specific file from current path up to the root
