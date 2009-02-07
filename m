From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Enable bit 11 in _PDC to advertise hw coord
Date: Fri, 06 Feb 2009 23:10:03 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902062309560.26256@localhost.localdomain>
References: <20090202195717.GA24510@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:20655 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbZBGEKI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Feb 2009 23:10:08 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KEO00KYOGWSZHE2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 06 Feb 2009 22:10:05 -0600 (CST)
In-reply-to: <20090202195717.GA24510@linux-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-acpi@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, Chris Mason <chris.mason@oracle.com>

applied
thanks,
--
Len Brown, Intel Open Source Technology Center

On Mon, 2 Feb 2009, Pallipadi, Venkatesh wrote:

> 
> Bit 11 in intel PDC definitions is meant for OS capability to handle
> hardware coordination of P-states. In Linux we have always supported
> hwardware coordination of P-states. Just let the BIOSes know that we
> support it, by setting this bit.
> 
> Some BIOSes use this bit to choose between hardware or software coordination
> and without this change below, BIOSes switch to software coordination, which
> is not very optimal in terms of power consumption and extra wakeups from idle.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> ---
>  include/acpi/pdc_intel.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-2.6/include/acpi/pdc_intel.h
> ===================================================================
> --- linux-2.6.orig/include/acpi/pdc_intel.h	2009-01-20 16:11:20.000000000 -0800
> +++ linux-2.6/include/acpi/pdc_intel.h	2009-02-02 10:32:06.000000000 -0800
> @@ -14,6 +14,7 @@
>  #define ACPI_PDC_SMP_T_SWCOORD		(0x0080)
>  #define ACPI_PDC_C_C1_FFH		(0x0100)
>  #define ACPI_PDC_C_C2C3_FFH		(0x0200)
> +#define ACPI_PDC_SMP_P_HWCOORD		(0x0800)
>  
>  #define ACPI_PDC_EST_CAPABILITY_SMP	(ACPI_PDC_SMP_C1PT | \
>  					 ACPI_PDC_C_C1_HALT | \
> @@ -22,6 +23,7 @@
>  #define ACPI_PDC_EST_CAPABILITY_SWSMP	(ACPI_PDC_SMP_C1PT | \
>  					 ACPI_PDC_C_C1_HALT | \
>  					 ACPI_PDC_SMP_P_SWCOORD | \
> +					 ACPI_PDC_SMP_P_HWCOORD | \
>  					 ACPI_PDC_P_FFH)
>  
>  #define ACPI_PDC_C_CAPABILITY_SMP	(ACPI_PDC_SMP_C2C3  | \
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
