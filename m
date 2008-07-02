From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver
Date: Wed, 2 Jul 2008 11:19:19 +0100
Message-ID: <20080702101919.GB699@srcf.ucam.org>
References: <20080702090044.GB12272@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53734 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbYGBKTY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jul 2008 06:19:24 -0400
Content-Disposition: inline
In-Reply-To: <20080702090044.GB12272@prithivi.gnumonks.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>, hadi@cyberus.ca

On Wed, Jul 02, 2008 at 05:00:44PM +0800, Harald Welte wrote:

> * in order to fully support the backlight interface and get rid of the
>   clumsy separation of 'ac' (with power supply) and 'dc' (battery only) 
>   brightness settings, the driver would need to receive a notification
>   whenever the ACPI power supply status changes.  I know how to get to
>   that notification in userspace, but in kernelspace I'm not so sure.
>   Is there a notifier chain to which I can attach?

I don't think so, but it ought to be easy enough to glue into the 
power_supply class. The easiest thing for the moment is probably just to 
write values to both the ac and dc classes and let userspace handle the 
transition. If they're both in sync, it doesn't matter which you read 
back from.

> +/* This is transitional definition */
> +#ifndef KEY_BATT
> +# define KEY_BATT 227
> +#endif

Shouldn't be needed in-tree.

> +	const int key_map[] = {
> +		/*  0 */ -1,
> +		/*  1 */ KEY_BRIGHTNESSDOWN,
> +		/*  2 */ KEY_BRIGHTNESSUP,
> +		/*  3 */ KEY_DISPLAYTOGGLE,
> +		/*  4 */ KEY_MUTE,
> +		/*  5 */ KEY_VOLUMEDOWN,
> +		/*  6 */ KEY_VOLUMEUP,
> +		/*  7 */ KEY_SLEEP,
> +		/*  8 */ -1, /* Change CPU boost: do nothing */
> +		/*  9 */ KEY_BATT,
> +		/* 10 */ KEY_SUSPEND,
> +	};

Hm. Does this mean that the keymap isn't changable at runtime?

> +		if (acpi_pcc_hotkey_get_key(hotkey)) {
> +			/* generate event like '"pcc HKEY 00000080 00000084"'
> +			 * when Fn+F4 pressed */

Probably better not to add further events to /proc now - we'd like to 
deprecate the interface.

> +struct _proc_item {
> +	const char *name;
> +	struct file_operations fops;
> +	mode_t flag;
> +};

And shouldn't be adding any new files to /proc. Anything that can't be 
expressed via the existing generic sysfs classes should be an attribute 
on a sysfs platform device.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
