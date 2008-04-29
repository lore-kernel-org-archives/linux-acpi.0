From: Len Brown <lenb@kernel.org>
Subject: [PATCH 086/171] eeepc-laptop: add backlight
Date: Tue, 29 Apr 2008 04:44:07 -0400
Message-ID: <6cfeddbe70c9a135c006bee3b883037ab389368c.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:45231 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756336AbYD2Io7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:44:59 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Add backlight class support to the eeepc-laptop driver.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/Kconfig        |    1 +
 drivers/misc/eeepc-laptop.c |   77 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 10c5ecf..e9ab291 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -331,6 +331,7 @@ config EEEPC_LAPTOP
 	tristate "Eee PC Hotkey Driver (EXPERIMENTAL)"
 	depends on X86
 	depends on ACPI
+	depends on BACKLIGHT_CLASS_DEVICE
 	depends on EXPERIMENTAL
 	---help---
 	  This driver supports the Fn-Fx keys on Eee PC laptops.
diff --git a/drivers/misc/eeepc-laptop.c b/drivers/misc/eeepc-laptop.c
index e34ff97..2b59b7e 100644
--- a/drivers/misc/eeepc-laptop.c
+++ b/drivers/misc/eeepc-laptop.c
@@ -21,6 +21,8 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
+#include <linux/backlight.h>
+#include <linux/fb.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 #include <linux/uaccess.h>
@@ -43,6 +45,8 @@
  * Definitions for Asus EeePC
  */
 #define	NOTIFY_WLAN_ON	0x10
+#define NOTIFY_BRN_MIN	0x20
+#define NOTIFY_BRN_MAX	0x2f
 
 enum {
 	DISABLE_ASL_WLAN = 0x0001,
@@ -147,6 +151,19 @@ static struct acpi_driver eeepc_hotk_driver = {
 	},
 };
 
+/* The backlight device /sys/class/backlight */
+static struct backlight_device *eeepc_backlight_device;
+
+/*
+ * The backlight class declaration
+ */
+static int read_brightness(struct backlight_device *bd);
+static int update_bl_status(struct backlight_device *bd);
+static struct backlight_ops eeepcbl_ops = {
+	.get_brightness = read_brightness,
+	.update_status = update_bl_status,
+};
+
 MODULE_AUTHOR("Corentin Chary, Eric Cooper");
 MODULE_DESCRIPTION(EEEPC_HOTK_NAME);
 MODULE_LICENSE("GPL");
@@ -211,6 +228,25 @@ static int get_acpi(int cm)
 }
 
 /*
+ * Backlight
+ */
+static int read_brightness(struct backlight_device *bd)
+{
+	return get_acpi(CM_ASL_PANELBRIGHT);
+}
+
+static int set_brightness(struct backlight_device *bd, int value)
+{
+	value = max(0, min(15, value));
+	return set_acpi(CM_ASL_PANELBRIGHT, value);
+}
+
+static int update_bl_status(struct backlight_device *bd)
+{
+	return set_brightness(bd, bd->props.brightness);
+}
+
+/*
  * Sys helpers
  */
 static int parse_arg(const char *buf, unsigned long count, int *val)
@@ -328,12 +364,20 @@ static void notify_wlan(u32 *event)
 	}
 }
 
+static void notify_brn(void)
+{
+	struct backlight_device *bd = eeepc_backlight_device;
+	bd->props.brightness = read_brightness(bd);
+}
+
 static void eeepc_hotk_notify(acpi_handle handle, u32 event, void *data)
 {
 	if (!ehotk)
 		return;
 	if (event == NOTIFY_WLAN_ON && (DISABLE_ASL_WLAN & ehotk->init_flag))
 		notify_wlan(&event);
+	if (event >= NOTIFY_BRN_MIN && event <= NOTIFY_BRN_MAX)
+		notify_brn();
 	acpi_bus_generate_proc_event(ehotk->device, event,
 				     ehotk->event_count[event % 128]++);
 }
@@ -387,8 +431,16 @@ static int eeepc_hotk_remove(struct acpi_device *device, int type)
 /*
  * exit/init
  */
+static void eeepc_backlight_exit(void)
+{
+	if (eeepc_backlight_device)
+		backlight_device_unregister(eeepc_backlight_device);
+	eeepc_backlight_device = NULL;
+}
+
 static void __exit eeepc_laptop_exit(void)
 {
+	eeepc_backlight_exit();
 	acpi_bus_unregister_driver(&eeepc_hotk_driver);
 	sysfs_remove_group(&platform_device->dev.kobj,
 			   &platform_attribute_group);
@@ -396,6 +448,26 @@ static void __exit eeepc_laptop_exit(void)
 	platform_driver_unregister(&platform_driver);
 }
 
+static int eeepc_backlight_init(struct device *dev)
+{
+	struct backlight_device *bd;
+
+	bd = backlight_device_register(EEEPC_HOTK_FILE, dev,
+				       NULL, &eeepcbl_ops);
+	if (IS_ERR(bd)) {
+		printk(EEEPC_ERR
+		       "Could not register eeepc backlight device\n");
+		eeepc_backlight_device = NULL;
+		return PTR_ERR(bd);
+	}
+	eeepc_backlight_device = bd;
+	bd->props.max_brightness = 15;
+	bd->props.brightness = read_brightness(NULL);
+	bd->props.power = FB_BLANK_UNBLANK;
+	backlight_update_status(bd);
+	return 0;
+}
+
 static int __init eeepc_laptop_init(void)
 {
 	struct device *dev;
@@ -411,6 +483,9 @@ static int __init eeepc_laptop_init(void)
 		return -ENODEV;
 	}
 	dev = acpi_get_physical_device(ehotk->device->handle);
+	result = eeepc_backlight_init(dev);
+	if (result)
+		goto fail_backlight;
 	/* Register platform stuff */
 	result = platform_driver_register(&platform_driver);
 	if (result)
@@ -435,6 +510,8 @@ fail_platform_device2:
 fail_platform_device1:
 	platform_driver_unregister(&platform_driver);
 fail_platform_driver:
+	eeepc_backlight_exit();
+fail_backlight:
 	return result;
 }
 
-- 
1.5.5.1.99.gf0ec4

