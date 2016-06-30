From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 4/5] acpi: dptf_power: Add DPTF power participant
Date: Wed, 29 Jun 2016 17:00:18 -0700
Message-ID: <1467244819-19046-5-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1467244819-19046-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18366 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504AbcF2X6y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jun 2016 19:58:54 -0400
In-Reply-To: <1467244819-19046-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This driver adds support for Dynamic Platform and Thermal Framework
(DPTF) Platform Power Participant device support.
This participant is responsible for exposing platform telemetry such as
platform Power, battery Information such as state of Charge, estimated
maximum sustainable power (PMax), SMART battery spec information.

This driver is implemented as a platform driver for INT3407. This driver
uses services of battery_common to read battery information and state to
avoid code duplication.
Optionally this can register with power supply class and can act as
ACPI Battery. This feature is activated only when CONFIG_ACPI_BATTERY
is not defined in the configuration

There are two types of objects in INT3407:
- Same as ACPI Battery objects: _BST and _BIX. They are read directly
using the interface from battery_common
- Specific to INT3407: These objects are read directly executing
ACPI methods in this module.
These attributes are presented via sysfs interface under the INT3407
platform device:

#ls /sys/bus/platform/devices/INT3407\:00/dptf_power/
adapter_rating_mw
charger_type
design_capacity_warning_mwh
oem_info
remaining_capacity_mwh
battery_steady_power_mw
charging_state
design_voltage_mv
platform_power_source
serial_number
capacity_granularity_1_mwh
cycle_count
last_full_charge_capacity_mwh
power_sampling_period_us  type
capacity_granularity_2_mwh
design_capacity_low_mwh
max_platform_power_mw
present_rate_mw
capacity_state
design_capacity_mwh
model_number
present_voltage_mv

ACPI methods description used in this driver:
PSOC: Platform Battery State Of Charge as a percentage.
PMAX: Maximum platform power that can be supported by the battery in mW.
PSRC: System charge source,
        0x00 = DC
        0x01 = AC
        0x02 = USB
        0x03 = Wireless Charger
ARTG: Adapter rating in mW (Maximum Adapter power) Must be 0 if no AC
        Adaptor is plugged in.
CTYP: Charger Type,
        Traditional : 0x01
        Hybrid: 0x02
        NVDC: 0x03
PBSS: Returns max sustained power for battery in milliWatts.
DPSP: Polling interval in 10ths of seconds.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/Kconfig           |   1 +
 drivers/acpi/Makefile          |   1 +
 drivers/acpi/dptf/Kconfig      |  17 +++
 drivers/acpi/dptf/Makefile     |   3 +
 drivers/acpi/dptf/dptf_power.c | 286 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 308 insertions(+)
 create mode 100644 drivers/acpi/dptf/Kconfig
 create mode 100644 drivers/acpi/dptf/Makefile
 create mode 100644 drivers/acpi/dptf/dptf_power.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 27ae351..da8c575 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -480,6 +480,7 @@ config ACPI_NFIT_DEBUG
 	  issue.
 
 source "drivers/acpi/apei/Kconfig"
+source "drivers/acpi/dptf/Kconfig"
 
 config ACPI_EXTLOG
 	tristate "Extended Error Log support"
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 950bf8e..8555c14 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -102,3 +102,4 @@ obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
 obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
 
 video-objs			+= acpi_video.o video_detect.o
