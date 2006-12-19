From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 18/22] Add support for S5A, V6J and V6V
Date: Tue, 19 Dec 2006 22:20:29 +0100
Message-ID: <200612192220.29994.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50180 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933019AbWLSVZ5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:25:57 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org


Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus_acpi.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

--- a/drivers/acpi/asus_acpi.c  2006-12-15 16:17:12.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 16:16:09.000000000 +0100
@@ -173,6 +173,9 @@
                P30,            //Samsung P30
                S1x,            //S1300A, but also L1400B and M2400A (L84F)
                S2x,            //S200 (J1 reported), Victor MP-XP7210
+               S5A,            //S5200A
+               V6J,            //V6J
+               V6V,            //V6V
                W1N,            //W1000N
                W5A,            //W5A
                W3V,            //W3030V
@@ -585,6 +588,42 @@
         .brightness_down = S2x_PREFIX "_Q0A"},

        {
+        .name = "S5A",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .lcd_switch = xxN_PREFIX "Q10",
+        .lcd_status = "\\RGPL(0x15,0x01)",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+        .display_get = "\\_SB.PCI0.P0P2.VGA.GETD"},
+
+       {
+        .name = "V6J",
+        .wled_set = "WLED",
+        .bt_switch = "BLED",
+        .tled_set = "TLED",
+        .lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_status = "\\RGPL(0x06,0x01)",
+        .display_get = "\\_SB.PCI0.P0P1.VGA.GETD",
+        .display_set = "SDSP",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV"},
+
+       {
+        .name = "V6V",
+        .bt_switch = "BLED",
+        .bt_status = "\\_SB.PCI0.SBRG.BLTS",
+        .wled_set = "WLED",
+        .tled_set = "TLED",
+        .lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_status = "\\BKLT",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_get = "\\_SB.PCI0.P0P1.VGA.GETD",
+        .display_set = "SDSP"},
+
+       {
         .name = "W1N",
         .mled_set = "MLED",
         .wled_set = "WLED",
@@ -1472,6 +1511,12 @@
                return W3V;
        else if (strncmp(model, "W5A", 3) == 0)
                return W5A;
+       else if (strncmp(model, "V6V", 3) == 0)
+               return V6V;
+       else if (strncmp(model, "V6J", 3) == 0)
+               return V6J;
+       else if (strncmp(model, "S5A", 3) == 0)
+               return S5A;
        else
                return END_MODEL;
 }

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

