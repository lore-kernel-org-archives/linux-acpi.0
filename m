From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Mon, 23 Mar 2009 15:43:32 +0000
Message-ID: <20090323154332.GA24872@srcf.ucam.org>
References: <20090322175609.GA10304@srcf.ucam.org> <20090322180321.GA10401@srcf.ucam.org> <20090322203603.GA6877@gamma.logic.tuwien.ac.at> <20090322203740.GA12285@srcf.ucam.org> <20090322220655.GA13887@gamma.logic.tuwien.ac.at> <20090322224652.GA13814@srcf.ucam.org> <20090322231029.GC17905@kamineko.org> <20090323123030.GC11430@gamma.logic.tuwien.ac.at> <20090323130457.GA2767@kamineko.org> <20090323153259.GA31191@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38480 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156AbZCWPnl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2009 11:43:41 -0400
Content-Disposition: inline
In-Reply-To: <20090323153259.GA31191@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Mattia Dongili <malattia@linux.it>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

Interesting. These don't seem to match your earlier numbers, but instead 
look much more like the 0x92-style events. Do any of the other keys 
generate events? This one should be consistent with the events you're 
reporting.

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 537959d..dc3ad48 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -64,6 +64,7 @@
 #include <asm/uaccess.h>
 #include <linux/sonypi.h>
 #include <linux/sony-laptop.h>
+#include <linux/rfkill.h>
 #ifdef CONFIG_SONYPI_COMPAT
 #include <linux/poll.h>
 #include <linux/miscdevice.h>
@@ -123,6 +124,11 @@ MODULE_PARM_DESC(minor,
 		 "default is -1 (automatic)");
 #endif
 
+static struct rfkill *sony_wifi_rfkill;
+static struct rfkill *sony_bluetooth_rfkill;
+static struct rfkill *sony_wwan_rfkill;
+static struct rfkill *sony_wimax_rfkill;
+
 /*********** Input Devices ***********/
 
 #define SONY_LAPTOP_BUF_SIZE	128
@@ -134,6 +140,7 @@ struct sony_laptop_input_s {
 	spinlock_t		fifo_lock;
 	struct workqueue_struct	*wq;
 };
+
 static struct sony_laptop_input_s sony_laptop_input = {
 	.users = ATOMIC_INIT(0),
 };
@@ -689,6 +696,31 @@ static int acpi_callsetfunc(acpi_handle handle, char *name, int value,
 	return -1;
 }
 
