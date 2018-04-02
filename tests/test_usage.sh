source utils.sh
# Source django example


# Ensure state is created
# if [ ! -f commands.pik ]; then
#   _failure 'Expected a commands.pik to be created'
# fi
# if [ ! -f prechecks.pik ]; then
#   _failure 'Expected a prechecks.pik to be created'
# fi
#
# # Running non-existent command should give default error message
# output=`bash -c dffdsggd 2>&1`
# expected='bash: dffdsggd: command not found'
# if [[ "$output" != "$expected" ]]; then
#   _failure "Expected '$expected', got '$output'"
# fi


source ../bash_contexter.sh

# Creat a simple echo that will always run
# function echo_command {
# 	echo "$1"
# }
# function precheck_echo_command {
# 	return 0
# }
# bash_contexter_register 'echo_command'

# type command_not_found_handle

# Run
# output=`nonexistingcommand 2>&1`
# expected='nonexistingcommand'
# echo "$output"


function my_test(){
    echo 'this is a test'
}

export -f my_test
python -c "from subprocess import check_output; print(check_output('my_test', shell=True))"
