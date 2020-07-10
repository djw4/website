---
date: 2019-01-17
title: Disable Mac OS dock animation
category: posts
---

Automatically hiding the Dock is one of the more useful features you can enable if you work on a Mac with limited screen space. That experience can be improved by removing the auto-hide delay from the Dock in OS X, which reduces the delay from when a mouse is hovered near the Dock to when it’s displayed.

Going one step further, you can remove the slide-in and slide-out animation all-together to make the hide/show process of the dock instantaneous.

To achieve this simply open a new terminal window, and paste in the following;

```
defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock
```

You can enable the dock hiding by right-clicking the dock separator as below.

![macos dock]({static}/images/mac-c98sfd3.jpg)

Your dock will close and re-open, and once you set 'Hiding' to on - the changes will become apparently immediately.
