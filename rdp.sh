#!/bin/bash

set -x

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

host=$1
if [ -z "$host" ]; then
  error "Usage: $0 <remote-host>"
fi

local_port=$(get_random_port)
echo "Using local port $local_port for RDP tunnel..."

function tunnel_pid() {
  port=$1
  pid=$(ps -aef | grep "\-L $port\:localhost\:3389\ $host" | awk '{print $2}')
  #debug echo "Tunnel PID for port $port is $pid"
  echo -n $pid
}

if [ -z "$(tunnel_pid $local_port)" ]; then
  echo "Establishing SSH Tunnel to $host on local port $local_port..."
  debug ssh -fN -L $local_port:localhost:3389 $host
  sleep 1
fi

PID=$(tunnel_pid $local_port)

if [ -z "$PID" ]; then
  error "Unable to establish SSH Tunnel!" 
fi

echo "Starting RDP Session via SSH Tunnel PID $PID..."
debug rdesktop -u $USER -a 8 -z -g 2560x1420 localhost:$local_port 2>/dev/null

kill $PID || error "Failed to kill Tunnel process PID $PID!" 

echo "RDP Connection terminated."

