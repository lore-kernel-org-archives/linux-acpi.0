From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/2] ACPI / LPSS: Deassert resets for SPI host controllers on Braswell
Date: Wed, 18 Feb 2015 13:50:17 +0200
Message-ID: <1424260217-7719-2-git-send-email-mika.westerberg@linux.intel.com>
References: <1424260217-7719-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424260217-7719-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Yang A Fang <yang.a.fang@intel.com>, Yu Chen <yu.c.chen@intel.com>
List-Id: linux-acpi@vger.kernel.org

On some Braswell systems BIOS leaves resets for SPI host controllers
active. This prevents the SPI driver from transferring messages on wire.

Fix this in similar way that we do for I2C already by deasserting resets
for the SPI host controllers.

Reported-by: Yang A Fang <yang.a.fang@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 64ccc3bb0826..7d5880ded78a 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -105,9 +105,7 @@ static void lpss_uart_setup(struct lpss_private_data *pdata)
 	}
 }
 
-#define LPSS_I2C_ENABLE			0x6c
-
-static void byt_i2c_setup(struct lpss_private_data *pdata)
+static void lpss_deassert_reset(struct lpss_private_data *pdata)
 {
 	unsigned int offset;
 	u32 val;
@@ -116,6 +114,13 @@ static void byt_i2c_setup(struct lpss_private_data *pdata)
 	val = readl(pdata->mmio_base + offset);
 	val |= LPSS_RESETS_RESET_APB | LPSS_RESETS_RESET_FUNC;
 	writel(val, pdata->mmio_base + offset);
+}
+
+#define LPSS_I2C_ENABLE			0x6c
+
+static void byt_i2c_setup(struct lpss_private_data *pdata)
+{
+	lpss_deassert_reset(pdata);
 
 	if (readl(pdata->mmio_base + pdata->dev_desc->prv_offset))
 		pdata->fixed_clk_rate = 133000000;
@@ -170,6 +175,12 @@ static struct lpss_device_desc byt_i2c_dev_desc = {
 	.setup = byt_i2c_setup,
 };
 
+static struct lpss_device_desc bsw_spi_dev_desc = {
+	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX,
+	.prv_offset = 0x400,
+	.setup = lpss_deassert_reset,
+};
+
 #else
 
 #define LPSS_ADDR(desc) (0UL)
@@ -202,7 +213,7 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 	/* Braswell LPSS devices */
 	{ "80862288", LPSS_ADDR(byt_pwm_dev_desc) },
 	{ "8086228A", LPSS_ADDR(byt_uart_dev_desc) },
-	{ "8086228E", LPSS_ADDR(byt_spi_dev_desc) },
+	{ "8086228E", LPSS_ADDR(bsw_spi_dev_desc) },
 	{ "808622C1", LPSS_ADDR(byt_i2c_dev_desc) },
 
 	{ "INT3430", LPSS_ADDR(lpt_dev_desc) },
-- 
2.1.4
