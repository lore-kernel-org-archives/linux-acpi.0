From: Len Brown <lenb@kernel.org>
Subject: [PATCH 084/112] asus-laptop new write_acpi_int
Date: Thu,  7 Feb 2008 04:34:46 -0500
Message-ID: <f8d1c94b346b62747322728e00e11f552cd90902.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:18844 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754023AbYBGJgo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:44 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin CHARY <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin CHARY <corentincj@iksaif.net>

Just a little modification of write_acpi_int

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/asus-laptop.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index 0846c33..34666ff 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -254,7 +254,7 @@ ASUS_LED(gled, "gaming");
  * method is searched within the scope of the handle, can be NULL. The output
  * of the method is written is output, which can also be NULL
  *
- * returns 1 if write is successful, 0 else.
+ * returns 0 if write is successful, -1 else.
  */
 static int write_acpi_int(acpi_handle handle, const char *method, int val,
 			  struct acpi_buffer *output)
@@ -263,13 +263,19 @@ static int write_acpi_int(acpi_handle handle, const char *method, int val,
 	union acpi_object in_obj;	//the only param we use
 	acpi_status status;
 
+	if (!handle)
+		return 0;
+
 	params.count = 1;
 	params.pointer = &in_obj;
 	in_obj.type = ACPI_TYPE_INTEGER;
 	in_obj.integer.value = val;
 
 	status = acpi_evaluate_object(handle, (char *)method, &params, output);
-	return (status == AE_OK);
+	if (status == AE_OK)
+		return 0;
+	else
+		return -1;
 }
 
 static int read_wireless_status(int mask)
@@ -335,7 +341,7 @@ static void write_status(acpi_handle handle, int out, int mask)
 		break;
 	}
 
-	if (handle && !write_acpi_int(handle, NULL, out, NULL))
+	if (write_acpi_int(handle, NULL, out, NULL))
 		printk(ASUS_WARNING " write failed %x\n", mask);
 }
 
@@ -415,7 +421,7 @@ static int set_brightness(struct backlight_device *bd, int value)
 	value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
 	/* 0 <= value <= 15 */
 
-	if (!write_acpi_int(brightness_set_handle, NULL, value, NULL)) {
+	if (write_acpi_int(brightness_set_handle, NULL, value, NULL)) {
 		printk(ASUS_WARNING "Error changing brightness\n");
 		ret = -EIO;
 	}
@@ -545,7 +551,7 @@ static ssize_t store_ledd(struct device *dev, struct device_attribute *attr,
 
 	rv = parse_arg(buf, count, &value);
 	if (rv > 0) {
-		if (!write_acpi_int(ledd_set_handle, NULL, value, NULL))
+		if (write_acpi_int(ledd_set_handle, NULL, value, NULL))
 			printk(ASUS_WARNING "LED display write failed\n");
 		else
 			hotk->ledd_status = (u32) value;
@@ -590,7 +596,7 @@ static ssize_t store_bluetooth(struct device *dev,
 static void set_display(int value)
 {
 	/* no sanity check needed for now */
-	if (!write_acpi_int(display_set_handle, NULL, value, NULL))
+	if (write_acpi_int(display_set_handle, NULL, value, NULL))
 		printk(ASUS_WARNING "Error setting display\n");
 	return;
 }
@@ -647,7 +653,7 @@ static ssize_t store_disp(struct device *dev, struct device_attribute *attr,
  */
 static void set_light_sens_switch(int value)
 {
-	if (!write_acpi_int(ls_switch_handle, NULL, value, NULL))
+	if (write_acpi_int(ls_switch_handle, NULL, value, NULL))
 		printk(ASUS_WARNING "Error setting light sensor switch\n");
 	hotk->light_switch = value;
 }
@@ -672,7 +678,7 @@ static ssize_t store_lssw(struct device *dev, struct device_attribute *attr,
 
 static void set_light_sens_level(int value)
 {
-	if (!write_acpi_int(ls_level_handle, NULL, value, NULL))
+	if (write_acpi_int(ls_level_handle, NULL, value, NULL))
 		printk(ASUS_WARNING "Error setting light sensor level\n");
 	hotk->light_level = value;
 }
@@ -860,7 +866,7 @@ static int asus_hotk_get_info(void)
 		printk(ASUS_WARNING "Couldn't get the DSDT table header\n");
 
 	/* We have to write 0 on init this far for all ASUS models */
-	if (!write_acpi_int(hotk->handle, "INIT", 0, &buffer)) {
+	if (write_acpi_int(hotk->handle, "INIT", 0, &buffer)) {
 		printk(ASUS_ERR "Hotkey initialization failed\n");
 		return -ENODEV;
 	}
-- 
1.5.4.23.gef5b9

