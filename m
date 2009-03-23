From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Mon, 23 Mar 2009 19:51:18 +0000
Message-ID: <20090323195118.GA30693@srcf.ucam.org>
References: <20090323154332.GA24872@srcf.ucam.org> <20090323160052.GA2525@gamma.logic.tuwien.ac.at> <20090323160944.GA25882@srcf.ucam.org> <20090323162749.GA5463@gamma.logic.tuwien.ac.at> <20090323163056.GA26715@srcf.ucam.org> <20090323163752.GC5463@gamma.logic.tuwien.ac.at> <20090323164007.GA27023@srcf.ucam.org> <20090323164104.GE5463@gamma.logic.tuwien.ac.at> <20090323165157.GA27223@srcf.ucam.org> <20090323174834.GA13341@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34848 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906AbZCWTvY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2009 15:51:24 -0400
Content-Disposition: inline
In-Reply-To: <20090323174834.GA13341@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Mattia Dongili <malattia@linux.it>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

Ok, and here's what I consider to be the "final" version for now. It 
cleans up the event handling (it turns out that the event value 
corresponds to the SN00 value required to call the corresponding 
function) and adds support for the external switch to flag the devices 
as being in HARD_BLOCKED state. Tested on a P series (remotely), if 
someone could check it on a Z and ideally a TT, that would be great. I 
think it's otherwise basically complete for keyboard and rfkill 
handling.

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 537959d..2d142d3 100644
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
@@ -123,6 +124,18 @@ MODULE_PARM_DESC(minor,
 		 "default is -1 (automatic)");
 #endif
 
+enum sony_nc_rfkill {
+	SONY_WIFI,
+	SONY_BLUETOOTH,
+	SONY_WWAN,
+	SONY_WIMAX,
+	SONY_RFKILL_MAX,
+};
+
+static struct rfkill *sony_rfkill_devices[SONY_RFKILL_MAX];
+static int sony_rfkill_address[SONY_RFKILL_MAX] = {0x300, 0x500, 0x700, 0x900};
+static void sony_nc_rfkill_update(void);
+
 /*********** Input Devices ***********/
 
 #define SONY_LAPTOP_BUF_SIZE	128
@@ -134,6 +147,7 @@ struct sony_laptop_input_s {
 	spinlock_t		fifo_lock;
 	struct workqueue_struct	*wq;
 };
+
 static struct sony_laptop_input_s sony_laptop_input = {
 	.users = ATOMIC_INIT(0),
 };
