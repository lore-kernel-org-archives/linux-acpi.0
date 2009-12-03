From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 08/33] eeepc-laptop: add touchpad led
Date: Thu,  3 Dec 2009 08:44:52 +0100
Message-ID: <1259826317-18809-9-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-5-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-6-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-7-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-8-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44221 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753597AbZLCHod (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:33 -0500
In-Reply-To: <1259826317-18809-8-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

This led can be found on Eeepc 1005 series.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/Kconfig        |    2 +
 drivers/platform/x86/eeepc-laptop.c |   67 +++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 55ca39d..e5e4312 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -334,6 +334,8 @@ config EEEPC_LAPTOP
 	depends on HOTPLUG_PCI
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON
+	select LEDS_CLASS
+	select NEW_LEDS
 	---help---
 	  This driver supports the Fn-Fx keys on Eee PC laptops.
 
diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 2c65a37..9130434 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -34,6 +34,7 @@
 #include <linux/rfkill.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
+#include <linux/leds.h>
 
 #define EEEPC_LAPTOP_VERSION	"0.1"
 
@@ -507,6 +508,39 @@ static struct attribute_group platform_attribute_group = {
 };
 
 /*
+ * LEDs
+ */
+/*
+ * These functions actually update the LED's, and are called from a
+ * workqueue. By doing this as separate work rather than when the LED
+ * subsystem asks, we avoid messing with the Asus ACPI stuff during a
+ * potentially bad time, such as a timer interrupt.
+ */
+static int tpd_led_wk;
+
+static void tpd_led_update(struct work_struct *ignored)
+{
+	int value = tpd_led_wk;
+	set_acpi(CM_ASL_TPD, value);
+}
+
+static struct workqueue_struct *led_workqueue;
+static DECLARE_WORK(tpd_led_work, tpd_led_update);
+
+static void tpd_led_set(struct led_classdev *led_cdev,
+			enum led_brightness value)
+{
+	tpd_led_wk = (value > 0) ? 1 : 0;
+	queue_work(led_workqueue, &tpd_led_work);
+}
+
+static struct led_classdev tpd_led = {
+	.name           = "eeepc::touchpad",
+	.brightness_set = tpd_led_set,
+	.max_brightness = 1
+};
+
+/*
  * Hotkey functions
  */
 static struct key_entry *eepc_get_entry_by_scancode(int code)
@@ -1034,6 +1068,14 @@ static void eeepc_hwmon_exit(void)
 	eeepc_hwmon_device = NULL;
 }
 
+static void eeepc_led_exit(void)
+{
+	if (led_workqueue)
+		destroy_workqueue(led_workqueue);
+	if (tpd_led.dev)
+		led_classdev_unregister(&tpd_led);
+}
+
 static int eeepc_new_rfkill(struct rfkill **rfkill,
 			    const char *name, struct device *dev,
 			    enum rfkill_type type, int cm)
@@ -1190,6 +1232,24 @@ static int eeepc_input_init(struct device *dev)
 	return 0;
 }
 
+static int eeepc_led_init(struct device *dev)
+{
+	int rv;
+
+	if (get_acpi(CM_ASL_TPD) == -ENODEV)
+		return 0;
+
+	rv = led_classdev_register(dev, &tpd_led);
+	if (rv)
+		return rv;
+
+	led_workqueue = create_singlethread_workqueue("led_workqueue");
+	if (!led_workqueue)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int __devinit eeepc_hotk_add(struct acpi_device *device)
 {
 	struct device *dev;
@@ -1248,6 +1308,10 @@ static int __devinit eeepc_hotk_add(struct acpi_device *device)
 	if (result)
 		goto fail_hwmon;
 
+	result = eeepc_led_init(dev);
+	if (result)
+		goto fail_led;
+
 	result = eeepc_rfkill_init(dev);
 	if (result)
 		goto fail_rfkill;
@@ -1255,6 +1319,8 @@ static int __devinit eeepc_hotk_add(struct acpi_device *device)
 	return 0;
 
 fail_rfkill:
+	eeepc_led_exit();
+fail_led:
 	eeepc_hwmon_exit();
 fail_hwmon:
 	eeepc_input_exit();
@@ -1284,6 +1350,7 @@ static int eeepc_hotk_remove(struct acpi_device *device, int type)
 	eeepc_rfkill_exit();
 	eeepc_input_exit();
 	eeepc_hwmon_exit();
+	eeepc_led_exit();
 	sysfs_remove_group(&platform_device->dev.kobj,
 			   &platform_attribute_group);
 	platform_device_unregister(platform_device);
-- 
1.6.5.3

