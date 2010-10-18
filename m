From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] acpi: remove dead code
Date: Mon, 18 Oct 2010 12:49:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010181239110.2932@localhost.localdomain>
References: <20101018084248.23262ba6@nehalam>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:64143 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757446Ab0JRQuP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Oct 2010 12:50:15 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAH00F1ZW3DMJI0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 18 Oct 2010 11:50:14 -0500 (CDT)
In-reply-to: <20101018084248.23262ba6@nehalam>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: linux-acpi@vger.kernel.org

On Mon, 18 Oct 2010, Stephen Hemminger wrote:

> Found by running make namespacecheck on linux-next
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
> 
> --- a/drivers/acpi/osl.c	2010-10-06 13:42:58.722974685 +0900
...
>  /*
> - * Allocate the memory for a spinlock and initialize it.
> - */
> -acpi_status acpi_os_create_lock(acpi_spinlock * handle)
> -{
> -	spin_lock_init(*handle);
> -
> -	return AE_OK;
> -}

ACPICA declares acpi_os_create_lock in acpiosxf.h,
but never calls it.  Bob, can we do away with it?

...
> -int acpi_check_mem_region(resource_size_t start, resource_size_t n,
> -		      const char *name)
> -{
> -	struct resource res = {
> -		.start = start,
> -		.end   = start + n - 1,
> -		.name  = name,
> -		.flags = IORESOURCE_MEM,
> -	};
> -
> -	return acpi_check_resource_conflict(&res);
> -
> -}
> -EXPORT_SYMBOL(acpi_check_mem_region);

acpi_check_mem_region seems to be entirely
a Linux thing.  It is exported to modules -- though
see any that use it.

> --- a/drivers/acpi/processor_driver.c	2010-10-06 13:46:52.594978592 +0900
...
> -EXPORT_SYMBOL(acpi_processor_set_thermal_limit);
...
> --- a/drivers/acpi/processor_thermal.c	2010-10-06 13:47:23.469979232 +0900
...
> -int acpi_processor_set_thermal_limit(acpi_handle handle, int type)
> -{

although acpi_processor_set_thermal_limit() is exported to modules
I don't see any users in recent history.


thanks,
-Len Brown, Intel Open Source Technology Center


