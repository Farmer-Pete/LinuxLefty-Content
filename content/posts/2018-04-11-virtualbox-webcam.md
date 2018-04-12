+++
title = "Enabling a Webcam in Virtualbox (Windows Client / Linux Host)"
slug = "enabling-webcam-virtualbox-windows-linux"
date = 2018-04-11
draft = false
toc = false
categories = ["Geek"]
tags = ["virtualbox", "Linux", "Windows"]
#images = ["/images/posts/2018-04-07-home-depot.jpg"]
+++

This is a quick post to document something rather simple, but something that took me a while to figure out. Hopefully it will save someone some time :)

Firstly, all of this was gleaned from the VirtualBox documentation, specificailly {{<a "the chapter on VBoxManage" "https://www.virtualbox.org/manual/ch08.html">}}.

To list the webcams that are installed on the system and available to VirtualBox, use the command: `VBoxManage list webcams`. Here is some sample output from my laptop

```
$> VBoxManage list webcams
Video Input Devices: 1
.1 "Integrated Camera: Integrated C"
/dev/video0
```

Take the path to the webcam, along with the name of the VirtualBox image, and use the command `VBoxManage controlvm <Image_Name> webcam attach <Webcam_Path>`. For me the command is:

```
$> VBoxManage controlvm Windows7 webcam attach /dev/video0
```

Finally, you can verify that the webcam attachment was sucessful by using the command `VBoxManage controlvm <Image_Name> webcam list`, like this:

```
$> VBoxManage controlvm Windows7 webcam list
/dev/video0
```

I hope that helps!
