function try_run_django_command {
	manage_file_path=`_upfind_file 'manage.py'`
	if [[ "$manage_file_path" ]]; then
		echo "Detected django project."
		python "$manage_file_path" "$@"
	else
		echo "Not a django project."
	fi
}


function precheck_try_run_django_command {
	_upfind_file 'manage.py' &> /dev/null
	return $?
}


bash_contexter_register 'try_run_django_command'
