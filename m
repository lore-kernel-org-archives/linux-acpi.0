From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] ACPI: print wakeup device list on same line as label
Date: Tue, 7 Feb 2006 16:18:01 -0700
Message-ID: <200602071618.01163.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:53984 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1030246AbWBGXSB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Feb 2006 18:18:01 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Print the ACPI wakeup device list on the same line as the label
to make "dmesg | grep ACPI" output more useful.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/acpi/sleep/wakeup.c
===================================================================
--- work-mm4.orig/drivers/acpi/sleep/wakeup.c	2006-02-01 16:24:45.000000000 -0700
+++ work-mm4/drivers/acpi/sleep/wakeup.c	2006-02-07 15:01:40.000000000 -0700
@@ -155,7 +155,7 @@
 
 	if (acpi_disabled)
 		return 0;
-	printk("ACPI wakeup devices: \n");
+	printk(KERN_INFO PREFIX "wakeup devices: ");
 
 	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
