From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/2] ACPI: Add "ACPI" to motherboard resources in /proc/io{mem,port}
Date: Mon, 6 Feb 2006 15:50:04 -0700
Message-ID: <200602061550.05000.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:32175 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932413AbWBFWuF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2006 17:50:05 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Add "ACPI" to motherboard resource allocation names, so people have a
clue about where to look.  And remove some trailing spaces.

Changes these /proc/iomem entries from this:

    ff5c1004-ff5c1007 : PM_TMR
    ff5c1008-ff5c100b : PM1a_EVT_BLK
    ff5c100c-ff5c100d : PM1a_CNT_BLK
    ff5c1010-ff5c1013 : GPE0_BLK
    ff5c1014-ff5c1017 : GPE1_BLK

to this:

    ff5c1004-ff5c1007 : ACPI PM_TMR
    ff5c1008-ff5c100b : ACPI PM1a_EVT_BLK
    ff5c100c-ff5c100d : ACPI PM1a_CNT_BLK
    ff5c1010-ff5c1013 : ACPI GPE0_BLK
    ff5c1014-ff5c1017 : ACPI GPE1_BLK

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/acpi/motherboard.c
===================================================================
--- work-mm4.orig/drivers/acpi/motherboard.c	2006-02-02 15:01:43.000000000 -0700
+++ work-mm4/drivers/acpi/motherboard.c	2006-02-02 15:06:46.000000000 -0700
@@ -37,7 +37,7 @@
 #define ACPI_MB_HID2			"PNP0C02"
 /**
  * Doesn't care about legacy IO ports, only IO ports beyond 0x1000 are reserved
- * Doesn't care about the failure of 'request_region', since other may reserve 
+ * Doesn't care about the failure of 'request_region', since other may reserve
  * the io ports as well
  */
 #define IS_RESERVED_ADDR(base, len) \
@@ -46,7 +46,7 @@
 /*
  * Clearing the flag (IORESOURCE_BUSY) allows drivers to use
  * the io ports if they really know they can use it, while
- * still preventing hotplug PCI devices from using it. 
+ * still preventing hotplug PCI devices from using it.
  */
 static acpi_status acpi_reserve_io_ranges(struct acpi_resource *res, void *data)
 {
@@ -138,39 +138,39 @@
 static void __init acpi_reserve_resources(void)
 {
 	acpi_request_region(&acpi_gbl_FADT->xpm1a_evt_blk,
-			       acpi_gbl_FADT->pm1_evt_len, "PM1a_EVT_BLK");
+			       acpi_gbl_FADT->pm1_evt_len, "ACPI PM1a_EVT_BLK");
 
 	acpi_request_region(&acpi_gbl_FADT->xpm1b_evt_blk,
-			       acpi_gbl_FADT->pm1_evt_len, "PM1b_EVT_BLK");
+			       acpi_gbl_FADT->pm1_evt_len, "ACPI PM1b_EVT_BLK");
 
 	acpi_request_region(&acpi_gbl_FADT->xpm1a_cnt_blk,
-			       acpi_gbl_FADT->pm1_cnt_len, "PM1a_CNT_BLK");
+			       acpi_gbl_FADT->pm1_cnt_len, "ACPI PM1a_CNT_BLK");
 
 	acpi_request_region(&acpi_gbl_FADT->xpm1b_cnt_blk,
-			       acpi_gbl_FADT->pm1_cnt_len, "PM1b_CNT_BLK");
+			       acpi_gbl_FADT->pm1_cnt_len, "ACPI PM1b_CNT_BLK");
 
 	if (acpi_gbl_FADT->pm_tm_len == 4)
-		acpi_request_region(&acpi_gbl_FADT->xpm_tmr_blk, 4, "PM_TMR");
+		acpi_request_region(&acpi_gbl_FADT->xpm_tmr_blk, 4, "ACPI PM_TMR");
 
 	acpi_request_region(&acpi_gbl_FADT->xpm2_cnt_blk,
-			       acpi_gbl_FADT->pm2_cnt_len, "PM2_CNT_BLK");
+			       acpi_gbl_FADT->pm2_cnt_len, "ACPI PM2_CNT_BLK");
 
 	/* Length of GPE blocks must be a non-negative multiple of 2 */
 
 	if (!(acpi_gbl_FADT->gpe0_blk_len & 0x1))
 		acpi_request_region(&acpi_gbl_FADT->xgpe0_blk,
-			       acpi_gbl_FADT->gpe0_blk_len, "GPE0_BLK");
+			       acpi_gbl_FADT->gpe0_blk_len, "ACPI GPE0_BLK");
 
 	if (!(acpi_gbl_FADT->gpe1_blk_len & 0x1))
 		acpi_request_region(&acpi_gbl_FADT->xgpe1_blk,
-			       acpi_gbl_FADT->gpe1_blk_len, "GPE1_BLK");
+			       acpi_gbl_FADT->gpe1_blk_len, "ACPI GPE1_BLK");
 }
 
 static int __init acpi_motherboard_init(void)
 {
 	acpi_bus_register_driver(&acpi_motherboard_driver1);
 	acpi_bus_register_driver(&acpi_motherboard_driver2);
-	/* 
+	/*
 	 * Guarantee motherboard IO reservation first
 	 * This module must run after scan.c
 	 */
