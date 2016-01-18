From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3] dell-wmi: Support new hotkeys on the XPS 13 9350 (Skylake)
Date: Mon, 18 Jan 2016 13:14:58 -0800
Message-ID: <54397d72fbadcc340ca3ef1339c1a62fe0a07ab8.1453151401.git.luto@kernel.org>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: Mario Limonciello <mario_limonciello@dell.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Jon Eyolfson <jon@eyl.io>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-acpi@vger.kernel.org

The XPS 13 9350 sends WMI keypress events that aren't enumerated in
the DMI table.  Add a table listing them.  To avoid breaking things
that worked before, these un-enumerated hotkeys won't be used if the
DMI table maps them to something else.

FWIW, it appears that the DMI table may be a legacy thing and we
might want to rethink how we handle events in general.  As an
example, a whole lot of things map to KEY_PROG3 via the DMI table.

So far, this doesn't send keypress events for any of the new
events.  Depnding on whether we figure out exactly what needs to
happen to get the wireless button working in time for Linux 4.5,
we might want to temporarily handle it in dell-wmi.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---

This applies after the dmi-walk fix.

Notes:
    Changes from v2:
     - Factor check for already-known scancodes into a helper.
     - Un-abbreviate comments.
     - Fix off-by-one.
     - Rebase on top of of dmi_walk fixes.
    
    Changes from v1:
     - The new hotkey code matches reality better.
     - Don't send key events for the new hotkeys.

 drivers/platform/x86/dell-wmi.c | 71 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 48838942d593..c8e8a2b08f6b 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -162,6 +162,30 @@ static const u16 bios_to_linux_keycode[256] __initconst = {
 	[255]	= KEY_PROG3,
 };
 
+/*
+ * These are applied if the 0xB2 DMI hotkey table is present and doesn't
+ * override them.
+ */
+static const struct key_entry dell_wmi_extra_keymap[] __initconst = {
+	/* Fn-lock */
+	{ KE_IGNORE, 0x151, { KEY_RESERVED } },
+
+	/* Change keyboard illumination */
+	{ KE_IGNORE, 0x152, { KEY_KBDILLUMTOGGLE } },
+
+	/*
+	 * Radio disable (notify only -- there is no model for which the
+	 * WMI event is supposed to trigger an action).
+	 */
+	{ KE_IGNORE, 0x153, { KEY_RFKILL } },
+
+	/* RGB keyboard backlight control */
+	{ KE_IGNORE, 0x154, { KEY_RESERVED } },
+
+	/* Stealth mode toggle */
+	{ KE_IGNORE, 0x155, { KEY_RESERVED } },
+};
+
 static struct input_dev *dell_wmi_input_dev;
 
 static void dell_wmi_process_key(int reported_key)
@@ -317,13 +341,27 @@ static void dell_wmi_notify(u32 value, void *context)
 	kfree(obj);
 }
 
+static bool have_scancode(u32 scancode, const struct key_entry *keymap, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		if (keymap[i].code == scancode)
+			return true;
+
+	return false;
+}
+
 static void __init handle_dmi_entry(const struct dmi_header *dm,
+
 				    void *opaque)
+
 {
 	struct dell_dmi_results *results = opaque;
 	struct dell_bios_hotkey_table *table;
+	int hotkey_num, i, pos = 0;
 	struct key_entry *keymap;
-	int hotkey_num, i;
+	int num_bios_keys;
 
 	if (results->err || results->keymap)
 		return;		/* We already found the hotkey table. */
@@ -338,7 +376,8 @@ static void __init handle_dmi_entry(const struct dmi_header *dm,
 		      sizeof(struct dell_bios_hotkey_table)) /
 				sizeof(struct dell_bios_keymap_entry);
 
-	keymap = kcalloc(hotkey_num + 1, sizeof(struct key_entry), GFP_KERNEL);
+	keymap = kcalloc(hotkey_num + ARRAY_SIZE(dell_wmi_extra_keymap) + 1,
+			 sizeof(struct key_entry), GFP_KERNEL);
 	if (!keymap) {
 		results->err = -ENOMEM;
 		return;
@@ -366,14 +405,32 @@ static void __init handle_dmi_entry(const struct dmi_header *dm,
 		}
 
 		if (keycode == KEY_KBDILLUMTOGGLE)
-			keymap[i].type = KE_IGNORE;
+			keymap[pos].type = KE_IGNORE;
 		else
-			keymap[i].type = KE_KEY;
-		keymap[i].code = bios_entry->scancode;
-		keymap[i].keycode = keycode;
+			keymap[pos].type = KE_KEY;
+		keymap[pos].code = bios_entry->scancode;
+		keymap[pos].keycode = keycode;
+
+		pos++;
+	}
+
+	num_bios_keys = pos;
+
+	for (i = 0; i < ARRAY_SIZE(dell_wmi_extra_keymap); i++) {
+		const struct key_entry *entry = &dell_wmi_extra_keymap[i];
+
+		/*
+		 * Check if we've already found this scancode.  This takes
+		 * quadratic time, but it doesn't matter unless the list
+		 * of extra keys gets very long.
+		 */
+		if (!have_scancode(entry->code, keymap, num_bios_keys)) {
+			keymap[pos] = *entry;
+			pos++;
+		}
 	}
 
-	keymap[hotkey_num].type = KE_END;
+	keymap[pos].type = KE_END;
 
 	results->keymap = keymap;
 }
-- 
2.5.0
