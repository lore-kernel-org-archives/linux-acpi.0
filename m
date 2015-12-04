From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 5/9] ACPI / LPSS: do delay for all LPSS devices when D3->D0
Date: Fri,  4 Dec 2015 23:49:21 +0200
Message-ID: <1449265765-9393-6-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

The LPSS DMA device has no context to save, though it requires the same delay
like the rest of LPSS devices when power state is changed from D3 to D0.

Do delay for the DMA device as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index c5f12f3..a10c2d6 100644
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
 
 static int acpi_lpss_activate(struct device *dev)
@@ -649,6 +652,8 @@ static int acpi_lpss_resume_early(struct device *dev)
 	if (ret)
 		return ret;
 
+	acpi_lpss_d3_to_d0_delay(pdata);
+
 	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
 		acpi_lpss_restore_ctx(dev, pdata);
 
@@ -680,6 +685,8 @@ static int acpi_lpss_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	acpi_lpss_d3_to_d0_delay(pdata);
+
 	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
 		acpi_lpss_restore_ctx(dev, pdata);
 
-- 
2.6.2