+static int sony_find_snc_handle(int handle)
+{
+	int i;
+	int result;
+
+	for (i=0x20; i<0x30; i++) {
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
@@ -809,33 +841,25 @@ struct sony_nc_event {
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
+static struct sony_nc_event sony_90_events[] = {
+	{ 0x10, SONYPI_EVENT_PKEY_P1 },
+	{ 0x11, SONYPI_EVENT_PKEY_P1 },
+	{ 0x85, SONYPI_EVENT_FNKEY_F5 },
+	{ 0x05, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x86, SONYPI_EVENT_FNKEY_F6 },
+	{ 0x06, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x87, SONYPI_EVENT_FNKEY_F7 },
+	{ 0x07, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x89, SONYPI_EVENT_FNKEY_F9 },
+	{ 0x09, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x8a, SONYPI_EVENT_FNKEY_F10 },
+	{ 0x0a, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x8C, SONYPI_EVENT_FNKEY_F12 },
+	{ 0x0C, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0, 0 },
+};
 
-static struct sony_nc_event sony_C_events[] = {
+static struct sony_nc_event sony_92_events[] = {
 	{ 0x81, SONYPI_EVENT_FNKEY_F1 },
 	{ 0x01, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x85, SONYPI_EVENT_FNKEY_F5 },
@@ -851,57 +875,18 @@ static struct sony_nc_event sony_C_events[] = {
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
 	u32 ev = event;
 	int result;
 
-	if (ev == 0x92) {
+	if (ev == 0x90 || ev == 0x92) {
+		struct sony_nc_event *events;
+		int origev = ev;
+		
 		/* read the key pressed from EC.GECR
 		 * A call to SN07 with 0x0202 will do it as well respecting
 		 * the current protocol on different OSes
@@ -913,20 +898,29 @@ static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
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
+		if (origev == 0x90)
+			events = sony_90_events;
+		else
+			events = sony_92_events;
+
+		while (events->event) {
+			if (events->data == ev) {
+				ev = events->event;
 				break;
 			}
+			events++;
 		}
 
+		if (!events->data)
+			printk(KERN_INFO DRV_PFX "Unknown event: %x %x\n",
+			       origev, ev);
+	}
+
 	dprintk("sony_acpi_notify, event: 0x%.2x\n", ev);
 	sony_laptop_report_input_event(ev);
 	acpi_bus_generate_proc_event(sony_nc_acpi_device, 1, ev);
@@ -953,9 +947,24 @@ static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
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
@@ -970,13 +979,156 @@ static int sony_nc_resume(struct acpi_device *device)
 		}
 	}
 
+	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "ECON",
+					 &handle))) {
+		if (acpi_callsetfunc(sony_nc_acpi_handle, "ECON", 1, NULL))
+			dprintk("ECON Method failed\n");
+	}
+
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
+	return 0;
+}
+
+static void sony_nc_rfkill_cleanup(void)
+{
+	if (sony_wifi_rfkill)
+		rfkill_unregister(sony_wifi_rfkill);
+	if (sony_bluetooth_rfkill)
+		rfkill_unregister(sony_bluetooth_rfkill);
+	if (sony_wwan_rfkill)
+		rfkill_unregister(sony_wwan_rfkill);
+	if (sony_wimax_rfkill)
+		rfkill_unregister(sony_wimax_rfkill);
+}
+
+static int sony_nc_rfkill_get(void *data, enum rfkill_state *state)
+{
+	int result;
+
+	sony_call_snc_handle(0x124, (long) data, &result);
+	if (result & 0xf)
+		*state = RFKILL_STATE_UNBLOCKED;
+	else
+		*state = RFKILL_STATE_SOFT_BLOCKED;
+	return 0;
+}
+
+static int sony_nc_rfkill_set(void *data, enum rfkill_state state)
+{
+	int result;
+	int argument = (long) data + 1;
+
+	if (state == RFKILL_STATE_UNBLOCKED)
+		argument |= 0xff0000;
+
+	return sony_call_snc_handle(0x124, argument, &result);
+}
+
+static int sony_nc_setup_wifi_rfkill(struct acpi_device *device)
+{
+	int err = 0;
+
+	sony_wifi_rfkill = rfkill_allocate(&device->dev, RFKILL_TYPE_WLAN);
+	if (!sony_wifi_rfkill)
+		return -1;
+	sony_wifi_rfkill->name = "sony-wifi";
+	sony_wifi_rfkill->toggle_radio = sony_nc_rfkill_set;
+	sony_wifi_rfkill->get_state = sony_nc_rfkill_get;
+	sony_wifi_rfkill->user_claim_unsupported = 1;
+	sony_wifi_rfkill->data = (void *)0x300;
+	err = rfkill_register(sony_wifi_rfkill);
+	if (err)
+		rfkill_free(sony_wifi_rfkill);
+	return err;
+}
+
+static int sony_nc_setup_bluetooth_rfkill(struct acpi_device *device)
+{
+	int err = 0;
+
+	sony_bluetooth_rfkill = rfkill_allocate(&device->dev,
+						RFKILL_TYPE_BLUETOOTH);
+       if (!sony_bluetooth_rfkill)
+	       return -1;
+       sony_bluetooth_rfkill->name = "sony-bluetooth";
+       sony_bluetooth_rfkill->toggle_radio = sony_nc_rfkill_set;
+       sony_bluetooth_rfkill->get_state = sony_nc_rfkill_get;
+       sony_bluetooth_rfkill->user_claim_unsupported = 1;
+       sony_bluetooth_rfkill->data = (void *)0x500;
+       err = rfkill_register(sony_bluetooth_rfkill);
+       if (err)
+	       rfkill_free(sony_bluetooth_rfkill);
+       return err;
+}
+
+static int sony_nc_setup_wwan_rfkill(struct acpi_device *device)
+{
+	int err = 0;
+
+	sony_wwan_rfkill = rfkill_allocate(&device->dev, RFKILL_TYPE_WWAN);
+	if (!sony_wwan_rfkill)
+		return -1;
+	sony_wwan_rfkill->name = "sony-wwan";
+	sony_wwan_rfkill->toggle_radio = sony_nc_rfkill_set;
+	sony_wwan_rfkill->get_state = sony_nc_rfkill_get;
+	sony_wwan_rfkill->user_claim_unsupported = 1;
+	sony_wwan_rfkill->data = (void *)0x700;
+	err = rfkill_register(sony_wwan_rfkill);
+	if (err)
+		rfkill_free(sony_wwan_rfkill);
+	return err;
+}
+
+static int sony_nc_setup_wimax_rfkill(struct acpi_device *device)
+{
+	int err = 0;
+
+	sony_wimax_rfkill = rfkill_allocate(&device->dev, RFKILL_TYPE_WIMAX);
+	if (!sony_wimax_rfkill)
+		return -1;
+	sony_wimax_rfkill->name = "sony-wimax";
+	sony_wimax_rfkill->toggle_radio = sony_nc_rfkill_set;
+	sony_wimax_rfkill->get_state = sony_nc_rfkill_get;
+	sony_wimax_rfkill->user_claim_unsupported = 1;
+	sony_wimax_rfkill->data = (void *)0x900;
+	err = rfkill_register(sony_wimax_rfkill);
+	if (err)
+		rfkill_free(sony_wimax_rfkill);
+	return err;
+}
+
+static int sony_nc_rfkill_setup(struct acpi_device *device)
+{
+	int result, ret;
+
+	if (sony_find_snc_handle(0x124) == -1)
+		return -1;
+
+	ret = sony_call_snc_handle(0x124, 0xb00, &result);
+	if (ret) {
+		printk(KERN_INFO DRV_PFX
+		       "Unable to enumerate rfkill devices: %x\n", ret);
+		return ret;
+	}
+
+	if (result & 0x1)
+		sony_nc_setup_wifi_rfkill(device);
+	if (result & 0x2)
+		sony_nc_setup_bluetooth_rfkill(device);
+	if (result & 0x1c)
+		sony_nc_setup_wwan_rfkill(device);
+	if (result & 0x20)
+		sony_nc_setup_wimax_rfkill(device);
 
 	return 0;
 }
@@ -1024,6 +1176,19 @@ static int sony_nc_add(struct acpi_device *device)
 			dprintk("_INI Method failed\n");
 	}
 
+	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "ECON",
+					 &handle))) {
+		if (acpi_callsetfunc(sony_nc_acpi_handle, "ECON", 1, NULL))
+			dprintk("ECON Method failed\n");
+	}
+
+	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "SN00",
+					 &handle))) {
+		dprintk("Doing SNC setup\n");
+		sony_nc_function_setup(device);
+		sony_nc_rfkill_setup(device);
+	}
+
 	/* setup input devices and helper fifo */
 	result = sony_laptop_setup_input(device);
 	if (result) {
@@ -1063,9 +1228,6 @@ static int sony_nc_add(struct acpi_device *device)
 
 	}
 
-	/* initialize models with specific requirements */
-	dmi_check_system(sony_nc_ids);
-
 	result = sony_pf_add();
 	if (result)
 		goto outbacklight;
@@ -1131,6 +1293,7 @@ static int sony_nc_add(struct acpi_device *device)
 	sony_laptop_remove_input();
 
       outwalk:
+	sony_nc_rfkill_cleanup();
 	return result;
 }
 
@@ -1156,6 +1319,7 @@ static int sony_nc_remove(struct acpi_device *device, int type)
 
 	sony_pf_remove();
 	sony_laptop_remove_input();
+	sony_nc_rfkill_cleanup();
 	dprintk(SONY_NC_DRIVER_NAME " removed.\n");
 
 	return 0;

-- 
Matthew Garrett | mjg59@srcf.ucam.org
