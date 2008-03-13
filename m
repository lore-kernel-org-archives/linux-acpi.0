From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 3/3] eeepc-laptop: add hwmon fan control
Date: Thu, 13 Mar 2008 12:57:18 +0100
Message-ID: <200803131257.18837.corentincj@iksaif.net>
References: <200803131254.01518.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:52810 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318AbYCML5v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Mar 2008 07:57:51 -0400
In-Reply-To: <200803131254.01518.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: acpi4asus-user@lists.sourceforge.net, eeecommunity-donated@lists.sourceforge.net, linux-acpi@vger.kernel.org

From: Corentin Chary <corentincj@iksaif.net>

Adds an hwmon interface to control the fan.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---

 Kconfig        |    1 
 eeepc-laptop.c |  147 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)

--- a/drivers/misc/eeepc-laptop.c	2008-03-11 10:37:04.000000000 +0100
+++ b/drivers/misc/eeepc-laptop.c	2008-03-11 18:42:51.000000000 +0100
@@ -23,6 +23,8 @@
 #include <linux/platform_device.h>
 #include <linux/backlight.h>
 #include <linux/fb.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
@@ -103,6 +105,15 @@
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
@@ -154,6 +165,9 @@
 /* The backlight device /sys/class/backlight */
 static struct backlight_device *eeepc_backlight_device;
 
+/* The hwmon device */
+static struct device *eeepc_hwmon_device;
+
 /*
  * The backlight class declaration
  */
@@ -429,6 +443,100 @@
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
@@ -438,9 +546,23 @@
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
@@ -468,6 +590,26 @@
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
@@ -486,6 +628,9 @@
 	result = eeepc_backlight_init(dev);
 	if (result)
 		goto fail_backlight;
+	result = eeepc_hwmon_init(dev);
+	if (result)
+		goto fail_hwmon;
 	/* Register platform stuff */
 	result = platform_driver_register(&platform_driver);
 	if (result)
@@ -510,6 +655,8 @@
 fail_platform_device1:
 	platform_driver_unregister(&platform_driver);
 fail_platform_driver:
+	eeepc_hwmon_exit();
+fail_hwmon:
 	eeepc_backlight_exit();
 fail_backlight:
 	return result;
--- a/drivers/misc/Kconfig	2008-03-11 18:43:26.000000000 +0100
+++ b/drivers/misc/Kconfig	2008-03-11 18:38:51.000000000 +0100
@@ -237,6 +237,7 @@
 	depends on X86
 	depends on ACPI
 	depends on BACKLIGHT_CLASS_DEVICE
+	depends on HWMON
 	depends on EXPERIMENTAL
 	---help---
 	  This driver supports the Fn-Fx keys on Eee PC laptops.
