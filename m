From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/17] sony-laptop: use .notify method instead of installing
 handler directly
Date: Tue, 07 Apr 2009 19:04:20 -0400
Message-ID: <8037d6e67709cf497134bbabd77b07dfc7c31fd6.1239145401.git.len.brown@intel.com>
References: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:42738 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbZDGXFD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:05:03 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR008XF6S4NOP6@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 18:04:58 -0500 (CDT)
In-reply-to: <1239145465-5486-1-git-send-email-lenb@kernel.org>
In-reply-to: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
References: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |   30 ++++--------------------------
 1 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index a90ec5c..d3c92d7 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -914,7 +914,7 @@ static struct sony_nc_event sony_127_events[] = {
 /*
  * ACPI callbacks
  */
-static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
+static void sony_nc_notify(struct acpi_device *device, u32 event)
 {
 	u32 ev = event;
 
@@ -933,7 +933,7 @@ static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 			struct sony_nc_event *key_event;
 
 			if (sony_call_snc_handle(key_handle, 0x200, &result)) {
-				dprintk("sony_acpi_notify, unable to decode"
+				dprintk("sony_nc_notify, unable to decode"
 					" event 0x%.2x 0x%.2x\n", key_handle,
 					ev);
 				/* restore the original event */
@@ -968,7 +968,7 @@ static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 	} else
 		sony_laptop_report_input_event(ev);
 
-	dprintk("sony_acpi_notify, event: 0x%.2x\n", ev);
+	dprintk("sony_nc_notify, event: 0x%.2x\n", ev);
 	acpi_bus_generate_proc_event(sony_nc_acpi_device, 1, ev);
 }
 
@@ -1276,15 +1276,6 @@ static int sony_nc_add(struct acpi_device *device)
 		goto outwalk;
 	}
 
-	status = acpi_install_notify_handler(sony_nc_acpi_handle,
-					     ACPI_DEVICE_NOTIFY,
-					     sony_acpi_notify, NULL);
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_WARNING DRV_PFX "unable to install notify handler (%u)\n", status);
-		result = -ENODEV;
-		goto outinput;
-	}
-
 	if (acpi_video_backlight_support()) {
 		printk(KERN_INFO DRV_PFX "brightness ignored, must be "
 		       "controlled by ACPI video driver\n");
@@ -1362,13 +1353,6 @@ static int sony_nc_add(struct acpi_device *device)
 	if (sony_backlight_device)
 		backlight_device_unregister(sony_backlight_device);
 
-	status = acpi_remove_notify_handler(sony_nc_acpi_handle,
-					    ACPI_DEVICE_NOTIFY,
-					    sony_acpi_notify);
-	if (ACPI_FAILURE(status))
-		printk(KERN_WARNING DRV_PFX "unable to remove notify handler\n");
-
-      outinput:
 	sony_laptop_remove_input();
 
       outwalk:
@@ -1378,7 +1362,6 @@ static int sony_nc_add(struct acpi_device *device)
 
 static int sony_nc_remove(struct acpi_device *device, int type)
 {
-	acpi_status status;
 	struct sony_nc_value *item;
 
 	if (sony_backlight_device)
@@ -1386,12 +1369,6 @@ static int sony_nc_remove(struct acpi_device *device, int type)
 
 	sony_nc_acpi_device = NULL;
 
-	status = acpi_remove_notify_handler(sony_nc_acpi_handle,
-					    ACPI_DEVICE_NOTIFY,
-					    sony_acpi_notify);
-	if (ACPI_FAILURE(status))
-		printk(KERN_WARNING DRV_PFX "unable to remove notify handler\n");
-
 	for (item = sony_nc_values; item->name; ++item) {
 		device_remove_file(&sony_pf_device->dev, &item->devattr);
 	}
@@ -1425,6 +1402,7 @@ static struct acpi_driver sony_nc_driver = {
 		.add = sony_nc_add,
 		.remove = sony_nc_remove,
 		.resume = sony_nc_resume,
+		.notify = sony_nc_notify,
 		},
 };
 
-- 
1.6.0.6

