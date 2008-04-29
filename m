From: Len Brown <lenb@kernel.org>
Subject: [PATCH 087/171] eeepc-laptop: add hwmon fan control
Date: Tue, 29 Apr 2008 04:44:08 -0400
Message-ID: <bc7f71ec03304d3c9959a4da993798502021bb84.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:28120 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755547AbYD2Io7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:44:59 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Adds an hwmon interface to control the fan.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/Kconfig        |    1 +
 drivers/misc/eeepc-laptop.c |  147 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index e9ab291..7547523 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -332,6 +332,7 @@ config EEEPC_LAPTOP
 	depends on X86
 	depends on ACPI
 	depends on BACKLIGHT_CLASS_DEVICE
+	depends on HWMON
 	depends on EXPERIMENTAL
 	---help---
 	  This driver supports the Fn-Fx keys on Eee PC laptops.
diff --git a/drivers/misc/eeepc-laptop.c b/drivers/misc/eeepc-laptop.c
index 2b59b7e..6d72760 100644
--- a/drivers/misc/eeepc-laptop.c
+++ b/drivers/misc/eeepc-laptop.c
@@ -23,6 +23,8 @@
 #include <linux/platform_device.h>
 #include <linux/backlight.h>
 #include <linux/fb.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 #include <linux/uaccess.h>
@@ -103,6 +105,15 @@ const char *cm_setv[] = {
 	"CRDS", NULL
 };
 
+#define EEEPC_EC	"\\_SB.PCI0.SBRG.EC0."
+
+#define EEEPC_EC_FAN_PWM	EEEPC_EC "SC02" /* Fan PWM duty cycle (%) */
+#define EEEPC_EC_SC02		0x63
+#define EEEPC_EC_FAN_HRPM	EEEPC_EC "SC05" /* High byte, fan speed (RPM) */
+#define EEEPC_EC_FAN_LRPM	EEEPC_EC "SC06" /* Low byte, fan speed (RPM) */
+#define EEEPC_EC_FAN_CTRL	EEEPC_EC "SFB3" /* Byte containing SF25  */
+#define EEEPC_EC_SFB3		0xD3
+
 /*
  * This is the main structure, we can use it to store useful information
  * about the hotk device
@@ -154,6 +165,9 @@ static struct acpi_driver eeepc_hotk_driver = {
 /* The backlight device /sys/class/backlight */
 static struct backlight_device *eeepc_backlight_device;
 
+/* The hwmon device */
+static struct device *eeepc_hwmon_device;
+
 /*
  * The backlight class declaration
  */
