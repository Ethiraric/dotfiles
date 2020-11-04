set -euo pipefail

function importFile() {
  from="$1"
  to="$2"

  if [ "$#" -ne 2 ]; then echo "Invalid use of importFile"; exit 1; fi
  [ -f "$from" ] && rm -f "$to" && ln -v "$from" "$to" || echo "Skipping: $from"
}

function importDir() {
  from="$1"
  to="$2"

  if [ "$#" -ne 2 ]; then echo "Invalid use of importDir"; exit 1; fi
  if [ -d "$from" ]; then
    rm -rf "$to"
    mkdir "$to"
    for dir in $(cd "$from" && find . -type d | tail -n +1 | cut -c 3-); do mkdir -v "$to/$dir"; done
    for file in $(cd "$from" && find . -type f | tail -n +1 | cut -c 3-); do ln -v "$from/$file" "$to/$file"; done
  else
    echo "Skipping: $from"
  fi
}

importDir "${HOME}/.config/nvim" "config/nvim"
importDir "${HOME}/.config/ranger" "config/ranger"
importDir "${HOME}/Scripts" "Scripts"

importFile "${HOME}/.config/i3/config" "config/i3/config"

importFile "${HOME}/.Xdefaults" Xdefaults
importFile "${HOME}/.xinitrc" xinitrc
importFile "${HOME}/.Xresources" Xresources
importFile "${HOME}/.bashrc" bashrc
