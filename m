From: Brandon Anderson <brandon.anderson@amd.com>
Subject: [PATCH 3/4] ACPI/ARM: Add ACPI to AMBA SPI driver
Date: Mon, 11 Nov 2013 11:16:09 -0600
Message-ID: <1384190170-8707-4-git-send-email-brandon.anderson@amd.com>
References: <1384190170-8707-1-git-send-email-brandon.anderson@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-db8lp0189.outbound.messaging.microsoft.com ([213.199.154.189]:25590
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754077Ab3KKRRd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Nov 2013 12:17:33 -0500
In-Reply-To: <1384190170-8707-1-git-send-email-brandon.anderson@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ssg.sos.patches@amd.com, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org
Cc: Brandon Anderson <brandon.anderson@amd.com>

Neither Foundation nor RTSM have a SPI device, but here are the necessary driver
changes as an example of how to use acpi_amba_dsm_lookup() to get non-standard
parameters from ACPI.

This was tested by wiring up a SPI device into an RTSM Fast Model.


Signed-off-by: Brandon Anderson <brandon.anderson@amd.com>
---
 drivers/spi/spi-pl022.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 9c511a9..75cff22 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -43,6 +43,7 @@
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/amba/acpi.h>
 
 /*
  * This macro is used to define some register default values.
@@ -2069,6 +2070,49 @@ pl022_platform_data_dt_get(struct device *dev)
 	return pd;
 }
 
+#ifdef CONFIG_ACPI
+static struct pl022_ssp_controller *
+acpi_pl022_get_platform_data(struct device *dev)
+{
+	struct pl022_ssp_controller *pd, *ret;
+	struct acpi_amba_dsm_entry entry;
+
+	pd = devm_kzalloc(dev, sizeof(struct pl022_ssp_controller), GFP_KERNEL);
+	if (!pd) {
+		dev_err(dev, "cannot allocate platform data memory\n");
+		return NULL;
+	}
+	ret = pd;
+
+	pd->bus_id = -1;
+	pd->enable_dma = 1;
+	if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev), "num-cs", 0, &entry) == 0) {
+		if (kstrtou8(entry.value, 0, &pd->num_chipselect) != 0) {
+			dev_err(dev, "invalid 'num-cs' in ACPI definition\n");
+			ret = NULL;
+		}
+		kfree(entry.key);
+		kfree(entry.value);
+	}
+	if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev),
+			"autosuspend-delay", 0, &entry) == 0) {
+		if (kstrtoint(entry.value, 0, &pd->autosuspend_delay) != 0) {
+			dev_err(dev, "invalid 'autosuspend-delay' in ACPI definition\n");
+			ret = NULL;
+		}
+		kfree(entry.key);
+		kfree(entry.value);
+	}
+	if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev), "rt", 0, &entry) == 0) {
+		pd->rt = (entry.value && strcmp(entry.value, "1") == 0);
+		kfree(entry.key);
+		kfree(entry.value);
+	}
+
+	return ret;
+}
+#endif
+
 static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct device *dev = &adev->dev;
@@ -2081,6 +2125,11 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 
 	dev_info(&adev->dev,
 		 "ARM PL022 driver, device ID: 0x%08x\n", adev->periphid);
+#ifdef CONFIG_ACPI
+	if (!platform_info && ACPI_HANDLE(dev))
+		platform_info = acpi_pl022_get_platform_data(dev);
+	else
+#endif
 	if (!platform_info && IS_ENABLED(CONFIG_OF))
 		platform_info = pl022_platform_data_dt_get(dev);
 
-- 
1.7.9.5


