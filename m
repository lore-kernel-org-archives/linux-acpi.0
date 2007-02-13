From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/41] sony-laptop: create from sony_acpi
Date: Tue, 13 Feb 2007 00:49:14 -0500
Message-ID: <11713458011379-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:39577 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751058AbXBMFuD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:03 -0500
In-Reply-To: <11713458001192-git-send-email-lenb@kernel.org>
Message-Id: <0c3be8460c60c90cf9c43bc7c5f0e1ef7092ab0a.1171345630.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

Move drivers/acpi/sony_acpi.c to drivers/misc/sony-laptop.c with all the
necessary configuration.
The SONY_LAPTOP config option substitutes the old ACPI_SONY and is 'default n'
now.

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig       |   15 --
 drivers/acpi/Makefile      |    1 -
 drivers/acpi/sony_acpi.c   |  504 --------------------------------------------
 drivers/misc/Kconfig       |   14 ++
 drivers/misc/Makefile      |    1 +
 drivers/misc/sony-laptop.c |  504 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 519 insertions(+), 520 deletions(-)
 delete mode 100644 drivers/acpi/sony_acpi.c
 create mode 100644 drivers/misc/sony-laptop.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 364e6fe..f4f000a 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -252,21 +252,6 @@ config ACPI_TOSHIBA
 	  If you have a legacy free Toshiba laptop (such as the Libretto L1
 	  series), say Y.
 
-config ACPI_SONY
-	tristate "Sony Laptop Extras"
-	depends on X86 && ACPI
-	select BACKLIGHT_CLASS_DEVICE
-	default m
-	  ---help---
-	  This mini-driver drives the ACPI SNC device present in the
-	  ACPI BIOS of the Sony Vaio laptops.
-
-	  It gives access to some extra laptop functionalities. In
-	  its current form, the only thing this driver does is letting
-	  the user set or query the screen brightness.
-
-	  Read <file:Documentation/acpi/sony_acpi.txt> for more information.
-
 config ACPI_CUSTOM_DSDT
 	bool "Include Custom DSDT"
 	depends on !STANDALONE
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 31b9ad2..bce7ca2 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -53,7 +53,6 @@ obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
 obj-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
 obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
