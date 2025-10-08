# Use bash with strict flags for all recipes
set shell := ["bash", "-eu", "-o", "pipefail", "-c"]
# Be less verbose
set quiet := true

# Where to link to (override with: just TGT=/some/where link all)
TGT := env_var("HOME")

# List stowable packages = top-level directories that aren't ignored
packages := `ls -1d */ 2>/dev/null | sed 's:/$::' | grep -vE '^(\\.git|\\.github|_?docs?|scripts?|bin|vendor)?$' || true`

@default:
  @just --list

# ---- Core helper ----
# Usage: just _stow plan|link|unlink <pkg...>|all
_stow cmd *pkgs:
  #! /usr/bin/env bash
  # inject TGT from just into the shell
  TGT="{{TGT}}"

  command -v stow >/dev/null || { echo "Please install GNU stow"; exit 1; }
  cmd="{{cmd}}"

  # args from just
  if [[ "{{pkgs}}" == "" ]]; then
    echo "Usage: just ${cmd} <pkg...>|all" >&2
    exit 2
  fi
  if [[ "{{pkgs}}" == "all" ]]; then
    set -- {{packages}}
  else
    set -- {{pkgs}}
  fi

  # run
  for pkg in "$@"; do
    case "$cmd" in
      plan)
        echo "🔎 plan $pkg -> $TGT"
        stow --target="$TGT" --dotfiles --no --restow "$pkg" || true
        ;;
      link)
        echo "🔗 link $pkg -> $TGT"
        stow --target="$TGT" --dotfiles --restow "$pkg"
        ;;
      unlink)
        echo "✂️ unlink $pkg from $TGT"
        stow --target="$TGT" --dotfiles -D "$pkg"
        ;;
      *)
        echo "Unknown subcommand: $cmd (expected: plan|link|unlink)" >&2
        exit 2
        ;;
    esac
  done

# ---- Thin wrappers ----
plan *pkgs:
  @just _stow plan {{pkgs}}

link *pkgs:
  @just _stow link {{pkgs}}

unlink *pkgs:
  @just _stow unlink {{pkgs}}

