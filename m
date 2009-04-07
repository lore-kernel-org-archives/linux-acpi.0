From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 6/7] sony-laptop: use .notify method instead of installing
	handler directly
Date: Tue, 07 Apr 2009 09:37:32 -0600
Message-ID: <20090407153732.21399.29566.stgit@bob.kio>
References: <20090407153532.21399.92051.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:39583 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593AbZDGPhc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 11:37:32 -0400
In-Reply-To: <20090407153532.21399.92051.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Tony Vroon <tony@linx.net>, Mattia Dongili <malattia@linux.it>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Harald Welte <laforge@gnumonks.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Mattia Dongili <malattia@linux.it>
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
 

