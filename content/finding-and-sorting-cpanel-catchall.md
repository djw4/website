---
date: 2012-04-06
title: "Finding and sorting cPanel catchall"
category: posts
---

In it's default configuration cPanel's email facilities have a feature called the 'Default Address', which accepts mail sent to a domain that didn't match any available mailboxes on the server.

Whilst great in theory it can prove problematic if not checked regularly by the customer or by the server administrator. Due to it's inherent ability to accept mail from anyone, to anyone (at the domain) the default address will frequently fill up with spam emails which does nothing but soak up disk space on the server.

Fortunately I've come up with a one-liner bash statement that will scan all default addresses on a server, count the number of emails inside, and sort those for you. You could easily build on this statement to email the server administrator when emails go over a certain limit using cron.

The statement looks like this:

```
for i in `ls -A1 /var/cpanel/users`; do \
echo $i `find /home/$i/mail/cur/ -type f | wc -l`; done | \
awk -F ' ' '{print $NF,$0}' | sort -n | cut -f2- -d' '
```

Whilst fairly basic, the statement does the following:

-   For every cPanel user on the server,
-   Print the user, find files in the user's `~/mail/cur/` directory,
    then count the number of found files,
-   Process the STDOUT to print only the username and count of files,
-   Then sort in a descending order

An example of this working being:

```
...
shutterw-331
villaget-514
swarchit-609
teamsbrc-662
tksteelc-5435
mclesolu-41435
```

The statement below then deletes all files in this directory (the largest directory) that is older than 1 year (and likely not needed any longer):

`find /home/mclesolu/mail/cur/ -type f -mtime +365 -delete`