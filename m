From: Len Brown <lenb@kernel.org>
Subject: [PATCH 032/112] ACPI: thinkpad-acpi: document keymap gotcha's (v2)
Date: Thu,  7 Feb 2008 04:33:54 -0500
Message-ID: <0f089147e620e083f58a0e641f701bd4244b455b.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:20777 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753445AbYBGJf7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:59 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Publish the requirements for keymap changes.  This is a documentation
change, only.

Currently, people look at the thinkpad-acpi default keymaps, and think:
"modifying this is a trivial thing, it can't break systems, and there are
keys defined for foo and bar, but the driver has them as KEY_RESERVED.
Must have been an oversight, let me change it."

And since they never get to see the bug reports, because they are not
really a part of the Linux ThinkPad users community (linux-thinkpad
mailinglist, thinkwiki wiki, thinkpad forums) and laptop users are slow
to complain to distros about any breakages...

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   68 ++++++++++++++++++++++++++++++++++++++---
 1 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index cf56647..7b1080f 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -954,26 +954,67 @@ static struct attribute *hotkey_mask_attributes[] __initdata = {
 
 static int __init hotkey_init(struct ibm_init_struct *iibm)
 {
-
+	/* Requirements for changing the default keymaps:
+	 *
+	 * 1. Many of the keys are mapped to KEY_RESERVED for very
+	 *    good reasons.  Do not change them unless you have deep
+	 *    knowledge on the IBM and Lenovo ThinkPad firmware for
+	 *    the various ThinkPad models.  The driver behaves
+	 *    differently for KEY_RESERVED: such keys have their
+	 *    hot key mask *unset* in mask_recommended, and also
+	 *    in the initial hot key mask programmed into the
+	 *    firmware at driver load time, which means the firm-
+	 *    ware may react very differently if you change them to
+	 *    something else;
+	 *
+	 * 2. You must be subscribed to the linux-thinkpad and
+	 *    ibm-acpi-devel mailing lists, and you should read the
+	 *    list archives since 2007 if you want to change the
+	 *    keymaps.  This requirement exists so that you will
+	 *    know the past history of problems with the thinkpad-
+	 *    acpi driver keymaps, and also that you will be
+	 *    listening to any bug reports;
+	 *
+	 * 3. Do not send thinkpad-acpi specific patches directly to
+	 *    for merging, *ever*.  Send them to the linux-acpi
+	 *    mailinglist for comments.  Merging is to be done only
+	 *    through acpi-test and the ACPI maintainer.
+	 *
+	 * If the above is too much to ask, don't change the keymap.
+	 * Ask the thinkpad-acpi maintainer to do it, instead.
+	 */
 	static u16 ibm_keycode_map[] __initdata = {
 		/* Scan Codes 0x00 to 0x0B: ACPI HKEY FN+F1..F12 */
 		KEY_FN_F1,	KEY_FN_F2,	KEY_COFFEE,	KEY_SLEEP,
 		KEY_WLAN,	KEY_FN_F6, KEY_SWITCHVIDEOMODE, KEY_FN_F8,
 		KEY_FN_F9,	KEY_FN_F10,	KEY_FN_F11,	KEY_SUSPEND,
-		/* Scan codes 0x0C to 0x0F: Other ACPI HKEY hot keys */
+
+		/* Scan codes 0x0C to 0x1F: Other ACPI HKEY hot keys */
 		KEY_UNKNOWN,	/* 0x0C: FN+BACKSPACE */
 		KEY_UNKNOWN,	/* 0x0D: FN+INSERT */
 		KEY_UNKNOWN,	/* 0x0E: FN+DELETE */
+
+		/* brightness: firmware always reacts to them, unless
+		 * X.org did some tricks in the radeon BIOS scratch
+		 * registers of *some* models */
 		KEY_RESERVED,	/* 0x0F: FN+HOME (brightness up) */
-		/* Scan codes 0x10 to 0x1F: Extended ACPI HKEY hot keys */
 		KEY_RESERVED,	/* 0x10: FN+END (brightness down) */
+
+		/* Thinklight: firmware always react to it */
 		KEY_RESERVED,	/* 0x11: FN+PGUP (thinklight toggle) */
+
 		KEY_UNKNOWN,	/* 0x12: FN+PGDOWN */
 		KEY_ZOOM,	/* 0x13: FN+SPACE (zoom) */
+
+		/* Volume: firmware always react to it and reprograms
+		 * the built-in *extra* mixer.  Never map it to control
+		 * another mixer by default. */
 		KEY_RESERVED,	/* 0x14: VOLUME UP */
 		KEY_RESERVED,	/* 0x15: VOLUME DOWN */
 		KEY_RESERVED,	/* 0x16: MUTE */
+
 		KEY_VENDOR,	/* 0x17: Thinkpad/AccessIBM/Lenovo */
+
 		/* (assignments unknown, please report if found) */
 		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
 		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
@@ -983,20 +1024,37 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		KEY_FN_F1,	KEY_COFFEE,	KEY_BATTERY,	KEY_SLEEP,
 		KEY_WLAN,	KEY_FN_F6, KEY_SWITCHVIDEOMODE, KEY_FN_F8,
 		KEY_FN_F9,	KEY_FN_F10,	KEY_FN_F11,	KEY_SUSPEND,
-		/* Scan codes 0x0C to 0x0F: Other ACPI HKEY hot keys */
+
+		/* Scan codes 0x0C to 0x1F: Other ACPI HKEY hot keys */
 		KEY_UNKNOWN,	/* 0x0C: FN+BACKSPACE */
 		KEY_UNKNOWN,	/* 0x0D: FN+INSERT */
 		KEY_UNKNOWN,	/* 0x0E: FN+DELETE */
+
 		KEY_RESERVED,	/* 0x0F: FN+HOME (brightness up) */
-		/* Scan codes 0x10 to 0x1F: Extended ACPI HKEY hot keys */
 		KEY_RESERVED,	/* 0x10: FN+END (brightness down) */
+
 		KEY_RESERVED,	/* 0x11: FN+PGUP (thinklight toggle) */
+
 		KEY_UNKNOWN,	/* 0x12: FN+PGDOWN */
 		KEY_ZOOM,	/* 0x13: FN+SPACE (zoom) */
+
+		/* Volume: z60/z61, T60 (BIOS version?): firmware always
+		 * react to it and reprograms the built-in *extra* mixer.
+		 * Never map it to control another mixer by default.
+		 *
+		 * T60?, T61, R60?, R61: firmware and EC tries to send
+		 * these over the regular keyboard, so these are no-ops,
+		 * but there are still weird bugs re. MUTE, so do not
+		 * change unless you get test reports from all Lenovo
+		 * models.  May cause the BIOS to interfere with the
+		 * HDA mixer.
+		 */
 		KEY_RESERVED,	/* 0x14: VOLUME UP */
 		KEY_RESERVED,	/* 0x15: VOLUME DOWN */
 		KEY_RESERVED,	/* 0x16: MUTE */
+
 		KEY_VENDOR,	/* 0x17: Thinkpad/AccessIBM/Lenovo */
+
 		/* (assignments unknown, please report if found) */
 		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
 		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
-- 
1.5.4.23.gef5b9

