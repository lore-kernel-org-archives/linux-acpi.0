From: Len Brown <lenb@kernel.org>
Subject: [PATCH 042/103] eeepc-laptop: callbacks should use "driver data"
 parameter or field
Date: Wed, 16 Dec 2009 03:35:53 -0500
Message-ID: <854c78363f37f03e30e2856ef17d7eefc62e0d06.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:61722 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760925AbZLPMGH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 07:06:07 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0025QUXOD4MD@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 06:05:57 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Callback methods should not refer to a variable like "eeepc" (formally
"ehotk").  Instead, they should extract the data they need either from
a "driver data" parameter, or the "driver data" field of the object
which they operate on.  The "eeepc" variable can then be removed.

In practice, drivers under "drivers/platform" can get away without using
driver data, because it doesn't make sense to have more than one
instance of them.  However this makes it harder to review them for
correctness.  This is especially true for core ACPI developers who have
not previously been exposed to this anti-pattern :-).

This will serve as an example of best practice for new driver writers
(whether they find it themselves, or have it pointed out during review
:-).

The hwmon sub-device is a special case.  It uses ec_{read,write} which
are defined to communicate with the (first) EC, so it does not require
any driver data.  It should still only be instantiated in the context of
an ASUS010 device because we don't have a safe way to probe for it.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |  466 ++++++++++++++++++++---------------
 1 files changed, 268 insertions(+), 198 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index b9b5aeb..935ec44 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -128,7 +128,7 @@ struct key_entry {
 
 enum { KE_KEY, KE_END };
 
-static struct key_entry eeepc_keymap[] = {
+static const struct key_entry eeepc_keymap[] = {
 	/* Sleep already handled via generic ACPI code */
 	{KE_KEY, 0x10, KEY_WLAN },
 	{KE_KEY, 0x11, KEY_WLAN },
@@ -153,33 +153,31 @@ static struct key_entry eeepc_keymap[] = {
  * This is the main structure, we can use it to store useful information
  */
 struct eeepc_laptop {
-	struct acpi_device *device;	/* the device we are in */
-	acpi_handle handle;		/* the handle of the hotk device */
+	acpi_handle handle;		/* the handle of the acpi device */
 	u32 cm_supported;		/* the control methods supported
 					   by this BIOS */
 	u16 event_count[128];		/* count for each event */
+
+	struct platform_device *platform_device;
+	struct device *hwmon_device;
+	struct backlight_device *backlight_device;
+
 	struct input_dev *inputdev;
-	u16 *keycode_map;
+	struct key_entry *keymap;
+
 	struct rfkill *wlan_rfkill;
 	struct rfkill *bluetooth_rfkill;
 	struct rfkill *wwan3g_rfkill;
 	struct rfkill *wimax_rfkill;
+
 	struct hotplug_slot *hotplug_slot;
 	struct mutex hotplug_lock;
-};
-
-/* The actual device the driver binds to */
-static struct eeepc_laptop *eeepc;
-
-/* The platform device */
-static struct platform_device *platform_device;
-
-/* The backlight device /sys/class/backlight */
-static struct backlight_device *eeepc_backlight_device;
-
-/* The hwmon device */
-static struct device *eeepc_hwmon_device;
 
+	struct led_classdev tpd_led;
+	int tpd_led_wk;
+	struct workqueue_struct *led_workqueue;
+	struct work_struct tpd_led_work;
+};
 
 /*
  * ACPI Helpers
@@ -214,7 +212,7 @@ static int read_acpi_int(acpi_handle handle, const char *method, int *val)
 	}
 }
 
-static int set_acpi(int cm, int value)
+static int set_acpi(struct eeepc_laptop *eeepc, int cm, int value)
 {
 	const char *method = cm_setv[cm];
 
@@ -228,7 +226,7 @@ static int set_acpi(int cm, int value)
 	return 0;
 }
 
-static int get_acpi(int cm)
+static int get_acpi(struct eeepc_laptop *eeepc, int cm)
 {
 	const char *method = cm_getv[cm];
 	int value;
@@ -243,6 +241,26 @@ static int get_acpi(int cm)
 	return value;
 }
 
+static int acpi_setter_handle(struct eeepc_laptop *eeepc, int cm, acpi_handle *handle)
+{
+	const char *method = cm_setv[cm];
+	acpi_status status;
+
+	if (method == NULL)
+		return -ENODEV;
+	if ((eeepc->cm_supported & (0x1 << cm)) == 0)
+		return -ENODEV;
+
+	status = acpi_get_handle(eeepc->handle, (char *)method,
+			         handle);
+	if (status != AE_OK) {
+		pr_warning("Error finding %s\n", method);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+
 /*
  * Sys helpers
  */
@@ -255,21 +273,24 @@ static int parse_arg(const char *buf, unsigned long count, int *val)
 	return count;
 }
 
-static ssize_t store_sys_acpi(int cm, const char *buf, size_t count)
+static ssize_t store_sys_acpi(struct device *dev, int cm,
+			      const char *buf, size_t count)
 {
+	struct eeepc_laptop *eeepc = dev_get_drvdata(dev);
 	int rv, value;
 
 	rv = parse_arg(buf, count, &value);
 	if (rv > 0)
-		value = set_acpi(cm, value);
+		value = set_acpi(eeepc, cm, value);
 	if (value < 0)
 		return -EIO;
 	return rv;
 }
 
-static ssize_t show_sys_acpi(int cm, char *buf)
+static ssize_t show_sys_acpi(struct device *dev, int cm, char *buf)
 {
-	int value = get_acpi(cm);
+	struct eeepc_laptop *eeepc = dev_get_drvdata(dev);
+	int value = get_acpi(eeepc, cm);
 
 	if (value < 0)
 		return -EIO;
@@ -281,13 +302,13 @@ static ssize_t show_sys_acpi(int cm, char *buf)
 				    struct device_attribute *attr,	\
 				    char *buf)				\
 	{								\
-		return show_sys_acpi(_cm, buf);				\
+		return show_sys_acpi(dev, _cm, buf);			\
 	}								\
 	static ssize_t store_##_name(struct device *dev,		\
 				     struct device_attribute *attr,	\
 				     const char *buf, size_t count)	\
 	{								\
-		return store_sys_acpi(_cm, buf, count);			\
+		return store_sys_acpi(dev, _cm, buf, count);		\
 	}								\
 	static struct device_attribute dev_attr_##_name = {		\
 		.attr = {						\
@@ -306,9 +327,9 @@ struct eeepc_cpufv {
 	int cur;
 };
 
-static int get_cpufv(struct eeepc_cpufv *c)
+static int get_cpufv(struct eeepc_laptop *eeepc, struct eeepc_cpufv *c)
 {
-	c->cur = get_acpi(CM_ASL_CPUFV);
+	c->cur = get_acpi(eeepc, CM_ASL_CPUFV);
 	c->num = (c->cur >> 8) & 0xff;
 	c->cur &= 0xff;
 	if (c->cur < 0 || c->num <= 0 || c->num > 12)
@@ -320,11 +341,12 @@ static ssize_t show_available_cpufv(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
+	struct eeepc_laptop *eeepc = dev_get_drvdata(dev);
 	struct eeepc_cpufv c;
 	int i;
 	ssize_t len = 0;
 
-	if (get_cpufv(&c))
+	if (get_cpufv(eeepc, &c))
 		return -ENODEV;
 	for (i = 0; i < c.num; i++)
 		len += sprintf(buf + len, "%d ", i);
@@ -336,9 +358,10 @@ static ssize_t show_cpufv(struct device *dev,
 			  struct device_attribute *attr,
 			  char *buf)
 {
+	struct eeepc_laptop *eeepc = dev_get_drvdata(dev);
 	struct eeepc_cpufv c;
 
-	if (get_cpufv(&c))
+	if (get_cpufv(eeepc, &c))
 		return -ENODEV;
 	return sprintf(buf, "%#x\n", (c.num << 8) | c.cur);
 }
@@ -347,17 +370,18 @@ static ssize_t store_cpufv(struct device *dev,
 			   struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
+	struct eeepc_laptop *eeepc = dev_get_drvdata(dev);
 	struct eeepc_cpufv c;
 	int rv, value;
 
-	if (get_cpufv(&c))
+	if (get_cpufv(eeepc, &c))
 		return -ENODEV;
 	rv = parse_arg(buf, count, &value);
 	if (rv < 0)
 		return rv;
 	if (!rv || value < 0 || value >= c.num)
 		return -EINVAL;
-	set_acpi(CM_ASL_CPUFV, value);
+	set_acpi(eeepc, CM_ASL_CPUFV, value);
 	return rv;
 }
 
@@ -389,36 +413,37 @@ static struct attribute_group platform_attribute_group = {
 	.attrs = platform_attributes
 };
 
-static int eeepc_platform_init(void)
+static int eeepc_platform_init(struct eeepc_laptop *eeepc)
 {
 	int result;
 
-	platform_device = platform_device_alloc(EEEPC_LAPTOP_FILE, -1);
-	if (!platform_device)
+	eeepc->platform_device = platform_device_alloc(EEEPC_LAPTOP_FILE, -1);
+	if (!eeepc->platform_device)
 		return -ENOMEM;
+	platform_set_drvdata(eeepc->platform_device, eeepc);
 
-	result = platform_device_add(platform_device);
+	result = platform_device_add(eeepc->platform_device);
 	if (result)
 		goto fail_platform_device;
 
-	result = sysfs_create_group(&platform_device->dev.kobj,
+	result = sysfs_create_group(&eeepc->platform_device->dev.kobj,
 				    &platform_attribute_group);
 	if (result)
 		goto fail_sysfs;
 	return 0;
 
 fail_sysfs:
-	platform_device_del(platform_device);
+	platform_device_del(eeepc->platform_device);
 fail_platform_device:
-	platform_device_put(platform_device);
+	platform_device_put(eeepc->platform_device);
 	return result;
 }
 
-static void eeepc_platform_exit(void)
+static void eeepc_platform_exit(struct eeepc_laptop *eeepc)
 {
-	sysfs_remove_group(&platform_device->dev.kobj,
+	sysfs_remove_group(&eeepc->platform_device->dev.kobj,
 			   &platform_attribute_group);
-	platform_device_unregister(platform_device);
+	platform_device_unregister(eeepc->platform_device);
 }
 
 /*
@@ -430,74 +455,76 @@ static void eeepc_platform_exit(void)
  * subsystem asks, we avoid messing with the Asus ACPI stuff during a
  * potentially bad time, such as a timer interrupt.
  */
-static int tpd_led_wk;
+static void tpd_led_update(struct work_struct *work)
+ {
+	struct eeepc_laptop *eeepc;
 
-static void tpd_led_update(struct work_struct *ignored)
-{
-	int value = tpd_led_wk;
-	set_acpi(CM_ASL_TPD, value);
-}
+	eeepc = container_of(work, struct eeepc_laptop, tpd_led_work);
 
-static struct workqueue_struct *led_workqueue;
-static DECLARE_WORK(tpd_led_work, tpd_led_update);
+	set_acpi(eeepc, CM_ASL_TPD, eeepc->tpd_led_wk);
+}
 
 static void tpd_led_set(struct led_classdev *led_cdev,
 			enum led_brightness value)
 {
-	tpd_led_wk = (value > 0) ? 1 : 0;
-	queue_work(led_workqueue, &tpd_led_work);
-}
+	struct eeepc_laptop *eeepc;
 
-static struct led_classdev tpd_led = {
-	.name           = "eeepc::touchpad",
-	.brightness_set = tpd_led_set,
-	.max_brightness = 1
-};
+	eeepc = container_of(led_cdev, struct eeepc_laptop, tpd_led);
 
-static int eeepc_led_init(struct device *dev)
+	eeepc->tpd_led_wk = (value > 0) ? 1 : 0;
+	queue_work(eeepc->led_workqueue, &eeepc->tpd_led_work);
+}
+
+static int eeepc_led_init(struct eeepc_laptop *eeepc)
 {
 	int rv;
 
-	if (get_acpi(CM_ASL_TPD) == -ENODEV)
+	if (get_acpi(eeepc, CM_ASL_TPD) == -ENODEV)
 		return 0;
 
-	led_workqueue = create_singlethread_workqueue("led_workqueue");
-	if (!led_workqueue)
+	eeepc->led_workqueue = create_singlethread_workqueue("led_workqueue");
+	if (!eeepc->led_workqueue)
 		return -ENOMEM;
+	INIT_WORK(&eeepc->tpd_led_work, tpd_led_update);
+
+	eeepc->tpd_led.name = "eeepc::touchpad";
+	eeepc->tpd_led.brightness_set = tpd_led_set;
+	eeepc->tpd_led.max_brightness = 1;
 
-	rv = led_classdev_register(dev, &tpd_led);
+	rv = led_classdev_register(&eeepc->platform_device->dev,
+				   &eeepc->tpd_led);
 	if (rv) {
-		destroy_workqueue(led_workqueue);
+		destroy_workqueue(eeepc->led_workqueue);
 		return rv;
 	}
 
 	return 0;
 }
 
-static void eeepc_led_exit(void)
+static void eeepc_led_exit(struct eeepc_laptop *eeepc)
 {
-	if (tpd_led.dev)
-		led_classdev_unregister(&tpd_led);
-	if (led_workqueue)
-		destroy_workqueue(led_workqueue);
+	if (eeepc->tpd_led.dev)
+		led_classdev_unregister(&eeepc->tpd_led);
+	if (eeepc->led_workqueue)
+		destroy_workqueue(eeepc->led_workqueue);
 }
 
 
 /*
  * PCI hotplug (for wlan rfkill)
  */
-static bool eeepc_wlan_rfkill_blocked(void)
+static bool eeepc_wlan_rfkill_blocked(struct eeepc_laptop *eeepc)
 {
-	if (get_acpi(CM_ASL_WLAN) == 1)
+	if (get_acpi(eeepc, CM_ASL_WLAN) == 1)
 		return false;
 	return true;
 }
 
-static void eeepc_rfkill_hotplug(void)
+static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus;
-	bool blocked = eeepc_wlan_rfkill_blocked();
+	bool blocked = eeepc_wlan_rfkill_blocked(eeepc);
 
 	if (eeepc->wlan_rfkill)
 		rfkill_set_sw_state(eeepc->wlan_rfkill, blocked);
@@ -539,15 +566,18 @@ out_unlock:
 
 static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct eeepc_laptop *eeepc = data;
+
 	if (event != ACPI_NOTIFY_BUS_CHECK)
 		return;
 
-	eeepc_rfkill_hotplug();
+	eeepc_rfkill_hotplug(eeepc);
 }
 
-static int eeepc_register_rfkill_notifier(char *node)
+static int eeepc_register_rfkill_notifier(struct eeepc_laptop *eeepc,
+					  char *node)
 {
-	acpi_status status = AE_OK;
+	acpi_status status;
 	acpi_handle handle;
 
 	status = acpi_get_handle(NULL, node, &handle);
@@ -556,7 +586,7 @@ static int eeepc_register_rfkill_notifier(char *node)
 		status = acpi_install_notify_handler(handle,
 						     ACPI_SYSTEM_NOTIFY,
 						     eeepc_rfkill_notify,
-						     NULL);
+						     eeepc);
 		if (ACPI_FAILURE(status))
 			pr_warning("Failed to register notify on %s\n", node);
 	} else
@@ -565,7 +595,8 @@ static int eeepc_register_rfkill_notifier(char *node)
 	return 0;
 }
 
-static void eeepc_unregister_rfkill_notifier(char *node)
+static void eeepc_unregister_rfkill_notifier(struct eeepc_laptop *eeepc,
+					     char *node)
 {
 	acpi_status status = AE_OK;
 	acpi_handle handle;
@@ -585,7 +616,8 @@ static void eeepc_unregister_rfkill_notifier(char *node)
 static int eeepc_get_adapter_status(struct hotplug_slot *hotplug_slot,
 				    u8 *value)
 {
-	int val = get_acpi(CM_ASL_WLAN);
+	struct eeepc_laptop *eeepc = hotplug_slot->private;
+	int val = get_acpi(eeepc, CM_ASL_WLAN);
 
 	if (val == 1 || val == 0)
 		*value = val;
@@ -607,7 +639,7 @@ static struct hotplug_slot_ops eeepc_hotplug_slot_ops = {
 	.get_power_status = eeepc_get_adapter_status,
 };
 
-static int eeepc_setup_pci_hotplug(void)
+static int eeepc_setup_pci_hotplug(struct eeepc_laptop *eeepc)
 {
 	int ret = -ENOMEM;
 	struct pci_bus *bus = pci_find_bus(0, 1);
@@ -654,31 +686,34 @@ error_slot:
  */
 static int eeepc_rfkill_set(void *data, bool blocked)
 {
-	unsigned long asl = (unsigned long)data;
-	return set_acpi(asl, !blocked);
+	acpi_handle handle = data;
+
+	return write_acpi_int(handle, NULL, !blocked);
 }
 
 static const struct rfkill_ops eeepc_rfkill_ops = {
 	.set_block = eeepc_rfkill_set,
 };
 
-static int eeepc_new_rfkill(struct rfkill **rfkill,
-			    const char *name, struct device *dev,
+static int eeepc_new_rfkill(struct eeepc_laptop *eeepc,
+			    struct rfkill **rfkill,
+			    const char *name,
 			    enum rfkill_type type, int cm)
 {
+	acpi_handle handle;
 	int result;
 
-	result = get_acpi(cm);
+	result = acpi_setter_handle(eeepc, cm, &handle);
 	if (result < 0)
 		return result;
 
-	*rfkill = rfkill_alloc(name, dev, type,
-			       &eeepc_rfkill_ops, (void *)(unsigned long)cm);
+	*rfkill = rfkill_alloc(name, &eeepc->platform_device->dev, type,
+			       &eeepc_rfkill_ops, handle);
 
 	if (!*rfkill)
 		return -EINVAL;
 
-	rfkill_init_sw_state(*rfkill, get_acpi(cm) != 1);
+	rfkill_init_sw_state(*rfkill, get_acpi(eeepc, cm) != 1);
 	result = rfkill_register(*rfkill);
 	if (result) {
 		rfkill_destroy(*rfkill);
@@ -688,11 +723,11 @@ static int eeepc_new_rfkill(struct rfkill **rfkill,
 	return 0;
 }
 
-static void eeepc_rfkill_exit(void)
+static void eeepc_rfkill_exit(struct eeepc_laptop *eeepc)
 {
-	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P5");
-	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
-	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
+	eeepc_unregister_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P5");
+	eeepc_unregister_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P6");
+	eeepc_unregister_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P7");
 	if (eeepc->wlan_rfkill) {
 		rfkill_unregister(eeepc->wlan_rfkill);
 		rfkill_destroy(eeepc->wlan_rfkill);
@@ -702,7 +737,7 @@ static void eeepc_rfkill_exit(void)
 	 * Refresh pci hotplug in case the rfkill state was changed after
 	 * eeepc_unregister_rfkill_notifier()
 	 */
-	eeepc_rfkill_hotplug();
+	eeepc_rfkill_hotplug(eeepc);
 	if (eeepc->hotplug_slot)
 		pci_hp_deregister(eeepc->hotplug_slot);
 
@@ -723,41 +758,41 @@ static void eeepc_rfkill_exit(void)
 	}
 }
 
-static int eeepc_rfkill_init(struct device *dev)
+static int eeepc_rfkill_init(struct eeepc_laptop *eeepc)
 {
 	int result = 0;
 
 	mutex_init(&eeepc->hotplug_lock);
 
-	result = eeepc_new_rfkill(&eeepc->wlan_rfkill,
-				  "eeepc-wlan", dev,
-				  RFKILL_TYPE_WLAN, CM_ASL_WLAN);
+	result = eeepc_new_rfkill(eeepc, &eeepc->wlan_rfkill,
+				  "eeepc-wlan", RFKILL_TYPE_WLAN,
+				  CM_ASL_WLAN);
 
 	if (result && result != -ENODEV)
 		goto exit;
 
-	result = eeepc_new_rfkill(&eeepc->bluetooth_rfkill,
-				  "eeepc-bluetooth", dev,
-				  RFKILL_TYPE_BLUETOOTH, CM_ASL_BLUETOOTH);
+	result = eeepc_new_rfkill(eeepc, &eeepc->bluetooth_rfkill,
+				  "eeepc-bluetooth", RFKILL_TYPE_BLUETOOTH,
+				  CM_ASL_BLUETOOTH);
 
 	if (result && result != -ENODEV)
 		goto exit;
 
-	result = eeepc_new_rfkill(&eeepc->wwan3g_rfkill,
-				  "eeepc-wwan3g", dev,
-				  RFKILL_TYPE_WWAN, CM_ASL_3G);
+	result = eeepc_new_rfkill(eeepc, &eeepc->wwan3g_rfkill,
+				  "eeepc-wwan3g", RFKILL_TYPE_WWAN,
+				  CM_ASL_3G);
 
 	if (result && result != -ENODEV)
 		goto exit;
 
-	result = eeepc_new_rfkill(&eeepc->wimax_rfkill,
-				  "eeepc-wimax", dev,
-				  RFKILL_TYPE_WIMAX, CM_ASL_WIMAX);
+	result = eeepc_new_rfkill(eeepc, &eeepc->wimax_rfkill,
+				  "eeepc-wimax", RFKILL_TYPE_WIMAX,
+				  CM_ASL_WIMAX);
 
 	if (result && result != -ENODEV)
 		goto exit;
 
-	result = eeepc_setup_pci_hotplug();
+	result = eeepc_setup_pci_hotplug(eeepc);
 	/*
 	 * If we get -EBUSY then something else is handling the PCI hotplug -
 	 * don't fail in this case
@@ -765,26 +800,28 @@ static int eeepc_rfkill_init(struct device *dev)
 	if (result == -EBUSY)
 		result = 0;
 
-	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P5");
-	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
-	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
+	eeepc_register_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P5");
+	eeepc_register_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P6");
+	eeepc_register_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P7");
 	/*
 	 * Refresh pci hotplug in case the rfkill state was changed during
 	 * setup.
 	 */
-	eeepc_rfkill_hotplug();
+	eeepc_rfkill_hotplug(eeepc);
 
 exit:
 	if (result && result != -ENODEV)
-		eeepc_rfkill_exit();
+		eeepc_rfkill_exit(eeepc);
 	return result;
 }
 
 /*
  * Platform driver - hibernate/resume callbacks
  */
-static int eeepc_thaw(struct device *device)
+static int eeepc_hotk_thaw(struct device *device)
 {
+	struct eeepc_laptop *eeepc = dev_get_drvdata(device);
+
 	if (eeepc->wlan_rfkill) {
 		bool wlan;
 
@@ -793,35 +830,37 @@ static int eeepc_thaw(struct device *device)
 		 * during suspend.  Normally it restores it on resume, but
 		 * we should kick it ourselves in case hibernation is aborted.
 		 */
-		wlan = get_acpi(CM_ASL_WLAN);
-		set_acpi(CM_ASL_WLAN, wlan);
+		wlan = get_acpi(eeepc, CM_ASL_WLAN);
+		set_acpi(eeepc, CM_ASL_WLAN, wlan);
 	}
 
 	return 0;
 }
 
-static int eeepc_restore(struct device *device)
+static int eeepc_hotk_restore(struct device *device)
 {
+	struct eeepc_laptop *eeepc = dev_get_drvdata(device);
+
 	/* Refresh both wlan rfkill state and pci hotplug */
 	if (eeepc->wlan_rfkill)
-		eeepc_rfkill_hotplug();
+		eeepc_rfkill_hotplug(eeepc);
 
 	if (eeepc->bluetooth_rfkill)
 		rfkill_set_sw_state(eeepc->bluetooth_rfkill,
-				    get_acpi(CM_ASL_BLUETOOTH) != 1);
+				    get_acpi(eeepc, CM_ASL_BLUETOOTH) != 1);
 	if (eeepc->wwan3g_rfkill)
 		rfkill_set_sw_state(eeepc->wwan3g_rfkill,
-				    get_acpi(CM_ASL_3G) != 1);
+				    get_acpi(eeepc, CM_ASL_3G) != 1);
 	if (eeepc->wimax_rfkill)
 		rfkill_set_sw_state(eeepc->wimax_rfkill,
-				    get_acpi(CM_ASL_WIMAX) != 1);
+				    get_acpi(eeepc, CM_ASL_WIMAX) != 1);
 
 	return 0;
 }
 
 static struct dev_pm_ops eeepc_pm_ops = {
-	.thaw = eeepc_thaw,
-	.restore = eeepc_restore,
+	.thaw = eeepc_hotk_thaw,
+	.restore = eeepc_hotk_restore,
 };
 
 static struct platform_driver platform_driver = {
@@ -947,35 +986,35 @@ static struct attribute_group hwmon_attribute_group = {
 	.attrs = hwmon_attributes
 };
 
-static void eeepc_hwmon_exit(void)
+static void eeepc_hwmon_exit(struct eeepc_laptop *eeepc)
 {
 	struct device *hwmon;
 
-	hwmon = eeepc_hwmon_device;
+	hwmon = eeepc->hwmon_device;
 	if (!hwmon)
-		return ;
+		return;
 	sysfs_remove_group(&hwmon->kobj,
 			   &hwmon_attribute_group);
 	hwmon_device_unregister(hwmon);
-	eeepc_hwmon_device = NULL;
+	eeepc->hwmon_device = NULL;
 }
 
-static int eeepc_hwmon_init(struct device *dev)
+static int eeepc_hwmon_init(struct eeepc_laptop *eeepc)
 {
 	struct device *hwmon;
 	int result;
 
-	hwmon = hwmon_device_register(dev);
+	hwmon = hwmon_device_register(&eeepc->platform_device->dev);
 	if (IS_ERR(hwmon)) {
 		pr_err("Could not register eeepc hwmon device\n");
-		eeepc_hwmon_device = NULL;
+		eeepc->hwmon_device = NULL;
 		return PTR_ERR(hwmon);
 	}
-	eeepc_hwmon_device = hwmon;
+	eeepc->hwmon_device = hwmon;
 	result = sysfs_create_group(&hwmon->kobj,
 				    &hwmon_attribute_group);
 	if (result)
-		eeepc_hwmon_exit();
+		eeepc_hwmon_exit(eeepc);
 	return result;
 }
 
@@ -984,12 +1023,16 @@ static int eeepc_hwmon_init(struct device *dev)
  */
 static int read_brightness(struct backlight_device *bd)
 {
-	return get_acpi(CM_ASL_PANELBRIGHT);
+	struct eeepc_laptop *eeepc = bl_get_data(bd);
+
+	return get_acpi(eeepc, CM_ASL_PANELBRIGHT);
 }
 
 static int set_brightness(struct backlight_device *bd, int value)
 {
-	return set_acpi(CM_ASL_PANELBRIGHT, value);
+	struct eeepc_laptop *eeepc = bl_get_data(bd);
+
+	return set_acpi(eeepc, CM_ASL_PANELBRIGHT, value);
 }
 
 static int update_bl_status(struct backlight_device *bd)
@@ -1002,9 +1045,9 @@ static struct backlight_ops eeepcbl_ops = {
 	.update_status = update_bl_status,
 };
 
-static int eeepc_backlight_notify(void)
+static int eeepc_backlight_notify(struct eeepc_laptop *eeepc)
 {
-	struct backlight_device *bd = eeepc_backlight_device;
+	struct backlight_device *bd = eeepc->backlight_device;
 	int old = bd->props.brightness;
 
 	backlight_force_update(bd, BACKLIGHT_UPDATE_HOTKEY);
@@ -1012,52 +1055,55 @@ static int eeepc_backlight_notify(void)
 	return old;
 }
 
-static int eeepc_backlight_init(struct device *dev)
+static int eeepc_backlight_init(struct eeepc_laptop *eeepc)
 {
 	struct backlight_device *bd;
 
-	bd = backlight_device_register(EEEPC_LAPTOP_FILE, dev,
-				       NULL, &eeepcbl_ops);
+	bd = backlight_device_register(EEEPC_LAPTOP_FILE,
+				       &eeepc->platform_device->dev,
+				       eeepc, &eeepcbl_ops);
 	if (IS_ERR(bd)) {
 		pr_err("Could not register eeepc backlight device\n");
-		eeepc_backlight_device = NULL;
+		eeepc->backlight_device = NULL;
 		return PTR_ERR(bd);
 	}
-	eeepc_backlight_device = bd;
+	eeepc->backlight_device = bd;
 	bd->props.max_brightness = 15;
-	bd->props.brightness = read_brightness(NULL);
+	bd->props.brightness = read_brightness(bd);
 	bd->props.power = FB_BLANK_UNBLANK;
 	backlight_update_status(bd);
 	return 0;
 }
 
-static void eeepc_backlight_exit(void)
+static void eeepc_backlight_exit(struct eeepc_laptop *eeepc)
 {
-	if (eeepc_backlight_device)
-		backlight_device_unregister(eeepc_backlight_device);
-	eeepc_backlight_device = NULL;
+	if (eeepc->backlight_device)
+		backlight_device_unregister(eeepc->backlight_device);
+	eeepc->backlight_device = NULL;
 }
 
 
 /*
  * Input device (i.e. hotkeys)
  */
-static struct key_entry *eeepc_get_entry_by_scancode(int code)
+static struct key_entry *eeepc_get_entry_by_scancode(
+	struct eeepc_laptop *eeepc,
+	int code)
 {
 	struct key_entry *key;
 
-	for (key = eeepc_keymap; key->type != KE_END; key++)
+	for (key = eeepc->keymap; key->type != KE_END; key++)
 		if (code == key->code)
 			return key;
 
 	return NULL;
 }
 
-static void eeepc_input_notify(int event)
+static void eeepc_input_notify(struct eeepc_laptop *eeepc, int event)
 {
 	static struct key_entry *key;
 
-	key = eeepc_get_entry_by_scancode(event);
+	key = eeepc_get_entry_by_scancode(eeepc, event);
 	if (key) {
 		switch (key->type) {
 		case KE_KEY:
@@ -1072,11 +1118,12 @@ static void eeepc_input_notify(int event)
 	}
 }
 
-static struct key_entry *eepc_get_entry_by_keycode(int code)
+static struct key_entry *eeepc_get_entry_by_keycode(
+	struct eeepc_laptop *eeepc, int code)
 {
 	struct key_entry *key;
 
-	for (key = eeepc_keymap; key->type != KE_END; key++)
+	for (key = eeepc->keymap; key->type != KE_END; key++)
 		if (code == key->keycode && key->type == KE_KEY)
 			return key;
 
@@ -1085,7 +1132,8 @@ static struct key_entry *eepc_get_entry_by_keycode(int code)
 
 static int eeepc_getkeycode(struct input_dev *dev, int scancode, int *keycode)
 {
-	struct key_entry *key = eeepc_get_entry_by_scancode(scancode);
+	struct eeepc_laptop *eeepc = input_get_drvdata(dev);
+	struct key_entry *key = eeepc_get_entry_by_scancode(eeepc, scancode);
 
 	if (key && key->type == KE_KEY) {
 		*keycode = key->keycode;
@@ -1097,18 +1145,19 @@ static int eeepc_getkeycode(struct input_dev *dev, int scancode, int *keycode)
 
 static int eeepc_setkeycode(struct input_dev *dev, int scancode, int keycode)
 {
+	struct eeepc_laptop *eeepc = input_get_drvdata(dev);
 	struct key_entry *key;
 	int old_keycode;
 
 	if (keycode < 0 || keycode > KEY_MAX)
 		return -EINVAL;
 
-	key = eeepc_get_entry_by_scancode(scancode);
+	key = eeepc_get_entry_by_scancode(eeepc, scancode);
 	if (key && key->type == KE_KEY) {
 		old_keycode = key->keycode;
 		key->keycode = keycode;
 		set_bit(keycode, dev->keybit);
-		if (!eepc_get_entry_by_keycode(old_keycode))
+		if (!eeepc_get_entry_by_keycode(eeepc, old_keycode))
 			clear_bit(old_keycode, dev->keybit);
 		return 0;
 	}
@@ -1116,7 +1165,7 @@ static int eeepc_setkeycode(struct input_dev *dev, int scancode, int keycode)
 	return -EINVAL;
 }
 
-static int eeepc_input_init(struct device *dev)
+static int eeepc_input_init(struct eeepc_laptop *eeepc)
 {
 	const struct key_entry *key;
 	int result;
@@ -1127,12 +1176,15 @@ static int eeepc_input_init(struct device *dev)
 		return -ENOMEM;
 	}
 	eeepc->inputdev->name = "Asus EeePC extra buttons";
-	eeepc->inputdev->dev.parent = dev;
+	eeepc->inputdev->dev.parent = &eeepc->platform_device->dev;
 	eeepc->inputdev->phys = EEEPC_LAPTOP_FILE "/input0";
 	eeepc->inputdev->id.bustype = BUS_HOST;
 	eeepc->inputdev->getkeycode = eeepc_getkeycode;
 	eeepc->inputdev->setkeycode = eeepc_setkeycode;
+	input_set_drvdata(eeepc->inputdev, eeepc);
 
+	eeepc->keymap = kmemdup(eeepc_keymap, sizeof(eeepc_keymap),
+				GFP_KERNEL);
 	for (key = eeepc_keymap; key->type != KE_END; key++) {
 		switch (key->type) {
 		case KE_KEY:
@@ -1150,10 +1202,12 @@ static int eeepc_input_init(struct device *dev)
 	return 0;
 }
 
-static void eeepc_input_exit(void)
+static void eeepc_input_exit(struct eeepc_laptop *eeepc)
 {
-	if (eeepc->inputdev)
+	if (eeepc->inputdev) {
 		input_unregister_device(eeepc->inputdev);
+		kfree(eeepc->keymap);
+	}
 }
 
 /*
@@ -1161,21 +1215,22 @@ static void eeepc_input_exit(void)
  */
 static void eeepc_acpi_notify(struct acpi_device *device, u32 event)
 {
+	struct eeepc_laptop *eeepc = acpi_driver_data(device);
 	u16 count;
 
 	if (event > ACPI_MAX_SYS_NOTIFY)
 		return;
 	count = eeepc->event_count[event % 128]++;
-	acpi_bus_generate_proc_event(eeepc->device, event, count);
-	acpi_bus_generate_netlink_event(eeepc->device->pnp.device_class,
-					dev_name(&eeepc->device->dev), event,
+	acpi_bus_generate_proc_event(device, event, count);
+	acpi_bus_generate_netlink_event(device->pnp.device_class,
+					dev_name(&device->dev), event,
 					count);
 
 	if (event >= NOTIFY_BRN_MIN && event <= NOTIFY_BRN_MAX) {
 		int old_brightness, new_brightness;
 
 		/* Update backlight device. */
-		old_brightness = eeepc_backlight_notify();
+		old_brightness = eeepc_backlight_notify(eeepc);
 
 		/* Convert brightness event to keypress (obsolescent hack). */
 		new_brightness = event - NOTIFY_BRN_MIN;
@@ -1191,10 +1246,10 @@ static void eeepc_acpi_notify(struct acpi_device *device, u32 event)
 			 */
 		}
 	}
-	eeepc_input_notify(event);
+	eeepc_input_notify(eeepc, event);
 }
 
-static void cmsg_quirk(int cm, const char *name)
+static void cmsg_quirk(struct eeepc_laptop *eeepc, int cm, const char *name)
 {
 	int dummy;
 
@@ -1208,23 +1263,23 @@ static void cmsg_quirk(int cm, const char *name)
 	}
 }
 
-static void cmsg_quirks(void)
+static void cmsg_quirks(struct eeepc_laptop *eeepc)
 {
-	cmsg_quirk(CM_ASL_LID, "LID");
-	cmsg_quirk(CM_ASL_TYPE, "TYPE");
-	cmsg_quirk(CM_ASL_PANELPOWER, "PANELPOWER");
-	cmsg_quirk(CM_ASL_TPD, "TPD");
+	cmsg_quirk(eeepc, CM_ASL_LID, "LID");
+	cmsg_quirk(eeepc, CM_ASL_TYPE, "TYPE");
+	cmsg_quirk(eeepc, CM_ASL_PANELPOWER, "PANELPOWER");
+	cmsg_quirk(eeepc, CM_ASL_TPD, "TPD");
 }
 
-static int eeepc_acpi_init(void)
+static int eeepc_acpi_init(struct eeepc_laptop *eeepc, struct acpi_device *device)
 {
 	unsigned int init_flags;
 	int result;
 
-	result = acpi_bus_get_status(eeepc->device);
+	result = acpi_bus_get_status(device);
 	if (result)
 		return result;
-	if (!eeepc->device->status.present) {
+	if (!device->status.present) {
 		pr_err("Hotkey device not present, aborting\n");
 		return -ENODEV;
 	}
@@ -1242,25 +1297,27 @@ static int eeepc_acpi_init(void)
 		pr_err("Get control methods supported failed\n");
 		return -ENODEV;
 	}
-	cmsg_quirks();
+	cmsg_quirks(eeepc);
 	pr_info("Get control methods supported: 0x%x\n", eeepc->cm_supported);
 
 	return 0;
 }
 
-static void __devinit eeepc_enable_camera(void)
+static void __devinit eeepc_enable_camera(struct eeepc_laptop *eeepc)
 {
 	/*
 	 * If the following call to set_acpi() fails, it's because there's no
 	 * camera so we can ignore the error.
 	 */
-	if (get_acpi(CM_ASL_CAMERA) == 0)
-		set_acpi(CM_ASL_CAMERA, 1);
+	if (get_acpi(eeepc, CM_ASL_CAMERA) == 0)
+		set_acpi(eeepc, CM_ASL_CAMERA, 1);
 }
 
+static bool eeepc_device_present;
+
 static int __devinit eeepc_acpi_add(struct acpi_device *device)
 {
-	struct device *dev;
+	struct eeepc_laptop *eeepc;
 	int result;
 
 	pr_notice(EEEPC_LAPTOP_NAME "\n");
@@ -1271,53 +1328,64 @@ static int __devinit eeepc_acpi_add(struct acpi_device *device)
 	strcpy(acpi_device_name(device), EEEPC_ACPI_DEVICE_NAME);
 	strcpy(acpi_device_class(device), EEEPC_ACPI_CLASS);
 	device->driver_data = eeepc;
-	eeepc->device = device;
 
-	result = eeepc_acpi_init();
+	result = eeepc_acpi_init(eeepc, device);
 	if (result)
 		goto fail_platform;
-	eeepc_enable_camera();
+	eeepc_enable_camera(eeepc);
 
-	result = eeepc_platform_init();
+	/*
+	 * Register the platform device first.  It is used as a parent for the
+	 * sub-devices below.
+	 *
+	 * Note that if there are multiple instances of this ACPI device it
+	 * will bail out, because the platform device is registered with a
+	 * fixed name.  Of course it doesn't make sense to have more than one,
+	 * and machine-specific scripts find the fixed name convenient.  But
+	 * It's also good for us to exclude multiple instances because both
+	 * our hwmon and our wlan rfkill subdevice use global ACPI objects
+	 * (the EC and the wlan PCI slot respectively).
+	 */
+	result = eeepc_platform_init(eeepc);
 	if (result)
 		goto fail_platform;
-	dev = &platform_device->dev;
 
 	if (!acpi_video_backlight_support()) {
-		result = eeepc_backlight_init(dev);
+		result = eeepc_backlight_init(eeepc);
 		if (result)
 			goto fail_backlight;
 	} else
 		pr_info("Backlight controlled by ACPI video driver\n");
 
-	result = eeepc_input_init(dev);
+	result = eeepc_input_init(eeepc);
 	if (result)
 		goto fail_input;
 
-	result = eeepc_hwmon_init(dev);
+	result = eeepc_hwmon_init(eeepc);
 	if (result)
 		goto fail_hwmon;
 
-	result = eeepc_led_init(dev);
+	result = eeepc_led_init(eeepc);
 	if (result)
 		goto fail_led;
 
-	result = eeepc_rfkill_init(dev);
+	result = eeepc_rfkill_init(eeepc);
 	if (result)
 		goto fail_rfkill;
 
+	eeepc_device_present = true;
 	return 0;
 
 fail_rfkill:
-	eeepc_led_exit();
+	eeepc_led_exit(eeepc);
 fail_led:
-	eeepc_hwmon_exit();
+	eeepc_hwmon_exit(eeepc);
 fail_hwmon:
-	eeepc_input_exit();
+	eeepc_input_exit(eeepc);
 fail_input:
-	eeepc_backlight_exit();
+	eeepc_backlight_exit(eeepc);
 fail_backlight:
-	eeepc_platform_exit();
+	eeepc_platform_exit(eeepc);
 fail_platform:
 	kfree(eeepc);
 
@@ -1326,12 +1394,14 @@ fail_platform:
 
 static int eeepc_acpi_remove(struct acpi_device *device, int type)
 {
-	eeepc_backlight_exit();
-	eeepc_rfkill_exit();
-	eeepc_input_exit();
-	eeepc_hwmon_exit();
-	eeepc_led_exit();
-	eeepc_platform_exit();
+	struct eeepc_laptop *eeepc = acpi_driver_data(device);
+
+	eeepc_backlight_exit(eeepc);
+	eeepc_rfkill_exit(eeepc);
+	eeepc_input_exit(eeepc);
+	eeepc_hwmon_exit(eeepc);
+	eeepc_led_exit(eeepc);
+	eeepc_platform_exit(eeepc);
 
 	kfree(eeepc);
 	return 0;
@@ -1369,7 +1439,7 @@ static int __init eeepc_laptop_init(void)
 	result = acpi_bus_register_driver(&eeepc_acpi_driver);
 	if (result < 0)
 		goto fail_acpi_driver;
-	if (!eeepc) {
+	if (!eeepc_device_present) {
 		result = -ENODEV;
 		goto fail_no_device;
 	}
-- 
1.6.0.6

