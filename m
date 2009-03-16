From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: unsigned cannot be less than 0.
Date: Sun, 15 Mar 2009 22:42:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903152242530.30317@localhost.localdomain>
References: <49AB0AA1.1090207@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:53946 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbZCPCnS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Mar 2009 22:43:18 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGK00I3CVJOP229@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Mar 2009 21:43:06 -0500 (CDT)
In-reply-to: <49AB0AA1.1090207@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: carlos@strangeworlds.co.uk, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

applied
thanks,
Len Brown, Intel Open Source Technology Center

On Sun, 1 Mar 2009, Roel Kluin wrote:

> include/linux/pci-acpi.h:74:
> typedef u32                 acpi_status;
> ------------------------------>8-------------8<---------------------------------
> result is unsigned, so an error returned by acpi_bus_register_driver() will not
> be noticed.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 8a8b377..2f269e1 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -708,7 +708,7 @@ static int __init acpi_wmi_add(struct acpi_device *device)
>  
>  static int __init acpi_wmi_init(void)
>  {
> -	acpi_status result;
> +	int result;
>  
>  	INIT_LIST_HEAD(&wmi_blocks.list);
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
