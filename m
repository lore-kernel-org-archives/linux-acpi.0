From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: Fwd: [PATCH] Add support for ASUS A6VA, M6V, W5F, V6V laptops in asus-acpi.
Date: Tue, 5 Dec 2006 08:42:29 +0100
Message-ID: <200612050842.29739.corentincj@iksaif.net>
References: <660ce7740612041336r30c33e42n29e7cfedb8558371@mail.gmail.com> <660ce7740612041339n5f1cc682v34e0a22e7944f764@mail.gmail.com>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lLSdFzAWUpL/W9x"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:41792 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967583AbWLEHmk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Dec 2006 02:42:40 -0500
Received: from [192.168.0.2] (ALyon-151-1-108-169.w86-209.abo.wanadoo.fr [86.209.99.169])
	by iksaif.net (Postfix) with ESMTP id 065BF1D8902
	for <linux-acpi@vger.kernel.org>; Tue,  5 Dec 2006 08:42:31 +0100 (CET)
In-Reply-To: <660ce7740612041339n5f1cc682v34e0a22e7944f764@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--Boundary-00=_lLSdFzAWUpL/W9x
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le lundi 4 d=E9cembre 2006 22:39, Panagiotis Papadakos a =E9crit=A0:
> Hello everybody.
>
> This patch is based on
> http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg02277.html
> and adds support for ASUS A6VA, M6V, W5F and V6V laptops in asus-acpi.
> Also some trailing spaces cleanups.
>
> Regards
> Papadakos Panagiotis

You should take a look at acpi4asus cvs=20
http://acpi4asus.sourceforge.net
There is a lot of new models supported, /sys/class/backlight support, fix t=
he=20
bad defaults values problems, a lot of cleanups, light sens support, etc ...
Patch against 2.6.19 attached.

=2D-=20
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

--Boundary-00=_lLSdFzAWUpL/W9x
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="asus4acpi-0.31b2-2.6.19.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="asus4acpi-0.31b2-2.6.19.patch"

=2D-- /usr/src/linux/drivers/acpi/asus_acpi.c	2006-12-02 11:50:05.000000000=
 +0100
+++ acpi4asus/driver/asus_acpi.c	2006-12-05 08:25:06.000000000 +0100
@@ -3,6 +3,7 @@
  *
  *
  *  Copyright (C) 2002-2005 Julien Lerouge, 2003-2006 Karol Kozimor
+ *  Copyright (C) 2006 Corentin Chary
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -26,20 +27,37 @@
  *  Pontus Fuchs   - Helper functions, cleanup
  *  Johann Wiesner - Small compile fixes
  *  John Belmonte  - ACPI code for Toshiba laptop was a good starting poin=
t.
=2D *  =C9ric Burghard  - LED display support for W1N
=2D *
+ *  Eric Burghard  - LED display support for W1N
+ *  Josh Green     - Light Sens support
+ *  Brice Arnould  - Some help for parse_method()
  */
=20
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE <=3D KERNEL_VERSION(2,6,18)
+# include <linux/config.h>
+#else
+# include <linux/autoconf.h>
+#endif
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/platform_device.h>
 #include <linux/types.h>
+#include <linux/err.h>
 #include <linux/proc_fs.h>
+#include <linux/backlight.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
=20
=2D#define ASUS_ACPI_VERSION "0.30"
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
+# define CONFIG_ACPI_ASUS_NEW_BACKLIGHT
+#endif
+
+
+#define ASUS_ACPI_VERSION "0.31b2"
=20
 #define PROC_ASUS       "asus"	//the directory
 #define PROC_MLED       "mled"
@@ -51,6 +69,8 @@
 #define PROC_LCD        "lcd"
 #define PROC_BRN        "brn"
 #define PROC_DISP       "disp"
+#define PROC_LSSW       "lssw"
+#define PROC_LSLVL      "lslvl"
=20
 #define ACPI_HOTK_NAME          "Asus Laptop ACPI Extras Driver"
 #define ACPI_HOTK_CLASS         "hotkey"
@@ -71,39 +91,53 @@
 #define TLED_ON     0x04	//touchpad LED
 #define BT_ON       0x08	//internal Bluetooth
=20
=2DMODULE_AUTHOR("Julien Lerouge, Karol Kozimor");
+/*
+ * Methods configuration
+ */
+#define MT_MAX_ARGS 3
+
+MODULE_AUTHOR("Julien Lerouge, Karol Kozimor, Corentin Chary");
 MODULE_DESCRIPTION(ACPI_HOTK_NAME);
 MODULE_LICENSE("GPL");
