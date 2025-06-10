#!/bin/bash
cd ~
rm -rf backup.tgz
tar -zcf backup.tgz .local/share/keyrings .ssh .gnupg Documents .thunderbird/y6g71159.default-release
