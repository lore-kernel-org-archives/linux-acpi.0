From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/41] sony-laptop: Lindent
Date: Tue, 13 Feb 2007 00:49:18 -0500
Message-ID: <11713458052158-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:31145 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751056AbXBMFuH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:07 -0500
In-Reply-To: <11713458041996-git-send-email-lenb@kernel.org>
Message-Id: <652cc3bf92fd9727ad55fb9405b870ba44a6788e.1171345630.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |  151 +++++++++++++++++++++++---------------------
 1 files changed, 78 insertions(+), 73 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 4a69ce7..d7b5330 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -52,21 +52,23 @@ MODULE_LICENSE("GPL");
 static int debug;
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "set this to 1 (and RTFM) if you want to help "
-			"the development of this driver");
+		 "the development of this driver");
 
-static ssize_t sony_acpi_show(struct device *, struct device_attribute *, char *);
-static ssize_t sony_acpi_store(struct device *, struct device_attribute *, const char *, size_t);
+static ssize_t sony_acpi_show(struct device *, struct device_attribute *,
+			      char *);
+static ssize_t sony_acpi_store(struct device *, struct device_attribute *,
+			       const char *, size_t);
 
 struct sony_acpi_value {
-	char			*name;		/* name of the entry */
-	char			**acpiget;	/* names of the ACPI get function */
-	char			**acpiset;	/* names of the ACPI set function */
-	int 			min;		/* minimum allowed value or -1 */
-	int			max;		/* maximum allowed value or -1 */
-	int			value;		/* current setting */
-	int			valid;		/* Has ever been set */
-	int			debug;		/* active only in debug mode ? */
-	struct device_attribute	devattr;	/* sysfs atribute */
+	char *name;		/* name of the entry */
+	char **acpiget;		/* names of the ACPI get function */
+	char **acpiset;		/* names of the ACPI set function */
+	int min;		/* minimum allowed value or -1 */
+	int max;		/* maximum allowed value or -1 */
+	int value;		/* current setting */
+	int valid;		/* Has ever been set */
+	int debug;		/* active only in debug mode ? */
+	struct device_attribute devattr;	/* sysfs atribute */
 };
 
 #define HANDLE_NAMES(_name, _values...) \
@@ -111,16 +113,18 @@ HANDLE_NAMES(CMI_get, "GCMI");
 HANDLE_NAMES(CMI_set, "SCMI");
 
 static struct sony_acpi_value sony_acpi_values[] = {
-	SONY_ACPI_VALUE(brightness_default, snc_brightness_def_get, snc_brightness_def_set, 1, SONY_MAX_BRIGHTNESS, 0),
-	SONY_ACPI_VALUE(fnkey,		snc_fnkey_get, NULL, -1, -1, 0),
-	SONY_ACPI_VALUE(cdpower,	snc_cdpower_get, snc_cdpower_set, 0, 1, 0),
-	SONY_ACPI_VALUE(audiopower,	snc_audiopower_get, snc_audiopower_set, 0, 1, 0),
-	SONY_ACPI_VALUE(lanpower,	snc_lanpower_get, snc_lanpower_set, 0, 1, 1),
+	SONY_ACPI_VALUE(brightness_default, snc_brightness_def_get,
+			snc_brightness_def_set, 1, SONY_MAX_BRIGHTNESS, 0),
+	SONY_ACPI_VALUE(fnkey, snc_fnkey_get, NULL, -1, -1, 0),
+	SONY_ACPI_VALUE(cdpower, snc_cdpower_get, snc_cdpower_set, 0, 1, 0),
+	SONY_ACPI_VALUE(audiopower, snc_audiopower_get, snc_audiopower_set, 0,
+			1, 0),
+	SONY_ACPI_VALUE(lanpower, snc_lanpower_get, snc_lanpower_set, 0, 1, 1),
 	/* unknown methods */
-	SONY_ACPI_VALUE(PID,		snc_PID_get, NULL, -1, -1, 1),
-	SONY_ACPI_VALUE(CTR,		snc_CTR_get, snc_CTR_set, -1, -1, 1),
-	SONY_ACPI_VALUE(PCR,		snc_PCR_get, snc_PCR_set, -1, -1, 1),
-	SONY_ACPI_VALUE(CMI,		snc_CMI_get, snc_CMI_set, -1, -1, 1),
+	SONY_ACPI_VALUE(PID, snc_PID_get, NULL, -1, -1, 1),
+	SONY_ACPI_VALUE(CTR, snc_CTR_get, snc_CTR_set, -1, -1, 1),
+	SONY_ACPI_VALUE(PCR, snc_PCR_get, snc_PCR_set, -1, -1, 1),
+	SONY_ACPI_VALUE(CMI, snc_CMI_get, snc_CMI_set, -1, -1, 1),
 	SONY_ACPI_VALUE_NULL
 };
 
