From: Thomas Renninger <trenn@suse.de>
Subject: Re: [intel/acpi] backlight - T61
Date: Fri, 28 Nov 2008 23:38:22 +0100
Message-ID: <200811282338.24096.trenn@suse.de>
References: <1227854824.3477.9.camel@hidalgo> <alpine.LFD.2.00.0811281316390.3204@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:38548 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626AbYK1WiT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Nov 2008 17:38:19 -0500
In-Reply-To: <alpine.LFD.2.00.0811281316390.3204@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Yves-Alexis Perez <corsac@debian.org>, linux-acpi@vger.kernel.org, dri-devel@lists.sourceforge.net, jbarnes@virtuousgeek.org, Matthew Garrett <mjg@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Keith Packard <keithp@keithp.com>

On Friday 28 November 2008 08:18:54 pm Len Brown wrote:
> On Fri, 28 Nov 2008, Yves-Alexis Perez wrote:
> > I'm running linux 2.6.28-rc6-00007-ged31348 on my Thinkpad T61, with
> > Intel GM965. Under X, brightness keys work fine most of the time, but in
> > some case it fails (for example after a dpms force off, but not always).
> > Switching to console and back to X fix the problem for a time.
>
> How to you invoke DPMS?
>
> I'm running the latest 2.6.28 on top of FC9, and I find that
> if I use the hot keys to dim the screen all the way,
> and then I'm idle for a period, the screen pretends to go black.
> (X foolishly paits the pixels black, but keeps the backlight on)
> Then when I touch the mouse to wake it up, my screen unlock
> prompt is at full brightness, and so is my screen when I unlock.
> So it seems that X forgot that I set the brightness.
> (though clicking the brightness hotkey shows the widget still
>  thinks I'm at minimum brightness, so that part remembered...)
>
> Now the backlight is totally screwed up.
> I use the hotkeys to get to minimum brightness,
> but something thinks I'm still at maximum brightness,
> because after some idle time, the screen all by itself
> goes bright.
>
> > Another weird stuff is that, in single user, I have no way to control
> > the backlight. Using brightness key doesn't work,
> > and /sys/class/backlight/acpi_video0 doesn't do anything.
>
> There are actually two text consoles -- CTRL-ALT-F1 while X is running
> and single-user mode.
>
> The hot keys have never worked for either of these modes.
>
> I would hope that X (i915) should be able to handle brightness
> in CTRL-ALT-F1 mode the same way that it does in GUI mode,
> but that doesn't seem to be working.
>
> Then there is single-user-mode, where X never ran
> and the i915 may not even be loaded...
>
> We used to have /sys/class/backlight and /proc/acpi/video
> available and they used to work in single-user mode
> (as well as in CTRL-ALT-F1) mode.  This was due to
> there being two video devices.  Unfortunately, we deleted
> the one what works in this scenario.
>
> Try this patch, which brings it back.
No!!!
Not again.

It will work, but it is wrong.
You might poke on HW IO which is not there.

The latest ThinkPads and your T61, if you have the latest BIOS,
are known to work with IGD aka OpRegion support.

This is the code which should switch your backlight:
drivers/gpu/drm/i915/i915_opregion.c
and this is the spec describing how it should work:
http://intellinuxgraphics.org/ACPI_IGD_OpRegion_%20Spec.pdf

       Thomas

> thanks,
> -Len
>
> From d5b5f1bf810dcc87d5d6adb6efbaee8bff6d796c Mon Sep 17 00:00:00 2001
> From: Len Brown <len.brown@intel.com>
> Date: Fri, 28 Nov 2008 14:02:52 -0500
> Subject: [PATCH] Partial revert "ACPI: video: Ignore devices that aren't
> present in hardware" Organization: Intel Open Source Technology Center
>
> 22c13f9d8179f4c9caecfcb60a95214562b9addc
> "ACPI: video: Ignore devices that aren't present in hardware"
>
> caused the 2nd /proc/acpi/video
> and /sys/firmware/backlight device to go away,
> making software brightness control unavailable
> in single-user-mode and X text-console-mode,
> on a Thinkpad T61.
>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/video.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index baa4419..f930413 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -845,16 +845,10 @@ static void acpi_video_bus_find_cap(struct
> acpi_video_bus *video) static int acpi_video_bus_check(struct
> acpi_video_bus *video)
>  {
>  	acpi_status status = -ENOENT;
> -	struct device *dev;
>
>  	if (!video)
>  		return -EINVAL;
>
> -	dev = acpi_get_physical_pci_device(video->device->handle);
> -	if (!dev)
> -		return -ENODEV;
> -	put_device(dev);
> -
>  	/* Since there is no HID, CID and so on for VGA driver, we have
>  	 * to check well known required nodes.
>  	 */


