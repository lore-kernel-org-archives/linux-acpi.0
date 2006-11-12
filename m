From: Corentin CHARY <corentincj@iksaif.net>
Subject: [Patch] Default values for asus_acpi
Date: Sun, 12 Nov 2006 14:22:28 +0100
Message-ID: <200611121422.29019.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:17545 "EHLO iksaif.net")
	by vger.kernel.org with ESMTP id S1755100AbWKLNW2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Nov 2006 08:22:28 -0500
Received: from [192.168.0.2] (ALyon-151-1-74-131.w83-201.abo.wanadoo.fr [83.201.77.131])
	by iksaif.net (Postfix) with ESMTP id 80BA11A214E
	for <linux-acpi@vger.kernel.org>; Sun, 12 Nov 2006 14:26:21 +0100 (CET)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

With the current default values, unsuported laptops usualy get a lot of "Asus 
ACPI: Error reading LCD status" in dmesg. And it's also a problem for apps 
like kmilo : http://bugs.kde.org/show_bug.cgi?id=102374 .
So, I think default values should be changed..
For example :

--- linux-2.6.19-rc5/drivers/acpi/asus_acpi.c	2006-11-08 03:24:20.000000000 
+0100
+++ asus_acpi.c	2006-11-12 14:10:03.000000000 +0100
@@ -141,6 +141,7 @@
 		W3V,            //W3030V
 		xxN,		//M2400N, M3700N, M5200N, M6800N, S1300N, S5200N
 		//(Centrino)
+		DEF,            //Others ...
 		END_MODEL
 	} model;		//Models currently supported
 	u16 event_count[128];	//count for each event TODO make this better
@@ -396,7 +397,19 @@
 	 .brightness_set = "SPLV",
 	 .brightness_get = "GPLV",
 	 .display_set = "SDSP",
-	 .display_get = "\\ADVG"}
+	 .display_get = "\\ADVG"},
+
+	{
+	 .name = "???",
+	 .mt_mled = "MLED",
+	 .mt_wled = "WLED",
+	 /* lcd_switch not supported as lcd_status is needed,
+	    but never the same */
+	 .brightness_set = "SPLV",
+	 .brightness_get = "GPLV",
+	 .display_set = "SDSP",
+	 .display_get = "\\INFB"}, /* Most of the time, it's \\INFB */
+
 };
 
 /* procdir we use */
@@ -1177,7 +1190,7 @@
 			printk(KERN_NOTICE
 			       "  Samsung P30 detected, supported\n");
 		} else {
-			hotk->model = M2E;
+			hotk->model = DEF;
 			printk(KERN_NOTICE "  unsupported model %s, trying "
 			       "default values\n", string);
 			printk(KERN_NOTICE


-- 
CHARY 'Iksaif' Corentin
corentincj@iksaif.net - corentincj@yahoo.fr
http://xf.iksaif.net