@@ -211,6 +225,7 @@ static int sony_laptop_input_index[] = {
 	48,	/* 61 SONYPI_EVENT_WIRELESS_OFF */
 	49,	/* 62 SONYPI_EVENT_ZOOM_IN_PRESSED */
 	50,	/* 63 SONYPI_EVENT_ZOOM_OUT_PRESSED */
+	51,	/* 64 SONYPI_EVENT_CD_EJECT_PRESSED */
 };
 
 static int sony_laptop_input_keycode_map[] = {
@@ -264,7 +279,8 @@ static int sony_laptop_input_keycode_map[] = {
 	KEY_WLAN,	/* 47 SONYPI_EVENT_WIRELESS_ON */
 	KEY_WLAN,	/* 48 SONYPI_EVENT_WIRELESS_OFF */
 	KEY_ZOOMIN,	/* 49 SONYPI_EVENT_ZOOM_IN_PRESSED */
-	KEY_ZOOMOUT	/* 50 SONYPI_EVENT_ZOOM_OUT_PRESSED */
+	KEY_ZOOMOUT,	/* 50 SONYPI_EVENT_ZOOM_OUT_PRESSED */
+	KEY_EJECTCD	/* 51 SONYPI_EVENT_CD_EJECT_PRESSED */
 };
 
 /* release buttons after a short delay if pressed */
@@ -689,6 +705,31 @@ static int acpi_callsetfunc(acpi_handle handle, char *name, int value,
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
@@ -809,33 +850,11 @@ struct sony_nc_event {
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
-static struct sony_nc_event sony_C_events[] = {
+static struct sony_nc_event sony_nc_events[] = {
+	{ 0x90, SONYPI_EVENT_PKEY_P1 },
+	{ 0x10, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0x91, SONYPI_EVENT_PKEY_P1 },
+	{ 0x11, SONYPI_EVENT_ANYBUTTON_RELEASED },
 	{ 0x81, SONYPI_EVENT_FNKEY_F1 },
 	{ 0x01, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x85, SONYPI_EVENT_FNKEY_F5 },
@@ -844,88 +863,53 @@ static struct sony_nc_event sony_C_events[] = {
 	{ 0x06, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x87, SONYPI_EVENT_FNKEY_F7 },
 	{ 0x07, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x89, SONYPI_EVENT_FNKEY_F9 },
+	{ 0x09, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x8A, SONYPI_EVENT_FNKEY_F10 },
 	{ 0x0A, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x8C, SONYPI_EVENT_FNKEY_F12 },
 	{ 0x0C, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x9f, SONYPI_EVENT_CD_EJECT_PRESSED },
+	{ 0x1f, SONYPI_EVENT_ANYBUTTON_RELEASED },
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
-		/* read the key pressed from EC.GECR
-		 * A call to SN07 with 0x0202 will do it as well respecting
-		 * the current protocol on different OSes
-		 *
-		 * Note: the path for GECR may be
-		 *   \_SB.PCI0.LPCB.EC (C, FE, AR, N and friends)
-		 *   \_SB.PCI0.PIB.EC0 (VGN-FR notifications are sent directly, no GECR)
-		 *
-		 * TODO: we may want to do the same for the older GHKE -need
-		 *       dmi list- so this snippet may become one more callback.
-		 */
-		if (acpi_callsetfunc(handle, "SN07", 0x0202, &result) < 0)
-			dprintk("sony_acpi_notify, unable to decode event 0x%.2x\n", ev);
-		else
-			ev = result & 0xFF;
-	}
+	if (ev >= 0x90) {
+		/* New-style event */
+		int origev = ev;
+		ev -= 0x90;
 
-	if (sony_nc_events)
-		for (evmap = sony_nc_events; evmap->event; evmap++) {
-			if (evmap->data == ev) {
-				ev = evmap->event;
-				break;
+		if (sony_find_snc_handle(0x100) == ev) {
+			int i;
+
+			if (sony_call_snc_handle(0x100, 0x200, &result))
+				dprintk("sony_acpi_notify, unable to decode event 0x%.2x\n", ev);
+			else
+				ev = result & 0xFF;
+
+			for (i=0; sony_nc_events[i].event; i++) {
+				if (sony_nc_events[i].data == ev) {
+					ev = sony_nc_events[i].event;
+					break;
+				}
 			}
+
+			if (!sony_nc_events[i].data)
+				printk(KERN_INFO DRV_PFX
+				       "Unknown event: %x %x\n", origev, ev);
+		} else if (sony_find_snc_handle(0x124) == ev) {
+			sony_nc_rfkill_update();
+			return;
 		}
+	}
 
 	dprintk("sony_acpi_notify, event: 0x%.2x\n", ev);
 	sony_laptop_report_input_event(ev);
@@ -953,9 +937,24 @@ static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
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
@@ -970,13 +969,188 @@ static int sony_nc_resume(struct acpi_device *device)
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
+	int i;
+
+	for (i=0; i<SONY_RFKILL_MAX; i++) {
+		if (sony_rfkill_devices[i])
+			rfkill_unregister(sony_rfkill_devices[i]);
+	}
+}
+
+static int sony_nc_rfkill_get(void *data, enum rfkill_state *state)
+{
+	int result;
+	int argument = sony_rfkill_address[(long) data];
+
+	sony_call_snc_handle(0x124, 0x200, &result);
+	if (result & 0x1) {
+		sony_call_snc_handle(0x124, argument, &result);
+		if (result & 0xf)
+			*state = RFKILL_STATE_UNBLOCKED;
+		else
+			*state = RFKILL_STATE_SOFT_BLOCKED;
+	} else {
+		*state = RFKILL_STATE_HARD_BLOCKED;
+	}
+
+	return 0;
+}
+
+static int sony_nc_rfkill_set(void *data, enum rfkill_state state)
+{
+	int result;
+	int argument = sony_rfkill_address[(long) data] + 0x100;
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
+	struct rfkill *sony_wifi_rfkill;
+
+	sony_wifi_rfkill = rfkill_allocate(&device->dev, RFKILL_TYPE_WLAN);
+	if (!sony_wifi_rfkill)
+		return -1;
+	sony_wifi_rfkill->name = "sony-wifi";
+	sony_wifi_rfkill->toggle_radio = sony_nc_rfkill_set;
+	sony_wifi_rfkill->get_state = sony_nc_rfkill_get;
+	sony_wifi_rfkill->user_claim_unsupported = 1;
+	sony_wifi_rfkill->data = (void *)SONY_WIFI;
+	err = rfkill_register(sony_wifi_rfkill);
+	if (err)
+		rfkill_free(sony_wifi_rfkill);
+	else
+		sony_rfkill_devices[SONY_WIFI] = sony_wifi_rfkill;
+	return err;
+}
+
+static int sony_nc_setup_bluetooth_rfkill(struct acpi_device *device)
+{
+	int err = 0;
+	struct rfkill *sony_bluetooth_rfkill;
+
+	sony_bluetooth_rfkill = rfkill_allocate(&device->dev,
+						RFKILL_TYPE_BLUETOOTH);
+	if (!sony_bluetooth_rfkill)
+		return -1;
+	sony_bluetooth_rfkill->name = "sony-bluetooth";
+	sony_bluetooth_rfkill->toggle_radio = sony_nc_rfkill_set;
+	sony_bluetooth_rfkill->get_state = sony_nc_rfkill_get;
+	sony_bluetooth_rfkill->user_claim_unsupported = 1;
+	sony_bluetooth_rfkill->data = (void *)SONY_BLUETOOTH;
+	err = rfkill_register(sony_bluetooth_rfkill);
+	if (err)
+		rfkill_free(sony_bluetooth_rfkill);
+	else
+		sony_rfkill_devices[SONY_BLUETOOTH] = sony_bluetooth_rfkill;
+	return err;
+}
+
+static int sony_nc_setup_wwan_rfkill(struct acpi_device *device)
+{
+	int err = 0;
+	struct rfkill *sony_wwan_rfkill;
+
+	sony_wwan_rfkill = rfkill_allocate(&device->dev, RFKILL_TYPE_WWAN);
+	if (!sony_wwan_rfkill)
+		return -1;
+	sony_wwan_rfkill->name = "sony-wwan";
+	sony_wwan_rfkill->toggle_radio = sony_nc_rfkill_set;
+	sony_wwan_rfkill->get_state = sony_nc_rfkill_get;
+	sony_wwan_rfkill->user_claim_unsupported = 1;
+	sony_wwan_rfkill->data = (void *)SONY_WWAN;
+	err = rfkill_register(sony_wwan_rfkill);
+	if (err)
+		rfkill_free(sony_wwan_rfkill);
+	else
+		sony_rfkill_devices[SONY_WWAN] = sony_wwan_rfkill;
+	return err;
+}
+
+static int sony_nc_setup_wimax_rfkill(struct acpi_device *device)
+{
+	int err = 0;
+	struct rfkill *sony_wimax_rfkill;
+
+	sony_wimax_rfkill = rfkill_allocate(&device->dev, RFKILL_TYPE_WIMAX);
+	if (!sony_wimax_rfkill)
+		return -1;
+	sony_wimax_rfkill->name = "sony-wimax";
+	sony_wimax_rfkill->toggle_radio = sony_nc_rfkill_set;
+	sony_wimax_rfkill->get_state = sony_nc_rfkill_get;
+	sony_wimax_rfkill->user_claim_unsupported = 1;
+	sony_wimax_rfkill->data = (void *)SONY_WIMAX;
+	err = rfkill_register(sony_wimax_rfkill);
+	if (err)
+		rfkill_free(sony_wimax_rfkill);
+	else
+		sony_rfkill_devices[SONY_WIMAX] = sony_wimax_rfkill;
+	return err;
+}
+
+static void sony_nc_rfkill_update()
+{
+	int i;
+	enum rfkill_state state;
+
+	for (i=0; i<SONY_RFKILL_MAX; i++) {
+		if (sony_rfkill_devices[i]) {
+			sony_rfkill_devices[i]->
+				get_state(sony_rfkill_devices[i]->data,
+					  &state);
+			rfkill_force_state(sony_rfkill_devices[i], state);
+		}
+	}
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
@@ -1024,6 +1198,19 @@ static int sony_nc_add(struct acpi_device *device)
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
@@ -1063,9 +1250,6 @@ static int sony_nc_add(struct acpi_device *device)
 
 	}
 
-	/* initialize models with specific requirements */
-	dmi_check_system(sony_nc_ids);
-
 	result = sony_pf_add();
 	if (result)
 		goto outbacklight;
@@ -1131,6 +1315,7 @@ static int sony_nc_add(struct acpi_device *device)
 	sony_laptop_remove_input();
 
       outwalk:
+	sony_nc_rfkill_cleanup();
 	return result;
 }
 
@@ -1156,6 +1341,7 @@ static int sony_nc_remove(struct acpi_device *device, int type)
 
 	sony_pf_remove();
 	sony_laptop_remove_input();
+	sony_nc_rfkill_cleanup();
 	dprintk(SONY_NC_DRIVER_NAME " removed.\n");
 
 	return 0;
diff --git a/include/linux/sonypi.h b/include/linux/sonypi.h
index f41ffd7..8458dbe 100644
--- a/include/linux/sonypi.h
+++ b/include/linux/sonypi.h
@@ -103,6 +103,7 @@
 #define SONYPI_EVENT_WIRELESS_OFF		61
 #define SONYPI_EVENT_ZOOM_IN_PRESSED		62
 #define SONYPI_EVENT_ZOOM_OUT_PRESSED		63
+#define SONYPI_EVENT_CD_EJECT_PRESSED		64
 
 /* get/set brightness */
 #define SONYPI_IOCGBRT		_IOR('v', 0, __u8)


-- 
Matthew Garrett | mjg59@srcf.ucam.org
