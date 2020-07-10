---
date: 2017-03-22
title: KL07 Drive Caddies
category: posts
---

Whilst I had every intention of fully completing this project before using it, I really wanted to play Cities Skylines again as I've been playing it on my Dell XPS 13 2016 until now and the Intel graphics processor isn't really up to the task.

The main problem with throwing the GPU in straight away was the clearance of the GPU with the hard drives at the front of the case - there simply was not enough room to accomodate the lengthy card and also have the 2 5-bay drive caddies in their current position. To deal with this I decided that I would create my own caddies, and repurpose the existing 'rails' that the caddies came with to hold the drives securely.

My intention is to model the caddies I need in SolidWorks and have them 3D printed out of a rigid plastic that will support the weight of 10x 3.5" hard drives. I'd estimate that a typical 3.5" drive weighs about 500 grams, so I'd need to design the caddie or bracket in such a way that it would be able to support up to 5Kg of load. It remains to be seen if that is even feasible or whether I'd need to reinforce the main load bearing elements with some threaded rods of some kind.

Either way not much of a problem, and one that we'll deal with when the time comes. In the meantime I need to create a prototype I can use the system and see how temperatures are with my i7 CPU, 980 GPU and 5x hard drives all running hot at the same time.

Enter *CD cases!*

Whilst it might be an odd choice for prototyping things of this nature, I've used this method before and it worked out brilliantly. The cases themselves are fairly study, but most importantly they're a standard size, with square edges and easily used to 'block out' shapes as needed.

This is what it looks like in version 1:

![Drive Caddy Prototype]({static}/images/unraid-hs5QFXMH.jpg)

You can see that I've used a mix of CD jewel cases with DVD cases to form a box, within which the edge of the GPU pokes into. The front of this box is open to the front of the case allowing for cool air to be pulled in direct to the GPU from the front of the case.

The top of this contraption provides a flat and level place that I was able to place the existing hard drive caddie on-top of - allowing me to use the original drive mounting mechanism for now, until I model my new version.

This new version will have a few advantages:

-   The drives will lie flat, allowing me to stack them vertically into a the cavity as I have more space that way than I do 'depth' wise as they're currently mounted.
-   The drives will be rotated 90 degrees, so that the SATA connections point toward me, allowing easier removal of drives without needing to remove the entire module itself.

Horizontally mounting and rotating the drives should allow me to run them in groups of twos, which will also allow more air to be passed over and above them to the rest of thes system - generally improving temperatures.

A crude drawing of my idea looks like this:

```
   TOP

========================
************** --- --- ‖
   MBOARD    * --- --- ‖[F]
             * --- --- ‖
GGGGGGGGGGGGGGGG       ‖        FRONT
             * --- --- ‖[F]
************** --- --- ‖
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯‖
  PSU   |   BASEMENT   ‖                       
========================

   BOTTOM

    Hard Drive: ---
    Fan: [F]
    GPU: GGGGG
```

I know that the distance between the leading edge of the top panel, and the 'basement' is 325mm so that is the amount of space I have to work with. Thankfully these drives are all standardised as well so I can predict the spacing of the drives.

Silverstone was kind enough to help me with the measurement of this case, even before I had purchased it - amazing support from a company that I totally didn't expect.

![Silverstone KL07 Gmail]({static}/images/unraid-nmcba97k.png)

I've purchased other cases from Silverstone in the past (FT-02, TJ-08E) and built in countless others as a system builder here in Melbourne and you won't find my systems in anything else. Nothing else on the market competes in terms of quality and price as far as I'm concerned.

Huge *thank you* to the SilverStone support team for their assistance with this.

I'm now going to proceed into SketchUp to do a proportionally correct and to scale render of the assembly and see how it fits. An average drive is at most 26.1mm (1 inch) high, 101.6mm (4 inches) wide and depth isn't a concern. The fans in that picture have been moved to the front, and they're 25mm thick providing me approximately 200mm of width to use.

The drives won't be flush with the case so clearance of the motherboard itself won't be a problem, but I don't really intend on having them overhang the motherboard by much if I can avoid it. Some quick maths before I start designing:

```
26.1mm x 5 = 130.5mm --- Height of 5 drives stacked
325mm - 130.5mm = 194.5mm --- 'Open air' above 5 drives stacked
194.5mm / 5 = 38.9mm --- The max spread available per drive
(38.9mm x 5) + (26.1mm x 5) = 325mm --- Double checking this equasion
```

Now I know that I have roughy 38.9mm per drive available to spread them out, but I also need to factor in the gap I want to leave for the GPU, running 6 drives above it and 4 below.

Off to SketchUp, check back later for a render and more measurements.