=20
=2Dstatic uid_t asus_uid;
=2Dstatic gid_t asus_gid;
=2Dmodule_param(asus_uid, uint, 0);
=2DMODULE_PARM_DESC(asus_uid, "UID for entries in /proc/acpi/asus.\n");
=2Dmodule_param(asus_gid, uint, 0);
=2DMODULE_PARM_DESC(asus_gid, "GID for entries in /proc/acpi/asus.\n");
+static uint unsupported;
+module_param(unsupported, uint, 0);
+MODULE_PARM_DESC(unsupported, "Allow the use of default values for an unsu=
pported model.\n");
+
=20
=2D/* For each model, all features implemented,=20
=2D * those marked with R are relative to HOTK, A for absolute */
+/* For each model, all features implemented,
+ * those marked with R are relative to HOTK, A for absolute.
+ */
 struct model_data {
 	char *name;		//name of the laptop________________A
=2D	char *mt_mled;		//method to handle mled_____________R
+	char *mled_set;		//method to handle mled_____________R
 	char *mled_status;	//node to handle mled reading_______A
=2D	char *mt_wled;		//method to handle wled_____________R
+	char *wled_set;		//method to handle wled_____________R
 	char *wled_status;	//node to handle wled reading_______A
=2D	char *mt_tled;		//method to handle tled_____________R
+	char *tled_set;		//method to handle tled_____________R
 	char *tled_status;	//node to handle tled reading_______A
=2D	char *mt_ledd;		//method to handle LED display______R
=2D	char *mt_bt_switch;	//method to switch Bluetooth on/off_R
=2D	char *bt_status;	//no model currently supports this__?
=2D	char *mt_lcd_switch;	//method to turn LCD on/off_________A
+	char *ledd_set;		//method to handle LED display______R
+	char *bt_switch;	//method to switch Bluetooth on/off_R
+	char *bt_status;	//method to read Bluetooth stat_____A
+	char *lcd_switch;	//method to turn LCD on/off_________A
 	char *lcd_status;	//node to read LCD panel state______A
 	char *brightness_up;	//method to set brightness up_______A
 	char *brightness_down;	//guess what ?______________________A
 	char *brightness_set;	//method to set absolute brightness_R
 	char *brightness_get;	//method to get absolute brightness_R
=2D	char *brightness_status;	//node to get brightness____________A
+	char *brightness_status; //node to get brightness____________A
+	char *light_sens_switch; //light sensor toggle method________R
+	char *light_sens_level; //light sensor level set method_____R
 	char *display_set;	//method to set video output________R
 	char *display_get;	//method to get video output________R
+
+};
+
+/* A method have a name, and from 0 to MT_MAX_ARGS params ... */
+struct method {
+	const char * name;
+	struct acpi_object_list input;
+	union acpi_object params[MT_MAX_ARGS];
 };
=20
 /*
@@ -117,30 +151,53 @@
 	u32 ledd_status;	//status of the LED display
 	struct model_data *methods;	//methods available on the laptop
 	u8 brightness;		//brightness level
+	u8 lcd_status;      // status of the lcd
+	u8 disp_status;     // guess what ?
+	u8 light_level;    //light sensor level
+	u8 light_switch;    //light sensor switch value
 	enum {
 		A1x =3D 0,	//A1340D, A1300F
+		A2D,            //A2D
 		A2x,		//A2500H
+		A3E,            //A3E
+		A3F,            //A3F, A6F
+		A3N,            //A3N, A3L
 		A4G,		//A4700G
+		A6B,            //A6B, A6K
+		A6J,            //A6J
+		A6R,            //A6R
+		A6T,            //A6T, A6M
+		A6V,            //A6V, A6Q
+		A8J,            //A8J
 		D1x,		//D1
+		F3J,            //F3JM
 		L2D,		//L2000D
 		L3C,		//L3800C
 		L3D,		//L3400D
 		L3H,		//L3H, L2000E, L5D
 		L4R,		//L4500R
=2D		L5x,		//L5800C=20
+		L5x,		//L5800C
 		L8L,		//L8400L
 		M1A,		//M1300A
 		M2E,		//M2400E, L4400L
 		M6N,		//M6800N, W3400N
 		M6R,		//M6700R, A3000G
+		M6V,            //M6A, M6V-B022P, M6V-8012P
+		M7A,            //Z71A
+		M7V,            //Z71V
 		P30,		//Samsung P30
 		S1x,		//S1300A, but also L1400B and M2400A (L84F)
 		S2x,		//S200 (J1 reported), Victor MP-XP7210
+		V6J,            //V6J
+		V6V,            //V6V
 		W1N,		//W1000N
=2D		W5A,		//W5A
 		W3V,            //W3030V
+		W5A,		//W5A
+		W5F,            //W5F
 		xxN,		//M2400N, M3700N, M5200N, M6800N, S1300N, S5200N
+		Z96,            //Z96F
 		//(Centrino)
+		DEF,            //Default values
 		END_MODEL
 	} model;		//Models currently supported
 	u16 event_count[128];	//count for each event TODO make this better
@@ -154,6 +211,7 @@
 #define S1x_PREFIX "\\_SB.PCI0.PX40."
 #define S2x_PREFIX A1x_PREFIX
 #define xxN_PREFIX "\\_SB.PCI0.SBRG.EC0."
+#define A6x_PREFIX xxN_PREFIX
=20
 static struct model_data model_conf[END_MODEL] =3D {
 	/*
@@ -163,39 +221,166 @@
=20
 	{
 	 .name =3D "A1x",
=2D	 .mt_mled =3D "MLED",
+	 .mled_set =3D "MLED",
 	 .mled_status =3D "\\MAIL",
=2D	 .mt_lcd_switch =3D A1x_PREFIX "_Q10",
+	 .lcd_switch =3D A1x_PREFIX "_Q10",
 	 .lcd_status =3D "\\BKLI",
 	 .brightness_up =3D A1x_PREFIX "_Q0E",
 	 .brightness_down =3D A1x_PREFIX "_Q0F"},
=20
 	{
+	 .name =3D "A2D",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
+	 .lcd_status =3D "\\_SB.PCI0.SBRG.GO18",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .display_set =3D "SDSP",
+	 .display_get =3D "\\ACTD"},
+
+	{
 	 .name =3D "A2x",
=2D	 .mt_mled =3D "MLED",
=2D	 .mt_wled =3D "WLED",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
 	 .wled_status =3D "\\SG66",
=2D	 .mt_lcd_switch =3D "\\Q10",
+	 .lcd_switch =3D "\\Q10",
 	 .lcd_status =3D "\\BAOF",
 	 .brightness_set =3D "SPLV",
 	 .brightness_get =3D "GPLV",
 	 .display_set =3D "SDSP",
=2D	 .display_get =3D "\\INFB"},
+ 	 .display_get =3D "\\INFB"},
+
+	{
+	 .name =3D "A3E",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
+	 .lcd_status =3D xxN_PREFIX "RPIN(0x67)",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .display_set =3D "SDSP",
+	 .display_get =3D "\\_SB.PCI0.P0P2.VGA.GETD"},
+
+	{
+	 .name =3D "A3F",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .wled_status =3D "\\WRST",
+	 .bt_switch =3D "BLED",
+	 .bt_status =3D "\\BRST",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
+	 .lcd_status =3D xxN_PREFIX "RPIN(0x11)",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .display_set =3D "SDSP",
+	 .display_get =3D "\\SSTE"},
+
+	{
+	 .name =3D "A3N",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .wled_status =3D "\\WLDC",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
+	 .lcd_status =3D "\\BKLT",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .display_set =3D "SDSP",
+	 .display_get =3D "\\SSTE"},
=20
 	{
 	 .name =3D "A4G",
=2D	 .mt_mled =3D "MLED",
+	 .mled_set =3D "MLED",
 /* WLED present, but not controlled by ACPI */
=2D	 .mt_lcd_switch =3D xxN_PREFIX "_Q10",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
 	 .brightness_set =3D "SPLV",
 	 .brightness_get =3D "GPLV",
 	 .display_set =3D "SDSP",
 	 .display_get =3D "\\ADVG"},
=20
 	{
+	 .name =3D "A6B",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .lcd_switch =3D A6x_PREFIX "_Q10",
+	 .lcd_status =3D "\\RGPL(0x07,0x01)",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .display_set =3D "SDSP",
+	 .display_get =3D "\\_SB.PCI0.P0P1.VGA.GETD"},
+
+	{
+	 .name =3D "A6J",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .wled_status =3D "\\WRST",
+	 .bt_switch =3D "BLED",
+	 .bt_status =3D "\\BRST",
+	 .lcd_switch =3D A6x_PREFIX "_Q10",
+	 .lcd_status =3D "\\RGP0(0x06)",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .display_set =3D "SDSP",
+	 .display_get =3D "\\_SB.PCI0.P0P2.VGA.GETD"},
+
+	{
+	 .name =3D "A6R",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .wled_status =3D "\\WRST",
+	 .bt_switch =3D "BLED",
+	 .bt_status =3D "\\BRST",
+	 .lcd_switch =3D A6x_PREFIX "_Q10",
+	 .lcd_status =3D A6x_PREFIX "RPIN(0x11)",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .display_set =3D "SDSP",
+	 .display_get =3D "\\_SB.PCI0.P0P1.VGA.GETD"},
+
+	{
+	 .name =3D "A6T",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .wled_status =3D "\\WWED",
+	 .bt_switch =3D "BLED",
+	 .bt_status =3D "\\BLTH",
+	 .lcd_switch =3D A6x_PREFIX "_Q10",
+	 .lcd_status =3D "\\BKLT",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .display_set =3D "SDSP",
+	 .display_get =3D "\\_SB.PCI0.P0PA.VGA.GETD"},
+
+	{
+	 .name =3D "A6V",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .bt_switch =3D "BLED",
+	 .lcd_switch =3D A6x_PREFIX "_Q10",
+	 .lcd_status =3D "\\RGPL(0x15,0x01)",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .display_set =3D "SDSP",
+	 .display_get =3D "\\_SB.PCI0.P0P3.VGA.GETD"},
+
+	{
+	 .name =3D "A8J",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .wled_status =3D "\\WRST",
+	 .bt_switch =3D "BLED",
+	 .bt_status =3D "\\BRST",
+	 .lcd_switch =3D A6x_PREFIX "_Q10",
+	 .lcd_status =3D "\\RGPL(0x06,0x01)",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .display_set =3D "SDSP",
+	 .display_get =3D "\\_SB.PCI0.P0P2.VGA.GETD"},
+
+	{
 	 .name =3D "D1x",
=2D	 .mt_mled =3D "MLED",
=2D	 .mt_lcd_switch =3D "\\Q0D",
+	 .mled_set =3D "MLED",
+	 .lcd_switch =3D "\\Q0D",
 	 .lcd_status =3D "\\GP11",
 	 .brightness_up =3D "\\Q0C",
 	 .brightness_down =3D "\\Q0B",
@@ -204,12 +389,27 @@
 	 .display_get =3D "\\INFB"},
