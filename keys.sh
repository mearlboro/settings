#!/bin/sh

# generate a SSH key on the Yubikey
# https://developers.yubico.com/PIV/Guides/SSH_with_PIV_and_PKCS11.html
# make sure ssh-agent is running

yubico-piv-tool -s 9a -a generate -o public.pem
yubico-piv-tool -a verify-pin -a selfsign-certificate -s 9a -S "/CN=SSH key/" -i public.pem -o cert.pem
yubico-piv-tool -a import-certificate -s 9a -i cert.pem
ssh-add -s /usr/lib/x86_64-linux-gnu/libykcs11.so
rm public.pem

# To setup with github, after pasting the key in account settings
ssh -T git@github.com
