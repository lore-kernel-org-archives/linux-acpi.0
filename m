From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI / LPSS: change 'does not' to 'does' in comment
Date: Mon, 21 Dec 2015 19:50:45 +0200
Message-ID: <1450720245-67575-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35817 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbbLURut (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Dec 2015 12:50:49 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The LPSS DMA device does have neither _PS0 nor _PS3 method. Fix the wording in
the comment line.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 84d3d90..6c6661d 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -95,7 +95,7 @@ static unsigned int lpss_quirks;
 /*
  * LPSS_QUIRK_ALWAYS_POWER_ON: override power state for LPSS DMA device.
  *
- * The LPSS DMA controller does not have neither _PS0 nor _PS3 method. Moreover
+ * The LPSS DMA controller does have neither _PS0 nor _PS3 method. Moreover
  * it can be powered off automatically whenever the last LPSS device goes down.
  * In case of no power any access to the DMA controller will hang the system.
  * The behaviour is reproduced on some HP laptops based on Intel BayTrail as
-- 
2.6.4

