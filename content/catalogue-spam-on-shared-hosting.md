---
date: 2012-04-06
title: "Catalogue spam in cPanel"
category: posts
---

The first script below will search every user in `/home` on a cPanel server, and look for emails with the string `***SPAM***` which is injected by Apache SpamAssassin. The second script searches for instances in `/var/log/maillog` for the same information.

```bash
#!/bin/bash
TODAY=`date +"%Y-%m-%d"`
OUTPUT="/usr/local/apache/htdocs"
touch $OUTPUT/$TODAY-mailboxspam.txt
echo > $OUTPUT/$TODAY-mailboxspam.txt

### Search the filesystem
grep -lrF ***SPAM*** /home/*/mail/ | sed "s/[^/]*$//" | \
awk '{gsub("new/|cur/", "");print}' | \
awk '{gsub(".[tT]rash/", "");print}' | \
awk '{gsub(".[jJ]unk/", "");print}' | \
awk '{gsub(".[sS]pam/", "");print}' | \
awk '{gsub(".[sS]ent/", "");print}' | \
sort | uniq -c | sort -n > $OUTPUT/$TODAY-mailboxspam.txt
sed -i 's/ //g' $OUTPUT/$TODAY-mailboxspam.txt
```

```bash
#!/bin/bash
TODAY=`date +"%Y-%m-%d"`
OUTPUT="/usr/local/apache/htdocs"
touch $OUTPUT/$TODAY-userspam.txt
echo > $OUTPUT/$TODAY-userspam.txt

### Search the maillog
printf "$(date): Now searching /var/log/maillog for identified spam.\n"
cat /var/log/maillog | grep \
-e "`date --date='-2 days' +%b\ %e`" \
-e "`date --date='-1 days' +%b\ %e`" | \
grep -i 'identified spam' > $OUTPUT/$TODAY-userspam.txt

cat $OUTPUT/$TODAY-userspam.txt | \
awk '{print $11}' | awk -F ':' '{print $1}' | sort | uniq -c | sort -n | \
awk '{$2=$2};1' | tr ' ' '/'
printf "$(date): Done.\n"
```

The output is will be saved to:

- `/usr/local/apache/htdocs/2017-02-09-mailboxspam.txt`
- `/usr/local/apache/htdocs/2017-02-09-userspam.txt`
