# Recreate directories
rm -rf config Scripts Xdefaults xinitrc Xresources
mkdir config config/{nvim,i3} Scripts

# Copy nvim config
for dir in $(cd ~/.config/nvim && find . -type d | tail -n +1 | cut -c 3-); do mkdir -v config/nvim/$dir; done
for file in $(cd ~/.config/nvim && find . -type f | tail -n +1 | cut -c 3-); do ln -v ~/.config/nvim/$file config/nvim/$file; done

# Copy i3 config
ln ${HOME}/.config/i3/config ./config/i3/config

# Copy Scripts
for dir in $(cd ~/Scripts && find . -type d | tail -n +1 | cut -c 3-); do mkdir -v Scripts/$dir; done
for file in $(cd ~/Scripts && find . -type f | tail -n +1 | cut -c 3-); do ln -v ~/Scripts/$file Scripts/$file; done

# Copy random files
ln ${HOME}/.Xdefaults Xdefaults
ln ${HOME}/.xinitrc xinitrc
ln ${HOME}/.Xresources Xresources
