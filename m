From: Len Brown <lenb@kernel.org>
Subject: Re: [RESEND] [RFC PATCH 6/6] ACPI: set waking vectors in all FACS
 tables
Date: Mon, 01 Dec 2008 22:53:55 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812012253510.934@localhost.localdomain>
References: <1226478552.15014.176.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:43382 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbYLBDyF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 22:54:05 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KB80081WDG9ZO56@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Dec 2008 21:52:58 -0600 (CST)
In-reply-to: <1226478552.15014.176.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

applied to acpi-test

-- 
-Len Brown
Intel Open Source Technology Center

On Wed, 12 Nov 2008, Zhang Rui wrote:

> 
> Set the waking vectors in all FACS tables
> in acpi_gbl_root_table_list.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/hardware/hwsleep.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c	2008-11-13 04:29:35.000000000 +0800
> +++ linux-2.6/drivers/acpi/hardware/hwsleep.c	2008-11-13 04:29:43.000000000 +0800
> @@ -90,6 +90,16 @@
>  
>  	facs->firmware_waking_vector = (u32)physical_address;
>  
> +	status = acpi_get_table(ACPI_SIG_FACS, 2,
> +		ACPI_CAST_INDIRECT_PTR(struct acpi_table_header, &facs));
> +	if (ACPI_FAILURE(status))
> +		return_ACPI_STATUS(AE_OK);
> +
> +	if (facs->version >= 1)
> +		facs->xfirmware_waking_vector = 0;
> +
> +	facs->firmware_waking_vector = (u32)physical_address;
> +
>  	return_ACPI_STATUS(AE_OK);
>  }
>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
