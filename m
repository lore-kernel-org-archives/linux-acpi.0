From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 21/22] Add support for Z96
Date: Tue, 19 Dec 2006 22:20:48 +0100
Message-ID: <200612192220.48088.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50187 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933015AbWLSVZ6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:25:58 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org


Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus_acpi.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/acpi/asus_acpi.c  2006-12-15 16:22:26.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 16:23:38.000000000 +0100
@@ -182,6 +182,7 @@
                W5F,            //W5F
                W6A,            //W6A
                xxN,            //M2400N, M3700N, M5200N, M6800N, S1300N, 
S5200N
+               Z96,            //Z96F
                //(Centrino)
                DEF,            //Default values
                END_MODEL
@@ -693,6 +694,16 @@
         .display_get = "\\ADVG"},

        {
+        .name = "Z96",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .bt_switch = "BLED",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+        .display_get = "\\_SB.PCI0.VGA.GETD"},
+
+       {
         .name = "???",
         .mled_set = "MLED",
         .wled_set = "WLED",
@@ -1486,6 +1497,8 @@
                 strncmp(model, "S1N", 3) == 0 ||
                 strncmp(model, "S5N", 3) == 0 || strncmp(model, "W1N", 3) == 
0)
                return xxN;
+       else if (strncmp(model, "Z96", 3) == 0)
+               return Z96;
        else if (strncmp(model, "M1", 2) == 0)
                return M1A;
        else if (strncmp(model, "M2", 2) == 0 || strncmp(model, "L4E", 3) == 
0)
-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

