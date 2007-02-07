From: malattia@linux.it
Subject: [PATCH 2/4] Remove /proc/acpi/sony interface and implement platform_device.
Date: Wed,  7 Feb 2007 20:01:54 +0100
Message-ID: <11708749161045-git-send-email-malattia@linux.it>
References: <11708749163025-git-send-email-malattia@linux.it> <11708749161009-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:36576 "EHLO
	aa011msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422860AbXBGTDV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 14:03:21 -0500
In-Reply-To: <11708749161009-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

From: Mattia Dongili <malattia@linux.it>


Rework method names list to allow an easier management of multiple
values.
Add myself as author/maintainer and bump the version number.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |  396 ++++++++++++++++++++++----------------------
 1 files changed, 198 insertions(+), 198 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 103657e..1d14969 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -2,6 +2,7 @@
  * ACPI Sony Notebook Control Driver (SNC)
  *
  * Copyright (C) 2004-2005 Stelian Pop <stelian@popies.net>
+ * Copyright (C) 2007 Mattia Dongili <malattia@linux.it>
  *
  * Parts of this driver inspired from asus_acpi.c and ibm_acpi.c
  * which are copyrighted by their respective authors.
@@ -28,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/backlight.h>
+#include <linux/platform_device.h>
 #include <linux/err.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
@@ -35,15 +37,15 @@
 
 #define ACPI_SNC_CLASS		"sony"
 #define ACPI_SNC_HID		"SNY5001"
-#define ACPI_SNC_DRIVER_NAME	"ACPI Sony Notebook Control Driver v0.3"
+#define ACPI_SNC_DRIVER_NAME	"ACPI Sony Notebook Control Driver v0.4"
 
 /* the device uses 1-based values, while the backlight subsystem uses
    0-based values */
 #define SONY_MAX_BRIGHTNESS	8
 
-#define LOG_PFX			KERN_WARNING "sony_acpi: "
+#define LOG_PFX			KERN_WARNING "sony-laptop: "
 
-MODULE_AUTHOR("Stelian Pop");
+MODULE_AUTHOR("Stelian Pop, Mattia Dongili");
 MODULE_DESCRIPTION(ACPI_SNC_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
@@ -52,10 +54,6 @@ module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "set this to 1 (and RTFM) if you want to help "
 			"the development of this driver");
 
-static acpi_handle sony_acpi_handle;
-static struct proc_dir_entry *sony_acpi_dir;
-static struct acpi_device *sony_acpi_acpi_device = NULL;
-
 static int sony_backlight_update_status(struct backlight_device *bd);
 static int sony_backlight_get_brightness(struct backlight_device *bd);
 static struct backlight_device *sony_backlight_device;
@@ -66,105 +64,79 @@ static struct backlight_properties sony_backlight_properties = {
 	.max_brightness	= SONY_MAX_BRIGHTNESS - 1,
 };
 
