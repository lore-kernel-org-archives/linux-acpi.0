From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 11/22] New way to handle unsupported models
Date: Tue, 19 Dec 2006 22:19:49 +0100
Message-ID: <200612192219.49337.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50218 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933029AbWLSV0M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:26:12 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

Now, if a model is unsupported, the module will not be loaded.
But, the user can force it to load, and use default values with :
modprobe asus_acpi unsupported=1
This will avoid bugs like 
<http://lists.kde.org/?l=kde-bugs-dist&m=114846987006116&w=2>.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus_acpi.c |   28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

--- a/drivers/acpi/asus_acpi.c  2006-12-15 13:37:13.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 13:39:36.000000000 +0100
@@ -88,6 +88,10 @@
 MODULE_DESCRIPTION(ACPI_HOTK_NAME);
 MODULE_LICENSE("GPL");

+static uint unsupported;
+module_param(unsupported, uint, 0);
+MODULE_PARM_DESC(unsupported, "Allow the use of default values for an 
unsupported model.\n");
+
 /* For each model, all features implemented,
  * those marked with R are relative to HOTK, A for absolute
  */
@@ -159,6 +163,7 @@
                W3V,            //W3030V
                xxN,            //M2400N, M3700N, M5200N, M6800N, S1300N, 
S5200N
                //(Centrino)
+               DEF,            //Default values
                END_MODEL
        } model;                //Models currently supported
        u16 event_count[128];   //count for each event TODO make this better
@@ -414,7 +419,15 @@
         .brightness_set = "SPLV",
         .brightness_get = "GPLV",
         .display_set = "SDSP",
-        .display_get = "\\ADVG"}
+        .display_get = "\\ADVG"},
+
+       {
+        .name = "???",
+        .mled_set = "MLED",
+        .wled_set = "WLED",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP"}
 };

 /* procdir we use */
@@ -1293,12 +1306,21 @@
                        hotk->model = P30;
                        printk(KERN_NOTICE
                               "  Samsung P30 detected, supported\n");
-               } else {
-                       hotk->model = M2E;
+               } else if(unsupported) {
                        printk(KERN_NOTICE "  unsupported model %s, trying "
                               "default values\n", string);
                        printk(KERN_NOTICE
                               "  send /proc/acpi/dsdt to the developers\n");
+                       hotk->model = DEF;
+
+               } else {
+                       printk(KERN_NOTICE "  unsupported model %s\n", 
string);
+                       printk(KERN_NOTICE
+                              "  send /proc/acpi/dsdt to the developers\n");
+                       printk(KERN_NOTICE
+                              "  you can use the \"unsupported=1\" "
+                              "parameter to have a minimal support\n");
+                       return -ENODEV;
                }
                hotk->methods = &model_conf[hotk->model];
                return AE_OK;


-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

