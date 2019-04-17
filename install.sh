#! /bin/bash

link_file() {
  if [[ -d $1 ]]; then
    if [[ ! -e "$1/$(basename $2)" ]]; then
      ln -s $2 $1/$(basename $2)
    elif [[ -f "$1/$(basename $2)" && ! -L "$1/$(basename $2)" ]]; then
      echo "$2: not linking because file exists: $1/$(basename $2)"
    fi
  else
    echo "$2: not linking because $1 is no directory"
  fi
}

link_dir() {
  for entry in $(find $2 -maxdepth 1 -type f); do
    if [[ ! -d $1 ]]; then
      echo "mkdir -p $1"
    fi
    link_file "$1" "$entry"
  done
}

walk() {
  link_dir $1 $2
  for entry in $(find $2 -maxdepth 1 -type d | tail -n +2); do
    walk "$1/$(basename "$entry")" "$entry"
  done
}

link() {
  root="$(cd "$(dirname "$0")" ; pwd -P)"
  for dir in "$@"
  do
    walk "$HOME" "$root/$dir"
  done
}

link fish git sbt tmux
