From: Rezwanul Kabir <Rezwanul_Kabir@dell.com>
Subject: [PATCH resend] dell-wmi: Add support for new Dell WMI based HotKey
Date: Mon, 24 Aug 2009 16:34:06 -0500
Message-ID: <1251149646-13654-1-git-send-email-Rezwanul_Kabir@dell.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:31641 "EHLO
	ausc60pc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbZHXVeL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2009 17:34:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Rezwanul_Kabir@dell.com

Newer Dell systems support HotKey features differently from legacy systems.
A new vendor specifc HotKey SMBIOS table (Type 0xB2) is defined. This
table contains a mapping between scancode and the corresponding predefined
keyfunction ( i.e. keycode).. Also, a new ACPI-WMI event type (called 
KeyIDList) with a value of 0x0010 is defined. Any BIOS containing 0xB2 
table will send hotkey notifications using KeyIDList event.


Signed-off-by: Rezwanul Kabir <Rezwanul_Kabir@dell.com>
---

diff -urNp a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
--- a/drivers/platform/x86/dell-wmi.c	2009-08-11 11:49:26.000000000 -0500
+++ b/drivers/platform/x86/dell-wmi.c	2009-08-18 12:20:10.000000000 -0500
@@ -31,6 +31,7 @@
 #include <acpi/acpi_drivers.h>
 #include <linux/acpi.h>
 #include <linux/string.h>
+#include <linux/dmi.h>
 
 MODULE_AUTHOR("Matthew Garrett <mjg@redhat.com>");
 MODULE_DESCRIPTION("Dell laptop WMI hotkeys driver");
@@ -54,7 +55,7 @@ enum { KE_KEY, KE_SW, KE_IGNORE, KE_END 
  * via the keyboard controller so should not be sent again.
  */
 
-static struct key_entry dell_wmi_keymap[] = {
+static struct key_entry dell_legacy_wmi_keymap[] = {
 	{KE_KEY, 0xe045, KEY_PROG1},
 	{KE_KEY, 0xe009, KEY_EJECTCD},
 
@@ -96,6 +97,47 @@ static struct key_entry dell_wmi_keymap[
 	{KE_END, 0}
 };
 
+static bool dell_new_hk_type = false;
+
+struct dell_new_keymap_entry {
+	u16 scancode;
+	u16 keycode;
+};
+
+struct dell_hotkey_table {
+	struct dmi_header header;
+	struct dell_new_keymap_entry keymap[];
+
+};
+
+static struct key_entry *dell_new_wmi_keymap;
+
+static u16 bios_to_linux_keycode[256] = {
+
+	KEY_MEDIA,	KEY_NEXTSONG,	KEY_PLAYPAUSE,	KEY_PREVIOUSSONG,
+	KEY_STOPCD,	KEY_UNKNOWN,	KEY_UNKNOWN,	KEY_UNKNOWN,
+	KEY_WWW,	KEY_UNKNOWN,	KEY_VOLUMEDOWN, KEY_MUTE,
+	KEY_VOLUMEUP,	KEY_UNKNOWN,	KEY_BATTERY,	KEY_EJECTCD,
+	KEY_UNKNOWN,	KEY_SLEEP,	KEY_PROG1,	KEY_BRIGHTNESSDOWN,
+	KEY_BRIGHTNESSUP,	KEY_UNKNOWN,	KEY_KBDILLUMTOGGLE,
+	KEY_UNKNOWN,	KEY_VIDEO_NEXT,	KEY_UNKNOWN, KEY_UNKNOWN,
+	KEY_DISPLAYTOGGLE,	KEY_UNKNOWN,	KEY_UNKNOWN,	KEY_PROG2,
+	KEY_UNKNOWN, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	KEY_PROG3
+};
+
+
+static struct key_entry *dell_wmi_keymap = dell_legacy_wmi_keymap;
+
 static struct input_dev *dell_wmi_input_dev;
 
 static struct key_entry *dell_wmi_get_entry_by_scancode(int code)
@@ -133,6 +175,7 @@ static int dell_wmi_getkeycode(struct in
 	return -EINVAL;
 }
 
+
 static int dell_wmi_setkeycode(struct input_dev *dev, int scancode, int keycode)
 {
 	struct key_entry *key;
@@ -164,24 +207,65 @@ static void dell_wmi_notify(u32 value, v
 	obj = (union acpi_object *)response.pointer;
 
 	if (obj && obj->type == ACPI_TYPE_BUFFER) {
-		int *buffer = (int *)obj->buffer.pointer;
-		/*
-		 *  The upper bytes of the event may contain
-		 *  additional information, so mask them off for the
-		 *  scancode lookup
-		 */
-		key = dell_wmi_get_entry_by_scancode(buffer[1] & 0xFFFF);
+		u16 *buffer_entry = (u16 *)obj->buffer.pointer;
+		if (dell_new_hk_type && (buffer_entry[1] != 0x10)) {
+			printk(KERN_INFO "dell-wmi: Received unknown WMI event"
+					 " (0x%x)\n", buffer_entry[1]);
+			return 0;
+		}
+		key = dell_wmi_get_entry_by_scancode((int)buffer_entry[2]);
 		if (key) {
 			input_report_key(dell_wmi_input_dev, key->keycode, 1);
 			input_sync(dell_wmi_input_dev);
 			input_report_key(dell_wmi_input_dev, key->keycode, 0);
 			input_sync(dell_wmi_input_dev);
-		} else if (buffer[1] & 0xFFFF)
+		} else
 			printk(KERN_INFO "dell-wmi: Unknown key %x pressed\n",
-			       buffer[1] & 0xFFFF);
+				buffer_entry[2]);
+
 	}
 }
 
+
+static void setup_new_hk_map(const struct dmi_header *dm)
+{
+
+	int i;
+	int hotkey_num = (dm->length-4)/sizeof(struct dell_new_keymap_entry);
+	struct dell_hotkey_table *table =
+		container_of(dm, struct dell_hotkey_table, header);
+
+	dell_new_wmi_keymap = kzalloc((hotkey_num+1) *
+				      sizeof(struct key_entry), GFP_KERNEL);
+
+	for (i = 0; i < hotkey_num; i++) {
+		dell_new_wmi_keymap[i].type = KE_KEY;
+		dell_new_wmi_keymap[i].code = table->keymap[i].scancode;
+		dell_new_wmi_keymap[i].keycode =
+			(table->keymap[i].keycode > 255) ? 0 :
+				bios_to_linux_keycode[table->keymap[i].keycode];
+	}
+
+	dell_new_wmi_keymap[i].type = KE_END;
+	dell_new_wmi_keymap[i].code = 0;
+	dell_new_wmi_keymap[i].keycode = 0;
+
+	dell_wmi_keymap = dell_new_wmi_keymap;
+
+}
+
+
+static void find_hk_type(const struct dmi_header *dm, void *dummy)
+{
+
+	if ((dm->type == 0xb2) && (dm->length > 6)) {
+		dell_new_hk_type = true;
+		setup_new_hk_map(dm);
+	}
+
+}
+
+
 static int __init dell_wmi_input_setup(void)
 {
 	struct key_entry *key;
@@ -226,6 +310,9 @@ static int __init dell_wmi_init(void)
 	int err;
 
 	if (wmi_has_guid(DELL_EVENT_GUID)) {
+
+		dmi_walk(find_hk_type, NULL);
+
 		err = dell_wmi_input_setup();
 
 		if (err)