-static struct sony_acpi_value {
-	char			*name;	 /* name of the entry */
-	struct proc_dir_entry	*proc;	 /* /proc entry */
-	char			*acpiget;/* name of the ACPI get function */
-	char			*acpiset;/* name of the ACPI get function */
-	int 			min;	 /* minimum allowed value or -1 */
-	int			max;	 /* maximum allowed value or -1 */
-	int			value;	 /* current setting */
-	int			valid;	 /* Has ever been set */
-	int			debug;	 /* active only in debug mode ? */
-} sony_acpi_values[] = {
-	{
-		/* for backward compatibility only */
-		.name		= "brightness",
-		.acpiget	= "GBRT",
-		.acpiset	= "SBRT",
-		.min		= 1,
-		.max		= SONY_MAX_BRIGHTNESS,
-		.debug		= 0,
-	},
-	{
-		.name		= "brightness_default",
-		.acpiget	= "GPBR",
-		.acpiset	= "SPBR",
-		.min		= 1,
-		.max		= SONY_MAX_BRIGHTNESS,
-		.debug		= 0,
-	},
-	{
-		.name           = "fnkey",
-		.acpiget        = "GHKE",
-		.debug          = 0,
-	},
-	{
-		.name		= "cdpower",
-		.acpiget	= "GCDP",
-		.acpiset	= "SCDP",
-		.min		= 0,
-		.max		= 1,
-		.debug		= 0,
-	},
-	{
-		.name		= "cdpower",
-		.acpiget	= "GCDP",
-		.acpiset	= "CDPW",
-		.min		= 0,
-		.max		= 1,
-		.debug		= 0,
-	},
-	{
-		.name           = "audiopower",
-		.acpiget        = "GAZP",
-		.acpiset        = "AZPW",
-		.min            = 0,
-		.max            = 1,
-		.debug          = 0,
-	},
-	{
-		.name           = "lanpower",
-		.acpiget        = "GLNP",
-		.acpiset        = "LNPW",
-		.min            = 0,
-		.max            = 1,
-		.debug          = 1,
-	},
-	{
-		.name		= "PID",
-		.acpiget	= "GPID",
-		.debug		= 1,
-	},
-	{
-		.name		= "CTR",
-		.acpiget	= "GCTR",
-		.acpiset	= "SCTR",
-		.min		= -1,
-		.max		= -1,
-		.debug		= 1,
-	},
-	{
-		.name		= "PCR",
-		.acpiget	= "GPCR",
-		.acpiset	= "SPCR",
-		.min		= -1,
-		.max		= -1,
-		.debug		= 1,
-	},
-	{
-		.name		= "CMI",
-		.acpiget	= "GCMI",
-		.acpiset	= "SCMI",
-		.min		= -1,
-		.max		= -1,
-		.debug		= 1,
-	},
-	{
-		.name		= NULL,
+static ssize_t sony_acpi_show(struct device *, struct device_attribute *, char *);
+static ssize_t sony_acpi_store(struct device *, struct device_attribute *, const char *, size_t);
+
+struct sony_acpi_value {
+	char			*name;		/* name of the entry */
+	char			**acpiget;	/* names of the ACPI get function */
+	char			**acpiset;	/* names of the ACPI set function */
+	int 			min;		/* minimum allowed value or -1 */
+	int			max;		/* maximum allowed value or -1 */
+	int			value;		/* current setting */
+	int			valid;		/* Has ever been set */
+	int			debug;		/* active only in debug mode ? */
+	struct device_attribute	devattr;	/* sysfs atribute */
+};
+
+#define HANDLE_NAMES(_name, _values...) \
+	static char *snc_##_name[] = { _values, NULL }
+
+#define SONY_ACPI_VALUE(_name, _getters, _setters, _min, _max, _debug) \
+	{ \
+		.name		= __stringify(_name), \
+		.acpiget	= _getters, \
+		.acpiset	= _setters, \
+		.min		= _min, \
+		.max		= _max, \
+		.debug		= _debug, \
+		.devattr	= __ATTR(_name, 0, sony_acpi_show, sony_acpi_store), \
 	}
+
+#define SONY_ACPI_VALUE_NULL	{ .name = NULL }
+
+HANDLE_NAMES(fnkey_get, "GHKE");
+
+HANDLE_NAMES(brightness_def_get, "GPBR");
+HANDLE_NAMES(brightness_def_set, "SPBR");
+
+HANDLE_NAMES(cdpower_get, "GCDP");
+HANDLE_NAMES(cdpower_set, "SCDP", "CDPW");
+
+HANDLE_NAMES(audiopower_get, "GAZP");
+HANDLE_NAMES(audiopower_set, "AZPW");
+
+HANDLE_NAMES(lanpower_get, "GLNP");
+HANDLE_NAMES(lanpower_set, "LNPW");
+
+HANDLE_NAMES(PID_get, "GPID");
+
+HANDLE_NAMES(CTR_get, "GCTR");
+HANDLE_NAMES(CTR_set, "SCTR");
+
+HANDLE_NAMES(PCR_get, "GPCR");
+HANDLE_NAMES(PCR_set, "SPCR");
+
+HANDLE_NAMES(CMI_get, "GCMI");
+HANDLE_NAMES(CMI_set, "SCMI");
+
+static struct sony_acpi_value sony_acpi_values[] = {
+	SONY_ACPI_VALUE(brightness_default, snc_brightness_def_get, snc_brightness_def_set, 1, SONY_MAX_BRIGHTNESS, 0),
+	SONY_ACPI_VALUE(fnkey,		snc_fnkey_get, NULL, -1, -1, 0),
+	SONY_ACPI_VALUE(cdpower,	snc_cdpower_get, snc_cdpower_set, 0, 1, 0),
+	SONY_ACPI_VALUE(audiopower,	snc_audiopower_get, snc_audiopower_set, 0, 1, 0),
+	SONY_ACPI_VALUE(lanpower,	snc_lanpower_get, snc_lanpower_set, 0, 1, 1),
+	/* unknown methods */
+	SONY_ACPI_VALUE(PID,		snc_PID_get, NULL, -1, -1, 1),
+	SONY_ACPI_VALUE(CTR,		snc_CTR_get, snc_CTR_set, -1, -1, 1),
+	SONY_ACPI_VALUE(PCR,		snc_PCR_get, snc_PCR_set, -1, -1, 1),
+	SONY_ACPI_VALUE(CMI,		snc_CMI_get, snc_CMI_set, -1, -1, 1),
+	SONY_ACPI_VALUE_NULL
 };
 
+static acpi_handle sony_acpi_handle;
+static struct acpi_device *sony_acpi_acpi_device = NULL;
+
 static int acpi_callgetfunc(acpi_handle handle, char *name, int *result)
 {
 	struct acpi_buffer output;
@@ -220,61 +192,149 @@ static int acpi_callsetfunc(acpi_handle handle, char *name, int value,
 	return -1;
 }
 
-static int parse_buffer(const char __user *buffer, unsigned long count,
-			int *val) {
-	char s[32];
-	int ret;
-
-	if (count > 31)
-		return -EINVAL;
-	if (copy_from_user(s, buffer, count))
-		return -EFAULT;
-	s[count] = '\0';
-	ret = simple_strtoul(s, NULL, 10);
-	*val = ret;
-	return 0;
-}
-
-static int sony_acpi_read(char* page, char** start, off_t off, int count,
-			  int* eof, void *data)
+/*
+ * Sysfs show/store common to all sony_acpi_values
+ */
+static ssize_t sony_acpi_show(struct device *dev, struct device_attribute *attr,
+		char *buffer)
 {
-	struct sony_acpi_value *item = data;
 	int value;
+	struct sony_acpi_value *item = container_of(attr, struct sony_acpi_value, devattr);
 
-	if (!item->acpiget)
+	if (!*item->acpiget)
 		return -EIO;
 
-	if (acpi_callgetfunc(sony_acpi_handle, item->acpiget, &value) < 0)
+	if (acpi_callgetfunc(sony_acpi_handle, *item->acpiget, &value) < 0)
 		return -EIO;
 
-	return sprintf(page, "%d\n", value);
+	return snprintf(buffer, PAGE_SIZE, "%d\n", value);
 }
 
-static int sony_acpi_write(struct file *file, const char __user *buffer,
-			   unsigned long count, void *data)
+static ssize_t sony_acpi_store(struct device *dev, struct device_attribute *attr,
+		const char *buffer, size_t count)
 {
-	struct sony_acpi_value *item = data;
-	int result;
 	int value;
+	struct sony_acpi_value *item = container_of(attr, struct sony_acpi_value, devattr);
 
 	if (!item->acpiset)
 		return -EIO;
 
-	if ((result = parse_buffer(buffer, count, &value)) < 0)
-		return result;
+	if (count > 31)
+		return -EINVAL;
+
+	value = simple_strtoul(buffer, NULL, 10);
 
 	if (item->min != -1 && value < item->min)
 		return -EINVAL;
 	if (item->max != -1 && value > item->max)
 		return -EINVAL;
 
-	if (acpi_callsetfunc(sony_acpi_handle, item->acpiset, value, NULL) < 0)
+	if (acpi_callsetfunc(sony_acpi_handle, *item->acpiset, value, NULL) < 0)
 		return -EIO;
 	item->value = value;
 	item->valid = 1;
 	return count;
 }
 
+/*
+ * Platform device
+ */
+static struct platform_driver sncpf_driver = {
+	.driver = {
+		.name = "sony-laptop",
+		.owner = THIS_MODULE,
+	}
+};
+static struct platform_device *sncpf_device;
+
+static int sony_snc_pf_add(void)
+{
+	acpi_handle handle;
+	struct sony_acpi_value *item;
+	int ret = 0;
+
+	ret = platform_driver_register(&sncpf_driver);
+	if (ret)
+		goto out;
+
+	sncpf_device = platform_device_alloc("sony-laptop", -1);
+	if (!sncpf_device) {
+		ret = -ENOMEM;
+		goto out_platform_registered;
+	}
+
+	ret = platform_device_add(sncpf_device);
+	if (ret)
+		goto out_platform_alloced;
+
+	for (item = sony_acpi_values; item->name; ++item) {
+
+		if (!debug && item->debug)
+			continue;
+
+		/* find the available acpiget as described in the DSDT */
+		for (; item->acpiget && *item->acpiget; ++item->acpiget) {
+			if (ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle,
+							*item->acpiget,
+							&handle))) {
+				if (debug)
+					printk(LOG_PFX "Found %s getter: %s\n",
+							item->name,
+							*item->acpiget);
+				item->devattr.attr.mode |= S_IRUGO;
+				break;
+			}
+		}
+
+		/* find the available acpiset as described in the DSDT */
+		for (; item->acpiset && *item->acpiset; ++item->acpiset) {
+			if (ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle,
+							*item->acpiset,
+							&handle))) {
+				if (debug)
+					printk(LOG_PFX "Found %s setter: %s\n",
+							item->name,
+							*item->acpiset);
+				item->devattr.attr.mode |= S_IWUSR;
+				break;
+			}
+		}
+
+	       if (item->devattr.attr.mode != 0) {
+		       ret = device_create_file(&sncpf_device->dev, &item->devattr);
+		       if (ret)
+			       goto out_sysfs;
+	       }
+	}
+
+	return 0;
+
+out_sysfs:
+	for (item = sony_acpi_values; item->name; ++item) {
+		device_remove_file(&sncpf_device->dev, &item->devattr);
+	}
+	platform_device_del(sncpf_device);
+out_platform_alloced:
+	platform_device_put(sncpf_device);
+out_platform_registered:
+	platform_driver_unregister(&sncpf_driver);
+out:
+	return ret;
+}
+
+static void sony_snc_pf_remove(void)
+{
+	struct sony_acpi_value *item;
+
+	for (item = sony_acpi_values; item->name; ++item) {
+		device_remove_file(&sncpf_device->dev, &item->devattr);
+	}
+
+	platform_device_del(sncpf_device);
+	platform_device_put(sncpf_device);
+	platform_driver_unregister(&sncpf_driver);
+}
+
 static int sony_acpi_resume(struct acpi_device *device)
 {
 	struct sony_acpi_value *item;
@@ -284,7 +344,7 @@ static int sony_acpi_resume(struct acpi_device *device)
 
 		if (!item->valid)
 			continue;
-		ret = acpi_callsetfunc(sony_acpi_handle, item->acpiset,
+		ret = acpi_callsetfunc(sony_acpi_handle, *item->acpiset,
 					item->value, NULL);
 		if (ret < 0) {
 			printk("%s: %d\n", __FUNCTION__, ret);
@@ -321,16 +381,11 @@ static int sony_acpi_add(struct acpi_device *device)
 	acpi_status status;
 	int result;
 	acpi_handle handle;
-	mode_t proc_file_mode;
-	struct sony_acpi_value *item;
 
 	sony_acpi_acpi_device = device;
 
 	sony_acpi_handle = device->handle;
 
-	acpi_driver_data(device) = NULL;
-	acpi_device_dir(device) = sony_acpi_dir;
-
 	if (debug) {
 		status = acpi_walk_namespace(ACPI_TYPE_METHOD, sony_acpi_handle,
 					     1, sony_walk_callback, NULL, NULL);
@@ -348,7 +403,7 @@ static int sony_acpi_add(struct acpi_device *device)
 	if (ACPI_FAILURE(status)) {
 		printk(LOG_PFX "unable to install notify handler\n");
 		result = -ENODEV;
-		goto outnotify;
+		goto outwalk;
 	}
 
 	if (ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle, "GBRT", &handle))) {
@@ -364,54 +419,17 @@ static int sony_acpi_add(struct acpi_device *device)
 				sony_backlight_get_brightness(sony_backlight_device);
 	}
 
-	for (item = sony_acpi_values; item->name; ++item) {
-		proc_file_mode = 0;
-
-		if (!debug && item->debug)
-			continue;
-
-		if (item->acpiget) {
-			if (ACPI_FAILURE(acpi_get_handle(sony_acpi_handle,
-							item->acpiget, &handle)))
-				continue;
-
-			proc_file_mode |= S_IRUSR;
-		}
-
-		if (item->acpiset) {
-			if (ACPI_FAILURE(acpi_get_handle(sony_acpi_handle,
-							item->acpiset, &handle)))
-				continue;
-
-			proc_file_mode |= S_IWUSR;
-		}
-
-		item->proc = create_proc_entry(item->name, proc_file_mode,
-				acpi_device_dir(device));
-		if (!item->proc) {
-			printk(LOG_PFX "unable to create proc entry\n");
-			result = -EIO;
-			goto outproc;
-		}
-
-		item->proc->read_proc = sony_acpi_read;
-		item->proc->write_proc = sony_acpi_write;
-		item->proc->data = item;
-		item->proc->owner = THIS_MODULE;
-	}
+	if (sony_snc_pf_add())
+		goto outbacklight;
 
 	printk(KERN_INFO ACPI_SNC_DRIVER_NAME " successfully installed\n");
 
 	return 0;
 
-outproc:
+outbacklight:
 	if (sony_backlight_device)
 		backlight_device_unregister(sony_backlight_device);
 
-	for (item = sony_acpi_values; item->name; ++item)
-		if (item->proc)
-			remove_proc_entry(item->name, acpi_device_dir(device));
-outnotify:
 	status = acpi_remove_notify_handler(sony_acpi_handle,
 					    ACPI_DEVICE_NOTIFY,
 					    sony_acpi_notify);
@@ -424,7 +442,6 @@ outwalk:
 static int sony_acpi_remove(struct acpi_device *device, int type)
 {
 	acpi_status status;
-	struct sony_acpi_value *item;
 
 	if (sony_backlight_device)
 		backlight_device_unregister(sony_backlight_device);
@@ -437,9 +454,7 @@ static int sony_acpi_remove(struct acpi_device *device, int type)
 	if (ACPI_FAILURE(status))
 		printk(LOG_PFX "unable to remove notify handler\n");
 
-	for (item = sony_acpi_values; item->name; ++item)
-		if (item->proc)
-			remove_proc_entry(item->name, acpi_device_dir(device));
+	sony_snc_pf_remove();
 
 	printk(KERN_INFO ACPI_SNC_DRIVER_NAME " successfully removed\n");
 
@@ -476,28 +491,13 @@ static struct acpi_driver sony_acpi_driver = {
 
 static int __init sony_acpi_init(void)
 {
-	int result;
-
-	sony_acpi_dir = proc_mkdir("sony", acpi_root_dir);
-	if (!sony_acpi_dir) {
-		printk(LOG_PFX "unable to create /proc entry\n");
-		return -ENODEV;
-	}
-	sony_acpi_dir->owner = THIS_MODULE;
-
-	result = acpi_bus_register_driver(&sony_acpi_driver);
-	if (result < 0) {
-		remove_proc_entry("sony", acpi_root_dir);
-		return -ENODEV;
-	}
-	return 0;
+	return acpi_bus_register_driver(&sony_acpi_driver);
 }
 
 
 static void __exit sony_acpi_exit(void)
 {
 	acpi_bus_unregister_driver(&sony_acpi_driver);
-	remove_proc_entry("sony", acpi_root_dir);
 }
 
 module_init(sony_acpi_init);
-- 
1.4.4.3

