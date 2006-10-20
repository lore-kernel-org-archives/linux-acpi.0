From: akpm@osdl.org
Subject: [patch 6/8] Add support for the generic backlight device to the ASUS ACPI driver
Date: Fri, 20 Oct 2006 14:30:29 -0700
Message-ID: <200610202130.k9KLUTG4003251@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:14464 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422979AbWJTVat (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Oct 2006 17:30:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, hmacht@suse.de, apw@shadowen.org

From: Holger Macht <hmacht@suse.de>

Add support for the generic backlight interface below /sys/class/backlight.
 The patch keeps the procfs brightness handling for backward compatibility.

[apw@shadowen.org: backlight users need to select BACKLIGHT_CLASS_DEVICE]
Signed-off-by: Holger Macht <hmacht@suse.de>
Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/Kconfig     |    1 
 drivers/acpi/asus_acpi.c |   62 +++++++++++++++++++++++++++----------
 2 files changed, 47 insertions(+), 16 deletions(-)

diff -puN drivers/acpi/Kconfig~add-support-for-the-generic-backlight-device-to-the-asus-acpi-driver drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig~add-support-for-the-generic-backlight-device-to-the-asus-acpi-driver
+++ a/drivers/acpi/Kconfig
@@ -179,6 +179,7 @@ config ACPI_NUMA
 config ACPI_ASUS
         tristate "ASUS/Medion Laptop Extras"
 	depends on X86
+	select BACKLIGHT_CLASS_DEVICE
         ---help---
           This driver provides support for extra features of ACPI-compatible
           ASUS laptops. As some of Medion laptops are made by ASUS, it may also
diff -puN drivers/acpi/asus_acpi.c~add-support-for-the-generic-backlight-device-to-the-asus-acpi-driver drivers/acpi/asus_acpi.c
--- a/drivers/acpi/asus_acpi.c~add-support-for-the-generic-backlight-device-to-the-asus-acpi-driver
+++ a/drivers/acpi/asus_acpi.c
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/backlight.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
@@ -402,6 +403,8 @@ static struct model_data model_conf[END_
 /* procdir we use */
 static struct proc_dir_entry *asus_proc_dir;
 
+static struct backlight_device *asus_backlight_device;
+
 /*
  * This header is made available to allow proper configuration given model,
  * revision number , ... this info cannot go in struct asus_hotk because it is
@@ -779,7 +782,7 @@ proc_write_lcd(struct file *file, const 
 	return rv;
 }
 
-static int read_brightness(void)
+static int read_brightness(struct backlight_device *bd)
 {
 	int value;
 
@@ -801,9 +804,10 @@ static int read_brightness(void)
 /*
  * Change the brightness level
  */
-static void set_brightness(int value)
+static int set_brightness(int value)
 {
 	acpi_status status = 0;
+	int ret = 0;
 
 	/* SPLV laptop */
 	if (hotk->methods->brightness_set) {
@@ -811,11 +815,12 @@ static void set_brightness(int value)
 				    value, NULL))
 			printk(KERN_WARNING
 			       "Asus ACPI: Error changing brightness\n");
-		return;
+			ret = -EIO;
+		goto out;
 	}
 
 	/* No SPLV method if we are here, act as appropriate */
-	value -= read_brightness();
+	value -= read_brightness(NULL);
 	while (value != 0) {
 		status = acpi_evaluate_object(NULL, (value > 0) ?
 					      hotk->methods->brightness_up :
@@ -825,15 +830,22 @@ static void set_brightness(int value)
 		if (ACPI_FAILURE(status))
 			printk(KERN_WARNING
 			       "Asus ACPI: Error changing brightness\n");
+			ret = -EIO;
 	}
-	return;
+out:
+	return ret;
+}
+
+static int set_brightness_status(struct backlight_device *bd)
+{
+	return set_brightness(bd->props->brightness);
 }
 
 static int
 proc_read_brn(char *page, char **start, off_t off, int count, int *eof,
 	      void *data)
 {
-	return sprintf(page, "%d\n", read_brightness());
+	return sprintf(page, "%d\n", read_brightness(NULL));
 }
 
 static int
@@ -1333,6 +1345,26 @@ static int asus_hotk_remove(struct acpi_
 	return 0;
 }
 
+static struct backlight_properties asus_backlight_data = {
+        .owner          = THIS_MODULE,
+        .get_brightness = read_brightness,
+        .update_status  = set_brightness_status,
+        .max_brightness = 15,
+};
+
+static void __exit asus_acpi_exit(void)
+{
+	if (asus_backlight_device)
+		backlight_device_unregister(asus_backlight_device);
+
+	acpi_bus_unregister_driver(&asus_hotk_driver);
+	remove_proc_entry(PROC_ASUS, acpi_root_dir);
+
+	kfree(asus_info);
+
+	return;
+}
+
 static int __init asus_acpi_init(void)
 {
 	int result;
@@ -1370,17 +1402,15 @@ static int __init asus_acpi_init(void)
 		return result;
 	}
 
-	return 0;
-}
-
-static void __exit asus_acpi_exit(void)
-{
-	acpi_bus_unregister_driver(&asus_hotk_driver);
-	remove_proc_entry(PROC_ASUS, acpi_root_dir);
-
-	kfree(asus_info);
+	asus_backlight_device = backlight_device_register("asus", NULL,
+							  &asus_backlight_data);
+        if (IS_ERR(asus_backlight_device)) {
+		printk(KERN_ERR "Could not register asus backlight device\n");
+		asus_backlight_device = NULL;
+		asus_acpi_exit();
+	}
 
-	return;
+	return 0;
 }
 
 module_init(asus_acpi_init);
_
