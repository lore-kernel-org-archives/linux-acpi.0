From: kamlakant.patel@broadcom.com
Subject: [PATCH 1/2] ACPI / APD: Add device HID for Vulcan SPI controller
Date: Tue,  9 Aug 2016 19:35:21 +0530
Message-ID: <1470751522-11060-1-git-send-email-kamlakant.patel@broadcom.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:64338 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbcHIO1T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Aug 2016 10:27:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki \"" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Kamlakant Patel <kamlakant.patel@broadcom.com>, linux-acpi@vger.kernel.org, Jayachandran C <jchandra@broadcom.com>, Mark Brown <broonie@kernel.org>

From: Kamlakant Patel <kamlakant.patel@broadcom.com>

Add device HID for SPI controller on Broadcom Vulcan ARM64.
The default frequency for SPI on Vulcan is 133MHz.

Signed-off-by: Kamlakant Patel <kamlakant.patel@broadcom.com>
---
 drivers/acpi/acpi_apd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 1daf9c4..c80c8f8 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -87,6 +87,11 @@ static struct apd_device_desc xgene_i2c_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 100000000,
 };
+
+static struct apd_device_desc vulcan_spi_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 133000000,
+};
 #endif
 
 #else
@@ -149,6 +154,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 #endif
 #ifdef CONFIG_ARM64
 	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
+	{ "BRCM900D", APD_ADDR(vulcan_spi_desc) },
 #endif
 	{ }
 };
-- 
1.9.1

