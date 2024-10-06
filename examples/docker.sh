if type docker &> /dev/null; then

	# Check if a docker container is running
	function _docker_container_is_running {
		running=$(docker inspect --format="{{.State.Running}}" $1 2>/dev/null)
		if [[ $running != "true" ]]; then
			false
		else
			true
		fi
	}


	function docker_autoenter {
		if [ $2 ]; then
			docker exec -it "$@"
		else
			docker exec -it $1 bash
		fi
	}


	function precheck_docker_autoenter {
		if _docker_container_is_running $1; then
			return 0
		fi
		return 1
	}


	bash_contexter_register 'docker_autoenter'

fi