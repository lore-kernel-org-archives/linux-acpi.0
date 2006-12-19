From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 14/22] Add support for A4K
Date: Tue, 19 Dec 2006 22:20:06 +0100
Message-ID: <200612192220.06335.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50221 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933030AbWLSV0N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:26:13 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org


Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus_acpi.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/acpi/asus_acpi.c  2006-12-15 15:58:27.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 15:59:43.000000000 +0100
@@ -147,6 +147,7 @@
                A3F,            //A3F, A6F
                A3N,            //A3N, A3L
                A4G,            //A4700G
+               A4K,            //A4K
                D1x,            //D1
                L2D,            //L2000D
                L3C,            //L3800C
@@ -268,6 +269,17 @@
         .display_get = "\\ADVG"},

        {
+        .name = "A4K",
+        .mled_set = "MLED",
+/* WLED and TLED present, but not controlled by ACPI */
+        .lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_status = "\\BLFG",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+        .display_get = "\\_SB.PCI0.P0P2.VGA.GETD"},
+
+       {
         .name = "D1x",
         .mled_set = "MLED",
         .lcd_switch = "\\Q0D",
@@ -1289,6 +1301,8 @@
                return L5x;
        else if (strncmp(model, "A4G", 3) == 0)
                return A4G;
+       else if (strncmp(model, "A4K", 3) == 0)
+               return A4K;
        else if (strncmp(model, "W1N", 3) == 0)
                return W1N;
        else if (strncmp(model, "W3V", 3) == 0)


-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

