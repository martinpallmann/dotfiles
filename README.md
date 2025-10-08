# Dotfiles • Stow + Just + Zsh (XDG + Znap + p10k)

Personal dotfiles managed with **GNU Stow** and a **Justfile** for ergonomic tasks.  
Zsh is XDG-clean, powered by **Znap** (plugin manager) and **Powerlevel10k**.

> Structure (at a glance): top-level directories are stow “packages” (e.g. `zsh/`).  
> Run `just plan|link|unlink <pkg...>|all` to preview/apply symlinks into your `$HOME`.

---

## Quick start

### 1) Install prerequisites
- macOS (Homebrew):
  ```bash
  brew install stow just
````

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

## What’s inside

* `zsh/` — Zsh configuration following XDG:

  * `~/.zshenv` sets `ZDOTDIR="$XDG_CONFIG_HOME/zsh"` so shells read configs from `~/.config/zsh/`.
  * `.zshrc` boots **Znap** from `$XDG_DATA_HOME/znap`, loads:

    * `zsh-users/zsh-autosuggestions`
    * `zsh-users/zsh-syntax-highlighting` (loaded last)
    * `romkatv/powerlevel10k` (with instant prompt)
  * Ruby toolchain:

    * `rbenv` initialized (root at `$XDG_DATA_HOME/rbenv`)
    * per-Ruby **GEM_HOME** at `$XDG_DATA_HOME/gem/ruby/<ruby_api_version>`
    * Bundler/config/history moved under XDG
* `.stow-local-ignore` — ignore rules so Stow doesn’t try to link repo junk (edit to taste).
* `Justfile` — friendly tasks for planning/linking/unlinking stow packages.

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

## Zsh details

* **XDG layout**

  * `~/.zshenv` (in this repo) sets:

    ```sh
    export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
    export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
    export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
    ```
* **Plugin manager: Znap**
  Bootstraps itself (first run clones to `$XDG_DATA_HOME/znap`). Subsequent startups are quiet and fast.
* **Prompt: Powerlevel10k**
  Instant prompt enabled. If a rare first-run message appears (e.g., when Znap clones), you can silence the warning with:

  ```sh
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
  ```

---

## Ruby (rbenv) & Gems

* `RBENV_ROOT="$XDG_DATA_HOME/rbenv"` (move an existing `~/.rbenv` there if present).
* After rbenv initializes, `GEM_HOME` is set per Ruby ABI:

  ```
  $XDG_DATA_HOME/gem/ruby/<api-version>
  ```
* Bundler and gem caches/config are moved under:

  ```
  $XDG_CONFIG_HOME/gem/gemrc
  $XDG_CACHE_HOME/gem
  $XDG_DATA_HOME/bundle
  ```

**Install example**

```bash
brew install rbenv ruby-build
rbenv install 3.3.4
rbenv global 3.3.4
gem update --system
gem install --no-document bundler
```

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
