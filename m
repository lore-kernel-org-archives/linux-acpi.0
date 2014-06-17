From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] ACPI / LPSS: Take I2C host controllers out of reset
Date: Tue, 17 Jun 2014 14:33:39 +0300
Message-ID: <1403004819-8906-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12508 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbaFQLdm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jun 2014 07:33:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Li Aubrey <aubrey.li@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

On Intel Baytrail, some I2C host controllers are held in reset when the OS
gets control. This causes the driver to fail to detect the hardware
properly.

Fix this so that we make sure that the I2C host controller is not in reset
when the driver gets probe'd.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 63407d264885..9cb65b0e7597 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -34,6 +34,9 @@ ACPI_MODULE_NAME("acpi_lpss");
 
 /* Offsets relative to LPSS_PRIVATE_OFFSET */
 #define LPSS_CLK_DIVIDER_DEF_MASK	(BIT(1) | BIT(16))
+#define LPSS_RESETS			0x04
+#define LPSS_RESETS_RESET_FUNC		BIT(0)
+#define LPSS_RESETS_RESET_APB		BIT(1)
 #define LPSS_GENERAL			0x08
 #define LPSS_GENERAL_LTR_MODE_SW	BIT(2)
 #define LPSS_GENERAL_UART_RTS_OVRD	BIT(3)
@@ -99,6 +102,17 @@ static void lpss_uart_setup(struct lpss_private_data *pdata)
 	writel(reg | LPSS_GENERAL_UART_RTS_OVRD, pdata->mmio_base + offset);
 }
 
+static void lpss_i2c_setup(struct lpss_private_data *pdata)
+{
+	unsigned int offset;
+	u32 val;
+
+	offset = pdata->dev_desc->prv_offset + LPSS_RESETS;
+	val = readl(pdata->mmio_base + offset);
+	val |= LPSS_RESETS_RESET_APB | LPSS_RESETS_RESET_FUNC;
+	writel(val, pdata->mmio_base + offset);
+}
+
 static struct lpss_device_desc lpt_dev_desc = {
 	.clk_required = true,
 	.prv_offset = 0x800,
@@ -171,6 +185,7 @@ static struct lpss_device_desc byt_i2c_dev_desc = {
 	.prv_offset = 0x800,
 	.save_ctx = true,
 	.shared_clock = &i2c_clock,
+	.setup = lpss_i2c_setup,
 };
 
 #else
-- 
2.0.0

