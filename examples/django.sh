function try_run_django_command {
	python "$(_upfind_file 'manage.py')" "$@"
}


function precheck_try_run_django_command {
	if _upfind_file 'manage.py' &> /dev/null; then
		echo "Detected django project."
		return 0
	else
		return 1
	fi
}


bash_contexter_register 'try_run_django_command'
