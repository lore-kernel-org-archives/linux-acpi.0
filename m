From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 1/3] dell-wmi: Use a C99-style array for bios_to_linux_keycode
Date: Mon, 30 Nov 2015 17:01:59 -0800
Message-ID: <c30cf7923f0059d21ba3d8a63b7eb47fe7e475a4.1448931589.git.luto@kernel.org>
References: <cover.1448931589.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46282 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124AbbLABCL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Nov 2015 20:02:11 -0500
In-Reply-To: <cover.1448931589.git.luto@kernel.org>
In-Reply-To: <cover.1448931589.git.luto@kernel.org>
References: <cover.1448931589.git.luto@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>

It's currently hard to follow what maps to what, and it's hard to edit
the array.  Redo it as a C99-style array.

I generated this using emacs regexes and a python one-liner.
objdump says this didn't change the table.

Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/platform/x86/dell-wmi.c | 61 +++++++++++++++++++++++++++------=
--------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/del=
l-wmi.c
index f2d77fe696ac..ad6e965c5862 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -119,27 +119,46 @@ struct dell_bios_hotkey_table {
 static const struct dell_bios_hotkey_table *dell_bios_hotkey_table;
=20
 static const u16 bios_to_linux_keycode[256] __initconst =3D {
-
-	KEY_MEDIA,	KEY_NEXTSONG,	KEY_PLAYPAUSE, KEY_PREVIOUSSONG,
-	KEY_STOPCD,	KEY_UNKNOWN,	KEY_UNKNOWN,	KEY_UNKNOWN,
-	KEY_WWW,	KEY_UNKNOWN,	KEY_VOLUMEDOWN, KEY_MUTE,
-	KEY_VOLUMEUP,	KEY_UNKNOWN,	KEY_BATTERY,	KEY_EJECTCD,
-	KEY_UNKNOWN,	KEY_SLEEP,	KEY_PROG1, KEY_BRIGHTNESSDOWN,
-	KEY_BRIGHTNESSUP,	KEY_UNKNOWN,	KEY_KBDILLUMTOGGLE,
-	KEY_UNKNOWN,	KEY_SWITCHVIDEOMODE,	KEY_UNKNOWN, KEY_UNKNOWN,
-	KEY_SWITCHVIDEOMODE,	KEY_UNKNOWN,	KEY_UNKNOWN, KEY_PROG2,
-	KEY_UNKNOWN,	KEY_UNKNOWN,	KEY_UNKNOWN,	KEY_UNKNOWN,
-	KEY_UNKNOWN,	KEY_UNKNOWN,	KEY_UNKNOWN,	KEY_MICMUTE,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, KEY_PROG3
+	[0]	=3D KEY_MEDIA,
+	[1]	=3D KEY_NEXTSONG,
+	[2]	=3D KEY_PLAYPAUSE,
+	[3]	=3D KEY_PREVIOUSSONG,
+	[4]	=3D KEY_STOPCD,
+	[5]	=3D KEY_UNKNOWN,
+	[6]	=3D KEY_UNKNOWN,
+	[7]	=3D KEY_UNKNOWN,
+	[8]	=3D KEY_WWW,
+	[9]	=3D KEY_UNKNOWN,
+	[10]	=3D KEY_VOLUMEDOWN,
+	[11]	=3D KEY_MUTE,
+	[12]	=3D KEY_VOLUMEUP,
+	[13]	=3D KEY_UNKNOWN,
+	[14]	=3D KEY_BATTERY,
+	[15]	=3D KEY_EJECTCD,
+	[16]	=3D KEY_UNKNOWN,
+	[17]	=3D KEY_SLEEP,
+	[18]	=3D KEY_PROG1,
+	[19]	=3D KEY_BRIGHTNESSDOWN,
+	[20]	=3D KEY_BRIGHTNESSUP,
+	[21]	=3D KEY_UNKNOWN,
+	[22]	=3D KEY_KBDILLUMTOGGLE,
+	[23]	=3D KEY_UNKNOWN,
+	[24]	=3D KEY_SWITCHVIDEOMODE,
+	[25]	=3D KEY_UNKNOWN,
+	[26]	=3D KEY_UNKNOWN,
+	[27]	=3D KEY_SWITCHVIDEOMODE,
+	[28]	=3D KEY_UNKNOWN,
+	[29]	=3D KEY_UNKNOWN,
+	[30]	=3D KEY_PROG2,
+	[31]	=3D KEY_UNKNOWN,
+	[32]	=3D KEY_UNKNOWN,
+	[33]	=3D KEY_UNKNOWN,
+	[34]	=3D KEY_UNKNOWN,
+	[35]	=3D KEY_UNKNOWN,
+	[36]	=3D KEY_UNKNOWN,
+	[37]	=3D KEY_UNKNOWN,
+	[38]	=3D KEY_MICMUTE,
+	[255]	=3D KEY_PROG3,
 };
=20
 static struct input_dev *dell_wmi_input_dev;
--=20
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
