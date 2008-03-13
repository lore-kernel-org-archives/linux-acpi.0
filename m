From: Corentin CHARY <corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>
Subject: [PATCH 2/3] eeepc-laptop: add backlight
Date: Thu, 13 Mar 2008 12:56:37 +0100
Message-ID: <200803131256.37295.corentincj@iksaif.net>
References: <200803131254.01518.corentincj@iksaif.net>
Reply-To: corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200803131254.01518.corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, eeecommunity-donated-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Corentin Chary <corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>

Add backlight class support to the eeepc-laptop driver.

Signed-off-by: Corentin Chary <corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>
---

 Kconfig        |    1 
 eeepc-laptop.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

--- a/drivers/misc/eeepc-laptop.c	2008-03-11 10:34:45.000000000 +0100
+++ b/drivers/misc/eeepc-laptop.c	2008-03-11 10:35:37.000000000 +0100
@@ -21,6 +21,8 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
+#include <linux/backlight.h>
+#include <linux/fb.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
@@ -43,6 +45,8 @@
  * Definitions for Asus EeePC
  */
 #define	NOTIFY_WLAN_ON	0x10
+#define NOTIFY_BRN_MIN	0x20
+#define NOTIFY_BRN_MAX	0x2f
 
 enum {
 	DISABLE_ASL_WLAN = 0x0001,
@@ -147,6 +151,19 @@
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
 MODULE_AUTHOR("Eric Cooper, Andrew Tipton, Corentin Chary");
 MODULE_DESCRIPTION(EEEPC_HOTK_NAME);
 MODULE_LICENSE("GPL");
@@ -211,6 +228,25 @@
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
@@ -328,12 +364,20 @@
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
@@ -387,8 +431,16 @@
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
@@ -396,6 +448,26 @@
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
@@ -411,6 +483,9 @@
 		return -ENODEV;
 	}
 	dev = acpi_get_physical_device(ehotk->device->handle);
+	result = eeepc_backlight_init(dev);
+	if (result)
+		goto fail_backlight;
 	/* Register platform stuff */
 	result = platform_driver_register(&platform_driver);
 	if (result)
@@ -435,6 +510,8 @@
 fail_platform_device1:
 	platform_driver_unregister(&platform_driver);
 fail_platform_driver:
+	eeepc_backlight_exit();
+fail_backlight:
 	return result;
 }
 
--- a/drivers/misc/Kconfig	2008-03-11 10:34:42.000000000 +0100
+++ b/drivers/misc/Kconfig	2008-03-11 18:35:23.000000000 +0100
@@ -236,6 +236,7 @@
 	tristate "Eee PC Hotkey Driver (EXPERIMENTAL)"
 	depends on X86
 	depends on ACPI
+	depends on BACKLIGHT_CLASS_DEVICE
 	depends on EXPERIMENTAL
 	---help---
 	  This driver supports the Fn-Fx keys on Eee PC laptops.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
