set shell := ["bash", "-eu", "-o", "pipefail", "-c"]
set quiet := true

@default:
  @just --list

link *pkgs:
  #! /usr/bin/env bash
  
  command -v stow >/dev/null || { echo "Please install GNU stow"; exit 1; }

  if [[ "{{pkgs}}" == "" ]]; then
    while IFS= read -r -d '' d; do
      PKGS+=("$(basename "$d")")
    done < <(find stow -mindepth 1 -maxdepth 1 -type d -print0)
    set -- "${PKGS[@]}"
  else
    set -- {{pkgs}}
  fi
  for pkg in "$@"; do
    stow --dir stow --target "$HOME" --dotfiles --restow --adopt --no-folding "$pkg"
    echo "🔗 $pkg"
  done

