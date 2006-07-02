From: Timo Hoenig <thoenig@suse.de>
Subject: [PATCH] Add support for ASUS laptops A6VA, M6A, M6V, W3030V, V6V
	and W5F
Date: Sun, 02 Jul 2006 15:08:12 +0200
Message-ID: <1151845692.25852.45.camel@nouse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:30613 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751191AbWGBNIQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Jul 2006 09:08:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, marekw1977@yahoo.com.au, j-engel@gmx.de, postadal@suse.de, acpi4asus-list@cerqueira.org

Hi Karol,

This is a cumulative patch for the ASUS ACPI driver in order to add
support the following ASUS laptops:

      * ASUS A6VA
      * ASUS M6A, M6V-B022P and M6V-8012P
      * ASUS W3030V
      * ASUS V6V
      * ASUS W5F

The patch applies cleanly on top of Len's git tree and builds fine
(tested with 2.6.17-git20 + Len's ACPI tree).  The broken out patches
can be found on [1].

If I recall correctly there have been patches being sent to the
acpi4asus list to support even more models.  Probably it would be good
to consider them as addition to this patch before asking for inclusion.

CC'ing the original authors of the individual patches.

Please review.  Thanks,

   Timo

[1] Patches to support ASUS laptops A6VA, M6A, M6V, W3030V, V6V and W5F
    http://nouse.net/kernel/patches/asus_acpi

--- a/drivers/acpi/asus_acpi.c	2006-07-02 12:21:35.000000000 +0200
+++ b/drivers/acpi/asus_acpi.c	2006-07-02 14:40:20.000000000 +0200
@@ -121,6 +121,7 @@
 		A1x = 0,	//A1340D, A1300F
 		A2x,		//A2500H
 		A4G,		//A4700G
+		A6VA,		//A6VA
 		D1x,		//D1
 		L2D,		//L2000D
 		L3C,		//L3800C
@@ -133,11 +134,15 @@
 		M2E,		//M2400E, L4400L
 		M6N,		//M6800N, W3400N
 		M6R,		//M6700R, A3000G
+		M6V,		//M6A, M6V-B022P, M6V-8012P
 		P30,		//Samsung P30
 		S1x,		//S1300A, but also L1400B and M2400A (L84F)
 		S2x,		//S200 (J1 reported), Victor MP-XP7210
 		W1N,		//W1000N
+		W3V,            //W3030V
 		W5A,		//W5A
+		W5F,		//W5F
+		V6V,		//V6V
 		xxN,		//M2400N, M3700N, M5200N, M6800N, S1300N, S5200N
 		//(Centrino)
 		END_MODEL
@@ -192,6 +197,17 @@
 	 .display_get = "\\ADVG"},
 
 	{
+	 .name = "A6VA",
+	 .mt_mled = "MLED",
+	 .mt_wled = "WLED",
+	 .mt_lcd_switch = "\\Q11",
+	 .lcd_status = "\\RGPL",
+	 .brightness_set = "SPLV",
+	 .brightness_get = "GPLV",
+	 .display_set = "SDSP",
+	 .display_get = "\\ADVG"},
+
+	{
 	 .name = "D1x",
 	 .mt_mled = "MLED",
 	 .mt_lcd_switch = "\\Q0D",
@@ -324,6 +340,20 @@
 	 .display_get = "\\_SB.PCI0.P0P1.VGA.GETD"},
 
 	{
+	 .name = "M6V",
+	 .mt_bt_switch = "BLED",
+	 .mt_wled = "WLED",
+	 .mt_mled = NULL,
+	 .mt_lcd_switch = xxN_PREFIX "_Q10",
+	 .bt_status = "\\_SB.PCI0.SBRG.BLTS",
+	 .lcd_status = "\\RGPL",
+	 .wled_status = "\\WLSF",
+	 .display_get = "\\_SB.PCI0.P0P3.VGA.GETD",
+	 .display_set = "SDSP",
+	 .brightness_set = "SPLV",
+	 .brightness_get = "GPLV"},
+
+	{
 	 .name = "P30",
 	 .mt_wled = "WLED",
 	 .mt_lcd_switch = P30_PREFIX "_Q0E",
@@ -364,6 +394,17 @@
 	 .brightness_get = "GPLV",
 	 .display_set = "SDSP",
 	 .display_get = "\\ADVG"},
