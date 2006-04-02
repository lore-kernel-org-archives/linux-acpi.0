From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 15/26] HPET: fix ACPI memory range length handling
Date: Sun, 2 Apr 2006 00:21:57 -0500
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6123DEB@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6579 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751259AbWDBFWA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Apr 2006 00:22:00 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com

applied.

thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Tuesday, March 28, 2006 5:04 PM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; bjorn.helgaas@hp.com
>Subject: [patch 15/26] HPET: fix ACPI memory range length handling
>
>
>From: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
>ACPI address space descriptors contain _MIN, _MAX, and _LEN.  
>_MIN and _MAX
>are the bounds within which the region can be moved (this is 
>clarified in
>Table 6-38 of the ACPI 3.0 spec).  We should use _LEN to 
>determine the size
>of the region, not _MAX - _MIN + 1.
>
>Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/char/hpet.c |    5 +----
> 1 files changed, 1 insertion(+), 4 deletions(-)
>
>diff -puN 
>drivers/char/hpet.c~hpet-fix-acpi-memory-range-length-handling 
>drivers/char/hpet.c
>--- 
>devel/drivers/char/hpet.c~hpet-fix-acpi-memory-range-length-h
>andling	2006-03-28 14:03:05.000000000 -0800
>+++ devel-akpm/drivers/char/hpet.c	2006-03-28 
>14:03:05.000000000 -0800
>@@ -925,11 +925,8 @@ static acpi_status hpet_resources(struct
> 	status = acpi_resource_to_address64(res, &addr);
> 
> 	if (ACPI_SUCCESS(status)) {
>-		unsigned long size;
>-
>-		size = addr.maximum - addr.minimum + 1;
> 		hdp->hd_phys_address = addr.minimum;
>-		hdp->hd_address = ioremap(addr.minimum, size);
>+		hdp->hd_address = ioremap(addr.minimum, 
>addr.address_length);
> 
> 		if (hpet_is_known(hdp)) {
> 			printk(KERN_DEBUG "%s: 0x%lx is busy\n",
>_
>
