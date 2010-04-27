From: =?ISO-8859-15?Q?Robert_W=F6rle?= <robert@linuxdevelopment.de>
Subject: [PATCH 1/1] Tabletkiosk eo7300 series WMI button support
Date: Tue, 27 Apr 2010 16:09:52 +0200
Message-ID: <4BD6F030.6080701@linuxdevelopment.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020607090204060600020200"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51992 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828Ab0D0OKE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Apr 2010 10:10:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020607090204060600020200
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Dear List

find attached a patch to get the WMI buttons going for the Tabletkiosk
eo7300
of course i will host this driver on our website but if they ever get
included , i would be more then proud.

As i am not a frequent patch sender, feel free to bitch me about
condingstyle or anything else to get this patch fly.

Cheers Rob



--------------020607090204060600020200
Content-Type: text/x-patch;
 name="i7330-wmi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i7330-wmi.patch"

diff -Nur linux-2.6.32.8-orig/drivers/platform/x86/i7330-wmi.c linux-2.6.32.8/drivers/platform/x86//i7330-wmi.c
--- linux-2.6.32.8-orig/drivers/platform/x86/i7330-wmi.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.32.8/drivers/platform/x86/i7330-wmi.c	2010-04-27 15:13:02.000000000 +0200
@@ -0,0 +1,249 @@
+/*
+ * eo 7300 WMI hotkeys
+ *
+ * Copyright (C) 2008 Red Hat <mjg@redhat.com>
+ *
+ * Derived from hp-wmi.c:
+ * Copyright (C) 2005 Miloslav Trmac <mitr@volny.cz>
+ * Copyright (C) 2005 Bernhard Rosenkraenzer <bero@arklinux.org>
+ * Copyright (C) 2005 Dmitry Torokhov <dtor@mail.ru>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/input.h>
+#include <acpi/acpi_drivers.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+#include <linux/rfkill.h>
+#include <linux/string.h>
+
+MODULE_AUTHOR("Robert Woerle <robert@tabletkiosk.de>");
+MODULE_DESCRIPTION("eo7300 WMI hotkeys driver");
+MODULE_LICENSE("GPL");
+
+MODULE_ALIAS("wmi:67C3371D-95A3-4C37-BB61-DD47B491DAAB");
+MODULE_ALIAS("wmi:40D1BF71-A82D-4E59-A168-3985E03B2E87");
+
+
+#define EVENT1	"40D1BF71-A82D-4E59-A168-3985E03B2E87"
+#define EVENT2  "67C3371D-95A3-4C37-BB61-DD47B491DAAB"
+/* will we ever need those ? */
+#define EVENT3  "431F16ED-0C2B-444C-B267-27DEB140CF9C"
+#define EVENT4  "D9F41781-F633-4400-9355-601770BEC510"
+
+/* hooks to see the button release events */
+#define KEY_F13_UP	129
+#define KEY_F14_UP	130
+#define KEY_F15_UP	131
+
+struct key_entry {
+	char type;		/* See KE_* below */
+	u16 code;
+	u16 keycode;
+};
+
+enum { KE_KEY, KE_END };
+
+static struct key_entry tk_wmi_keymap[] = {
+	{KE_KEY, 0x01, KEY_F13},
+	{KE_KEY, 0x02, KEY_F14},
+	{KE_KEY, 0x03, KEY_F15},
+	{KE_END, 0}
+};
+
+static struct input_dev *tk_wmi_input_dev;
+
+static struct key_entry *tk_wmi_get_entry_by_scancode(int code)
+{
+	struct key_entry *key;
+
+	for (key = tk_wmi_keymap; key->type != KE_END; key++)
+		if (code == key->code)
+			return key;
+
+	return NULL;
+}
+
+static struct key_entry *tk_wmi_get_entry_by_keycode(int keycode)
+{
+	struct key_entry *key;
+
+	for (key = tk_wmi_keymap; key->type != KE_END; key++)
+		if (key->type == KE_KEY && keycode == key->keycode)
+			return key;
+
+	return NULL;
+}
+
+static int tk_wmi_getkeycode(struct input_dev *dev, int scancode, int *keycode)
+{
+	struct key_entry *key = tk_wmi_get_entry_by_scancode(scancode);
+
+	if (key && key->type == KE_KEY) {
+		*keycode = key->keycode;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int tk_wmi_setkeycode(struct input_dev *dev, int scancode, int keycode)
+{
+	struct key_entry *key;
+	int old_keycode;
+
+	if (keycode < 0 || keycode > KEY_MAX)
+		return -EINVAL;
+
+	key = tk_wmi_get_entry_by_scancode(scancode);
+	if (key && key->type == KE_KEY) {
+		old_keycode = key->keycode;
+		key->keycode = keycode;
+		set_bit(keycode, dev->keybit);
+		if (!tk_wmi_get_entry_by_keycode(old_keycode))
+			clear_bit(old_keycode, dev->keybit);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static void tk_wmi_notify(u32 value, void *context)
+{
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	static struct key_entry *key;
+	union acpi_object *obj;
+
+	wmi_get_event_data(value, &response);
+	
+	obj = (union acpi_object *)response.pointer;
+
+	if (obj && obj->type == ACPI_TYPE_BUFFER && obj->buffer.length == 4) {
+		int eventcode = *((u8 *) obj->buffer.pointer);
+
+		key = tk_wmi_get_entry_by_scancode(eventcode);
+		if (key) {
+			switch (key->type) {
+			case KE_KEY:
+				input_report_key(tk_wmi_input_dev,
+						 key->keycode, 1);
+				input_sync(tk_wmi_input_dev);
+				break;
+			}
+		} else if (eventcode == KEY_F13_UP) {
+				input_report_key(tk_wmi_input_dev,
+						 KEY_F13, 0);
+				input_sync(tk_wmi_input_dev);
+		} else if (eventcode == KEY_F14_UP) {
+				input_report_key(tk_wmi_input_dev,
+						 KEY_F14, 0);
+				input_sync(tk_wmi_input_dev);
+		} else if (eventcode == KEY_F15_UP) {
+				input_report_key(tk_wmi_input_dev,
+						 KEY_F15, 0);
+				input_sync(tk_wmi_input_dev);
+		} else
+			printk(KERN_INFO "tk WMI: Unknown key pressed - %x\n",
+			       eventcode);
+	} else
+		printk(KERN_INFO "tk WMI: Unknown response received\n");
+}
+
+static int __init tk_wmi_input_setup(void)
+{
+	struct key_entry *key;
+	int err;
+
+	tk_wmi_input_dev = input_allocate_device();
+
+	tk_wmi_input_dev->name = "eo 7300 WMI hotkeys";
+	tk_wmi_input_dev->phys = "wmi/input0";
+	tk_wmi_input_dev->id.bustype = BUS_HOST;
+	tk_wmi_input_dev->getkeycode = tk_wmi_getkeycode;
+	tk_wmi_input_dev->setkeycode = tk_wmi_setkeycode;
+
+	for (key = tk_wmi_keymap; key->type != KE_END; key++) {
+		switch (key->type) {
+		case KE_KEY:
+			set_bit(EV_KEY, tk_wmi_input_dev->evbit);
+			set_bit(key->keycode, tk_wmi_input_dev->keybit);
+			break;
+		}
+	}
+
+	input_sync(tk_wmi_input_dev);
+
+	err = input_register_device(tk_wmi_input_dev);
+
+	if (err) {
+		input_free_device(tk_wmi_input_dev);
+		return err;
+	}
+
+	return 0;
+}
+
+
+static int __init tk_wmi_init(void)
+{
+	int err;
+	struct acpi_buffer input;
+	acpi_status status;
+	struct wmab_args {
+		u32 eax;
+		u32 ebx;
+		u32 ecx;
+		u32 edx;
+		} wmab_args;
+
+	if (wmi_has_guid(EVENT1)) {
+		err = wmi_install_notify_handler(EVENT1,
+						 tk_wmi_notify, NULL);
+		if (!err)
+			tk_wmi_input_setup();
+	}
+
+	/* FOO() to active the ACPI Method */
+	/* luckly acer-wmi did this and made it happen in the first place */
+	/* why , i dont know, and i dont care now */
+
+	wmab_args.eax = 86;
+	wmab_args.ebx = 0;
+	wmab_args.ecx = 0;
+	wmab_args.edx = 0;
+
+	input.length = sizeof(struct wmab_args);
+	input.pointer = &wmab_args;
+
+	status = wmi_evaluate_method(EVENT2, 1, 1, &input, 0);
+
+	return 0;
+}
+
+static void __exit tk_wmi_exit(void)
+{
+	if (wmi_has_guid(EVENT1)){
+		wmi_remove_notify_handler(EVENT1);
+		input_unregister_device(tk_wmi_input_dev);
+	}
+}
+
+module_init(tk_wmi_init);
+module_exit(tk_wmi_exit);
diff -Nur linux-2.6.32.8-orig/drivers/platform/x86/Kconfig linux-2.6.32.8/drivers/platform/x86//Kconfig
--- linux-2.6.32.8-orig/drivers/platform/x86/Kconfig	2010-02-09 13:57:19.000000000 +0100
+++ linux-2.6.32.8/drivers/platform/x86/Kconfig	2010-04-27 11:40:30.000000000 +0200
@@ -143,6 +143,16 @@
 	 To compile this driver as a module, choose M here: the module will
 	 be called hp-wmi.
 
+config I7330_WMI
+        tristate "Tabletkiosk i7330 WMI buttons"
+        depends on ACPI_WMI
+        depends on INPUT
+        help
+         Say Y here if you want to support WMI-based hotkeys on eo(tm) i7330 
+	 Tabletkiosk Slate Tablet
+	 To compile this driver as a module, choose M here: the module will
+         be called i7330-wmi.
+
 config MSI_LAPTOP
 	tristate "MSI Laptop Extras"
 	depends on ACPI
diff -Nur linux-2.6.32.8-orig/drivers/platform/x86/Makefile linux-2.6.32.8/drivers/platform/x86//Makefile
--- linux-2.6.32.8-orig/drivers/platform/x86/Makefile	2010-02-09 13:57:19.000000000 +0100
+++ linux-2.6.32.8/drivers/platform/x86/Makefile	2010-04-26 08:06:55.000000000 +0200
@@ -21,3 +21,4 @@
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_TOPSTAR_LAPTOP)	+= topstar-laptop.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
+obj-$(CONFIG_I7330_WMI)		+= i7330-wmi.o



--------------020607090204060600020200--
