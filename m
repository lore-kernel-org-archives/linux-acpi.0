From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 17/22] Add support for M6x and M7x
Date: Tue, 19 Dec 2006 22:20:22 +0100
Message-ID: <200612192220.22471.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50176 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933017AbWLSVZ4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:25:56 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org


Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---

--- a/drivers/acpi/asus_acpi.c  2006-12-15 16:05:42.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 16:08:42.000000000 +0100
@@ -167,6 +167,9 @@
                M2E,            //M2400E, L4400L
                M6N,            //M6800N, W3400N
                M6R,            //M6700R, A3000G
+               M6V,            //M6A, M6V-B022P, M6V-8012P
+               M7A,            //Z71A
+               M7V,            //Z71V
                P30,            //Samsung P30
                S1x,            //S1300A, but also L1400B and M2400A (L84F)
                S2x,            //S200 (J1 reported), Victor MP-XP7210
@@ -514,6 +517,44 @@
         .display_get = "\\_SB.PCI0.P0P1.VGA.GETD"},

        {
+        .name = "M6V",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .mled_status = "\\WLSF",
+        .bt_switch = "BLED",
+        .bt_status = "\\BTST",
+        .lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_status = "\\RGPL(0x15,0x01)",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+        .display_get = "\\_SB.PCI0.P0P1.VGA.GETD"},
+
+       {
+        .name = "M7A",
+        .mled_set = "MLED",
+        .lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_status = xxN_PREFIX "RPIN(0x56)",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .light_sens_switch = "ALSC",
+        .light_sens_level = "ALSL",
+        .display_set = "SDSP",
+        .display_get = "\\ADVG"},
+
+       {
+        .name = "M7V",
+        .mled_set = "MLED",
+        .lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_status = xxN_PREFIX "RPIN(0x56)",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .light_sens_switch = "ALSC",
+        .light_sens_level = "ALSL",
+        .display_set = "SDSP",
+        .display_get = "\\_SB.PCI0.P0P2.VGA.GETD"},
+
+       {
         .name = "P30",
         .wled_set = "WLED",
         .lcd_switch = P30_PREFIX "_Q0E",
@@ -1368,6 +1409,12 @@
                return M6N;
        else if (strncmp(model, "M6R", 3) == 0 || strncmp(model, "A3G", 3) == 
0)
                return M6R;
+       else if (strncmp(model, "M6V", 3) == 0 || strncmp(model, "M6A", 3) == 
0)
+               return M6V;
+       else if (strncmp(model, "M7V", 3) == 0)
+               return M7V;
+       else if (strncmp(model, "M7A", 3) == 0)
+               return M7A;
        else if (strncmp(model, "M2N", 3) == 0 ||
                 strncmp(model, "M3N", 3) == 0 ||
                 strncmp(model, "M5N", 3) == 0 ||

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

