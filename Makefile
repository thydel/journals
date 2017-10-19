top:; @date

indexed := ln -s ../journals-indexed/indexed;
indexed += ansible -i localhost, localhost -c local -m lineinfile -a 'path=.gitignore line=indexed' -D
indexed:; $($@)

once: indexed

.PHONY: top once