=20
 	{
+	 .name =3D "F3J",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .wled_status =3D "\\WRST",
+	 .bt_switch =3D "BLED",
+	 .bt_status =3D "\\BRST",
+	 .tled_set =3D "TLED",
+	 .lcd_switch =3D A6x_PREFIX "_Q10",
+	 .lcd_status =3D A6x_PREFIX "RPIN(0x11)",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .display_set =3D "SDSP",
+	 .display_get =3D "\\_SB.PCI0.P0P1.VGA.GETD"},
+
+	{
 	 .name =3D "L2D",
=2D	 .mt_mled =3D "MLED",
+	 .mled_set =3D "MLED",
 	 .mled_status =3D "\\SGP6",
=2D	 .mt_wled =3D "WLED",
+	 .wled_set =3D "WLED",
 	 .wled_status =3D "\\RCP3",
=2D	 .mt_lcd_switch =3D "\\Q10",
+	 .lcd_switch =3D "\\Q10",
 	 .lcd_status =3D "\\SGP0",
 	 .brightness_up =3D "\\Q0E",
 	 .brightness_down =3D "\\Q0F",
@@ -218,9 +418,9 @@
=20
 	{
 	 .name =3D "L3C",
=2D	 .mt_mled =3D "MLED",
=2D	 .mt_wled =3D "WLED",
=2D	 .mt_lcd_switch =3D L3C_PREFIX "_Q10",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .lcd_switch =3D L3C_PREFIX "_Q10",
 	 .lcd_status =3D "\\GL32",
 	 .brightness_set =3D "SPLV",
 	 .brightness_get =3D "GPLV",
@@ -229,10 +429,10 @@
=20
 	{
 	 .name =3D "L3D",
=2D	 .mt_mled =3D "MLED",
+	 .mled_set =3D "MLED",
 	 .mled_status =3D "\\MALD",
=2D	 .mt_wled =3D "WLED",
=2D	 .mt_lcd_switch =3D "\\Q10",
+	 .wled_set =3D "WLED",
+	 .lcd_switch =3D "\\Q10",
 	 .lcd_status =3D "\\BKLG",
 	 .brightness_set =3D "SPLV",
 	 .brightness_get =3D "GPLV",
@@ -241,10 +441,10 @@
=20
 	{
 	 .name =3D "L3H",
=2D	 .mt_mled =3D "MLED",
=2D	 .mt_wled =3D "WLED",
=2D	 .mt_lcd_switch =3D "EHK",
=2D	 .lcd_status =3D "\\_SB.PCI0.PM.PBC",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .lcd_switch =3D "EHK(0x07)",
+	 .lcd_status =3D "\\_SB.PCI0.PM.PBC(0x02,0x02)",
 	 .brightness_set =3D "SPLV",
 	 .brightness_get =3D "GPLV",
 	 .display_set =3D "SDSP",
@@ -252,10 +452,10 @@
=20
 	{
 	 .name =3D "L4R",
=2D	 .mt_mled =3D "MLED",
=2D	 .mt_wled =3D "WLED",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
 	 .wled_status =3D "\\_SB.PCI0.SBRG.SG13",
=2D	 .mt_lcd_switch =3D xxN_PREFIX "_Q10",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
 	 .lcd_status =3D "\\_SB.PCI0.SBSM.SEO4",
 	 .brightness_set =3D "SPLV",
 	 .brightness_get =3D "GPLV",
@@ -264,10 +464,10 @@
=20
 	{
 	 .name =3D "L5x",
=2D	 .mt_mled =3D "MLED",
+	 .mled_set =3D "MLED",
 /* WLED present, but not controlled by ACPI */
=2D	 .mt_tled =3D "TLED",
=2D	 .mt_lcd_switch =3D "\\Q0D",
+	 .tled_set =3D "TLED",
+	 .lcd_switch =3D "\\Q0D",
 	 .lcd_status =3D "\\BAOF",
 	 .brightness_set =3D "SPLV",
 	 .brightness_get =3D "GPLV",
@@ -281,8 +481,8 @@
=20
 	{
 	 .name =3D "M1A",
=2D	 .mt_mled =3D "MLED",
=2D	 .mt_lcd_switch =3D M1A_PREFIX "Q10",
+	 .mled_set =3D "MLED",
+	 .lcd_switch =3D M1A_PREFIX "Q10",
 	 .lcd_status =3D "\\PNOF",
 	 .brightness_up =3D M1A_PREFIX "Q0E",
 	 .brightness_down =3D M1A_PREFIX "Q0F",
@@ -292,9 +492,9 @@
=20
 	{
 	 .name =3D "M2E",
=2D	 .mt_mled =3D "MLED",
=2D	 .mt_wled =3D "WLED",
=2D	 .mt_lcd_switch =3D "\\Q10",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .lcd_switch =3D "\\Q10",
 	 .lcd_status =3D "\\GP06",
 	 .brightness_set =3D "SPLV",
 	 .brightness_get =3D "GPLV",
@@ -303,10 +503,10 @@
=20
 	{
 	 .name =3D "M6N",
=2D	 .mt_mled =3D "MLED",
=2D	 .mt_wled =3D "WLED",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
 	 .wled_status =3D "\\_SB.PCI0.SBRG.SG13",
=2D	 .mt_lcd_switch =3D xxN_PREFIX "_Q10",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
 	 .lcd_status =3D "\\_SB.BKLT",
 	 .brightness_set =3D "SPLV",
 	 .brightness_get =3D "GPLV",
@@ -315,19 +515,57 @@
=20
 	{
 	 .name =3D "M6R",
=2D	 .mt_mled =3D "MLED",
=2D	 .mt_wled =3D "WLED",
=2D	 .mt_lcd_switch =3D xxN_PREFIX "_Q10",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
 	 .lcd_status =3D "\\_SB.PCI0.SBSM.SEO4",
 	 .brightness_set =3D "SPLV",
 	 .brightness_get =3D "GPLV",
 	 .display_set =3D "SDSP",
+	 .display_get =3D "\\ACTD"},
+
+	{
+	 .name =3D "M6V",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .mled_status =3D "\\WLSF",
+	 .bt_switch =3D "BLED",
+	 .bt_status =3D "\\BTST",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
+	 .lcd_status =3D "\\RGPL(0x15,0x01)",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .display_set =3D "SDSP",
 	 .display_get =3D "\\_SB.PCI0.P0P1.VGA.GETD"},
=20
 	{
+	 .name =3D "M7A",
+	 .mled_set =3D "MLED",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
+	 .lcd_status =3D xxN_PREFIX "RPIN(0x56)",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .light_sens_switch =3D "ALSC",
+	 .light_sens_level =3D "ALSL",
+	 .display_set =3D "SDSP",
+	 .display_get =3D "\\ADVG"},
+
+	{
+	 .name =3D "M7V",
+	 .mled_set =3D "MLED",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
+	 .lcd_status =3D xxN_PREFIX "RPIN(0x56)",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .light_sens_switch =3D "ALSC",
+	 .light_sens_level =3D "ALSL",
+	 .display_set =3D "SDSP",
+	 .display_get =3D "\\_SB.PCI0.P0P2.VGA.GETD"},
+
+	{
 	 .name =3D "P30",
=2D	 .mt_wled =3D "WLED",
=2D	 .mt_lcd_switch =3D P30_PREFIX "_Q0E",
+	 .wled_set =3D "WLED",
+	 .lcd_switch =3D P30_PREFIX "_Q0E",
 	 .lcd_status =3D "\\BKLT",
 	 .brightness_up =3D P30_PREFIX "_Q68",
 	 .brightness_down =3D P30_PREFIX "_Q69",
@@ -337,40 +575,55 @@
=20
 	{
 	 .name =3D "S1x",
=2D	 .mt_mled =3D "MLED",
+	 .mled_set =3D "MLED",
 	 .mled_status =3D "\\EMLE",
=2D	 .mt_wled =3D "WLED",
=2D	 .mt_lcd_switch =3D S1x_PREFIX "Q10",
+	 .wled_set =3D "WLED",
+	 .lcd_switch =3D S1x_PREFIX "Q10",
 	 .lcd_status =3D "\\PNOF",
 	 .brightness_set =3D "SPLV",
 	 .brightness_get =3D "GPLV"},
=20
 	{
 	 .name =3D "S2x",
=2D	 .mt_mled =3D "MLED",
+	 .mled_set =3D "MLED",
 	 .mled_status =3D "\\MAIL",
=2D	 .mt_lcd_switch =3D S2x_PREFIX "_Q10",
+	 .lcd_switch =3D S2x_PREFIX "_Q10",
 	 .lcd_status =3D "\\BKLI",
 	 .brightness_up =3D S2x_PREFIX "_Q0B",
 	 .brightness_down =3D S2x_PREFIX "_Q0A"},
=20
 	{
=2D	 .name =3D "W1N",
=2D	 .mt_mled =3D "MLED",
=2D	 .mt_wled =3D "WLED",
=2D	 .mt_ledd =3D "SLCM",
=2D	 .mt_lcd_switch =3D xxN_PREFIX "_Q10",
+	 .name =3D "V6J",
+	 .wled_set =3D "WLED",
+	 .bt_switch =3D "BLED",
+	 .tled_set =3D "TLED",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
+	 .lcd_status =3D "\\RGPL(0x06,0x01)",
+	 .display_get =3D "\\_SB.PCI0.P0P1.VGA.GETD",
+	 .display_set =3D "SDSP",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV"},
+
+	{
+	 .name =3D "V6V",
+	 .bt_switch =3D "BLED",
+	 .bt_status =3D "\\_SB.PCI0.SBRG.BLTS",
+	 .wled_set =3D "WLED",
+	 .tled_set =3D "TLED",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
 	 .lcd_status =3D "\\BKLT",
 	 .brightness_set =3D "SPLV",
 	 .brightness_get =3D "GPLV",
=2D	 .display_set =3D "SDSP",
=2D	 .display_get =3D "\\ADVG"},
+	 .display_get =3D "\\_SB.PCI0.POP1.VGA.GETD",
+	 .display_set =3D "SDSP"},
=20
 	{
=2D	 .name =3D "W5A",
=2D	 .mt_bt_switch =3D "BLED",
=2D	 .mt_wled =3D "WLED",
=2D	 .mt_lcd_switch =3D xxN_PREFIX "_Q10",
+	 .name =3D "W1N",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .ledd_set =3D "SLCM",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
+	 .lcd_status =3D "\\BKLT",
 	 .brightness_set =3D "SPLV",
 	 .brightness_get =3D "GPLV",
 	 .display_set =3D "SDSP",
@@ -378,26 +631,65 @@
=20
 	{
 	 .name =3D "W3V",
=2D	 .mt_mled =3D "MLED",
=2D	 .mt_wled =3D "WLED",
=2D	 .mt_lcd_switch =3D xxN_PREFIX "_Q10",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
 	 .lcd_status =3D "\\BKLT",
 	 .brightness_set =3D "SPLV",
 	 .brightness_get =3D "GPLV",
 	 .display_set =3D "SDSP",
 	 .display_get =3D "\\INFB"},
=20
=2D       {
+	{
+	 .name =3D "W5A",
+	 .bt_switch =3D "BLED",
+	 .wled_set =3D "WLED",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .display_set =3D "SDSP",
+	 .display_get =3D "\\ADVG"},
+
+        {
+	 .name =3D "W5F",
+	 .bt_switch =3D "BLED",
+	 .wled_set =3D "WLED",
+	 .tled_set =3D "TLED",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .display_set =3D "SDSP",
+         .display_get =3D "\\ADVG"},
+
+	{
 	 .name =3D "xxN",
=2D	 .mt_mled =3D "MLED",
+	 .mled_set =3D "MLED",
 /* WLED present, but not controlled by ACPI */
=2D	 .mt_lcd_switch =3D xxN_PREFIX "_Q10",
+	 .lcd_switch =3D xxN_PREFIX "_Q10",
 	 .lcd_status =3D "\\BKLT",
 	 .brightness_set =3D "SPLV",
 	 .brightness_get =3D "GPLV",
 	 .display_set =3D "SDSP",
=2D	 .display_get =3D "\\ADVG"}
=2D};
+	 .display_get =3D "\\ADVG"},
+
+	{
+	 .name =3D "Z96",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .bt_switch =3D "BLED",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .display_set =3D "SDSP",
+	 .display_get =3D "\\_SB.PCI0.VGA.GETD"},
+
+	{
+	 .name =3D "???",
+	 .mled_set =3D "MLED",
+	 .wled_set =3D "WLED",
+	 .brightness_set =3D "SPLV",
+	 .brightness_get =3D "GPLV",
+	 .display_set =3D "SDSP"}
+}; /* End methods configuration */
=20
 /* procdir we use */
 static struct proc_dir_entry *asus_proc_dir;
@@ -427,12 +719,55 @@
 		},
 };
=20
=2D/*=20
+#ifdef CONFIG_ACPI_ASUS_NEW_BACKLIGHT
+/* The backlight device /sys/class/backlight */
+static struct backlight_device *backlight;
+
+/*
+ * The backlight class declaration
+ */
+static int read_brightness(struct backlight_device *bd);
+static int update_bl_status(struct backlight_device *bd);
+static struct backlight_properties asusbl_data =3D {
+	       .owner          =3D THIS_MODULE,
+	       .get_brightness =3D read_brightness,
+	       .update_status  =3D update_bl_status,
+	       .max_brightness =3D 15,
+};
+#endif
+
+/*
+ * Take a string describing a method,
+ * parse it, and store the result into mt
+ */
+static void parse_method(char *orig, struct method *mt)
+{
+	char *args =3D orig;
+	uint argc =3D 0;
+
+	mt->name =3D strsep(&args, "(");
+	mt->input.count =3D 0;
+	mt->input.pointer =3D mt->params;
+
+	while(args && *args && argc < MT_MAX_ARGS) {
+		char *tmp;
+		tmp =3D strsep(&args, ",");
+
+		mt->params[argc].type =3D ACPI_TYPE_INTEGER;
+		mt->params[argc].integer.value =3D simple_strtoul(tmp, NULL, 0);
+
+		argc++;
+	}
+
+	mt->input.count =3D argc;
+}
+
+/*
  * This function evaluates an ACPI method, given an int as parameter, the
  * method is searched within the scope of the handle, can be NULL. The out=
put
  * of the method is written is output, which can also be NULL
  *
=2D * returns 1 if write is successful, 0 else.=20
+ * returns 1 if write is successful, 0 else.
  */
 static int write_acpi_int(acpi_handle handle, const char *method, int val,
 			  struct acpi_buffer *output)
@@ -450,7 +785,8 @@
 	return (status =3D=3D AE_OK);
 }
=20
=2Dstatic int read_acpi_int(acpi_handle handle, const char *method, int *va=
l)
+static int read_acpi_int(acpi_handle handle, const char *method, int *val,
+			 struct acpi_object_list *params)
 {
 	struct acpi_buffer output;
 	union acpi_object out_obj;
@@ -459,7 +795,7 @@
 	output.length =3D sizeof(out_obj);
 	output.pointer =3D &out_obj;
=20
=2D	status =3D acpi_evaluate_object(handle, (char *)method, NULL, &output);
+	status =3D acpi_evaluate_object(handle, (char *)method, params, &output);
 	*val =3D out_obj.integer.value;
 	return (status =3D=3D AE_OK) && (out_obj.type =3D=3D ACPI_TYPE_INTEGER);
 }
@@ -484,23 +820,23 @@
 	len +=3D sprintf(page, ACPI_HOTK_NAME " " ASUS_ACPI_VERSION "\n");
 	len +=3D sprintf(page + len, "Model reference    : %s\n",
 		       hotk->methods->name);
=2D	/*=20
=2D	 * The SFUN method probably allows the original driver to get the list=
=20
=2D	 * of features supported by a given model. For now, 0x0100 or 0x0800=20
+	/*
+	 * The SFUN method probably allows the original driver to get the list
+	 * of features supported by a given model. For now, 0x0100 or 0x0800
 	 * bit signifies that the laptop is equipped with a Wi-Fi MiniPCI card.
 	 * The significance of others is yet to be found.
 	 */
=2D	if (read_acpi_int(hotk->handle, "SFUN", &temp))
+	if (read_acpi_int(hotk->handle, "SFUN", &temp, NULL))
 		len +=3D
 		    sprintf(page + len, "SFUN value         : 0x%04x\n", temp);
 	/*
 	 * Another value for userspace: the ASYM method returns 0x02 for
 	 * battery low and 0x04 for battery critical, its readings tend to be
=2D	 * more accurate than those provided by _BST.=20
+	 * more accurate than those provided by _BST.
 	 * Note: since not all the laptops provide this method, errors are
 	 * silently ignored.
 	 */
=2D	if (read_acpi_int(hotk->handle, "ASYM", &temp))
+	if (read_acpi_int(hotk->handle, "ASYM", &temp, NULL))
 		len +=3D
 		    sprintf(page + len, "ASYM value         : 0x%04x\n", temp);
 	if (asus_info) {
@@ -538,12 +874,13 @@
 	if (ledname) {
 		int led_status;
=20
=2D		if (read_acpi_int(NULL, ledname, &led_status))
+		if (read_acpi_int(NULL, ledname, &led_status, NULL))
 			return led_status;
 		else
 			printk(KERN_WARNING "Asus ACPI: Error reading LED "
 			       "status\n");
 	}
+
 	return (hotk->status & ledmask) ? 1 : 0;
 }
=20
@@ -602,7 +939,7 @@
 proc_write_mled(struct file *file, const char __user * buffer,
 		unsigned long count, void *data)
 {
=2D	return write_led(buffer, count, hotk->methods->mt_mled, MLED_ON, 1);
+	return write_led(buffer, count, hotk->methods->mled_set, MLED_ON, 1);
 }
=20
 /*
@@ -624,7 +961,7 @@
 	rv =3D parse_arg(buffer, count, &value);
 	if (rv > 0) {
 		if (!write_acpi_int
=2D		    (hotk->handle, hotk->methods->mt_ledd, value, NULL))
+		    (hotk->handle, hotk->methods->ledd_set, value, NULL))
 			printk(KERN_WARNING
 			       "Asus ACPI: LED display write failed\n");
 		else
@@ -648,7 +985,7 @@
 proc_write_wled(struct file *file, const char __user * buffer,
 		unsigned long count, void *data)
 {
=2D	return write_led(buffer, count, hotk->methods->mt_wled, WLED_ON, 0);
+	return write_led(buffer, count, hotk->methods->wled_set, WLED_ON, 0);
 }
=20
 /*
@@ -665,9 +1002,9 @@
 proc_write_bluetooth(struct file *file, const char __user * buffer,
 		     unsigned long count, void *data)
 {
=2D	/* Note: mt_bt_switch controls both internal Bluetooth adapter's=20
+	/* Note: bt_switch controls both internal Bluetooth adapter's
 	   presence and its LED */
=2D	return write_led(buffer, count, hotk->methods->mt_bt_switch, BT_ON, 0);
+	return write_led(buffer, count, hotk->methods->bt_switch, BT_ON, 0);
 }
=20
 /*
@@ -685,76 +1022,58 @@
 proc_write_tled(struct file *file, const char __user * buffer,
 		unsigned long count, void *data)
 {
=2D	return write_led(buffer, count, hotk->methods->mt_tled, TLED_ON, 0);
+	return write_led(buffer, count, hotk->methods->tled_set, TLED_ON, 0);
 }
=20
 static int get_lcd_state(void)
 {
+	static struct method mt =3D { .name =3D NULL };
 	int lcd =3D 0;
=20
=2D	if (hotk->model !=3D L3H) {
=2D		/* We don't have to check anything if we are here */
=2D		if (!read_acpi_int(NULL, hotk->methods->lcd_status, &lcd))
=2D			printk(KERN_WARNING
=2D			       "Asus ACPI: Error reading LCD status\n");
+	if(mt.name !=3D hotk->methods->lcd_status)
+		parse_method(hotk->methods->lcd_status, &mt);
=20
=2D		if (hotk->model =3D=3D L2D)
=2D			lcd =3D ~lcd;
=2D	} else {		/* L3H and the like have to be handled differently */
=2D		acpi_status status =3D 0;
=2D		struct acpi_object_list input;
=2D		union acpi_object mt_params[2];
=2D		struct acpi_buffer output;
=2D		union acpi_object out_obj;
=2D
=2D		input.count =3D 2;
=2D		input.pointer =3D mt_params;
=2D		/* Note: the following values are partly guessed up, but=20
=2D		   otherwise they seem to work */
=2D		mt_params[0].type =3D ACPI_TYPE_INTEGER;
=2D		mt_params[0].integer.value =3D 0x02;
=2D		mt_params[1].type =3D ACPI_TYPE_INTEGER;
=2D		mt_params[1].integer.value =3D 0x02;
+	if(!mt.name) { /* Not methods to get lcd status */
+		hotk->lcd_status =3D !hotk->lcd_status;
+		return hotk->lcd_status;
+	}
=20
=2D		output.length =3D sizeof(out_obj);
=2D		output.pointer =3D &out_obj;
+	if (!read_acpi_int(NULL, mt.name, &lcd, &mt.input))
+		printk(KERN_WARNING
+		       "Asus ACPI: Error reading LCD status\n");
+
+	if (hotk->model =3D=3D L2D)
+		lcd =3D ~lcd;
+	else if(hotk->model =3D=3D L3H) /* That's what the AML code does */
+		lcd =3D lcd >> 8;
=20
=2D		status =3D
=2D		    acpi_evaluate_object(NULL, hotk->methods->lcd_status,
=2D					 &input, &output);
=2D		if (status !=3D AE_OK)
=2D			return -1;
=2D		if (out_obj.type =3D=3D ACPI_TYPE_INTEGER)
=2D			/* That's what the AML code does */
=2D			lcd =3D out_obj.integer.value >> 8;
=2D	}
=20
 	return (lcd & 1);
 }
=20
 static int set_lcd_state(int value)
 {
+	static struct method mt =3D { .name =3D NULL };
 	int lcd =3D 0;
 	acpi_status status =3D 0;
=20
+	if(mt.name !=3D hotk->methods->lcd_switch)
+		parse_method(hotk->methods->lcd_switch, &mt);
+
 	lcd =3D value ? 1 : 0;
 	if (lcd !=3D get_lcd_state()) {
=2D		/* switch */
=2D		if (hotk->model !=3D L3H) {
=2D			status =3D
=2D			    acpi_evaluate_object(NULL,
=2D						 hotk->methods->mt_lcd_switch,
=2D						 NULL, NULL);
=2D		} else {	/* L3H and the like have to be handled differently */
=2D			if (!write_acpi_int
=2D			    (hotk->handle, hotk->methods->mt_lcd_switch, 0x07,
=2D			     NULL))
=2D				status =3D AE_ERROR;
=2D			/* L3H's AML executes EHK (0x07) upon Fn+F7 keypress,=20
=2D			   the exact behaviour is simulated here */
=2D		}
+		if(hotk->model =3D=3D L3H) /* L3H is special .. */
+			status =3D=20
+				acpi_evaluate_object(hotk->handle,
+						     (char *)mt.name,
+						     &mt.input, NULL);
+		else
+			status =3D acpi_evaluate_object(NULL, (char *)mt.name,
+						      &mt.input, NULL);
+
 		if (ACPI_FAILURE(status))
=2D			printk(KERN_WARNING "Asus ACPI: Error switching LCD\n");
+			printk(KERN_WARNING=20
+			       "Asus ACPI: Error switching LCD\n");
 	}
 	return 0;
=20
@@ -779,18 +1098,18 @@
 	return rv;
 }
=20
=2Dstatic int read_brightness(void)
+static int read_brightness(struct backlight_device *bd)
 {
 	int value;
=20
 	if (hotk->methods->brightness_get) {	/* SPLV/GPLV laptop */
 		if (!read_acpi_int(hotk->handle, hotk->methods->brightness_get,
=2D				   &value))
+				   &value, NULL))
 			printk(KERN_WARNING
 			       "Asus ACPI: Error reading brightness\n");
 	} else if (hotk->methods->brightness_status) {	/* For D1 for example */
 		if (!read_acpi_int(NULL, hotk->methods->brightness_status,
=2D				   &value))
+				   &value, NULL))
 			printk(KERN_WARNING
 			       "Asus ACPI: Error reading brightness\n");
 	} else			/* No GPLV method */
