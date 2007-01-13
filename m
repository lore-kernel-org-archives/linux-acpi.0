From: Mattia Dongili <malattia@linux.it>
Subject: [RFC][PATCH] sony_acpi: turn into a platform device driver
Date: Sat, 13 Jan 2007 23:20:46 +0100
Message-ID: <20070113222045.GA7066@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:49057 "EHLO
	aa014msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422806AbXAMWUt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jan 2007 17:20:49 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Stelian Pop <stelian@popies.net>, Len Brown <len.brown@intel.com>

Hello,

this is my current work to remove the /proc/acpi/sony directory, it
applies ontop of the previous patchset I just sent.

A few questions though:
- is it correct to have files in /sys/devices/platform/sony_acpi?
    /sys/devices/platform/sony_acpi/
    |-- audiopower
    |-- brightness
    |-- brightness_default
    |-- cdpower
    |-- driver -> ../../../bus/platform/drivers/sony_acpi
    |-- lanpower
    |-- modalias
    |-- power
    |   `-- wakeup
    |-- subsystem -> ../../../bus/platform
    `-- uevent
  (oops, yes, will remove 'brightness')

- shall I move the source file to drivers/misc?

thanks for any comment and suggestion!
---

 sony_acpi.c |  349 ++++++++++++++++++++++++++----------------------------------
 1 file changed, 152 insertions(+), 197 deletions(-)

---
diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
index c01d98d..4ffda2b 100644
--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
@@ -3,6 +3,8 @@
  *
  * Copyright (C) 2004-2005 Stelian Pop <stelian@popies.net>
  *
+ * Copyright (C) 2007 Mattia Dongili <malattia@linux.it>
+ *
  * Parts of this driver inspired from asus_acpi.c and ibm_acpi.c
  * which are copyrighted by their respective authors.
  *
@@ -28,6 +30,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/backlight.h>
+#include <linux/platform_device.h>
 #include <linux/err.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
@@ -35,7 +38,7 @@
 
 #define ACPI_SNC_CLASS		"sony"
 #define ACPI_SNC_HID		"SNY5001"
-#define ACPI_SNC_DRIVER_NAME	"ACPI Sony Notebook Control Driver v0.3"
+#define ACPI_SNC_DRIVER_NAME	"ACPI Sony Notebook Control Driver v0.4"
 
 /* the device uses 1-based values, while the backlight subsystem uses
    0-based values */
@@ -52,10 +55,53 @@ module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "set this to 1 (and RTFM) if you want to help "
 			"the development of this driver");
 
+static ssize_t sony_acpi_show(struct device *, struct device_attribute *, char *);
+static ssize_t sony_acpi_store(struct device *, struct device_attribute *, const char *, size_t);
+
+struct sony_acpi_value {
+	char			*name;	 /* name of the entry */
+	char			*acpiget;/* name of the ACPI get function */
+	char			*acpiset;/* name of the ACPI get function */
+	int 			min;	 /* minimum allowed value or -1 */
+	int			max;	 /* maximum allowed value or -1 */
+	int			value;	 /* current setting */
+	int			valid;	 /* Has ever been set */
+	int			debug;	 /* active only in debug mode ? */
+	struct device_attribute	devattr; /* sysfs atribute */
+};
+
+#define SONY_ACPI_VALUE(_name, _getter, _setter, _min, _max, _debug) \
+	{ \
+		.name		= __stringify(_name), \
+		.acpiget	= _getter, \
+		.acpiset	= _setter, \
+		.min		= _min, \
+		.max		= _max, \
+		.debug		= _debug, \
+		.devattr	= __ATTR(_name, 0, sony_acpi_show, sony_acpi_store), \
+	}
+
+#define SONY_ACPI_VALUE_NULL	{ .name = NULL }
+
+static struct sony_acpi_value sony_acpi_values[] = {
+	SONY_ACPI_VALUE( brightness,		"GBRT", "SBRT", 1, SONY_MAX_BRIGHTNESS, 0),
+	SONY_ACPI_VALUE( brightness_default,	"GPBR", "SPBR", 1, SONY_MAX_BRIGHTNESS, 0),
+	SONY_ACPI_VALUE( fnkey,			"GHKE", NULL, -1, -1, 0),
+	SONY_ACPI_VALUE( cdpower,		"GCDP", "SCDP", 0, 1, 0),
+	SONY_ACPI_VALUE( cdpower,		"GCDP", "CDPW", 0, 1, 0),
+	SONY_ACPI_VALUE( audiopower,		"GAZP", "AZPW", 0, 1, 0),
+	SONY_ACPI_VALUE( lanpower,		"GLNP", "LNPW", 0, 1, 1),
+	SONY_ACPI_VALUE( PID,			"GPID", NULL, -1, -1, 1),
+	SONY_ACPI_VALUE( CTR,			"GCTR", "SCTR", -1, -1, 1),
+	SONY_ACPI_VALUE( PCR,			"GPCR", "SPCR", -1, -1, 1),
+	SONY_ACPI_VALUE( CMI,			"GCMI", "SCMI", -1, -1, 1),
+	SONY_ACPI_VALUE_NULL
+};
+
 static acpi_handle sony_acpi_handle;
-static struct proc_dir_entry *sony_acpi_dir;
 static struct acpi_device *sony_acpi_acpi_device = NULL;
 
