function try_run_pipenv_command {
	echo Running: pipenv run "$@"
	pipenv run "$@"
}


function precheck_try_run_pipenv_command {
	if _upfind_file 'Pipfile.lock' &> /dev/null; then
		return 0
	else
		return 1
	fi
}


bash_contexter_register 'try_run_pipenv_command'