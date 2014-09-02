From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 3/4] ACPI / LPSS: support for 133MHz I2C source clock on Baytrail
Date: Tue,  2 Sep 2014 10:55:09 +0300
Message-ID: <1409644510-26397-4-git-send-email-heikki.krogerus@linux.intel.com>
References: <1409644510-26397-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13203 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711AbaIBHzT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Sep 2014 03:55:19 -0400
In-Reply-To: <1409644510-26397-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

The I2C controllers on Baytrail can get the clock from
100MHz or 133MHz source clock. The first bits in the private
clock parameter register indicates which one is being used.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index db3498b..b693098 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -84,6 +84,7 @@ static struct lpss_device_desc lpss_dma_desc = {
 struct lpss_private_data {
 	void __iomem *mmio_base;
 	resource_size_t mmio_size;
+	unsigned int fixed_clk_rate;
 	struct clk *clk;
 	const struct lpss_device_desc *dev_desc;
 	u32 prv_reg_ctx[LPSS_PRV_REG_COUNT];
@@ -103,7 +104,7 @@ static void lpss_uart_setup(struct lpss_private_data *pdata)
 	writel(reg | LPSS_GENERAL_UART_RTS_OVRD, pdata->mmio_base + offset);
 }
 
-static void lpss_i2c_setup(struct lpss_private_data *pdata)
+static void byt_i2c_setup(struct lpss_private_data *pdata)
 {
 	unsigned int offset;
 	u32 val;
@@ -112,6 +113,9 @@ static void lpss_i2c_setup(struct lpss_private_data *pdata)
 	val = readl(pdata->mmio_base + offset);
 	val |= LPSS_RESETS_RESET_APB | LPSS_RESETS_RESET_FUNC;
 	writel(val, pdata->mmio_base + offset);
+
+	if (readl(pdata->mmio_base + pdata->dev_desc->prv_offset))
+		pdata->fixed_clk_rate = 133000000;
 }
 
 static struct lpss_device_desc lpt_dev_desc = {
@@ -161,16 +165,10 @@ static struct lpss_device_desc byt_sdio_dev_desc = {
 	.flags = LPSS_CLK,
 };
 
-static struct lpss_shared_clock i2c_clock = {
-	.name = "i2c_clk",
-	.rate = 100000000,
-};
-
 static struct lpss_device_desc byt_i2c_dev_desc = {
 	.flags = LPSS_CLK | LPSS_SAVE_CTX,
 	.prv_offset = 0x800,
-	.shared_clock = &i2c_clock,
-	.setup = lpss_i2c_setup,
+	.setup = byt_i2c_setup,
 };
 
 static struct lpss_shared_clock bsw_pwm_clock = {
@@ -286,6 +284,12 @@ static int register_device_clock(struct acpi_device *adev,
 		parent = shared_clock->name;
 	}
 
+	if (pdata->fixed_clk_rate) {
+		clk = clk_register_fixed_rate(NULL, devname, parent, 0,
+					      pdata->fixed_clk_rate);
+		goto out;
+	}
+
 	if (dev_desc->flags & LPSS_CLK_GATE) {
 		clk = clk_register_gate(NULL, devname, parent, 0,
 					prv_base, 0, 0, NULL);
@@ -316,7 +320,7 @@ static int register_device_clock(struct acpi_device *adev,
 		kfree(parent);
 		kfree(clk_name);
 	}
-
+out:
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
@@ -364,6 +368,9 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 
 	pdata->dev_desc = dev_desc;
 
+	if (dev_desc->setup)
+		dev_desc->setup(pdata);
+
 	if (dev_desc->flags & LPSS_CLK) {
 		ret = register_device_clock(adev, pdata);
 		if (ret) {
@@ -385,9 +392,6 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 		goto err_out;
 	}
 
-	if (dev_desc->setup)
-		dev_desc->setup(pdata);
-
 	adev->driver_data = pdata;
 	pdev = acpi_create_platform_device(adev);
 	if (!IS_ERR_OR_NULL(pdev)) {
-- 
2.1.0

