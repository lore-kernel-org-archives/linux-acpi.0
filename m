From: malattia@linux.it
Subject: [patch 3/9] Add debug macros also used by the sonypi reimplementation
Date: Mon, 9 Apr 2007 19:22:44 +0200
Message-ID: <20070409172244.GD10646@inferi.kami.home>
References: <20070409081903.057292676@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:52744 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbXDIRYW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Apr 2007 13:24:22 -0400
Content-Disposition: inline; filename="0003-introduce-debug-macros.patch"
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, stelian@popies.net

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Index: linux-2.6/drivers/misc/sony-laptop.c
===================================================================
--- linux-2.6.orig/drivers/misc/sony-laptop.c	2007-03-18 18:50:17.769519953 +0100
+++ linux-2.6/drivers/misc/sony-laptop.c	2007-03-18 18:50:26.270004320 +0100
@@ -35,6 +35,11 @@
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
 
+#define LOG_PFX			KERN_WARNING "sony-laptop: "
+#define dprintk(msg...)		do {			\
+	if (debug) printk(KERN_WARNING LOG_PFX  msg);	\
+} while (0)
+
 #define SONY_NC_CLASS		"sony"
 #define SONY_NC_HID		"SNY5001"
 #define SONY_NC_DRIVER_NAME	"ACPI Sony Notebook Control Driver v0.4"
@@ -43,8 +48,6 @@
    0-based values */
 #define SONY_MAX_BRIGHTNESS	8
 
-#define LOG_PFX			KERN_WARNING "sony-laptop: "
-
 MODULE_AUTHOR("Stelian Pop, Mattia Dongili");
 MODULE_DESCRIPTION(SONY_NC_DRIVER_NAME);
 MODULE_LICENSE("GPL");
@@ -368,8 +371,7 @@ static struct backlight_ops sony_backlig
  */
 static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	if (debug)
-		printk(LOG_PFX "sony_acpi_notify, event: %d\n", event);
+	dprintk("sony_acpi_notify, event: %d\n", event);
 	acpi_bus_generate_event(sony_nc_acpi_device, 1, event);
 }
 
@@ -472,9 +474,8 @@ static int sony_nc_add(struct acpi_devic
 			if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle,
 							 *item->acpiget,
 							 &handle))) {
-				if (debug)
-					printk(LOG_PFX "Found %s getter: %s\n",
-					       item->name, *item->acpiget);
+				dprintk("Found %s getter: %s\n",
+						item->name, *item->acpiget);
 				item->devattr.attr.mode |= S_IRUGO;
 				break;
 			}
@@ -485,9 +486,8 @@ static int sony_nc_add(struct acpi_devic
 			if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle,
 							 *item->acpiset,
 							 &handle))) {
-				if (debug)
-					printk(LOG_PFX "Found %s setter: %s\n",
-					       item->name, *item->acpiset);
+				dprintk("Found %s setter: %s\n",
+						item->name, *item->acpiset);
 				item->devattr.attr.mode |= S_IWUSR;
 				break;
 			}

--
-- 
mattia
:wq!
