From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 7/7] Revert "dmaengine: dw: platform: provide platform data for Intel"
Date: Thu, 26 Nov 2015 17:19:13 +0200
Message-ID: <1448551153-84719-8-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Since we have a work around to prevent a system hangup we don't need to provide
a platform data explicitly anymore.

This reverts commit 175267b389f781748e2bbb6c737e76b5c9bc4c88.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/platform.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index d0734e9..127093a 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -155,7 +155,6 @@ static int dw_probe(struct platform_device *pdev)
 	struct dw_dma_chip *chip;
 	struct device *dev = &pdev->dev;
 	struct resource *mem;
-	const struct acpi_device_id *id;
 	struct dw_dma_platform_data *pdata;
 	int err;
 
@@ -179,11 +178,6 @@ static int dw_probe(struct platform_device *pdev)
 	pdata = dev_get_platdata(dev);
 	if (!pdata)
 		pdata = dw_dma_parse_dt(pdev);
-	if (!pdata && has_acpi_companion(dev)) {
-		id = acpi_match_device(dev->driver->acpi_match_table, dev);
-		if (id)
-			pdata = (struct dw_dma_platform_data *)id->driver_data;
-	}
 
 	chip->dev = dev;
 
@@ -264,17 +258,8 @@ MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
 #endif
 
 #ifdef CONFIG_ACPI
-static struct dw_dma_platform_data dw_dma_acpi_pdata = {
-	.nr_channels = 8,
-	.is_private = true,
-	.chan_allocation_order = CHAN_ALLOCATION_ASCENDING,
-	.chan_priority = CHAN_PRIORITY_ASCENDING,
-	.block_size = 4095,
-	.nr_masters = 2,
-};
-
 static const struct acpi_device_id dw_dma_acpi_id_table[] = {
-	{ "INTL9C60", (kernel_ulong_t)&dw_dma_acpi_pdata },
+	{ "INTL9C60", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dw_dma_acpi_id_table);
-- 
2.6.2
