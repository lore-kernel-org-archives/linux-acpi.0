From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 09/10] sony-laptop: use .notify method instead of installing
	handler directly
Date: Mon, 30 Mar 2009 11:48:54 -0600
Message-ID: <20090330174854.20905.68935.stgit@bob.kio>
References: <20090330174646.20905.18465.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:28865 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314AbZC3Rs4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Mar 2009 13:48:56 -0400
In-Reply-To: <20090330174646.20905.18465.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Tony Vroon <tony@linx.net>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |   32 +++++---------------------------
 1 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index bc8996c..be98b1f 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -895,7 +895,7 @@ static const struct dmi_system_id sony_nc_ids[] = {
 /*
  * ACPI callbacks
  */
-static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
+static void sony_nc_notify(struct acpi_device *device, u32 event)
 {
 	struct sony_nc_event *evmap;
 	u32 ev = event;
@@ -913,8 +913,8 @@ static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 		 * TODO: we may want to do the same for the older GHKE -need
 		 *       dmi list- so this snippet may become one more callback.
 		 */
-		if (acpi_callsetfunc(handle, "SN07", 0x0202, &result) < 0)
-			dprintk("sony_acpi_notify, unable to decode event 0x%.2x\n", ev);
+		if (acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0x0202, &result) < 0)
+			dprintk("sony_nc_notify, unable to decode event 0x%.2x\n", ev);
 		else
 			ev = result & 0xFF;
 	}
@@ -927,7 +927,7 @@ static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 			}
 		}
 
-	dprintk("sony_acpi_notify, event: 0x%.2x\n", ev);
+	dprintk("sony_nc_notify, event: 0x%.2x\n", ev);
 	sony_laptop_report_input_event(ev);
 	acpi_bus_generate_proc_event(sony_nc_acpi_device, 1, ev);
 }
@@ -1032,15 +1032,6 @@ static int sony_nc_add(struct acpi_device *device)
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
@@ -1121,13 +1112,6 @@ static int sony_nc_add(struct acpi_device *device)
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
@@ -1136,7 +1120,6 @@ static int sony_nc_add(struct acpi_device *device)
 
 static int sony_nc_remove(struct acpi_device *device, int type)
 {
-	acpi_status status;
 	struct sony_nc_value *item;
 
 	if (sony_backlight_device)
@@ -1144,12 +1127,6 @@ static int sony_nc_remove(struct acpi_device *device, int type)
 
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
@@ -1182,6 +1159,7 @@ static struct acpi_driver sony_nc_driver = {
 		.add = sony_nc_add,
 		.remove = sony_nc_remove,
 		.resume = sony_nc_resume,
+		.notify = sony_nc_notify,
 		},
 };
 

