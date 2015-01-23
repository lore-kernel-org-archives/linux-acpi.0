From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ACPI / LPSS: Remove non-existing clock control from Intel Lynxpoint I2C
Date: Fri, 23 Jan 2015 09:42:39 +0200
Message-ID: <1421998959-6595-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:32172 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbbAWHmo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Jan 2015 02:42:44 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Intel Lynxpoint I2C does not have clock parameter register like SPI and UART
do have. Therefore remove LPSS_CLK_GATE flag from the Lynxpoint I2C device
description in order to not needlessly toggle clock enable bit in
non-existing register.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
For linux-next branch. This has been here since commit f58b082aed43
("ACPI / scan: Add special handler for Intel Lynxpoint LPSS devices")
without known problems.

Mika: I assumed this holds true for INT3432 and INT3433 too?
---
 drivers/acpi/acpi_lpss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 4f3febf8a589..9d43f79627a9 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -129,7 +129,7 @@ static struct lpss_device_desc lpt_dev_desc = {
 };
 
 static struct lpss_device_desc lpt_i2c_dev_desc = {
-	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_LTR,
+	.flags = LPSS_CLK | LPSS_LTR,
 	.prv_offset = 0x800,
 };
 
-- 
2.1.4

