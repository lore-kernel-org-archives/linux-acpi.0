From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] ACPI: add "Fujitsu laptop extras" module
Date: Fri, 24 Aug 2007 10:12:55 +0930 (CST)
Message-ID: <200708240042.l7O0gtEe022838@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:45955 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933019AbXHXAm6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Aug 2007 20:42:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

The following patch adds support for features on various Fujitsu laptops
which are not accessible using the "standard" ACPI kernel modules.  Of
particular interest to me is the software control of screen brightness,
which allows software to turn the screen back on following a resume from
suspend-to-ram.

This patch was originally created by "hardwire" on the "Fujitsu P Series
Forum" at http://leog.net/fujp%5Fforum/topic.asp?ARCHIVE=true&TOPIC_ID=3388.
Adrian Yee (brewt-fujitsu@brewt.org) "cleaned up the code and made some
fixes".  I have simply re-based the patch against 2.6.22.3 and added mention
of the S7xxx to the Kconfig help text.

While originally written for the P-series laptops I can confirm that the LCD
brightness control (which is the only thing I really care about) also
functions correctly on my S7020, so it seems it's fine for the S-series as
well.

Please apply, or tell me what needs to be done to make this acceptable.

Regards
  jonathan

diff -ruN linux-2.6.22.3-orig/drivers/acpi/Kconfig linux-2.6.22.3/drivers/acpi/Kconfig
--- linux-2.6.22.3-orig/drivers/acpi/Kconfig	2007-08-16 01:55:39.000000000 +0930
+++ linux-2.6.22.3/drivers/acpi/Kconfig	2007-08-24 09:30:11.000000000 +0930
@@ -245,6 +245,16 @@
 	  If you have a legacy free Toshiba laptop (such as the Libretto L1
 	  series), say Y.
 
+config ACPI_FUJ02B1
+	tristate "Fujitsu FUJ02B1 Laptop Extras"
+	depends on X86 && ACPI && !ACPI_HT_ONLY
+	help
+	  This driver adds support for access to certain system settings
+	  on Fujitsu laptops.
+
+	  If you have a Fujitsu laptop (such as the P2xxx/P5xxx/S6xxx/S7xxx
+	  series), say Y.
+
 config ACPI_CUSTOM_DSDT
 	bool "Include Custom DSDT"
 	depends on !STANDALONE
diff -ruN linux-2.6.22.3-orig/drivers/acpi/Makefile linux-2.6.22.3/drivers/acpi/Makefile
--- linux-2.6.22.3-orig/drivers/acpi/Makefile	2007-08-16 01:55:39.000000000 +0930
+++ linux-2.6.22.3/drivers/acpi/Makefile	2007-08-24 09:27:36.000000000 +0930
@@ -57,6 +57,7 @@
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
+obj-$(CONFIG_ACPI_FUJ02B1)	+= fuj02b1_acpi.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
 obj-y				+= cm_sbs.o
 obj-$(CONFIG_ACPI_SBS)		+= sbs.o
