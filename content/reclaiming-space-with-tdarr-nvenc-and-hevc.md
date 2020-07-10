---
date: 2020-07-10
title: Reclaiming terrabytes with Tdarr, HEVC and NVENC on Unraid
category: posts
---

**Thursday, 02/07/2020**

Last weekend I was searching through my Plex server looking for something to watch and despite having several hundred movies on file, I couldn't find anything that I really felt like watching. Some days later I was performing some routine maintenance on the Unraid server and was reminded that I only had a mere 1.57TB remaining before I would need to purchase a new drive to expand the array (or upgrade an existing drive).

These two instances combined kick-started a thought in my head - _most of the movies in my collection I most likely will never watch again .. so why don't I just delete what I don't need?_

As a self-diagnosed digital hoarder this idea seemed a little extreme to me so I thought about other viable options and eventually settled on the idea of _reclaiming_ space on the array back by converting my media collection _en-masse_ HEVC (H265) to take advantage of the smaller file sizes. Once I have a reclaimed some space I will be able to remove any content that I really don't think I will ever need again (or can redownload if needed) and potentially avoid purchasing a new disk.

Today is Thursday and I've done some inital proof-of-concept work to determine if this is even feasible:

- I have 'finger printed' my media collection using the excellent [mediainfo](https://mediaarea.net/en/MediaInfo/Download) utility, generating a JSON output of every file I am considering transcoding (6TB+) - the list is not short, which makes for a lengthy report.

```
root@Tower:~# du -sh /mnt/user/multimedia/Movies/
6.1T  /mnt/user/multimedia/Movies/

root@Tower:~# find /mnt/user/multimedia/Movies/ -type f -size +500M | wc -l
617

root@Tower:~# mediainfo --Output=JSON --LogFile=movies.json /mnt/user/multimedia/Movies && wc -l movies.json
188462 movies.json
```

- I have also installed the [patched Unraid version](https://github.com/linuxserver/Unraid-Nvidia-Plugin) which enables support for Nvidia graphics cards.
- Lastly I have configured and tested the tdarr batch-processing container with great success. Using the excellent plugin [drdd_standardise_all_in_one](https://github.com/HaveAGitGat/Tdarr_Plugins/blob/master/Community/Tdarr_Plugin_drdd_standardise_all_in_one.js) with default settings, Tdarr was able to process a 16Gb file in just over 20 minutes, shrinking the file-size down to 8Gb and converting the file into a format that our Chromecast(s) will be able to direct stream from Plex without transcoding - nice.

My plan is simple: the tdarr plugin I am using has a variable that can be specified by the user to only transcode videos that have a higher bitrate than the threshold. I will use this to my advantage and start with a relatively high bitrate, processing only the largest 10% of movies to begin with and work my way down from there.

Note: Running more than one active transcode at one time has a neglible effect on the GPU:

```
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 440.59	  Driver Version: 440.59       CUDA Version: 10.2     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  GeForce GTX 980     Off  | 00000000:01:00.0 Off |                  N/A |
|  9%   63C    P2    67W / 185W |    685MiB /  4043MiB |     14%      Default |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|    0     10383      C   ...erver/assets/app/ffmpeg/ffmpeg42/ffmpeg   357MiB |
|    0     14754      C   ...erver/assets/app/ffmpeg/ffmpeg42/ffmpeg   313MiB |
+-----------------------------------------------------------------------------+
```

- - - -

**Monday, 06/07/2020**

So after all that I decided to just go for it, as I figured whatever breaks - I can fix and I'm happy to report that the results are really quite impressive.

I set tdar to run against my _entire_ collection of movies and after 3 days of continuous transcoding I have reclaimed nearly **1.5TB of disk space**. I did however need to patch the GPU using this [this script](https://github.com/keylase/nvidia-patch) due to the fact that there is a default maximum limit of 2 NVENC processes allowed, but this is easily dealt with.

This means that I have transcoded roughly 1/3 of my movies library, beginning with the largest and working down from there so the reclaimation will obviously taper off as the program encodes smaller and smaller files. I am still aiming for a 2TB of reclaimation though, this will leave ~3.5TB of free space on the array.

![tdarr stats page]({static}/images/reclaiming-space-with-tdarr-nvenc-and-hevc-2020-07-05_22-30-31.png)

![tdarr stats page]({static}/images/reclaiming-space-with-tdarr-nvenc-and-hevc-2020-07-05_22-30-41.png)


I'll leave this run for the rest of this week and see how things go and perhaps in a day or two bump up the number of simulteanous transcodes from 4 to 8 considering the files will be much smaller.

In the meantime however, this is exactly what I wanted to see (direct play for both the video and audio streams) - happy day.

![plex status page]({static}/images/reclaiming-space-with-tdarr-nvenc-and-hevc-2020-07-06_09-42-05.png)

- - - -

**Friday, 10/07/2020**

The transcode queue is finished (for now) and now we can have a look at the results.

![tdarr stats page]({static}/images/reclaiming-space-with-tdarr-nvenc-and-hevc-2020-07-10_10-32-42.png)

Out of a total of 616 files, 535 were transcoded to HEVC which in turn has reclaimed a whopping 2.76TB of space on the array!

```
root@Tower:~# du -sh /mnt/user/multimedia/Movies/
3.6T  /mnt/user/multimedia/Movies/
```