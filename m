From: Gustavo Maciel Dias Vieira <gustavo@sagui.org>
Subject: [PATCH] ACPI video: ignore BIOS backlight value for HP dm4
Date: Mon, 04 Mar 2013 12:23:37 -0300
Message-ID: <1362410617.2761.30.camel@oberon.sagui.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from horatio.sagui.org ([173.230.138.212]:55940 "EHLO
	horatio.sagui.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758165Ab3CDPbQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Mar 2013 10:31:16 -0500
Received: from oberon.sagui.org (gw.sor.ufscar.br [200.133.238.2])
	by horatio.sagui.org (Postfix) with ESMTPSA id 32551839
	for <linux-acpi@vger.kernel.org>; Mon,  4 Mar 2013 12:41:00 -0300 (BRT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>


On a HP Pavilion dm4 laptop the BIOS sets minimum backlight on boot,
completely dimming the screen. Ignore this initial value for this
machine.

Signed-off-by: Gustavo Maciel Dias Vieira <gustavo@sagui.org>
---

This is the same situation as with the HP Folio
(http://www.spinics.net/lists/linux-acpi/msg40401.html).

Without this patch, the only way to get a correct display is with the
video.use_bios_initial_backlight=3D0 command line switch. With it the
display works out of the box.

Abra=C3=A7os,
Gustavo


 drivers/acpi/video.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index ac9a69c..d7329bc 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -447,6 +447,14 @@ static struct dmi_system_id video_dmi_table[] __in=
itdata =3D {
 		DMI_MATCH(DMI_PRODUCT_NAME, "HP Folio 13 - 2000 Notebook PC"),
 		},
 	},
+	{
+	 .callback =3D video_ignore_initial_backlight,
+	 .ident =3D "HP Pavilion dm4",
+	 .matches =3D {
+		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dm4 Notebook PC"),
+		},
+	},
 	{}
 };
=20
--=20
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
