From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] ACPI / FAN: do nothing in suspend and poweroff callback
Date: Wed, 19 Feb 2014 12:16:48 +0800
Message-ID: <20140219041648.GA3974@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26841 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275AbaBSEQ2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Feb 2014 23:16:28 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>

We put FAN to full speed in acpi_fan_suspend but that is only needed
in the hibernation case when we are generating hibernation image, so
this patch removes that when we are to suspend or poweroff.

Link: http://www.spinics.net/lists/linux-acpi/msg48636.html
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/fan.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 09e423f3d8ad..8acf53e62966 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -55,11 +55,16 @@ MODULE_DEVICE_TABLE(acpi, fan_device_ids);
 #ifdef CONFIG_PM_SLEEP
 static int acpi_fan_suspend(struct device *dev);
 static int acpi_fan_resume(struct device *dev);
+static struct dev_pm_ops acpi_fan_pm = {
+	.resume = acpi_fan_resume,
+	.freeze = acpi_fan_suspend,
+	.thaw = acpi_fan_resume,
+	.restore = acpi_fan_resume,
+};
+#define FAN_PM_OPS_PTR (&acpi_fan_pm)
 #else
-#define acpi_fan_suspend NULL
-#define acpi_fan_resume NULL
+#define FAN_PM_OPS_PTR NULL
 #endif
-static SIMPLE_DEV_PM_OPS(acpi_fan_pm, acpi_fan_suspend, acpi_fan_resume);
 
 static struct acpi_driver acpi_fan_driver = {
 	.name = "fan",
@@ -69,7 +74,7 @@ static struct acpi_driver acpi_fan_driver = {
 		.add = acpi_fan_add,
 		.remove = acpi_fan_remove,
 		},
-	.drv.pm = &acpi_fan_pm,
+	.drv.pm = FAN_PM_OPS_PTR,
 };
 
 /* thermal cooling device callbacks */
-- 
1.8.5.3
