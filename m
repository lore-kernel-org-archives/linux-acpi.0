From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH 2/3] ACPI / sybus: add a driver for LNXSYBUS device
Date: Wed, 16 Mar 2016 13:37:01 -0600
Message-ID: <1458157022-18633-3-git-send-email-pprakash@codeaurora.org>
References: <1458157022-18633-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60433 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934996AbcCPThT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2016 15:37:19 -0400
In-Reply-To: <1458157022-18633-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: harba@codeaurora.org, rjw@rjwysocki.net, Prashanth Prakash <pprakash@codeaurora.org>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>

This patch adds a bus driver to handle the graceful shutdown
requests as described in the section 6.3.5.1, section 5.6.6
and table 5-143 of ACPI spec 6.1

The OSPM will get a graceful shutdown request via a Notify
operator on \_SB device with a value of 0x81 per section 5.6.6.
Following the shutdown request from platform the OSPM needs to
follow the processing sequence described in section 6.2.5.1 -
"Processing Sequence for Graceful Shutdown Request"

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
---
 drivers/acpi/Kconfig  |   6 +++
 drivers/acpi/Makefile |   1 +
 drivers/acpi/sybus.c  | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 drivers/acpi/sybus.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 82b96ee..78cf770 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -209,6 +209,12 @@ config ACPI_DOCK
 	  This driver supports ACPI-controlled docking stations and removable
 	  drive bays such as the IBM Ultrabay and the Dell Module Bay.
 
+config ACPI_SYBUS
+	bool "System Bus"
+	help
+	  This driver handles the events on system bus which includes
+	  support for a graceful shutdown request from the platform.
+
 config ACPI_CPU_FREQ_PSS
 	bool
 	select THERMAL
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index cb648a4..fe56427 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
+obj-$(CONFIG_ACPI_SYBUS)	+= sybus.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
diff --git a/drivers/acpi/sybus.c b/drivers/acpi/sybus.c
new file mode 100644
index 0000000..f9fa821
--- /dev/null
+++ b/drivers/acpi/sybus.c
@@ -0,0 +1,116 @@
+/*
+ * ACPI System Bus Device (\_SB, LNXSYBUS) Driver
+ * ACPI System Bus Device Driver is used to handle events reported to
+ * the device.
+ *
+ * Copyright (c) 2016, The Linux Foundation. All rights reserved.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/workqueue.h>
+#include <linux/reboot.h>
+
+#include <acpi/acpi_drivers.h>
+
+#define _COMPONENT			ACPI_BUS_COMPONENT
+#define SYBUS_PFX			"ACPI SYBUS: "
+
+/*
+ * According to section 6.3.5 of ACPI 6.0 spec, the kernel
+ * should evaluate _OST (an ACPI control method) every 10 seconds
+ * to indicate "OS shutdown in progress" to the platform.
+ */
+#define SYBUS_INDICATE_INTERVAL		10000
+
+#define SYBUS_NOTIFY_RESERVED		    (0x80)
+#define SYBUS_NOTIFY_SHUTDOWN_REQUEST	(0x81)
+
+ACPI_MODULE_NAME("sybus");
+
+static void sybus_evaluate_ost(struct work_struct *);
+
+static struct acpi_device_id acpi_sybus_ids[] = {
+	{ACPI_BUS_HID, 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, acpi_sybus_ids);
+
+static acpi_handle sybus_handle;
+static DECLARE_DELAYED_WORK(acpi_sybus_work, sybus_evaluate_ost);
+
+static void sybus_evaluate_ost(struct work_struct *dummy)
+{
+	pr_info(SYBUS_PFX "OS shutdown in progress.\n");
+	acpi_evaluate_ost(sybus_handle, ACPI_OST_EC_OSPM_SHUTDOWN,
+			  ACPI_OST_SC_OS_SHUTDOWN_IN_PROGRESS, NULL);
+	schedule_delayed_work(&acpi_sybus_work,
+			msecs_to_jiffies(SYBUS_INDICATE_INTERVAL));
+}
+
+static void acpi_sybus_notify(struct acpi_device *device, u32 event)
+{
+	/*
+	 * The only event that ACPI System Bus Device should handle is
+	 * SYBUS_NOTIFY_SHUTDOWN_REQUEST.
+	 */
+	if (event != SYBUS_NOTIFY_SHUTDOWN_REQUEST) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"event %x is not supported by ACPI system bus device.\n",
+			event));
+		return;
+	}
+
+	pr_warn(SYBUS_PFX "Shutdown request notification received.\n");
+
+	if (!delayed_work_pending(&acpi_sybus_work)) {
+		sybus_evaluate_ost(NULL);
+		schedule_delayed_work(&acpi_sybus_work,
+				msecs_to_jiffies(SYBUS_INDICATE_INTERVAL));
+
+		orderly_poweroff(true);
+	} else
+		pr_info(SYBUS_PFX "Shutdown in already progress!\n");
+}
+
+static int acpi_sybus_add(struct acpi_device *device)
+{
+	/* Only one ACPI system bus device */
+	if (sybus_handle)
+		return -EINVAL;
+	sybus_handle = device->handle;
+	return 0;
+}
+
+static int acpi_sybus_remove(struct acpi_device *device)
+{
+	cancel_delayed_work_sync(&acpi_sybus_work);
+	sybus_handle = NULL;
+	return 0;
+}
+
+static struct acpi_driver acpi_sybus_driver = {
+	.name = "system_bus_device",
+	.class = "system_bus",
+	.ids = acpi_sybus_ids,
+	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
+	.ops = {
+		.notify = acpi_sybus_notify,
+		.add = acpi_sybus_add,
+		.remove = acpi_sybus_remove,
+	},
+};
+module_acpi_driver(acpi_sybus_driver);
+
+MODULE_DESCRIPTION("ACPI System Bus Device Driver");
+MODULE_LICENSE("GPL");
-- 
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

