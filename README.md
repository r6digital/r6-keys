# r6-keys (public repository)

The script at `.github/workflows/getkeys.sh` updates the `authorized_keys` file in this repository by fetching the keys of each member of the r6digital GitHub organization. 

A cronjob on each server pulls the `authorized_keys` file on a regular basis (usually every minute).

This script runs automatically once a day, but it can also be run on demand from the [workflow page](https://github.com/r6digital/r6-keys/actions/workflows/getKeys.yml).

## Using this repo on a server

Add this to the sshd configuration file:

```
PubkeyAuthentication yes
AuthorizedKeysFile /etc/ssh/authorized_keys .ssh/authorized_keys
```

Then add this to the crontab:

```
* * * * * /usr/bin/wget https://raw.githubusercontent.com/r6digital/r6-keys/develop/authorized_keys -qO-> /etc/ssh/authorized_keys
```
