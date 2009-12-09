From: Len Brown <lenb@kernel.org>
Subject: Re: [patch] move null check earlier
Date: Wed, 09 Dec 2009 15:39:43 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912091539130.24891@localhost.localdomain>
References: <alpine.DEB.2.00.0911081929420.10055@bicker>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47265 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757779AbZLIUjm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 15:39:42 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUE00A9JK289KI2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 09 Dec 2009 14:39:45 -0600 (CST)
In-reply-to: <alpine.DEB.2.00.0911081929420.10055@bicker>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: linux-acpi@vger.kernel.org

Julia's patch to fix this shipped in Linux-2.6.32-rc7

cheers,
Len Brown, Intel Open Source Technology Center

On Tue, 10 Nov 2009, Dan Carpenter wrote:

> I moved the null dereference after the check.  It is unlikely to make any 
> difference, but it's the right thing to do and it makes my static checker 
> happy.
> 
> regards,
> dan carpenter
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> --- orig/drivers/acpi/processor_throttling.c	2009-11-08 19:26:09.000000000 +0200
> +++ devel/drivers/acpi/processor_throttling.c	2009-11-08 19:27:10.000000000 +0200
> @@ -1133,15 +1133,15 @@
>  	int result = 0;
>  	struct acpi_processor_throttling *pthrottling;
>  
> +	if (!pr)
> +		return -EINVAL;
> +
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  			  "pblk_address[0x%08x] duty_offset[%d] duty_width[%d]\n",
>  			  pr->throttling.address,
>  			  pr->throttling.duty_offset,
>  			  pr->throttling.duty_width));
>  
> -	if (!pr)
> -		return -EINVAL;
> -
>  	/*
>  	 * Evaluate _PTC, _TSS and _TPC
>  	 * They must all be present or none of them can be used.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
