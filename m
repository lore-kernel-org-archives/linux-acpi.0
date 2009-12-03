From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 24/33] eeepc-laptop: revise names
Date: Thu,  3 Dec 2009 08:45:08 +0100
Message-ID: <1259826317-18809-25-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-5-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-6-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-7-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-8-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-9-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-10-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-11-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-12-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-13-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-14-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-15-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-16-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-17-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-18-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-19-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-20-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-21-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-22-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-23-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-24-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44224 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754367AbZLCHoi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:38 -0500
In-Reply-To: <1259826317-18809-24-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

eeepc-laptop now does a lot more than just hotkeys.  Replace the "hotk"
names used throughout the driver with some slightly more appropriate
names.  The actual strings used in kernel messages and sysfs are left
unchanged.

e.g.
	EEEPC_HOTK_FILE  -> EEEPC_LAPTOP_FILE
	EEEPC_HOTK_HID   -> EEEPC_ACPI_HID

	eeepc_hotk_notify -> eeepc_acpi_notify
	struct eeepc_hotk -> struct eeepc_laptop
	ehotk             -> eeepc

I'm about to refactor the entire driver to remove the global "ehotk"
variable, and I don't wish to add "struct eeepc_hotk *ehotk" to
functions which have nothing to do with hotkeys.

Also
 - fix the name of "eepc_get_entry_by_keycode()"
 - remove the unused definition of NOTIFY_WLAN_ON.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/platform/x86/eeepc-laptop.c |  253 +++++++++++++++++------------------
 1 files changed, 125 insertions(+), 128 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index f457587..b9b5aeb 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1,5 +1,5 @@
 /*
- *  eepc-laptop.c - Asus Eee PC extras
+ *  eeepc-laptop.c - Asus Eee PC extras
  *
  *  Based on asus_acpi.c as patched for the Eee PC by Asus:
  *  ftp://ftp.asus.com/pub/ASUS/EeePC/701/ASUS_ACPI_071126.rar
@@ -37,21 +37,20 @@
 #include <linux/leds.h>
 
 #define EEEPC_LAPTOP_VERSION	"0.1"
+#define EEEPC_LAPTOP_NAME	"Eee PC Hotkey Driver"
+#define EEEPC_LAPTOP_FILE	"eeepc"
 
-#define EEEPC_HOTK_NAME		"Eee PC Hotkey Driver"
-#define EEEPC_HOTK_FILE		"eeepc"
-#define EEEPC_HOTK_CLASS	"hotkey"
-#define EEEPC_HOTK_DEVICE_NAME	"Hotkey"
-#define EEEPC_HOTK_HID		"ASUS010"
+#define EEEPC_ACPI_CLASS	"hotkey"
+#define EEEPC_ACPI_DEVICE_NAME	"Hotkey"
+#define EEEPC_ACPI_HID		"ASUS010"
 
 MODULE_AUTHOR("Corentin Chary, Eric Cooper");
-MODULE_DESCRIPTION(EEEPC_HOTK_NAME);
+MODULE_DESCRIPTION(EEEPC_LAPTOP_NAME);
 MODULE_LICENSE("GPL");
 
 /*
  * Definitions for Asus EeePC
  */
-#define	NOTIFY_WLAN_ON	0x10
 #define NOTIFY_BRN_MIN	0x20
 #define NOTIFY_BRN_MAX	0x2f
 
