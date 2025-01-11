#!/bin/bash
cd ~
rm -rf backup.tgz
tar -zcf backup.tgz .local/share/keyrings .ssh .gnupg Documents snap/thunderbird/common/.thunderbird/bmjzizun.default
