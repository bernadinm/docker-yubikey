#!/bin/bash

gpg --card-status
gpg-connect-agent updatestartuptty /bye

mkdir test
cd test
touch 1
git init
git add 1
git commit -S -m "My commit msg"

git verify-commit HEAD
echo ">>>>>>>>>>>>> Executed Commit"

echo test | gpg -a --sign
echo ">>>>>>>>>>>>> Executed signing test"
git clone git@github.com:bernadinm/g ~/g
ls -l ~/g | head -10
