From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 15/22] Add support for A6x and A8J
Date: Tue, 19 Dec 2006 22:20:11 +0100
Message-ID: <200612192220.11277.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50220 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933020AbWLSV0N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:26:13 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org


Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---

 asus_acpi.c |   98 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

--- a/drivers/acpi/asus_acpi.c  2006-12-15 16:00:28.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 16:02:43.000000000 +0100
@@ -148,6 +148,12 @@
                A3N,            //A3N, A3L
                A4G,            //A4700G
                A4K,            //A4K
+               A6B,            //A6B, A6K
+               A6J,            //A6J
+               A6R,            //A6R
+               A6T,            //A6T, A6M
+               A6V,            //A6V, A6Q
+               A8J,            //A8J
                D1x,            //D1
                L2D,            //L2000D
                L3C,            //L3800C
@@ -182,6 +188,7 @@
 #define S1x_PREFIX "\\_SB.PCI0.PX40."
 #define S2x_PREFIX A1x_PREFIX
 #define xxN_PREFIX "\\_SB.PCI0.SBRG.EC0."
+#define A6x_PREFIX xxN_PREFIX

 static struct model_data model_conf[END_MODEL] = {
        /*
@@ -280,6 +287,85 @@
         .display_get = "\\_SB.PCI0.P0P2.VGA.GETD"},

        {
+        .name = "A6B",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .lcd_switch = A6x_PREFIX "_Q10",
+        .lcd_status = "\\RGPL(0x07,0x01)",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+        .display_get = "\\_SB.PCI0.P0P1.VGA.GETD"},
+
+       {
+        .name = "A6J",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .wled_status = "\\WRST",
+        .bt_switch = "BLED",
+        .bt_status = "\\BRST",
+        .lcd_switch = A6x_PREFIX "_Q10",
+        .lcd_status = "\\RGP0(0x06)",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+        .display_get = "\\_SB.PCI0.P0P2.VGA.GETD"},
+
+       {
+        .name = "A6R",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .wled_status = "\\WRST",
+        .bt_switch = "BLED",
+        .bt_status = "\\BRST",
+        .lcd_switch = A6x_PREFIX "_Q10",
+        .lcd_status = A6x_PREFIX "RPIN(0x11)",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+        .display_get = "\\_SB.PCI0.P0P1.VGA.GETD"},
+
+       {
+        .name = "A6T",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .wled_status = "\\WWED",
+        .bt_switch = "BLED",
+        .bt_status = "\\BLTH",
+        .lcd_switch = A6x_PREFIX "_Q10",
+        .lcd_status = "\\BKLT",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+        .display_get = "\\_SB.PCI0.P0PA.VGA.GETD"},
+
+       {
+        .name = "A6V",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .bt_switch = "BLED",
+        .lcd_switch = A6x_PREFIX "_Q10",
+        .lcd_status = "\\RGPL(0x15,0x01)",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+        .display_get = "\\_SB.PCI0.P0P3.VGA.GETD"},
+
+       {
+        .name = "A8J",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .wled_status = "\\WRST",
+        .bt_switch = "BLED",
+        .bt_status = "\\BRST",
+        .lcd_switch = A6x_PREFIX "_Q10",
+        .lcd_status = "\\RGPL(0x06,0x01)",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+        .display_get = "\\_SB.PCI0.P0P2.VGA.GETD"},
+
+       {
         .name = "D1x",
         .mled_set = "MLED",
         .lcd_switch = "\\Q0D",
@@ -1303,6 +1389,18 @@
                return A4G;
        else if (strncmp(model, "A4K", 3) == 0)
                return A4K;
+       else if (strncmp(model, "A6J", 3) == 0)
+               return A6J;
+       else if (strncmp(model, "A6R", 3) == 0)
+               return A6R;
+       else if (strncmp(model, "A6V", 3) == 0 || strncmp(model, "A6Q", 3) == 
0)
+               return A6V;
+       else if (strncmp(model, "A6T", 3) == 0 || strncmp(model, "A6M", 3) == 
0)
+               return A6T;
+       else if (strncmp(model, "A6B", 3) == 0 || strncmp(model, "A6K", 3) == 
0)
+               return A6B;
+       else if (strncmp(model, "A8J", 3) == 0)
+               return A8J;
        else if (strncmp(model, "W1N", 3) == 0)
                return W1N;
        else if (strncmp(model, "W3V", 3) == 0)


-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