+/* backlight */
 static int sony_backlight_update_status(struct backlight_device *bd);
 static int sony_backlight_get_brightness(struct backlight_device *bd);
 static struct backlight_device *sony_backlight_device;
@@ -66,105 +112,7 @@ static struct backlight_properties sony_backlight_properties = {
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
-	}
-};
-
+/* acpi stubs */
 static int acpi_callgetfunc(acpi_handle handle, char *name, int *result)
 {
 	struct acpi_buffer output;
@@ -220,26 +168,11 @@ static int acpi_callsetfunc(acpi_handle handle, char *name, int value,
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
+static ssize_t sony_acpi_show(struct device *dev, struct device_attribute *attr,
+		char *buffer)
 {
-	struct sony_acpi_value *item = data;
 	int value;
+	struct sony_acpi_value *item = container_of(attr, struct sony_acpi_value, devattr);
 
 	if (!item->acpiget)
 		return -EIO;
@@ -247,21 +180,22 @@ static int sony_acpi_read(char* page, char** start, off_t off, int count,
 	if (acpi_callgetfunc(sony_acpi_handle, item->acpiget, &value) < 0)
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
@@ -316,20 +250,102 @@ static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
 	return AE_OK;
 }
 
+/***************** Platform device **********************/
+static struct platform_driver sncpf_driver = {
+	.driver = {
+		.name = "sony_acpi",
+		.owner = THIS_MODULE,
+	}
+};
+static struct platform_device *sncpf_device;
+
+static int sony_acpi_pf_add(void)
+{
+
+	acpi_handle handle;
+	struct sony_acpi_value *item;
+	int ret = 0;
+
+	ret = platform_driver_register(&sncpf_driver);
+	if (ret)
+		goto out;
+
+	sncpf_device = platform_device_alloc("sony_acpi", -1);
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
+		if (item->acpiget) {
+			if (ACPI_FAILURE(acpi_get_handle(sony_acpi_handle,
+							item->acpiget, &handle)))
+				continue;
+
+			item->devattr.attr.mode |= S_IRUSR;
+		}
+
+		if (item->acpiset) {
+			if (ACPI_FAILURE(acpi_get_handle(sony_acpi_handle,
+							item->acpiset, &handle)))
+				continue;
+
+			item->devattr.attr.mode |= S_IWUSR;
+		}
+		ret = device_create_file(&sncpf_device->dev, &item->devattr);
+		if (ret)
+			goto out_sysfs;
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
+static void sony_acpi_pf_remove(void)
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
+
+}
+
 static int sony_acpi_add(struct acpi_device *device)
 {
 	acpi_status status;
 	int result;
 	acpi_handle handle;
-	mode_t proc_file_mode;
-	struct sony_acpi_value *item;
 
 	sony_acpi_acpi_device = device;
 
 	sony_acpi_handle = device->handle;
 
 	acpi_driver_data(device) = NULL;
-	acpi_device_dir(device) = sony_acpi_dir;
+	acpi_device_dir(device) = NULL;
 
 	if (debug) {
 		status = acpi_walk_namespace(ACPI_TYPE_METHOD, sony_acpi_handle,
@@ -353,64 +369,21 @@ static int sony_acpi_add(struct acpi_device *device)
 
 	if (ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle, "GBRT", &handle))) {
 		sony_backlight_device = backlight_device_register("sony", NULL,
-					NULL, &sony_backlight_properties);
-
+				NULL, &sony_backlight_properties);
 	        if (IS_ERR(sony_backlight_device)) {
         	        printk(LOG_PFX "unable to register backlight device\n");
-			sony_backlight_device = NULL;
 		}
-		else
-			sony_backlight_properties.brightness =
-				sony_backlight_get_brightness(sony_backlight_device);
+		sony_backlight_properties.brightness =
+			sony_backlight_get_brightness(sony_backlight_device);
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
+	if (sony_acpi_pf_add())
+		goto outnotify;
 
 	printk(KERN_INFO ACPI_SNC_DRIVER_NAME " successfully installed\n");
 
 	return 0;
 
-outproc:
-	if (sony_backlight_device)
-		backlight_device_unregister(sony_backlight_device);
-
-	for (item = sony_acpi_values; item->name; ++item)
-		if (item->proc)
-			remove_proc_entry(item->name, acpi_device_dir(device));
 outnotify:
 	status = acpi_remove_notify_handler(sony_acpi_handle,
 					    ACPI_DEVICE_NOTIFY,
@@ -424,7 +397,6 @@ outwalk:
 static int sony_acpi_remove(struct acpi_device *device, int type)
 {
 	acpi_status status;
-	struct sony_acpi_value *item;
 
 	if (sony_backlight_device)
 		backlight_device_unregister(sony_backlight_device);
@@ -437,9 +409,7 @@ static int sony_acpi_remove(struct acpi_device *device, int type)
 	if (ACPI_FAILURE(status))
 		printk(LOG_PFX "unable to remove notify handler\n");
 
-	for (item = sony_acpi_values; item->name; ++item)
-		if (item->proc)
-			remove_proc_entry(item->name, acpi_device_dir(device));
+	sony_acpi_pf_remove();
 
 	printk(KERN_INFO ACPI_SNC_DRIVER_NAME " successfully removed\n");
 
@@ -476,28 +446,13 @@ static struct acpi_driver sony_acpi_driver = {
 
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
mattia
:wq!
