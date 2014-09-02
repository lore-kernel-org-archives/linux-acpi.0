From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4/4] ACPI / LPSS: remove struct lpss_shared_clock
Date: Tue,  2 Sep 2014 10:55:10 +0300
Message-ID: <1409644510-26397-5-git-send-email-heikki.krogerus@linux.intel.com>
References: <1409644510-26397-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13203 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbaIBHzX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Sep 2014 03:55:23 -0400
In-Reply-To: <1409644510-26397-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

Nothing requires it anymore. The PWM driver no longer
uses clk framework to get the rate.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 39 ++-------------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index b693098..bcbdbd2 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -61,19 +61,12 @@ ACPI_MODULE_NAME("acpi_lpss");
 #define LPSS_LTR			BIT(3)
 #define LPSS_SAVE_CTX			BIT(4)
 
-struct lpss_shared_clock {
-	const char *name;
-	unsigned long rate;
-	struct clk *clk;
-};
-
 struct lpss_private_data;
 
 struct lpss_device_desc {
 	unsigned int flags;
 	unsigned int prv_offset;
 	size_t prv_size_override;
-	struct lpss_shared_clock *shared_clock;
 	void (*setup)(struct lpss_private_data *pdata);
 };
 
@@ -140,14 +133,8 @@ static struct lpss_device_desc lpt_sdio_dev_desc = {
 	.prv_size_override = 0x1018,
 };
 
-static struct lpss_shared_clock pwm_clock = {
-	.name = "pwm_clk",
-	.rate = 25000000,
-};
-
 static struct lpss_device_desc byt_pwm_dev_desc = {
-	.flags = LPSS_CLK | LPSS_SAVE_CTX,
-	.shared_clock = &pwm_clock,
+	.flags = LPSS_SAVE_CTX,
 };
 
 static struct lpss_device_desc byt_uart_dev_desc = {
@@ -171,16 +158,6 @@ static struct lpss_device_desc byt_i2c_dev_desc = {
 	.setup = byt_i2c_setup,
 };
 
-static struct lpss_shared_clock bsw_pwm_clock = {
-	.name = "pwm_clk",
-	.rate = 19200000,
-};
-
-static struct lpss_device_desc bsw_pwm_dev_desc = {
-	.flags = LPSS_CLK | LPSS_SAVE_CTX,
-	.shared_clock = &bsw_pwm_clock,
-};
-
 #else
 
 #define LPSS_ADDR(desc) (0UL)
@@ -211,7 +188,7 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 	{ "INT33FC", },
 
 	/* Braswell LPSS devices */
-	{ "80862288", LPSS_ADDR(bsw_pwm_dev_desc) },
+	{ "80862288", LPSS_ADDR(byt_pwm_dev_desc) },
 	{ "8086228A", LPSS_ADDR(byt_uart_dev_desc) },
 	{ "8086228E", LPSS_ADDR(byt_spi_dev_desc) },
 	{ "808622C1", LPSS_ADDR(byt_i2c_dev_desc) },
@@ -251,7 +228,6 @@ static int register_device_clock(struct acpi_device *adev,
 				 struct lpss_private_data *pdata)
 {
 	const struct lpss_device_desc *dev_desc = pdata->dev_desc;
-	struct lpss_shared_clock *shared_clock = dev_desc->shared_clock;
 	const char *devname = dev_name(&adev->dev);
 	struct clk *clk = ERR_PTR(-ENODEV);
 	struct lpss_clk_data *clk_data;
@@ -273,17 +249,6 @@ static int register_device_clock(struct acpi_device *adev,
 	parent = clk_data->name;
 	prv_base = pdata->mmio_base + dev_desc->prv_offset;
 
-	if (shared_clock) {
-		clk = shared_clock->clk;
-		if (!clk) {
-			clk = clk_register_fixed_rate(NULL, shared_clock->name,
-						      "lpss_clk", 0,
-						      shared_clock->rate);
-			shared_clock->clk = clk;
-		}
-		parent = shared_clock->name;
-	}
-
 	if (pdata->fixed_clk_rate) {
 		clk = clk_register_fixed_rate(NULL, devname, parent, 0,
 					      pdata->fixed_clk_rate);
-- 
2.1.0

