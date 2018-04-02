#
# Needed by multiple other modules
#


# Usage
# 1. Use register_command_not_found to register a function to fallback to

BASH_CONTEXTER_PATH=~/.bash_contexter
BASH_CONTEXTER_PY="$BASH_CONTEXTER_PATH/bash_contexter.py"


_is_shell_bash () {
	if [ "$0" == "bash" ] || [ "$(basename $SHELL)" == "bash" ]; then
		true
	else
		false
	fi
}


# ---------------------------------- Setup -------------------------------------


# TODO: Check version +4.4
if ! _is_shell_bash; then
  echo "This script is only supported for Bash v4.4+"
fi


# Store existing command_not_found_handle if it has contents or else use the default
_default_command_not_found_handle () {
  bash -c "$@"
  return $?
}
if type command_not_found_handle &> /dev/null; then
  eval "_before_bash_contexter_$(declare -f command_not_found_handle)"
	python -B "$BASH_CONTEXTER_PY" --register "_before_bash_contexter_command_not_found_handle"
else
	python -B "$BASH_CONTEXTER_PY" --register "_default_command_not_found_handle"
fi


# ------------------------------------ API -------------------------------------


bash_contexter_register () {
	# Register and export to python wrapper
  python "$BASH_CONTEXTER_PY" --register "$1"
	export -f "$1"

	# Check if precheck exists.
	if type "precheck_$1" &> /dev/null; then
		python -B "$BASH_CONTEXTER_PY" --register-precheck "$1" "precheck_$1"
		export -f "precheck_$1"
	else
		echo "No precheck found for $1, continuing without."
	fi
}

echo "Instantiate command_not_found_handle"
command_not_found_handle () {
	echo "Running through python contexter"
	export -f "echo_command"
	python -c "from subprocess import check_output; print(check_output('echo_command tsfsd', shell=True))"
	# python -B "$BASH_CONTEXTER_PY" --run "$@"
}


source "$BASH_CONTEXTER_PATH/helpers.sh"
