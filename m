From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCHv2 3/3] usb: dwc3: add ACPI support
Date: Thu, 25 Sep 2014 10:57:02 +0300
Message-ID: <1411631822-3177-1-git-send-email-heikki.krogerus@linux.intel.com>
References: <20140924145053.GC17997@saruman>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47474 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbaIYH5c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Sep 2014 03:57:32 -0400
In-Reply-To: <20140924145053.GC17997@saruman>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Adding ACPI ID used on newer Intel SoCs.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/dwc3/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index d08cac5..88e29f5 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
+#include <linux/acpi.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -960,12 +961,24 @@ static const struct of_device_id of_dwc3_match[] = {
 MODULE_DEVICE_TABLE(of, of_dwc3_match);
 #endif
 
+#ifdef CONFIG_ACPI
+
+#define ACPI_ID_INTEL_BSW	"808622B7"
+
+static const struct acpi_device_id dwc3_acpi_match[] = {
+	{ ACPI_ID_INTEL_BSW, 0 },
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

