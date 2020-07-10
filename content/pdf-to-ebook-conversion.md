---
title: PDF to eBook Conversion
draft: false
date: 2012-04-06
category: posts
---

If you haven't yet discovered [humblebundle.com](https://www.humblebundle.com/) I would highly recommend that you do - as on this website you will discover that they publish 'bundles' of games and books which are often great deals when compared to buying these items individually. The bundles are updated quite frequently and sometimes they include 'comic' bundles.

I recently picked up one of these comic bundles - 'Humble Comics Bundle: Star Trek presented by IDW ' which gave me a the opportunity to download (legally purchased) copies of some really cool old comic books. I wasn't much of a comic book reader myself when I was younger, but I thought I might give these a go. I'm not overly interested in reading the comic books on my computer screen, for obvious reasons but instead I thought I might put these on my ereader instead. I am very lucky to have a [Kobo Aura H2O](https://us.kobobooks.com/products/kobo-aura-h2o-edition-2) in my possession and this seemed like a great choice - however there was one problem; the PDFs provided by Humble Bundle can exceed 2GB in size (yes that's right -- 2,000+MB per PDF). Obviously this would not do, because;

- A Kobo simply cannot _store_ a PDF that large.
- A Kobo additionally cannot _render_ a PDF of that size, even if it could be stored.

To fix this problem, I did some research and discovered [Ghostscript](https://www.ghostscript.com) -- an AGPL software suite that processes files in and out of _postscript_. You can download Ghostscript from their website [here](https://www.ghostscript.com/download/), but if you're on Mac or Linux you will already have it -- it's called `gs`. I discovered that I could use this software package to _dramatically_ shrink down the size of the PDFs that I wanted to read, so that they would fit on the Kobo ereader and also be capable of being displayed by the Kobo as well.

- - - -

Converting PDFs to PS (and back to PDF!)
----------------------------------------

The commands below will help you to shrink the size of any PDF, and optionally convert a full colour PDF to black-and-white (grayscale) which aids immensely in reducing file sizes. My Kobo can only display grayscale documents so removing any colour seems like a good idea. These commands should be universal to all platforms but you may need to mix-and-match to your requirements.

Here is the full command to take a full size colour PDF and convert it to grayscale, we'll call it **bw**:

```
gswin64c.exe -dBATCH -dNOPAUSE -dNOPROMPT -sDEVICE=pdfwrite -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray -dCompatibilityLevel=1.6 -sOutputFile="Star Trek Classics Vol. 5 Who Killed Captain Kirk bw.pdf" "Star Trek Classics Vol. 5 Who Killed Captain Kirk.pdf"
```

The commands break down as follows:

- `gswin64c.exe` : Your ghostscript binary, `gs` on Mac & Linux.
- `-dBATCH -dNOPAUSE -dNOPROMPT` : Do not prompt or pause when processing each page.
- `-sDEVICE=pdfwrite` : Write directly to a new PDF file.
- `-sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray` : Any colours are stripped out by this flag.
- `-dCompatibilityLevel=1.6` : PDF compatibility level based on Adobe's specifications.
- `-sOutputFile="..."` : The file that will be created
- `".."` : The input file

- - - -

Next we run the the PDF through another pass, this time reducing the compatibility level and dialing up the compression to shrink the PDF even further.

This time we'll feed in the PDF from the output of the last command -- we'll call this one **compressed**:

```
gswin64c.exe -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dBATCH  -dQUIET -sOutputFile="Star Trek Classics Vol. 5 Who Killed Captain Kirk bw-compressed.pdf" "Star Trek Classics Vol. 5 Who Killed Captain Kirk bw.pdf"
```

You will now end up with your original PDF with the filename 'bw-compressed' appended to it - but how much smaller is it?

- Original file-size: 2,569,993 KB (2.56 GB)
- Grayscale version (bw): 150,334 KB (150 MB)
- Grayscale compressed version (bw-compressed): **15,330 KB (15 MB)**

Note: That is a 99.40% decrease in file-size!

Now the PDF will load perfectly and you can read PDFs as much as you like on any lower-powered ereader.



