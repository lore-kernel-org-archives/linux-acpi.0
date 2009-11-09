From: Andrew Lutomirski <luto@mit.edu>
Subject: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Mon, 9 Nov 2009 11:47:30 -0500
Message-ID: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:38340 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbZKIQrZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2009 11:47:25 -0500
Received: by bwz27 with SMTP id 27so3655848bwz.21
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2009 08:47:30 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

The ThinkPad X200s, like the X61, requires OSI=Linux for the mute
button to work.  Without this patch (or the equivalent command-line
parameter), the mute button does not generate a keystroke and,
instead, messes up the sound hardware.

Tested on an X200s.

Signed-off-by: Andy Lutomirski <luto@mit.edu>

---

This is probably 2.6.33 material.

The X200 and X200T probably have the same problem.  Can someone test
them and submit similar patches?

Oddly enough, Windows has the same problem as Linux, where the mute
button does bad things until you install a special driver.

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index e56b2a7..ea9f88b 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -224,6 +224,7 @@ static struct dmi_system_id acpi_osi_dmi_table[]
__initdata = {
 	 * _OSI(Linux) helps sound
 	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R61"),
 	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
+	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X200s"),
 	 * _OSI(Linux) has Linux specific hooks
 	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X61"),
 	 * _OSI(Linux) is a NOP:
@@ -254,6 +255,14 @@ static struct dmi_system_id acpi_osi_dmi_table[]
__initdata = {
 		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X61"),
 		},
 	},
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo X200s",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X200s"),
+		},
+	},
 	{}
 };