@@ -189,10 +193,11 @@ static int acpi_callsetfunc(acpi_handle handle, char *name, int value,
  * Sysfs show/store common to all sony_acpi_values
  */
 static ssize_t sony_acpi_show(struct device *dev, struct device_attribute *attr,
-		char *buffer)
+			      char *buffer)
 {
 	int value;
-	struct sony_acpi_value *item = container_of(attr, struct sony_acpi_value, devattr);
+	struct sony_acpi_value *item =
+	    container_of(attr, struct sony_acpi_value, devattr);
 
 	if (!*item->acpiget)
 		return -EIO;
@@ -203,11 +208,13 @@ static ssize_t sony_acpi_show(struct device *dev, struct device_attribute *attr,
 	return snprintf(buffer, PAGE_SIZE, "%d\n", value);
 }
 
-static ssize_t sony_acpi_store(struct device *dev, struct device_attribute *attr,
-		const char *buffer, size_t count)
+static ssize_t sony_acpi_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buffer, size_t count)
 {
 	int value;
-	struct sony_acpi_value *item = container_of(attr, struct sony_acpi_value, devattr);
+	struct sony_acpi_value *item =
+	    container_of(attr, struct sony_acpi_value, devattr);
 
 	if (!item->acpiset)
 		return -EIO;
@@ -234,9 +241,9 @@ static ssize_t sony_acpi_store(struct device *dev, struct device_attribute *attr
  */
 static struct platform_driver sncpf_driver = {
 	.driver = {
-		.name = "sony-laptop",
-		.owner = THIS_MODULE,
-	}
+		   .name = "sony-laptop",
+		   .owner = THIS_MODULE,
+		   }
 };
 static struct platform_device *sncpf_device;
 
@@ -268,12 +275,11 @@ static int sony_snc_pf_add(void)
 		/* find the available acpiget as described in the DSDT */
 		for (; item->acpiget && *item->acpiget; ++item->acpiget) {
 			if (ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle,
-							*item->acpiget,
-							&handle))) {
+							 *item->acpiget,
+							 &handle))) {
 				if (debug)
 					printk(LOG_PFX "Found %s getter: %s\n",
-							item->name,
-							*item->acpiget);
+					       item->name, *item->acpiget);
 				item->devattr.attr.mode |= S_IRUGO;
 				break;
 			}
@@ -282,36 +288,37 @@ static int sony_snc_pf_add(void)
 		/* find the available acpiset as described in the DSDT */
 		for (; item->acpiset && *item->acpiset; ++item->acpiset) {
 			if (ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle,
-							*item->acpiset,
-							&handle))) {
+							 *item->acpiset,
+							 &handle))) {
 				if (debug)
 					printk(LOG_PFX "Found %s setter: %s\n",
-							item->name,
-							*item->acpiset);
+					       item->name, *item->acpiset);
 				item->devattr.attr.mode |= S_IWUSR;
 				break;
 			}
 		}
 
-	       if (item->devattr.attr.mode != 0) {
-		       ret = device_create_file(&sncpf_device->dev, &item->devattr);
-		       if (ret)
-			       goto out_sysfs;
-	       }
+		if (item->devattr.attr.mode != 0) {
+			ret =
+			    device_create_file(&sncpf_device->dev,
+					       &item->devattr);
+			if (ret)
+				goto out_sysfs;
+		}
 	}
 
 	return 0;
 
-out_sysfs:
+      out_sysfs:
 	for (item = sony_acpi_values; item->name; ++item) {
 		device_remove_file(&sncpf_device->dev, &item->devattr);
 	}
 	platform_device_del(sncpf_device);
-out_platform_alloced:
+      out_platform_alloced:
 	platform_device_put(sncpf_device);
-out_platform_registered:
+      out_platform_registered:
 	platform_driver_unregister(&sncpf_driver);
-out:
+      out:
 	return ret;
 }
 
@@ -334,8 +341,7 @@ static void sony_snc_pf_remove(void)
 static int sony_backlight_update_status(struct backlight_device *bd)
 {
 	return acpi_callsetfunc(sony_acpi_handle, "SBRT",
-				bd->props->brightness + 1,
-				NULL);
+				bd->props->brightness + 1, NULL);
 }
 
 static int sony_backlight_get_brightness(struct backlight_device *bd)
