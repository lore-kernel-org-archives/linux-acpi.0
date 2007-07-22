From: Len Brown <len.brown@intel.com>
Subject: [PATCH 49/77] ACPI: thinkpad-acpi: register input device
Date: Sun, 22 Jul 2007 05:14:34 -0400
Message-ID: <11850957531914-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
 <11850957482671-git-send-email-len.brown@intel.com>
 <11850957491254-git-send-email-len.brown@intel.com>
 <11850957503243-git-send-email-len.brown@intel.com>
 <1185095751279-git-send-email-len.brown@intel.com>
 <11850957522609-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22481 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763491AbXGVJPz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:55 -0400
In-Reply-To: <11850957522609-git-send-email-len.brown@intel.com>
Message-Id: <7f5d1cd6287b7b29d210f85e2343207ac4310da2.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hughes <hughsient@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Register an input device to send input events to userspace.

This patch is based on a patch by Richard Hughes <hughsient@gmail.com>.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Richard Hughes <hughsient@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   32 +++++++++++++++++++++++++++++++-
 drivers/misc/thinkpad_acpi.h |    9 +++++++++
 2 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 4d71893..4427c99 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -510,13 +510,14 @@ static char *next_cmd(char **cmds)
 /****************************************************************************
  ****************************************************************************
  *
- * Device model: hwmon and platform
+ * Device model: input, hwmon and platform
  *
  ****************************************************************************
  ****************************************************************************/
 
 static struct platform_device *tpacpi_pdev;
 static struct class_device *tpacpi_hwmon;
+static struct input_dev *tpacpi_inputdev;
 
 static struct platform_driver tpacpi_pdriver = {
 	.driver = {
@@ -4363,6 +4364,20 @@ static int __init thinkpad_acpi_module_init(void)
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
+	tpacpi_inputdev = input_allocate_device();
+	if (!tpacpi_inputdev) {
+		printk(IBM_ERR "unable to allocate input device\n");
+		thinkpad_acpi_module_exit();
+		return -ENOMEM;
+	} else {
+		/* Prepare input device, but don't register */
+		tpacpi_inputdev->name = "ThinkPad Extra Buttons";
+		tpacpi_inputdev->phys = IBM_DRVR_NAME "/input0";
+		tpacpi_inputdev->id.bustype = BUS_HOST;
+		tpacpi_inputdev->id.vendor = TPACPI_HKEY_INPUT_VENDOR;
+		tpacpi_inputdev->id.product = TPACPI_HKEY_INPUT_PRODUCT;
+		tpacpi_inputdev->id.version = TPACPI_HKEY_INPUT_VERSION;
+	}
 	for (i = 0; i < ARRAY_SIZE(ibms_init); i++) {
 		ret = ibm_init(&ibms_init[i]);
 		if (ret >= 0 && *ibms_init[i].param)
@@ -4372,6 +4387,14 @@ static int __init thinkpad_acpi_module_init(void)
 			return ret;
 		}
 	}
+	ret = input_register_device(tpacpi_inputdev);
+	if (ret < 0) {
+		printk(IBM_ERR "unable to register input device\n");
+		thinkpad_acpi_module_exit();
+		return ret;
+	} else {
+		tp_features.input_device_registered = 1;
+	}
 
 	return 0;
 }
@@ -4388,6 +4411,13 @@ static void thinkpad_acpi_module_exit(void)
 
 	dbg_printk(TPACPI_DBG_INIT, "finished subdriver exit path...\n");
 
+	if (tpacpi_inputdev) {
+		if (tp_features.input_device_registered)
+			input_unregister_device(tpacpi_inputdev);
+		else
+			input_free_device(tpacpi_inputdev);
+	}
+
 	if (tpacpi_hwmon)
 		hwmon_device_unregister(tpacpi_hwmon);
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 78ea4c8..00f1bd7 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -39,6 +39,7 @@
 #include <linux/platform_device.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/input.h>
 #include <asm/uaccess.h>
 
 #include <linux/dmi.h>
@@ -48,6 +49,7 @@
 #include <acpi/acpi_drivers.h>
 #include <acpi/acnamesp.h>
 
+#include <linux/pci_ids.h>
 
 /****************************************************************************
  * Main driver
@@ -98,6 +100,11 @@ static const char *str_supported(int is_supported);
 #define vdbg_printk(a_dbg_level, format, arg...)
 #endif
 
+/* Input IDs */
+#define TPACPI_HKEY_INPUT_VENDOR	PCI_VENDOR_ID_IBM
+#define TPACPI_HKEY_INPUT_PRODUCT	0x5054 /* "TP" */
+#define TPACPI_HKEY_INPUT_VERSION	0x4101
+
 /* ACPI HIDs */
 #define IBM_HKEY_HID    "IBM0068"
 #define IBM_PCI_HID     "PNP0A03"
@@ -161,6 +168,7 @@ static int parse_strtoul(const char *buf, unsigned long max,
 static struct platform_device *tpacpi_pdev;
 static struct class_device *tpacpi_hwmon;
 static struct platform_driver tpacpi_pdriver;
+static struct input_dev *tpacpi_inputdev;
 static int tpacpi_create_driver_attributes(struct device_driver *drv);
 static void tpacpi_remove_driver_attributes(struct device_driver *drv);
 
@@ -233,6 +241,7 @@ static struct {
 	u16 light_status:1;
 	u16 wan:1;
 	u16 fan_ctrl_status_undef:1;
+	u16 input_device_registered:1;
 } tp_features;
 
 static struct list_head tpacpi_all_drivers;
-- 
1.5.3.rc2.22.g69a9b
