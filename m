From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 16/22] Add support for F3J
Date: Tue, 19 Dec 2006 22:20:16 +0100
Message-ID: <200612192220.16571.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50123 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932972AbWLSVZg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:25:36 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org


Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus_acpi.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/acpi/asus_acpi.c  2006-12-15 16:03:47.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 16:05:07.000000000 +0100
@@ -155,6 +155,7 @@
                A6V,            //A6V, A6Q
                A8J,            //A8J
                D1x,            //D1
+               F3J,            //F3JM
                L2D,            //L2000D
                L3C,            //L3800C
                L3D,            //L3400D
@@ -377,6 +378,21 @@
         .display_get = "\\INFB"},

        {
+        .name = "F3J",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .wled_status = "\\WRST",
+        .bt_switch = "BLED",
+        .bt_status = "\\BRST",
+        .tled_set = "TLED",
+        .lcd_switch = A6x_PREFIX "_Q10",
+        .lcd_status = A6x_PREFIX "RPIN(0x11)",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+        .display_get = "\\_SB.PCI0.P0P1.VGA.GETD"},
+
+       {
         .name = "L2D",
         .mled_set = "MLED",
         .mled_status = "\\SGP6",
@@ -1365,6 +1381,8 @@
                return M2E;
        else if (strncmp(model, "L2", 2) == 0)
                return L2D;
+       else if (strncmp(model, "F3J", 3) == 0)
+               return F3J;
        else if (strncmp(model, "L8", 2) == 0)
                return S1x;
        else if (strncmp(model, "D1", 2) == 0)

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

