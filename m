From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/4] dmaengine: dw: enable runtime PM
Date: Wed,  5 Nov 2014 18:34:48 +0200
Message-ID: <1415205288-3356-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1415205288-3356-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:45159 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755001AbaKEQfZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 Nov 2014 11:35:25 -0500
In-Reply-To: <1415205288-3356-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Scott Ashcroft <scott.ashcroft@talk21.com>, Mika Westerberg <mika.westerberg@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Blin, Jerome" <jerome.blin@intel.com>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On runtime PM aware platforms the DMA have to manage its own power state. This
patch enables runtime PM support and applies necessary calls wherever it's
needed.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 2447221..3804785 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 #include "../dmaengine.h"
 #include "internal.h"
@@ -1504,6 +1505,9 @@ int dw_dma_probe(struct dw_dma_chip *chip, struct dw_dma_platform_data *pdata)
 	dw->regs = chip->regs;
 	chip->dw = dw;
 
+	pm_runtime_enable(chip->dev);
+	pm_runtime_get_sync(chip->dev);
+
 	dw_params = dma_read_byaddr(chip->regs, DW_PARAMS);
 	autocfg = dw_params >> DW_PARAMS_EN & 0x1;
 
@@ -1667,11 +1671,14 @@ int dw_dma_probe(struct dw_dma_chip *chip, struct dw_dma_platform_data *pdata)
 	dev_info(chip->dev, "DesignWare DMA Controller, %d channels\n",
 		 nr_channels);
 
+	pm_runtime_put_sync_suspend(chip->dev);
+
 	return 0;
 
 err_dma_register:
 	free_irq(chip->irq, dw);
 err_pdata:
+	pm_runtime_put_sync_suspend(chip->dev);
 	return err;
 }
 EXPORT_SYMBOL_GPL(dw_dma_probe);
@@ -1681,6 +1688,8 @@ int dw_dma_remove(struct dw_dma_chip *chip)
 	struct dw_dma		*dw = chip->dw;
 	struct dw_dma_chan	*dwc, *_dwc;
 
+	pm_runtime_get_sync(chip->dev);
+
 	dw_dma_off(dw);
 	dma_async_device_unregister(&dw->dma);
 
@@ -1693,6 +1702,8 @@ int dw_dma_remove(struct dw_dma_chip *chip)
 		channel_clear_bit(dw, CH_EN, dwc->mask);
 	}
 
+	pm_runtime_put_sync_suspend(chip->dev);
+	pm_runtime_disable(chip->dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_dma_remove);
-- 
2.1.1

