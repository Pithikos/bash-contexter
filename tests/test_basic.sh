source utils.sh

# Source django example
source ../bash_contexter.sh
source ../examples/django.sh

# Ensure state is created
if [ ! -f commands.pik ]; then
  _failure 'Expected a commands.pik to be created'
fi
if [ ! -f prechecks.pik ]; then
  _failure 'Expected a prechecks.pik to be created'
fi

# Running non-existent command should give default error message
output=`bash -c dffdsggd 2>&1`
expected='bash: dffdsggd: command not found'
if [[ "$output" != "$expected" ]]; then
  _failure "Expected '$expected', got '$output'"
fi
