From: Bastien Nocera <hadess@hadess.net>
Subject: More X1 Carbon (2nd gen) adaptive keyboard support
Date: Tue, 13 Jan 2015 14:54:19 +0100
Message-ID: <1421157259.2542.13.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35025 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbbAMNzK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Jan 2015 08:55:10 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Hey,

I'm currently working on adding support for the extra "adaptive" keys
for the X1 Carbon 2014 (2nd gen).

Below is the (non-working) patch to add support for some of those keys.
I'm working with Benjamin Tissoires to add the necessary, missing, Linu=
x
keycodes.

A couple of questions though:
- Should I expand the main "hotkey" keymap? I don't really understand
that code (and don't really want to read the archives since 2007 ;)
- A couple of keys don't go through the same "hotkey" interface:
  - show all applications
  - show overview/expos=C3=A9
  - search
  - webcam on/off
  - wireless on/off

Any ideas how those could be exported? Any specific data you would need
(de-compiled DSDT?)? Debug I can turn on?

Some interesting kernel messages:

--8<--
[13747.860235] thinkpad_acpi_adaptive: ThinkPad BIOS GRET42WW (1.19 ), =
EC unknown
[13747.860236] thinkpad_acpi_adaptive: Lenovo ThinkPad X1 Carbon 2nd, m=
odel 20A7002WUS
[13747.860865] thinkpad_acpi_adaptive: tpacpi_acpi_handle_locate: Found=
 ACPI handle for video
[13747.861114] thinkpad_acpi_adaptive: Unsupported brightness interface=
, please contact ibm-acpi-devel@lists.sourceforge.net

[13747.861127] thinkpad_acpi_adaptive: drv_acpi_handle_init: Found ACPI=
 handle HKEY for hkey
[13747.861141] thinkpad_acpi_adaptive: unknown version of the HKEY inte=
rface: 0x200
[13747.861142] thinkpad_acpi_adaptive: please report this to ibm-acpi-d=
evel@lists.sourceforge.net
--8<--

Patch below,

Cheers

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x8=
6/thinkpad_acpi.c
index 721905b..ebf2fb2 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3526,6 +3526,31 @@ const int adaptive_keyboard_modes[] =3D {
=20
 #define DFR_CHANGE_ROW			0x101
 #define DFR_SHOW_QUICKVIEW_ROW		0x102
+#define FIRST_ADAPTIVE_KEY		0x105
+
+/* The first item in this list is the Clipping tool button
+ * which is emitted with 0x105 through
+ * adaptive_keyboard_hotkey_notify_hotkey ()*/
+static int adaptive_keycodes[] =3D {
+	KEY_RESERVED, /* Clipping tool, 0x105 */
+	KEY_RESERVED, /* Cloud */
+	KEY_RESERVED,
+	KEY_RESERVED, /* Voice */
+	KEY_RESERVED,
+	KEY_RESERVED, /* Gestures */
+	KEY_RESERVED,
+	KEY_RESERVED,
+	KEY_RESERVED,
+	KEY_RESERVED, /* Settings */
+	KEY_RESERVED, /* New tab */
+	KEY_REFRESH,  /* Reload */
+	KEY_BACK,     /* Back */
+	KEY_RESERVED, /* Microphone down */
+	KEY_RESERVED, /* Microphone up */
+	KEY_RESERVED, /* Microphone cancellation */
+	KEY_RESERVED, /* Camera mode */
+	KEY_RESERVED, /* Rotate display, 0x116 */
+};
=20
 /* press Fn key a while second, it will switch to Function Mode. Then
  * release Fn key, previous mode be restored.
@@ -3583,6 +3608,7 @@ static bool adaptive_keyboard_hotkey_notify_hotke=
y(unsigned int scancode)
 {
 	u32 current_mode =3D 0;
 	int new_mode =3D 0;
+	int keycode;
=20
 	switch (scancode) {
 	case DFR_CHANGE_ROW:
@@ -3615,7 +3641,26 @@ static bool adaptive_keyboard_hotkey_notify_hotk=
ey(unsigned int scancode)
 		return true;
=20
 	default:
-		return false;
+		if (scancode < FIRST_ADAPTIVE_KEY ||
+			scancode > FIRST_ADAPTIVE_KEY +
+				ARRAY_SIZE(adaptive_keycodes)) {
+			pr_info("Unhandled adaptive keyboard key: 0x%x\n",
+					scancode);
+			return false;
+		}
+		keycode =3D adaptive_keycodes[scancode - FIRST_ADAPTIVE_KEY];
+		if (keycode !=3D KEY_RESERVED) {
+			mutex_lock(&tpacpi_inputdev_send_mutex);
+
+			input_report_key(tpacpi_inputdev, keycode, 1);
+			input_sync(tpacpi_inputdev);
+
+			input_report_key(tpacpi_inputdev, keycode, 0);
+			input_sync(tpacpi_inputdev);
+
+			mutex_unlock(&tpacpi_inputdev_send_mutex);
+		}
+		return true;
 	}
 }
=20
@@ -3628,6 +3673,8 @@ static bool hotkey_notify_hotkey(const u32 hkey,
 	*send_acpi_ev =3D true;
 	*ignore_acpi_ev =3D false;
=20
+	pr_err ("hotkey_notify_hotkey: 0x%x\n", hkey);
+
 	/* HKEY event 0x1001 is scancode 0x00 */
 	if (scancode > 0 && scancode <=3D TPACPI_HOTKEY_MAP_LEN) {
 		scancode--;
@@ -3639,6 +3686,7 @@ static bool hotkey_notify_hotkey(const u32 hkey,
 		}
 		return true;
 	} else {
+		pr_err ("scancode: 0x%x\n", scancode);
 		return adaptive_keyboard_hotkey_notify_hotkey(scancode);
 	}
 	return false;

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
