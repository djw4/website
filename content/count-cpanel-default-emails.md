---
date: 2012-04-06
title: Count cPanel default emails
category: posts
---

Recently a customer had an issue on their cPanel server whereby their MX records were overwritten and mail was sent to the 'default' email address instead of to their Office365 addresses.

To better understand what mail had been missed I used the following expression (domain removed for retain their privacy):

```bash
grep -ir "***.com.au" /home/***/mail/cur/ \
grep -i "envelope-to" | \
grep -i -o '[A-Z0-9._%+-]\[email protected][A-Z0-9.-]\+\.[A-Z]\&#123;2,4\&#125;' | \
sort | uniq -c | sort -nr
```

This will return a sorted count of emails and their intended recipients, such as the following:

```
25 [email protected].com.au
10 [email protected].com.au
9 [email protected].com.au
9 [email protected].com.au
8 [email protected].com.au
7 [email protected].com.au
7 [email protected].com.au
4 [email protected].com.au
3 [email protected].com.au
1 [email protected].com.au
1 [email protected].com.au
1 [email protected].COM.AU
```

Syncing this email on with IMAP sync is a simple affair, but now we know where the best place to send the mail to to minimise any additional work in sorting.

