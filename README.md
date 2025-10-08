# Dotfiles

Personal dotfiles managed with **GNU Stow** and a **Justfile** for ergonomic tasks.  

> Structure (at a glance): top-level directories are stow “packages” (e.g. `zsh/`).  
> Run `just plan|link|unlink <pkg...>|all` to preview/apply symlinks into your `$HOME`.

---

## Quick start

### 1) Install prerequisites
- macOS (Homebrew):
  ```bash
  brew install stow just
```

* Debian/Ubuntu:

  ```bash
  sudo apt install stow just
```

### 2) Clone and enter

```bash
git clone https://github.com/martinpallmann/dotfiles.git ~/Dotfiles
cd ~/Dotfiles
```

### 3) Preview, then link

```bash
just plan all      # dry-run: see what would be linked
just link zsh      # or: just link all
```

> Default target is `$HOME`. You can override per run:
>
> ```bash
> TGT=/some/other/home just link all
> ```

---

## Usage

```bash
# See available tasks
just

# Dry-run (no changes), one or more packages or "all"
just plan zsh
just plan all

# Link / restow
just link zsh
just link all

# Unlink (remove symlinks created by Stow)
just unlink zsh
just unlink all

# Target a different home
TGT=/tmp/home just plan all
```

The Justfile:

* checks `stow` is installed each run,
* supports `all` (expands to all top-level package folders),
* prints concise status lines.

---

## Tips & troubleshooting

* **Dry-run first**
  Use `just plan <pkg>` before `link` to catch conflicts.
* **Existing files clash**
  Move/backup them, then `just link ...` again. (`--restow` is used automatically.)
* **Compinit “insecure directories”**
  Run `compaudit` and fix permissions, or temporarily `compinit -i`.
* **IDE doesn’t pick up env**
  GUI apps launched from dock may not inherit zsh env. Launch once from a terminal or configure env vars inside the app.
* **First-run prompt warning**
  It’s usually Znap cloning/caching. Either ignore (it’s one-time), or set:

  ```sh
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
  ```

---

## Conventions

* Package layout follows Stow’s `--dotfiles` convention: files named `dot-foo` become `~/.foo`.
* Keep only *source of truth* here (no vendored plugin code when using Znap).
* Prefer XDG for caches/config/data. If a tool lacks an XDG knob, leave its default in `$HOME`.

---

## License

Personal dotfiles. Use anything you find helpful; no warranty.
