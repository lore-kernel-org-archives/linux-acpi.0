From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 13/26] ACPI: print wakeup device list on same line as label
Date: Sat, 1 Apr 2006 21:55:48 -0500
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6123DD6@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22833 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751653AbWDBCzv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Apr 2006 21:55:51 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com


>From: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
>Print the ACPI wakeup device list on the same line as the label to make
>"dmesg | grep ACPI" output more useful.

It is a temporary hack that we expose these devices via the internal BIOS names.
They should really be properties of devices in the device tree.

Instead of updating this message, can we delete it altogether?

thanks,
-Len


>Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/sleep/wakeup.c |    2 +-
> 1 files changed, 1 insertion(+), 1 deletion(-)
>
>diff -puN 
>drivers/acpi/sleep/wakeup.c~acpi-print-wakeup-device-list-on-sa
me-line-as-label drivers/acpi/sleep/wakeup.c
>--- 
>devel/drivers/acpi/sleep/wakeup.c~acpi-print-wakeup-device-list
-on-same-line-as-label	2006-03-28 14:03:04.000000000 -0800
>+++ devel-akpm/drivers/acpi/sleep/wakeup.c	2006-03-28 
>14:03:04.000000000 -0800
>@@ -155,7 +155,7 @@ static int __init acpi_wakeup_device_ini
> 
> 	if (acpi_disabled)
> 		return 0;
>-	printk("ACPI wakeup devices: \n");
>+	printk(KERN_INFO PREFIX "wakeup devices: ");
> 
> 	spin_lock(&acpi_device_lock);
> 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
>_
>