@@ -801,39 +1120,61 @@
 /*
  * Change the brightness level
  */
=2Dstatic void set_brightness(int value)
+static int set_brightness(struct backlight_device *bd, int value)
 {
 	acpi_status status =3D 0;
=20
+	value =3D (0 < value) ? ((15 < value) ? 15 : value) : 0;
+	/* 0 <=3D value <=3D 15 */
+
 	/* SPLV laptop */
 	if (hotk->methods->brightness_set) {
 		if (!write_acpi_int(hotk->handle, hotk->methods->brightness_set,
=2D				    value, NULL))
+				    value, NULL)) {
 			printk(KERN_WARNING
 			       "Asus ACPI: Error changing brightness\n");
=2D		return;
+			return -EINVAL;
+		}
+	} else {
+		/* No SPLV method if we are here, act as appropriate */
+		value -=3D read_brightness(NULL);
+		while (value !=3D 0) {
+			status =3D acpi_evaluate_object(NULL, (value > 0) ?
+						      hotk->methods->brightness_up :
+						      hotk->methods->brightness_down,
+						      NULL, NULL);
+			(value > 0) ? value-- : value++;
+			if (ACPI_FAILURE(status)) {
+				printk(KERN_WARNING
+				       "Asus ACPI: Error changing brightness\n");
+				return -EINVAL;
+			}
+		}
 	}