@@ -350,10 +356,10 @@ static int sony_backlight_get_brightness(struct backlight_device *bd)
 
 static struct backlight_device *sony_backlight_device;
 static struct backlight_properties sony_backlight_properties = {
-	.owner		= THIS_MODULE,
-	.update_status	= sony_backlight_update_status,
-	.get_brightness	= sony_backlight_get_brightness,
-	.max_brightness	= SONY_MAX_BRIGHTNESS - 1,
+	.owner = THIS_MODULE,
+	.update_status = sony_backlight_update_status,
+	.get_brightness = sony_backlight_get_brightness,
+	.max_brightness = SONY_MAX_BRIGHTNESS - 1,
 };
 
 /*
@@ -372,8 +378,8 @@ static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
 	struct acpi_namespace_node *node;
 	union acpi_operand_object *operand;
 
-	node = (struct acpi_namespace_node *) handle;
-	operand = (union acpi_operand_object *) node->object;
+	node = (struct acpi_namespace_node *)handle;
+	operand = (union acpi_operand_object *)node->object;
 
 	printk(LOG_PFX "method: name: %4.4s, args %X\n", node->name.ascii,
 	       (u32) operand->method.param_count);
@@ -394,7 +400,7 @@ static int sony_acpi_resume(struct acpi_device *device)
 		if (!item->valid)
 			continue;
 		ret = acpi_callsetfunc(sony_acpi_handle, *item->acpiset,
-					item->value, NULL);
+				       item->value, NULL);
 		if (ret < 0) {
 			printk("%s: %d\n", __FUNCTION__, ret);
 			break;
@@ -425,8 +431,7 @@ static int sony_acpi_add(struct acpi_device *device)
 
 	status = acpi_install_notify_handler(sony_acpi_handle,
 					     ACPI_DEVICE_NOTIFY,
-					     sony_acpi_notify,
-					     NULL);
+					     sony_acpi_notify, NULL);
 	if (ACPI_FAILURE(status)) {
 		printk(LOG_PFX "unable to install notify handler\n");
 		result = -ENODEV;
@@ -435,15 +440,16 @@ static int sony_acpi_add(struct acpi_device *device)
 
 	if (ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle, "GBRT", &handle))) {
 		sony_backlight_device = backlight_device_register("sony", NULL,
-					NULL, &sony_backlight_properties);
+								  NULL,
+								  &sony_backlight_properties);
 
-	        if (IS_ERR(sony_backlight_device)) {
+		if (IS_ERR(sony_backlight_device)) {
 			printk(LOG_PFX "unable to register backlight device\n");
 			sony_backlight_device = NULL;
-		}
-		else
+		} else
 			sony_backlight_properties.brightness =
-				sony_backlight_get_brightness(sony_backlight_device);
+			    sony_backlight_get_brightness
+			    (sony_backlight_device);
 	}
 
 	if (sony_snc_pf_add())
@@ -453,7 +459,7 @@ static int sony_acpi_add(struct acpi_device *device)
 
 	return 0;
 
-outbacklight:
+      outbacklight:
 	if (sony_backlight_device)
 		backlight_device_unregister(sony_backlight_device);
 
@@ -462,7 +468,7 @@ outbacklight:
 					    sony_acpi_notify);
 	if (ACPI_FAILURE(status))
 		printk(LOG_PFX "unable to remove notify handler\n");
-outwalk:
+      outwalk:
 	return result;
 }
 
@@ -489,14 +495,14 @@ static int sony_acpi_remove(struct acpi_device *device, int type)
 }
 
 static struct acpi_driver sony_acpi_driver = {
-	.name	= ACPI_SNC_DRIVER_NAME,
-	.class	= ACPI_SNC_CLASS,
-	.ids	= ACPI_SNC_HID,
-	.ops	= {
-			.add	= sony_acpi_add,
-			.remove	= sony_acpi_remove,
-			.resume = sony_acpi_resume,
-		  },
+	.name = ACPI_SNC_DRIVER_NAME,
+	.class = ACPI_SNC_CLASS,
+	.ids = ACPI_SNC_HID,
+	.ops = {
+		.add = sony_acpi_add,
+		.remove = sony_acpi_remove,
+		.resume = sony_acpi_resume,
+		},
 };
 
 static int __init sony_acpi_init(void)
@@ -504,7 +510,6 @@ static int __init sony_acpi_init(void)
 	return acpi_bus_register_driver(&sony_acpi_driver);
 }
 
-
 static void __exit sony_acpi_exit(void)
 {
 	acpi_bus_unregister_driver(&sony_acpi_driver);
-- 
1.5.0.rc4.345.gb4d2
