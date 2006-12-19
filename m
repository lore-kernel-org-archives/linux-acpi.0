From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 12/22] Add support for A2D
Date: Tue, 19 Dec 2006 22:19:55 +0100
Message-ID: <200612192219.55253.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50171 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933021AbWLSVZ6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:25:58 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org


Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus_acpi.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/acpi/asus_acpi.c  2006-12-15 13:43:30.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 15:52:29.000000000 +0100
@@ -141,6 +141,7 @@
        u8 light_switch;    //light sensor switch value
        enum {
                A1x = 0,        //A1340D, A1300F
+               A2D,            //A2D
                A2x,            //A2500H
                A4G,            //A4700G
                D1x,            //D1
@@ -194,6 +195,17 @@
         .brightness_down = A1x_PREFIX "_Q0F"},

        {
+        .name = "A2D",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_status = "\\_SB.PCI0.SBRG.GO18",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+        .display_get = "\\ACTD"},
+
+       {
         .name = "A2x",
         .mled_set = "MLED",
         .wled_set = "WLED",
@@ -1221,6 +1233,8 @@
                return D1x;
        else if (strncmp(model, "A1", 2) == 0)
                return A1x;
+       else if (strncmp(model, "A2D", 3) == 0)
+               return A2D;
        else if (strncmp(model, "A2", 2) == 0)
                return A2x;
        else if (strncmp(model, "J1", 2) == 0)

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
