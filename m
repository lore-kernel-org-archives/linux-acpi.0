From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] ACPI / LPSS: introduce a 'proxy' device to power on LPSS for DMA
Date: Wed,  5 Nov 2014 18:34:47 +0200
Message-ID: <1415205288-3356-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1415205288-3356-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21902 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754590AbaKEQfN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 Nov 2014 11:35:13 -0500
In-Reply-To: <1415205288-3356-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Scott Ashcroft <scott.ashcroft@talk21.com>, Mika Westerberg <mika.westerberg@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Blin, Jerome" <jerome.blin@intel.com>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The LPSS DMA controller does not have _PS0 and _PS3 methods. Moreover it can be
powered off automatically whenever the last LPSS device goes down. In case of
no power any access to the DMA controller will hang the system. The behaviour
is reproduced on some HP laptops based on Intel Bay Trail [1] as well as on
Asus T100 transformer.

This patch introduces a so called 'proxy' device that has the knobs to handle a
power of the LPSS island. When the system needs to program the DMA controller
it calls to the ACPI LPSS power domain callbacks that wake or suspend the
'proxy' device.

[1] http://www.spinics.net/lists/dmaengine/msg01514.html

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 4804ae3..d1dd0ad 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -1,7 +1,7 @@
 /*
  * ACPI support for Intel Lynxpoint LPSS.
  *
- * Copyright (C) 2013, Intel Corporation
+ * Copyright (C) 2013, 2014, Intel Corporation
  * Authors: Mika Westerberg <mika.westerberg@linux.intel.com>
  *          Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  *
@@ -60,6 +60,8 @@ ACPI_MODULE_NAME("acpi_lpss");
 #define LPSS_CLK_DIVIDER		BIT(2)
 #define LPSS_LTR			BIT(3)
 #define LPSS_SAVE_CTX			BIT(4)
+#define LPSS_DEV_PROXY			BIT(5)
+#define LPSS_PROXY_REQ			BIT(6)
 
 struct lpss_private_data;
 
@@ -70,8 +72,10 @@ struct lpss_device_desc {
 	void (*setup)(struct lpss_private_data *pdata);
 };
 
+static struct device *proxy_device;
+
 static struct lpss_device_desc lpss_dma_desc = {
-	.flags = LPSS_CLK,
+	.flags = LPSS_CLK | LPSS_PROXY_REQ,
 };
 
 struct lpss_private_data {
@@ -146,22 +150,24 @@ static struct lpss_device_desc byt_pwm_dev_desc = {
 };
 
 static struct lpss_device_desc byt_uart_dev_desc = {
-	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX,
+	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX |
+		 LPSS_DEV_PROXY,
 	.prv_offset = 0x800,
 	.setup = lpss_uart_setup,
 };
 
 static struct lpss_device_desc byt_spi_dev_desc = {
-	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX,
+	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX |
+		 LPSS_DEV_PROXY,
 	.prv_offset = 0x400,
 };
 
 static struct lpss_device_desc byt_sdio_dev_desc = {
-	.flags = LPSS_CLK,
+	.flags = LPSS_CLK | LPSS_DEV_PROXY,
 };
 
 static struct lpss_device_desc byt_i2c_dev_desc = {
-	.flags = LPSS_CLK | LPSS_SAVE_CTX,
+	.flags = LPSS_CLK | LPSS_SAVE_CTX | LPSS_DEV_PROXY,
 	.prv_offset = 0x800,
 	.setup = byt_i2c_setup,
 };
@@ -368,6 +374,8 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 	adev->driver_data = pdata;
 	pdev = acpi_create_platform_device(adev);
 	if (!IS_ERR_OR_NULL(pdev)) {
+		if (!proxy_device && dev_desc->flags & LPSS_DEV_PROXY)
+			proxy_device = &pdev->dev;
 		return 1;
 	}
 
@@ -593,7 +601,14 @@ static int acpi_lpss_runtime_suspend(struct device *dev)
 	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
 		acpi_lpss_save_ctx(dev, pdata);
 
-	return acpi_dev_runtime_suspend(dev);
+	ret = acpi_dev_runtime_suspend(dev);
+	if (ret)
+		return ret;
+
+	if (pdata->dev_desc->flags & LPSS_PROXY_REQ && proxy_device)
+		return pm_runtime_put_sync_suspend(proxy_device);
+
+	return 0;
 }
 
 static int acpi_lpss_runtime_resume(struct device *dev)
@@ -601,6 +616,12 @@ static int acpi_lpss_runtime_resume(struct device *dev)
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
 	int ret;
 
+	if (pdata->dev_desc->flags & LPSS_PROXY_REQ && proxy_device) {
+		ret = pm_runtime_get_sync(proxy_device);
+		if (ret)
+			return ret;
+	}
+
 	ret = acpi_dev_runtime_resume(dev);
 	if (ret)
 		return ret;
-- 
2.1.1

