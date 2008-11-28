From: Len Brown <lenb@kernel.org>
Subject: Re: [intel/acpi] backlight - T61
Date: Fri, 28 Nov 2008 14:18:54 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811281316390.3204@localhost.localdomain>
References: <1227854824.3477.9.camel@hidalgo>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:62782 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbYK1TTM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Nov 2008 14:19:12 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KB200IAI5NNB4ME@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 28 Nov 2008 13:19:00 -0600 (CST)
In-reply-to: <1227854824.3477.9.camel@hidalgo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: linux-acpi@vger.kernel.org, dri-devel@lists.sourceforge.net, jbarnes@virtuousgeek.org, Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Keith Packard <keithp@keithp.com>


On Fri, 28 Nov 2008, Yves-Alexis Perez wrote:

> I'm running linux 2.6.28-rc6-00007-ged31348 on my Thinkpad T61, with
> Intel GM965. Under X, brightness keys work fine most of the time, but in
> some case it fails (for example after a dpms force off, but not always).
> Switching to console and back to X fix the problem for a time.

How to you invoke DPMS?

I'm running the latest 2.6.28 on top of FC9, and I find that
if I use the hot keys to dim the screen all the way,
and then I'm idle for a period, the screen pretends to go black.
(X foolishly paits the pixels black, but keeps the backlight on)
Then when I touch the mouse to wake it up, my screen unlock
prompt is at full brightness, and so is my screen when I unlock.
So it seems that X forgot that I set the brightness.
(though clicking the brightness hotkey shows the widget still
 thinks I'm at minimum brightness, so that part remembered...)

Now the backlight is totally screwed up.
I use the hotkeys to get to minimum brightness,
but something thinks I'm still at maximum brightness,
because after some idle time, the screen all by itself
goes bright.

> Another weird stuff is that, in single user, I have no way to control
> the backlight. Using brightness key doesn't work,
> and /sys/class/backlight/acpi_video0 doesn't do anything.

There are actually two text consoles -- CTRL-ALT-F1 while X is running
and single-user mode.

The hot keys have never worked for either of these modes.

I would hope that X (i915) should be able to handle brightness
in CTRL-ALT-F1 mode the same way that it does in GUI mode,
but that doesn't seem to be working.

Then there is single-user-mode, where X never ran
and the i915 may not even be loaded...

We used to have /sys/class/backlight and /proc/acpi/video
available and they used to work in single-user mode
(as well as in CTRL-ALT-F1) mode.  This was due to
there being two video devices.  Unfortunately, we deleted
the one what works in this scenario.

Try this patch, which brings it back.

thanks,
-Len

>From d5b5f1bf810dcc87d5d6adb6efbaee8bff6d796c Mon Sep 17 00:00:00 2001
From: Len Brown <len.brown@intel.com>
Date: Fri, 28 Nov 2008 14:02:52 -0500
Subject: [PATCH] Partial revert "ACPI: video: Ignore devices that aren't present in hardware"
Organization: Intel Open Source Technology Center

22c13f9d8179f4c9caecfcb60a95214562b9addc
"ACPI: video: Ignore devices that aren't present in hardware"

caused the 2nd /proc/acpi/video
and /sys/firmware/backlight device to go away,
making software brightness control unavailable
in single-user-mode and X text-console-mode,
on a Thinkpad T61.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index baa4419..f930413 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -845,16 +845,10 @@ static void acpi_video_bus_find_cap(struct acpi_video_bus *video)
 static int acpi_video_bus_check(struct acpi_video_bus *video)
 {
 	acpi_status status = -ENOENT;
-	struct device *dev;
 
 	if (!video)
 		return -EINVAL;
 
-	dev = acpi_get_physical_pci_device(video->device->handle);
-	if (!dev)
-		return -ENODEV;
-	put_device(dev);
-
 	/* Since there is no HID, CID and so on for VGA driver, we have
 	 * to check well known required nodes.
 	 */
-- 
1.6.0.4.836.gd5cb



