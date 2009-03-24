From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH 1/5] sony-laptop: Add support for new Sony platform API
Date: Tue, 24 Mar 2009 00:47:41 +0000
Message-ID: <20090324004741.GA2252@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49632 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535AbZCXArt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2009 20:47:49 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Norbert Preining <preining@logic.at>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

Newer Sony Vaios provide a new API for accessing platform functionality. It
consists of a set of standardised methods for enabling events and performing
queries. These are each identified by a unique handle. This patch adds
support for calling functions based on their handle and ports the existing
code for these machines over to it.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/platform/x86/sony-laptop.c |  145 ++++++++++++++++--------------------
 1 files changed, 64 insertions(+), 81 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 537959d..ebe7ea6 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -689,6 +689,31 @@ static int acpi_callsetfunc(acpi_handle handle, char *name, int value,
 	return -1;
 }
 
+static int sony_find_snc_handle(int handle)
+{
+	int i;
+	int result;
+
+	for (i = 0x20; i < 0x30; i++) {
+		acpi_callsetfunc(sony_nc_acpi_handle, "SN00", i, &result);
+		if (result == handle)
+			return i-0x20;
+	}
+
+	return -1;
+}
+
+static int sony_call_snc_handle(int handle, int argument, int *result)
+{
+	int offset = sony_find_snc_handle(handle);
+
+	if (offset < 0)
+		return -1;
+
+	return acpi_callsetfunc(sony_nc_acpi_handle, "SN07", offset | argument,
+				result);
+}
+
 /*
  * sony_nc_values input/output validate functions
  */
@@ -809,32 +834,6 @@ struct sony_nc_event {
 	u8	event;
 };
 
