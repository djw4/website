---
date: 2012-04-06
title: "Mass download from wallhaven"
category: posts
---

I'm experimenting with creating spiders to crawl web pages and download content however in the mean time I thought I'd experiment with rudimentary bash tools to try and accomplish the same task.

The script below will run through a number sequence of 1 to 999999 to append to the download link `<https://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-___.jpg>` and try to download the file.

```bash
#!/bin/bash
# Scrape wallhaver.cc images
printf 'Hit [CTRL+C] to stop!\n\n'

for i in $(seq -f "%g" 1 999999) do 
wget https://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-$i.jpg 
done
```