=20
=2D	/* No SPLV method if we are here, act as appropriate */
=2D	value -=3D read_brightness();
=2D	while (value !=3D 0) {
=2D		status =3D acpi_evaluate_object(NULL, (value > 0) ?
=2D					      hotk->methods->brightness_up :
=2D					      hotk->methods->brightness_down,
=2D					      NULL, NULL);
=2D		(value > 0) ? value-- : value++;
=2D		if (ACPI_FAILURE(status))
=2D			printk(KERN_WARNING
=2D			       "Asus ACPI: Error changing brightness\n");
=2D	}
=2D	return;
+	return 0;
 }
=20
+#ifdef CONFIG_ACPI_ASUS_NEW_BACKLIGHT
+static int update_bl_status(struct backlight_device *bd)
+{
+	int value =3D bd->props->brightness;
+	int power =3D bd->props->power;
+	int rv;
+
+	rv =3D set_brightness(bd, value);
+	if(rv > 0)
+		return rv;
+
+	return set_lcd_state(power);
+}
+#endif
+
 static int
 proc_read_brn(char *page, char **start, off_t off, int count, int *eof,
 	      void *data)
 {
=2D	return sprintf(page, "%d\n", read_brightness());
+	return sprintf(page, "%d\n", read_brightness(NULL));
 }
