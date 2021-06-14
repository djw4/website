---
date: 2017-03-06
title: Silverstone KL07 NAS Conversion
category: posts
---

### UNraid

Part of my role as a systems engineer involves the day to day maintenance of our backup systems, which as we're a VMware shop mostly revolve around the Veeam Availability Suite (Backup & Replication in particular). Whilst fantastic in an enterprise setting, this kind of software package is not very well suited (see; not at all) for a home user. Instead over the last few years I've been continuously improving my home server to be more in line with my own personal needs.

I've run Raspberry Pi NAS's of various configurations, FreeNAS on comodity hardware and more recently a QNAP TS-412. Whilst all of these options are good for 'file serving' they do not really provide the kind of features or capability that I'd like for a home user.

My needs are a little more specific:

-   Support for VM and/or docker (preferably both).
-   Ability to use high-powered CPUs (I'm using an Intel 4790k
    overclocked to 4.5Ghz).
-   Flexible operation regarding storage devices.
    -   Quick and easy rebuilding of the array when replacing a failed
        disk.
    -   Not being locked into a proprietry conventional 'RAID'
        configuration.
    -   Seamless upgrading with new disks.
    -   Support for SSD storage and caching.

After many different iterations I've finally settled on [UNraid](https://lime-technology.com/) and I can safely say I don't think I'll be looking at anything else as it perfectly suits my needs. The advantages of UNraid over a conventional 'NAS' are long, but here's the highlights:

-   Use your own desktop or server-grade hardware - it doesn't care.
-   Support for VMs using KVM and docker is fantastic and easy to use.
-   Device pass through to VMs and docker containers (any PCIe device
    including a GPU, USB devices, etc).

<<<<<<< HEAD:content/posts/silverstone-kl07-nas-conversion.md
![Unraid Dashboard](/img/unraid-f9979514.jpg)
=======
![Unraid Dashboard]({static}/images/unraid-f9979514.jpg)
>>>>>>> master:content/silverstone-kl07-nas-conversion.md

You can see above that the interface for UNraid is nice and clean, and partitioned into sections such as 'Apps' (VMs and docker containers), statistics, partity status, etc. Other pages show you more specific information the array and how it's functioning, whilst also providing controls for stopping and starting the array amongst other things. I urge you to download the software and try it out - you won't be disappointed.

Yes it's [paid software](https://lime-technology.com/pricing/) but the 30 day trial is great and provides you enough time to get to grips with it, and determine whethe it would work for you.

### Silverstone KL07

The second main part to this setup is the case, that being the recently released [Silverstone
KL07](http://www.silverstonetek.com/product.php?area=en&pid=680). Whilst not initially billed as a 'server case' it is remarkably well set up out of the box for this purpose and I haven't yet figured out why more people aren't using the case for their home servers. Advantages include:

<<<<<<< HEAD:content/posts/silverstone-kl07-nas-conversion.md
![KL07 Front](/img/b490e258-kl07-1.jpg)
=======
![KL07 Front]({static}/images/b490e258-kl07-1.jpg)
>>>>>>> master:content/silverstone-kl07-nas-conversion.md

-   Factory fitted noise dampening foam.
-   No window at all (plus or minus depending on your taste).
-   Very easy to build in, with huge amount of space for cables.
-   Plenty of space towards the front of the case for getting creative
    (more on that later).

Whilst the 3 included hard drive bays and 3 SSD mounting points are appreciated and sufficient for most, I need more options for securing drives (10 at a minimum is my aim). Mounting 10 3.5" hard drives inside the case would require me to fashion my own mounting mechanisms, and luckily there is plenty of open space in the front of the case to do this - it would just require a bit of creativity.

My first go was using these [5-in-3 caddies](https://www.aliexpress.com/item/5-25-to-3-5-SATA-SAS-HDD-Hard-Drive-Cage-Adapter-Tray-Caddy-Rack-Bracket/1993113502.html) from AliExpress and they seemed to work OK however I did run into problems with securing them to the front of the case. I had initially thought that I could secure the caddies to the front of the case where the fan mounts are, which is also used to mount any watercooling radiators in a convential gaming build. This worked but due to the weight of the caddies when fully loaded with drives (approximately 5KG), this realistcally wasn't an option as the thin metal simply wasn't up to task for this purpose (unsurprisingly). To combat this and get the system running I still used those caddies and connected them as described, but I then used CD jewel cases stacked 2 or 3 high to 'shim' the caddies so that they would rest most of their weight on the PSU basement which is plenty strong.

Whilst acceptable in it's current form, it does not let me insert a GPU as the 2 caddies are so close together that they would conflict with the end of my GPU (meaning Steam in-house streaming is off the table for now).

Note: I've now decided to fashion my own caddies and model them in CAD specifically to fit the mounting holes on the motherboard, whilst leaving the space open in the design that I can slot a GPU in between. Check back soon for an update.

So it's done - for now.

I got a tired of waiting for enough free time where I could sink a few hours into SolidWorks and come up with a solution that best suited my needs, so I turned to my favourite prototyping method to get the job done - CD jewel cases and duct tape. If you haven't used these for prototyping then you should definitely give it a go.


10/03/2018
----------

I did some small updates on the server today, mainly switching out my previous 4-port LSI HBA for an 8-port of the same make that I purchased second hand on the [OCAU Forums](https://forums.overclockers.com.au/). Whilst the case was open I took the opportunity to give the cables at the front a bit of a tidy and take a few snaps.

I have dispensed with the CD & DVD drive 'ledge' mechanism to clean things up a bit, and I was able to fit the existing hard drive cage I was using into the space infront of my EVGA GTX 980 when rotated 90 degreess. 

Everything went very smoothly, and I'm pretty happy with the results.

![internal image](https://i.imgur.com/TAoMvg4l.jpg)
![internal image](https://i.imgur.com/yRVGjVfl.jpg)
![internal image](https://i.imgur.com/ZCkjuMAl.jpg)
