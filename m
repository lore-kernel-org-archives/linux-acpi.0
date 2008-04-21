From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/7] Differ generic vs vendor specific ACPI video
	support
Date: Mon, 21 Apr 2008 11:14:15 +0800
Message-ID: <1208747655.2925.63.camel@rzhang.sh.intel.com>
References: <1208371882.1784.340.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55571 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754288AbYDUDPd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Apr 2008 23:15:33 -0400
In-Reply-To: <1208371882.1784.340.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, jwoithe@physics.adelaide.edu.au, Carlos Corbacho <carlos@strangeworlds.co.uk>, corentincj@iksaif.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Barnes, Jesse" <jesse.barnes@intel.com>, Egbert Eich <eich@suse.de>, Mattia Dongili <malattia@linux.it>, "Liu, Hong" <hong.liu@intel.com>

Hi, thomas,

On Thu, 2008-04-17 at 02:51 +0800, Thomas Renninger wrote:
> Hi,
> 
> This series is to avoid the parallel usage of ACPI video
> functionality.
> ACPI video functionality includes: brightness and video output
> switching.
> 
> If generic functions are available, brightness and output switching
> should be served by the video driver by default. This patch series
> detects IGD capability of a plugged in graphics card, but does not
> decide anything automatically on this (yet). To be found out whether
> switching through vendor specific drivers still works then or whether
> graphics driver can switch better (probably the latter, depending on
> the
> driver...).
Unlike the brightness switching, video output switching via ACPI video
driver seldom works.
This is not a problem for IGD video devices.
But for the non-IGD devices, we probably still need the help of vendor
specific drivers.

> The user can override the default decision to let the video ACPI
> driver
> handle brightness/display switching with a boot param:
> acpi_video_by_vendor.
> This should often work with osi="!Windows 2006" (then BIOSes often
> switch to the legacy, XP supported SMI or int10 methods).
> 
> The patches are compile and "boot" tested only.
> I checked that the acpi_get_physical_pci_device(..) function works
> that
> early and had to move video device detection to a bit later point.
> 
> (I only added Egbert, Barnes and Hong to this mail, the patches
> themselves shouldn't be that interesting for you, but this):
> If the patch series gets accepted, I like to start another discussion
> about an interface between ACPI and graphics card drivers or better
> between the backlight interface and graphics card drivers.
> AFAIK some graphics card drivers already tried to catch acpi hotkey
> events, e.g. even IBM specific ones and tried to switch the
> display/brightness themselves. Which I could imagine resulting in
> (graphics card drivers) * (vendor specific) amount of implementations,
> being more a workaround than a solution.
> 
> IMO there should be an easy switch (e.g. for graphics drivers to
> modify
> at runtime) to decide whether ACPI should try to switch the brightness
> or whether switching requests should be forwarded to the graphics
> drivers.
That's what brightness_switch_enabled in ACPI video driver designed
for. :)

>  The only central place where this could work for all kind of
> drivers that are involved into backlight switching, even for other
> archs
> currently is drivers/video/backlight/backlight.c.

> Do you think it's possible to e.g. give it a sysfs file and let
> graphics
> drivers tell the backlight interface whether it can switch the
> brightness and only let it generate a netlink (an ACPI independent)
> event that brightness should be changed?
Do you want a more generic I/F under /sys/class/backlight/... here?

> The same for the display output switching interface.
> Hmm, theoretically you can give it a generic "notify graphics cards"
> set_brightness/update_brightness call back function..., but it
> probably
> can be designed better for above purpose... suggestions?
Hmm, it seems that we need a lot of changes in backlight sysfs driver.

Video backlight driver needs to export another interface, something like
video_update_brightness.
And in ACPI case, this is called by ACPI video driver when there is an
ACPI video brightness switch event.
And the video backlight driver should be able the change the brightness
automatically, if the brightness switch flag is not cleared.

> Instead of sending a netlink event directly, this could be an
> in-kernel
> notification to a (in-kernel) graphics driver stub. Currently it may
> just generate the netlink event and forward the request to the
> userspace
> graphics driver, later the in-kernel graphics drivers can handle it
> themselves.
Acpi has set up a notifier chain, so that graphics driver can be
notified for hotkey events.

Do you mean to move all this kind of stuff to the backlight sysfs
driver, in order to make it more generic?
> 
> Also there are some input interfaces to be considered:
>   A) User explicitly requests a backlight change
>   B) Hotkeys generate key codes
>   C) Vendor specific (hotkey) ACPI devices get notified (the old way?)
>   D) The generic graphics device gets notified (The Vista way or do
>      they finally go the keycode way or both?)
> 
> I wonder how B currently works,
> is it directly routed to X all done in
> userspace (not telling /sys/.../backlight)? That would be bad.

>  While I
> am all for graphics drivers taking over control, we should think about
> how this could all be pushed to be forwarded through one interface...
> 
> These are some ideas just made from scratch without knowing much about
> the upcoming in-kernel graphics things..., more ideas are very
> welcome.
Thomas,
I'm not sure if I understand this email correctly, but I think a generic
backlight solution is reasonable.
Following are just some of my thoughts,

1. All drivers that support backlight switching should be registered
with the generic brightness switching driver (the current backlight
sysfs driver).
2. all the current callbacks are kept to build the backlight sysfs I/F.
3. create a new callback video_update_brightness(, int type)
the value of "type" should be one of {up, down, max, min,...}
4. ACPI video driver and other platform specific driver should call
video_update_brightness to notify the generic brightness switching
driver to update the brightness levels.
5. create a new file "mode" for backlight switching control.
"mode" should be one of "kernel"/"user"/...
6. create a notifier chain for kernel users and be able to notify user
space(input layer/netlink/...)
7. when video_update_brightness is called, the generic brightness driver
should check the value of "mode", and
	a) if in "user" mode, do nothing but export a netlink events
	   and call the brightness notifier chain.
	b) if in "kernel" mode, check the parameter type,
	   calculate the next brightness level,
	   call video_set_brightness to update the backlight.
	c) ...

with this solution, no matter the brightness switch follows the ACPI
video extension or vendor specific methods, both userspace and other
kernel drivers only need to communicate with the generic brightness
switching driver.
these are just some thoughts that come to my mind when reading this
email. I know this needs a lot of changes and I'm not sure if this is
worth doing. Any comments are welcome. :)

thanks,
rui

