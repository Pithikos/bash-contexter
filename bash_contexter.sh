BASH_CONTEXTER_PATH=~/.bash_contexter

# Warn user of double sourcing
if type _before_bash_contexter_command_not_found_handle &>/dev/null; then
	echo "WARNING: Seems you already sourced this. This can lead to infinite loops.."
fi

declare -A _bash_contexter_prechecks_commands
declare -a _bash_contexter_context_commands


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

# Store any pre-defined command_not_found_handle
if type command_not_found_handle &> /dev/null; then
  eval "_before_bash_contexter_$(declare -f command_not_found_handle)"
fi


# Default handle when no pre-defined command_not_found_handle is used
_default_command_not_found_handle () {
  bash -c "$@"
  return $?
}


command_not_found_handle () {
	for (( i=${#_bash_contexter_context_commands[@]}-1 ; i>=0 ; i-- )) ; do
		cmd="${_bash_contexter_context_commands[i]}"

		# Go through prechecks and execute context functions
		if ${_bash_contexter_prechecks_commands[$cmd]} "$@"; then
			$cmd "$@"
			return $?
		fi
	done

	# Fallback to _before_bash_contexter_command_not_found_handle
	if type _before_bash_contexter_command_not_found_handle &> /dev/null; then
		_before_bash_contexter_command_not_found_handle "$@"
		return $?
	fi

	# Fallback to _default_command_not_found_handle
	_default_command_not_found_handle "$@"
	return $?
}


# ------------------------------------ API -------------------------------------


bash_contexter_register () {

	# Register precheck first since it's a dependancy
	if ! type "precheck_$1" &> /dev/null; then
		echo "No precheck found for $1, will not register it."
		return 1
	else
		_bash_contexter_prechecks_commands["$1"]="precheck_$1"
	fi

	# Register command
	_bash_contexter_context_commands+=("$1")

}


source "$BASH_CONTEXTER_PATH/helpers.sh"
