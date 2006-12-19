From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 22/22] Add support for W3Z
Date: Tue, 19 Dec 2006 22:20:53 +0100
Message-ID: <200612192220.53669.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50125 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933007AbWLSVZh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:25:37 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org


Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus_acpi.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)


--- a/drivers/acpi/asus_acpi.c  2006-12-15 16:24:20.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 16:27:30.000000000 +0100
@@ -178,6 +178,7 @@
                V6V,            //V6V
                W1N,            //W1000N
                W3V,            //W3030V
+               W3Z,            //W3Z
                W5A,            //W5A
                W5F,            //W5F
                W6A,            //W6A
@@ -650,6 +651,19 @@
         .display_get = "\\INFB"},

        {
+        .name = "W3Z",
+        .wled_set = "WLED",
+        .wled_status = "\\WLSF",
+        .bt_switch = "BLED",
+        .bt_status = "\\BLSF",
+        .lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_status = "\\RUOP(0x01)",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+        .display_get = "\\_SB.PCI0.P0P1.VGA.GETD"},
+
+       {
         .name = "W5A",
         .bt_switch = "BLED",
         .wled_set = "WLED",
@@ -1547,6 +1561,8 @@
                return W1N;
        else if (strncmp(model, "W3V", 3) == 0)
                return W3V;
+       else if (strncmp(model, "W3Z", 3) == 0)
+               return W3Z;
        else if (strncmp(model, "W5A", 3) == 0)
                return W5A;
        else if (strncmp(model, "W5F", 3) == 0)


-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
