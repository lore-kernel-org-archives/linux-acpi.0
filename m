From: Norbert Preining <preining@logic.at>
Subject: new fixes for sony-acpi
Date: Mon, 23 Mar 2009 17:34:59 +0100
Message-ID: <20090323163459.GB5463@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:41153 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633AbZCWQfG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2009 12:35:06 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: sony-vaio-z-series@lists.launchpad.net
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Mattia Dongili <malattia@linux.it>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sony Vaio Z list,

after some discussion Matthew has provided a nice patch that makes the
Fn-F5 and Fn-F6 keys working, and also S1 and S2.

I have adapted the speed-stamina patch from Matthias.

The following patches are only interesting for people running 2.6.29-rc
kernels (afais)

So attached are two patches:
- sony-laptop-matthew-version5.patch
  latest version from Matthew with some keys creating events

- sony-laptop.c-speed-stamina-latest.patch
  patch to add speed-stamina switch based on the 0.7 module of Matthias

Thanks a lot to Matthew and Matthias for working on that.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
HIGH LIMERIGG (n.)
The topmost tread of a staircase which disappears when you've climbing
the stairs in the darkness.
			--- Douglas Adams, The Meaning of Liff

--k+w/mQv8wyuph6w0
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="sony-laptop-matthew-version5.patch"

Ok, this one should cover it. Thanks for testing! S1 and S2 will just 
generate events that can be bound with your desktop environment or 
xbindkeys or something similar.

Mattia, how do you feel about this approach? If you're happy enough I 
can send this as a patchset.

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 537959d..00ed914 100644
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
@@ -809,33 +841,27 @@ struct sony_nc_event {
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
+	{ 0x90, SONYPI_EVENT_PKEY_P1 },
+	{ 0x10, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0x91, SONYPI_EVENT_PKEY_P1 },
+	{ 0x11, SONYPI_EVENT_ANYBUTTON_RELEASED },
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
@@ -851,57 +877,18 @@ static struct sony_nc_event sony_C_events[] = {
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
@@ -913,20 +900,29 @@ static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
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
@@ -953,9 +949,24 @@ static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
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
@@ -970,13 +981,156 @@ static int sony_nc_resume(struct acpi_device *device)
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
@@ -1024,6 +1178,19 @@ static int sony_nc_add(struct acpi_device *device)
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
@@ -1063,9 +1230,6 @@ static int sony_nc_add(struct acpi_device *device)
 
 	}
 
-	/* initialize models with specific requirements */
-	dmi_check_system(sony_nc_ids);
-
 	result = sony_pf_add();
 	if (result)
 		goto outbacklight;
@@ -1131,6 +1295,7 @@ static int sony_nc_add(struct acpi_device *device)
 	sony_laptop_remove_input();
 
       outwalk:
+	sony_nc_rfkill_cleanup();
 	return result;
 }
 
@@ -1156,6 +1321,7 @@ static int sony_nc_remove(struct acpi_device *device, int type)
 
 	sony_pf_remove();
 	sony_laptop_remove_input();
+	sony_nc_rfkill_cleanup();
 	dprintk(SONY_NC_DRIVER_NAME " removed.\n");
 
 	return 0;


-- 
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--k+w/mQv8wyuph6w0
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="sony-laptop.c-speed-stamina-latest.patch"

--- sony-laptop.c-2.6.29-rc8-matthew5	2009-03-23 17:31:19.000000000 +0100
+++ sony-laptop.c	2009-03-23 17:32:29.000000000 +0100
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2004-2005 Stelian Pop <stelian@popies.net>
  * Copyright (C) 2007 Mattia Dongili <malattia@linux.it>
+ * Copyright (C) 2009 Matthias Welwarsky <matze@welwarsky.de>
  *
  * Parts of this driver inspired from asus_acpi.c and ibm_acpi.c
  * which are copyrighted by their respective authors.
@@ -115,6 +116,11 @@
 		 "set this to 1 to enable Motion Eye camera controls "
 		 "(only use it if you have a C1VE or C1VN model)");
 
+static int speed_stamina;
+module_param(speed_stamina, int, 0444);
+MODULE_PARM_DESC(speed_stamina,
+                 "Set this to 1 to enable SPEED mode on module load (EXPERIMENTAL)");
+
 #ifdef CONFIG_SONYPI_COMPAT
 static int minor = -1;
 module_param(minor, int, 0);
@@ -475,9 +481,161 @@
 }
 
 /*********** Platform Device ***********/