@@ -152,9 +151,8 @@ static struct key_entry eeepc_keymap[] = {
 
 /*
  * This is the main structure, we can use it to store useful information
- * about the hotk device
  */
-struct eeepc_hotk {
+struct eeepc_laptop {
 	struct acpi_device *device;	/* the device we are in */
 	acpi_handle handle;		/* the handle of the hotk device */
 	u32 cm_supported;		/* the control methods supported
@@ -171,7 +169,7 @@ struct eeepc_hotk {
 };
 
 /* The actual device the driver binds to */
-static struct eeepc_hotk *ehotk;
+static struct eeepc_laptop *eeepc;
 
 /* The platform device */
 static struct platform_device *platform_device;
@@ -222,10 +220,10 @@ static int set_acpi(int cm, int value)
 
 	if (method == NULL)
 		return -ENODEV;
-	if ((ehotk->cm_supported & (0x1 << cm)) == 0)
+	if ((eeepc->cm_supported & (0x1 << cm)) == 0)
 		return -ENODEV;
 
-	if (write_acpi_int(ehotk->handle, method, value))
+	if (write_acpi_int(eeepc->handle, method, value))
 		pr_warning("Error writing %s\n", method);
 	return 0;
 }
@@ -237,10 +235,10 @@ static int get_acpi(int cm)
 
 	if (method == NULL)
 		return -ENODEV;
-	if ((ehotk->cm_supported & (0x1 << cm)) == 0)
+	if ((eeepc->cm_supported & (0x1 << cm)) == 0)
 		return -ENODEV;
 
-	if (read_acpi_int(ehotk->handle, method, &value))
+	if (read_acpi_int(eeepc->handle, method, &value))
 		pr_warning("Error reading %s\n", method);
 	return value;
 }
@@ -395,7 +393,7 @@ static int eeepc_platform_init(void)
 {
 	int result;
 
-	platform_device = platform_device_alloc(EEEPC_HOTK_FILE, -1);
+	platform_device = platform_device_alloc(EEEPC_LAPTOP_FILE, -1);
 	if (!platform_device)
 		return -ENOMEM;
 
@@ -501,12 +499,12 @@ static void eeepc_rfkill_hotplug(void)
 	struct pci_bus *bus;
 	bool blocked = eeepc_wlan_rfkill_blocked();
 
-	if (ehotk->wlan_rfkill)
-		rfkill_set_sw_state(ehotk->wlan_rfkill, blocked);
+	if (eeepc->wlan_rfkill)
+		rfkill_set_sw_state(eeepc->wlan_rfkill, blocked);
 
-	mutex_lock(&ehotk->hotplug_lock);
+	mutex_lock(&eeepc->hotplug_lock);
 
-	if (ehotk->hotplug_slot) {
+	if (eeepc->hotplug_slot) {
 		bus = pci_find_bus(0, 1);
 		if (!bus) {
 			pr_warning("Unable to find PCI bus 1?\n");
@@ -536,7 +534,7 @@ static void eeepc_rfkill_hotplug(void)
 	}
 
 out_unlock:
-	mutex_unlock(&ehotk->hotplug_lock);
+	mutex_unlock(&eeepc->hotplug_lock);
 }
 
 static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
@@ -619,22 +617,22 @@ static int eeepc_setup_pci_hotplug(void)
 		return -ENODEV;
 	}
 
-	ehotk->hotplug_slot = kzalloc(sizeof(struct hotplug_slot), GFP_KERNEL);
-	if (!ehotk->hotplug_slot)
+	eeepc->hotplug_slot = kzalloc(sizeof(struct hotplug_slot), GFP_KERNEL);
+	if (!eeepc->hotplug_slot)
 		goto error_slot;
 
-	ehotk->hotplug_slot->info = kzalloc(sizeof(struct hotplug_slot_info),
+	eeepc->hotplug_slot->info = kzalloc(sizeof(struct hotplug_slot_info),
 					    GFP_KERNEL);
-	if (!ehotk->hotplug_slot->info)
+	if (!eeepc->hotplug_slot->info)
 		goto error_info;
 
-	ehotk->hotplug_slot->private = ehotk;
-	ehotk->hotplug_slot->release = &eeepc_cleanup_pci_hotplug;
-	ehotk->hotplug_slot->ops = &eeepc_hotplug_slot_ops;
-	eeepc_get_adapter_status(ehotk->hotplug_slot,
-				 &ehotk->hotplug_slot->info->adapter_status);
+	eeepc->hotplug_slot->private = eeepc;
+	eeepc->hotplug_slot->release = &eeepc_cleanup_pci_hotplug;
+	eeepc->hotplug_slot->ops = &eeepc_hotplug_slot_ops;
+	eeepc_get_adapter_status(eeepc->hotplug_slot,
+				 &eeepc->hotplug_slot->info->adapter_status);
 
-	ret = pci_hp_register(ehotk->hotplug_slot, bus, 0, "eeepc-wifi");
+	ret = pci_hp_register(eeepc->hotplug_slot, bus, 0, "eeepc-wifi");
 	if (ret) {
 		pr_err("Unable to register hotplug slot - %d\n", ret);
 		goto error_register;
@@ -643,10 +641,10 @@ static int eeepc_setup_pci_hotplug(void)
 	return 0;
 
 error_register:
-	kfree(ehotk->hotplug_slot->info);
+	kfree(eeepc->hotplug_slot->info);
 error_info:
-	kfree(ehotk->hotplug_slot);
-	ehotk->hotplug_slot = NULL;
+	kfree(eeepc->hotplug_slot);
+	eeepc->hotplug_slot = NULL;
 error_slot:
 	return ret;
 }
@@ -695,33 +693,33 @@ static void eeepc_rfkill_exit(void)
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P5");
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
-	if (ehotk->wlan_rfkill) {
-		rfkill_unregister(ehotk->wlan_rfkill);
-		rfkill_destroy(ehotk->wlan_rfkill);
-		ehotk->wlan_rfkill = NULL;
+	if (eeepc->wlan_rfkill) {
+		rfkill_unregister(eeepc->wlan_rfkill);
+		rfkill_destroy(eeepc->wlan_rfkill);
+		eeepc->wlan_rfkill = NULL;
 	}
 	/*
 	 * Refresh pci hotplug in case the rfkill state was changed after
 	 * eeepc_unregister_rfkill_notifier()
 	 */
 	eeepc_rfkill_hotplug();
-	if (ehotk->hotplug_slot)
-		pci_hp_deregister(ehotk->hotplug_slot);
+	if (eeepc->hotplug_slot)
+		pci_hp_deregister(eeepc->hotplug_slot);
 
-	if (ehotk->bluetooth_rfkill) {
-		rfkill_unregister(ehotk->bluetooth_rfkill);
-		rfkill_destroy(ehotk->bluetooth_rfkill);
-		ehotk->bluetooth_rfkill = NULL;
+	if (eeepc->bluetooth_rfkill) {
+		rfkill_unregister(eeepc->bluetooth_rfkill);
+		rfkill_destroy(eeepc->bluetooth_rfkill);
+		eeepc->bluetooth_rfkill = NULL;
 	}
-	if (ehotk->wwan3g_rfkill) {
-		rfkill_unregister(ehotk->wwan3g_rfkill);
-		rfkill_destroy(ehotk->wwan3g_rfkill);
-		ehotk->wwan3g_rfkill = NULL;
+	if (eeepc->wwan3g_rfkill) {
+		rfkill_unregister(eeepc->wwan3g_rfkill);
+		rfkill_destroy(eeepc->wwan3g_rfkill);
+		eeepc->wwan3g_rfkill = NULL;
 	}
-	if (ehotk->wimax_rfkill) {
-		rfkill_unregister(ehotk->wimax_rfkill);
-		rfkill_destroy(ehotk->wimax_rfkill);
-		ehotk->wimax_rfkill = NULL;
+	if (eeepc->wimax_rfkill) {
+		rfkill_unregister(eeepc->wimax_rfkill);
+		rfkill_destroy(eeepc->wimax_rfkill);
+		eeepc->wimax_rfkill = NULL;
 	}
 }
 
@@ -729,30 +727,30 @@ static int eeepc_rfkill_init(struct device *dev)
 {
 	int result = 0;
 
-	mutex_init(&ehotk->hotplug_lock);
+	mutex_init(&eeepc->hotplug_lock);
 
-	result = eeepc_new_rfkill(&ehotk->wlan_rfkill,
+	result = eeepc_new_rfkill(&eeepc->wlan_rfkill,
 				  "eeepc-wlan", dev,
 				  RFKILL_TYPE_WLAN, CM_ASL_WLAN);
 
 	if (result && result != -ENODEV)
 		goto exit;
 
-	result = eeepc_new_rfkill(&ehotk->bluetooth_rfkill,
+	result = eeepc_new_rfkill(&eeepc->bluetooth_rfkill,
 				  "eeepc-bluetooth", dev,
 				  RFKILL_TYPE_BLUETOOTH, CM_ASL_BLUETOOTH);
 
 	if (result && result != -ENODEV)
 		goto exit;
 
-	result = eeepc_new_rfkill(&ehotk->wwan3g_rfkill,
+	result = eeepc_new_rfkill(&eeepc->wwan3g_rfkill,
 				  "eeepc-wwan3g", dev,
 				  RFKILL_TYPE_WWAN, CM_ASL_3G);
 
 	if (result && result != -ENODEV)
 		goto exit;
 
-	result = eeepc_new_rfkill(&ehotk->wimax_rfkill,
+	result = eeepc_new_rfkill(&eeepc->wimax_rfkill,
 				  "eeepc-wimax", dev,
 				  RFKILL_TYPE_WIMAX, CM_ASL_WIMAX);
 
@@ -785,9 +783,9 @@ exit:
 /*
  * Platform driver - hibernate/resume callbacks
  */
-static int eeepc_hotk_thaw(struct device *device)
+static int eeepc_thaw(struct device *device)
 {
-	if (ehotk->wlan_rfkill) {
+	if (eeepc->wlan_rfkill) {
 		bool wlan;
 
 		/*
@@ -802,33 +800,33 @@ static int eeepc_hotk_thaw(struct device *device)
 	return 0;
 }
 
-static int eeepc_hotk_restore(struct device *device)
+static int eeepc_restore(struct device *device)
 {
 	/* Refresh both wlan rfkill state and pci hotplug */
-	if (ehotk->wlan_rfkill)
+	if (eeepc->wlan_rfkill)
 		eeepc_rfkill_hotplug();
 
-	if (ehotk->bluetooth_rfkill)
-		rfkill_set_sw_state(ehotk->bluetooth_rfkill,
+	if (eeepc->bluetooth_rfkill)
+		rfkill_set_sw_state(eeepc->bluetooth_rfkill,
 				    get_acpi(CM_ASL_BLUETOOTH) != 1);
-	if (ehotk->wwan3g_rfkill)
-		rfkill_set_sw_state(ehotk->wwan3g_rfkill,
+	if (eeepc->wwan3g_rfkill)
+		rfkill_set_sw_state(eeepc->wwan3g_rfkill,
 				    get_acpi(CM_ASL_3G) != 1);
-	if (ehotk->wimax_rfkill)
-		rfkill_set_sw_state(ehotk->wimax_rfkill,
+	if (eeepc->wimax_rfkill)
+		rfkill_set_sw_state(eeepc->wimax_rfkill,
 				    get_acpi(CM_ASL_WIMAX) != 1);
 
 	return 0;
 }
 
 static struct dev_pm_ops eeepc_pm_ops = {
-	.thaw = eeepc_hotk_thaw,
-	.restore = eeepc_hotk_restore,
+	.thaw = eeepc_thaw,
+	.restore = eeepc_restore,
 };
 
 static struct platform_driver platform_driver = {
 	.driver = {
-		.name = EEEPC_HOTK_FILE,
+		.name = EEEPC_LAPTOP_FILE,
 		.owner = THIS_MODULE,
 		.pm = &eeepc_pm_ops,
 	}
@@ -1018,7 +1016,7 @@ static int eeepc_backlight_init(struct device *dev)
 {
 	struct backlight_device *bd;
 
-	bd = backlight_device_register(EEEPC_HOTK_FILE, dev,
+	bd = backlight_device_register(EEEPC_LAPTOP_FILE, dev,
 				       NULL, &eeepcbl_ops);
 	if (IS_ERR(bd)) {
 		pr_err("Could not register eeepc backlight device\n");
@@ -1063,12 +1061,12 @@ static void eeepc_input_notify(int event)
 	if (key) {
 		switch (key->type) {
 		case KE_KEY:
-			input_report_key(ehotk->inputdev, key->keycode,
+			input_report_key(eeepc->inputdev, key->keycode,
 						1);
-			input_sync(ehotk->inputdev);
-			input_report_key(ehotk->inputdev, key->keycode,
+			input_sync(eeepc->inputdev);
+			input_report_key(eeepc->inputdev, key->keycode,
 						0);
-			input_sync(ehotk->inputdev);
+			input_sync(eeepc->inputdev);
 			break;
 		}
 	}
@@ -1123,30 +1121,30 @@ static int eeepc_input_init(struct device *dev)
 	const struct key_entry *key;
 	int result;
 
-	ehotk->inputdev = input_allocate_device();
-	if (!ehotk->inputdev) {
+	eeepc->inputdev = input_allocate_device();
+	if (!eeepc->inputdev) {
 		pr_info("Unable to allocate input device\n");
 		return -ENOMEM;
 	}
-	ehotk->inputdev->name = "Asus EeePC extra buttons";
-	ehotk->inputdev->dev.parent = dev;
-	ehotk->inputdev->phys = EEEPC_HOTK_FILE "/input0";
-	ehotk->inputdev->id.bustype = BUS_HOST;
-	ehotk->inputdev->getkeycode = eeepc_getkeycode;
-	ehotk->inputdev->setkeycode = eeepc_setkeycode;
+	eeepc->inputdev->name = "Asus EeePC extra buttons";
+	eeepc->inputdev->dev.parent = dev;
+	eeepc->inputdev->phys = EEEPC_LAPTOP_FILE "/input0";
+	eeepc->inputdev->id.bustype = BUS_HOST;
+	eeepc->inputdev->getkeycode = eeepc_getkeycode;
+	eeepc->inputdev->setkeycode = eeepc_setkeycode;
 
 	for (key = eeepc_keymap; key->type != KE_END; key++) {
 		switch (key->type) {
 		case KE_KEY:
-			set_bit(EV_KEY, ehotk->inputdev->evbit);
-			set_bit(key->keycode, ehotk->inputdev->keybit);
+			set_bit(EV_KEY, eeepc->inputdev->evbit);
+			set_bit(key->keycode, eeepc->inputdev->keybit);
 			break;
 		}
 	}
-	result = input_register_device(ehotk->inputdev);
+	result = input_register_device(eeepc->inputdev);
 	if (result) {
 		pr_info("Unable to register input device\n");
-		input_free_device(ehotk->inputdev);
+		input_free_device(eeepc->inputdev);
 		return result;
 	}
 	return 0;
@@ -1154,23 +1152,23 @@ static int eeepc_input_init(struct device *dev)
 
 static void eeepc_input_exit(void)
 {
-	if (ehotk->inputdev)
-		input_unregister_device(ehotk->inputdev);
+	if (eeepc->inputdev)
+		input_unregister_device(eeepc->inputdev);
 }
 
 /*
  * ACPI driver
  */
-static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
+static void eeepc_acpi_notify(struct acpi_device *device, u32 event)
 {
 	u16 count;
 
 	if (event > ACPI_MAX_SYS_NOTIFY)
 		return;
-	count = ehotk->event_count[event % 128]++;
-	acpi_bus_generate_proc_event(ehotk->device, event, count);
-	acpi_bus_generate_netlink_event(ehotk->device->pnp.device_class,
-					dev_name(&ehotk->device->dev), event,
+	count = eeepc->event_count[event % 128]++;
+	acpi_bus_generate_proc_event(eeepc->device, event, count);
+	acpi_bus_generate_netlink_event(eeepc->device->pnp.device_class,
+					dev_name(&eeepc->device->dev), event,
 					count);
 
 	if (event >= NOTIFY_BRN_MIN && event <= NOTIFY_BRN_MAX) {
@@ -1202,11 +1200,11 @@ static void cmsg_quirk(int cm, const char *name)
 
 	/* Some BIOSes do not report cm although it is avaliable.
 	   Check if cm_getv[cm] works and, if yes, assume cm should be set. */
-	if (!(ehotk->cm_supported & (1 << cm))
-	    && !read_acpi_int(ehotk->handle, cm_getv[cm], &dummy)) {
+	if (!(eeepc->cm_supported & (1 << cm))
+	    && !read_acpi_int(eeepc->handle, cm_getv[cm], &dummy)) {
 		pr_info("%s (%x) not reported by BIOS,"
 			" enabling anyway\n", name, 1 << cm);
-		ehotk->cm_supported |= 1 << cm;
+		eeepc->cm_supported |= 1 << cm;
 	}
 }
 
@@ -1218,15 +1216,15 @@ static void cmsg_quirks(void)
 	cmsg_quirk(CM_ASL_TPD, "TPD");
 }
 
-static int eeepc_hotk_init(void)
+static int eeepc_acpi_init(void)
 {
 	unsigned int init_flags;
 	int result;
 
-	result = acpi_bus_get_status(ehotk->device);
+	result = acpi_bus_get_status(eeepc->device);
 	if (result)
 		return result;
-	if (!ehotk->device->status.present) {
+	if (!eeepc->device->status.present) {
 		pr_err("Hotkey device not present, aborting\n");
 		return -ENODEV;
 	}
@@ -1234,18 +1232,18 @@ static int eeepc_hotk_init(void)
 	init_flags = DISABLE_ASL_WLAN | DISABLE_ASL_DISPLAYSWITCH;
 	pr_notice("Hotkey init flags 0x%x\n", init_flags);
 
-	if (write_acpi_int(ehotk->handle, "INIT", init_flags)) {
+	if (write_acpi_int(eeepc->handle, "INIT", init_flags)) {
 		pr_err("Hotkey initialization failed\n");
 		return -ENODEV;
 	}
 
 	/* get control methods supported */
-	if (read_acpi_int(ehotk->handle, "CMSG", &ehotk->cm_supported)) {
+	if (read_acpi_int(eeepc->handle, "CMSG", &eeepc->cm_supported)) {
 		pr_err("Get control methods supported failed\n");
 		return -ENODEV;
 	}
 	cmsg_quirks();
-	pr_info("Get control methods supported: 0x%x\n", ehotk->cm_supported);
+	pr_info("Get control methods supported: 0x%x\n", eeepc->cm_supported);
 
 	return 0;
 }
@@ -1260,22 +1258,22 @@ static void __devinit eeepc_enable_camera(void)
 		set_acpi(CM_ASL_CAMERA, 1);
 }
 
-static int __devinit eeepc_hotk_add(struct acpi_device *device)
+static int __devinit eeepc_acpi_add(struct acpi_device *device)
 {
 	struct device *dev;
 	int result;
 
-	pr_notice(EEEPC_HOTK_NAME "\n");
-	ehotk = kzalloc(sizeof(struct eeepc_hotk), GFP_KERNEL);
-	if (!ehotk)
+	pr_notice(EEEPC_LAPTOP_NAME "\n");
+	eeepc = kzalloc(sizeof(struct eeepc_laptop), GFP_KERNEL);
+	if (!eeepc)
 		return -ENOMEM;
-	ehotk->handle = device->handle;
-	strcpy(acpi_device_name(device), EEEPC_HOTK_DEVICE_NAME);
-	strcpy(acpi_device_class(device), EEEPC_HOTK_CLASS);
-	device->driver_data = ehotk;
-	ehotk->device = device;
+	eeepc->handle = device->handle;
+	strcpy(acpi_device_name(device), EEEPC_ACPI_DEVICE_NAME);
+	strcpy(acpi_device_class(device), EEEPC_ACPI_CLASS);
+	device->driver_data = eeepc;
+	eeepc->device = device;
 
-	result = eeepc_hotk_init();
+	result = eeepc_acpi_init();
 	if (result)
 		goto fail_platform;
 	eeepc_enable_camera();
@@ -1283,7 +1281,6 @@ static int __devinit eeepc_hotk_add(struct acpi_device *device)
 	result = eeepc_platform_init();
 	if (result)
 		goto fail_platform;
-
 	dev = &platform_device->dev;
 
 	if (!acpi_video_backlight_support()) {
@@ -1322,12 +1319,12 @@ fail_input:
 fail_backlight:
 	eeepc_platform_exit();
 fail_platform:
-	kfree(ehotk);
+	kfree(eeepc);
 
 	return result;
 }
 
-static int eeepc_hotk_remove(struct acpi_device *device, int type)
+static int eeepc_acpi_remove(struct acpi_device *device, int type)
 {
 	eeepc_backlight_exit();
 	eeepc_rfkill_exit();
@@ -1336,27 +1333,27 @@ static int eeepc_hotk_remove(struct acpi_device *device, int type)
 	eeepc_led_exit();
 	eeepc_platform_exit();
 
-	kfree(ehotk);
+	kfree(eeepc);
 	return 0;
 }
 
 
 static const struct acpi_device_id eeepc_device_ids[] = {
-	{EEEPC_HOTK_HID, 0},
+	{EEEPC_ACPI_HID, 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, eeepc_device_ids);
 
-static struct acpi_driver eeepc_hotk_driver = {
-	.name = EEEPC_HOTK_NAME,
-	.class = EEEPC_HOTK_CLASS,
+static struct acpi_driver eeepc_acpi_driver = {
+	.name = EEEPC_LAPTOP_NAME,
+	.class = EEEPC_ACPI_CLASS,
 	.owner = THIS_MODULE,
 	.ids = eeepc_device_ids,
 	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
-		.add = eeepc_hotk_add,
-		.remove = eeepc_hotk_remove,
-		.notify = eeepc_hotk_notify,
+		.add = eeepc_acpi_add,
+		.remove = eeepc_acpi_remove,
+		.notify = eeepc_acpi_notify,
 	},
 };
 
@@ -1369,17 +1366,17 @@ static int __init eeepc_laptop_init(void)
 	if (result < 0)
 		return result;
 
-	result = acpi_bus_register_driver(&eeepc_hotk_driver);
+	result = acpi_bus_register_driver(&eeepc_acpi_driver);
 	if (result < 0)
 		goto fail_acpi_driver;
-	if (!ehotk) {
+	if (!eeepc) {
 		result = -ENODEV;
 		goto fail_no_device;
 	}
 	return 0;
 
 fail_no_device:
-	acpi_bus_unregister_driver(&eeepc_hotk_driver);
+	acpi_bus_unregister_driver(&eeepc_acpi_driver);
 fail_acpi_driver:
 	platform_driver_unregister(&platform_driver);
 	return result;
@@ -1387,7 +1384,7 @@ fail_acpi_driver:
 
 static void __exit eeepc_laptop_exit(void)
 {
-	acpi_bus_unregister_driver(&eeepc_hotk_driver);
+	acpi_bus_unregister_driver(&eeepc_acpi_driver);
 	platform_driver_unregister(&platform_driver);
 }
 
-- 
1.6.5.3

