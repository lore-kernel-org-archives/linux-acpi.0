From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] HPET: fix ACPI memory range length handling
Date: Tue, 7 Feb 2006 16:25:48 -0700
Message-ID: <200602071625.48658.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:24482 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1030256AbWBGXZs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Feb 2006 18:25:48 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bob Picco <robert.picco@hp.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>

ACPI address space descriptors contain _MIN, _MAX, and _LEN.  _MIN and
_MAX are the bounds within which the region can be moved (this
is clarified in Table 6-38 of the ACPI 3.0 spec).  We should use
_LEN to determine the size of the region, not _MAX - _MIN + 1.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/char/hpet.c
===================================================================
--- work-mm4.orig/drivers/char/hpet.c	2006-02-07 15:03:17.000000000 -0700
+++ work-mm4/drivers/char/hpet.c	2006-02-07 16:11:43.000000000 -0700
@@ -925,11 +925,8 @@
 	status = acpi_resource_to_address64(res, &addr);
 
 	if (ACPI_SUCCESS(status)) {
-		unsigned long size;
-
-		size = addr.maximum - addr.minimum + 1;
 		hdp->hd_phys_address = addr.minimum;
-		hdp->hd_address = ioremap(addr.minimum, size);
+		hdp->hd_address = ioremap(addr.minimum, addr.address_length);
 
 		if (hpet_is_known(hdp)) {
 			printk(KERN_DEBUG "%s: 0x%lx is busy\n",
