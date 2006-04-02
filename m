From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 23/26] x86_64: Remove entries in /sys/firmware/acpi for processor also
Date: Sun, 2 Apr 2006 00:22:35 -0500
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6123DF0@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10073 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751368AbWDBFWj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Apr 2006 00:22:39 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, "Raj, Ashok" <ashok.raj@intel.com>, ak@muc.de

applied.

thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Tuesday, March 28, 2006 5:04 PM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; Raj, Ashok; ak@muc.de
>Subject: [patch 23/26] x86_64: Remove entries in 
>/sys/firmware/acpi for processor also
>
>
>From: Ashok Raj <ashok.raj@intel.com>
>
>Processor entries under 
>/sys/firmware/acpi/namespace/ACPI/_SB/CPU* were not
>being removed due to acpi_bus_trim not asking for it just for 
>processors. 
>Without which a new hot-add after a remove doesnt call appropriate init
>functions resulting in subsequent hot-add for same cpu failing.
>
>Not clear why we restricted that to non-processor devices.
>
>Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>Cc: Andi Kleen <ak@muc.de>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/scan.c |    5 +----
> 1 files changed, 1 insertion(+), 4 deletions(-)
>
>diff -puN 
>drivers/acpi/scan.c~remove-entries-in-sys-firmware-acpi-for-pro
>cessor-also drivers/acpi/scan.c
>--- 
>devel/drivers/acpi/scan.c~remove-entries-in-sys-firmware-acpi-f
>or-processor-also	2006-03-28 14:03:07.000000000 -0800
>+++ devel-akpm/drivers/acpi/scan.c	2006-03-28 
>14:03:07.000000000 -0800
>@@ -433,10 +433,7 @@ acpi_eject_store(struct acpi_device *dev
> 	islockable = device->flags.lockable;
> 	handle = device->handle;
> 
>-	if (type == ACPI_TYPE_PROCESSOR)
>-		result = acpi_bus_trim(device, 0);
>-	else
>-		result = acpi_bus_trim(device, 1);
>+	result = acpi_bus_trim(device, 1);
> 
> 	if (!result)
> 		result = acpi_eject_operation(handle, islockable);
>_
>
