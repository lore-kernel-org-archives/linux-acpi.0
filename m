From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 1/5] ACPI: move FADT resource reservations from motherboard driver to osl
Date: Thu, 18 Jan 2007 16:42:55 -0700
Message-ID: <200701181642.56040.bjorn.helgaas@hp.com>
References: <200701181636.45590.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:50907 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932757AbXARXnD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Jan 2007 18:43:03 -0500
In-Reply-To: <200701181636.45590.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

Resources described by the FADT aren't really a good fit for the
ACPI motherboard driver.

The motherboard driver cares about PNP0C01 and PNP0C02 devices and
their resources.

The FADT describes some resources used by the ACPI core.  Often, they
are also described by by the _CRS of a motherboard device, but I think
it's better to reserve them specifically in the ACPI osl.c because
(a) the motherboard driver is optional and ACPI uses the resources even
if the driver is absent, and (b) I want to remove the ACPI motherboard
driver because it's mostly redundant with the PNP system.c driver.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: mm-work3/drivers/acpi/motherboard.c
===================================================================
--- mm-work3.orig/drivers/acpi/motherboard.c	2007-01-14 14:52:30.000000000 -0700
+++ mm-work3/drivers/acpi/motherboard.c	2007-01-18 10:21:13.000000000 -0700
@@ -118,58 +118,9 @@
 		},
 };
 
-static void __init acpi_request_region (struct acpi_generic_address *addr,
-	unsigned int length, char *desc)
-{
-	if (!addr->address || !length)
-		return;
-
-	if (addr->address_space_id == ACPI_ADR_SPACE_SYSTEM_IO)
-		request_region(addr->address, length, desc);
-	else if (addr->address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		request_mem_region(addr->address, length, desc);
-}
-
-static void __init acpi_reserve_resources(void)
-{
-	acpi_request_region(&acpi_gbl_FADT->xpm1a_evt_blk,
-			       acpi_gbl_FADT->pm1_evt_len, "ACPI PM1a_EVT_BLK");
-
-	acpi_request_region(&acpi_gbl_FADT->xpm1b_evt_blk,
-			       acpi_gbl_FADT->pm1_evt_len, "ACPI PM1b_EVT_BLK");
-
-	acpi_request_region(&acpi_gbl_FADT->xpm1a_cnt_blk,
-			       acpi_gbl_FADT->pm1_cnt_len, "ACPI PM1a_CNT_BLK");
-
-	acpi_request_region(&acpi_gbl_FADT->xpm1b_cnt_blk,
-			       acpi_gbl_FADT->pm1_cnt_len, "ACPI PM1b_CNT_BLK");
-
-	if (acpi_gbl_FADT->pm_tm_len == 4)
-		acpi_request_region(&acpi_gbl_FADT->xpm_tmr_blk, 4, "ACPI PM_TMR");
-
-	acpi_request_region(&acpi_gbl_FADT->xpm2_cnt_blk,
-			       acpi_gbl_FADT->pm2_cnt_len, "ACPI PM2_CNT_BLK");
-
-	/* Length of GPE blocks must be a non-negative multiple of 2 */
-
-	if (!(acpi_gbl_FADT->gpe0_blk_len & 0x1))
-		acpi_request_region(&acpi_gbl_FADT->xgpe0_blk,
-			       acpi_gbl_FADT->gpe0_blk_len, "ACPI GPE0_BLK");
-
-	if (!(acpi_gbl_FADT->gpe1_blk_len & 0x1))
-		acpi_request_region(&acpi_gbl_FADT->xgpe1_blk,
-			       acpi_gbl_FADT->gpe1_blk_len, "ACPI GPE1_BLK");
-}
-
 static int __init acpi_motherboard_init(void)
 {
 	acpi_bus_register_driver(&acpi_motherboard_driver);
-	/*
-	 * Guarantee motherboard IO reservation first
-	 * This module must run after scan.c
-	 */
-	if (!acpi_disabled)
-		acpi_reserve_resources();
 	return 0;
 }
 
Index: mm-work3/drivers/acpi/osl.c
===================================================================
--- mm-work3.orig/drivers/acpi/osl.c	2007-01-14 14:52:30.000000000 -0700
+++ mm-work3/drivers/acpi/osl.c	2007-01-18 14:39:47.000000000 -0700
@@ -75,6 +75,54 @@
 static void *acpi_irq_context;
 static struct workqueue_struct *kacpid_wq;
 
+static void __init acpi_request_region (struct acpi_generic_address *addr,
+	unsigned int length, char *desc)
+{
+	struct resource *res;
+
+	if (!addr->address || !length)
+		return;
+
+	if (addr->address_space_id == ACPI_ADR_SPACE_SYSTEM_IO)
+		res = request_region(addr->address, length, desc);
+	else if (addr->address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		res = request_mem_region(addr->address, length, desc);
+}
+
+static int __init acpi_reserve_resources(void)
+{
+	acpi_request_region(&acpi_fadt.xpm1a_evt_blk, acpi_fadt.pm1_evt_len,
+		"ACPI PM1a_EVT_BLK");
+
+	acpi_request_region(&acpi_fadt.xpm1b_evt_blk, acpi_fadt.pm1_evt_len,
+		"ACPI PM1b_EVT_BLK");
+
+	acpi_request_region(&acpi_fadt.xpm1a_cnt_blk, acpi_fadt.pm1_cnt_len,
+		"ACPI PM1a_CNT_BLK");
+
+	acpi_request_region(&acpi_fadt.xpm1b_cnt_blk, acpi_fadt.pm1_cnt_len,
+		"ACPI PM1b_CNT_BLK");
+
+	if (acpi_fadt.pm_tm_len == 4)
+		acpi_request_region(&acpi_fadt.xpm_tmr_blk, 4, "ACPI PM_TMR");
+
+	acpi_request_region(&acpi_fadt.xpm2_cnt_blk, acpi_fadt.pm2_cnt_len,
+		"ACPI PM2_CNT_BLK");
+
+	/* Length of GPE blocks must be a non-negative multiple of 2 */
+
+	if (!(acpi_fadt.gpe0_blk_len & 0x1))
+		acpi_request_region(&acpi_fadt.xgpe0_blk,
+			       acpi_fadt.gpe0_blk_len, "ACPI GPE0_BLK");
+
+	if (!(acpi_fadt.gpe1_blk_len & 0x1))
+		acpi_request_region(&acpi_fadt.xgpe1_blk,
+			       acpi_fadt.gpe1_blk_len, "ACPI GPE1_BLK");
+
+	return 0;
+}
+device_initcall(acpi_reserve_resources);
+
 acpi_status acpi_os_initialize(void)
 {
 	return AE_OK;
