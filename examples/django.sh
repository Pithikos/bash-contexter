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
	return _upfind_file 'manage.py'
}


bash_contexter_register 'try_run_django_command'
