From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] ACPI thermal: Check for thermal zone requiremen
Date: Fri, 19 Feb 2010 01:39:43 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002190138310.24628@localhost.localdomain>
References: <1266357351-20224-1-git-send-email-trenn@suse.de>
 <1266357351-20224-2-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:34189 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622Ab0BSGjt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2010 01:39:49 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KY200BW8T679V54@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 19 Feb 2010 00:39:44 -0600 (CST)
In-reply-to: <1266357351-20224-2-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org

Thomas,

What good things happen after this patch that didn't happen before it?

thanks,
Len Brown, Intel Open Source Technology Center

On Tue, 16 Feb 2010, Thomas Renninger wrote:

> ACPI spec says (11.5 Thermal Zone Interface Requirements):
>    A thermal zone must contain at least one trip point
>    (critical, near critical, active, or passive)
> 
> Check this once at init time.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> Tested-by: clarkt@cnsp.com
> CC: Len Brown <lenb@kernel.org>
> CC: linux-acpi@vger.kernel.org
> ---
>  drivers/acpi/thermal.c |   18 +++++++++++++++++-
>  1 files changed, 17 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 8fa71b8..09b757a 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -577,7 +577,23 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>  
>  static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
>  {
> -	return acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
> +	int i, valid, ret = acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
> +
> +	if (ret)
> +		return ret;
> +
> +	valid = tz->trips.critical.flags.valid |
> +		tz->trips.hot.flags.valid |
> +		tz->trips.passive.flags.valid;
> +
> +	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
> +		valid |= tz->trips.active[i].flags.valid;
> +
> +	if (!valid) {
> +		printk(KERN_WARNING FW_BUG "No valid trip found\n");
> +		return -ENODEV;
> +	}
> +	return 0;
>  }
>  
>  static void acpi_thermal_check(void *data)
> -- 
> 1.6.3
> 
