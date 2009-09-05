From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] topstar_acpi: add new driver for hotkeys support on Topstar N01
Date: Sat, 5 Sep 2009 02:29:55 -0300
Message-ID: <200909050229.55665.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TdfoKHR6ts35Tk8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:52723 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbZIEFvj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Sep 2009 01:51:39 -0400
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 43AAF2EE48
	for <linux-acpi@vger.kernel.org>; Sat,  5 Sep 2009 01:30:07 -0400 (EDT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id pJHPeTLfiTDK for <linux-acpi@vger.kernel.org>;
	Sat,  5 Sep 2009 01:30:04 -0400 (EDT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id A94A82EE47
	for <linux-acpi@vger.kernel.org>; Sat,  5 Sep 2009 01:30:03 -0400 (EDT)
Received: from palo.localnet (unknown [172.21.225.6])
	by fox.conectiva (Postfix) with ESMTP id 4F7112F22C
	for <linux-acpi@vger.kernel.org>; Sat,  5 Sep 2009 02:29:58 -0300 (BRT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--Boundary-00=_TdfoKHR6ts35Tk8
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

This adds Topstar Laptop Extras ACPI driver. It enables hotkeys
functionality with Topstar N01 netbook. Besides hotkeys there are
other functions exposed by its ACPI firmware, but for now only
hotkeys reporting on Topstar N01 is supported. Topstar is a chinese
manufacturer, its website can be currently reached at
http://www.topstardigital.cn/

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 drivers/platform/x86/Kconfig        |    8 +
 drivers/platform/x86/Makefile       |    1 +
 drivers/platform/x86/topstar_acpi.c |  301 +++++++++++++++++++++++++++++++++++
 3 files changed, 310 insertions(+), 0 deletions(-)
 create mode 100644 drivers/platform/x86/topstar_acpi.c

I'm attaching here too the gzipped acpidump of Topstar N01, which I based to do
the driver.

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 77c6097..3ba2caa 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -396,6 +396,14 @@ config ACPI_ASUS
 	  NOTE: This driver is deprecated and will probably be removed soon,
 	  use asus-laptop instead.
 
+config ACPI_TOPSTAR
+	tristate "Topstar Laptop Extras"
+	depends on ACPI
+	---help---
+	  This driver adds support for hotkeys found on topstar laptops.
+
+	  If you have a Topstar laptop, say Y or M here.
+
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 641b8bf..a32e8dd 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -19,4 +19,5 @@ obj-$(CONFIG_PANASONIC_LAPTOP)	+= panasonic-laptop.o
 obj-$(CONFIG_INTEL_MENLOW)	+= intel_menlow.o
 obj-$(CONFIG_ACPI_WMI)		+= wmi.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
+obj-$(CONFIG_ACPI_TOPSTAR)	+= topstar_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
diff --git a/drivers/platform/x86/topstar_acpi.c b/drivers/platform/x86/topstar_acpi.c
new file mode 100644
index 0000000..e852de2
--- /dev/null
+++ b/drivers/platform/x86/topstar_acpi.c
@@ -0,0 +1,301 @@
+/*
+ * ACPI driver for Topstar notebooks (hotkeys support only)
+ *
+ * Copyright (c) 2009 Herton Ronaldo Krzesinski <herton@mandriva.com.br>
+ *
+ * Implementation inspired by existing x86 platform drivers, in special
+ * asus/eepc/fujitsu-laptop, thanks to their authors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/mod_devicetable.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/actypes.h>
+#include <acpi/acpixf.h>
+#include <linux/input.h>
+
+#define ACPI_TOPSTAR_HID "TPSACPI01"
+#define ACPI_TOPSTAR_DEVICE_NAME "Topstar TPSACPI01"
+#define ACPI_TOPSTAR_DRIVER_NAME "Topstar laptop ACPI driver"
+#define ACPI_TOPSTAR_CLASS "topstar"
+
+#define TOPSTAR_ACPI_NAME "topstar_acpi"
+#define TOPSTAR_ACPI_ERR KERN_ERR TOPSTAR_ACPI_NAME ": "
+#define TOPSTAR_ACPI_INFO KERN_INFO TOPSTAR_ACPI_NAME ": "
+
+static const struct acpi_device_id topstar_device_ids[] = {
+	{ ACPI_TOPSTAR_HID, 0 },
+	{ "", 0 },
+};
+
+struct topstar_hkey {
+	struct input_dev *inputdev;
+};
+
+struct tps_key_entry {
+	u8 code;
+	u16 keycode;
+};
+
+static struct tps_key_entry topstar_keymap[] = {
+	{ 0x80, KEY_BRIGHTNESSUP },
+	{ 0x81, KEY_BRIGHTNESSDOWN },
+	{ 0x83, KEY_VOLUMEUP },
+	{ 0x84, KEY_VOLUMEDOWN },
+	{ 0x85, KEY_MUTE },
+	{ 0x86, KEY_SWITCHVIDEOMODE },
+	{ 0x87, KEY_F13 }, /* touchpad enable/disable key */
+	{ 0x88, KEY_WLAN },
+	{ 0x8a, KEY_WWW },
+	{ 0x8b, KEY_MAIL },
+	{ 0x8c, KEY_MEDIA },
+	{ 0x96, KEY_F14 }, /* G key? */
+	{ }
+};
+
+static struct tps_key_entry *tps_get_key_by_scancode(int code)
+{
+	struct tps_key_entry *key;
+
+	for (key = topstar_keymap; key->code; key++)
+		if (code == key->code)
+			return key;
+
+	return NULL;
+}
+
+static struct tps_key_entry *tps_get_key_by_keycode(int code)
+{
+	struct tps_key_entry *key;
+
+	for (key = topstar_keymap; key->code; key++)
+		if (code == key->keycode)
+			return key;
+
+	return NULL;
+}
+
+static void acpi_topstar_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct tps_key_entry *key;
+	static bool dup_evnt[2];
+	bool *dup;
+	struct topstar_hkey *hkey = data;
+
+	/* 0x83 and 0x84 key events comes duplicated... */
+	if (event == 0x83 || event == 0x84) {
+		dup = &dup_evnt[event - 0x83];
+		if (*dup) {
+			*dup = false;
+			return;
+		}
+		*dup = true;
+	}
+
+	/*
+	 * 'G key' generate two event codes, convert to only
+	 * one event/key code for now (3G switch?)
+	 */
+	if (event == 0x97)
+		event = 0x96;
+
+	key = tps_get_key_by_scancode(event);
+	if (key) {
+		input_report_key(hkey->inputdev, key->keycode, 1);
+		input_sync(hkey->inputdev);
+		input_report_key(hkey->inputdev, key->keycode, 0);
+		input_sync(hkey->inputdev);
+		return;
+	}
+
+	/* Known non hotkey events don't handled or that we don't care yet */
+	if (event == 0x8e || event == 0x8f || event == 0x90)
+		return;
+
+	printk(TOPSTAR_ACPI_INFO "unknown event = 0x%02x\n", event);
+}
+
+static int acpi_topstar_fncx_switch(struct acpi_device *device, bool state)
+{
+	acpi_status status;
+	acpi_handle handle = NULL;
+	union acpi_object fncx_params[1] = {
+		{ .type = ACPI_TYPE_INTEGER }
+	};
+	struct acpi_object_list fncx_arg_list = { 1, &fncx_params[0] };
+	struct acpi_buffer buf;
+	union acpi_object obj;
+
+	status = acpi_get_handle(device->handle, "FNCX", &handle);
+	if (ACPI_FAILURE(status)) {
+		printk(TOPSTAR_ACPI_ERR "FNCX method not found\n");
+		return -ENODEV;
+	}
+	fncx_params[0].integer.value = state ? 0x86 : 0x87;
+	buf.length = sizeof(obj);
+	buf.pointer = &obj;
+	status = acpi_evaluate_object(handle, NULL, &fncx_arg_list, &buf);
+	if (ACPI_FAILURE(status)) {
+		printk(TOPSTAR_ACPI_ERR
+		       "Unable to switch FNCX notifications\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int topstar_getkeycode(struct input_dev *dev, int scancode, int *keycode)
+{
+	struct tps_key_entry *key = tps_get_key_by_scancode(scancode);
+
+	if (key) {
+		*keycode = key->keycode;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int topstar_setkeycode(struct input_dev *dev, int scancode, int keycode)
+{
+	struct tps_key_entry *key;
+	int old_keycode;
+
+	if (keycode < 0 || keycode > KEY_MAX)
+		return -EINVAL;
+
+	key = tps_get_key_by_scancode(scancode);
+	if (key) {
+		old_keycode = key->keycode;
+		key->keycode = keycode;
+		set_bit(keycode, dev->keybit);
+		if (!tps_get_key_by_keycode(old_keycode))
+			clear_bit(old_keycode, dev->keybit);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int acpi_topstar_init_hkey(struct topstar_hkey *hkey)
+{
+	struct tps_key_entry *key;
+
+	hkey->inputdev = input_allocate_device();
+	if (!hkey->inputdev) {
+		printk(TOPSTAR_ACPI_ERR "Unable to allocate input device\n");
+		return -ENODEV;
+	}
+	hkey->inputdev->name = "Topstar Laptop extra buttons";
+	hkey->inputdev->phys = "topstar/input0";
+	hkey->inputdev->id.bustype = BUS_HOST;
+	hkey->inputdev->getkeycode = topstar_getkeycode;
+	hkey->inputdev->setkeycode = topstar_setkeycode;
+	for (key = topstar_keymap; key->code; key++) {
+		set_bit(EV_KEY, hkey->inputdev->evbit);
+		set_bit(key->keycode, hkey->inputdev->keybit);
+	}
+	if (input_register_device(hkey->inputdev)) {
+		printk(TOPSTAR_ACPI_ERR "Unable to register input device\n");
+		input_free_device(hkey->inputdev);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int acpi_topstar_add(struct acpi_device *device)
+{
+	acpi_status status;
+	struct topstar_hkey *tps_hkey;
+
+	if (!device)
+		return -EINVAL;
+
+	tps_hkey = kzalloc(sizeof(struct topstar_hkey), GFP_KERNEL);
+	if (!tps_hkey)
+		return -ENOMEM;
+
+	sprintf(acpi_device_name(device), "%s", ACPI_TOPSTAR_DEVICE_NAME);
+	sprintf(acpi_device_class(device), "%s", ACPI_TOPSTAR_CLASS);
+
+	if (acpi_topstar_fncx_switch(device, true))
+		goto add_err;
+
+	device->driver_data = tps_hkey;
+
+	if (acpi_topstar_init_hkey(tps_hkey))
+		goto add_err;
+
+	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+					     acpi_topstar_notify, tps_hkey);
+	if (ACPI_FAILURE(status))
+		goto add_err;
+
+	return 0;
+
+add_err:
+	kfree(tps_hkey);
+	device->driver_data = NULL;
+	return -ENODEV;
+}
+
+static int acpi_topstar_remove(struct acpi_device *device, int type)
+{
+	struct topstar_hkey *tps_hkey = acpi_driver_data(device);
+
+	if (!device || !tps_hkey)
+		return -EINVAL;
+
+	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+				   acpi_topstar_notify);
+
+	acpi_topstar_fncx_switch(device, false);
+
+	input_unregister_device(tps_hkey->inputdev);
+	kfree(tps_hkey);
+	device->driver_data = NULL;
+
+	return 0;
+}
+
+static struct acpi_driver acpi_topstar_driver = {
+	.name = ACPI_TOPSTAR_DRIVER_NAME,
+	.class = ACPI_TOPSTAR_CLASS,
+	.ids = topstar_device_ids,
+	.ops = {
+		.add = acpi_topstar_add,
+		.remove = acpi_topstar_remove,
+	},
+};
+
+static int __init acpi_topstar_init(void)
+{
+	if (acpi_disabled)
+		return -ENODEV;
+
+	if (acpi_bus_register_driver(&acpi_topstar_driver) < 0)
+		return -ENODEV;
+
+	printk(KERN_INFO "Topstar Laptop ACPI extras driver loaded\n");
+
+	return 0;
+}
+
+static void __exit acpi_topstar_exit(void)
+{
+	acpi_bus_unregister_driver(&acpi_topstar_driver);
+
+	printk(KERN_INFO "Topstar Laptop ACPI extras driver unloaded\n");
+}
+
+module_init(acpi_topstar_init);
+module_exit(acpi_topstar_exit);
+
+MODULE_AUTHOR("Herton Ronaldo Krzesinski");
+MODULE_DESCRIPTION("Topstar Laptop ACPI Extras driver");
+MODULE_LICENSE("GPL");
-- 
1.6.4.2


--Boundary-00=_TdfoKHR6ts35Tk8
Content-Type: application/x-gzip;
  name="topstarn01.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="topstarn01.gz"

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
AQA=

--Boundary-00=_TdfoKHR6ts35Tk8--
