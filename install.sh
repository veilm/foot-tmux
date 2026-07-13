#!/bin/sh
meson setup --reconfigure build
meson compile -C build
sudo cp build/foot /usr/local/bin/foot-tmux

echo "testing PATH:"
which foot-tmux
