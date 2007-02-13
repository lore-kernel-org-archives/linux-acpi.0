From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/41] sony-laptop: Group functions and structures to better draw subsytems usage
Date: Tue, 13 Feb 2007 00:49:17 -0500
Message-ID: <11713458041996-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:26577 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751055AbXBMFuG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:06 -0500
In-Reply-To: <11713458031539-git-send-email-lenb@kernel.org>
Message-Id: <fb4d31866a03a81b184eebafb8fea605f2808fe5.1171345630.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |   92 ++++++++++++++++++++++++-------------------
 1 files changed, 51 insertions(+), 41 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 1d14969..4a69ce7 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -54,16 +54,6 @@ module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "set this to 1 (and RTFM) if you want to help "
 			"the development of this driver");
 
-static int sony_backlight_update_status(struct backlight_device *bd);
-static int sony_backlight_get_brightness(struct backlight_device *bd);
-static struct backlight_device *sony_backlight_device;
-static struct backlight_properties sony_backlight_properties = {
-	.owner		= THIS_MODULE,
-	.update_status	= sony_backlight_update_status,
-	.get_brightness	= sony_backlight_get_brightness,
-	.max_brightness	= SONY_MAX_BRIGHTNESS - 1,
-};
-
 static ssize_t sony_acpi_show(struct device *, struct device_attribute *, char *);
 static ssize_t sony_acpi_store(struct device *, struct device_attribute *, const char *, size_t);
 
@@ -137,6 +127,9 @@ static struct sony_acpi_value sony_acpi_values[] = {
 static acpi_handle sony_acpi_handle;
 static struct acpi_device *sony_acpi_acpi_device = NULL;
 
+/*
+ * acpi_evaluate_object wrappers
+ */
 static int acpi_callgetfunc(acpi_handle handle, char *name, int *result)
 {
 	struct acpi_buffer output;
@@ -335,25 +328,37 @@ static void sony_snc_pf_remove(void)
 	platform_driver_unregister(&sncpf_driver);
 }
 
-static int sony_acpi_resume(struct acpi_device *device)
+/*
+ * Backlight device
+ */
+static int sony_backlight_update_status(struct backlight_device *bd)
 {
-	struct sony_acpi_value *item;
+	return acpi_callsetfunc(sony_acpi_handle, "SBRT",
+				bd->props->brightness + 1,
+				NULL);
+}
 
-	for (item = sony_acpi_values; item->name; item++) {
-		int ret;
+static int sony_backlight_get_brightness(struct backlight_device *bd)
+{
+	int value;
 
-		if (!item->valid)
-			continue;
-		ret = acpi_callsetfunc(sony_acpi_handle, *item->acpiset,
-					item->value, NULL);
-		if (ret < 0) {
-			printk("%s: %d\n", __FUNCTION__, ret);
-			break;
-		}
-	}
-	return 0;
+	if (acpi_callgetfunc(sony_acpi_handle, "GBRT", &value))
+		return 0;
+	/* brightness levels are 1-based, while backlight ones are 0-based */
+	return value - 1;
 }
 
+static struct backlight_device *sony_backlight_device;
+static struct backlight_properties sony_backlight_properties = {
+	.owner		= THIS_MODULE,
+	.update_status	= sony_backlight_update_status,
+	.get_brightness	= sony_backlight_get_brightness,
+	.max_brightness	= SONY_MAX_BRIGHTNESS - 1,
+};
+
+/*
+ * ACPI callbacks
+ */
 static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
 	if (debug)
@@ -376,6 +381,28 @@ static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
 	return AE_OK;
 }
 
+/*
+ * ACPI device
+ */
+static int sony_acpi_resume(struct acpi_device *device)
+{
+	struct sony_acpi_value *item;
+
+	for (item = sony_acpi_values; item->name; item++) {
+		int ret;
+
+		if (!item->valid)
+			continue;
+		ret = acpi_callsetfunc(sony_acpi_handle, *item->acpiset,
+					item->value, NULL);
+		if (ret < 0) {
+			printk("%s: %d\n", __FUNCTION__, ret);
+			break;
+		}
+	}
+	return 0;
+}
+
 static int sony_acpi_add(struct acpi_device *device)
 {
 	acpi_status status;
@@ -461,23 +488,6 @@ static int sony_acpi_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
-static int sony_backlight_update_status(struct backlight_device *bd)
-{
-	return acpi_callsetfunc(sony_acpi_handle, "SBRT",
-				bd->props->brightness + 1,
-				NULL);
-}
-
-static int sony_backlight_get_brightness(struct backlight_device *bd)
-{
-	int value;
-
-	if (acpi_callgetfunc(sony_acpi_handle, "GBRT", &value))
-		return 0;
-	/* brightness levels are 1-based, while backlight ones are 0-based */
-	return value - 1;
-}
-
 static struct acpi_driver sony_acpi_driver = {
 	.name	= ACPI_SNC_DRIVER_NAME,
 	.class	= ACPI_SNC_CLASS,
-- 
1.5.0.rc4.345.gb4d2
