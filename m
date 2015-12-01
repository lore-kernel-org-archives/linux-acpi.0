From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 2/3] dell-wmi: Support new hotkeys on the XPS 13 9350 (Skylake)
Date: Mon, 30 Nov 2015 17:02:00 -0800
Message-ID: <d9ff5adc7e496b7714202785f8279af313bbcc59.1448931589.git.luto@kernel.org>
References: <cover.1448931589.git.luto@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46303 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964AbbLABCN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Nov 2015 20:02:13 -0500
In-Reply-To: <cover.1448931589.git.luto@kernel.org>
In-Reply-To: <cover.1448931589.git.luto@kernel.org>
References: <cover.1448931589.git.luto@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>

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
 drivers/platform/x86/dell-wmi.c | 59 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index ad6e965c5862..baff658a3621 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -161,6 +161,27 @@ static const u16 bios_to_linux_keycode[256] __initconst = {
 	[255]	= KEY_PROG3,
 };
 
+/* These are applied if the hk table is present and doesn't override them. */
+static const struct key_entry dell_wmi_extra_keymap[] __initconst = {
+	/* Fn-lock */
+	{ KE_IGNORE, 0x151, { KEY_RESERVED } },
+
+	/* Change keyboard illumination */
+	{ KE_IGNORE, 0x152, { KEY_KBDILLUMTOGGLE } },
+
+	/*
+	 * Radio disable (notify only -- there is no model for which the
+	 * WMI event is supposed to trigger an action.
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
@@ -319,9 +340,10 @@ static const struct key_entry * __init dell_wmi_prepare_new_keymap(void)
 	int hotkey_num = (dell_bios_hotkey_table->header.length - 4) /
 				sizeof(struct dell_bios_keymap_entry);
 	struct key_entry *keymap;
-	int i;
+	int i, pos = 0, num_bios_keys;
 
-	keymap = kcalloc(hotkey_num + 1, sizeof(struct key_entry), GFP_KERNEL);
+	keymap = kcalloc(hotkey_num + ARRAY_SIZE(dell_wmi_extra_keymap),
+			 sizeof(struct key_entry), GFP_KERNEL);
 	if (!keymap)
 		return NULL;
 
@@ -333,14 +355,37 @@ static const struct key_entry * __init dell_wmi_prepare_new_keymap(void)
 				    KEY_RESERVED;
 
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
+		int j;
+
+		/*
+		 * Check if we've already found this scancode.  This takes
+		 * quadratic time, but it doesn't matter unless the list
+		 * of extra keys gets very long.
+		 */
+		for (j = 0; j < num_bios_keys; j++)
+			if (keymap[j].code == dell_wmi_extra_keymap[i].code)
+				goto skip;
+
+		keymap[pos] = dell_wmi_extra_keymap[i];
+		pos++;
+
+skip:
+		;
 	}
 
-	keymap[hotkey_num].type = KE_END;
+	keymap[pos].type = KE_END;
 
 	return keymap;
 }
-- 
2.5.0

