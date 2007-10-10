From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/37] ACPI: thinkpad-acpi: duplicate driver attributes to new hwmon pdrv
Date: Wed, 10 Oct 2007 01:06:25 -0400
Message-ID: <1191992804-14965-19-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:19103 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751266AbXJJFG6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 01:06:58 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <2369cc9492a462285f9eec9d2bbfa730cc2ab5ac.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Thinkpad-acpi has some driver attributes (debug level, sysfs interface
version, etc) that also belong to the new hwmon driver.  Duplicate them
there.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |    8 +++++++-
 drivers/misc/thinkpad_acpi.h |    1 +
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index d5fb93e..81693b4 100644
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
1.5.3.4.206.g58ba4
