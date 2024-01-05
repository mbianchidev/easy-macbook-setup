#!/bin/sh

ssh-keygen -t my-key -C "john.doe@example.co"
exec ssh-agent zsh
ssh-add --apple-use-keychain ~/.ssh/my-key
touch ~/.ssh/config
vi ~/.ssh/config

# Host *
#  AddKeysToAgent yes
#  UseKeychain yes
#  IdentityFile ~/.ssh/my-key

# Add pub key to GH Account

echo "ready to clone"
