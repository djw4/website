---
date: 2016-11-21
title: Cracking WPA/WPA2 Hashes using GPUs
category: posts
---

Cracking WPA/WPA2 Hashes using GPUs

Recently I have been investigating the most effective way to crack WPA passkeys, and I wanted to know - what is the most cost effective method for hashing the key; purchasing a GPU(s) or using a cloud based service such as AWS.

I first began by capturing the 4-way handshake from the target AP using Kali Linux and `airmon-ng`, and stored this on my computer. I performed my baseline crack using a conventional system with the following specifications:

* Windows 10 Pro
* GeForce GTX 980 (4GB Memory, 2048 CUDA cores, ~1100Mhz clock without boost)
* Intel 4770k @ 4.4GHz
* 16GB RAM

Using hashcat as my hash cracking software, the crack was successful using a brute-force keyspace attack with an approximate cracking time of 12 hours, and an actual cracking time of approximately 3 hours.

The computer was able to sustain approximately 220kH/s.

- GTX 980 - 2048 CUDA Cores
  - ~$500 purchase price
- GTX 980Ti - 2816 CUDA Cores
  - ~$1000 purchase price
- GTX 1080 - 2560 CUDA Cores
  - ~$800 purchase price
- GTX Titan X - 3072 CUDA Cores
  - ~1600 purchase price
- AWS g2.8xlarge EC2 - 6144 CUDA Cores (4x 1536)
  - ~$31 for 12 hours, ~$1900 per month

Using the approximate recommend retail value of the cards I’ve listed above, it seems that the GTX 980 is perfectly positioned as the best ‘bang for buck’ card I’ve investigated, with other newer cards not providing enough of an increase in performance in this application to offset their significantly more expensive cost.

A second alternative would be using a server from AWS in the g2.8xlarge combination to perform incidental cracks, but in this case the job would have cost approximately $31AUD it’s up to the user to decide whether that is worthwhile or not.