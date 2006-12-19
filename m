From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 20/22] Add support for W5F and W6A
Date: Tue, 19 Dec 2006 22:20:40 +0100
Message-ID: <200612192220.40793.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50174 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933011AbWLSVZ4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:25:56 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org


Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus_acpi.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- a/drivers/acpi/asus_acpi.c  2006-12-15 16:20:12.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 16:21:36.000000000 +0100
@@ -179,6 +179,8 @@
                W1N,            //W1000N
                W3V,            //W3030V
                W5A,            //W5A
+               W5F,            //W5F
+               W6A,            //W6A
                xxN,            //M2400N, M3700N, M5200N, M6800N, S1300N, 
S5200N
                //(Centrino)
                DEF,            //Default values
@@ -656,6 +658,29 @@
         .display_set = "SDSP",
         .display_get = "\\ADVG"},

+        {
+        .name = "W5F",
+        .bt_switch = "BLED",
+        .wled_set = "WLED",
+        .tled_set = "TLED",
+        .lcd_switch = xxN_PREFIX "_Q10",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+         .display_get = "\\ADVG"},
+
+        {
+        .name = "W6A",
+        .bt_switch = "BLED",
+        .wled_set = "WLED",
+        .tled_set = "TLED",
+        .lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_status = "\\RGPL(0x15,0x01)",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+         .display_get = "\\SSTE"},
+
        {
         .name = "xxN",
         .mled_set = "MLED",
@@ -1511,6 +1536,10 @@
                return W3V;
        else if (strncmp(model, "W5A", 3) == 0)
                return W5A;
+       else if (strncmp(model, "W5F", 3) == 0)
+               return W5F;
+       else if (strncmp(model, "W6A", 3) == 0)
+               return W6A;
        else if (strncmp(model, "V6V", 3) == 0)
                return V6V;
        else if (strncmp(model, "V6J", 3) == 0)

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

