From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 19/22] Swap W3V and W5A
Date: Tue, 19 Dec 2006 22:20:35 +0100
Message-ID: <200612192220.35487.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50118 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932946AbWLSVZg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:25:36 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org


Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus_acpi.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)


--- a/drivers/acpi/asus_acpi.c  2006-12-15 16:19:24.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 16:19:08.000000000 +0100
@@ -177,8 +177,8 @@
                V6J,            //V6J
                V6V,            //V6V
                W1N,            //W1000N
-               W5A,            //W5A
                W3V,            //W3030V
+               W5A,            //W5A
                xxN,            //M2400N, M3700N, M5200N, M6800N, S1300N, 
S5200N
                //(Centrino)
                DEF,            //Default values
@@ -636,25 +636,25 @@
         .display_get = "\\ADVG"},

        {
-        .name = "W5A",
-        .bt_switch = "BLED",
+        .name = "W3V",
+        .mled_set = "MLED",
         .wled_set = "WLED",
         .lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_status = "\\BKLT",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
         .display_set = "SDSP",
-        .display_get = "\\ADVG"},
+        .display_get = "\\INFB"},

        {
-        .name = "W3V",
-        .mled_set = "MLED",
+        .name = "W5A",
+        .bt_switch = "BLED",
         .wled_set = "WLED",
         .lcd_switch = xxN_PREFIX "_Q10",
-        .lcd_status = "\\BKLT",
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
         .display_set = "SDSP",
-        .display_get = "\\INFB"},
+        .display_get = "\\ADVG"},

        {
         .name = "xxN",

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
