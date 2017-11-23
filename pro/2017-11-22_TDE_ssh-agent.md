On my `debian9` workstation trying to get an ssh-agent *as usual*, I fight with:

- `gnome-keyring-dameon`
  - process `/usr/bin/gnome-keyring-daemon --start --foreground --components=secrets`
  - env `SSH_AUTH_SOCK=/run/user/1000/keyring/control`

- `gpg-agent`
  - process `/usr/bin/gpg-agent --supervised`
  - env `GPG_AGENT_INFO=/run/user/1000/S.gpg-agent.ssh`

- `mate-session`
  - process `/usr/bin/ssh-agent mate-session`
  - env `GPG_AGENT_INFO=/run/user/1000/S.gpg-agent.ssh`


Admittedly, I upgraded from wheezy to stretch via jessie, and I
installed gnome and mate, and now only use make and lightdm.

Resulting in a default login session with a non functionnal

```
SSH_AUTH_SOCK=/run/user/1000/keyring/ssh
GPG_AGENT_INFO=/run/user/1000/gnupg/S.gpg-agent:0:1
```

Trying to force `gpg` use for ssh-agent using

```
export SSH_AUTH_SOCK=/run/user/1000/gnupg/S.gpg-agent.ssh
```

opens new arcanes problems which I decided to not even mention here.

Revert to plain old `ssh-agent` following
[how-to-start-and-use-ssh-agent-as-systemd-service][] advice

Make a small playbook [user-ssh-agent.yml][] to install `ssh-agent`,
enable and activate `ssh-agent`

```
user-ssh-agent.yml # once
export SSH_AUTH_SOCK=/run/user/$(id -u $USER)/user-ssh-agent.socket
```

[how-to-start-and-use-ssh-agent-as-systemd-service]:
	https://unix.stackexchange.com/questions/339840/how-to-start-and-use-ssh-agent-as-systemd-service "unix.stackexchange.com"

[user-ssh-agent.yml]: https://github.com/thydel/misc-play/blob/master/user-ssh-agent.yml "github.com"
