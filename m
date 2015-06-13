From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 02/12] ACPI / LPSS: constify device descriptors
Date: Sat, 13 Jun 2015 14:26:50 +0200
Message-ID: <1434198420-8519-3-git-send-email-minipli@googlemail.com>
References: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38213 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbbFMM1O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jun 2015 08:27:14 -0400
Received: by wibdq8 with SMTP id dq8so37102874wib.1
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jun 2015 05:27:13 -0700 (PDT)
In-Reply-To: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

The device descriptors are never written to -- even pointed to as
'const' from struct lpss_private_data. Make them r/o for real.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 drivers/acpi/acpi_lpss.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 37fb19047603..569ee090343f 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -129,50 +129,50 @@ static void byt_i2c_setup(struct lpss_private_data *pdata)
 	writel(0, pdata->mmio_base + LPSS_I2C_ENABLE);
 }
 
-static struct lpss_device_desc lpt_dev_desc = {
+static const struct lpss_device_desc lpt_dev_desc = {
 	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR,
 	.prv_offset = 0x800,
 };
 
-static struct lpss_device_desc lpt_i2c_dev_desc = {
+static const struct lpss_device_desc lpt_i2c_dev_desc = {
 	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_LTR,
 	.prv_offset = 0x800,
 };
 
-static struct lpss_device_desc lpt_uart_dev_desc = {
+static const struct lpss_device_desc lpt_uart_dev_desc = {
 	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR,
 	.clk_con_id = "baudclk",
 	.prv_offset = 0x800,
 	.setup = lpss_uart_setup,
 };
 
-static struct lpss_device_desc lpt_sdio_dev_desc = {
+static const struct lpss_device_desc lpt_sdio_dev_desc = {
 	.flags = LPSS_LTR,
 	.prv_offset = 0x1000,
 	.prv_size_override = 0x1018,
 };
 
-static struct lpss_device_desc byt_pwm_dev_desc = {
+static const struct lpss_device_desc byt_pwm_dev_desc = {
 	.flags = LPSS_SAVE_CTX,
 };
 
-static struct lpss_device_desc byt_uart_dev_desc = {
+static const struct lpss_device_desc byt_uart_dev_desc = {
 	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX,
 	.clk_con_id = "baudclk",
 	.prv_offset = 0x800,
 	.setup = lpss_uart_setup,
 };
 
-static struct lpss_device_desc byt_spi_dev_desc = {
+static const struct lpss_device_desc byt_spi_dev_desc = {
 	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX,
 	.prv_offset = 0x400,
 };
 
-static struct lpss_device_desc byt_sdio_dev_desc = {
+static const struct lpss_device_desc byt_sdio_dev_desc = {
 	.flags = LPSS_CLK,
 };
 
-static struct lpss_device_desc byt_i2c_dev_desc = {
+static const struct lpss_device_desc byt_i2c_dev_desc = {
 	.flags = LPSS_CLK | LPSS_SAVE_CTX,
 	.prv_offset = 0x800,
 	.setup = byt_i2c_setup,
@@ -323,14 +323,14 @@ out:
 static int acpi_lpss_create_device(struct acpi_device *adev,
 				   const struct acpi_device_id *id)
 {
-	struct lpss_device_desc *dev_desc;
+	const struct lpss_device_desc *dev_desc;
 	struct lpss_private_data *pdata;
 	struct resource_entry *rentry;
 	struct list_head resource_list;
 	struct platform_device *pdev;
 	int ret;
 
-	dev_desc = (struct lpss_device_desc *)id->driver_data;
+	dev_desc = (const struct lpss_device_desc *)id->driver_data;
 	if (!dev_desc) {
 		pdev = acpi_create_platform_device(adev);
 		return IS_ERR_OR_NULL(pdev) ? PTR_ERR(pdev) : 1;
-- 
1.7.10.4

