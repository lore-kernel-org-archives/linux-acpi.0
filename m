From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v5] acpi: dptf_power: Add DPTF power participant
Date: Sun, 17 Jul 2016 13:45:32 -0700
Message-ID: <1468788332-32518-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1468788332-32518-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:51927 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbcGQUrU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Jul 2016 16:47:20 -0400
In-Reply-To: <1468788332-32518-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This driver adds support for Dynamic Platform and Thermal Framework
(DPTF) Platform Power Participant device (INT3407) support.

This participant is responsible for exposing platform telemetry such as:
    max_platform_power
    platform_power_source
    adapter_rating
    battery_steady_power
    charger_type

These attributes are presented via sysfs interface under the INT3407
platform device:
$ls /sys/bus/platform/devices/INT3407\:00/dptf_power/
    adapter_rating_mw
    battery_steady_power_mw
    charger_type
    max_platform_power_mw
    platform_power_source
    `
ACPI methods description used in this driver:
    PMAX: Maximum platform power that can be supported by the battery in
          mW.
    PSRC: System charge source,
            0x00 = DC
            0x01 = AC
            0x02 = USB
            0x03 = Wireless Charger
    ARTG: Adapter rating in mW (Maximum Adapter power) Must be 0 if no
          AC adapter is plugged in.
    CTYP: Charger Type,
            Traditional : 0x01
            Hybrid: 0x02
            NVDC: 0x03
    PBSS: Returns max sustained power for battery in milliWatts.

The INT3407 also contains _BTS and _BIX objects, which are compliant to
ACPI 5.0, specification. Those objects are already used by ACPI battery
(PNP0C0A) driver and information about them is exported via Linux power
supply class registration.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/Kconfig           |   1 +
 drivers/acpi/Makefile          |   1 +
 drivers/acpi/dptf/Kconfig      |  16 ++++++
 drivers/acpi/dptf/Makefile     |   1 +
 drivers/acpi/dptf/dptf_power.c | 128 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 147 insertions(+)
 create mode 100644 drivers/acpi/dptf/Kconfig
 create mode 100644 drivers/acpi/dptf/Makefile
 create mode 100644 drivers/acpi/dptf/dptf_power.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b7e2e77..b91a35b 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -475,6 +475,7 @@ config ACPI_NFIT_DEBUG
 	  issue.
 
 source "drivers/acpi/apei/Kconfig"
+source "drivers/acpi/dptf/Kconfig"
 
 config ACPI_EXTLOG
 	tristate "Extended Error Log support"
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 251ce85..f6d0cc0 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -101,3 +101,4 @@ obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
 obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
 
 video-objs			+= acpi_video.o video_detect.o
+obj-y				+= dptf/
diff --git a/drivers/acpi/dptf/Kconfig b/drivers/acpi/dptf/Kconfig
new file mode 100644
index 0000000..684543a
--- /dev/null
+++ b/drivers/acpi/dptf/Kconfig
@@ -0,0 +1,16 @@
+config DPTF_POWER
+	tristate "DPTF Platform Power Participant"
+	depends on X86
+	help
+	  This driver adds support for Dynamic Platform and Thermal Framework
+	  (DPTF) Platform Power Participant device (INT3407) support.
+	  This participant is responsible for exposing platform telemetry:
+		max_platform_power
+		platform_power_source
+		adapter_rating
+		battery_steady_power
+		charger_type
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called dptf_power.
+
diff --git a/drivers/acpi/dptf/Makefile b/drivers/acpi/dptf/Makefile
new file mode 100644
index 0000000..62cbe87
--- /dev/null
+++ b/drivers/acpi/dptf/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_DPTF_POWER)	+= dptf_power.o
diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
new file mode 100644
index 0000000..734642d
--- /dev/null
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -0,0 +1,128 @@
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
+
+/*
+ * Presentation of attributes which are defined for INT3407. They are:
+ * PMAX : Maximum platform powe
+ * PSRC : Platform power source
+ * ARTG : Adapter rating
+ * CTYP : Charger type
+ * PBSS : Battery steady power
+ */
+#define DPTF_POWER_SHOW(name, object) \
+static ssize_t name##_show(struct device *dev,\
+			   struct device_attribute *attr,\
+			   char *buf)\
+{\
+	struct platform_device *pdev = to_platform_device(dev);\
+	struct acpi_device *acpi_dev = platform_get_drvdata(pdev);\
+	unsigned long long val;\
+	acpi_status status;\
+\
+	status = acpi_evaluate_integer(acpi_dev->handle, #object,\
+				       NULL, &val);\
+	if (ACPI_SUCCESS(status))\
+		return sprintf(buf, "%d\n", (int)val);\
+	else \
+		return -EINVAL;\
+}
+
+DPTF_POWER_SHOW(max_platform_power_mw, PMAX)
+DPTF_POWER_SHOW(platform_power_source, PSRC)
+DPTF_POWER_SHOW(adapter_rating_mw, ARTG)
+DPTF_POWER_SHOW(battery_steady_power_mw, PBSS)
+DPTF_POWER_SHOW(charger_type, CTYP)
+
+static DEVICE_ATTR_RO(max_platform_power_mw);
+static DEVICE_ATTR_RO(platform_power_source);
+static DEVICE_ATTR_RO(adapter_rating_mw);
+static DEVICE_ATTR_RO(battery_steady_power_mw);
+static DEVICE_ATTR_RO(charger_type);
+
+static struct attribute *dptf_power_attrs[] = {
+	&dev_attr_max_platform_power_mw.attr,
+	&dev_attr_platform_power_source.attr,
+	&dev_attr_adapter_rating_mw.attr,
+	&dev_attr_battery_steady_power_mw.attr,
+	&dev_attr_charger_type.attr,
+	NULL
+};
+
+static struct attribute_group dptf_power_attribute_group = {
+	.attrs = dptf_power_attrs,
+	.name = "dptf_power"
+};
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
+	result = sysfs_create_group(&pdev->dev.kobj,
+				    &dptf_power_attribute_group);
+	if (result)
+		return result;
+
+	platform_set_drvdata(pdev, acpi_dev);
+
+	return 0;
+}
+
+static int dptf_power_remove(struct platform_device *pdev)
+{
+
+	sysfs_remove_group(&pdev->dev.kobj, &dptf_power_attribute_group);
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

