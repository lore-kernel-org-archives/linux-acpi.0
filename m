From: Alex Hung <alex.hung@canonical.com>
Subject: [PATCH] ACPI: add a dummy ACPI RTC driver to handle BIOS's accesses to registers delcared in OperationRegion.
Date: Wed, 16 Jan 2013 11:15:25 +0800
Message-ID: <1358306125-8104-1-git-send-email-alex.hung@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:60840 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756859Ab3APDPf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Jan 2013 22:15:35 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: alex.hung@canonical.com, lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org

This is to fix acpica returns an error and terminate AML execution as
soon as BIOS tries to access ACPI's RTC registers.

BugLink: http://launchpad.net/bugs/1065066

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/Kconfig    |    9 +++
 drivers/acpi/Makefile   |    1 +
 drivers/acpi/acpi_rtc.c |  140 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 drivers/acpi/acpi_rtc.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 38c5078..fb90397 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -181,6 +181,15 @@ config ACPI_DOCK
 	  This driver supports ACPI-controlled docking stations and removable
 	  drive bays such as the IBM Ultrabay and the Dell Module Bay.
 
+config ACPI_RTC
+	tristate "RTC"
+	default m
+	help
+	  This driver supports an ACPI RTC device. It enables BIOS to read and
+	  to write ACPI RTC registers declared in an OperationRegion with
+	  RegionSpace as SYSTEMCMOS. This is required if BIOS needs to access
+	  RTC registers during run-time such as a number of HP laptops.
+
 config ACPI_I2C
 	def_tristate I2C
 	depends on I2C
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 2a4502b..383c62b 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
 obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_I2C)		+= acpi_i2c.o
+obj-$(CONFIG_ACPI_RTC)          += acpi_rtc.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o processor_throttling.o
diff --git a/drivers/acpi/acpi_rtc.c b/drivers/acpi/acpi_rtc.c
new file mode 100644
index 0000000..0ddcfc8
--- /dev/null
+++ b/drivers/acpi/acpi_rtc.c
@@ -0,0 +1,140 @@
+/*
+ *  acpi_rtc - ACPI RTC Driver
+ *
+ *  Copyright (C) 2013 Alex Hung <alex.hung@canonical.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <linux/miscdevice.h>
+
+#define pr_fmt(fmt) "acpi_rtc: " fmt
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("acpi*:PNP0B00:*");
+
+static const struct acpi_device_id rtc_device_ids[] = {
+	{"PNP0B00", 0},
+	{"", 0},
+};
+
+static acpi_status acpi_acpi_handle_locate_callback(acpi_handle handle,
+			u32 level, void *context, void **return_value)
+{
+	struct acpi_device *dev = context;
+	dev->handle = handle;
+
+	return AE_CTRL_TERMINATE;
+}
+
+static acpi_status
+acpi_rtc_space_handler(u32 function, acpi_physical_address address,
+		      u32 bits, u64 *value64,
+		      void *handler_context, void *region_context)
+{
+	return AE_OK;
+}
+
+static int rtc_install_handlers(struct acpi_device *rtc_dev)
+{
+	acpi_status status;
+	status = acpi_install_address_space_handler(rtc_dev->handle,
+						    ACPI_ADR_SPACE_CMOS,
+						    &acpi_rtc_space_handler,
+						    NULL, rtc_dev);
+	if (ACPI_FAILURE(status)) {
+		pr_info("Fail to install ACPI RTC handler\n");
+		return AE_ERROR;
+	}
+
+	return 0;
+}
+
+static int acpi_rtc_add(struct acpi_device *device)
+{
+	int ret;
+	acpi_status status;
+	acpi_handle rtc_dev;
+
+	status = acpi_get_devices(rtc_device_ids[0].id,
+				  acpi_acpi_handle_locate_callback,
+				  &rtc_dev, &rtc_dev);
+	if (!ACPI_SUCCESS(status))
+		return AE_NOT_FOUND;
+
+	ret = rtc_install_handlers((struct acpi_device *) &rtc_dev);
+
+	return ret;
+}
+
+static int acpi_rtc_remove(struct acpi_device *device, int type)
+{
+	acpi_status status;
+	status = acpi_remove_address_space_handler(device->handle,
+						   ACPI_ADR_SPACE_CMOS,
+						   &acpi_rtc_space_handler);
+	if (!ACPI_SUCCESS(status))
+		return AE_ERROR;
+
+	return AE_OK;
+}
+
+static struct acpi_driver acpi_rtc_driver = {
+	.name = "rtc",
+	.class = "ACPI_RTC_CLASS",
+	.ids = rtc_device_ids,
+	.ops = {
+		.add = acpi_rtc_add,
+		.remove = acpi_rtc_remove,
+		},
+};
+
+static int __init rtc_init(void)
+{
+	int err;
+
+	pr_info("Initializing ACPI RTC module\n");
+	err = acpi_bus_register_driver(&acpi_rtc_driver);
+	if (err) {
+		pr_err("Unable to register acpi driver.\n");
+		goto error_acpi_register;
+	}
+
+	return 0;
+
+error_acpi_register:
+
+	return err;
+}
+
+static void __exit rtc_exit(void)
+{
+	pr_info("Exiting ACPI RTC module\n");
+	acpi_bus_unregister_driver(&acpi_rtc_driver);
+}
+
+module_init(rtc_init);
+module_exit(rtc_exit);
-- 
1.7.9.5