=20
 static int
@@ -844,9 +1185,7 @@
=20
 	rv =3D parse_arg(buffer, count, &value);
 	if (rv > 0) {
=2D		value =3D (0 < value) ? ((15 < value) ? 15 : value) : 0;
=2D		/* 0 <=3D value <=3D 15 */
=2D		set_brightness(value);
+		set_brightness(NULL, value);
 	}
 	return rv;
 }
@@ -854,6 +1193,7 @@
 static void set_display(int value)
 {
 	/* no sanity check needed for now */
+	hotk->disp_status =3D value;
 	if (!write_acpi_int(hotk->handle, hotk->methods->display_set,
 			    value, NULL))
 		printk(KERN_WARNING "Asus ACPI: Error setting display\n");
@@ -861,7 +1201,7 @@
 }
=20
 /*
=2D * Now, *this* one could be more user-friendly, but so far, no-one has=20
+ * Now, *this* one could be more user-friendly, but so far, no-one has
  * complained. The significance of bits is the same as in proc_write_disp()
  */
 static int
@@ -870,18 +1210,25 @@
 {
 	int value =3D 0;
=20
=2D	if (!read_acpi_int(hotk->handle, hotk->methods->display_get, &value))
+	if(!hotk->methods->display_get)
+		return hotk->disp_status;
+
+	if (!read_acpi_int(hotk->handle, hotk->methods->display_get,
+			   &value, NULL))
 		printk(KERN_WARNING
 		       "Asus ACPI: Error reading display status\n");
=2D	value &=3D 0x07;		/* needed for some models, shouldn't hurt others */
+
+	value &=3D 0x0F;		/* needed for some models, shouldn't hurt others */
+
 	return sprintf(page, "%d\n", value);
 }
=20
 /*
=2D * Experimental support for display switching. As of now: 1 should activ=
ate=20
=2D * the LCD output, 2 should do for CRT, and 4 for TV-Out. Any combinatio=
n=20
=2D * (bitwise) of these will suffice. I never actually tested 3 displays h=
ooked up=20
=2D * simultaneously, so be warned. See the acpi4asus README for more info.
+ * Experimental support for display switching. As of now: 1 should activate
+ * the LCD output, 2 should do for CRT, 4 for TV-Out and 8 for DVI.
+ * Any combination (bitwise) of these will suffice. I never actually teste=
d 4
+ * displays hooked up simultaneously, so be warned. See the acpi4asus READ=
ME
+ * for more info.
  */
 static int
 proc_write_disp(struct file *file, const char __user * buffer,
@@ -895,6 +1242,65 @@
 	return rv;
 }
=20
+static void set_light_sens_switch(int value)
+{
+	if (!write_acpi_int(hotk->handle, hotk->methods->light_sens_switch,
+			    value, NULL))
+		printk(KERN_WARNING "Asus ACPI: Error setting light sensor "
+		       " switch\n");
+	hotk->light_switch =3D value;
+}
+
+static int proc_read_lssw(char *page, char **start, off_t off, int count,
+			  int *eof, void *data)
+{
+	return sprintf(page, "%d\n", hotk->light_switch);
+}
+
+static int proc_write_lssw(struct file *file, const char __user *buffer,
+			   unsigned long count, void *data)
+{
+	int rv, value;
+
+	rv =3D parse_arg(buffer, count, &value);
+	if (rv > 0)
+		set_light_sens_switch(value ? 1 : 0);
+
+	return rv;
+}
+
+static void set_light_sens_level(int value)
+{
+	if (!write_acpi_int(hotk->handle, hotk->methods->light_sens_level,
+			    value, NULL))
+		printk(KERN_WARNING "Asus ACPI: Error setting light sensor"
+		       " level\n");
+	hotk->light_level =3D value;
+}
+
+static int
+proc_read_lslvl(char *page, char **start, off_t off, int count, int *eof,
+		void *data)
+{
+	return sprintf(page, "%d\n", hotk->light_level);
+}
+
+static int
+proc_write_lslvl(struct file *file, const char __user *buffer,
+		 unsigned long count, void *data)
+{
+	int rv, value;
+
+	rv =3D parse_arg(buffer, count, &value);
+	if (rv > 0) {
+		value =3D (0 < value) ? ((15 < value) ? 15 : value) : 0;
+		/* 0 <=3D value <=3D 15 */
+		set_light_sens_level(value);
+	}
+
+	return rv;
+}
+
 typedef int (proc_readfunc) (char *page, char **start, off_t off, int coun=
t,
 			     int *eof, void *data);
 typedef int (proc_writefunc) (struct file * file, const char __user * buff=
er,
@@ -915,8 +1321,8 @@
 	proc->read_proc =3D readfunc;
 	proc->data =3D acpi_driver_data(device);
 	proc->owner =3D THIS_MODULE;
=2D	proc->uid =3D asus_uid;
=2D	proc->gid =3D asus_gid;
+	proc->uid =3D 0;
+	proc->gid =3D 0;
 	return 0;
 }
=20
@@ -925,19 +1331,7 @@
 	struct proc_dir_entry *proc;
 	mode_t mode;
=20
=2D	/*
=2D	 * If parameter uid or gid is not changed, keep the default setting for
=2D	 * our proc entries (-rw-rw-rw-) else, it means we care about security,
=2D	 * and then set to -rw-rw----
=2D	 */
=2D
=2D	if ((asus_uid =3D=3D 0) && (asus_gid =3D=3D 0)) {
=2D		mode =3D S_IFREG | S_IRUGO | S_IWUGO;
=2D	} else {
=2D		mode =3D S_IFREG | S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP;
=2D		printk(KERN_WARNING "  asus_uid and asus_gid parameters are "
=2D		       "deprecated, use chown and chmod instead!\n");
=2D	}
+	mode =3D S_IFREG | S_IRUGO | S_IWUGO;
=20
 	acpi_device_dir(device) =3D asus_proc_dir;
 	if (!acpi_device_dir(device))
@@ -948,43 +1342,43 @@
 		proc->read_proc =3D proc_read_info;
 		proc->data =3D acpi_driver_data(device);
 		proc->owner =3D THIS_MODULE;
