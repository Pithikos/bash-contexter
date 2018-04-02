source utils.sh


##############################################
# CASE: Normal usage
##############################################

source ../bash_contexter.sh

# Create a simple echo that will always run
function echo_command {
	echo "$1"
}
function precheck_echo_command {
	return 0
}
bash_contexter_register 'echo_command'

# Run
output=`nonexistingcommand 2>&1`
expected='nonexistingcommand'
if [[ $output != $expected ]]; then
  _failure "Expected '$expected', got '$output'"
fi


##############################################
# CASE: Failing precheck
##############################################

_reset

# Create a simple echo with a precheck that always fails
function echo_command {
	echo "$1"
}
function precheck_echo_command {
	return 1
}
bash_contexter_register 'echo_command'

# Run
output=`nonexistingcommand 2>&1`
notexpected='nonexistingcommand'
if [[ $output == $notexpected ]] || [[ $output == '' ]]; then
  _failure "Expected something but got '$output'"
fi


##############################################
# CASE: Missing precheck
##############################################


_reset
unset -f precheck_echo_command
function echo_command {
	echo "$1"
}
bash_contexter_register 'echo_command' &> /dev/null
if (( $? == 0 )); then
  _failure "Should not have registered 'echo_command', but it did."
fi


##############################################
# CASE: Chaining
##############################################
_reset
function echo_command_1 {
	echo 'first'
}
function precheck_echo_command_1 {
  return 1
}
function echo_command_2 {
	echo 'second'
}
function precheck_echo_command_2 {
  return 0
}
bash_contexter_register 'echo_command_1'
bash_contexter_register 'echo_command_2'

# Run
output=`nonexistingcommand 2>&1`
expected='second'
if [[ $output != $expected ]]; then
  _failure "Expected '$expected', got '$output'"
fi
