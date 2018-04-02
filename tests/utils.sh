function _failure {
  echo "Test failed:"
  echo "  $1"
  return 1
}

function _reset {
  unset _bash_contexter_prechecks_commands
  unset _bash_contexter_context_commands
}