+static int sony_ovga_dsm(int func, int arg)
+{
+        static char *path = "\\_SB.PCI0.OVGA._DSM";
+	static char muid[] = {
+		/*00*/	0xA0, 0xA0, 0x95, 0x9D, 0x60, 0x00, 0x48, 0x4D,		/* MUID */
+		/*08*/	0xB3, 0x4D, 0x7E, 0x5F, 0xEA, 0x12, 0x9F, 0xD4,
+	};
+
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_object_list input;
+	union acpi_object params[4];
+	int result;
+
+	input.count = 4;
+	input.pointer = params;
+	params[0].type = ACPI_TYPE_BUFFER;
+	params[0].buffer.length = sizeof(muid);
+	params[0].buffer.pointer = (char*)muid;
+	params[1].type = ACPI_TYPE_INTEGER;
+	params[1].integer.value = 0x00000102;
+	params[2].type = ACPI_TYPE_INTEGER;
+	params[2].integer.value = func;
+	params[3].type = ACPI_TYPE_INTEGER;
+	params[3].integer.value = arg;
+
+	result = acpi_evaluate_object(NULL, (char*)path, &input, &output);
+	if (result) {
+		printk("%s failed: %d\n", path, result);
+		return -1;
+	}
+
+#ifdef DEBUG
+	{
+		union acpi_object *obj = (union acpi_object*)output.pointer;
+		if (obj->type == ACPI_TYPE_PACKAGE) {
+			int i;
+			printk("returned package sized %d\n", obj->package.count);
+			for (i = 0; i < obj->package.count; i++)
+				printk("%d %08x\n", i, obj->package.elements[i].integer.value);
+		} else
+		if (obj->type == ACPI_TYPE_INTEGER) {
+			printk("returned integer %08X\n", obj->integer.value);
+		} else
+		if (obj->type == ACPI_TYPE_BUFFER) {
+			int i;
+			printk("returned buffer sized %d\n", obj->buffer.length);
+			for (i = 0; i < obj->buffer.length; i++)
+				printk("%d %02x\n", i, obj->buffer.pointer[i]);
+		}
+	}
+#endif
+	kfree(output.pointer);
+	return 0;
+}
+
+static int sony_led_stamina(void)
+{
+	return sony_ovga_dsm(2, 0x11);
+}
+
+static int sony_led_speed(void)
+{
+	return sony_ovga_dsm(2, 0x12);
+}
+
+#ifdef DEBUG
+static int sony_led_off(void)
+{
+	return sony_ovga_dsm(2, 0x13);
+}
+
+static int sony_dgpu_sta(void)
+{
+	return sony_ovga_dsm(3, 0x00);
+}
+#endif
+
+static int sony_dgpu_off(void)
+{
+	return sony_ovga_dsm(3, 0x02);
+}
+
+static int sony_dgpu_on(void)
+{
+	return sony_ovga_dsm(3, 0x01);
+}
+
+static ssize_t sony_pf_store_speed_stamina(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buffer, size_t count)
+{
+	if (!strncmp(buffer, "speed", strlen("speed"))) {
+		sony_dgpu_on();
+		sony_led_speed();
+		speed_stamina = 1;
+	} else
+	if (!strncmp(buffer, "stamina", strlen("stamina"))) {
+		sony_dgpu_off();
+		sony_led_stamina();
+		speed_stamina = 0;
+	} else
+		return -EINVAL;
+
+	return count;
+}
+
+static ssize_t sony_pf_show_speed_stamina(struct device *dev,
+		struct device_attribute *attr, char *buffer)
+{
+	return snprintf(buffer, PAGE_SIZE, "%s\n", speed_stamina ? "speed":"stamina");
+}
+
+static struct device_attribute sony_pf_speed_stamina_attr =
+	__ATTR(speed_stamina, S_IWUSR|S_IRUGO,
+		sony_pf_show_speed_stamina, sony_pf_store_speed_stamina);
+
+static int sony_pf_probe(struct platform_device *pdev)
+{
+	int result;
+
+	result = device_create_file(&pdev->dev, &sony_pf_speed_stamina_attr);
+	if (result)
+		printk(KERN_DEBUG "sony_pf_probe: failed to add speed/stamina switch\n");
+
+	/* initialize default, look at module param speed_stamina */
+	if (speed_stamina == 1) {
+		sony_dgpu_on();
+		sony_led_speed();
+	} else {
+		sony_dgpu_off();
+		sony_led_stamina();
+	}
+
+	return 0;
+}
+
+static int sony_pf_resume(struct platform_device *pdev)
+{
+	/* on resume, restore previous state */
+	if (speed_stamina == 1) {
+		sony_dgpu_on();
+		sony_led_speed();
+	} else {
+		sony_dgpu_off();
+		sony_led_stamina();
+	}
+	return 0;
+}
 
 static atomic_t sony_pf_users = ATOMIC_INIT(0);
 static struct platform_driver sony_pf_driver = {
+	.probe  = sony_pf_probe,
+#ifdef CONFIG_PM
+	.resume_early = sony_pf_resume,
+#endif
 	.driver = {
 		   .name = "sony-laptop",
 		   .owner = THIS_MODULE,

--k+w/mQv8wyuph6w0--