=2D		proc->uid =3D asus_uid;
=2D		proc->gid =3D asus_gid;
+		proc->uid =3D 0;
+		proc->gid =3D 0;
 	} else {
 		printk(KERN_WARNING "  Unable to create " PROC_INFO
 		       " fs entry\n");
 	}
=20
=2D	if (hotk->methods->mt_wled) {
+	if (hotk->methods->wled_set) {
 		asus_proc_add(PROC_WLED, &proc_write_wled, &proc_read_wled,
 			      mode, device);
 	}
=20
=2D	if (hotk->methods->mt_ledd) {
+	if (hotk->methods->ledd_set) {
 		asus_proc_add(PROC_LEDD, &proc_write_ledd, &proc_read_ledd,
 			      mode, device);
 	}
=20
=2D	if (hotk->methods->mt_mled) {
+	if (hotk->methods->mled_set) {
 		asus_proc_add(PROC_MLED, &proc_write_mled, &proc_read_mled,
 			      mode, device);
 	}
=20
=2D	if (hotk->methods->mt_tled) {
+	if (hotk->methods->tled_set) {
 		asus_proc_add(PROC_TLED, &proc_write_tled, &proc_read_tled,
 			      mode, device);
 	}
=20
=2D	if (hotk->methods->mt_bt_switch) {
+	if (hotk->methods->bt_switch) {
 		asus_proc_add(PROC_BT, &proc_write_bluetooth,
 			      &proc_read_bluetooth, mode, device);
 	}
=20
=2D	/*=20
=2D	 * We need both read node and write method as LCD switch is also access=
ible
=2D	 * from keyboard=20
+	/*
+	 * We need both read node and write method as LCD switch is also
+	 * accessible from keyboard
 	 */
=2D	if (hotk->methods->mt_lcd_switch && hotk->methods->lcd_status) {
+	if (hotk->methods->lcd_switch && hotk->methods->lcd_status) {
 		asus_proc_add(PROC_LCD, &proc_write_lcd, &proc_read_lcd, mode,
 			      device);
 	}
@@ -1000,6 +1394,14 @@
 			      mode, device);
 	}
=20
+	if (hotk->methods->light_sens_switch)
+		asus_proc_add(PROC_LSSW, &proc_write_lssw, &proc_read_lssw,
+			      mode, device);
+
+	if (hotk->methods->light_sens_level)
+		asus_proc_add(PROC_LSLVL, &proc_write_lslvl, &proc_read_lslvl,
+			      mode, device);
+
 	return 0;
 }
=20
@@ -1007,17 +1409,17 @@
 {
 	if (acpi_device_dir(device)) {
 		remove_proc_entry(PROC_INFO, acpi_device_dir(device));
=2D		if (hotk->methods->mt_wled)
+		if (hotk->methods->wled_set)
 			remove_proc_entry(PROC_WLED, acpi_device_dir(device));
=2D		if (hotk->methods->mt_mled)
+		if (hotk->methods->mled_set)
 			remove_proc_entry(PROC_MLED, acpi_device_dir(device));
=2D		if (hotk->methods->mt_tled)
+		if (hotk->methods->tled_set)
 			remove_proc_entry(PROC_TLED, acpi_device_dir(device));
=2D		if (hotk->methods->mt_ledd)
+		if (hotk->methods->ledd_set)
 			remove_proc_entry(PROC_LEDD, acpi_device_dir(device));
=2D		if (hotk->methods->mt_bt_switch)
+		if (hotk->methods->bt_switch)
 			remove_proc_entry(PROC_BT, acpi_device_dir(device));
=2D		if (hotk->methods->mt_lcd_switch && hotk->methods->lcd_status)
+		if (hotk->methods->lcd_switch && hotk->methods->lcd_status)
 			remove_proc_entry(PROC_LCD, acpi_device_dir(device));
 		if ((hotk->methods->brightness_up
 		     && hotk->methods->brightness_down)
@@ -1026,6 +1428,10 @@
 			remove_proc_entry(PROC_BRN, acpi_device_dir(device));
 		if (hotk->methods->display_set)
 			remove_proc_entry(PROC_DISP, acpi_device_dir(device));
+		if (hotk->methods->light_sens_switch)
+			remove_proc_entry(PROC_LSSW, acpi_device_dir(device));
+		if (hotk->methods->light_sens_level)
+			remove_proc_entry(PROC_LSLVL, acpi_device_dir(device));
 	}
 	return 0;
 }
@@ -1070,6 +1476,8 @@
 		return L4R;
 	else if (strncmp(model, "M6N", 3) =3D=3D 0 || strncmp(model, "W3N", 3) =
=3D=3D 0)
 		return M6N;
+	else if (strncmp(model, "M6V", 3) =3D=3D 0 || strncmp(model, "M6A", 3) =
=3D=3D 0)
+		return M6V;
 	else if (strncmp(model, "M6R", 3) =3D=3D 0 || strncmp(model, "A3G", 3) =
=3D=3D 0)
 		return M6R;
 	else if (strncmp(model, "M2N", 3) =3D=3D 0 ||
@@ -1079,6 +1487,8 @@
 		 strncmp(model, "S1N", 3) =3D=3D 0 ||
 		 strncmp(model, "S5N", 3) =3D=3D 0 || strncmp(model, "W1N", 3) =3D=3D 0)
 		return xxN;
+	else if (strncmp(model, "Z96", 3) =3D=3D 0)
+		return Z96;
 	else if (strncmp(model, "M1", 2) =3D=3D 0)
 		return M1A;
 	else if (strncmp(model, "M2", 2) =3D=3D 0 || strncmp(model, "L4E", 3) =3D=
=3D 0)
@@ -1091,20 +1501,54 @@
 		return D1x;
 	else if (strncmp(model, "A1", 2) =3D=3D 0)
 		return A1x;
+	else if (strncmp(model, "A2D", 3) =3D=3D 0)
+		return A2D;
 	else if (strncmp(model, "A2", 2) =3D=3D 0)
 		return A2x;
+	else if (strncmp(model, "A3N", 3) =3D=3D 0 && strncmp(model, "A3L", 2) =
=3D=3D 0)
+		return A3N;
+	else if (strncmp(model, "A3E", 3) =3D=3D 0)
+		return A3E;
+	else if (strncmp(model, "A3F", 3) =3D=3D 0)
+		return A3F;
+	else if (strncmp(model, "A6F", 3) =3D=3D 0)
+		return A3F;
 	else if (strncmp(model, "J1", 2) =3D=3D 0)
 		return S2x;
 	else if (strncmp(model, "L5", 2) =3D=3D 0)
 		return L5x;
 	else if (strncmp(model, "A4G", 3) =3D=3D 0)
 		return A4G;
+	else if (strncmp(model, "A6J", 3) =3D=3D 0)
+		return A6J;
+	else if (strncmp(model, "A8J", 3) =3D=3D 0)
+		return A8J;
+	else if (strncmp(model, "A6R", 3) =3D=3D 0)
+		return A6R;
+	else if (strncmp(model, "A6V", 3) =3D=3D 0 || strncmp(model, "A6Q", 3) =
=3D=3D 0)
+		return A6V;
+	else if (strncmp(model, "A6T", 3) =3D=3D 0 || strncmp(model, "A6M", 3) =
=3D=3D 0)
+		return A6T;
+	else if (strncmp(model, "A6B", 3) =3D=3D 0 || strncmp(model, "A6K", 3) =
=3D=3D 0)
+		return A6B;
+	else if (strncmp(model, "F3J", 3) =3D=3D 0)
+		return F3J;
 	else if (strncmp(model, "W1N", 3) =3D=3D 0)
 		return W1N;
 	else if (strncmp(model, "W3V", 3) =3D=3D 0)
 		return W3V;
 	else if (strncmp(model, "W5A", 3) =3D=3D 0)
 		return W5A;
+	else if (strncmp(model, "W5F", 3) =3D=3D 0)
+		return W5F;
+	else if (strncmp(model, "M7V", 3) =3D=3D 0)
+		return M7V;
+	else if (strncmp(model, "M7A", 3) =3D=3D 0)
+		return M7A;
+	else if (strncmp(model, "V6V", 3) =3D=3D 0)
+		return V6V;
+	else if (strncmp(model, "V6J", 3) =3D=3D 0)
+		return V6J;
 	else
 		return END_MODEL;
 }
@@ -1123,8 +1567,8 @@
 	acpi_status status;
=20
 	/*
=2D	 * Get DSDT headers early enough to allow for differentiating between=20
=2D	 * models, but late enough to allow acpi_bus_register_driver() to fail=
=20
+	 * Get DSDT headers early enough to allow for differentiating between
+	 * models, but late enough to allow acpi_bus_register_driver() to fail
 	 * before doing anything ACPI-specific. Should we encounter a machine,
 	 * which needs special handling (i.e. its hotkey device has a different
 	 * HID), this bit will be moved. A global variable asus_info contains
@@ -1143,7 +1587,7 @@
 	}
=20
 	/* This needs to be called for some laptops to init properly */
=2D	if (!read_acpi_int(hotk->handle, "BSTS", &bsts_result))
+	if (!read_acpi_int(hotk->handle, "BSTS", &bsts_result, NULL))
 		printk(KERN_WARNING "  Error calling BSTS\n");
 	else if (bsts_result)
 		printk(KERN_NOTICE "  BSTS called, 0x%02x returned\n",
@@ -1151,8 +1595,8 @@
=20
 	/*
 	 * Try to match the object returned by INIT to the specific model.
=2D	 * Handle every possible object (or the lack of thereof) the DSDT=20
=2D	 * writers might throw at us. When in trouble, we pass NULL to=20
+	 * Handle every possible object (or the lack of thereof) the DSDT
+	 * writers might throw at us. When in trouble, we pass NULL to
 	 * asus_model_match() and try something completely different.
 	 */
 	if (buffer.pointer) {
@@ -1176,12 +1620,21 @@
 			hotk->model =3D P30;
 			printk(KERN_NOTICE
 			       "  Samsung P30 detected, supported\n");
=2D		} else {
=2D			hotk->model =3D M2E;
+		} else if(unsupported) {
 			printk(KERN_NOTICE "  unsupported model %s, trying "
 			       "default values\n", string);
 			printk(KERN_NOTICE
 			       "  send /proc/acpi/dsdt to the developers\n");
+			hotk->model =3D DEF;
+
+		} else {
+			printk(KERN_NOTICE "  unsupported model %s\n", string);
+			printk(KERN_NOTICE
+			       "  send /proc/acpi/dsdt to the developers\n");
+			printk(KERN_NOTICE
+			       "  you can use the \"unsupported=3D1\" "
+			       "parameter to have a minimal support\n");
+			return -ENODEV;
 		}
 		hotk->methods =3D &model_conf[hotk->model];
 		return AE_OK;
@@ -1192,7 +1645,7 @@
 	/* Sort of per-model blacklist */
 	if (strncmp(string, "L2B", 3) =3D=3D 0)
 		hotk->methods->lcd_status =3D NULL;
=2D	/* L2B is similar enough to L3C to use its settings, with this only=20
+	/* L2B is similar enough to L3C to use its settings, with this only
 	   exception */
 	else if (strncmp(string, "A3G", 3) =3D=3D 0)
 		hotk->methods->lcd_status =3D "\\BLFG";
@@ -1200,15 +1653,15 @@
 	else if (strncmp(string, "S5N", 3) =3D=3D 0 ||
 		 strncmp(string, "M5N", 3) =3D=3D 0 ||
 		 strncmp(string, "W3N", 3) =3D=3D 0)
=2D		hotk->methods->mt_mled =3D NULL;
+		hotk->methods->mled_set =3D NULL;
 	/* S5N, M5N and W3N have no MLED */
 	else if (strncmp(string, "L5D", 3) =3D=3D 0)
=2D		hotk->methods->mt_wled =3D NULL;
+		hotk->methods->wled_set =3D NULL;
 	/* L5D's WLED is not controlled by ACPI */
 	else if (strncmp(string, "M2N", 3) =3D=3D 0 ||
 		 strncmp(string, "W3V", 3) =3D=3D 0 ||
 		 strncmp(string, "S1N", 3) =3D=3D 0)
=2D		hotk->methods->mt_wled =3D "WLED";
+		hotk->methods->wled_set =3D "WLED";
 	/* M2N, S1N and W3V have a usable WLED */
 	else if (asus_info) {
 		if (strncmp(asus_info->oem_table_id, "L1", 2) =3D=3D 0)
@@ -1301,11 +1754,26 @@
 		}
 	}
=20
+	/* Backlight is probably on at boot time, but it's only used
+	   if we don't have a method to get lcd status */
+	hotk->lcd_status =3D 1;
+	hotk->disp_status =3D 1;
+
 	asus_hotk_found =3D 1;
=20
 	/* LED display is off by default */
 	hotk->ledd_status =3D 0xFFF;
=20
+	/* Set initial values of light sensor and level */
+	hotk->light_switch =3D 1;/* Default to light sensor disabled */
+	hotk->light_level =3D 0;/* level 5 for sensor sensitivity */
+
+	if (hotk->methods->light_sens_switch)
+		set_light_sens_switch(hotk->light_switch);
+
+	if (hotk->methods->light_sens_level)
+		set_light_sens_level(hotk->light_level);
+
       end:
 	if (result) {
 		kfree(hotk);
@@ -1333,7 +1801,8 @@
 	return 0;
 }
=20
=2Dstatic int __init asus_acpi_init(void)
+
+static int __init asus_acpi_probe(struct platform_device *dev)
 {
 	int result;
=20
@@ -1370,18 +1839,79 @@
 		return result;
 	}
=20
+#ifdef CONFIG_ACPI_ASUS_NEW_BACKLIGHT
+	backlight =3D backlight_device_register ("asus", NULL,
+					       &asusbl_data);
+
+	if (IS_ERR (backlight)) {
+		printk(KERN_ERR "Unable to register backlight\n");
+		backlight_device_unregister(backlight);
+		acpi_bus_unregister_driver(&asus_hotk_driver);
+		remove_proc_entry(PROC_ASUS, acpi_root_dir);
+		return -ENODEV;
+	}
+
+	backlight->props->brightness =3D read_brightness(NULL);
+	backlight->props->power =3D get_lcd_state();
+
+#endif
+
 	return 0;
 }
=20
=2Dstatic void __exit asus_acpi_exit(void)
+static int asus_acpi_remove(struct platform_device *dev)
 {
+#ifdef CONFIG_ACPI_ASUS_NEW_BACKLIGHT
+	/* Ugly Hack ...*/
+	if(backlight) {
+		backlight->props->update_status =3D NULL;
+		backlight_device_unregister(backlight);
+	}
+#endif
 	acpi_bus_unregister_driver(&asus_hotk_driver);
 	remove_proc_entry(PROC_ASUS, acpi_root_dir);
=20
 	kfree(asus_info);
=20
=2D	return;
+	return 0;
+}
+
+static struct platform_driver asus_acpi_driver =3D {
+        .probe          =3D asus_acpi_probe,
+        .remove         =3D asus_acpi_remove,
+        .driver         =3D {
+                .name   =3D "asus_acpi",
+        },
+};
+
+static struct platform_device *asus_acpi_device;
+
+static int __init asus_acpi_init(void)
+{
+        int ret;
+
+        ret =3D platform_driver_register(&asus_acpi_driver);
+        if (!ret) {
+                asus_acpi_device =3D platform_device_alloc("asus_acpi", -1=
);
+                if (!asus_acpi_device)
+                        return -ENOMEM;
+
+                ret =3D platform_device_add(asus_acpi_device);
+
+                if (ret) {
+                        platform_device_put(asus_acpi_device);
+                        platform_driver_unregister(&asus_acpi_driver);
+                }
+        }
+        return ret;
+}
+
+static void __exit asus_acpi_exit(void)
+{
+        platform_device_unregister(asus_acpi_device);
+        platform_driver_unregister(&asus_acpi_driver);
 }
=20
+
 module_init(asus_acpi_init);
 module_exit(asus_acpi_exit);

--Boundary-00=_lLSdFzAWUpL/W9x--
