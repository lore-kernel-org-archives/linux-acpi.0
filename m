From: Len Brown <lenb@kernel.org>
Subject: Re: acpi_battery_init() boot speed
Date: Wed, 15 Dec 2010 03:15:49 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012150314560.21167@x980>
References: <alpine.LFD.2.00.1012150308260.4878@x980>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56847 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab0LOIQF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Dec 2010 03:16:05 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LDG00ASJMYFNTI3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 15 Dec 2010 02:16:04 -0600 (CST)
In-reply-to: <alpine.LFD.2.00.1012150308260.4878@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-acpi@vger.kernel.org


On Wed, 15 Dec 2010, Len Brown wrote:

> Hi Arjan,
> I hoped that the test patch below would help acpi_battery_init()
> on machines where it runs a lot of AML.  I have a lenovo s10-3
> where it was taking 900ms, and this patch seemed to reduce
> it to 600ms.  However, I measured again and it seems to have
> gone _up_ to 1300ms - so perhaps there is some other factor
> determining how long that routine is taking?

Oh, I should mention that this was vs 2.6.36.stable
and measured by enabling "initcall_debug" and seeing how
long it took for the routine to return.  bootchart.pl
shows that acpi_battery_init is being done in an async thread.

> -Len
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 65b25a3..4658f61 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -271,7 +271,7 @@ acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
>  		/*
>  		* ioremap checks to ensure this is in reserved space
>  		*/
> -		return ioremap((unsigned long)phys, size);
> +		return ioremap_cache((unsigned long)phys, size);
>  	else
>  		return __acpi_map_table((unsigned long)phys, size);
>  }
> 
