From: akpm@osdl.org
Subject: [patch 7/8] Add support for the generic backlight device to the TOSHIBA ACPI driver
Date: Fri, 20 Oct 2006 14:30:29 -0700
Message-ID: <200610202130.k9KLUTm9003254@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:22912 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992739AbWJTVbE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Oct 2006 17:31:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, hmacht@suse.de, apw@shadowen.org

From: Holger Macht <hmacht@suse.de>

Add support for the generic backlight interface below /sys/class/backlight.
 The patch keeps the procfs brightness handling for backward compatibility.

For this to archive, the patch adds two generic functions get_lcd and
set_lcd to be used both by the procfs related and the sysfs related
methods.

[apw@shadowen.org: backlight users need to select BACKLIGHT_CLASS_DEVICE]
Signed-off-by: Holger Macht <hmacht@suse.de>
Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/Kconfig        |    1 
 drivers/acpi/toshiba_acpi.c |   88 +++++++++++++++++++++++++---------
 2 files changed, 66 insertions(+), 23 deletions(-)

diff -puN drivers/acpi/Kconfig~add-support-for-the-generic-backlight-device-to-the-toshiba-acpi-driver drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig~add-support-for-the-generic-backlight-device-to-the-toshiba-acpi-driver
+++ a/drivers/acpi/Kconfig
@@ -234,6 +234,7 @@ config ACPI_IBM_DOCK
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
 	depends on X86
+	select BACKLIGHT_CLASS_DEVICE
 	---help---
 	  This driver adds support for access to certain system settings
 	  on "legacy free" Toshiba laptops.  These laptops can be recognized by
diff -puN drivers/acpi/toshiba_acpi.c~add-support-for-the-generic-backlight-device-to-the-toshiba-acpi-driver drivers/acpi/toshiba_acpi.c
--- a/drivers/acpi/toshiba_acpi.c~add-support-for-the-generic-backlight-device-to-the-toshiba-acpi-driver
+++ a/drivers/acpi/toshiba_acpi.c
@@ -41,6 +41,8 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/backlight.h>
+
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_drivers.h>
@@ -210,6 +212,7 @@ static acpi_status hci_read1(u32 reg, u3
 }
 
 static struct proc_dir_entry *toshiba_proc_dir /*= 0*/ ;
+static struct backlight_device *toshiba_backlight_device;
 static int force_fan;
 static int last_key_event;
 static int key_event_valid;
@@ -271,14 +274,23 @@ dispatch_write(struct file *file, const 
 	return result;
 }
 
-static char *read_lcd(char *p)
+static int get_lcd(struct backlight_device *bd)
 {
 	u32 hci_result;
 	u32 value;
 
 	hci_read1(HCI_LCD_BRIGHTNESS, &value, &hci_result);
 	if (hci_result == HCI_SUCCESS) {
-		value = value >> HCI_LCD_BRIGHTNESS_SHIFT;
+		return (value >> HCI_LCD_BRIGHTNESS_SHIFT);
+	} else
+		return -EFAULT;
+}
+
+static char *read_lcd(char *p)
+{
+	int value = get_lcd(NULL);
+
+	if (value >= 0) {
 		p += sprintf(p, "brightness:              %d\n", value);
 		p += sprintf(p, "brightness_levels:       %d\n",
 			     HCI_LCD_BRIGHTNESS_LEVELS);
@@ -289,22 +301,34 @@ static char *read_lcd(char *p)
 	return p;
 }
 
+static int set_lcd(int value)
+{
+	u32 hci_result;
+
+	value = value << HCI_LCD_BRIGHTNESS_SHIFT;
+	hci_write1(HCI_LCD_BRIGHTNESS, value, &hci_result);
+	if (hci_result != HCI_SUCCESS)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int set_lcd_status(struct backlight_device *bd)
+{
+	return set_lcd(bd->props->brightness);
+}
+
 static unsigned long write_lcd(const char *buffer, unsigned long count)
 {
 	int value;
-	u32 hci_result;
+	int ret = count;
 
 	if (sscanf(buffer, " brightness : %i", &value) == 1 &&
-	    value >= 0 && value < HCI_LCD_BRIGHTNESS_LEVELS) {
-		value = value << HCI_LCD_BRIGHTNESS_SHIFT;
-		hci_write1(HCI_LCD_BRIGHTNESS, value, &hci_result);
-		if (hci_result != HCI_SUCCESS)
-			return -EFAULT;
-	} else {
-		return -EINVAL;
-	}
-
-	return count;
+	    value >= 0 && value < HCI_LCD_BRIGHTNESS_LEVELS)
+		ret = set_lcd(value);
+	else
+		ret = -EINVAL;
+	return ret;
 }
 
 static char *read_video(char *p)
@@ -506,6 +530,26 @@ static acpi_status __exit remove_device(
 	return AE_OK;
 }
 
+static struct backlight_properties toshiba_backlight_data = {
+        .owner          = THIS_MODULE,
+        .get_brightness = get_lcd,
+        .update_status  = set_lcd_status,
+        .max_brightness = HCI_LCD_BRIGHTNESS_LEVELS - 1,
+};
+
+static void __exit toshiba_acpi_exit(void)
+{
+	if (toshiba_backlight_device)
+		backlight_device_unregister(toshiba_backlight_device);
+
+	remove_device();
+
+	if (toshiba_proc_dir)
+		remove_proc_entry(PROC_TOSHIBA, acpi_root_dir);
+
+	return;
+}
+
 static int __init toshiba_acpi_init(void)
 {
 	acpi_status status = AE_OK;
@@ -546,17 +590,15 @@ static int __init toshiba_acpi_init(void
 			remove_proc_entry(PROC_TOSHIBA, acpi_root_dir);
 	}
 
-	return (ACPI_SUCCESS(status)) ? 0 : -ENODEV;
-}
-
-static void __exit toshiba_acpi_exit(void)
-{
-	remove_device();
-
-	if (toshiba_proc_dir)
-		remove_proc_entry(PROC_TOSHIBA, acpi_root_dir);
+	toshiba_backlight_device = backlight_device_register("toshiba", NULL,
+						&toshiba_backlight_data);
+        if (IS_ERR(toshiba_backlight_device)) {
+		printk(KERN_ERR "Could not register toshiba backlight device\n");
+		toshiba_backlight_device = NULL;
+		toshiba_acpi_exit();
+	}
 
-	return;
+	return (ACPI_SUCCESS(status)) ? 0 : -ENODEV;
 }
 
 module_init(toshiba_acpi_init);
_
