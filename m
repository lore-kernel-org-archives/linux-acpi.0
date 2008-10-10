From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: acpi_driver_data could only be applied to acpi_device
Date: Fri, 10 Oct 2008 12:24:34 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810101224270.3131@localhost.localdomain>
References: <20080910103342.20391.81647.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172073pub.verizon.net ([206.46.172.73]:54811 "EHLO
	vms172073pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761729AbYJJQYh (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 10 Oct 2008 12:24:37 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172073.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8J00FLL6X0YMD4@vms172073.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Fri, 10 Oct 2008 11:24:36 -0500 (CDT)
In-reply-to: <20080910103342.20391.81647.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

applied.

thanks,
-len

On Wed, 10 Sep 2008, Alexey Starikovskiy wrote:

> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> CC: Hannes Reinecke <hare@suse.de>
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/scan.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index f6f52c1..e7b8853 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -384,7 +384,7 @@ static int acpi_device_remove(struct device * dev)
>  			acpi_drv->ops.remove(acpi_dev, acpi_dev->removal_type);
>  	}
>  	acpi_dev->driver = NULL;
> -	acpi_driver_data(dev) = NULL;
> +	acpi_driver_data(acpi_dev) = NULL;
>  
>  	put_device(dev);
>  	return 0;
> 
