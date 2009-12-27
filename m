From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/2] dell-wmi - switch to using sparse keymap library
Date: Sun, 27 Dec 2009 01:49:59 -0800
Message-ID: <20091227094754.14542.22118.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:36783 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbZL0JuE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Dec 2009 04:50:04 -0500
Received: by pzk1 with SMTP id 1so2364334pzk.33
        for <linux-acpi@vger.kernel.org>; Sun, 27 Dec 2009 01:50:03 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

Compile-tested only due to the lack of hardware; beware.

 drivers/platform/x86/Kconfig    |    1 
 drivers/platform/x86/dell-wmi.c |  256 +++++++++++++++------------------------
 2 files changed, 100 insertions(+), 157 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 7ddf286..c483cb4 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -89,6 +89,7 @@ config DELL_WMI
 	tristate "Dell WMI extras"
 	depends on ACPI_WMI
 	depends on INPUT
+	select INPUT_SPARSEKMAP
 	---help---
 	  Say Y here if you want to support WMI-based hotkeys on Dell laptops.
 
diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index c980782..e0a0716 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
 #include <acpi/acpi_drivers.h>
 #include <linux/acpi.h>
 #include <linux/string.h>
@@ -43,78 +44,70 @@ static int acpi_video;
 
 MODULE_ALIAS("wmi:"DELL_EVENT_GUID);
 
-struct key_entry {
-	char type;		/* See KE_* below */
-	u16 code;
-	u16 keycode;
-};
-
-enum { KE_KEY, KE_SW, KE_IGNORE, KE_END };
-
 /*
  * Certain keys are flagged as KE_IGNORE. All of these are either
  * notifications (rather than requests for change) or are also sent
  * via the keyboard controller so should not be sent again.
  */
 
