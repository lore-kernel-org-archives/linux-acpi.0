From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 1/9] asus-laptop: use pr_fmt and pr_<level>
Date: Fri, 19 Jun 2009 14:52:03 +0200
Message-ID: <1245415931-26466-1-git-send-email-corentincj@iksaif.net>
References: <alpine.LFD.2.00.0906180157380.8921@localhost.localdomain>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp21.orange.fr ([80.12.242.49]:23049 "EHLO smtp21.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869AbZFSMyl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Jun 2009 08:54:41 -0400
In-Reply-To: <alpine.LFD.2.00.0906180157380.8921@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Convert the unusual printk(ASUS_<level> uses to
the more standard pr_fmt and pr_<level>(.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/asus-laptop.c |   50 ++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index faa87d3..db657bb 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -33,6 +33,8 @@
  *  Sam Lin        - GPS support
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -53,9 +55,10 @@
 #define ASUS_HOTK_NAME          "Asus Laptop Support"
 #define ASUS_HOTK_CLASS         "hotkey"
 #define ASUS_HOTK_DEVICE_NAME   "Hotkey"
-#define ASUS_HOTK_FILE          "asus-laptop"
+#define ASUS_HOTK_FILE          KBUILD_MODNAME
 #define ASUS_HOTK_PREFIX        "\\_SB.ATKD."
 
+
 /*
  * Some events we use, same for all Asus
  */
@@ -327,7 +330,7 @@ static int read_wireless_status(int mask)
 
 	rv = acpi_evaluate_integer(wireless_status_handle, NULL, NULL, &status);
 	if (ACPI_FAILURE(rv))
-		printk(ASUS_WARNING "Error reading Wireless status\n");
+		pr_warning("Error reading Wireless status\n");
 	else
 		return (status & mask) ? 1 : 0;
 
@@ -341,7 +344,7 @@ static int read_gps_status(void)
 
 	rv = acpi_evaluate_integer(gps_status_handle, NULL, NULL, &status);
 	if (ACPI_FAILURE(rv))
-		printk(ASUS_WARNING "Error reading GPS status\n");
+		pr_warning("Error reading GPS status\n");
 	else
 		return status ? 1 : 0;
 
@@ -381,7 +384,7 @@ static void write_status(acpi_handle handle, int out, int mask)
 	}
 
 	if (write_acpi_int(handle, NULL, out, NULL))
-		printk(ASUS_WARNING " write failed %x\n", mask);
+		pr_warning(" write failed %x\n", mask);
 }
 
 /* /sys/class/led handlers */
@@ -424,7 +427,7 @@ static int set_lcd_state(int value)
 					      NULL, NULL, NULL);
 
 		if (ACPI_FAILURE(status))
-			printk(ASUS_WARNING "Error switching LCD\n");
+			pr_warning("Error switching LCD\n");
 	}
 
 	write_status(NULL, lcd, LCD_ON);
@@ -448,7 +451,7 @@ static int read_brightness(struct backlight_device *bd)
 
 	rv = acpi_evaluate_integer(brightness_get_handle, NULL, NULL, &value);
 	if (ACPI_FAILURE(rv))
-		printk(ASUS_WARNING "Error reading brightness\n");
+		pr_warning("Error reading brightness\n");
 
 	return value;
 }
@@ -461,7 +464,7 @@ static int set_brightness(struct backlight_device *bd, int value)
 	/* 0 <= value <= 15 */
 
 	if (write_acpi_int(brightness_set_handle, NULL, value, NULL)) {
-		printk(ASUS_WARNING "Error changing brightness\n");
+		pr_warning("Error changing brightness\n");
 		ret = -EIO;
 	}
 
@@ -591,7 +594,7 @@ static ssize_t store_ledd(struct device *dev, struct device_attribute *attr,
 	rv = parse_arg(buf, count, &value);
 	if (rv > 0) {
 		if (write_acpi_int(ledd_set_handle, NULL, value, NULL))
-			printk(ASUS_WARNING "LED display write failed\n");
+			pr_warning("LED display write failed\n");
 		else
 			hotk->ledd_status = (u32) value;
 	}
@@ -636,7 +639,7 @@ static void set_display(int value)
 {
 	/* no sanity check needed for now */
 	if (write_acpi_int(display_set_handle, NULL, value, NULL))
-		printk(ASUS_WARNING "Error setting display\n");
+		pr_warning("Error setting display\n");
 	return;
 }
 
@@ -651,7 +654,7 @@ static int read_display(void)
 		rv = acpi_evaluate_integer(display_get_handle, NULL,
 					   NULL, &value);
 		if (ACPI_FAILURE(rv))
-			printk(ASUS_WARNING "Error reading display status\n");
+			pr_warning("Error reading display status\n");
 	}
 
 	value &= 0x0F;		/* needed for some models, shouldn't hurt others */
