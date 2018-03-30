# Extracts file list from an email set using curl

```
imap=imaps://imap.gmail.com/INBOX
email=user@domain.tld
user=$email:$(pass imap/$email)
from=sender
subject=ERROR
search='curl -su $user --url $imap -X "SEARCH FROM $from SUBJECT $subject"'
body='curl -su $user --url "$imap/;UID={}/;SECTION=TEXT"'
eval $search | cut -d' ' -f 3- | tr ' ' '\n' | eval xargs -ri $body | grep 'No space left on device' | cut -d: -f2
```

See

- [pass][]
- [Test IMAP with curl (IMAP example)][]
- [Manual IMAP][]
- [libcurl and imap][]

[pass]: https://www.passwordstore.org/ "passwordstore.org"

[Test IMAP with curl (IMAP example)]:
	https://busylog.net/test-imap-with-curl-imap-example/ "busylog.net"

[Manual IMAP]:
	https://www.skytale.net/blog/archives/23-Manual-IMAP.html "skytale.net"

[libcurl and imap]:
	https://stackoverflow.com/questions/10267500/libcurl-and-imap "stackoverflow.com"

[Performing IMAP queries via curl]:
	https://debian-administration.org/article/726/Performing_IMAP_queries_via_curl "debian-administration.org"
