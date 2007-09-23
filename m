From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 9/9] ACPI: thinkpad-acpi: duplicate driver attributes to new hwmon pdrv
Date: Sun, 23 Sep 2007 11:39:07 -0300
Message-ID: <119055834871-git-send-email-hmh@hmh.eng.br>
References: <11905583473293-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43197 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754084AbXIWOjP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Sep 2007 10:39:15 -0400
In-Reply-To: <11905583473293-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Thinkpad-acpi has some driver attributes (debug level, sysfs interface
version, etc) that also belong to the new hwmon driver.  Duplicate them
there.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |    8 +++++++-
 drivers/misc/thinkpad_acpi.h |    1 +
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index a0d9925..5d51c03 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -4803,12 +4803,16 @@ static int __init thinkpad_acpi_module_init(void)
 	tp_features.sensors_pdrv_registered = 1;
 
 	ret = tpacpi_create_driver_attributes(&tpacpi_pdriver.driver);
+	if (!ret) {
+		tp_features.platform_drv_attrs_registered = 1;
+		ret = tpacpi_create_driver_attributes(&tpacpi_hwmon_pdriver.driver);
+	}
 	if (ret) {
 		printk(IBM_ERR "unable to create sysfs driver attributes\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
-	tp_features.platform_drv_attrs_registered = 1;
+	tp_features.sensors_pdrv_attrs_registered = 1;
 
 
 	/* Device initialization */
@@ -4919,6 +4923,8 @@ static void thinkpad_acpi_module_exit(void)
 	if (tpacpi_pdev)
 		platform_device_unregister(tpacpi_pdev);
 
+	if (tp_features.sensors_pdrv_attrs_registered)
+		tpacpi_remove_driver_attributes(&tpacpi_hwmon_pdriver.driver);
 	if (tp_features.platform_drv_attrs_registered)
 		tpacpi_remove_driver_attributes(&tpacpi_pdriver.driver);
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 791b8ca..c5fdd68 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -252,6 +252,7 @@ static struct {
 	u32 platform_drv_registered:1;
 	u32 platform_drv_attrs_registered:1;
 	u32 sensors_pdrv_registered:1;
+	u32 sensors_pdrv_attrs_registered:1;
 	u32 sensors_pdev_attrs_registered:1;
 } tp_features;
 
-- 
1.5.3.1