@@ -429,6 +443,100 @@ static int eeepc_hotk_remove(struct acpi_device *device, int type)
 }
 
 /*
+ * Hwmon
+ */
+static int eeepc_get_fan_pwm(void)
+{
+	int value = 0;
+
+	read_acpi_int(NULL, EEEPC_EC_FAN_PWM, &value);
+	return (value);
+}
+
+static void eeepc_set_fan_pwm(int value)
+{
+	value = SENSORS_LIMIT(value, 0, 100);
+	ec_write(EEEPC_EC_SC02, value);
+}
+
+static int eeepc_get_fan_rpm(void)
+{
+	int high = 0;
+	int low = 0;
+
+	read_acpi_int(NULL, EEEPC_EC_FAN_HRPM, &high);
+	read_acpi_int(NULL, EEEPC_EC_FAN_LRPM, &low);
+	return (high << 8 | low);
+}
+
+static int eeepc_get_fan_ctrl(void)
+{
+	int value = 0;
+
+	read_acpi_int(NULL, EEEPC_EC_FAN_CTRL, &value);
+	return ((value & 0x02 ? 1 : 0));
+}
+
+static void eeepc_set_fan_ctrl(int manual)
+{
+	int value = 0;
+
+	read_acpi_int(NULL, EEEPC_EC_FAN_CTRL, &value);
+	if (manual)
+		value |= 0x02;
+	else
+		value &= ~0x02;
+	ec_write(EEEPC_EC_SFB3, value);
+}
+
+static ssize_t store_sys_hwmon(void (*set)(int), const char *buf, size_t count)
+{
+	int rv, value;
+
+	rv = parse_arg(buf, count, &value);
+	if (rv > 0)
+		set(value);
+	return rv;
+}
+
+static ssize_t show_sys_hwmon(int (*get)(void), char *buf)
+{
+	return sprintf(buf, "%d\n", get());
+}
+
+#define EEEPC_CREATE_SENSOR_ATTR(_name, _mode, _set, _get)		\
+	static ssize_t show_##_name(struct device *dev,			\
+				    struct device_attribute *attr,	\
+				    char *buf)				\
+	{								\
+		return show_sys_hwmon(_set, buf);			\
+	}								\
+	static ssize_t store_##_name(struct device *dev,		\
+				     struct device_attribute *attr,	\
+				     const char *buf, size_t count)	\
+	{								\
+		return store_sys_hwmon(_get, buf, count);		\
+	}								\
+	static SENSOR_DEVICE_ATTR(_name, _mode, show_##_name, store_##_name, 0);
+
+EEEPC_CREATE_SENSOR_ATTR(fan1_input, S_IRUGO, eeepc_get_fan_rpm, NULL);
+EEEPC_CREATE_SENSOR_ATTR(fan1_pwm, S_IRUGO | S_IWUSR,
+			 eeepc_get_fan_pwm, eeepc_set_fan_pwm);
+EEEPC_CREATE_SENSOR_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
+			 eeepc_get_fan_ctrl, eeepc_set_fan_ctrl);
+
+static struct attribute *hwmon_attributes[] = {
+	&sensor_dev_attr_fan1_pwm.dev_attr.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group hwmon_attribute_group = {
+	.attrs = hwmon_attributes
+};
+
+/*
  * exit/init
  */
 static void eeepc_backlight_exit(void)
@@ -438,9 +546,23 @@ static void eeepc_backlight_exit(void)
 	eeepc_backlight_device = NULL;
 }
 
+static void eeepc_hwmon_exit(void)
+{
+	struct device *hwmon;
+
+	hwmon = eeepc_hwmon_device;
+	if (!hwmon)
+		return ;
+	hwmon_device_unregister(hwmon);
+	sysfs_remove_group(&hwmon->kobj,
+			   &hwmon_attribute_group);
+	eeepc_hwmon_device = NULL;
+}
+
 static void __exit eeepc_laptop_exit(void)
 {
 	eeepc_backlight_exit();
+	eeepc_hwmon_exit();
 	acpi_bus_unregister_driver(&eeepc_hotk_driver);
 	sysfs_remove_group(&platform_device->dev.kobj,
 			   &platform_attribute_group);
@@ -468,6 +590,26 @@ static int eeepc_backlight_init(struct device *dev)
 	return 0;
 }
 
+static int eeepc_hwmon_init(struct device *dev)
+{
+	struct device *hwmon;
+	int result;
+
+	hwmon = hwmon_device_register(dev);
+	if (IS_ERR(hwmon)) {
+		printk(EEEPC_ERR
+		       "Could not register eeepc hwmon device\n");
+		eeepc_hwmon_device = NULL;
+		return PTR_ERR(hwmon);
+	}
+	eeepc_hwmon_device = hwmon;
+	result = sysfs_create_group(&hwmon->kobj,
+				    &hwmon_attribute_group);
+	if (result)
+		eeepc_hwmon_exit();
+	return result;
+}
+
 static int __init eeepc_laptop_init(void)
 {
 	struct device *dev;
@@ -486,6 +628,9 @@ static int __init eeepc_laptop_init(void)
 	result = eeepc_backlight_init(dev);
 	if (result)
 		goto fail_backlight;
+	result = eeepc_hwmon_init(dev);
+	if (result)
+		goto fail_hwmon;
 	/* Register platform stuff */
 	result = platform_driver_register(&platform_driver);
 	if (result)
@@ -510,6 +655,8 @@ fail_platform_device2:
 fail_platform_device1:
 	platform_driver_unregister(&platform_driver);
 fail_platform_driver:
+	eeepc_hwmon_exit();
+fail_hwmon:
 	eeepc_backlight_exit();
 fail_backlight:
 	return result;
-- 
1.5.5.1.99.gf0ec4

