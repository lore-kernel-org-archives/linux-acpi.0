From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 4/6] misc: add dell-wmi driver for hotkey control
Date: Fri, 03 Apr 2009 22:57:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904032248500.4655@localhost.localdomain>
References: <200901092017.n09KHCcY014999@imap1.linux-foundation.org>
 <alpine.LFD.2.00.0901091602360.16697@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:48732 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbZDDC5Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2009 22:57:25 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHK00IUX2VI24P3@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 03 Apr 2009 21:57:19 -0500 (CDT)
In-reply-to: <alpine.LFD.2.00.0901091602360.16697@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, dtor@mail.ru, mjg@redhat.com

From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Fri, 9 Jan 2009 20:17:11 +0000
Subject: [PATCH] dell-wmi: new driver for hotkey control

Add a WMI driver for Dell laptops. Currently it does nothing but send a
generic input event when a button with a picture of a battery on it is
pressed, but maybe other uses will appear over time.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---

Looks like I screwed up and caused this patch to get dropped.
Here it is picked up again, ported on top of 2.6.29.

Matthew, should we proceed with this on in the mix?

thanks,
-Len

 MAINTAINERS                     |    5 +
 drivers/platform/x86/Kconfig    |   10 ++
 drivers/platform/x86/Makefile   |    1 +
 drivers/platform/x86/dell-wmi.c |  210 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 226 insertions(+), 0 deletions(-)
 create mode 100644 drivers/platform/x86/dell-wmi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d460c9..4ee5964 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1393,6 +1393,11 @@ P:	Doug Warzecha
 M:	Douglas_Warzecha@dell.com
 S:	Maintained
 
+DELL WMI EXTRAS DRIVER
+P:	Matthew Garrett
+M:	mjg59@srcf.ucam.org
+S:	Maintained
+
 DEVICE NUMBER REGISTRY
 P:	Torben Mathiasen
 M:	device@lanana.org
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 3608081..a27bff3 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -67,6 +67,16 @@ config DELL_LAPTOP
 	This driver adds support for rfkill and backlight control to Dell
 	laptops.
 
+config DELL_WMI
+	tristate "Dell WMI extras"
+	depends on ACPI_WMI
+	depends on INPUT
+	---help---
+	  Say Y here if you want to support WMI-based hotkeys on Dell laptops.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called dell-wmi.
+
 config FUJITSU_LAPTOP
 	tristate "Fujitsu Laptop Extras"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index e290651..e40c7bd 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_EEEPC_LAPTOP)	+= eeepc-laptop.o
 obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
 obj-$(CONFIG_COMPAL_LAPTOP)	+= compal-laptop.o
 obj-$(CONFIG_DELL_LAPTOP)	+= dell-laptop.o
+obj-$(CONFIG_DELL_WMI)		+= dell-wmi.o
 obj-$(CONFIG_ACER_WMI)		+= acer-wmi.o
 obj-$(CONFIG_HP_WMI)		+= hp-wmi.o
 obj-$(CONFIG_TC1100_WMI)	+= tc1100-wmi.o
diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
new file mode 100644
index 0000000..2fab941
--- /dev/null
+++ b/drivers/platform/x86/dell-wmi.c
@@ -0,0 +1,210 @@
+/*
+ * Dell WMI hotkeys
+ *
+ * Copyright (C) 2008 Red Hat <mjg@redhat.com>
+ *
+ * Portions based on wistron_btns.c:
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
+#include <linux/acpi.h>
+#include <linux/string.h>
+
+MODULE_AUTHOR("Matthew Garrett <mjg@redhat.com>");
+MODULE_DESCRIPTION("Dell laptop WMI hotkeys driver");
+MODULE_LICENSE("GPL");
+
+#define DELL_EVENT_GUID "9DBB5994-A997-11DA-B012-B622A1EF5492"
+
+MODULE_ALIAS("wmi:"DELL_EVENT_GUID);
+
+struct key_entry {
+	char type;		/* See KE_* below */
+	u16 code;
+	u16 keycode;
+};
+
+enum { KE_KEY, KE_SW, KE_END };
+
+static struct key_entry dell_wmi_keymap[] = {
+	{KE_KEY, 0xe045, KEY_PROG1},
+	{KE_END, 0}
+};
+
+static struct input_dev *dell_wmi_input_dev;
+
+static struct key_entry *dell_wmi_get_entry_by_scancode(int code)
+{
+	struct key_entry *key;
+
+	for (key = dell_wmi_keymap; key->type != KE_END; key++)
+		if (code == key->code)
+			return key;
+
+	return NULL;
+}
+
+static struct key_entry *dell_wmi_get_entry_by_keycode(int keycode)
+{
+	struct key_entry *key;
+
+	for (key = dell_wmi_keymap; key->type != KE_END; key++)
+		if (key->type == KE_KEY && keycode == key->keycode)
+			return key;
+
+	return NULL;
+}
+
+static int dell_wmi_getkeycode(struct input_dev *dev, int scancode,
+			       int *keycode)
+{
+	struct key_entry *key = dell_wmi_get_entry_by_scancode(scancode);
+
+	if (key && key->type == KE_KEY) {
+		*keycode = key->keycode;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int dell_wmi_setkeycode(struct input_dev *dev, int scancode, int keycode)
+{
+	struct key_entry *key;
+	int old_keycode;
+
+	if (keycode < 0 || keycode > KEY_MAX)
+		return -EINVAL;
+
+	key = dell_wmi_get_entry_by_scancode(scancode);
+	if (key && key->type == KE_KEY) {
+		old_keycode = key->keycode;
+		key->keycode = keycode;
+		set_bit(keycode, dev->keybit);
+		if (!dell_wmi_get_entry_by_keycode(old_keycode))
+			clear_bit(old_keycode, dev->keybit);
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static void dell_wmi_notify(u32 value, void *context)
+{
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	static struct key_entry *key;
+	union acpi_object *obj;
+
+	wmi_get_event_data(value, &response);
+
+	obj = (union acpi_object *)response.pointer;
+
+	if (obj && obj->type == ACPI_TYPE_BUFFER) {
+		int *buffer = (int *)obj->buffer.pointer;
+		key = dell_wmi_get_entry_by_scancode(buffer[1]);
+		if (key) {
+			input_report_key(dell_wmi_input_dev, key->keycode, 1);
+			input_sync(dell_wmi_input_dev);
+			input_report_key(dell_wmi_input_dev, key->keycode, 0);
+			input_sync(dell_wmi_input_dev);
+		} else
+			printk(KERN_INFO "dell-wmi: Unknown key %x pressed\n",
+			       buffer[1]);
+	}
+}
+
+static int __init dell_wmi_input_setup(void)
+{
+	struct key_entry *key;
+	int err;
+
+	dell_wmi_input_dev = input_allocate_device();
+
+	if (!dell_wmi_input_dev)
+		return -ENOMEM;
+
+	dell_wmi_input_dev->name = "Dell WMI hotkeys";
+	dell_wmi_input_dev->phys = "wmi/input0";
+	dell_wmi_input_dev->id.bustype = BUS_HOST;
+	dell_wmi_input_dev->getkeycode = dell_wmi_getkeycode;
+	dell_wmi_input_dev->setkeycode = dell_wmi_setkeycode;
+
+	for (key = dell_wmi_keymap; key->type != KE_END; key++) {
+		switch (key->type) {
+		case KE_KEY:
+			set_bit(EV_KEY, dell_wmi_input_dev->evbit);
+			set_bit(key->keycode, dell_wmi_input_dev->keybit);
+			break;
+		case KE_SW:
+			set_bit(EV_SW, dell_wmi_input_dev->evbit);
+			set_bit(key->keycode, dell_wmi_input_dev->swbit);
+			break;
+		}
+	}
+
+	err = input_register_device(dell_wmi_input_dev);
+
+	if (err) {
+		input_free_device(dell_wmi_input_dev);
+		return err;
+	}
+
+	return 0;
+}
+
+static int __init dell_wmi_init(void)
+{
+	int err;
+
+	if (wmi_has_guid(DELL_EVENT_GUID)) {
+		err = dell_wmi_input_setup();
+
+		if (err)
+			return err;
+
+		err = wmi_install_notify_handler(DELL_EVENT_GUID,
+						 dell_wmi_notify, NULL);
+		if (err) {
+			input_unregister_device(dell_wmi_input_dev);
+			printk(KERN_ERR "dell-wmi: Unable to register"
+			       " notify handler - %d\n", err);
+			return err;
+		}
+
+	} else
+		printk(KERN_WARNING "dell-wmi: No known WMI GUID found\n");
+
+	return 0;
+}
+
+static void __exit dell_wmi_exit(void)
+{
+	if (wmi_has_guid(DELL_EVENT_GUID)) {
+		wmi_remove_notify_handler(DELL_EVENT_GUID);
+		input_unregister_device(dell_wmi_input_dev);
+	}
+}
+
+module_init(dell_wmi_init);
+module_exit(dell_wmi_exit);
-- 
1.6.2.2.404.ge96f3

