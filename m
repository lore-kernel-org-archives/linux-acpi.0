From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 13/22] Add support for A3x
Date: Tue, 19 Dec 2006 22:20:00 +0100
Message-ID: <200612192220.00655.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50171 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933016AbWLSVZ4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:25:56 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org


Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus_acpi.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

--- a/drivers/acpi/asus_acpi.c  2006-12-15 15:53:40.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 15:57:49.000000000 +0100
@@ -143,6 +143,9 @@
                A1x = 0,        //A1340D, A1300F
                A2D,            //A2D
                A2x,            //A2500H
+               A3E,            //A3E
+               A3F,            //A3F, A6F
+               A3N,            //A3N, A3L
                A4G,            //A4700G
                D1x,            //D1
                L2D,            //L2000D
@@ -218,6 +221,43 @@
         .display_get = "\\INFB"},

        {
+        .name = "A3E",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_status = xxN_PREFIX "RPIN(0x67)",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+        .display_get = "\\_SB.PCI0.P0P2.VGA.GETD"},
+
+       {
+        .name = "A3F",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .wled_status = "\\WRST",
+        .bt_switch = "BLED",
+        .bt_status = "\\BRST",
+        .lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_status = xxN_PREFIX "RPIN(0x11)",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+        .display_get = "\\SSTE"},
+
+       {
+        .name = "A3N",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .wled_status = "\\WLDC",
+        .lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_status = "\\BKLT",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+        .display_get = "\\SSTE"},
+
+       {
         .name = "A4G",
         .mled_set = "MLED",
 /* WLED present, but not controlled by ACPI */
@@ -1237,6 +1277,12 @@
                return A2D;
        else if (strncmp(model, "A2", 2) == 0)
                return A2x;
+       else if (strncmp(model, "A3N", 3) == 0 || strncmp(model, "A3L", 3) == 
0)
+               return A3N;
+       else if (strncmp(model, "A3E", 3) == 0)
+               return A3E;
+       else if (strncmp(model, "A3F", 3) == 0 || strncmp(model, "A6F", 3) == 
0)
+               return A3F;
        else if (strncmp(model, "J1", 2) == 0)
                return S2x;
        else if (strncmp(model, "L5", 2) == 0)
-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

