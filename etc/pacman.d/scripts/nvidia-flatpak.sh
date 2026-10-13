#!/bin/sh
# Run by nvidia-flatpak.hook after nvidia-utils is installed or upgraded. Managed by chezmoi (etc/).
# Flatpak apps (Heroic) only get the NVIDIA GPU through a GL extension whose version matches the
# host driver exactly. `flatpak update` derives that version from the *loaded* kernel module,
# which stays the old one until reboot, so the new version is read from pacman here instead.
#
# The hook only queues the work: the download runs in the user's systemd manager (so it has
# their session bus for the notification) and pacman isn't held up while it fetches.
user=mike

if [ "$1" = sync ]; then
	# Second stage, running as the user: $2 = extension to install, $3 = loaded one to keep.
	ext=$2 keep=$3 ver=$4
	if flatpak --user install -y --noninteractive flathub \
		"org.freedesktop.Platform.GL.$ext" "org.freedesktop.Platform.GL32.$ext"; then
		# Drop other versions, except the loaded driver's: it's still in use until reboot.
		flatpak --user list --runtime --columns=application |
			grep -E '^org\.freedesktop\.Platform\.GL(32)?\.nvidia-' |
			grep -vE "\.($ext|$keep)\$" |
			xargs -r flatpak --user uninstall -y --noninteractive
		notify-send -u critical -a nvidia "NVIDIA driver $ver installed" \
			"Flatpak extension synced. Reboot to load the new driver; games can't use the GPU until then."
	else
		notify-send -u critical -a nvidia "NVIDIA driver $ver installed" \
			"Flathub has no $ext extension yet, so Heroic games will fall back to Intel. Reboot, then retry with: flatpak update"
	fi
	exit 0
fi

ver=$(pacman -Q nvidia-utils | cut -d' ' -f2 | cut -d- -f1)  # 615.78.08-2 -> 615.78.08
ext=nvidia-$(echo "$ver" | tr . -)                          # -> nvidia-615-78-08
loaded=$(cat /sys/module/nvidia/version 2>/dev/null)
keep=nvidia-$(echo "${loaded:-none}" | tr . -)

echo "==> NVIDIA driver $ver installed (loaded: ${loaded:-none}). Reboot to use it."
systemd-run --quiet --no-block --user --machine="$user@.host" --unit="nvidia-flatpak-$ext" \
	/bin/sh /etc/pacman.d/scripts/nvidia-flatpak.sh sync "$ext" "$keep" "$ver" ||
	echo "==> $user isn't logged in: run 'flatpak update' after rebooting to sync the extension."
exit 0
