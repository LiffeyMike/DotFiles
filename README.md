# dotfiles

Managed with [chezmoi](https://chezmoi.io). Secrets are encrypted with age.

## Restore on a fresh CachyOS install

1. `sudo pacman -Syu chezmoi age git`
2. Copy the age key from offline storage to `~/.config/chezmoi/key.txt` and `chmod 600` it.
3. `chezmoi init --apply https://github.com/LiffeyMike/DotFiles.git`
   (HTTPS with a token: the SSH key is inside this repo). Then switch the remote to SSH:
   `chezmoi git -- remote set-url origin git@github.com:LiffeyMike/DotFiles.git`
4. Reboot (the nvidia modprobe options are in the initramfs).

## Layout

- `dot_*`, `private_*`, `encrypted_*`: files in `$HOME`.
- `etc/`: copied into `/etc` by `run_onchange_after_20-etc.sh.tmpl`. Not a chezmoi target.
- `packages/`: pacman/AUR package lists and systemd units, applied by the `run_onchange_after_` scripts.

## Day to day

- `chezmoi edit <file>` / `chezmoi re-add`, then `chezmoi git -- commit -am ...`
- Package lists update themselves: a pacman hook (etc/pacman.d/hooks/chezmoi-pkglists.hook)
  rewrites packages/*.txt after every install or removal. Review and commit them.
- Secrets: `chezmoi edit ~/.config/secrets.env`
