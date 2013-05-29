From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [Fix PATCH 1/2] ACPI: Add CMOS RTC operation region handler support
Date: Wed, 29 May 2013 20:03:59 +0800
Message-ID: <1369829040-31029-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17739 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965564Ab3E2MKU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 May 2013 08:10:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, public@stefan-nagy.at, stable@vger.kernel.org

On the HP Folio 13-2000, the bios defines the CMOS RTC region
and EC _REG methord will access CMOS RTC region. So the handler
must be registered before EC driver being loaded.

This patch is to add handler to access CMOS RTC operation. Register
acpi scan handler for CMOS RTC devices. When these device has
been detected during enumerating devices in the ACPI namespace,
install CMOS RTC operation region handler.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=54621
Cc: stable@vger.kernel.org
Reported-and-tested-by: Stefan Nagy <public@stefan-nagy.at>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/Makefile        |    1 +
 drivers/acpi/acpi_cmos_rtc.c |  107 ++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h      |    1 +
 drivers/acpi/scan.c          |    1 +
 4 files changed, 110 insertions(+)
 create mode 100644 drivers/acpi/acpi_cmos_rtc.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d07771b..90bbcda 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -44,6 +44,7 @@ acpi-y				+= acpi_platform.o
 acpi-y				+= power.o
 acpi-y				+= event.o
 acpi-y				+= sysfs.o
+acpi-y				+= acpi_cmos_rtc.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
 acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
 acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
diff --git a/drivers/acpi/acpi_cmos_rtc.c b/drivers/acpi/acpi_cmos_rtc.c
new file mode 100644
index 0000000..5837005
--- /dev/null
+++ b/drivers/acpi/acpi_cmos_rtc.c
@@ -0,0 +1,107 @@
+/*
+ * ACPI support for CMOS RTC Address Space access
+ *
+ * Copyright (C) 2013, Intel Corporation
+ * Authors: Lan Tianyu <tianyu.lan@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <asm-generic/rtc.h>
+
+#include "internal.h"
+
+#define PREFIX "ACPI: "
+
+ACPI_MODULE_NAME("cmos rtc");
+
+static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
+	{ "PNP0B00" },
+	{ "PNP0B01" },
+	{ "PNP0B02" },
+	{}
+};
+
+static acpi_status
+acpi_cmos_rtc_space_handler(u32 function, acpi_physical_address address,
+		      u32 bits, u64 *value64,
+		      void *handler_context, void *region_context)
+{
+	int i;
+	u64 tmp;
+	u8 *value = (u8 *)&tmp;
+
+	if (address > 0xff || !value64)
+		return AE_BAD_PARAMETER;
+
+	/*
+	 * The input/output value's type is u64 while
+	 * CMOS_READ/CMOS_WRITE unit is 8 bits. To avoid
+	 * endianness problem on different machines,
+	 * operations of write/read follows little
+	 * endianness. Output value is translated to little
+	 * endianness before writing. Input value is
+	 * translated to cpu's endianness after reading.
+	 */
+	if (function == ACPI_WRITE)
+		tmp = cpu_to_le64(*value64);
+	else if (function != ACPI_READ)
+		return AE_BAD_PARAMETER;
+
+	spin_lock_irq(&rtc_lock);
+
+	for (i = 0; i < DIV_ROUND_UP(bits, 8); ++i, ++address, ++value)
+		if (function == ACPI_READ)
+			*value = CMOS_READ(address);
+		else
+			CMOS_WRITE(*value, address);
+
+	spin_unlock_irq(&rtc_lock);
+
+	if (function == ACPI_READ)
+		*value64 = le64_to_cpu(tmp);
+
+	return AE_OK;
+}
+
+static int acpi_install_cmos_rtc_space_handler(struct acpi_device *adev,
+		const struct acpi_device_id *id)
+{
+	acpi_status status;
+
+	status = acpi_install_address_space_handler(adev->handle,
+			ACPI_ADR_SPACE_CMOS,
+			&acpi_cmos_rtc_space_handler,
+			NULL, NULL);
+	if (ACPI_FAILURE(status)) {
+		pr_err(PREFIX "Error installing CMOS-RTC region handler\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void acpi_remove_cmos_rtc_space_handler(struct acpi_device *adev)
+{
+	if (ACPI_FAILURE(acpi_remove_address_space_handler(adev->handle,
+			ACPI_ADR_SPACE_CMOS, &acpi_cmos_rtc_space_handler)))
+		pr_err(PREFIX "Error removing CMOS-RTC region handler\n");
+}
+
+static struct acpi_scan_handler cmos_rtc_handler = {
+	.ids = acpi_cmos_rtc_ids,
+	.attach = acpi_install_cmos_rtc_space_handler,
+	.detach = acpi_remove_cmos_rtc_space_handler,
+};
+
+void __init acpi_cmos_rtc_init(void)
+{
+	acpi_scan_add_handler(&cmos_rtc_handler);
+}
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 18a9d22..09bf428 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -35,6 +35,7 @@ void acpi_pci_link_init(void);
 void acpi_pci_root_hp_init(void);
 void acpi_processor_init(void);
 void acpi_platform_init(void);
+void acpi_cmos_rtc_init(void);
 int acpi_sysfs_init(void);
 #ifdef CONFIG_ACPI_CONTAINER
 void acpi_container_init(void);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a67f614..642e045 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2159,6 +2159,7 @@ int __init acpi_scan_init(void)
 	acpi_processor_init();
 	acpi_platform_init();
 	acpi_lpss_init();
+	acpi_cmos_rtc_init();
 	acpi_container_init();
 	acpi_memory_hotplug_init();
 
-- 
1.7.10.4

