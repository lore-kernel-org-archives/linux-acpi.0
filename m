From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] ACPI: Add "ACPI" to motherboard resources in /proc/io{mem,port}
Date: Fri, 16 Sep 2005 11:36:02 -0600
Message-ID: <200509161136.02065.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add "ACPI" to motherboard resource allocation names, so people have a
clue about where to look.  And remove some trailing spaces.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

Index: work-vga2/drivers/acpi/motherboard.c
===================================================================
--- work-vga2.orig/drivers/acpi/motherboard.c	2005-09-14 10:39:05.000000000 -0600
+++ work-vga2/drivers/acpi/motherboard.c	2005-09-14 10:43:36.000000000 -0600
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


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