-obj-$(CONFIG_ACPI_SONY)		+= sony_acpi.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_ACPI_IBM)		+= ibm_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
deleted file mode 100644
index c01d98d..0000000
--- a/drivers/acpi/sony_acpi.c
+++ /dev/null
@@ -1,504 +0,0 @@
-/*
- * ACPI Sony Notebook Control Driver (SNC)
- *
- * Copyright (C) 2004-2005 Stelian Pop <stelian@popies.net>
- *
- * Parts of this driver inspired from asus_acpi.c and ibm_acpi.c
- * which are copyrighted by their respective authors.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/backlight.h>
-#include <linux/err.h>
-#include <acpi/acpi_drivers.h>
-#include <acpi/acpi_bus.h>
-#include <asm/uaccess.h>
-
-#define ACPI_SNC_CLASS		"sony"
-#define ACPI_SNC_HID		"SNY5001"
-#define ACPI_SNC_DRIVER_NAME	"ACPI Sony Notebook Control Driver v0.3"
-
-/* the device uses 1-based values, while the backlight subsystem uses
-   0-based values */
-#define SONY_MAX_BRIGHTNESS	8
-
-#define LOG_PFX			KERN_WARNING "sony_acpi: "
-
-MODULE_AUTHOR("Stelian Pop");
-MODULE_DESCRIPTION(ACPI_SNC_DRIVER_NAME);
-MODULE_LICENSE("GPL");
-
-static int debug;
-module_param(debug, int, 0);
-MODULE_PARM_DESC(debug, "set this to 1 (and RTFM) if you want to help "
-			"the development of this driver");
-
-static acpi_handle sony_acpi_handle;
-static struct proc_dir_entry *sony_acpi_dir;
-static struct acpi_device *sony_acpi_acpi_device = NULL;
-
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
-static int acpi_callgetfunc(acpi_handle handle, char *name, int *result)
-{
-	struct acpi_buffer output;
-	union acpi_object out_obj;
-	acpi_status status;
-
-	output.length = sizeof(out_obj);
-	output.pointer = &out_obj;
-
-	status = acpi_evaluate_object(handle, name, NULL, &output);
-	if ((status == AE_OK) && (out_obj.type == ACPI_TYPE_INTEGER)) {
-		*result = out_obj.integer.value;
-		return 0;
-	}
-
-	printk(LOG_PFX "acpi_callreadfunc failed\n");
-
-	return -1;
-}
-
-static int acpi_callsetfunc(acpi_handle handle, char *name, int value,
-			    int *result)
-{
-	struct acpi_object_list params;
-	union acpi_object in_obj;
-	struct acpi_buffer output;
-	union acpi_object out_obj;
-	acpi_status status;
-
-	params.count = 1;
-	params.pointer = &in_obj;
-	in_obj.type = ACPI_TYPE_INTEGER;
-	in_obj.integer.value = value;
-
-	output.length = sizeof(out_obj);
-	output.pointer = &out_obj;
-
-	status = acpi_evaluate_object(handle, name, &params, &output);
-	if (status == AE_OK) {
-		if (result != NULL) {
-			if (out_obj.type != ACPI_TYPE_INTEGER) {
-				printk(LOG_PFX "acpi_evaluate_object bad "
-				       "return type\n");
-				return -1;
-			}
-			*result = out_obj.integer.value;
-		}
-		return 0;
-	}
-
-	printk(LOG_PFX "acpi_evaluate_object failed\n");
-
-	return -1;
-}
-
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
-{
-	struct sony_acpi_value *item = data;
-	int value;
-
-	if (!item->acpiget)
-		return -EIO;
-
-	if (acpi_callgetfunc(sony_acpi_handle, item->acpiget, &value) < 0)
-		return -EIO;
-
-	return sprintf(page, "%d\n", value);
-}
-
-static int sony_acpi_write(struct file *file, const char __user *buffer,
-			   unsigned long count, void *data)
-{
-	struct sony_acpi_value *item = data;
-	int result;
-	int value;
-
-	if (!item->acpiset)
-		return -EIO;
-
-	if ((result = parse_buffer(buffer, count, &value)) < 0)
-		return result;
-
-	if (item->min != -1 && value < item->min)
-		return -EINVAL;
-	if (item->max != -1 && value > item->max)
-		return -EINVAL;
-
-	if (acpi_callsetfunc(sony_acpi_handle, item->acpiset, value, NULL) < 0)
-		return -EIO;
-	item->value = value;
-	item->valid = 1;
-	return count;
-}
-
-static int sony_acpi_resume(struct acpi_device *device)
-{
-	struct sony_acpi_value *item;
-
-	for (item = sony_acpi_values; item->name; item++) {
-		int ret;
-
-		if (!item->valid)
-			continue;
-		ret = acpi_callsetfunc(sony_acpi_handle, item->acpiset,
-					item->value, NULL);
-		if (ret < 0) {
-			printk("%s: %d\n", __FUNCTION__, ret);
-			break;
-		}
-	}
-	return 0;
-}
-
-static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
-{
-	if (debug)
-		printk(LOG_PFX "sony_acpi_notify, event: %d\n", event);
-	acpi_bus_generate_event(sony_acpi_acpi_device, 1, event);
-}
-
-static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
-				      void *context, void **return_value)
-{
-	struct acpi_namespace_node *node;
-	union acpi_operand_object *operand;
-
-	node = (struct acpi_namespace_node *) handle;
-	operand = (union acpi_operand_object *) node->object;
-
-	printk(LOG_PFX "method: name: %4.4s, args %X\n", node->name.ascii,
-	       (u32) operand->method.param_count);
-
-	return AE_OK;
-}
-
-static int sony_acpi_add(struct acpi_device *device)
-{
-	acpi_status status;
-	int result;
-	acpi_handle handle;
-	mode_t proc_file_mode;
-	struct sony_acpi_value *item;
-
-	sony_acpi_acpi_device = device;
-
-	sony_acpi_handle = device->handle;
-
-	acpi_driver_data(device) = NULL;
-	acpi_device_dir(device) = sony_acpi_dir;
-
-	if (debug) {
-		status = acpi_walk_namespace(ACPI_TYPE_METHOD, sony_acpi_handle,
-					     1, sony_walk_callback, NULL, NULL);
-		if (ACPI_FAILURE(status)) {
-			printk(LOG_PFX "unable to walk acpi resources\n");
-			result = -ENODEV;
-			goto outwalk;
-		}
-	}
-
-	status = acpi_install_notify_handler(sony_acpi_handle,
-					     ACPI_DEVICE_NOTIFY,
-					     sony_acpi_notify,
-					     NULL);
-	if (ACPI_FAILURE(status)) {
-		printk(LOG_PFX "unable to install notify handler\n");
-		result = -ENODEV;
-		goto outnotify;
-	}
-
-	if (ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle, "GBRT", &handle))) {
-		sony_backlight_device = backlight_device_register("sony", NULL,
-					NULL, &sony_backlight_properties);
-
-	        if (IS_ERR(sony_backlight_device)) {
-        	        printk(LOG_PFX "unable to register backlight device\n");
-			sony_backlight_device = NULL;
-		}
-		else
-			sony_backlight_properties.brightness =
-				sony_backlight_get_brightness(sony_backlight_device);
-	}
-
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
-
-	printk(KERN_INFO ACPI_SNC_DRIVER_NAME " successfully installed\n");
-
-	return 0;
-
-outproc:
-	if (sony_backlight_device)
-		backlight_device_unregister(sony_backlight_device);
-
-	for (item = sony_acpi_values; item->name; ++item)
-		if (item->proc)
-			remove_proc_entry(item->name, acpi_device_dir(device));
-outnotify:
-	status = acpi_remove_notify_handler(sony_acpi_handle,
-					    ACPI_DEVICE_NOTIFY,
-					    sony_acpi_notify);
-	if (ACPI_FAILURE(status))
-		printk(LOG_PFX "unable to remove notify handler\n");
-outwalk:
-	return result;
-}
-
-static int sony_acpi_remove(struct acpi_device *device, int type)
-{
-	acpi_status status;
-	struct sony_acpi_value *item;
-
-	if (sony_backlight_device)
-		backlight_device_unregister(sony_backlight_device);
-
-	sony_acpi_acpi_device = NULL;
-
-	status = acpi_remove_notify_handler(sony_acpi_handle,
-					    ACPI_DEVICE_NOTIFY,
-					    sony_acpi_notify);
-	if (ACPI_FAILURE(status))
-		printk(LOG_PFX "unable to remove notify handler\n");
-
-	for (item = sony_acpi_values; item->name; ++item)
-		if (item->proc)
-			remove_proc_entry(item->name, acpi_device_dir(device));
-
-	printk(KERN_INFO ACPI_SNC_DRIVER_NAME " successfully removed\n");
-
-	return 0;
-}
-
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
-static struct acpi_driver sony_acpi_driver = {
-	.name	= ACPI_SNC_DRIVER_NAME,
-	.class	= ACPI_SNC_CLASS,
-	.ids	= ACPI_SNC_HID,
-	.ops	= {
-			.add	= sony_acpi_add,
-			.remove	= sony_acpi_remove,
-			.resume = sony_acpi_resume,
-		  },
-};
-
-static int __init sony_acpi_init(void)
-{
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
-}
-
-
-static void __exit sony_acpi_exit(void)
-{
-	acpi_bus_unregister_driver(&sony_acpi_driver);
-	remove_proc_entry("sony", acpi_root_dir);
-}
-
-module_init(sony_acpi_init);
-module_exit(sony_acpi_exit);
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 00db31c..78fc47b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -88,4 +88,18 @@ config MSI_LAPTOP
 
 	  If you have an MSI S270 laptop, say Y or M here.
 