@@ -693,7 +696,7 @@ static ssize_t store_disp(struct device *dev, struct device_attribute *attr,
 static void set_light_sens_switch(int value)
 {
 	if (write_acpi_int(ls_switch_handle, NULL, value, NULL))
-		printk(ASUS_WARNING "Error setting light sensor switch\n");
+		pr_warning("Error setting light sensor switch\n");
 	hotk->light_switch = value;
 }
 
@@ -718,7 +721,7 @@ static ssize_t store_lssw(struct device *dev, struct device_attribute *attr,
 static void set_light_sens_level(int value)
 {
 	if (write_acpi_int(ls_level_handle, NULL, value, NULL))
-		printk(ASUS_WARNING "Error setting light sensor level\n");
+		pr_warning("Error setting light sensor level\n");
 	hotk->light_level = value;
 }
 
@@ -979,11 +982,11 @@ static int asus_hotk_get_info(void)
 	 */
 	status = acpi_get_table(ACPI_SIG_DSDT, 1, &asus_info);
 	if (ACPI_FAILURE(status))
-		printk(ASUS_WARNING "Couldn't get the DSDT table header\n");
+		pr_warning("Couldn't get the DSDT table header\n");
 
 	/* We have to write 0 on init this far for all ASUS models */
 	if (write_acpi_int(hotk->handle, "INIT", 0, &buffer)) {
-		printk(ASUS_ERR "Hotkey initialization failed\n");
+		pr_err("Hotkey initialization failed\n");
 		return -ENODEV;
 	}
 
@@ -991,9 +994,9 @@ static int asus_hotk_get_info(void)
 	status =
 	    acpi_evaluate_integer(hotk->handle, "BSTS", NULL, &bsts_result);
 	if (ACPI_FAILURE(status))
-		printk(ASUS_WARNING "Error calling BSTS\n");
+		pr_warning("Error calling BSTS\n");
 	else if (bsts_result)
-		printk(ASUS_NOTICE "BSTS called, 0x%02x returned\n",
+		pr_notice("BSTS called, 0x%02x returned\n",
 		       (uint) bsts_result);
 
 	/* This too ... */
@@ -1024,7 +1027,7 @@ static int asus_hotk_get_info(void)
 		return -ENOMEM;
 
 	if (*string)
-		printk(ASUS_NOTICE "  %s model detected\n", string);
+		pr_notice("  %s model detected\n", string);
 
 	ASUS_HANDLE_INIT(mled_set);
 	ASUS_HANDLE_INIT(tled_set);
@@ -1081,7 +1084,7 @@ static int asus_input_init(void)
 
 	hotk->inputdev = input_allocate_device();
 	if (!hotk->inputdev) {
-		printk(ASUS_INFO "Unable to allocate input device\n");
+		pr_info("Unable to allocate input device\n");
 		return 0;
 	}
 	hotk->inputdev->name = "Asus Laptop extra buttons";
@@ -1100,7 +1103,7 @@ static int asus_input_init(void)
 	}
 	result = input_register_device(hotk->inputdev);
 	if (result) {
-		printk(ASUS_INFO "Unable to register input device\n");
+		pr_info("Unable to register input device\n");
 		input_free_device(hotk->inputdev);
 	}
 	return result;
@@ -1117,7 +1120,7 @@ static int asus_hotk_check(void)
 	if (hotk->device->status.present) {
 		result = asus_hotk_get_info();
 	} else {
-		printk(ASUS_ERR "Hotkey device not present, aborting\n");
+		pr_err("Hotkey device not present, aborting\n");
 		return -EINVAL;
 	}
 
@@ -1133,7 +1136,7 @@ static int asus_hotk_add(struct acpi_device *device)
 	if (!device)
 		return -EINVAL;
 
-	printk(ASUS_NOTICE "Asus Laptop Support version %s\n",
+	pr_notice("Asus Laptop Support version %s\n",
 	       ASUS_LAPTOP_VERSION);
 
 	hotk = kzalloc(sizeof(struct asus_hotk), GFP_KERNEL);
@@ -1247,8 +1250,7 @@ static int asus_backlight_init(struct device *dev)
 		bd = backlight_device_register(ASUS_HOTK_FILE, dev,
 					       NULL, &asusbl_ops);
 		if (IS_ERR(bd)) {
-			printk(ASUS_ERR
-			       "Could not register asus backlight device\n");
+			pr_err("Could not register asus backlight device\n");
 			asus_backlight_device = NULL;
 			return PTR_ERR(bd);
 		}
@@ -1375,7 +1377,7 @@ static int __init asus_laptop_init(void)
 		if (result)
 			goto fail_backlight;
 	} else
-		printk(ASUS_INFO "Brightness ignored, must be controlled by "
+		pr_info("Brightness ignored, must be controlled by "
 		       "ACPI video driver\n");
 
 	return 0;
-- 
1.6.3.1


