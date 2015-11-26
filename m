From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/7] ACPI / LPSS: do delay for all LPSS devices when D3->D0
Date: Thu, 26 Nov 2015 17:19:09 +0200
Message-ID: <1448551153-84719-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60460 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbbKZPTS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Nov 2015 10:19:18 -0500
In-Reply-To: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The LPSS DMA device has no context to save, though it requires the same delay
like the rest of LPSS devices when power state is changed from D3 to D0.

Do delay for the DMA device as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index e840229..a155dec 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -574,6 +574,17 @@ static void acpi_lpss_restore_ctx(struct device *dev,
 {
 	unsigned int i;
 
+	for (i = 0; i < LPSS_PRV_REG_COUNT; i++) {
+		unsigned long offset = i * sizeof(u32);
+
+		__lpss_reg_write(pdata->prv_reg_ctx[i], pdata, offset);
+		dev_dbg(dev, "restoring 0x%08x to LPSS reg at offset 0x%02lx\n",
+			pdata->prv_reg_ctx[i], offset);
+	}
+}
+
+static void acpi_lpss_d3_to_d0_delay(struct lpss_private_data *pdata)
+{
 	/*
 	 * The following delay is needed or the subsequent write operations may
 	 * fail. The LPSS devices are actually PCI devices and the PCI spec
@@ -586,14 +597,6 @@ static void acpi_lpss_restore_ctx(struct device *dev,
 		delay = 0;
 
 	msleep(delay);
-
-	for (i = 0; i < LPSS_PRV_REG_COUNT; i++) {
-		unsigned long offset = i * sizeof(u32);
-
-		__lpss_reg_write(pdata->prv_reg_ctx[i], pdata, offset);
-		dev_dbg(dev, "restoring 0x%08x to LPSS reg at offset 0x%02lx\n",
-			pdata->prv_reg_ctx[i], offset);
-	}
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -621,6 +624,8 @@ static int acpi_lpss_resume_early(struct device *dev)
 	if (ret)
 		return ret;
 
+	acpi_lpss_d3_to_d0_delay(pdata);
+
 	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
 		acpi_lpss_restore_ctx(dev, pdata);
 
@@ -652,6 +657,8 @@ static int acpi_lpss_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	acpi_lpss_d3_to_d0_delay(pdata);
+
 	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
 		acpi_lpss_restore_ctx(dev, pdata);
 
-- 
2.6.2

