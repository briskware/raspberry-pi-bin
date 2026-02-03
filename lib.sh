
function error() {
  msg=$1
  echo "$msg" >&2
  exit 2
}

function debug() {
  msg="$@"
  echo "DEBUG: $msg" >&2

  # I want to execute the argument as a command for debugging purposes
  eval "$msg" || error "DEBUG COMMAND FAILED: $msg"
}

function breakline() {
    echo "----------------------------------------"
}

function generate_random_port_number() {
  echo $(( ( RANDOM % 16383 )  + 49152 ))
}

function get_random_port() {
  while : ; do
    port=$(generate_random_port_number)
    if ! lsof -i:$port >/dev/null 2>&1 ; then
      break
    fi
  done
  echo -n $port
}
