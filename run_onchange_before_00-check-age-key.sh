#!/bin/sh
# Encrypted files can't be applied without the age identity, which is kept outside the repo.
if [ ! -f "$HOME/.config/chezmoi/key.txt" ]; then
    echo "chezmoi: missing $HOME/.config/chezmoi/key.txt, so encrypted files can't be decrypted." >&2
    echo "Copy the age key from offline storage there (chmod 600), then re-run chezmoi apply." >&2
    exit 1
fi
