From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] ACPI / LPSS: mask the UART TX completion interrupt
Date: Mon, 17 Jun 2013 13:25:46 +0300
Message-ID: <1371464746-28500-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:54523 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932300Ab3FQKXC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Jun 2013 06:23:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

Intel LPSS provides an extra TX byte counter and an extra TX
completion interrupt for some of it's bus controllers. This
masks out the extra UART interrupt as there is no use for it.

Otherwise, if the firmware does not mask the interrupt and
the driver does not clear it, it may cause interrupt flood
that freezes the board.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index f6d7605..bd9867f 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -32,6 +32,8 @@ ACPI_MODULE_NAME("acpi_lpss");
 #define LPSS_GENERAL_LTR_MODE_SW	BIT(2)
 #define LPSS_SW_LTR			0x10
 #define LPSS_AUTO_LTR			0x14
+#define LPSS_TX_INT			0x20
+#define LPSS_TX_INT_MASK		BIT(1)
 
 struct lpss_shared_clock {
 	const char *name;
@@ -39,6 +41,8 @@ struct lpss_shared_clock {
 	struct clk *clk;
 };
 
+struct lpss_private_data;
+
 struct lpss_device_desc {
 	bool clk_required;
 	const char *clkdev_name;
@@ -46,6 +50,7 @@ struct lpss_device_desc {
 	unsigned int prv_offset;
 	bool clk_gate;
 	struct lpss_shared_clock *shared_clock;
+	void (*setup)(struct lpss_private_data *pdata);
 };
 
 static struct lpss_device_desc lpss_dma_desc = {
@@ -60,6 +65,15 @@ struct lpss_private_data {
 	const struct lpss_device_desc *dev_desc;
 };
 
+static void lpss_uart_setup(struct lpss_private_data *pdata)
+{
+	unsigned int tx_int_offset = pdata->dev_desc->prv_offset + LPSS_TX_INT;
+	u32 reg;
+
+	reg = readl(pdata->mmio_base + tx_int_offset);
+	writel(reg | LPSS_TX_INT_MASK, pdata->mmio_base + tx_int_offset);
+}
+
 static struct lpss_device_desc lpt_dev_desc = {
 	.clk_required = true,
 	.prv_offset = 0x800,
@@ -67,6 +81,14 @@ static struct lpss_device_desc lpt_dev_desc = {
 	.clk_gate = true,
 };
 
+static struct lpss_device_desc lpt_uart_dev_desc = {
+	.clk_required = true,
+	.prv_offset = 0x800,
+	.ltr_required = true,
+	.clk_gate = true,
+	.setup = lpss_uart_setup,
+};
+
 static struct lpss_device_desc lpt_sdio_dev_desc = {
 	.prv_offset = 0x1000,
 	.ltr_required = true,
@@ -82,6 +104,7 @@ static struct lpss_device_desc byt_uart_dev_desc = {
 	.prv_offset = 0x800,
 	.clk_gate = true,
 	.shared_clock = &uart_clock,
+	.setup = lpss_uart_setup,
 };
 
 static struct lpss_shared_clock spi_clock = {
@@ -120,8 +143,8 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 	{ "INT33C1", (unsigned long)&lpt_dev_desc },
 	{ "INT33C2", (unsigned long)&lpt_dev_desc },
 	{ "INT33C3", (unsigned long)&lpt_dev_desc },
-	{ "INT33C4", (unsigned long)&lpt_dev_desc },
-	{ "INT33C5", (unsigned long)&lpt_dev_desc },
+	{ "INT33C4", (unsigned long)&lpt_uart_dev_desc },
+	{ "INT33C5", (unsigned long)&lpt_uart_dev_desc },
 	{ "INT33C6", (unsigned long)&lpt_sdio_dev_desc },
 	{ "INT33C7", },
 
@@ -247,6 +270,9 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 		}
 	}
 
+	if (dev_desc->setup)
+		dev_desc->setup(pdata);
+
 	adev->driver_data = pdata;
 	ret = acpi_create_platform_device(adev, id);
 	if (ret > 0)
-- 
1.8.3.1

