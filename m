From: akpm@osdl.org
Subject: [patch 07/22] ACPI: request correct fixed hardware resource type (MMIO vs I/O port)
Date: Tue, 07 Mar 2006 23:49:34 -0800
Message-ID: <200603080751.k287pNM5000966@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:13730 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932418AbWCHHwJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Mar 2006 02:52:09 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bjorn.helgaas@hp.com


From: Bjorn Helgaas <bjorn.helgaas@hp.com>

ACPI supports fixed hardware (PM_TMR, GPE blocks, etc) in either I/O port
or MMIO space, but used to always request the regions from I/O space
because it didn't check the address_space_id.

Sample ACPI fixed hardware in MMIO space (HP rx2600), was incorrectly
reported in /proc/ioports, now reported in /proc/iomem:

    ff5c1004-ff5c1007 : PM_TMR
    ff5c1008-ff5c100b : PM1a_EVT_BLK
    ff5c100c-ff5c100d : PM1a_CNT_BLK
    ff5c1010-ff5c1013 : GPE0_BLK
    ff5c1014-ff5c1017 : GPE1_BLK

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/motherboard.c |   41 +++++++++++++++++++----------------
 1 files changed, 23 insertions(+), 18 deletions(-)

diff -puN drivers/acpi/motherboard.c~acpi-request-correct-fixed-hardware-resource-type-mmio-vs-i-o-port drivers/acpi/motherboard.c
--- devel/drivers/acpi/motherboard.c~acpi-request-correct-fixed-hardware-resource-type-mmio-vs-i-o-port	2006-03-07 23:47:09.000000000 -0800
+++ devel-akpm/drivers/acpi/motherboard.c	2006-03-07 23:47:09.000000000 -0800
@@ -123,41 +123,46 @@ static struct acpi_driver acpi_motherboa
 		},
 };
 
+static void __init acpi_request_region (struct acpi_generic_address *addr,
+	unsigned int length, char *desc)
+{
+	if (!addr->address || !length)
+		return;
+
+	if (addr->address_space_id == ACPI_ADR_SPACE_SYSTEM_IO)
+		request_region(addr->address, length, desc);
+	else if (addr->address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		request_mem_region(addr->address, length, desc);
+}
+
 static void __init acpi_reserve_resources(void)
 {
-	if (acpi_gbl_FADT->xpm1a_evt_blk.address && acpi_gbl_FADT->pm1_evt_len)
-		request_region(acpi_gbl_FADT->xpm1a_evt_blk.address,
+	acpi_request_region(&acpi_gbl_FADT->xpm1a_evt_blk,
 			       acpi_gbl_FADT->pm1_evt_len, "PM1a_EVT_BLK");
 
-	if (acpi_gbl_FADT->xpm1b_evt_blk.address && acpi_gbl_FADT->pm1_evt_len)
-		request_region(acpi_gbl_FADT->xpm1b_evt_blk.address,
+	acpi_request_region(&acpi_gbl_FADT->xpm1b_evt_blk,
 			       acpi_gbl_FADT->pm1_evt_len, "PM1b_EVT_BLK");
 
-	if (acpi_gbl_FADT->xpm1a_cnt_blk.address && acpi_gbl_FADT->pm1_cnt_len)
-		request_region(acpi_gbl_FADT->xpm1a_cnt_blk.address,
+	acpi_request_region(&acpi_gbl_FADT->xpm1a_cnt_blk,
 			       acpi_gbl_FADT->pm1_cnt_len, "PM1a_CNT_BLK");
 
-	if (acpi_gbl_FADT->xpm1b_cnt_blk.address && acpi_gbl_FADT->pm1_cnt_len)
-		request_region(acpi_gbl_FADT->xpm1b_cnt_blk.address,
+	acpi_request_region(&acpi_gbl_FADT->xpm1b_cnt_blk,
 			       acpi_gbl_FADT->pm1_cnt_len, "PM1b_CNT_BLK");
 
-	if (acpi_gbl_FADT->xpm_tmr_blk.address && acpi_gbl_FADT->pm_tm_len == 4)
-		request_region(acpi_gbl_FADT->xpm_tmr_blk.address, 4, "PM_TMR");
+	if (acpi_gbl_FADT->pm_tm_len == 4)
+		acpi_request_region(&acpi_gbl_FADT->xpm_tmr_blk, 4, "PM_TMR");
 
-	if (acpi_gbl_FADT->xpm2_cnt_blk.address && acpi_gbl_FADT->pm2_cnt_len)
-		request_region(acpi_gbl_FADT->xpm2_cnt_blk.address,
+	acpi_request_region(&acpi_gbl_FADT->xpm2_cnt_blk,
 			       acpi_gbl_FADT->pm2_cnt_len, "PM2_CNT_BLK");
 
 	/* Length of GPE blocks must be a non-negative multiple of 2 */
 
-	if (acpi_gbl_FADT->xgpe0_blk.address && acpi_gbl_FADT->gpe0_blk_len &&
-	    !(acpi_gbl_FADT->gpe0_blk_len & 0x1))
-		request_region(acpi_gbl_FADT->xgpe0_blk.address,
+	if (!(acpi_gbl_FADT->gpe0_blk_len & 0x1))
+		acpi_request_region(&acpi_gbl_FADT->xgpe0_blk,
 			       acpi_gbl_FADT->gpe0_blk_len, "GPE0_BLK");
 
-	if (acpi_gbl_FADT->xgpe1_blk.address && acpi_gbl_FADT->gpe1_blk_len &&
-	    !(acpi_gbl_FADT->gpe1_blk_len & 0x1))
-		request_region(acpi_gbl_FADT->xgpe1_blk.address,
+	if (!(acpi_gbl_FADT->gpe1_blk_len & 0x1))
+		acpi_request_region(&acpi_gbl_FADT->xgpe1_blk,
 			       acpi_gbl_FADT->gpe1_blk_len, "GPE1_BLK");
 }
 
_