+obj-y				+= dptf/
diff --git a/drivers/acpi/dptf/Kconfig b/drivers/acpi/dptf/Kconfig
new file mode 100644
index 0000000..bce8edf
--- /dev/null
+++ b/drivers/acpi/dptf/Kconfig
@@ -0,0 +1,17 @@
+config DPTF_POWER
+	tristate "DPTF Platform Power Participant"
+	depends on X86
+	select ACPI_BATTERY_COMMON
+	select POWER_SUPPLY
+	default y
+	help
+	  This driver adds support for Dynamic Platform and Thermal Framework
+	  (DPTF) Platform Power Participant device support.
+	  This participant is responsible for exposing platform telemetry such
+	  as platform Power, battery Information such as state of Charge,
+	  estimated maximum sustainable power (PMax), SMART battery spec
+	  information.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called dptf_power.
+
diff --git a/drivers/acpi/dptf/Makefile b/drivers/acpi/dptf/Makefile
new file mode 100644
index 0000000..1b6d8bd
--- /dev/null
+++ b/drivers/acpi/dptf/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_DPTF_POWER)	+= dptf_power.o
+
+ccflags-y += -Idrivers/acpi
diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
new file mode 100644
index 0000000..f239da7
--- /dev/null
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -0,0 +1,286 @@
+/*
+ * dptf_power:  DPTF platform power driver
+ * Copyright (c) 2016, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+#include "battery.h"
+
+/*
+ * Presentation of attributes which are only defined for INT3407. They are:
+ * PMAX : Maximum platform powe
+ * PSRC : Platform power source
+ * ARTG : Adapter rating
+ * CTYP : Charger type
+ * PBSS : Battery steady power
+ * DPSP : power sampling period
+ */
+#define DPTF_POWER_SHOW(name, object) \
+static ssize_t name##_show(struct device *dev,\
+			   struct device_attribute *attr,\
+			   char *buf)\
+{\
+	struct platform_device *pdev = to_platform_device(dev); \
+	struct acpi_device *acpi_dev = platform_get_drvdata(pdev);\
+	unsigned long long val;\
+	acpi_status status;\
+	int multiplier = 1;\
+\
+	status = acpi_evaluate_integer(acpi_dev->handle, #object,\
+				       NULL, &val);\
+	if (ACPI_SUCCESS(status)) {\
+		if (!strcmp(#object, "DPSP")) \
+			multiplier = 100; \
+		return sprintf(buf, "%d\n", ((int)val * multiplier));\
+	} else {\
+		return -EINVAL;\
+	} \
+}
+
+DPTF_POWER_SHOW(max_platform_power_mw, PMAX)
+DPTF_POWER_SHOW(platform_power_source, PSRC)
+DPTF_POWER_SHOW(adapter_rating_mw, ARTG)
+DPTF_POWER_SHOW(charger_type, CTYP)
+DPTF_POWER_SHOW(battery_steady_power_mw, PBSS)
+DPTF_POWER_SHOW(power_sampling_period_us, DPSP)
+
+static DEVICE_ATTR_RO(max_platform_power_mw);
+static DEVICE_ATTR_RO(platform_power_source);
+static DEVICE_ATTR_RO(adapter_rating_mw);
+static DEVICE_ATTR_RO(battery_steady_power_mw);
+static DEVICE_ATTR_RO(power_sampling_period_us);
+static DEVICE_ATTR_RO(charger_type);
+
+/*
+ * Attributes read via _BST and _BIX methods. These fields are populated in
+ * battery_common part. Here they are just presented in sysfs
+ */
+#define BATTERY_INFO_SHOW(name, format, object) \
+static ssize_t name##_show(struct device *dev,\
+			   struct device_attribute *attr,\
+			   char *buf)\
+{\
+	struct platform_device *pdev = to_platform_device(dev); \
+	struct acpi_device *acpi_dev = platform_get_drvdata(pdev);\
+	struct acpi_battery *battery = acpi_driver_data(acpi_dev);\
+	int result;\
+	\
+	result = acpi_battery_update(battery, false);\
+	if (result) \
+		return result;\
+	\
+	return sprintf(buf, #format, battery->object);\
+}
+BATTERY_INFO_SHOW(design_capacity_mwh, %d\n, design_capacity)
+BATTERY_INFO_SHOW(last_full_charge_capacity_mwh, %d\n, full_charge_capacity);
+BATTERY_INFO_SHOW(design_voltage_mv, %d\n, design_voltage);
+BATTERY_INFO_SHOW(design_capacity_warning_mwh, %d\n, design_capacity_warning);
+BATTERY_INFO_SHOW(design_capacity_low_mwh, %d\n, design_capacity_low);
+BATTERY_INFO_SHOW(cycle_count, %d\n, cycle_count);
+BATTERY_INFO_SHOW(capacity_granularity_1_mwh, %d\n, capacity_granularity_1);
+BATTERY_INFO_SHOW(capacity_granularity_2_mwh, %d\n, capacity_granularity_2);
+BATTERY_INFO_SHOW(model_number, %s\n, model_number);
+BATTERY_INFO_SHOW(serial_number, %s\n, serial_number);
+BATTERY_INFO_SHOW(type, %s\n, type);
+BATTERY_INFO_SHOW(oem_info, %s\n, oem_info);
+BATTERY_INFO_SHOW(present_rate_mw, %d\n, rate_now);
+BATTERY_INFO_SHOW(remaining_capacity_mwh, %d\n, capacity_now);
+BATTERY_INFO_SHOW(present_voltage_mv, %d\n, voltage_now);
+
+static DEVICE_ATTR_RO(design_capacity_mwh);
+static DEVICE_ATTR_RO(last_full_charge_capacity_mwh);
+static DEVICE_ATTR_RO(design_voltage_mv);
+static DEVICE_ATTR_RO(design_capacity_warning_mwh);
+static DEVICE_ATTR_RO(design_capacity_low_mwh);
+static DEVICE_ATTR_RO(cycle_count);
+static DEVICE_ATTR_RO(capacity_granularity_1_mwh);
+static DEVICE_ATTR_RO(capacity_granularity_2_mwh);
+static DEVICE_ATTR_RO(model_number);
+static DEVICE_ATTR_RO(serial_number);
+static DEVICE_ATTR_RO(type);
+static DEVICE_ATTR_RO(oem_info);
+static DEVICE_ATTR_RO(present_rate_mw);
+static DEVICE_ATTR_RO(remaining_capacity_mwh);
+static DEVICE_ATTR_RO(present_voltage_mv);
+
+/*
+ * Capacity and charging state need special handler to interpret and present
+ * in string format
+ */
+static ssize_t capacity_state_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct acpi_device *acpi_dev = platform_get_drvdata(pdev);
+	struct acpi_battery *battery = acpi_driver_data(acpi_dev);
+	int result;
+
+	result = acpi_battery_update(battery, false);
+	if (result)
+		return result;
+
+	if (battery->state & 0x04)
+		return sprintf(buf, "critical");
+	else
+		return sprintf(buf, "ok");
+}
+static DEVICE_ATTR_RO(capacity_state);
+
+static ssize_t charging_state_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct acpi_device *acpi_dev = platform_get_drvdata(pdev);
+	struct acpi_battery *battery = acpi_driver_data(acpi_dev);
+	int result;
+
+	result = acpi_battery_update(battery, false);
+	if (result)
+		return result;
+
+	if ((battery->state & 0x01) && (battery->state & 0x02))
+		return sprintf(buf, "charging/discharging\n");
+	else if (battery->state & 0x01)
+		return sprintf(buf, "discharging\n");
+	else if (battery->state & 0x02)
+		return sprintf(buf, "charging\n");
+	else
+		return sprintf(buf, "charged\n");
+}
+static DEVICE_ATTR_RO(charging_state);
+
+static struct attribute *dptf_power_attrs[] = {
+	&dev_attr_max_platform_power_mw.attr,
+	&dev_attr_platform_power_source.attr,
+	&dev_attr_adapter_rating_mw.attr,
+	&dev_attr_charger_type.attr,
+	&dev_attr_battery_steady_power_mw.attr,
+	&dev_attr_power_sampling_period_us.attr,
+	&dev_attr_design_capacity_mwh.attr,
+	&dev_attr_last_full_charge_capacity_mwh.attr,
+	&dev_attr_design_voltage_mv.attr,
+	&dev_attr_design_capacity_warning_mwh.attr,
+	&dev_attr_design_capacity_low_mwh.attr,
+	&dev_attr_cycle_count.attr,
+	&dev_attr_capacity_granularity_1_mwh.attr,
+	&dev_attr_capacity_granularity_2_mwh.attr,
+	&dev_attr_model_number.attr,
+	&dev_attr_serial_number.attr,
+	&dev_attr_type.attr,
+	&dev_attr_oem_info.attr,
+	&dev_attr_capacity_state.attr,
+	&dev_attr_charging_state.attr,
+	&dev_attr_present_rate_mw.attr,
+	&dev_attr_remaining_capacity_mwh.attr,
+	&dev_attr_present_voltage_mv.attr,
+	NULL
+};
+
+static struct attribute_group dptf_power_attribute_group = {
+	.attrs = dptf_power_attrs,
+	.name = "dptf_power"
+};
+
+static void dptf_power_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_device *device = data;
+
+	acpi_battery_common_notify(device, event);
+}
+
+static int dptf_power_add(struct platform_device *pdev)
+{
+	struct acpi_device *acpi_dev;
+	acpi_status status;
+	unsigned long long ptype;
+	int result;
+
+	acpi_dev = ACPI_COMPANION(&(pdev->dev));
+	if (!acpi_dev)
+		return -ENODEV;
+
+	status = acpi_evaluate_integer(acpi_dev->handle, "PTYP", NULL, &ptype);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	if (ptype != 0x11)
+		return -ENODEV;
+
+#if IS_ENABLED(CONFIG_ACPI_BATTERY)
+	result = acpi_battery_common_add(acpi_dev, false);
+#else
+	result = acpi_battery_common_add(acpi_dev, true);
+#endif
+	if (result)
+		return result;
+
+	result = sysfs_create_group(&pdev->dev.kobj,
+				    &dptf_power_attribute_group);
+	if (result)
+		goto error_remove_battery;
+
+	result = acpi_install_notify_handler(acpi_dev->handle,
+					     ACPI_DEVICE_NOTIFY,
+					     dptf_power_notify,
+					     (void *)acpi_dev);
+	if (result)
+		goto error_remove_sysfs;
+
+	platform_set_drvdata(pdev, acpi_dev);
+
+	return 0;
+
+error_remove_sysfs:
+	sysfs_remove_group(&pdev->dev.kobj, &dptf_power_attribute_group);
+error_remove_battery:
+	acpi_battery_common_remove(acpi_dev);
+	return result;
+}
+
+static int dptf_power_remove(struct platform_device *pdev)
+{
+	struct acpi_device *acpi_dev = platform_get_drvdata(pdev);
+
+	acpi_remove_notify_handler(acpi_dev->handle, ACPI_DEVICE_NOTIFY,
+				   dptf_power_notify);
+	sysfs_remove_group(&pdev->dev.kobj, &dptf_power_attribute_group);
+	acpi_battery_common_remove(acpi_dev);
+
+	return 0;
+}
+
+static const struct acpi_device_id int3407_device_ids[] = {
+	{"INT3407", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, int3407_device_ids);
+
+static struct platform_driver dptf_power_driver = {
+	.probe = dptf_power_add,
+	.remove = dptf_power_remove,
+	.driver = {
+		.name = "DPTF Platform Power",
+		.acpi_match_table = int3407_device_ids,
+	},
+};
+
+module_platform_driver(dptf_power_driver);
+
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ACPI DPTF platform power driver");
-- 
2.5.0

