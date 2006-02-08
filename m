From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] Make asus_acpi use generic backlight infrastructure
Date: Wed, 8 Feb 2006 16:13:03 +0000
Message-ID: <20060208161303.GA28963@srcf.ucam.org>
References: <20060208161056.GA28922@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:31118 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1161096AbWBHQNL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Feb 2006 11:13:11 -0500
Content-Disposition: inline
In-Reply-To: <20060208161056.GA28922@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: sziwan@hell.org.pl
Cc: linux-acpi@vger.kernel.org

The included patch makes it possible to alter the brightness through 
/sys/class/backlight on machines which support asus_acpi.

Signed-Off-By: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index 7e9913f..3d320fd 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -38,6 +38,8 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/backlight.h>
+#include <linux/err.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
@@ -82,6 +84,8 @@ MODULE_PARM_DESC(uid, "UID for entries i
 module_param(asus_gid, uint, 0);
 MODULE_PARM_DESC(gid, "GID for entries in /proc/acpi/asus.\n");
 
+static struct backlight_device *asus_backlight_device;
+
 /* For each model, all features implemented, 
  * those marked with R are relative to HOTK, A for absolute */
 struct model_data {
@@ -689,7 +693,7 @@ proc_write_lcd(struct file *file, const 
 	return count;
 }
 
-static int read_brightness(void)
+static int read_brightness(struct backlight_device *bd)
 {
 	int value;
 
@@ -711,10 +715,13 @@ static int read_brightness(void)
 /*
  * Change the brightness level
  */
-static void set_brightness(int value)
+static void set_brightness(struct backlight_device *bd, int value)
 {
 	acpi_status status = 0;
 
+	value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
+	/* 0 <= value <= 15 */
+
 	/* SPLV laptop */
 	if (hotk->methods->brightness_set) {
 		if (!write_acpi_int(hotk->handle, hotk->methods->brightness_set,
@@ -725,7 +732,7 @@ static void set_brightness(int value)
 	}
 
 	/* No SPLV method if we are here, act as appropriate */
-	value -= read_brightness();
+	value -= read_brightness(NULL);
 	while (value != 0) {
 		status = acpi_evaluate_object(NULL, (value > 0) ?
 					      hotk->methods->brightness_up :
@@ -743,7 +750,7 @@ static int
 proc_read_brn(char *page, char **start, off_t off, int count, int *eof,
 	      void *data)
 {
-	return sprintf(page, "%d\n", read_brightness());
+	return sprintf(page, "%d\n", read_brightness(NULL));
 }
 
 static int
@@ -754,9 +761,7 @@ proc_write_brn(struct file *file, const 
 
 	count = parse_arg(buffer, count, &value);
 	if (count > 0) {
-		value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
-		/* 0 <= value <= 15 */
-		set_brightness(value);
+		set_brightness(NULL,value);
 	} else if (count < 0) {
 		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 	}
@@ -1205,6 +1210,13 @@ static int asus_hotk_remove(struct acpi_
 	return 0;
 }
 
+static struct backlight_properties asusbl_data = {
+	.owner          = THIS_MODULE,
+	.get_brightness = read_brightness,
+	.set_brightness = set_brightness,
+	.max_brightness = 15,
+};
+
 static int __init asus_acpi_init(void)
 {
 	int result;
@@ -1230,11 +1242,24 @@ static int __init asus_acpi_init(void)
 		return -ENODEV;
 	}
 
+	asus_backlight_device = backlight_device_register ("asus_bl", NULL,
+							   &asusbl_data);
+
+	if (IS_ERR (asus_backlight_device)) {
+		printk("Unable to register backlight\n");
+		acpi_bus_unregister_driver(&asus_hotk_driver);
+		remove_proc_entry(PROC_ASUS, acpi_root_dir);
+		
+		acpi_os_free(asus_info);
+		return -ENODEV;
+	}
+
 	return 0;
 }
 
 static void __exit asus_acpi_exit(void)
 {
+	backlight_device_unregister(asus_backlight_device);
 	acpi_bus_unregister_driver(&asus_hotk_driver);
 	remove_proc_entry(PROC_ASUS, acpi_root_dir);

-- 
Matthew Garrett | mjg59@srcf.ucam.org
