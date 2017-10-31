# Creates and clone new ar-sudoersd github repos

On my workstation, uses [helpers][] to [Adds ar-sudoersd repos][]

```
cd ~/usr/thydel.d/helpers
./helper.mk install
github thy create/ar-sudoersd
git ci -am 'Adds ar-sudoersd repos'
git push
```

[helpers]: https://github.com/thydel/helpers "github.com"
[Adds ar-sudoersd repos]:
	https://github.com/thydel/helpers/commit/09ad4030c3af402c8dd398805a619ccc550fc69d "github.com"

On my workstation, clone and init [ar-sudoersd][]

```
cd ~/usr/thydel.d
github clone/ar-sudoersd
cd ar-sudoersd
helper ansible
helper git-config
```

[ar-sudoersd]: https://github.com/thydel/ar-sudoersd "github.com"

# hg-git and stretch

```
pip install hg-git
```

[Adds a stretch kludge for hg-git][]

[Adds a stretch kludge for hg-git]:
	https://github.com/thydel/helpers/commit/bc12786fa81181eb9b7dc0f0e0bd8152d1b17420 "github.com"


# Migrates from mercurial


```bash
or=sudoersd
r=ar-${or}
cd ~/usr/thydel.d/helpers/
helper ansible
hg2git.yml -D -e hg=~/usr/epi2/roles/$or -e git=~/usr/thydel.d/$r
hg --cwd ~/usr/epi2/roles/$or push git
cd ~/usr/thydel.d/$r
git pull
echo *~ >> .gitignore
git rm .hgignore
git add .
git commit -m 'Migrates from mercurial'
git push
```
