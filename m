From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Recent Lenovo ThinkPads define a dummy grahpics
	device, find it and ignore it
Date: Fri, 07 Dec 2007 16:27:52 +0100
Message-ID: <1197041272.28990.188.camel@queen.suse.de>
References: <1197032113.28990.155.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:41622 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbXLGP1y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Dec 2007 10:27:54 -0500
In-Reply-To: <1197032113.28990.155.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>

On Fri, 2007-12-07 at 13:55 +0100, Thomas Renninger wrote:
> Hi Matthew,
> 
> I posted this one already and you had some concerns about it:
> http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg09510.html
> 
> IMO, this one should still be added to -mm, because:
>   - The patch itself is correct, it is the function that is called
>     that must make sure to return the corresponding pci device
> 
>   - There currently is a bug: Lenovos will register a device for which
>     no physical device exists.
>     
>   - That means on these machines HW is addressed/poked
>     which does not exist -> danger.
> 
>   - There is no other way to fix up acpi_get_physical_device, than to
>     just do this change (at least I don't see it). People have to
>     complain that their device is not found (the message they see in
>     dmesg is obvious).
>     Then we can make acpi_get_physical_device more robust, which will
>     come out as a benefit for other functionality too sooner or later to
>     be able to rely on getting struct pci in the video (and possibly
>     other) driver(s).

I forgot to mention, that not only Lenovos are affected.
I tested this on an HP Compaq 6715b and the video device is still found.
I also tested this on a Toshiba Satellite A210 and there the patch is
also mandatory!

There two VGA devices are declared, which results in /proc/acpi/video
showing *two* "VGA" device entries in the same proc directory.
Here the hack (drivers/acpi/video.c):
        /* a hack to fix the duplicate name "VID" problem on T61 */
        if (!strcmp(device->pnp.bus_id, "VID")) {
                if (instance)
                        device->pnp.bus_id[3] = '0' + instance;
                instance ++;
        }
which was written for duplicated Lenovo devices (where BIOS names the
graphics device "VID") does not help.
Brightness switching is broken there without this patch and works fine
with it.

Please add it to mm.
Is that ok with you, Matthew?

    Thomas

> What do you think?
> 
> ---------------
> 
> 
> Recent Lenovo ThinkPads define a dummy grahpics device, find it and ignore it
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> 
> ---
>  drivers/acpi/video.c |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/video.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/video.c
> +++ linux-2.6/drivers/acpi/video.c
> @@ -35,6 +35,7 @@
>  #include <linux/input.h>
>  #include <linux/backlight.h>
>  #include <linux/video_output.h>
> +#include <linux/acpi.h>
>  #include <asm/uaccess.h>
>  
>  #include <acpi/acpi_bus.h>
> @@ -1896,6 +1897,21 @@ static int acpi_video_bus_add(struct acp
>  	struct acpi_video_bus *video;
>  	struct input_dev *input;
>  	int error;
> +	struct device *dev;
> +
> +
> +	/*
> +	 *	Check whether we have really  a graphics device physically
> +	 *      in the slot and registered at the system.
> +	 */
> +	dev = acpi_get_physical_device(device->handle);
> +	if (!dev) {
> +		printk (KERN_DEBUG PREFIX "Video device %s.%s not physically"
> +			" connected, ignoring\n", acpi_device_bid(device),
> +			device->parent ? acpi_device_bid(device->parent) : "");
> +		return -ENODEV;
> +	}
> +	put_device(dev);
>  
>  	video = kzalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);
>  	if (!video)
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

