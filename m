From: Corentin CHARY <corentincj@iksaif.net>
Subject: [Patch] A6J support in asus_acpi
Date: Sun, 12 Nov 2006 14:31:42 +0100
Message-ID: <200611121431.42421.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:6806 "EHLO iksaif.net")
	by vger.kernel.org with ESMTP id S1755118AbWKLNbk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Nov 2006 08:31:40 -0500
Received: from [192.168.0.2] (ALyon-151-1-74-131.w83-201.abo.wanadoo.fr [83.201.77.131])
	by iksaif.net (Postfix) with ESMTP id AC9251A2548
	for <linux-acpi@vger.kernel.org>; Sun, 12 Nov 2006 14:35:34 +0100 (CET)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

A6J have LCD, CRT, TV-Out AND DVI ... So /proc/acpi/asus/disp work like=
 this :

=A0 +-------+-----+-----+-----+-----+-----+
=A0 | Bin =A0 | Val | DVI | TV =A0| CRT | LCD |
=A0 +-------+-----+-----+-----+-----+-----+
=A0 + 0000 =A0+ =A0 0 + =A0 =A0 + =A0 =A0 + =A0 =A0 + =A0 =A0 +
=A0 +-------+-----+-----+-----+-----+-----+
=A0 + 0001 =A0+ =A0 1 + =A0 =A0 + =A0 =A0 + =A0 =A0 + =A0X =A0+
=A0 +-------+-----+-----+-----+-----+-----+
=A0 + 0010 =A0+ =A0 2 + =A0 =A0 + =A0 =A0 + =A0X =A0+ =A0 =A0 +
=A0 +-------+-----+-----+-----+-----+-----+
=A0 + 0011 =A0+ =A0 3 + =A0 =A0 + =A0 =A0 + =A0X =A0+ =A0X =A0+
=A0 +-------+-----+-----+-----+-----+-----+
=A0 + 0100 =A0+ =A0 4 + =A0 =A0 + =A0X =A0+ =A0 =A0 + =A0 =A0 +
=A0 +-------+-----+-----+-----+-----+-----+
=A0 + 0101 =A0+ =A0 5 + =A0 =A0 + =A0X =A0+ =A0 =A0 + X =A0 +
=A0 +-------+-----+-----+-----+-----+-----+
=A0 + 0110 =A0+ =A0 6 + =A0 =A0 + =A0X =A0+ =A0X =A0+ =A0 =A0 +
=A0 +-------+-----+-----+-----+-----+-----+
=A0 + 0111 =A0+ =A0 7 + =A0 =A0 + =A0X =A0+ =A0X =A0+ =A0X =A0+
=A0 +-------+-----+-----+-----+-----+-----+
=A0 + 1000 =A0+ =A0 8 + =A0X =A0+ =A0 =A0 + =A0 =A0 + =A0 =A0 +
=A0 +-------+-----+-----+-----+-----+-----+
=A0 + 1001 =A0+ =A0 9 + =A0X =A0+ =A0 =A0 + =A0 =A0 + =A0X =A0+
=A0 +-------+-----+-----+-----+-----+-----+
=A0 + 1010 =A0+ =A010 + =A0X =A0+ =A0 =A0 + =A0X =A0+ =A0 =A0 +
=A0 +-------+-----+-----+-----+-----+-----+
=A0 + 1011 =A0+ =A011 + =A0X =A0+ =A0 =A0 + =A0X =A0+ =A0X =A0+
=A0 +-------+-----+-----+-----+-----+-----+
=A0 + 1100 =A0+ =A012 + =A0X =A0+ =A0X =A0+ =A0 =A0 + =A0 =A0 +
=A0 +-------+-----+-----+-----+-----+-----+
=A0 + 1101 =A0+ =A013 + =A0X =A0+ =A0X =A0+ =A0 =A0 + =A0X =A0+
=A0 +-------+-----+-----+-----+-----+-----+
=A0 + 1110 =A0+ =A014 + =A0X =A0+ =A0X =A0+ =A0X =A0+ =A0 =A0 +
=A0 +-------+-----+-----+-----+-----+-----+
=A0 + 1111 =A0+ =A015 + =A0X =A0+ =A0X =A0+ =A0X =A0+ =A0X =A0+
=A0 +-------+-----+-----+-----+-----+-----+


it should be the same with all ASUS with DVI. I will see this week, a f=
riend have another ASUS with DVI ...

