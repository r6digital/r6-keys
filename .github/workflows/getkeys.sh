#!/bin/bash
set -e
git config user.name "Github Actions Bot - $REPO"
TEMP=$(mktemp)
cat <<EOF >$TEMP
# keys generated by github.com/r6digital/r6-keys
# adding keys to your github profile can be done here:
# https://github.com/settings/keys
# you can then trigger a refresh of the authorized_keys file here:
# https://github.com/r6digital/r6-keys/actions/workflows/getKeys.yml
#####
EOF
curl -s https://api.github.com/orgs/r6digital/members \
  -H "Authorization: token ${GH_PAT}" |
  jq -r '[ .[] | .html_url]|.[]' |
  while read ghuser; do
    curl -s "$ghuser.keys" >>$TEMP
  done
/bin/cp $TEMP authorized_keys
[[ $(git status --porcelain=v1 2>/dev/null | wc -l | xargs) == 0 ]] && exit 0
git commit -am "updating authorized_keys"
git push