diff -ruN linux-2.6.22.3-orig/drivers/acpi/fuj02b1_acpi.c linux-2.6.22.3/drivers/acpi/fuj02b1_acpi.c
--- linux-2.6.22.3-orig/drivers/acpi/fuj02b1_acpi.c	1970-01-01 09:30:00.000000000 +0930
+++ linux-2.6.22.3/drivers/acpi/fuj02b1_acpi.c	2007-08-24 09:25:55.000000000 +0930
@@ -0,0 +1,612 @@
+/*
+ *  fuj02b1.c - Fujitsu FUJ02B1 ACPI Extras
+ * 
+ *  Copyright (C) 2003 Shane Spencer <shane@bogomip.com>
+ * 
+ * Templated from on fan.c
+ *
+ *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
+ *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * TODO:
+ *  clean notify output and define a standard.. based on acpi events from the toshiba code
+ * 
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+
+#define ACPI_FUJ02B1_CLASS		"fuj02b1"
+#define ACPI_FUJ02B1_HID		"FUJ02B1"
+#define ACPI_FUJ02B1_DRIVER_NAME	"Fujitsu FUJ02B1 ACPI Extras Driver"
+#define ACPI_FUJ02B1_DEVICE_NAME	"FUJ02B1"
+#define ACPI_FUJ02B1_FILE_POINTER	"pointer"
+#define ACPI_FUJ02B1_FILE_VOLUME	"volume"
+#define ACPI_FUJ02B1_FILE_BRIGHTNESS	"brightness"
+#define ACPI_FUJ02B1_NOTIFY_STATUS	0x80
+
+#define PREFIX				"ACPI: "
+#define ACPI_FUJ02B1_COMPONENT		0x00200000
+#define _COMPONENT			ACPI_FUJ02B1_COMPONENT
+ACPI_MODULE_NAME("acpi_fuj02b1");
+
+MODULE_AUTHOR("Shane Spencer");
+MODULE_DESCRIPTION(ACPI_FUJ02B1_DRIVER_NAME);
+MODULE_LICENSE("GPL");
+
+int acpi_fuj02b1_add(struct acpi_device *device);
+int acpi_fuj02b1_remove(struct acpi_device *device, int type);
+
+/* an sscanf that takes explicit string length **STOLEN FROM TOSHIBA_ACPI.C** */
+static int snscanf(const char* str, int n, const char* format, ...)
+{
+	va_list args;
+	int result;
+	char* str2 = kmalloc(n + 1, GFP_KERNEL);
+	if (str2 == 0) return 0;
+	/* NOTE: don't even _think_ about replacing this with strlcpy */
+	strncpy(str2, str, n);
+	str2[n] = 0;
+	va_start(args, format);
+	result = vsscanf(str2, format, args);
+	va_end(args);
+	kfree(str2);
+	return result;
+}
+
+static struct acpi_driver acpi_fuj02b1_driver = {
+	.name = ACPI_FUJ02B1_DRIVER_NAME,
+	.class = ACPI_FUJ02B1_CLASS,
+	.ids = ACPI_FUJ02B1_HID,
+	.ops = {
+		.add = acpi_fuj02b1_add,
+		.remove = acpi_fuj02b1_remove,
+	},
+};
+
+struct acpi_fuj02b1 {
+	acpi_handle handle;
+	unsigned long state;
+	unsigned int mute_state;
+	unsigned int volume_level;
+	unsigned int volume_changed;
+	unsigned int brightness_level;
+	unsigned int brightness_changed;
+	unsigned int pointer_state;
+	unsigned int pointer_changed;
+};
+
+
+/* --------------------------------------------------------------------------
+ FS Interface (/proc)
+ -------------------------------------------------------------------------- */
+
+struct proc_dir_entry *acpi_fuj02b1_dir = NULL;
+
+
+/* --------------------------------------------------------------------------
+ Volume States
+ -------------------------------------------------------------------------- */
+
+static int acpi_fuj02b1_get_volume_state(void *data)
+{
+	struct acpi_fuj02b1 *fuj02b1 = (struct acpi_fuj02b1 *) data;
+	unsigned long state = 0;
+	acpi_status status = AE_OK;
+
+	// Get the Volume
+	status = acpi_evaluate_integer(fuj02b1->handle, "GVOL", NULL, &state);
+	fuj02b1->state = state;
+
+	fuj02b1->volume_level = state & 0x0fffffff; 
+
+	if (state & 0x40000000)
+		fuj02b1->mute_state = 0;
+	else
+		fuj02b1->mute_state = 1;
+
+	if (state & 0x80000000)
+		fuj02b1->volume_changed = 1;
+	else
+		fuj02b1->volume_changed = 0;
+
+	return -1;
+}
+
+static int acpi_fuj02b1_read_volume_state(char *page, char **start,
+	off_t off, int count, int *eof, void *data)
+{
+	struct acpi_fuj02b1 *fuj02b1 = (struct acpi_fuj02b1 *) data;
+	char *p = page;
+	int len = 0;
+
+	if (!fuj02b1 || (off != 0))
+		goto end;
+
+	acpi_fuj02b1_get_volume_state(fuj02b1);
+
+	p += sprintf(p, "volume:                  %d\n", fuj02b1->volume_level);
+	p += sprintf(p, "mute:                    %s\n", !fuj02b1->mute_state ? "on" : "off");
+	p += sprintf(p, "volume levels:           16\n");
+
+end:
+	len = (p - page);
+	if (len <= off + count) *eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len > count) len = count;
+	if (len < 0) len = 0;
+
+	return len;
+}
+
+static int acpi_fuj02b1_write_volume_state(struct file *file,
+	const char *buffer, unsigned long count, void *data)
+{
+	struct acpi_fuj02b1 *fuj02b1 = (struct acpi_fuj02b1 *) data;
+	char state_string[12] = {'\0'};
+	int volume;
+	int mute;
+	acpi_status status = AE_OK;
+	union acpi_object arg0 = {ACPI_TYPE_INTEGER};
+	struct acpi_object_list arg_list = {1, &arg0};
+	acpi_handle handle = NULL;   
+
+	ACPI_FUNCTION_TRACE("acpi_fuj02b1_write_volume_state");
+
+	if (!fuj02b1 || (count > sizeof(state_string) - 1))
+		return -EINVAL;
+
+	if (copy_from_user(state_string, buffer, count))
+		return -EFAULT;
+
+	state_string[count] = '\0';
+
+	status = acpi_get_handle(fuj02b1->handle, "SVOL", &handle);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SVOL not present\n"));
+		return -ENODEV;
+	}
+
+	if (snscanf(buffer, count, " volume : %i", &volume) == 1 && volume >= 0 && volume <= 15) {
+	/* A change of volume results in unmute */
+		arg0.integer.value = volume;
+	} else if (snscanf(buffer, count, " mute : %i", &mute) == 1 && (mute == 0 || mute == 1)) {
+	/* Remember the volume level on a mute/unmute */
+		if (mute)
+			mute = 0x40000000 | fuj02b1->volume_level;
+		else
+			mute = fuj02b1->volume_level;
+		arg0.integer.value = mute;
+	} else
+		return -EINVAL;
+
+	status = acpi_evaluate_object(handle, NULL, &arg_list, NULL);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return count;
+}
+
+
+/* --------------------------------------------------------------------------
+ Brightness States
+ -------------------------------------------------------------------------- */
+
+static int acpi_fuj02b1_get_brightness_state(void *data)
+{
+	struct acpi_fuj02b1 *fuj02b1 = (struct acpi_fuj02b1 *) data;
+	unsigned long state = 0;
+	acpi_status status = AE_OK;
+
+	// Get the Brightness
+	status = acpi_evaluate_integer(fuj02b1->handle, "GBLL", NULL, &state);
+	fuj02b1->state = state;
+
+	fuj02b1->brightness_level = state & 0x0fffffff; 
+
+	if (state & 0x80000000)
+		fuj02b1->brightness_changed = 1;
+	else
+		fuj02b1->brightness_changed = 0;
+
+	return -1;
+}
+
+static int acpi_fuj02b1_read_brightness_state(char *page, char **start,
+	off_t off, int count, int *eof, void *data)
+{
+	struct acpi_fuj02b1 *fuj02b1 = (struct acpi_fuj02b1 *) data;
+	char *p = page;
+	int len = 0;
+
+	if (!fuj02b1 || (off != 0))
+		goto end;
+
+	acpi_fuj02b1_get_brightness_state(fuj02b1);
+
+	p += sprintf(p, "brightness:              %d\n", fuj02b1->brightness_level);
+	p += sprintf(p, "brightness levels:       8\n");
+
+end:
+	len = (p - page);
+	if (len <= off + count) *eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len > count) len = count;
+	if (len < 0) len = 0;
+
+	return len;
+}
+
+static int acpi_fuj02b1_write_brightness_state(struct file *file,
+	const char *buffer, unsigned long count, void *data)
+{
+	struct acpi_fuj02b1 *fuj02b1 = (struct acpi_fuj02b1 *) data;
+	char state_string[24] = {'\0'};
+	int brightness;
+	acpi_status status = AE_OK;
+	union acpi_object arg0 = {ACPI_TYPE_INTEGER};
+	struct acpi_object_list arg_list = {1, &arg0};
+	acpi_handle handle = NULL;   
+
+	ACPI_FUNCTION_TRACE("acpi_fuj02b1_write_brightness_state");
+
+	if (!fuj02b1 || (count > sizeof(state_string) - 1))
+		return -EINVAL;
+
+	if (copy_from_user(state_string, buffer, count))
+		return -EFAULT;
+
+	state_string[count] = '\0';
+
+	status = acpi_get_handle(fuj02b1->handle, "SBLL", &handle);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SBLL not present\n"));
+		return -ENODEV;
+	}
+
+	if (snscanf(buffer, count, " brightness : %i", &brightness) == 1 && brightness >= 0 && brightness <= 7)
+		arg0.integer.value = brightness;
+	else
+	{
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "No Woot \n"));
+		return -EINVAL;      
+	}
+
+	status = acpi_evaluate_object(handle, NULL, &arg_list, NULL);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return count;
+}
+
+
+/* --------------------------------------------------------------------------
+ Pointer States
+ -------------------------------------------------------------------------- */
+
+static int acpi_fuj02b1_get_pointer_state(void *data)
+{
+	struct acpi_fuj02b1 *fuj02b1 = (struct acpi_fuj02b1 *) data;
+	unsigned long state = 0;
+	acpi_status status = AE_OK;
+
+	// Get the pointer state
+	status = acpi_evaluate_integer(fuj02b1->handle, "GMOU", NULL, &state);
+	fuj02b1->state = state;
+
+	fuj02b1->pointer_state = state & 0x0fffffff; 
+
+	if (state & 0x80000000)
+		fuj02b1->pointer_changed = 1;
+	else
+		fuj02b1->pointer_changed = 0;
+
+	return -1;
+}
+
+static int acpi_fuj02b1_read_pointer_state(char *page, char **start,
+	off_t off, int count, int *eof, void *data)
+{
+	struct acpi_fuj02b1 *fuj02b1 = (struct acpi_fuj02b1 *) data;
+	char *p = page;
+	int len = 0;
+
+	ACPI_FUNCTION_TRACE("acpi_fuj02b1_read_pointer_state");
+
+	if (!fuj02b1 || (off != 0))
+		goto end;
+
+	acpi_fuj02b1_get_pointer_state(fuj02b1);
+
+	p += sprintf(p, "pointer:                 %d\n", fuj02b1->pointer_state);
+
+end:
+	len = (p - page);
+	if (len <= off + count) *eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len > count) len = count;
+	if (len < 0) len = 0;
+
+	return len;
+}
+
+static int acpi_fuj02b1_write_pointer_state(struct file *file,
+	const char *buffer, unsigned long count, void *data)
+{
+	struct acpi_fuj02b1 *fuj02b1 = (struct acpi_fuj02b1 *) data;
+	char state_string[24] = {'\0'};
+	int pointer;
+	acpi_status status = AE_OK;
+	union acpi_object arg0 = {ACPI_TYPE_INTEGER};
+	struct acpi_object_list arg_list = {1, &arg0};
+	acpi_handle handle = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_fuj02b1_write_pointer_state");
+
+	if (!fuj02b1 || (count > sizeof(state_string) - 1))
+		return -EINVAL;
+
+	if (copy_from_user(state_string, buffer, count))
+		return -EFAULT;
+
+	state_string[count] = '\0';
+
+	status = acpi_get_handle(fuj02b1->handle, "SMOU", &handle);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SMOU not present\n"));
+		return -ENODEV;
+	}
+
+	if (snscanf(buffer, count, " pointer : %i", &pointer) == 1 && (pointer == 0 || pointer == 1))
+		arg0.integer.value = pointer;
+	else
+		return -EINVAL;      
+
+	status = acpi_evaluate_object(handle, NULL, &arg_list, NULL);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return count;
+}
+
+static int acpi_fuj02b1_add_fs(struct acpi_device *device)
+{
+	struct proc_dir_entry *entry_volume = NULL;
+	struct proc_dir_entry *entry_brightness = NULL;
+	struct proc_dir_entry *entry_pointer = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_fuj02b1_add_fs");
+
+	if (!device)
+		return -EINVAL;
+
+	acpi_device_dir(device) = acpi_fuj02b1_dir;
+	if (!acpi_device_dir(device))
+		return -ENODEV;
+
+	/* 'status' [R/W] */
+	entry_volume = create_proc_entry(ACPI_FUJ02B1_FILE_VOLUME,
+			S_IFREG|S_IRUGO|S_IWUSR, acpi_device_dir(device));
+	entry_brightness = create_proc_entry(ACPI_FUJ02B1_FILE_BRIGHTNESS,
+			S_IFREG|S_IRUGO|S_IWUSR, acpi_device_dir(device));
+	entry_pointer = create_proc_entry(ACPI_FUJ02B1_FILE_POINTER,
+			S_IFREG|S_IRUGO|S_IWUSR, acpi_device_dir(device));
+
+	if (!entry_volume)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Unable to create '%s' fs entry\n",
+			ACPI_FUJ02B1_FILE_VOLUME));
+	else {
+		entry_volume->read_proc = acpi_fuj02b1_read_volume_state;
+		entry_volume->write_proc = acpi_fuj02b1_write_volume_state;
+		entry_volume->data = acpi_driver_data(device);
+	}
+
+	if (!entry_brightness)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Unable to create '%s' fs entry\n",
+			ACPI_FUJ02B1_FILE_BRIGHTNESS));
+	else {
+		entry_brightness->read_proc = acpi_fuj02b1_read_brightness_state;
+		entry_brightness->write_proc = acpi_fuj02b1_write_brightness_state;
+		entry_brightness->data = acpi_driver_data(device);
+	}
+
+	if (!entry_pointer)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Unable to create '%s' fs entry\n",
+			ACPI_FUJ02B1_FILE_POINTER));
+	else {
+		entry_pointer->read_proc = acpi_fuj02b1_read_pointer_state;
+		entry_pointer->write_proc = acpi_fuj02b1_write_pointer_state;
+		entry_pointer->data = acpi_driver_data(device);
+	}
+
+	return 0;
+}
+
+static int acpi_fuj02b1_remove_fs(struct acpi_device *device)
+{
+	ACPI_FUNCTION_TRACE("acpi_fuj02b1_remove_fs");
+
+	if (acpi_device_dir(device)) {
+		remove_proc_entry(acpi_device_bid(device), acpi_fuj02b1_dir);
+		acpi_device_dir(device) = NULL;
+	}
+
+	return 0;
+}
+
+
+/* --------------------------------------------------------------------------
+ Driver Interface
+ -------------------------------------------------------------------------- */
+
+void acpi_fuj02b1_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_fuj02b1 *fuj02b1 = (struct acpi_fuj02b1 *) data;
+	struct acpi_device *device = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_fuj02b1_notify");
+
+	if (!fuj02b1)
+		return;
+
+	if (acpi_bus_get_device(fuj02b1->handle, &device))
+		return;
+
+	switch (event) {
+		case ACPI_FUJ02B1_NOTIFY_STATUS:
+			acpi_fuj02b1_get_volume_state(fuj02b1);      
+			if (fuj02b1->volume_changed == 1)
+				acpi_bus_generate_event(device, event, (u32) fuj02b1->volume_level | (fuj02b1->mute_state * 0x1000000) | 0x10000000);
+
+			acpi_fuj02b1_get_brightness_state(fuj02b1);
+			if (fuj02b1->brightness_changed == 1)
+				acpi_bus_generate_event(device, event, (u32) fuj02b1->brightness_level | 0x20000000);
+
+			acpi_fuj02b1_get_pointer_state(fuj02b1);
+			if (fuj02b1->pointer_changed == 1)
+				acpi_bus_generate_event(device, event, (u32) fuj02b1->pointer_state | 0x30000000);
+			break;
+		default:
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				"Unsupported event [0x%x]\n", event));
+			break;
+	}
+
+	return;
+}
+
+int acpi_fuj02b1_add(struct acpi_device *device)
+{
+	struct acpi_fuj02b1 *fuj02b1 = NULL;
+	int result = 0;
+	int state = 0;
+	acpi_status status = AE_OK;
+
+	ACPI_FUNCTION_TRACE("acpi_fuj02b1_add");
+
+	if (!device)
+		return -EINVAL;
+
+	fuj02b1 = kmalloc(sizeof(struct acpi_fuj02b1), GFP_KERNEL);
+	if (!fuj02b1)
+		return -ENOMEM;
+	memset(fuj02b1, 0, sizeof(struct acpi_fuj02b1));
+
+	fuj02b1->handle = device->handle;
+	sprintf(acpi_device_name(device), "%s", ACPI_FUJ02B1_DEVICE_NAME);
+	sprintf(acpi_device_class(device), "%s", ACPI_FUJ02B1_CLASS);
+	acpi_driver_data(device) = fuj02b1;
+
+	result = acpi_bus_get_power(fuj02b1->handle, &state);
+	if (result) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error reading power state\n"));
+		goto end;
+	}
+
+	result = acpi_fuj02b1_add_fs(device);
+	if (result)
+		goto end;
+
+	status = acpi_install_notify_handler(fuj02b1->handle,
+		ACPI_DEVICE_NOTIFY, acpi_fuj02b1_notify, fuj02b1);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error installing notify handler\n"));
+		result = -ENODEV;
+		goto end;
+	}
+
+	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
+		acpi_device_name(device), acpi_device_bid(device), !device->power.state ? "on" : "off");
+
+end:
+	if (result)
+		kfree(fuj02b1);
+
+	return result;
+}
+
+int acpi_fuj02b1_remove(struct acpi_device *device, int type)
+{
+	acpi_status status = AE_OK;
+	struct acpi_fuj02b1 *fuj02b1 = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_fuj02b1_remove");
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
+	fuj02b1 = (struct acpi_fuj02b1 *) acpi_driver_data(device);
+
+	status = acpi_remove_notify_handler(fuj02b1->handle,
+		ACPI_DEVICE_NOTIFY, acpi_fuj02b1_notify);
+	if (ACPI_FAILURE(status))
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+		"Error removing notify handler\n"));
+
+	acpi_fuj02b1_remove_fs(device);
+
+	kfree(fuj02b1);
+
+	return 0;
+}
+
+int __init acpi_fuj02b1_init(void)
+{
+	int result = 0;
+
+	ACPI_FUNCTION_TRACE("acpi_fuj02b1_init");
+
+	acpi_fuj02b1_dir = proc_mkdir(ACPI_FUJ02B1_CLASS, acpi_root_dir);
+	if (!acpi_fuj02b1_dir)
+		return -ENODEV;
+
+	result = acpi_bus_register_driver(&acpi_fuj02b1_driver);
+	if (result < 0) {
+		remove_proc_entry(ACPI_FUJ02B1_CLASS, acpi_root_dir);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+void __exit acpi_fuj02b1_exit(void)
+{
+	acpi_bus_unregister_driver(&acpi_fuj02b1_driver);
+
+	remove_proc_entry(ACPI_FUJ02B1_CLASS, acpi_root_dir);
+
+	return;
+}
+
+module_init(acpi_fuj02b1_init);
+module_exit(acpi_fuj02b1_exit);