-static struct key_entry dell_legacy_wmi_keymap[] = {
-	{KE_KEY, 0xe045, KEY_PROG1},
-	{KE_KEY, 0xe009, KEY_EJECTCD},
+static const struct key_entry dell_wmi_legacy_keymap[] __initconst = {
+	{ KE_KEY, 0xe045, { KEY_PROG1 } },
+	{ KE_KEY, 0xe009, { KEY_EJECTCD } },
 
 	/* These also contain the brightness level at offset 6 */
-	{KE_KEY, 0xe006, KEY_BRIGHTNESSUP},
-	{KE_KEY, 0xe005, KEY_BRIGHTNESSDOWN},
+	{ KE_KEY, 0xe006, { KEY_BRIGHTNESSUP } },
+	{ KE_KEY, 0xe005, { KEY_BRIGHTNESSDOWN } },
 
 	/* Battery health status button */
-	{KE_KEY, 0xe007, KEY_BATTERY},
+	{ KE_KEY, 0xe007, { KEY_BATTERY } },
 
 	/* This is actually for all radios. Although physically a
 	 * switch, the notification does not provide an indication of
 	 * state and so it should be reported as a key */
-	{KE_KEY, 0xe008, KEY_WLAN},
+	{ KE_KEY, 0xe008, { KEY_WLAN } },
 
 	/* The next device is at offset 6, the active devices are at
 	   offset 8 and the attached devices at offset 10 */
-	{KE_KEY, 0xe00b, KEY_SWITCHVIDEOMODE},
+	{ KE_KEY, 0xe00b, { KEY_SWITCHVIDEOMODE } },
 
-	{KE_IGNORE, 0xe00c, KEY_KBDILLUMTOGGLE},
+	{ KE_IGNORE, 0xe00c, {KEY_KBDILLUMTOGGLE } },
 
 	/* BIOS error detected */
-	{KE_IGNORE, 0xe00d, KEY_RESERVED},
+	{ KE_IGNORE, 0xe00d, { KEY_RESERVED } },
 
 	/* Wifi Catcher */
-	{KE_KEY, 0xe011, KEY_PROG2},
+	{ KE_KEY, 0xe011, {KEY_PROG2 } },
 
 	/* Ambient light sensor toggle */
-	{KE_IGNORE, 0xe013, KEY_RESERVED},
-
-	{KE_IGNORE, 0xe020, KEY_MUTE},
-	{KE_IGNORE, 0xe02e, KEY_VOLUMEDOWN},
-	{KE_IGNORE, 0xe030, KEY_VOLUMEUP},
-	{KE_IGNORE, 0xe033, KEY_KBDILLUMUP},
-	{KE_IGNORE, 0xe034, KEY_KBDILLUMDOWN},
-	{KE_IGNORE, 0xe03a, KEY_CAPSLOCK},
-	{KE_IGNORE, 0xe045, KEY_NUMLOCK},
-	{KE_IGNORE, 0xe046, KEY_SCROLLLOCK},
-	{KE_END, 0}
+	{ KE_IGNORE, 0xe013, { KEY_RESERVED } },
+
+	{ KE_IGNORE, 0xe020, { KEY_MUTE } },
+	{ KE_IGNORE, 0xe02e, { KEY_VOLUMEDOWN } },
+	{ KE_IGNORE, 0xe030, { KEY_VOLUMEUP } },
+	{ KE_IGNORE, 0xe033, { KEY_KBDILLUMUP } },
+	{ KE_IGNORE, 0xe034, { KEY_KBDILLUMDOWN } },
+	{ KE_IGNORE, 0xe03a, { KEY_CAPSLOCK } },
+	{ KE_IGNORE, 0xe045, { KEY_NUMLOCK } },
+	{ KE_IGNORE, 0xe046, { KEY_SCROLLLOCK } },
+	{ KE_END, 0}
 };
 
 static bool dell_new_hk_type;
 
-struct dell_new_keymap_entry {
+struct dell_bios_keymap_entry {
 	u16 scancode;
 	u16 keycode;
 };
 
-struct dell_hotkey_table {
+struct dell_bios_hotkey_table {
 	struct dmi_header header;
-	struct dell_new_keymap_entry keymap[];
+	struct dell_bios_keymap_entry keymap[];
 
 };
 
-static struct key_entry *dell_new_wmi_keymap;
+static const struct dell_bios_hotkey_table *dell_bios_hotkey_table;
 
-static u16 bios_to_linux_keycode[256] = {
+static const u16 bios_to_linux_keycode[256] __initconst = {
 
 	KEY_MEDIA,	KEY_NEXTSONG,	KEY_PLAYPAUSE, KEY_PREVIOUSSONG,
 	KEY_STOPCD,	KEY_UNKNOWN,	KEY_UNKNOWN,	KEY_UNKNOWN,
@@ -137,70 +130,11 @@ static u16 bios_to_linux_keycode[256] = {
 	KEY_PROG3
 };
 
-
-static struct key_entry *dell_wmi_keymap = dell_legacy_wmi_keymap;
-
 static struct input_dev *dell_wmi_input_dev;
 
-static struct key_entry *dell_wmi_get_entry_by_scancode(int code)
-{
-	struct key_entry *key;
-
-	for (key = dell_wmi_keymap; key->type != KE_END; key++)
-		if (code == key->code)
-			return key;
-
-	return NULL;
-}
-
-static struct key_entry *dell_wmi_get_entry_by_keycode(int keycode)
-{
-	struct key_entry *key;
-
-	for (key = dell_wmi_keymap; key->type != KE_END; key++)
-		if (key->type == KE_KEY && keycode == key->keycode)
-			return key;
-
-	return NULL;
-}
-
-static int dell_wmi_getkeycode(struct input_dev *dev, int scancode,
-			       int *keycode)
-{
-	struct key_entry *key = dell_wmi_get_entry_by_scancode(scancode);
-
-	if (key && key->type == KE_KEY) {
-		*keycode = key->keycode;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static int dell_wmi_setkeycode(struct input_dev *dev, int scancode, int keycode)
-{
-	struct key_entry *key;
-	int old_keycode;
-
-	if (keycode < 0 || keycode > KEY_MAX)
-		return -EINVAL;
-
-	key = dell_wmi_get_entry_by_scancode(scancode);
-	if (key && key->type == KE_KEY) {
-		old_keycode = key->keycode;
-		key->keycode = keycode;
-		set_bit(keycode, dev->keybit);
-		if (!dell_wmi_get_entry_by_keycode(old_keycode))
-			clear_bit(old_keycode, dev->keybit);
-		return 0;
-	}
-	return -EINVAL;
-}
-
 static void dell_wmi_notify(u32 value, void *context)
 {
 	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
-	static struct key_entry *key;
 	union acpi_object *obj;
 
 	wmi_get_event_data(value, &response);
@@ -208,11 +142,14 @@ static void dell_wmi_notify(u32 value, void *context)
 	obj = (union acpi_object *)response.pointer;
 
 	if (obj && obj->type == ACPI_TYPE_BUFFER) {
+		const struct key_entry *key;
 		int reported_key;
 		u16 *buffer_entry = (u16 *)obj->buffer.pointer;
-		if (dell_new_hk_type && (buffer_entry[1] != 0x10)) {
-			printk(KERN_INFO "dell-wmi: Received unknown WMI event"
-					 " (0x%x)\n", buffer_entry[1]);
+
+		if (dell_new_hk_type && buffer_entry[1] != 0x10) {
+			printk(KERN_INFO
+				"dell-wmi: Received unknown WMI event (0x%x)\n",
+				buffer_entry[1]);
 			return;
 		}
 
@@ -221,8 +158,8 @@ static void dell_wmi_notify(u32 value, void *context)
 		else
 			reported_key = (int)buffer_entry[1] & 0xffff;
 
-		key = dell_wmi_get_entry_by_scancode(reported_key);
-
+		key = sparse_keymap_entry_from_scancode(dell_wmi_input_dev,
+							reported_key);
 		if (!key) {
 			printk(KERN_INFO "dell-wmi: Unknown key %x pressed\n",
 				reported_key);
@@ -232,92 +169,98 @@ static void dell_wmi_notify(u32 value, void *context)
 			 * come via ACPI */
 			return;
 		} else {
-			input_report_key(dell_wmi_input_dev, key->keycode, 1);
-			input_sync(dell_wmi_input_dev);
-			input_report_key(dell_wmi_input_dev, key->keycode, 0);
-			input_sync(dell_wmi_input_dev);
+			sparse_keymap_report_entry(dell_wmi_input_dev, key,
+						   1, true);
 		}
 	}
 	kfree(obj);
 }
 
-
-static void setup_new_hk_map(const struct dmi_header *dm)
+static const struct key_entry *dell_wmi_prepare_new_keymap(void)
 {
-
+	int hotkey_num = (dell_bios_hotkey_table->header.length - 4) /
+			 sizeof(struct dell_bios_keymap_entry);
+	struct key_entry *keymap;
 	int i;
-	int hotkey_num = (dm->length-4)/sizeof(struct dell_new_keymap_entry);
-	struct dell_hotkey_table *table =
-		container_of(dm, struct dell_hotkey_table, header);
 
-	dell_new_wmi_keymap = kzalloc((hotkey_num+1) *
-				      sizeof(struct key_entry), GFP_KERNEL);
+	keymap = kcalloc(hotkey_num + 1, sizeof(struct key_entry), GFP_KERNEL);
+	if (!keymap)
+		return NULL;
 
 	for (i = 0; i < hotkey_num; i++) {
-		dell_new_wmi_keymap[i].type = KE_KEY;
-		dell_new_wmi_keymap[i].code = table->keymap[i].scancode;
-		dell_new_wmi_keymap[i].keycode =
-			(table->keymap[i].keycode > 255) ? 0 :
-			bios_to_linux_keycode[table->keymap[i].keycode];
+		const struct dell_bios_keymap_entry *bios_entry =
+					&dell_bios_hotkey_table->keymap[i];
+		keymap[i].type = KE_KEY;
+		keymap[i].code = bios_entry->scancode;
+		keymap[i].keycode = bios_entry->keycode < 256 ?
+				    bios_to_linux_keycode[bios_entry->keycode] :
+				    KEY_RESERVED;
 	}
 
-	dell_new_wmi_keymap[i].type = KE_END;
-	dell_new_wmi_keymap[i].code = 0;
-	dell_new_wmi_keymap[i].keycode = 0;
-
-	dell_wmi_keymap = dell_new_wmi_keymap;
-
-}
-
-
-static void find_hk_type(const struct dmi_header *dm, void *dummy)
-{
-
-	if ((dm->type == 0xb2) && (dm->length > 6)) {
-		dell_new_hk_type = true;
-		setup_new_hk_map(dm);
-	}
+	keymap[hotkey_num].type = KE_END;
 
+	return keymap;
 }
 
-
 static int __init dell_wmi_input_setup(void)
 {
-	struct key_entry *key;
 	int err;
 
 	dell_wmi_input_dev = input_allocate_device();
-
 	if (!dell_wmi_input_dev)
 		return -ENOMEM;
 
 	dell_wmi_input_dev->name = "Dell WMI hotkeys";
 	dell_wmi_input_dev->phys = "wmi/input0";
 	dell_wmi_input_dev->id.bustype = BUS_HOST;
-	dell_wmi_input_dev->getkeycode = dell_wmi_getkeycode;
-	dell_wmi_input_dev->setkeycode = dell_wmi_setkeycode;
-
-	for (key = dell_wmi_keymap; key->type != KE_END; key++) {
-		switch (key->type) {
-		case KE_KEY:
-			set_bit(EV_KEY, dell_wmi_input_dev->evbit);
-			set_bit(key->keycode, dell_wmi_input_dev->keybit);
-			break;
-		case KE_SW:
-			set_bit(EV_SW, dell_wmi_input_dev->evbit);
-			set_bit(key->keycode, dell_wmi_input_dev->swbit);
-			break;
+
+	if (dell_new_hk_type) {
+		const struct key_entry *keymap = dell_wmi_prepare_new_keymap();
+		if (!keymap) {
+			err = -ENOMEM;
+			goto err_free_dev;
 		}
-	}
 
-	err = input_register_device(dell_wmi_input_dev);
+		err = sparse_keymap_setup(dell_wmi_input_dev, keymap, NULL);
 
-	if (err) {
-		input_free_device(dell_wmi_input_dev);
-		return err;
+		/*
+		 * Sparse keymap library makes a copy of keymap so we
+		 * don't need the original one that was allocated.
+		 */
+		kfree(keymap);
+	} else {
+		err = sparse_keymap_setup(dell_wmi_input_dev,
+					  dell_wmi_legacy_keymap, NULL);
 	}
+	if (err)
+		goto err_free_dev;
+
+	err = input_register_device(dell_wmi_input_dev);
+	if (err)
+		goto err_free_keymap;
 
 	return 0;
+
+ err_free_keymap:
+	sparse_keymap_free(dell_wmi_input_dev);
+ err_free_dev:
+	input_free_device(dell_wmi_input_dev);
+	return err;
+}
+
+static void dell_wmi_input_destroy(void)
+{
+	sparse_keymap_free(dell_wmi_input_dev);
+	input_unregister_device(dell_wmi_input_dev);
+}
+
+static void __init find_hk_type(const struct dmi_header *dm, void *dummy)
+{
+	if (dm->type == 0xb2 && dm->length > 6) {
+		dell_new_hk_type = true;
+		dell_bios_hotkey_table =
+			container_of(dm, struct dell_bios_hotkey_table, header);
+	}
 }
 
 static int __init dell_wmi_init(void)
@@ -339,7 +282,7 @@ static int __init dell_wmi_init(void)
 	err = wmi_install_notify_handler(DELL_EVENT_GUID,
 					 dell_wmi_notify, NULL);
 	if (err) {
-		input_unregister_device(dell_wmi_input_dev);
+		dell_wmi_input_destroy();
 		printk(KERN_ERR
 			"dell-wmi: Unable to register notify handler - %d\n",
 			err);
@@ -348,12 +291,11 @@ static int __init dell_wmi_init(void)
 
 	return 0;
 }
+module_init(dell_wmi_init);
 
 static void __exit dell_wmi_exit(void)
 {
 	wmi_remove_notify_handler(DELL_EVENT_GUID);
-	input_unregister_device(dell_wmi_input_dev);
+	dell_wmi_input_destroy();
 }
-
-module_init(dell_wmi_init);
 module_exit(dell_wmi_exit);

