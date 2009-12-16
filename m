From: Len Brown <lenb@kernel.org>
Subject: [PATCH 040/103] eeepc-laptop: code movement
Date: Wed, 16 Dec 2009 03:35:51 -0500
Message-ID: <52bbe3c7b413d656833686f9f08e5dcab3786eeb.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47186 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761997AbZLPLF5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:05:57 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:05:53 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Move e.g. backlight_init() and backlight_exit() together along with the
other backlight functions, instead of grouping init() and exit()
functions.  Move e.g. backlight_ops to follow the functions it refers
to, and remove the forward declarations.  The code itself should remain
unchanged.

The eeepc-laptop driver implements a number of interfaces like the
backlight class driver.  This change makes it easier to examine the
implementation of one interface at at a time, without having to search
through the file to find init() and exit() functions etc.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |  934 +++++++++++++++++------------------
 1 files changed, 462 insertions(+), 472 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index f4f6796..f457587 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -44,6 +44,9 @@
 #define EEEPC_HOTK_DEVICE_NAME	"Hotkey"
 #define EEEPC_HOTK_HID		"ASUS010"
 
+MODULE_AUTHOR("Corentin Chary, Eric Cooper");
+MODULE_DESCRIPTION(EEEPC_HOTK_NAME);
+MODULE_LICENSE("GPL");
 
 /*
  * Definitions for Asus EeePC
@@ -118,57 +121,6 @@ static const char *cm_setv[] = {
 	NULL, NULL, "PBPS", "TPDS"
 };
 
-#define EEEPC_EC_SC00      0x61
-#define EEEPC_EC_FAN_PWM   (EEEPC_EC_SC00 + 2) /* Fan PWM duty cycle (%) */
-#define EEEPC_EC_FAN_HRPM  (EEEPC_EC_SC00 + 5) /* High byte, fan speed (RPM) */
-#define EEEPC_EC_FAN_LRPM  (EEEPC_EC_SC00 + 6) /* Low byte, fan speed (RPM) */
-
-#define EEEPC_EC_SFB0      0xD0
-#define EEEPC_EC_FAN_CTRL  (EEEPC_EC_SFB0 + 3) /* Byte containing SF25  */
-
-
-/*
- * This is the main structure, we can use it to store useful information
- * about the hotk device
- */
-struct eeepc_hotk {
-	struct acpi_device *device;	/* the device we are in */
-	acpi_handle handle;		/* the handle of the hotk device */
-	u32 cm_supported;		/* the control methods supported
-					   by this BIOS */
-	u16 event_count[128];		/* count for each event */
-	struct input_dev *inputdev;
-	u16 *keycode_map;
-	struct rfkill *wlan_rfkill;
-	struct rfkill *bluetooth_rfkill;
-	struct rfkill *wwan3g_rfkill;
-	struct rfkill *wimax_rfkill;
-	struct hotplug_slot *hotplug_slot;
-	struct mutex hotplug_lock;
-};
-
-/* The actual device the driver binds to */
-static struct eeepc_hotk *ehotk;
-
-/* Platform device/driver */
-static int eeepc_hotk_thaw(struct device *device);
-static int eeepc_hotk_restore(struct device *device);
-
-static struct dev_pm_ops eeepc_pm_ops = {
-	.thaw = eeepc_hotk_thaw,
-	.restore = eeepc_hotk_restore,
-};
-
-static struct platform_driver platform_driver = {
-	.driver = {
-		.name = EEEPC_HOTK_FILE,
-		.owner = THIS_MODULE,
-		.pm = &eeepc_pm_ops,
-	}
-};
-
-static struct platform_device *platform_device;
-
 struct key_entry {
 	char type;
 	u8 code;
@@ -189,48 +141,40 @@ static struct key_entry eeepc_keymap[] = {
 	{KE_KEY, 0x1b, KEY_ZOOM },
 	{KE_KEY, 0x1c, KEY_PROG2 },
 	{KE_KEY, 0x1d, KEY_PROG3 },
-	{KE_KEY, NOTIFY_BRN_MIN,     KEY_BRIGHTNESSDOWN },
-	{KE_KEY, NOTIFY_BRN_MIN + 2, KEY_BRIGHTNESSUP },
+	{KE_KEY, NOTIFY_BRN_MIN, KEY_BRIGHTNESSDOWN },
+	{KE_KEY, NOTIFY_BRN_MAX, KEY_BRIGHTNESSUP },
 	{KE_KEY, 0x30, KEY_SWITCHVIDEOMODE },
 	{KE_KEY, 0x31, KEY_SWITCHVIDEOMODE },
 	{KE_KEY, 0x32, KEY_SWITCHVIDEOMODE },
 	{KE_END, 0},
 };
 
+
 /*
- * The hotkey driver declaration
+ * This is the main structure, we can use it to store useful information
+ * about the hotk device
  */
-static int eeepc_hotk_add(struct acpi_device *device);
-static int eeepc_hotk_remove(struct acpi_device *device, int type);
-static void eeepc_hotk_notify(struct acpi_device *device, u32 event);
-
-static const struct acpi_device_id eeepc_device_ids[] = {
-	{EEEPC_HOTK_HID, 0},
-	{"", 0},
-};
-MODULE_DEVICE_TABLE(acpi, eeepc_device_ids);
-
-static struct acpi_driver eeepc_hotk_driver = {
-	.name = EEEPC_HOTK_NAME,
-	.class = EEEPC_HOTK_CLASS,
-	.owner = THIS_MODULE,
-	.ids = eeepc_device_ids,
-	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
-	.ops = {
-		.add = eeepc_hotk_add,
-		.remove = eeepc_hotk_remove,
-		.notify = eeepc_hotk_notify,
-	},
+struct eeepc_hotk {
+	struct acpi_device *device;	/* the device we are in */
+	acpi_handle handle;		/* the handle of the hotk device */
+	u32 cm_supported;		/* the control methods supported
+					   by this BIOS */
+	u16 event_count[128];		/* count for each event */
+	struct input_dev *inputdev;
+	u16 *keycode_map;
+	struct rfkill *wlan_rfkill;
+	struct rfkill *bluetooth_rfkill;
+	struct rfkill *wwan3g_rfkill;
+	struct rfkill *wimax_rfkill;
+	struct hotplug_slot *hotplug_slot;
+	struct mutex hotplug_lock;
 };
 
-/* PCI hotplug ops */
-static int eeepc_get_adapter_status(struct hotplug_slot *slot, u8 *value);
+/* The actual device the driver binds to */
+static struct eeepc_hotk *ehotk;
 
-static struct hotplug_slot_ops eeepc_hotplug_slot_ops = {
-	.owner = THIS_MODULE,
-	.get_adapter_status = eeepc_get_adapter_status,
-	.get_power_status = eeepc_get_adapter_status,
-};
+/* The platform device */
+static struct platform_device *platform_device;
 
 /* The backlight device /sys/class/backlight */
 static struct backlight_device *eeepc_backlight_device;
@@ -238,19 +182,6 @@ static struct backlight_device *eeepc_backlight_device;
 /* The hwmon device */
 static struct device *eeepc_hwmon_device;
 
-/*
- * The backlight class declaration
- */
-static int read_brightness(struct backlight_device *bd);
-static int update_bl_status(struct backlight_device *bd);
-static struct backlight_ops eeepcbl_ops = {
-	.get_brightness = read_brightness,
-	.update_status = update_bl_status,
-};
-
-MODULE_AUTHOR("Corentin Chary, Eric Cooper");
-MODULE_DESCRIPTION(EEEPC_HOTK_NAME);
-MODULE_LICENSE("GPL");
 
 /*
  * ACPI Helpers
@@ -315,55 +246,6 @@ static int get_acpi(int cm)
 }
 
 /*
- * Backlight
- */
-static int read_brightness(struct backlight_device *bd)
-{
-	return get_acpi(CM_ASL_PANELBRIGHT);
-}
-
-static int set_brightness(struct backlight_device *bd, int value)
-{
-	return set_acpi(CM_ASL_PANELBRIGHT, value);
-}
-
-static int update_bl_status(struct backlight_device *bd)
-{
-	return set_brightness(bd, bd->props.brightness);
-}
-
-/*
- * Rfkill helpers
- */
-
-static bool eeepc_wlan_rfkill_blocked(void)
-{
-	if (get_acpi(CM_ASL_WLAN) == 1)
-		return false;
-	return true;
-}
-
-static int eeepc_rfkill_set(void *data, bool blocked)
-{
-	unsigned long asl = (unsigned long)data;
-	return set_acpi(asl, !blocked);
-}
-
-static const struct rfkill_ops eeepc_rfkill_ops = {
-	.set_block = eeepc_rfkill_set,
-};
-
-static void __devinit eeepc_enable_camera(void)
-{
-	/*
-	 * If the following call to set_acpi() fails, it's because there's no
-	 * camera so we can ignore the error.
-	 */
-	if (get_acpi(CM_ASL_CAMERA) == 0)
-		set_acpi(CM_ASL_CAMERA, 1);
-}
-
-/*
  * Sys helpers
  */
 static int parse_arg(const char *buf, unsigned long count, int *val)
@@ -574,140 +456,43 @@ static struct led_classdev tpd_led = {
 	.max_brightness = 1
 };
 
-/*
- * Hotkey functions
- */
-static struct key_entry *eepc_get_entry_by_scancode(int code)
-{
-	struct key_entry *key;
-
-	for (key = eeepc_keymap; key->type != KE_END; key++)
-		if (code == key->code)
-			return key;
-
-	return NULL;
-}
-
-static struct key_entry *eepc_get_entry_by_keycode(int code)
-{
-	struct key_entry *key;
-
-	for (key = eeepc_keymap; key->type != KE_END; key++)
-		if (code == key->keycode && key->type == KE_KEY)
-			return key;
-
-	return NULL;
-}
-
-static int eeepc_getkeycode(struct input_dev *dev, int scancode, int *keycode)
-{
-	struct key_entry *key = eepc_get_entry_by_scancode(scancode);
-
-	if (key && key->type == KE_KEY) {
-		*keycode = key->keycode;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static int eeepc_setkeycode(struct input_dev *dev, int scancode, int keycode)
+static int eeepc_led_init(struct device *dev)
 {
-	struct key_entry *key;
-	int old_keycode;
-
-	if (keycode < 0 || keycode > KEY_MAX)
-		return -EINVAL;
+	int rv;
 
-	key = eepc_get_entry_by_scancode(scancode);
-	if (key && key->type == KE_KEY) {
-		old_keycode = key->keycode;
-		key->keycode = keycode;
-		set_bit(keycode, dev->keybit);
-		if (!eepc_get_entry_by_keycode(old_keycode))
-			clear_bit(old_keycode, dev->keybit);
+	if (get_acpi(CM_ASL_TPD) == -ENODEV)
 		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static void cmsg_quirk(int cm, const char *name)
-{
-	int dummy;
-
-	/* Some BIOSes do not report cm although it is avaliable.
-	   Check if cm_getv[cm] works and, if yes, assume cm should be set. */
-	if (!(ehotk->cm_supported & (1 << cm))
-	    && !read_acpi_int(ehotk->handle, cm_getv[cm], &dummy)) {
-		pr_info("%s (%x) not reported by BIOS,"
-			" enabling anyway\n", name, 1 << cm);
-		ehotk->cm_supported |= 1 << cm;
-	}
-}
 
-static void cmsg_quirks(void)
-{
-	cmsg_quirk(CM_ASL_LID, "LID");
-	cmsg_quirk(CM_ASL_TYPE, "TYPE");
-	cmsg_quirk(CM_ASL_PANELPOWER, "PANELPOWER");
-	cmsg_quirk(CM_ASL_TPD, "TPD");
-}
-
-static int eeepc_hotk_init(void)
-{
-	unsigned int init_flags;
-	int result;
-
-	result = acpi_bus_get_status(ehotk->device);
-	if (result)
-		return result;
-	if (!ehotk->device->status.present) {
-		pr_err("Hotkey device not present, aborting\n");
-		return -ENODEV;
-	}
-
-	init_flags = DISABLE_ASL_WLAN | DISABLE_ASL_DISPLAYSWITCH;
-	pr_notice("Hotkey init flags 0x%x\n", init_flags);
-
-	if (write_acpi_int(ehotk->handle, "INIT", init_flags)) {
-		pr_err("Hotkey initialization failed\n");
-		return -ENODEV;
-	}
+	led_workqueue = create_singlethread_workqueue("led_workqueue");
+	if (!led_workqueue)
+		return -ENOMEM;
 
-	/* get control methods supported */
-	if (read_acpi_int(ehotk->handle, "CMSG",
-				&ehotk->cm_supported)) {
-		pr_err("Get control methods supported failed\n");
-		return -ENODEV;
+	rv = led_classdev_register(dev, &tpd_led);
+	if (rv) {
+		destroy_workqueue(led_workqueue);
+		return rv;
 	}
-	cmsg_quirks();
-	pr_info("Get control methods supported: 0x%x\n", ehotk->cm_supported);
 
 	return 0;
 }
 
-static int eeepc_backlight_notify(void)
+static void eeepc_led_exit(void)
 {
-	struct backlight_device *bd = eeepc_backlight_device;
-	int old = bd->props.brightness;
-
-	backlight_force_update(bd, BACKLIGHT_UPDATE_HOTKEY);
-
-	return old;
+	if (tpd_led.dev)
+		led_classdev_unregister(&tpd_led);
+	if (led_workqueue)
+		destroy_workqueue(led_workqueue);
 }
 
-static int eeepc_get_adapter_status(struct hotplug_slot *hotplug_slot,
-				    u8 *value)
-{
-	int val = get_acpi(CM_ASL_WLAN);
-
-	if (val == 1 || val == 0)
-		*value = val;
-	else
-		return -EINVAL;
 
-	return 0;
+/*
+ * PCI hotplug (for wlan rfkill)
+ */
+static bool eeepc_wlan_rfkill_blocked(void)
+{
+	if (get_acpi(CM_ASL_WLAN) == 1)
+		return false;
+	return true;
 }
 
 static void eeepc_rfkill_hotplug(void)
@@ -762,60 +547,6 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 	eeepc_rfkill_hotplug();
 }
 
-static void eeepc_input_notify(int event)
-{
-	static struct key_entry *key;
-
-	key = eepc_get_entry_by_scancode(event);
-	if (key) {
-		switch (key->type) {
-		case KE_KEY:
-			input_report_key(ehotk->inputdev, key->keycode,
-						1);
-			input_sync(ehotk->inputdev);
-			input_report_key(ehotk->inputdev, key->keycode,
-						0);
-			input_sync(ehotk->inputdev);
-			break;
-		}
-	}
-}
-
-static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
-{
-	u16 count;
-
-	if (event > ACPI_MAX_SYS_NOTIFY)
-		return;
-	count = ehotk->event_count[event % 128]++;
-	acpi_bus_generate_proc_event(ehotk->device, event, count);
-	acpi_bus_generate_netlink_event(ehotk->device->pnp.device_class,
-					dev_name(&ehotk->device->dev), event,
-					count);
-
-	if (event >= NOTIFY_BRN_MIN && event <= NOTIFY_BRN_MAX) {
-		int old_brightness, new_brightness;
-
-		/* Update backlight device. */
-		old_brightness = eeepc_backlight_notify();
-
-		/* Convert brightness event to keypress (obsolescent hack). */
-		new_brightness = event - NOTIFY_BRN_MIN;
-
-		if (new_brightness < old_brightness) {
-			event = NOTIFY_BRN_MIN; /* brightness down */
-		} else if (new_brightness > old_brightness) {
-			event = NOTIFY_BRN_MAX; /* brightness up */
-		} else {
-			/*
-			 * no change in brightness - already at min/max,
-			 * event will be desired value (or else ignored).
-			 */
-		}
-	}
-	eeepc_input_notify(event);
-}
-
 static int eeepc_register_rfkill_notifier(char *node)
 {
 	acpi_status status = AE_OK;
@@ -853,12 +584,31 @@ static void eeepc_unregister_rfkill_notifier(char *node)
 	}
 }
 
+static int eeepc_get_adapter_status(struct hotplug_slot *hotplug_slot,
+				    u8 *value)
+{
+	int val = get_acpi(CM_ASL_WLAN);
+
+	if (val == 1 || val == 0)
+		*value = val;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
 static void eeepc_cleanup_pci_hotplug(struct hotplug_slot *hotplug_slot)
 {
 	kfree(hotplug_slot->info);
 	kfree(hotplug_slot);
 }
 
+static struct hotplug_slot_ops eeepc_hotplug_slot_ops = {
+	.owner = THIS_MODULE,
+	.get_adapter_status = eeepc_get_adapter_status,
+	.get_power_status = eeepc_get_adapter_status,
+};
+
 static int eeepc_setup_pci_hotplug(void)
 {
 	int ret = -ENOMEM;
@@ -901,6 +651,140 @@ error_slot:
 	return ret;
 }
 
+/*
+ * Rfkill devices
+ */
+static int eeepc_rfkill_set(void *data, bool blocked)
+{
+	unsigned long asl = (unsigned long)data;
+	return set_acpi(asl, !blocked);
+}
+
+static const struct rfkill_ops eeepc_rfkill_ops = {
+	.set_block = eeepc_rfkill_set,
+};
+
+static int eeepc_new_rfkill(struct rfkill **rfkill,
+			    const char *name, struct device *dev,
+			    enum rfkill_type type, int cm)
+{
+	int result;
+
+	result = get_acpi(cm);
+	if (result < 0)
+		return result;
+
+	*rfkill = rfkill_alloc(name, dev, type,
+			       &eeepc_rfkill_ops, (void *)(unsigned long)cm);
+
+	if (!*rfkill)
+		return -EINVAL;
+
+	rfkill_init_sw_state(*rfkill, get_acpi(cm) != 1);
+	result = rfkill_register(*rfkill);
+	if (result) {
+		rfkill_destroy(*rfkill);
+		*rfkill = NULL;
+		return result;
+	}
+	return 0;
+}
+
+static void eeepc_rfkill_exit(void)
+{
+	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P5");
+	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
+	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
+	if (ehotk->wlan_rfkill) {
+		rfkill_unregister(ehotk->wlan_rfkill);
+		rfkill_destroy(ehotk->wlan_rfkill);
+		ehotk->wlan_rfkill = NULL;
+	}
+	/*
+	 * Refresh pci hotplug in case the rfkill state was changed after
+	 * eeepc_unregister_rfkill_notifier()
+	 */
+	eeepc_rfkill_hotplug();
+	if (ehotk->hotplug_slot)
+		pci_hp_deregister(ehotk->hotplug_slot);
+
+	if (ehotk->bluetooth_rfkill) {
+		rfkill_unregister(ehotk->bluetooth_rfkill);
+		rfkill_destroy(ehotk->bluetooth_rfkill);
+		ehotk->bluetooth_rfkill = NULL;
+	}
+	if (ehotk->wwan3g_rfkill) {
+		rfkill_unregister(ehotk->wwan3g_rfkill);
+		rfkill_destroy(ehotk->wwan3g_rfkill);
+		ehotk->wwan3g_rfkill = NULL;
+	}
+	if (ehotk->wimax_rfkill) {
+		rfkill_unregister(ehotk->wimax_rfkill);
+		rfkill_destroy(ehotk->wimax_rfkill);
+		ehotk->wimax_rfkill = NULL;
+	}
+}
+
+static int eeepc_rfkill_init(struct device *dev)
+{
+	int result = 0;
+
+	mutex_init(&ehotk->hotplug_lock);
+
+	result = eeepc_new_rfkill(&ehotk->wlan_rfkill,
+				  "eeepc-wlan", dev,
+				  RFKILL_TYPE_WLAN, CM_ASL_WLAN);
+
+	if (result && result != -ENODEV)
+		goto exit;
+
+	result = eeepc_new_rfkill(&ehotk->bluetooth_rfkill,
+				  "eeepc-bluetooth", dev,
+				  RFKILL_TYPE_BLUETOOTH, CM_ASL_BLUETOOTH);
+
+	if (result && result != -ENODEV)
+		goto exit;
+
+	result = eeepc_new_rfkill(&ehotk->wwan3g_rfkill,
+				  "eeepc-wwan3g", dev,
+				  RFKILL_TYPE_WWAN, CM_ASL_3G);
+
+	if (result && result != -ENODEV)
+		goto exit;
+
+	result = eeepc_new_rfkill(&ehotk->wimax_rfkill,
+				  "eeepc-wimax", dev,
+				  RFKILL_TYPE_WIMAX, CM_ASL_WIMAX);
+
+	if (result && result != -ENODEV)
+		goto exit;
+
+	result = eeepc_setup_pci_hotplug();
+	/*
+	 * If we get -EBUSY then something else is handling the PCI hotplug -
+	 * don't fail in this case
+	 */
+	if (result == -EBUSY)
+		result = 0;
+
+	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P5");
+	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
+	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
+	/*
+	 * Refresh pci hotplug in case the rfkill state was changed during
+	 * setup.
+	 */
+	eeepc_rfkill_hotplug();
+
+exit:
+	if (result && result != -ENODEV)
+		eeepc_rfkill_exit();
+	return result;
+}
+
+/*
+ * Platform driver - hibernate/resume callbacks
+ */
 static int eeepc_hotk_thaw(struct device *device)
 {
 	if (ehotk->wlan_rfkill) {
@@ -937,9 +821,31 @@ static int eeepc_hotk_restore(struct device *device)
 	return 0;
 }
 
+static struct dev_pm_ops eeepc_pm_ops = {
+	.thaw = eeepc_hotk_thaw,
+	.restore = eeepc_hotk_restore,
+};
+
+static struct platform_driver platform_driver = {
+	.driver = {
+		.name = EEEPC_HOTK_FILE,
+		.owner = THIS_MODULE,
+		.pm = &eeepc_pm_ops,
+	}
+};
+
 /*
- * Hwmon
+ * Hwmon device
  */
+
+#define EEEPC_EC_SC00      0x61
+#define EEEPC_EC_FAN_PWM   (EEEPC_EC_SC00 + 2) /* Fan PWM duty cycle (%) */
+#define EEEPC_EC_FAN_HRPM  (EEEPC_EC_SC00 + 5) /* High byte, fan speed (RPM) */
+#define EEEPC_EC_FAN_LRPM  (EEEPC_EC_SC00 + 6) /* Low byte, fan speed (RPM) */
+
+#define EEEPC_EC_SFB0      0xD0
+#define EEEPC_EC_FAN_CTRL  (EEEPC_EC_SFB0 + 3) /* Byte containing SF25  */
+
 static int eeepc_get_fan_pwm(void)
 {
 	u8 value = 0;
@@ -1043,57 +949,6 @@ static struct attribute_group hwmon_attribute_group = {
 	.attrs = hwmon_attributes
 };
 
-/*
- * exit/init
- */
-static void eeepc_backlight_exit(void)
-{
-	if (eeepc_backlight_device)
-		backlight_device_unregister(eeepc_backlight_device);
-	eeepc_backlight_device = NULL;
-}
-
-static void eeepc_rfkill_exit(void)
-{
-	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P5");
-	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
-	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
-	if (ehotk->wlan_rfkill) {
-		rfkill_unregister(ehotk->wlan_rfkill);
-		rfkill_destroy(ehotk->wlan_rfkill);
-		ehotk->wlan_rfkill = NULL;
-	}
-	/*
-	 * Refresh pci hotplug in case the rfkill state was changed after
-	 * eeepc_unregister_rfkill_notifier()
-	 */
-	eeepc_rfkill_hotplug();
-	if (ehotk->hotplug_slot)
-		pci_hp_deregister(ehotk->hotplug_slot);
-
-	if (ehotk->bluetooth_rfkill) {
-		rfkill_unregister(ehotk->bluetooth_rfkill);
-		rfkill_destroy(ehotk->bluetooth_rfkill);
-		ehotk->bluetooth_rfkill = NULL;
-	}
-	if (ehotk->wwan3g_rfkill) {
-		rfkill_unregister(ehotk->wwan3g_rfkill);
-		rfkill_destroy(ehotk->wwan3g_rfkill);
-		ehotk->wwan3g_rfkill = NULL;
-	}
-	if (ehotk->wimax_rfkill) {
-		rfkill_unregister(ehotk->wimax_rfkill);
-		rfkill_destroy(ehotk->wimax_rfkill);
-		ehotk->wimax_rfkill = NULL;
-	}
-}
-
-static void eeepc_input_exit(void)
-{
-	if (ehotk->inputdev)
-		input_unregister_device(ehotk->inputdev);
-}
-
 static void eeepc_hwmon_exit(void)
 {
 	struct device *hwmon;
@@ -1107,96 +962,56 @@ static void eeepc_hwmon_exit(void)
 	eeepc_hwmon_device = NULL;
 }
 
-static void eeepc_led_exit(void)
-{
-	if (tpd_led.dev)
-		led_classdev_unregister(&tpd_led);
-	if (led_workqueue)
-		destroy_workqueue(led_workqueue);
-}
-
-static int eeepc_new_rfkill(struct rfkill **rfkill,
-			    const char *name, struct device *dev,
-			    enum rfkill_type type, int cm)
+static int eeepc_hwmon_init(struct device *dev)
 {
+	struct device *hwmon;
 	int result;
 
-	result = get_acpi(cm);
-	if (result < 0)
-		return result;
-
-	*rfkill = rfkill_alloc(name, dev, type,
-			       &eeepc_rfkill_ops, (void *)(unsigned long)cm);
-
-	if (!*rfkill)
-		return -EINVAL;
-
-	rfkill_init_sw_state(*rfkill, get_acpi(cm) != 1);
-	result = rfkill_register(*rfkill);
-	if (result) {
-		rfkill_destroy(*rfkill);
-		*rfkill = NULL;
-		return result;
+	hwmon = hwmon_device_register(dev);
+	if (IS_ERR(hwmon)) {
+		pr_err("Could not register eeepc hwmon device\n");
+		eeepc_hwmon_device = NULL;
+		return PTR_ERR(hwmon);
 	}
-	return 0;
+	eeepc_hwmon_device = hwmon;
+	result = sysfs_create_group(&hwmon->kobj,
+				    &hwmon_attribute_group);
+	if (result)
+		eeepc_hwmon_exit();
+	return result;
 }
 
-
-static int eeepc_rfkill_init(struct device *dev)
+/*
+ * Backlight device
+ */
+static int read_brightness(struct backlight_device *bd)
 {
-	int result = 0;
-
-	mutex_init(&ehotk->hotplug_lock);
-
-	result = eeepc_new_rfkill(&ehotk->wlan_rfkill,
-				  "eeepc-wlan", dev,
-				  RFKILL_TYPE_WLAN, CM_ASL_WLAN);
-
-	if (result && result != -ENODEV)
-		goto exit;
-
-	result = eeepc_new_rfkill(&ehotk->bluetooth_rfkill,
-				  "eeepc-bluetooth", dev,
-				  RFKILL_TYPE_BLUETOOTH, CM_ASL_BLUETOOTH);
-
-	if (result && result != -ENODEV)
-		goto exit;
-
-	result = eeepc_new_rfkill(&ehotk->wwan3g_rfkill,
-				  "eeepc-wwan3g", dev,
-				  RFKILL_TYPE_WWAN, CM_ASL_3G);
+	return get_acpi(CM_ASL_PANELBRIGHT);
+}
 
-	if (result && result != -ENODEV)
-		goto exit;
+static int set_brightness(struct backlight_device *bd, int value)
+{
+	return set_acpi(CM_ASL_PANELBRIGHT, value);
+}
 
-	result = eeepc_new_rfkill(&ehotk->wimax_rfkill,
-				  "eeepc-wimax", dev,
-				  RFKILL_TYPE_WIMAX, CM_ASL_WIMAX);
+static int update_bl_status(struct backlight_device *bd)
+{
+	return set_brightness(bd, bd->props.brightness);
+}
 
-	if (result && result != -ENODEV)
-		goto exit;
+static struct backlight_ops eeepcbl_ops = {
+	.get_brightness = read_brightness,
+	.update_status = update_bl_status,
+};
 
-	result = eeepc_setup_pci_hotplug();
-	/*
-	 * If we get -EBUSY then something else is handling the PCI hotplug -
-	 * don't fail in this case
-	 */
-	if (result == -EBUSY)
-		result = 0;
+static int eeepc_backlight_notify(void)
+{
+	struct backlight_device *bd = eeepc_backlight_device;
+	int old = bd->props.brightness;
 
-	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P5");
-	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
-	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
-	/*
-	 * Refresh pci hotplug in case the rfkill state was changed during
-	 * setup.
-	 */
-	eeepc_rfkill_hotplug();
+	backlight_force_update(bd, BACKLIGHT_UPDATE_HOTKEY);
 
-exit:
-	if (result && result != -ENODEV)
-		eeepc_rfkill_exit();
-	return result;
+	return old;
 }
 
 static int eeepc_backlight_init(struct device *dev)
@@ -1218,23 +1033,89 @@ static int eeepc_backlight_init(struct device *dev)
 	return 0;
 }
 
-static int eeepc_hwmon_init(struct device *dev)
+static void eeepc_backlight_exit(void)
 {
-	struct device *hwmon;
-	int result;
+	if (eeepc_backlight_device)
+		backlight_device_unregister(eeepc_backlight_device);
+	eeepc_backlight_device = NULL;
+}
 
-	hwmon = hwmon_device_register(dev);
-	if (IS_ERR(hwmon)) {
-		pr_err("Could not register eeepc hwmon device\n");
-		eeepc_hwmon_device = NULL;
-		return PTR_ERR(hwmon);
+
+/*
+ * Input device (i.e. hotkeys)
+ */
+static struct key_entry *eeepc_get_entry_by_scancode(int code)
+{
+	struct key_entry *key;
+
+	for (key = eeepc_keymap; key->type != KE_END; key++)
+		if (code == key->code)
+			return key;
+
+	return NULL;
+}
+
+static void eeepc_input_notify(int event)
+{
+	static struct key_entry *key;
+
+	key = eeepc_get_entry_by_scancode(event);
+	if (key) {
+		switch (key->type) {
+		case KE_KEY:
+			input_report_key(ehotk->inputdev, key->keycode,
+						1);
+			input_sync(ehotk->inputdev);
+			input_report_key(ehotk->inputdev, key->keycode,
+						0);
+			input_sync(ehotk->inputdev);
+			break;
+		}
 	}
-	eeepc_hwmon_device = hwmon;
-	result = sysfs_create_group(&hwmon->kobj,
-				    &hwmon_attribute_group);
-	if (result)
-		eeepc_hwmon_exit();
-	return result;
+}
+
+static struct key_entry *eepc_get_entry_by_keycode(int code)
+{
+	struct key_entry *key;
+
+	for (key = eeepc_keymap; key->type != KE_END; key++)
+		if (code == key->keycode && key->type == KE_KEY)
+			return key;
+
+	return NULL;
+}
+
+static int eeepc_getkeycode(struct input_dev *dev, int scancode, int *keycode)
+{
+	struct key_entry *key = eeepc_get_entry_by_scancode(scancode);
+
+	if (key && key->type == KE_KEY) {
+		*keycode = key->keycode;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int eeepc_setkeycode(struct input_dev *dev, int scancode, int keycode)
+{
+	struct key_entry *key;
+	int old_keycode;
+
+	if (keycode < 0 || keycode > KEY_MAX)
+		return -EINVAL;
+
+	key = eeepc_get_entry_by_scancode(scancode);
+	if (key && key->type == KE_KEY) {
+		old_keycode = key->keycode;
+		key->keycode = keycode;
+		set_bit(keycode, dev->keybit);
+		if (!eepc_get_entry_by_keycode(old_keycode))
+			clear_bit(old_keycode, dev->keybit);
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 static int eeepc_input_init(struct device *dev)
@@ -1271,26 +1152,114 @@ static int eeepc_input_init(struct device *dev)
 	return 0;
 }
 
-static int eeepc_led_init(struct device *dev)
+static void eeepc_input_exit(void)
 {
-	int rv;
+	if (ehotk->inputdev)
+		input_unregister_device(ehotk->inputdev);
+}
 
-	if (get_acpi(CM_ASL_TPD) == -ENODEV)
-		return 0;
+/*
+ * ACPI driver
+ */
+static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
+{
+	u16 count;
 
-	led_workqueue = create_singlethread_workqueue("led_workqueue");
-	if (!led_workqueue)
-		return -ENOMEM;
+	if (event > ACPI_MAX_SYS_NOTIFY)
+		return;
+	count = ehotk->event_count[event % 128]++;
+	acpi_bus_generate_proc_event(ehotk->device, event, count);
+	acpi_bus_generate_netlink_event(ehotk->device->pnp.device_class,
+					dev_name(&ehotk->device->dev), event,
+					count);
 
-	rv = led_classdev_register(dev, &tpd_led);
-	if (rv) {
-		destroy_workqueue(led_workqueue);
-		return rv;
+	if (event >= NOTIFY_BRN_MIN && event <= NOTIFY_BRN_MAX) {
+		int old_brightness, new_brightness;
+
+		/* Update backlight device. */
+		old_brightness = eeepc_backlight_notify();
+
+		/* Convert brightness event to keypress (obsolescent hack). */
+		new_brightness = event - NOTIFY_BRN_MIN;
+
+		if (new_brightness < old_brightness) {
+			event = NOTIFY_BRN_MIN; /* brightness down */
+		} else if (new_brightness > old_brightness) {
+			event = NOTIFY_BRN_MAX; /* brightness up */
+		} else {
+			/*
+			 * no change in brightness - already at min/max,
+			 * event will be desired value (or else ignored).
+			 */
+		}
 	}
+	eeepc_input_notify(event);
+}
+
+static void cmsg_quirk(int cm, const char *name)
+{
+	int dummy;
+
+	/* Some BIOSes do not report cm although it is avaliable.
+	   Check if cm_getv[cm] works and, if yes, assume cm should be set. */
+	if (!(ehotk->cm_supported & (1 << cm))
+	    && !read_acpi_int(ehotk->handle, cm_getv[cm], &dummy)) {
+		pr_info("%s (%x) not reported by BIOS,"
+			" enabling anyway\n", name, 1 << cm);
+		ehotk->cm_supported |= 1 << cm;
+	}
+}
+
+static void cmsg_quirks(void)
+{
+	cmsg_quirk(CM_ASL_LID, "LID");
+	cmsg_quirk(CM_ASL_TYPE, "TYPE");
+	cmsg_quirk(CM_ASL_PANELPOWER, "PANELPOWER");
+	cmsg_quirk(CM_ASL_TPD, "TPD");
+}
+
+static int eeepc_hotk_init(void)
+{
+	unsigned int init_flags;
+	int result;
+
+	result = acpi_bus_get_status(ehotk->device);
+	if (result)
+		return result;
+	if (!ehotk->device->status.present) {
+		pr_err("Hotkey device not present, aborting\n");
+		return -ENODEV;
+	}
+
+	init_flags = DISABLE_ASL_WLAN | DISABLE_ASL_DISPLAYSWITCH;
+	pr_notice("Hotkey init flags 0x%x\n", init_flags);
+
+	if (write_acpi_int(ehotk->handle, "INIT", init_flags)) {
+		pr_err("Hotkey initialization failed\n");
+		return -ENODEV;
+	}
+
+	/* get control methods supported */
+	if (read_acpi_int(ehotk->handle, "CMSG", &ehotk->cm_supported)) {
+		pr_err("Get control methods supported failed\n");
+		return -ENODEV;
+	}
+	cmsg_quirks();
+	pr_info("Get control methods supported: 0x%x\n", ehotk->cm_supported);
 
 	return 0;
 }
 
+static void __devinit eeepc_enable_camera(void)
+{
+	/*
+	 * If the following call to set_acpi() fails, it's because there's no
+	 * camera so we can ignore the error.
+	 */
+	if (get_acpi(CM_ASL_CAMERA) == 0)
+		set_acpi(CM_ASL_CAMERA, 1);
+}
+
 static int __devinit eeepc_hotk_add(struct acpi_device *device)
 {
 	struct device *dev;
@@ -1371,6 +1340,27 @@ static int eeepc_hotk_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
+
+static const struct acpi_device_id eeepc_device_ids[] = {
+	{EEEPC_HOTK_HID, 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, eeepc_device_ids);
+
+static struct acpi_driver eeepc_hotk_driver = {
+	.name = EEEPC_HOTK_NAME,
+	.class = EEEPC_HOTK_CLASS,
+	.owner = THIS_MODULE,
+	.ids = eeepc_device_ids,
+	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
+	.ops = {
+		.add = eeepc_hotk_add,
+		.remove = eeepc_hotk_remove,
+		.notify = eeepc_hotk_notify,
+	},
+};
+
+
 static int __init eeepc_laptop_init(void)
 {
 	int result;
-- 
1.6.0.6

