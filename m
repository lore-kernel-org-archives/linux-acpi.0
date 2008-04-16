From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 0/7] Differ generic vs vendor specific ACPI video support
Date: Wed, 16 Apr 2008 20:51:22 +0200
Message-ID: <1208371882.1784.340.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:42937 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbYDPSv1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2008 14:51:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, jwoithe@physics.adelaide.edu.au, Carlos Corbacho <carlos@strangeworlds.co.uk>, corentincj@iksaif.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Barnes, Jesse" <jesse.barnes@intel.com>, Egbert Eich <eich@suse.de>, Mattia Dongili <malattia@linux.it>, hong.liu@intel.com

Hi,

This series is to avoid the parallel usage of ACPI video functionality.
ACPI video functionality includes: brightness and video output
switching.

If generic functions are available, brightness and output switching
should be served by the video driver by default. This patch series
detects IGD capability of a plugged in graphics card, but does not
decide anything automatically on this (yet). To be found out whether
switching through vendor specific drivers still works then or whether
graphics driver can switch better (probably the latter, depending on the
driver...).

The user can override the default decision to let the video ACPI driver
handle brightness/display switching with a boot param:
acpi_video_by_vendor.
This should often work with osi="!Windows 2006" (then BIOSes often
switch to the legacy, XP supported SMI or int10 methods).

The patches are compile and "boot" tested only.
I checked that the acpi_get_physical_pci_device(..) function works that
early and had to move video device detection to a bit later point.

(I only added Egbert, Barnes and Hong to this mail, the patches
themselves shouldn't be that interesting for you, but this):
If the patch series gets accepted, I like to start another discussion
about an interface between ACPI and graphics card drivers or better
between the backlight interface and graphics card drivers.
AFAIK some graphics card drivers already tried to catch acpi hotkey
events, e.g. even IBM specific ones and tried to switch the
display/brightness themselves. Which I could imagine resulting in
(graphics card drivers) * (vendor specific) amount of implementations,
being more a workaround than a solution.

IMO there should be an easy switch (e.g. for graphics drivers to modify
at runtime) to decide whether ACPI should try to switch the brightness
or whether switching requests should be forwarded to the graphics
drivers. The only central place where this could work for all kind of
drivers that are involved into backlight switching, even for other archs
currently is drivers/video/backlight/backlight.c.
Do you think it's possible to e.g. give it a sysfs file and let graphics
drivers tell the backlight interface whether it can switch the
brightness and only let it generate a netlink (an ACPI independent)
event that brightness should be changed?
The same for the display output switching interface.
Hmm, theoretically you can give it a generic "notify graphics cards"
set_brightness/update_brightness call back function..., but it probably
can be designed better for above purpose... suggestions?

Instead of sending a netlink event directly, this could be an in-kernel
notification to a (in-kernel) graphics driver stub. Currently it may
just generate the netlink event and forward the request to the userspace
graphics driver, later the in-kernel graphics drivers can handle it
themselves.

Also there are some input interfaces to be considered:
  A) User explicitly requests a backlight change
  B) Hotkeys generate key codes
  C) Vendor specific (hotkey) ACPI devices get notified (the old way?)
  D) The generic graphics device gets notified (The Vista way or do 
     they finally go the keycode way or both?)

I wonder how B currently works, is it directly routed to X all done in
userspace (not telling /sys/.../backlight)? That would be bad. While I
am all for graphics drivers taking over control, we should think about
how this could all be pushed to be forwarded through one interface...

These are some ideas just made from scratch without knowing much about
the upcoming in-kernel graphics things..., more ideas are very welcome.

   Thomas

