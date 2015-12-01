From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 3/3] dell-wmi: Improve unknown hotkey handling
Date: Mon, 30 Nov 2015 17:02:01 -0800
Message-ID: <b409d60963f81611e398b492a73ffd998414cd68.1448931589.git.luto@kernel.org>
References: <cover.1448931589.git.luto@kernel.org>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <cover.1448931589.git.luto@kernel.org>
In-Reply-To: <cover.1448931589.git.luto@kernel.org>
References: <cover.1448931589.git.luto@kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-acpi@vger.kernel.org

If DMI lists a hotkey that we don't recognize, log and ignore it
instead of trying to map it to keycode 0.  I haven't seen this happen,
but it will help maintain the key map in the future and it will help
avoid sending bogus events.

This also improves the message that we log when we get an unknown key
event.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/platform/x86/dell-wmi.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index baff658a3621..7c3ebda811ca 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -118,6 +118,7 @@ struct dell_bios_hotkey_table {
 
 static const struct dell_bios_hotkey_table *dell_bios_hotkey_table;
 
+/* Uninitialized entries here are KEY_RESERVED == 0. */
 static const u16 bios_to_linux_keycode[256] __initconst = {
 	[0]	= KEY_MEDIA,
 	[1]	= KEY_NEXTSONG,
@@ -191,7 +192,8 @@ static void dell_wmi_process_key(int reported_key)
 	key = sparse_keymap_entry_from_scancode(dell_wmi_input_dev,
 						reported_key);
 	if (!key) {
-		pr_info("Unknown key %x pressed\n", reported_key);
+		pr_info("Unknown key with scancode 0x%x pressed\n",
+			reported_key);
 		return;
 	}
 
@@ -350,9 +352,24 @@ static const struct key_entry * __init dell_wmi_prepare_new_keymap(void)
 	for (i = 0; i < hotkey_num; i++) {
 		const struct dell_bios_keymap_entry *bios_entry =
 					&dell_bios_hotkey_table->keymap[i];
-		u16 keycode = bios_entry->keycode < 256 ?
-				    bios_to_linux_keycode[bios_entry->keycode] :
-				    KEY_RESERVED;
+
+		/* Uninitialized entries are 0 aka KEY_RESERVED. */
+		u16 keycode = (bios_entry->keycode <
+			       ARRAY_SIZE(bios_to_linux_keycode)) ?
+			bios_to_linux_keycode[bios_entry->keycode] :
+			KEY_RESERVED;
+		BUILD_BUG_ON(KEY_RESERVED != 0);
+
+		/*
+		 * Log if we find an entry in the DMI table that we don't
+		 * understand.  If this happens, we should figure out what
+		 * the entry means and add it to bios_to_linux_keycode.
+		 */
+		if (keycode == KEY_RESERVED) {
+			pr_info("firmware scancode 0x%x maps to unrecognized keycode 0x%x\n",
+				bios_entry->scancode, bios_entry->keycode);
+			continue;
+		}
 
 		if (keycode == KEY_KBDILLUMTOGGLE)
 			keymap[pos].type = KE_IGNORE;
-- 
2.5.0
