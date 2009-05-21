From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]: ACPI: Change the array size from 5 to 8 for acpi_bus_id
Date: Thu, 21 May 2009 14:26:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905211425390.4390@localhost.localdomain>
References: <1242894335.8523.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:9208 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbZEUS0p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 May 2009 14:26:45 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KK000AROB89OR20@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 21 May 2009 13:26:34 -0500 (CDT)
In-reply-to: <1242894335.8523.61.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

what bad things happen if this patch is not applied --
do some of those strcpy()'s overflow?

what good things happen if it is applied?

are you just eating up the padding because it is there?

thanks,
Len Brown, Intel Open Source Technology Center

On Thu, 21 May 2009, yakui_zhao wrote:

> From: Zhao Yakui <yaui.zhao@intel.com>
> 
> In fact the following three bytes can't be used when the following data
> type is unsigned long or unsigned long long.
> 
> Change the array size from 5 to 8 for the acpi_bus_id.
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
>  include/acpi/acpi_bus.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-2.6.orig/include/acpi/acpi_bus.h	2009-04-20 09:13:42.000000000 +0800
> +++ linux-2.6/include/acpi/acpi_bus.h	2009-05-21 16:18:25.000000000 +0800
> @@ -168,7 +168,7 @@
>  
>  /* Plug and Play */
>  
> -typedef char acpi_bus_id[5];
> +typedef char acpi_bus_id[8];
>  typedef unsigned long acpi_bus_address;
>  typedef char acpi_hardware_id[15];
>  typedef char acpi_unique_id[9];
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
