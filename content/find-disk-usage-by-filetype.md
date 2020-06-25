---
date: 2012-04-06
title: "Find disk usage by file type"
category: posts
---

The script shown below will search all users files of a specific file type, and compute the total disk usage (in bytes) of each file type. The information is presented in a CSV that can be documented or achived for graphing.

The list of filetypes is drawn from a file referenced at the start of the script, edit this for your requirements.

```bash
#!/bin/bash

# Initialise filetypes list
today=`date +"%Y-%m-%d"`
filetypes=/scripts/filetypes
exclude=/scripts/excludedir
output=/usr/local/apache/htdocs/tools/"$today-computefiles.csv"

# Clear output before beginning
cat /dev/null > $output

# Begin looping through users
for user in `ls -A1 /home/`; do

# Begin looping through file types
for line in `cat $filetypes`; do \
printf $user/$line/ && find /home/$user/www/ -type f -name "*$line" -ls | \ 
awk '{total += $7} END {print total}'; \
done >> $output
done
sed -i '/\README_BEFORE/d' $output
sed -i '/\.cp/d' $output
sed -i '/\.jb/d' $output
sed -i '/cagefs-skeleton/d' $output
sed -i '/cPanelInstall/d' $output
sed -i '/cpmove-/d' $output
printf "Done.\n"
```

As per the previous script, the information is stored in the HTdocs folder of Apache.