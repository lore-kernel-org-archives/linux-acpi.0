From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH]: ACPI: Skip the first two elements in the _BCL package
Date: Tue, 3 Feb 2009 14:56:38 +0100
Message-ID: <200902031456.39680.trenn@suse.de>
References: <1233545621.3715.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:45237 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344AbZBCN4m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Feb 2009 08:56:42 -0500
In-Reply-To: <1233545621.3715.42.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, rui.zhang@intel.com

On Monday 02 February 2009 04:33:41 yakui_zhao wrote:
> Subject: ACPI: Skip the first two elements in the _BCL package
> From: Zhao Yakui <yakui.zhao@intel.com>
>    According to the Spec the first two elements in the _BCL package won't
> be regarded as the available brightness level. The first is the brightness
> when full power is connected to the box(It means that the AC adapter is
> plugged). The second is the brightness level when the box is on battery.
>     If the first two elements are still used while finding the next
> brightness level, it will fall back to the lowest level when keeping on
> pressing hotkey. (On some boxes the brightness will be changed twice when
> hotkey is pressed once. One is in the ACPI video driver. The other is
> changed by sys I/F. In the ACPI video driver the first two elements will be
> used while changing the brightness. But the first two elements is skipped
> while using sys I/F. In such case there exists the inconsistency).
>     So he first two elements had better be skipped while showing the
> available brightness or finding the next brightness level.
I remember that Rui pointed me to a brightness level list, which included
a value in AC/battery values which was not in the rest of the list.
I expect simply ignoring battery/AC values is not right.
I posted a patch a while ago which did:
  - Go through the brightness values and extract from all (including
    AC and battery) unique values
  - Sort them
  - Create a with the data a new list.
Not sure whether this would have worked, but something is still
missing. Currently we do not use battery/AC values, but what if we want
do that, e.g. exporting them to userspace?
Then trying to set them will fail.
We either need to consider AC/battery levels or we need to
take the closest level if it's not included in the list. I
expect the first is correct, otherwise it would be stupid from
the vendors to provide an AC/battery level which cannot be set.

I expect we still miss a little piece of Windows compatibility here ...

   Thomas


> http://bugzilla.kernel.org/show_bug.cgi?id=12450
>
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> cc: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/video.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Index: linux-2.6/drivers/acpi/video.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/video.c	2009-01-23 14:47:25.000000000 +0800
> +++ linux-2.6/drivers/acpi/video.c	2009-02-02 11:11:55.000000000 +0800
> @@ -1020,7 +1020,7 @@
>  	}
>
>  	seq_printf(seq, "levels: ");
> -	for (i = 0; i < dev->brightness->count; i++)
> +	for (i = 2; i < dev->brightness->count; i++)
>  		seq_printf(seq, " %d", dev->brightness->levels[i]);
>  	seq_printf(seq, "\ncurrent: %d\n", dev->brightness->curr);
>
> @@ -1059,7 +1059,7 @@
>  		return -EFAULT;
>
>  	/* validate through the list of available levels */
> -	for (i = 0; i < dev->brightness->count; i++)
> +	for (i = 2; i < dev->brightness->count; i++)
>  		if (level == dev->brightness->levels[i]) {
>  			if (ACPI_SUCCESS
>  			    (acpi_video_device_lcd_set_level(dev, level)))
> @@ -1712,7 +1712,7 @@
>  	max = max_below = 0;
>  	min = min_above = 255;
>  	/* Find closest level to level_current */
> -	for (i = 0; i < device->brightness->count; i++) {
> +	for (i = 2; i < device->brightness->count; i++) {
>  		l = device->brightness->levels[i];
>  		if (abs(l - level_current) < abs(delta)) {
>  			delta = l - level_current;
> @@ -1722,7 +1722,7 @@
>  	}
>  	/* Ajust level_current to closest available level */
>  	level_current += delta;
> -	for (i = 0; i < device->brightness->count; i++) {
> +	for (i = 2; i < device->brightness->count; i++) {
>  		l = device->brightness->levels[i];
>  		if (l < min)
>  			min = l;
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

