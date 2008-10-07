From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: don't enable control method power button as wakeup
 device when Fixed Power button is used
Date: Mon, 06 Oct 2008 22:31:29 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810062231180.11053@localhost.localdomain>
References: <1221189145.3441.117.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172073pub.verizon.net ([206.46.172.73]:64472 "EHLO
	vms172073pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbYJGDbd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Oct 2008 23:31:33 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172073.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8C00COCKCK2VQ0@vms172073.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 06 Oct 2008 21:31:32 -0500 (CDT)
In-reply-to: <1221189145.3441.117.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, walken@zoy.org

applied to acpi-test.

thanks,
-len

On Fri, 12 Sep 2008, Zhang Rui wrote:

> don't enable control method power button as wakeup device
> when Fixed Power button is used.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=10503
> 
> 
> Tested-by: walken@zoy.org <walken@zoy.org>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/scan.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/scan.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/scan.c	2008-09-11 13:28:11.000000000 +0800
> +++ linux-2.6/drivers/acpi/scan.c	2008-09-11 15:12:12.000000000 +0800
> @@ -744,6 +744,16 @@
>  	if (!acpi_match_device_ids(device, button_device_ids))
>  		device->wakeup.flags.run_wake = 1;
>  
> +	/*
> +	 * Don't set Power button GPE as run_wake
> +	 * if Fixed Power button is used
> +	 */
> +	if (!strcmp(device->pnp.hardware_id, "PNP0C0C") &&
> +		!(acpi_gbl_FADT.flags & ACPI_FADT_POWER_BUTTON)) {
> +		device->wakeup.flags.run_wake = 0;
> +		device->wakeup.flags.valid = 0;
> +	}
> +
>        end:
>  	if (ACPI_FAILURE(status))
>  		device->flags.wake_capable = 0;
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
