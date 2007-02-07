From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/140] ACPI: move FADT resource reservations from motherboard driver to osl
Date: Wed,  7 Feb 2007 13:50:35 -0500
Message-ID: <11708744023872-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:34715 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422724AbXBGSxY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:24 -0500
In-Reply-To: <11708744003959-git-send-email-lenb@kernel.org>
Message-Id: <9a47cdb1bb85e7944fb7419e4078c46516ef7335.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/motherboard.c |   49 --------------------------------------------
 drivers/acpi/osl.c         |   48 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/drivers/acpi/motherboard.c b/drivers/acpi/motherboard.c
index bedb511..cddab7b 100644
--- a/drivers/acpi/motherboard.c
+++ b/drivers/acpi/motherboard.c
@@ -118,58 +118,9 @@ static struct acpi_driver acpi_motherboard_driver = {
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
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 02b30ae..0acd0e7 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -75,6 +75,54 @@ static acpi_osd_handler acpi_irq_handler;
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
-- 
1.5.0.rc3.39.gec804
