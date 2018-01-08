# Tries inotify

We know that `inotify` exists, but how exactly can we use it to
trigger a simple script when we drop a file in a directory ?

In a first terminal

```console
thy@tde-ws:~/tmp$ echo 'top: $(patsubst %.c,%,$(wildcard *.c))' > Makefile
thy@tde-ws:~/tmp$ inotifywait -qme close_write . | grep -F .c --line-buffered | xargs -i make
# see second terminal actions below
cc     t.c   -o t
cc     t.c   -o t
```

In a second terminal

```console
thy@tde-ws:~/tmp$ echo -e '#include <stdlib.h>\nint main(){exit(0);}' > t.c
thy@tde-ws:~/tmp$ touch t.c
```

Sadly the onliner way don't work

```
inotifywait -qme close_write . | grep -F .c --line-buffered \
                               | xargs -i make -f <(echo 'top: $(patsubst %.c,%,$(wildcard *.c))')
```

I don't understand why exactly why, but the process susbstition
invocation via a never ending xargs induces zombies make processus.
