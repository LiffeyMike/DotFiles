#!/bin/sh
# Run by chezmoi-pkglists.hook after packages are installed or removed. Managed by chezmoi (etc/).
# It lives in /etc, not in the user's home, because a root hook must only run root-owned code.
# The lists are written as the user, so the files stay theirs and root never writes into $HOME.
user=mike
dir=/home/$user/.local/share/chezmoi/packages
[ -d "$dir" ] || exit 0

pacman -Qqen | runuser -u "$user" -- sh -c 'cat > "$1"' sh "$dir/pacman.txt"
# yay-bin is left out: on a fresh install the packages script installs yay from the repo.
pacman -Qqem | grep -v '^yay-bin' | runuser -u "$user" -- sh -c 'cat > "$1"' sh "$dir/aur.txt"
exit 0