-static struct sony_nc_event *sony_nc_events;
-
-/* Vaio C* --maybe also FE*, N* and AR* ?-- special init sequence
- * for Fn keys
- */
-static int sony_nc_C_enable(const struct dmi_system_id *id)
-{
-	int result = 0;
-
-	printk(KERN_NOTICE DRV_PFX "detected %s\n", id->ident);
-
-	sony_nc_events = id->driver_data;
-
-	if (acpi_callsetfunc(sony_nc_acpi_handle, "SN02", 0x4, &result) < 0
-			|| acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0x2, &result) < 0
-			|| acpi_callsetfunc(sony_nc_acpi_handle, "SN02", 0x10, &result) < 0
-			|| acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0x0, &result) < 0
-			|| acpi_callsetfunc(sony_nc_acpi_handle, "SN03", 0x2, &result) < 0
-			|| acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0x101, &result) < 0) {
-		printk(KERN_WARNING DRV_PFX "failed to initialize SNC, some "
-				"functionalities may be missing\n");
-		return 1;
-	}
-	return 0;
-}
-
 static struct sony_nc_event sony_C_events[] = {
 	{ 0x81, SONYPI_EVENT_FNKEY_F1 },
 	{ 0x01, SONYPI_EVENT_FNKEY_RELEASED },
@@ -851,57 +850,17 @@ static struct sony_nc_event sony_C_events[] = {
 	{ 0, 0 },
 };
 
-/* SNC-only model map */
-static const struct dmi_system_id sony_nc_ids[] = {
-		{
-			.ident = "Sony Vaio FE Series",
-			.callback = sony_nc_C_enable,
-			.driver_data = sony_C_events,
-			.matches = {
-				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FE"),
-			},
-		},
-		{
-			.ident = "Sony Vaio FZ Series",
-			.callback = sony_nc_C_enable,
-			.driver_data = sony_C_events,
-			.matches = {
-				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ"),
-			},
-		},
-		{
-			.ident = "Sony Vaio C Series",
-			.callback = sony_nc_C_enable,
-			.driver_data = sony_C_events,
-			.matches = {
-				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-C"),
-			},
-		},
-		{
-			.ident = "Sony Vaio N Series",
-			.callback = sony_nc_C_enable,
-			.driver_data = sony_C_events,
-			.matches = {
-				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-N"),
-			},
-		},
-		{ }
-};
-
 /*
  * ACPI callbacks
  */
 static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct sony_nc_event *evmap;
+	int i;
 	u32 ev = event;
 	int result;
 
-	if (ev == 0x92) {
+	if (ev == 0x92 || ev == 0x90) {
+		int origev = ev;
 		/* read the key pressed from EC.GECR
 		 * A call to SN07 with 0x0202 will do it as well respecting
 		 * the current protocol on different OSes
@@ -913,20 +872,23 @@ static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 		 * TODO: we may want to do the same for the older GHKE -need
 		 *       dmi list- so this snippet may become one more callback.
 		 */
-		if (acpi_callsetfunc(handle, "SN07", 0x0202, &result) < 0)
+		if (sony_call_snc_handle(0x100, 0x200, &result))
 			dprintk("sony_acpi_notify, unable to decode event 0x%.2x\n", ev);
 		else
 			ev = result & 0xFF;
-	}
 
-	if (sony_nc_events)
-		for (evmap = sony_nc_events; evmap->event; evmap++) {
-			if (evmap->data == ev) {
-				ev = evmap->event;
+		for (i = 0; sony_C_events[i].data; i++) {
+			if (sony_C_events[i].data == ev) {
+				ev = sony_C_events[i].event;
 				break;
 			}
 		}
 
+		if (!sony_C_events[i].data)
+			printk(KERN_INFO DRV_PFX "Unknown event: %x %x\n",
+			       origev, ev);
+	}
+
 	dprintk("sony_acpi_notify, event: 0x%.2x\n", ev);
 	sony_laptop_report_input_event(ev);
 	acpi_bus_generate_proc_event(sony_nc_acpi_device, 1, ev);
@@ -953,9 +915,24 @@ static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
 /*
  * ACPI device
  */
+static int sony_nc_function_setup(struct acpi_device *device) {
+	int result;
+
+	/* Enable all events */
+	acpi_callsetfunc(sony_nc_acpi_handle, "SN02", 0xffff, &result);
+
+	/* Setup hotkeys */
+	sony_call_snc_handle(0x0100, 0, &result);
+	sony_call_snc_handle(0x0101, 0, &result);
+	sony_call_snc_handle(0x0102, 0x100, &result);
+
+	return 0;
+}
+
 static int sony_nc_resume(struct acpi_device *device)
 {
 	struct sony_nc_value *item;
+	acpi_handle handle;
 
 	for (item = sony_nc_values; item->name; item++) {
 		int ret;
@@ -970,14 +947,17 @@ static int sony_nc_resume(struct acpi_device *device)
 		}
 	}
 
+	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "SN00",
+					 &handle))) {
+		dprintk("Doing SNC setup\n");
+		sony_nc_function_setup(device);
+	}
+
 	/* set the last requested brightness level */
 	if (sony_backlight_device &&
 			!sony_backlight_update_status(sony_backlight_device))
 		printk(KERN_WARNING DRV_PFX "unable to restore brightness level\n");
 
-	/* re-initialize models with specific requirements */
-	dmi_check_system(sony_nc_ids);
-
 	return 0;
 }
 
@@ -1024,6 +1004,12 @@ static int sony_nc_add(struct acpi_device *device)
 			dprintk("_INI Method failed\n");
 	}
 
+	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "SN00",
+					 &handle))) {
+		dprintk("Doing SNC setup\n");
+		sony_nc_function_setup(device);
+	}
+
 	/* setup input devices and helper fifo */
 	result = sony_laptop_setup_input(device);
 	if (result) {
@@ -1063,9 +1049,6 @@ static int sony_nc_add(struct acpi_device *device)
 
 	}
 
-	/* initialize models with specific requirements */
-	dmi_check_system(sony_nc_ids);
-
 	result = sony_pf_add();
 	if (result)
 		goto outbacklight;
-- 
Matthew Garrett | mjg59@srcf.ucam.org