--- linux-2.6.19-rc5/drivers/acpi/asus_acpi.c =A0 2006-11-08 03:24:20.0=
00000000 +0100
+++ linux-2.6.19-rc5-ik/drivers/acpi/asus_acpi.c =A0 =A0 =A0 =A02006-11=
-12 12:03:04.000000000 +0100
@@ -121,6 +121,7 @@
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 A1x =3D 0, =A0 =A0 =A0 =A0//A1340D, A13=
00F
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 A2x, =A0 =A0 =A0 =A0 =A0 =A0//A2500H
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 A4G, =A0 =A0 =A0 =A0 =A0 =A0//A4700G
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 A6J, =A0 =A0 =A0 =A0 =A0 =A0//A6J
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 D1x, =A0 =A0 =A0 =A0 =A0 =A0//D1
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 L2D, =A0 =A0 =A0 =A0 =A0 =A0//L2000D
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 L3C, =A0 =A0 =A0 =A0 =A0 =A0//L3800C
@@ -193,6 +194,18 @@
=A0 =A0 =A0 =A0 =A0.display_get =3D "\\ADVG"},

=A0 =A0 =A0 =A0 {
+ =A0 =A0 =A0 =A0.name =3D "A6J",
+ =A0 =A0 =A0 =A0.mt_mled =3D "MLED",
+ =A0 =A0 =A0 =A0.mt_wled =3D "WLED",
+ =A0 =A0 =A0 =A0.mt_bt_switch =3D "BLED",
+ =A0 =A0 =A0 =A0.mt_lcd_switch =3D xxN_PREFIX "_Q10",
+ =A0 =A0 =A0 =A0.lcd_status =3D "\\GPL0",
+ =A0 =A0 =A0 =A0.brightness_set =3D "SPLV",
+ =A0 =A0 =A0 =A0.brightness_get =3D "GPLV",
+ =A0 =A0 =A0 =A0.display_set =3D "SDSP",
+ =A0 =A0 =A0 =A0.display_get =3D "\\SETD"},
+
+ =A0 =A0 =A0 {
=A0 =A0 =A0 =A0 =A0.name =3D "D1x",
=A0 =A0 =A0 =A0 =A0.mt_mled =3D "MLED",
=A0 =A0 =A0 =A0 =A0.mt_lcd_switch =3D "\\Q0D",
@@ -700,6 +713,8 @@

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hotk->model =3D=3D L2D)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd =3D ~lcd;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (hotk->model =3D=3D A6J)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd =3D lcd >> 6;
=A0 =A0 =A0 =A0 } else { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* L3H and the =
like have to be handled differently */
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_status status =3D 0;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct acpi_object_list input;
@@ -873,14 +888,19 @@
=A0 =A0 =A0 =A0 if (!read_acpi_int(hotk->handle, hotk->methods->display=
_get, &value))
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Asus ACPI: Error readin=
g display status\n");
- =A0 =A0 =A0 value &=3D 0x07; =A0 =A0 =A0 =A0 =A0/* needed for some mo=
dels, shouldn't hurt others */
+
+ =A0 =A0 =A0 if(hotk->model =3D=3D A6J)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 value &=3D 0x0F; =A0 =A0 =A0 =A0 =A0/* A6=
J use 4bit, last for DVI */
+ =A0 =A0 =A0 else
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 value &=3D 0x07; =A0 =A0 =A0 =A0 =A0/* ne=
eded for some models, shouldn't hurt others */
+
=A0 =A0 =A0 =A0 return sprintf(page, "%d\n", value);
=A0}

=A0/*
=A0 * Experimental support for display switching. As of now: 1 should a=
ctivate
- * the LCD output, 2 should do for CRT, and 4 for TV-Out. Any combinat=
ion
- * (bitwise) of these will suffice. I never actually tested 3 displays=
 hooked up
+ * the LCD output, 2 should do for CRT, 4 for TV-Out and 8 for DVI. An=
y combination
+ * (bitwise) of these will suffice. I never actually tested 4 displays=
 hooked up
=A0 * simultaneously, so be warned. See the acpi4asus README for more i=
nfo.
=A0 */
=A0static int
@@ -1099,6 +1119,8 @@
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return L5x;
=A0 =A0 =A0 =A0 else if (strncmp(model, "A4G", 3) =3D=3D 0)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return A4G;
+ =A0 =A0 =A0 else if (strncmp(model, "A6J", 3) =3D=3D 0)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return A6J;
=A0 =A0 =A0 =A0 else if (strncmp(model, "W1N", 3) =3D=3D 0)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return W1N;
=A0 =A0 =A0 =A0 else if (strncmp(model, "W3V", 3) =3D=3D 0)
--=20
CHARY 'Iksaif' Corentin
corentincj@iksaif.net - corentincj@yahoo.fr
http://xf.iksaif.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
