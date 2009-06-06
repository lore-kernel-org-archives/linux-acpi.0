From: Len Brown <lenb@kernel.org>
Subject: Re: [Resend] [PATCH]: ACPI: Rename ACPI processor device bus ID
Date: Fri, 05 Jun 2009 21:51:40 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906052150040.5039@localhost.localdomain>
References: <1243737111.3634.168.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:36738 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbZFFBvz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jun 2009 21:51:55 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKS00GPZNU5Y4U9@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 05 Jun 2009 20:51:47 -0500 (CDT)
In-reply-to: <1243737111.3634.168.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

We've promised to delete /proc/acpi instead of enhance it,
so i'd rather see a patch that ignores errors from procfs
and registers the driver even when procfs fails.

thanks,
Len Brown, Intel Open Source Technology Center

On Sun, 31 May 2009, yakui_zhao wrote:

> From: Zhao Yakui <yakui.zhao@intel.com
> 
> On some boxes several processors use the same processor bus id.
> But they are located in different scope. For example:
> 	\_SB.SCK0.CPU0
> 	\_SB.SCK1.CPU0
> 	As they use the same bus id, it can't be registered when
> registering proc I/F. It causes that the ACPI processor driver can't
> be bound with the processor device.
> 	
> Rename the processor device bus id. And the new bus id will be 
> generated as the following format:
> 	CPU+ CPU ID
> 	
> For example: If the cpu ID is 5, then the bus ID will be "CPU5".
> 	If the CPU ID is 10, then the bus ID will be "CPUA".
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
>  drivers/acpi/processor_core.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/acpi/processor_core.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/processor_core.c	2009-05-27 08:38:44.000000000 +0800
> +++ linux-2.6/drivers/acpi/processor_core.c	2009-05-31 10:21:21.000000000 +0800
> @@ -649,7 +649,16 @@
>  			return -ENODEV;
>  		}
>  	}
> -
> +	/*
> +	 * On some boxes several processors use the same processor bus id.
> +	 * But they are located in different scope. For example:
> +	 * \_SB.SCK0.CPU0
> +	 * \_SB.SCK1.CPU0
> +	 * Rename the processor device bus id. And the new bus id will be
> +	 * generated as the following format:
> +	 * CPU+CPU ID.
> +	 */
> +	sprintf(acpi_device_bid(device), "CPU%X", pr->id);
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Processor [%d:%d]\n", pr->id,
>  			  pr->acpi_id));
>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
