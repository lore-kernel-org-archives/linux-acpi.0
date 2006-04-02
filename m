From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 09/26] ACPI: update asus_acpi driver registration
Date: Sun, 2 Apr 2006 00:21:38 -0500
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6123DE7@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46992 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751123AbWDBFVl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Apr 2006 00:21:41 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com

applied
thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Tuesday, March 28, 2006 5:04 PM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; bjorn.helgaas@hp.com
>Subject: [patch 09/26] ACPI: update asus_acpi driver registration
>
>
>From: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
>Remove the assumption that acpi_bus_register_driver() returns 
>the number of
>devices claimed.  Returning the count is unreliable because 
>devices may be
>hot-plugged in the future (admittedly not applicable for this driver).
>
>Since the hardware for this driver is not hot-pluggable, 
>determine whether the
>hardware is present by noticing calls to the .add() method.  
>It would be
>better to probe the ACPI namespace for the ASUS HIDs, and load 
>the driver only
>when we find one, but ACPI doesn't support that yet.
>
>I don't have an ASUS laptop to test on, but on my HP dl360, it 
>does report the
>appropriate error when attempting to load the module:
>
>    $ sudo insmod drivers/acpi/asus_acpi.ko
>    insmod: error inserting 'drivers/acpi/asus_acpi.ko': -1 No 
>such device
>
>Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>Cc: "Brown, Len" <len.brown@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/asus_acpi.c |   18 +++++++++++++++++-
> 1 files changed, 17 insertions(+), 1 deletion(-)
>
>diff -puN 
>drivers/acpi/asus_acpi.c~acpi-update-asus_acpi-driver-registrat
ion drivers/acpi/asus_acpi.c
>--- 
>devel/drivers/acpi/asus_acpi.c~acpi-update-asus_acpi-driver-reg
istration	2006-03-28 14:03:03.000000000 -0800
>+++ devel-akpm/drivers/acpi/asus_acpi.c	2006-03-28 
>14:03:03.000000000 -0800
>@@ -1119,6 +1119,8 @@ static int __init asus_hotk_check(void)
> 	return result;
> }
> 
>+static int asus_hotk_found;
>+
> static int __init asus_hotk_add(struct acpi_device *device)
> {
> 	acpi_status status = AE_OK;
>@@ -1180,6 +1182,8 @@ static int __init asus_hotk_add(struct a
> 		}
> 	}
> 
>+	asus_hotk_found = 1;
>+
>       end:
> 	if (result) {
> 		kfree(hotk);
>@@ -1226,7 +1230,19 @@ static int __init asus_acpi_init(void)
> 	asus_proc_dir->owner = THIS_MODULE;
> 
> 	result = acpi_bus_register_driver(&asus_hotk_driver);
>-	if (result < 1) {
>+	if (result < 0) {
>+		remove_proc_entry(PROC_ASUS, acpi_root_dir);
>+		return -ENODEV;
>+	}
>+
>+	/*
>+	 * This is a bit of a kludge.  We only want this module loaded
>+	 * for ASUS systems, but there's currently no way to probe the
>+	 * ACPI namespace for ASUS HIDs.  So we just return failure if
>+	 * we didn't find one, which will cause the module to be
>+	 * unloaded.
>+	 */
>+	if (!asus_hotk_found) {
> 		acpi_bus_unregister_driver(&asus_hotk_driver);
> 		remove_proc_entry(PROC_ASUS, acpi_root_dir);
> 		return -ENODEV;
>_
>
