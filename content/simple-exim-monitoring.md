---
date: 2013-03-06
title: "Simple Exim monitoring"
draft: true
category: posts
---

This is a simple script that I've begun developing to output some useful information from the Exim logs that can be used for analysis of emails being sent via SMTP authentication.

Whilst fairly basic, the script looks like this:

```
#!/bin/bash
# cPanel Simple Monitor
WEBROOT="/usr/local/apache/htdocs/tools/mail.txt"
echo --------------------------- > $WEBROOT
echo `hostname` >> $WEBROOT
echo `date` >> $WEBROOT
echo Mailbox Auth: >> $WEBROOT
perl -lsne '/$today.* \[([0-9.]+)\]:.+dovecot_(?:login|plain):([^\s]+).* for (.*)/ and $sender&#123;$2&#125;&#123;r&#125;+=scalar (split / /,$3) and $sender&#123;$2&#125;&#123;i&#125;&#123;$1&#125;=1; END &#123;foreach $sender(keys %sender)&#123;printf"Recip=%05d Hosts=%03d Auth=%s\n",$sender&#123;$sender&#125;&#123;r&#125;,scalar (keys %&#123;$sender&#123;$sender&#125;&#123;i&#125;&#125;),$sender;&#125;&#125;' -- -today=$(date +%F) /var/log/exim_mainlog | sort | tail -n 5 >> $WEBROOT
echo --------------------------- >> $WEBROOT
  ```

This should give you something like the following:

```
cp-x.com
Mon Jul 18 17:01:00 AEST 2016
Mailbox Auth:
Recip=00016 Hosts=002 [email protected]
Recip=00017 Hosts=001 [email protected]
Recip=00032 Hosts=009 [email protected]
Recip=00036 Hosts=001 [email protected]
Recip=05072 Hosts=306 [email protected]
```

You can then schedule this with a Cronjob.