+	
+	{
+	 .name = "W3V",
+	 .mt_mled = "MLED",
+	 .mt_wled = "WLED",
+	 .mt_lcd_switch = xxN_PREFIX "_Q10",
+	 .lcd_status = "\\BKLT",
+	 .brightness_set = "SPLV",
+	 .brightness_get = "GPLV",
+	 .display_set = "SDSP",
+	 .display_get = "\\INFB"},
 
 	{
 	 .name = "W5A",
@@ -376,6 +417,30 @@
 	 .display_get = "\\ADVG"},
 
 	{
+	 .name = "W5F",
+	 .mt_bt_switch = "BLED",
+	 .mt_wled = "WLED",
+	 .mt_tled = "TLED",
+	 .mt_lcd_switch = xxN_PREFIX "_Q10",
+	 .brightness_set = "SPLV",
+	 .brightness_get = "GPLV",
+	 .display_set = "SDSP",
+	 .display_get = "\\ADVG"},
+
+	{
+	 .name = "V6V",
+	 .mt_bt_switch = "BLED",
+	 .mt_wled = "WLED",
+	 .mt_tled = "TLED",
+	 .mt_lcd_switch = xxN_PREFIX "_Q10",
+	 .bt_status = "\\_SB.PCI0.SBRG.BLTS",
+	 .display_get = "\\_SB.PCI0.POP1.VGA.GETD",
+	 .display_set = "SDSP",
+	 .brightness_set = "SPLV",
+	 .brightness_get = "GPLV",
+	 .lcd_status = "\\BKLT"},
+
+	{
 	 .name = "xxN",
 	 .mt_mled = "MLED",
 /* WLED present, but not controlled by ACPI */
@@ -682,7 +747,7 @@
 {
 	int lcd = 0;
 
-	if (hotk->model != L3H) {
+	if (hotk->model != A6VA && hotk->model != M6V && hotk->model != L3H) {
 		/* We don't have to check anything if we are here */
 		if (!read_acpi_int(NULL, hotk->methods->lcd_status, &lcd))
 			printk(KERN_WARNING
@@ -702,9 +767,15 @@
 		/* Note: the following values are partly guessed up, but 
 		   otherwise they seem to work */
 		mt_params[0].type = ACPI_TYPE_INTEGER;
-		mt_params[0].integer.value = 0x02;
 		mt_params[1].type = ACPI_TYPE_INTEGER;
-		mt_params[1].integer.value = 0x02;
+
+		if (hotk->model == A6VA || hotk->model == M6V) {
+			mt_params[0].integer.value = 0x15;
+			mt_params[1].integer.value = 0x01;
+		} else if (hotk->model == L3H) {
+			mt_params[0].integer.value = 0x02;
+			mt_params[1].integer.value = 0x02;
+		} 
 
 		output.length = sizeof(out_obj);
 		output.pointer = &out_obj;
@@ -714,9 +785,13 @@
 					 &input, &output);
 		if (status != AE_OK)
 			return -1;
-		if (out_obj.type == ACPI_TYPE_INTEGER)
+		if (out_obj.type == ACPI_TYPE_INTEGER) {
 			/* That's what the AML code does */
-			lcd = out_obj.integer.value >> 8;
+			if (hotk->model == A6VA || hotk->model == M6V)
+				lcd = out_obj.integer.value;
+			else if (hotk->model == L3H)
+				lcd = out_obj.integer.value >> 8;
+		}
 	}
 
 	return (lcd & 1);
@@ -1079,6 +1154,8 @@
 		return M1A;
 	else if (strncmp(model, "M2", 2) == 0 || strncmp(model, "L4E", 3) == 0)
 		return M2E;
+	else if (strncmp(model, "M6A", 3) == 0 || strncmp(model, "M6V", 3) == 0)
+		return M6V;
 	else if (strncmp(model, "L2", 2) == 0)
 		return L2D;
 	else if (strncmp(model, "L8", 2) == 0)
@@ -1089,6 +1166,8 @@
 		return A1x;
 	else if (strncmp(model, "A2", 2) == 0)
 		return A2x;
+	else if (strncmp(model, "A6VA", 4) == 0)
+		return A6VA;
 	else if (strncmp(model, "J1", 2) == 0)
 		return S2x;
 	else if (strncmp(model, "L5", 2) == 0)
@@ -1097,8 +1176,14 @@
 		return A4G;
 	else if (strncmp(model, "W1N", 3) == 0)
 		return W1N;
+	else if (strncmp(model, "W3V", 3) == 0)
+		return W3V;
 	else if (strncmp(model, "W5A", 3) == 0)
 		return W5A;
+	else if (strncmp(model, "W5F", 3) == 0)
+		return W5F;	
+	else if (strncmp(model, "V6V", 3) == 0)
+		return V6V;
 	else
 		return END_MODEL;
 }
@@ -1200,9 +1285,10 @@
 		hotk->methods->mt_wled = NULL;
 	/* L5D's WLED is not controlled by ACPI */
 	else if (strncmp(string, "M2N", 3) == 0 ||
+		 strncmp(string, "W3V", 3) == 0 ||
 		 strncmp(string, "S1N", 3) == 0)
 		hotk->methods->mt_wled = "WLED";
-	/* M2N and S1N have a usable WLED */
+	/* M2N, S1N and W3V have a usable WLED */
 	else if (asus_info) {
 		if (strncmp(asus_info->oem_table_id, "L1", 2) == 0)
 			hotk->methods->mled_status = NULL;


