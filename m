From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 9/22] Display use 4 bits, not 3
Date: Tue, 19 Dec 2006 22:19:35 +0100
Message-ID: <200612192219.35492.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50160 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933009AbWLSVZv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:25:51 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

In all new models, with DVI output, the display value is on 4 bits, not 3.
It still experimental, but works perfectly on A6JC/A6T/F3JC !

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus_acpi.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/acpi/asus_acpi.c  2006-12-15 13:14:50.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 13:16:41.000000000 +0100
@@ -889,18 +889,22 @@
 {
        int value = 0;

-       if (!read_acpi_int(hotk->handle, hotk->methods->display_get, &value, 
NULL))
+       if (!read_acpi_int(hotk->handle, hotk->methods->display_get,
+                          &value, NULL))
                printk(KERN_WARNING
                       "Asus ACPI: Error reading display status\n");
-       value &= 0x07;          /* needed for some models, shouldn't hurt 
others */
+
+       value &= 0x0F;          /* needed for some models, shouldn't hurt 
others */
+
        return sprintf(page, "%d\n", value);
 }

 /*
  * Experimental support for display switching. As of now: 1 should activate
- * the LCD output, 2 should do for CRT, and 4 for TV-Out. Any combination
- * (bitwise) of these will suffice. I never actually tested 3 displays hooked 
up
- * simultaneously, so be warned. See the acpi4asus README for more info.
+ * the LCD output, 2 should do for CRT, 4 for TV-Out and 8 for DVI.
+ * Any combination (bitwise) of these will suffice. I never actually tested 4
+ * displays hooked up simultaneously, so be warned. See the acpi4asus README
+ * for more info.
  */
 static int
 proc_write_disp(struct file *file, const char __user * buffer,

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

