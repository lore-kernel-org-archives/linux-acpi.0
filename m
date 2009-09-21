From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ACPI: request_region failure ignored in acpi_request_region()
Date: Mon, 21 Sep 2009 11:50:56 +0200
Message-ID: <4AB74C80.5090801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:61823 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755778AbZIUJna (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 05:43:30 -0400
Received: by ewy2 with SMTP id 2so782800ewy.17
        for <linux-acpi@vger.kernel.org>; Mon, 21 Sep 2009 02:43:32 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

request_(mem_)region may fail, clean up and produce an error.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Found with sed: http://kernelnewbies.org/roelkluin

build, sparse and checkpatch tested.

please review.

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5691f16..f10d786 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -136,51 +136,112 @@ static struct osi_linux {
 	unsigned int	known:1;
 } osi_linux = { 0, 0, 0, 0};
 
-static void __init acpi_request_region (struct acpi_generic_address *addr,
+static int __init acpi_request_region(struct acpi_generic_address *addr,
 	unsigned int length, char *desc)
 {
 	struct resource *res;
 
 	if (!addr->address || !length)
-		return;
+		return 0;
 
 	if (addr->space_id == ACPI_ADR_SPACE_SYSTEM_IO)
 		res = request_region(addr->address, length, desc);
 	else if (addr->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		res = request_mem_region(addr->address, length, desc);
+	else
+		return 0;
+
+	if (res == NULL)
+		return -ENOMEM;
+	return 0;
 }
 
-static int __init acpi_reserve_resources(void)
+static void __init acpi_release_region(struct acpi_generic_address *addr,
+		unsigned int length)
 {
-	acpi_request_region(&acpi_gbl_FADT.xpm1a_event_block, acpi_gbl_FADT.pm1_event_length,
-		"ACPI PM1a_EVT_BLK");
-
-	acpi_request_region(&acpi_gbl_FADT.xpm1b_event_block, acpi_gbl_FADT.pm1_event_length,
-		"ACPI PM1b_EVT_BLK");
-
-	acpi_request_region(&acpi_gbl_FADT.xpm1a_control_block, acpi_gbl_FADT.pm1_control_length,
-		"ACPI PM1a_CNT_BLK");
-
-	acpi_request_region(&acpi_gbl_FADT.xpm1b_control_block, acpi_gbl_FADT.pm1_control_length,
-		"ACPI PM1b_CNT_BLK");
+	if (addr->space_id == ACPI_ADR_SPACE_SYSTEM_IO)
+		release_region(addr->address, length);
+	else
+		release_mem_region(addr->address, length);
+}
 
-	if (acpi_gbl_FADT.pm_timer_length == 4)
-		acpi_request_region(&acpi_gbl_FADT.xpm_timer_block, 4, "ACPI PM_TMR");
+static int __init acpi_reserve_resources(void)
+{
+	int ret;
+	ret = acpi_request_region(&acpi_gbl_FADT.xpm1a_event_block,
+			acpi_gbl_FADT.pm1_event_length, "ACPI PM1a_EVT_BLK");
+	if (ret != 0)
+		return ret;
+
+	ret = acpi_request_region(&acpi_gbl_FADT.xpm1b_event_block,
+			acpi_gbl_FADT.pm1_event_length, "ACPI PM1b_EVT_BLK");
+	if (ret != 0)
+		goto release_xpm1a_eb;
+
+	ret = acpi_request_region(&acpi_gbl_FADT.xpm1a_control_block,
+			acpi_gbl_FADT.pm1_control_length, "ACPI PM1a_CNT_BLK");
+	if (ret != 0)
+		goto release_xpm1b_eb;
+
+	ret = acpi_request_region(&acpi_gbl_FADT.xpm1b_control_block,
+			acpi_gbl_FADT.pm1_control_length, "ACPI PM1b_CNT_BLK");
+	if (ret != 0)
+		goto release_xpm1a_cb;
+
+	if (acpi_gbl_FADT.pm_timer_length == 4) {
+		ret = acpi_request_region(&acpi_gbl_FADT.xpm_timer_block, 4,
+				"ACPI PM_TMR");
+		if (ret != 0)
+			goto release_xpm1b_cb;
+	}
 
-	acpi_request_region(&acpi_gbl_FADT.xpm2_control_block, acpi_gbl_FADT.pm2_control_length,
-		"ACPI PM2_CNT_BLK");
+	ret = acpi_request_region(&acpi_gbl_FADT.xpm2_control_block,
+			acpi_gbl_FADT.pm2_control_length, "ACPI PM2_CNT_BLK");
+	if (ret != 0)
+		goto release_xpm_tb;
 
 	/* Length of GPE blocks must be a non-negative multiple of 2 */
 
-	if (!(acpi_gbl_FADT.gpe0_block_length & 0x1))
-		acpi_request_region(&acpi_gbl_FADT.xgpe0_block,
-			       acpi_gbl_FADT.gpe0_block_length, "ACPI GPE0_BLK");
-
-	if (!(acpi_gbl_FADT.gpe1_block_length & 0x1))
-		acpi_request_region(&acpi_gbl_FADT.xgpe1_block,
-			       acpi_gbl_FADT.gpe1_block_length, "ACPI GPE1_BLK");
+	if (!(acpi_gbl_FADT.gpe0_block_length & 0x1)) {
+		ret = acpi_request_region(&acpi_gbl_FADT.xgpe0_block,
+			       acpi_gbl_FADT.gpe0_block_length,
+			       "ACPI GPE0_BLK");
+		if (ret != 0)
+			goto release_xpm2_cb;
+	}
 
+	if (!(acpi_gbl_FADT.gpe1_block_length & 0x1)) {
+		ret = acpi_request_region(&acpi_gbl_FADT.xgpe1_block,
+			       acpi_gbl_FADT.gpe1_block_length,
+			       "ACPI GPE1_BLK");
+		if (ret != 0)
+			goto release_xgpe0_b;
+	}
 	return 0;
+
+release_xgpe0_b:
+	if (!(acpi_gbl_FADT.gpe0_block_length & 0x1))
+		acpi_release_region(&acpi_gbl_FADT.xgpe0_block,
+				acpi_gbl_FADT.gpe0_block_length);
+release_xpm2_cb:
+	acpi_release_region(&acpi_gbl_FADT.xpm2_control_block,
+			acpi_gbl_FADT.pm2_control_length);
+release_xpm_tb:
+	if (acpi_gbl_FADT.pm_timer_length == 4)
+		acpi_release_region(&acpi_gbl_FADT.xpm_timer_block, 4);
+release_xpm1b_cb:
+	acpi_release_region(&acpi_gbl_FADT.xpm1b_control_block,
+			acpi_gbl_FADT.pm1_control_length);
+release_xpm1a_cb:
+	acpi_release_region(&acpi_gbl_FADT.xpm1a_control_block,
+			acpi_gbl_FADT.pm1_control_length);
+release_xpm1b_eb:
+	acpi_release_region(&acpi_gbl_FADT.xpm1b_event_block,
+			acpi_gbl_FADT.pm1_event_length);
+release_xpm1a_eb:
+	acpi_release_region(&acpi_gbl_FADT.xpm1a_event_block,
+			acpi_gbl_FADT.pm1_event_length);
+	return ret;
 }
 device_initcall(acpi_reserve_resources);
 
