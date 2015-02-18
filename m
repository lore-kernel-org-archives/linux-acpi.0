From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/2] ACPI / LPSS: Always disable I2C host controllers
Date: Wed, 18 Feb 2015 13:50:16 +0200
Message-ID: <1424260217-7719-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Yang A Fang <yang.a.fang@intel.com>, Yu Chen <yu.c.chen@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Baytrail and Braswell the BIOS might leave the I2C host controllers
enabled, probably because it uses them for its on purposes. This is fine in
normal cases because the I2C driver will disable the hardware when it is
probed anyway.

However, in case of suspend to disk it is different story. If the driver
happens to be compiled as module the boot kernel never loads the driver
thus leaving host controllers enabled upon loading the hibernation image.

The I2C host controller interrupt mask register has default value of 0x8ff,
in other words it has most of the interrupts unmasked. When combined with
the fact that the host controller is enabled, the driver immediately starts
getting interrupts even before its resume hook is called (once IO-APIC is
resumed). Since the driver is not prepared for this it will crash the
kernel due to NULL pointer derefence because dev->msgs is NULL.

Unfortunately we were not able to get full backtrace to from the console
which could be reproduced here.

In order to fix this even when the driver is compiled as module, we disable
the I2C host controllers in byt_i2c_setup() before devices are created.

Reported-by: Yu Chen <yu.c.chen@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index e75737fd7eef..64ccc3bb0826 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -105,6 +105,8 @@ static void lpss_uart_setup(struct lpss_private_data *pdata)
 	}
 }
 
+#define LPSS_I2C_ENABLE			0x6c
+
 static void byt_i2c_setup(struct lpss_private_data *pdata)
 {
 	unsigned int offset;
@@ -117,6 +119,8 @@ static void byt_i2c_setup(struct lpss_private_data *pdata)
 
 	if (readl(pdata->mmio_base + pdata->dev_desc->prv_offset))
 		pdata->fixed_clk_rate = 133000000;
+
+	writel(0, pdata->mmio_base + LPSS_I2C_ENABLE);
 }
 
 static struct lpss_device_desc lpt_dev_desc = {
-- 
2.1.4