+config SONY_LAPTOP
+	tristate "Sony Laptop Extras"
+	depends on X86 && ACPI
+	select BACKLIGHT_CLASS_DEVICE
+	  ---help---
+	  This mini-driver drives the ACPI SNC device present in the
+	  ACPI BIOS of the Sony Vaio laptops.
+
+	  It gives access to some extra laptop functionalities. In
+	  its current form, the only thing this driver does is letting
+	  the user set or query the screen brightness.
+
+	  Read <file:Documentation/acpi/sony_acpi.txt> for more information.
+
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c9e98ab..f86f9dc 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_LKDTM)		+= lkdtm.o
 obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
 obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
 obj-$(CONFIG_SGI_IOC4)		+= ioc4.o
+obj-$(CONFIG_SONY_LAPTOP)	+= sony-laptop.o
diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
new file mode 100644
index 0000000..103657e
--- /dev/null
+++ b/drivers/misc/sony-laptop.c
@@ -0,0 +1,504 @@
+/*
+ * ACPI Sony Notebook Control Driver (SNC)
+ *
+ * Copyright (C) 2004-2005 Stelian Pop <stelian@popies.net>
+ *
+ * Parts of this driver inspired from asus_acpi.c and ibm_acpi.c
+ * which are copyrighted by their respective authors.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/backlight.h>
+#include <linux/err.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acpi_bus.h>
+#include <asm/uaccess.h>
+
+#define ACPI_SNC_CLASS		"sony"
+#define ACPI_SNC_HID		"SNY5001"
+#define ACPI_SNC_DRIVER_NAME	"ACPI Sony Notebook Control Driver v0.3"
+
+/* the device uses 1-based values, while the backlight subsystem uses
+   0-based values */
+#define SONY_MAX_BRIGHTNESS	8
+
+#define LOG_PFX			KERN_WARNING "sony_acpi: "
+
+MODULE_AUTHOR("Stelian Pop");
+MODULE_DESCRIPTION(ACPI_SNC_DRIVER_NAME);
+MODULE_LICENSE("GPL");
+
+static int debug;
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "set this to 1 (and RTFM) if you want to help "
+			"the development of this driver");
+
+static acpi_handle sony_acpi_handle;
+static struct proc_dir_entry *sony_acpi_dir;
+static struct acpi_device *sony_acpi_acpi_device = NULL;
+
+static int sony_backlight_update_status(struct backlight_device *bd);
+static int sony_backlight_get_brightness(struct backlight_device *bd);
+static struct backlight_device *sony_backlight_device;
+static struct backlight_properties sony_backlight_properties = {
+	.owner		= THIS_MODULE,
+	.update_status	= sony_backlight_update_status,
+	.get_brightness	= sony_backlight_get_brightness,
+	.max_brightness	= SONY_MAX_BRIGHTNESS - 1,
+};
+
+static struct sony_acpi_value {
+	char			*name;	 /* name of the entry */
+	struct proc_dir_entry	*proc;	 /* /proc entry */
+	char			*acpiget;/* name of the ACPI get function */
+	char			*acpiset;/* name of the ACPI get function */
+	int 			min;	 /* minimum allowed value or -1 */
+	int			max;	 /* maximum allowed value or -1 */
+	int			value;	 /* current setting */
+	int			valid;	 /* Has ever been set */
+	int			debug;	 /* active only in debug mode ? */
+} sony_acpi_values[] = {
+	{
+		/* for backward compatibility only */
+		.name		= "brightness",
+		.acpiget	= "GBRT",
+		.acpiset	= "SBRT",
+		.min		= 1,
+		.max		= SONY_MAX_BRIGHTNESS,
+		.debug		= 0,
+	},
+	{
+		.name		= "brightness_default",
+		.acpiget	= "GPBR",
+		.acpiset	= "SPBR",
+		.min		= 1,
+		.max		= SONY_MAX_BRIGHTNESS,
+		.debug		= 0,
+	},
+	{
+		.name           = "fnkey",
+		.acpiget        = "GHKE",
+		.debug          = 0,
+	},
+	{
+		.name		= "cdpower",
+		.acpiget	= "GCDP",
+		.acpiset	= "SCDP",
+		.min		= 0,
+		.max		= 1,
+		.debug		= 0,
+	},
+	{
+		.name		= "cdpower",
+		.acpiget	= "GCDP",
+		.acpiset	= "CDPW",
+		.min		= 0,
+		.max		= 1,
+		.debug		= 0,
+	},
+	{
+		.name           = "audiopower",
+		.acpiget        = "GAZP",
+		.acpiset        = "AZPW",
+		.min            = 0,
+		.max            = 1,
+		.debug          = 0,
+	},
+	{
+		.name           = "lanpower",
+		.acpiget        = "GLNP",
+		.acpiset        = "LNPW",
+		.min            = 0,
+		.max            = 1,
+		.debug          = 1,
+	},
+	{
+		.name		= "PID",
+		.acpiget	= "GPID",
+		.debug		= 1,
+	},
+	{
+		.name		= "CTR",
+		.acpiget	= "GCTR",
+		.acpiset	= "SCTR",
+		.min		= -1,
+		.max		= -1,
+		.debug		= 1,
+	},
+	{
+		.name		= "PCR",
+		.acpiget	= "GPCR",
+		.acpiset	= "SPCR",
+		.min		= -1,
+		.max		= -1,
+		.debug		= 1,
+	},
+	{
+		.name		= "CMI",
+		.acpiget	= "GCMI",
+		.acpiset	= "SCMI",
+		.min		= -1,
+		.max		= -1,
+		.debug		= 1,
+	},
+	{
+		.name		= NULL,
+	}
+};
+
+static int acpi_callgetfunc(acpi_handle handle, char *name, int *result)
+{
+	struct acpi_buffer output;
+	union acpi_object out_obj;
+	acpi_status status;
+
+	output.length = sizeof(out_obj);
+	output.pointer = &out_obj;
+
+	status = acpi_evaluate_object(handle, name, NULL, &output);
+	if ((status == AE_OK) && (out_obj.type == ACPI_TYPE_INTEGER)) {
+		*result = out_obj.integer.value;
+		return 0;
+	}
+
+	printk(LOG_PFX "acpi_callreadfunc failed\n");
+
+	return -1;
+}
+
+static int acpi_callsetfunc(acpi_handle handle, char *name, int value,
+			    int *result)
+{
+	struct acpi_object_list params;
+	union acpi_object in_obj;
+	struct acpi_buffer output;
+	union acpi_object out_obj;
+	acpi_status status;
+
+	params.count = 1;
+	params.pointer = &in_obj;
+	in_obj.type = ACPI_TYPE_INTEGER;
+	in_obj.integer.value = value;
+
+	output.length = sizeof(out_obj);
+	output.pointer = &out_obj;
+
+	status = acpi_evaluate_object(handle, name, &params, &output);
+	if (status == AE_OK) {
+		if (result != NULL) {
+			if (out_obj.type != ACPI_TYPE_INTEGER) {
+				printk(LOG_PFX "acpi_evaluate_object bad "
+				       "return type\n");
+				return -1;
+			}
+			*result = out_obj.integer.value;
+		}
+		return 0;
+	}
+
+	printk(LOG_PFX "acpi_evaluate_object failed\n");
+
+	return -1;
+}
+
+static int parse_buffer(const char __user *buffer, unsigned long count,
+			int *val) {
+	char s[32];
+	int ret;
+
+	if (count > 31)
+		return -EINVAL;
+	if (copy_from_user(s, buffer, count))
+		return -EFAULT;
+	s[count] = '\0';
+	ret = simple_strtoul(s, NULL, 10);
+	*val = ret;
+	return 0;
+}
+
+static int sony_acpi_read(char* page, char** start, off_t off, int count,
+			  int* eof, void *data)
+{
+	struct sony_acpi_value *item = data;
+	int value;
+
+	if (!item->acpiget)
+		return -EIO;
+
+	if (acpi_callgetfunc(sony_acpi_handle, item->acpiget, &value) < 0)
+		return -EIO;
+
+	return sprintf(page, "%d\n", value);
+}
+
+static int sony_acpi_write(struct file *file, const char __user *buffer,
+			   unsigned long count, void *data)
+{
+	struct sony_acpi_value *item = data;
+	int result;
+	int value;
+
+	if (!item->acpiset)
+		return -EIO;
+
+	if ((result = parse_buffer(buffer, count, &value)) < 0)
+		return result;
+
+	if (item->min != -1 && value < item->min)
+		return -EINVAL;
+	if (item->max != -1 && value > item->max)
+		return -EINVAL;
+
+	if (acpi_callsetfunc(sony_acpi_handle, item->acpiset, value, NULL) < 0)
+		return -EIO;
+	item->value = value;
+	item->valid = 1;
+	return count;
+}
+
+static int sony_acpi_resume(struct acpi_device *device)
+{
+	struct sony_acpi_value *item;
+
+	for (item = sony_acpi_values; item->name; item++) {
+		int ret;
+
+		if (!item->valid)
+			continue;
+		ret = acpi_callsetfunc(sony_acpi_handle, item->acpiset,
+					item->value, NULL);
+		if (ret < 0) {
+			printk("%s: %d\n", __FUNCTION__, ret);
+			break;
+		}
+	}
+	return 0;
+}
+
+static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
+{
+	if (debug)
+		printk(LOG_PFX "sony_acpi_notify, event: %d\n", event);
+	acpi_bus_generate_event(sony_acpi_acpi_device, 1, event);
+}
+
+static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
+				      void *context, void **return_value)
+{
+	struct acpi_namespace_node *node;
+	union acpi_operand_object *operand;
+
+	node = (struct acpi_namespace_node *) handle;
+	operand = (union acpi_operand_object *) node->object;
+
+	printk(LOG_PFX "method: name: %4.4s, args %X\n", node->name.ascii,
+	       (u32) operand->method.param_count);
+
+	return AE_OK;
+}
+
+static int sony_acpi_add(struct acpi_device *device)
+{
+	acpi_status status;
+	int result;
+	acpi_handle handle;
+	mode_t proc_file_mode;
+	struct sony_acpi_value *item;
+
+	sony_acpi_acpi_device = device;
+
+	sony_acpi_handle = device->handle;
+
+	acpi_driver_data(device) = NULL;
+	acpi_device_dir(device) = sony_acpi_dir;
+
+	if (debug) {
+		status = acpi_walk_namespace(ACPI_TYPE_METHOD, sony_acpi_handle,
+					     1, sony_walk_callback, NULL, NULL);
+		if (ACPI_FAILURE(status)) {
+			printk(LOG_PFX "unable to walk acpi resources\n");
+			result = -ENODEV;
+			goto outwalk;
+		}
+	}
+
+	status = acpi_install_notify_handler(sony_acpi_handle,
+					     ACPI_DEVICE_NOTIFY,
+					     sony_acpi_notify,
+					     NULL);
+	if (ACPI_FAILURE(status)) {
+		printk(LOG_PFX "unable to install notify handler\n");
+		result = -ENODEV;
+		goto outnotify;
+	}
+
+	if (ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle, "GBRT", &handle))) {
+		sony_backlight_device = backlight_device_register("sony", NULL,
+					NULL, &sony_backlight_properties);
+
+	        if (IS_ERR(sony_backlight_device)) {
+			printk(LOG_PFX "unable to register backlight device\n");
+			sony_backlight_device = NULL;
+		}
+		else
+			sony_backlight_properties.brightness =
+				sony_backlight_get_brightness(sony_backlight_device);
+	}
+
+	for (item = sony_acpi_values; item->name; ++item) {
+		proc_file_mode = 0;
+
+		if (!debug && item->debug)
+			continue;
+
+		if (item->acpiget) {
+			if (ACPI_FAILURE(acpi_get_handle(sony_acpi_handle,
+							item->acpiget, &handle)))
+				continue;
+
+			proc_file_mode |= S_IRUSR;
+		}
+
+		if (item->acpiset) {
+			if (ACPI_FAILURE(acpi_get_handle(sony_acpi_handle,
+							item->acpiset, &handle)))
+				continue;
+
+			proc_file_mode |= S_IWUSR;
+		}
+
+		item->proc = create_proc_entry(item->name, proc_file_mode,
+				acpi_device_dir(device));
+		if (!item->proc) {
+			printk(LOG_PFX "unable to create proc entry\n");
+			result = -EIO;
+			goto outproc;
+		}
+
+		item->proc->read_proc = sony_acpi_read;
+		item->proc->write_proc = sony_acpi_write;
+		item->proc->data = item;
+		item->proc->owner = THIS_MODULE;
+	}
+
+	printk(KERN_INFO ACPI_SNC_DRIVER_NAME " successfully installed\n");
+
+	return 0;
+
+outproc:
+	if (sony_backlight_device)
+		backlight_device_unregister(sony_backlight_device);
+
+	for (item = sony_acpi_values; item->name; ++item)
+		if (item->proc)
+			remove_proc_entry(item->name, acpi_device_dir(device));
+outnotify:
+	status = acpi_remove_notify_handler(sony_acpi_handle,
+					    ACPI_DEVICE_NOTIFY,
+					    sony_acpi_notify);
+	if (ACPI_FAILURE(status))
+		printk(LOG_PFX "unable to remove notify handler\n");
+outwalk:
+	return result;
+}
+
+static int sony_acpi_remove(struct acpi_device *device, int type)
+{
+	acpi_status status;
+	struct sony_acpi_value *item;
+
+	if (sony_backlight_device)
+		backlight_device_unregister(sony_backlight_device);
+
+	sony_acpi_acpi_device = NULL;
+
+	status = acpi_remove_notify_handler(sony_acpi_handle,
+					    ACPI_DEVICE_NOTIFY,
+					    sony_acpi_notify);
+	if (ACPI_FAILURE(status))
+		printk(LOG_PFX "unable to remove notify handler\n");
+
+	for (item = sony_acpi_values; item->name; ++item)
+		if (item->proc)
+			remove_proc_entry(item->name, acpi_device_dir(device));
+
+	printk(KERN_INFO ACPI_SNC_DRIVER_NAME " successfully removed\n");
+
+	return 0;
+}
+
+static int sony_backlight_update_status(struct backlight_device *bd)
+{
+	return acpi_callsetfunc(sony_acpi_handle, "SBRT",
+				bd->props->brightness + 1,
+				NULL);
+}
+
+static int sony_backlight_get_brightness(struct backlight_device *bd)
+{
+	int value;
+
+	if (acpi_callgetfunc(sony_acpi_handle, "GBRT", &value))
+		return 0;
+	/* brightness levels are 1-based, while backlight ones are 0-based */
+	return value - 1;
+}
+
+static struct acpi_driver sony_acpi_driver = {
+	.name	= ACPI_SNC_DRIVER_NAME,
+	.class	= ACPI_SNC_CLASS,
+	.ids	= ACPI_SNC_HID,
+	.ops	= {
+			.add	= sony_acpi_add,
+			.remove	= sony_acpi_remove,
+			.resume = sony_acpi_resume,
+		  },
+};
+
+static int __init sony_acpi_init(void)
+{
+	int result;
+
+	sony_acpi_dir = proc_mkdir("sony", acpi_root_dir);
+	if (!sony_acpi_dir) {
+		printk(LOG_PFX "unable to create /proc entry\n");
+		return -ENODEV;
+	}
+	sony_acpi_dir->owner = THIS_MODULE;
+
+	result = acpi_bus_register_driver(&sony_acpi_driver);
+	if (result < 0) {
+		remove_proc_entry("sony", acpi_root_dir);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+
+static void __exit sony_acpi_exit(void)
+{
+	acpi_bus_unregister_driver(&sony_acpi_driver);
+	remove_proc_entry("sony", acpi_root_dir);
+}
+
+module_init(sony_acpi_init);
+module_exit(sony_acpi_exit);
-- 
1.5.0.rc4.345.gb4d2
