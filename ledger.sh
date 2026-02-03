#!/bin/bash

#set -x

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$script_dir/lib.sh"

if [ -z "$LEDGER_HOST" ]; then
  error "Missing environment variable LEDGER_HOST"
fi

if [ -z "$LEDGER_PORT" ]; then
  error "Missing environment variable LEDGER_PORT"
fi

local_port=$(get_random_port)
echo "Using local port $local_port for SSL tunnel..."

function tunnel_pid() {
  port=$1
  pid=$(ps -aef | grep "\-L $port\:localhost\:$LEDGER_PORT\ $LEDGER_HOST" | awk '{print $2}')
  #debug echo "Tunnel PID for port $port is $pid"
  echo -n $pid
}

if [ -z "$(tunnel_pid $local_port)" ]; then
  echo "Establishing SSH Tunnel to $LEDGER_HOST on local port $local_port..."
  debug ssh -fN -L $local_port:localhost:$LEDGER_PORT $LEDGER_HOST
  sleep 1
fi

PID=$(tunnel_pid $local_port)

if [ -z "$PID" ]; then
  error "Unable to establish SSH Tunnel!" 
fi

echo "Starting Ledger Session via SSH Tunnel PID $PID..."
temp_profile=$(mktemp -d)
chromium --user-data-dir="$temp_profile" --app="http://localhost:$local_port" 2>/dev/null
rm -rf "$temp_profile"

kill $PID || error "Failed to kill Tunnel process PID $PID!" 

echo "Ledger Connection terminated."
