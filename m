From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4/4] usb: dwc3: add ACPI support
Date: Wed, 20 Aug 2014 14:55:28 +0300
Message-ID: <1408535728-10518-5-git-send-email-heikki.krogerus@linux.intel.com>
References: <1408535728-10518-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408535728-10518-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Adding ACPI ID used on newer Intel SoCs.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/dwc3/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3f307f6..6b0dcdb 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
+#include <linux/acpi.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -962,12 +963,21 @@ static const struct of_device_id of_dwc3_match[] = {
 MODULE_DEVICE_TABLE(of, of_dwc3_match);
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id dwc3_acpi_match[] = {
+	{ "808622B7", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);
+#endif
+
 static struct platform_driver dwc3_driver = {
 	.probe		= dwc3_probe,
 	.remove		= dwc3_remove,
 	.driver		= {
 		.name	= "dwc3",
 		.of_match_table	= of_match_ptr(of_dwc3_match),
+		.acpi_match_table = ACPI_PTR(dwc3_acpi_match),
 		.pm	= DWC3_PM_OPS,
 	},
 };
-- 
2.1.0
