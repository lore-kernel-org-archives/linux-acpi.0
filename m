From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] drivers: acpi: fan.c move a dereference below the NULL test
Date: Fri, 19 Feb 2010 00:27:46 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002190026070.17638@localhost.localdomain>
References: <1265882202.27789.0.camel@ICE-BOX>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:58733 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab0BSF2I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2010 00:28:08 -0500
In-reply-to: <1265882202.27789.0.camel@ICE-BOX>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Jenkins <darrenrjenkins@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Thomas Renninger <trenn@suse.de>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Janitors <kernel-janitors@vger.kernel.org>

I think think this is a run-time check for a programming error,
and the current fashion is to delete the check and take a fault
if this happens so the caller can be fixed.

There are a couple of checks like this in fan.c --
perhaps Rui can clean them up when he comes back next week.

thanks,
Len Brown, Intel Open Source Technology Center

On Thu, 11 Feb 2010, Darren Jenkins wrote:

> In acpi_fan_remove() device is being dereferenced before the NULL test.
> This reorders the code to ensure it is checked for NULL first.
> 
> Coverity CID: 2758
> 
> Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>
> ---
>  drivers/acpi/fan.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index acf2ab2..dc39640 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -298,9 +298,14 @@ static int acpi_fan_add(struct acpi_device *device)
>  
>  static int acpi_fan_remove(struct acpi_device *device, int type)
>  {
> -	struct thermal_cooling_device *cdev = acpi_driver_data(device);
> +	struct thermal_cooling_device *cdev;
> +
> +	if (!device)
> +		return -EINVAL;
> +
> +	cdev = acpi_driver_data(device);
>  
> -	if (!device || !cdev)
> +	if (!cdev)
>  		return -EINVAL;
>  
>  	acpi_fan_remove_fs(device);
> -- 
> 1.6.3.3
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
