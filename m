From: Ken Xue <Ken.Xue@amd.com>
Subject: [PATCH 2/3 V3] acpi:apd:add AMD ACPI2Platform device support
Date: Thu, 18 Dec 2014 16:50:55 +0800
Message-ID: <1418892655.17614.10.camel@kxue-X58A-UD3R>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bl2on0124.outbound.protection.outlook.com ([65.55.169.124]:43077
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751630AbaLRJBs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Dec 2014 04:01:48 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andy.shevchenko@gmail.com, mika.westerberg@linux.intel.com, rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Ken.Xue@amd.com

This is a new feature to interpret AMD specific ACPI device to
platform device such as I2C, UART found on AMD CZ and later
chipsets. It based on ACPI SOC.

Signed-off-by: Ken Xue <Ken.Xue@amd.com>
---
 arch/x86/Kconfig        | 11 ++++++++
 drivers/acpi/Makefile   |  2 +-
 drivers/acpi/acpi_apd.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h |  2 ++
 drivers/acpi/scan.c     |  1 +
 5 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/acpi_apd.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bea3a015..d189864 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -499,6 +499,17 @@ config X86_INTEL_LPSS
 	  things like clock tree (common clock framework) and pincontrol
 	  which are needed by the LPSS peripheral drivers.
 
+config X86_AMD_PLATFORM_DEVICE
+	bool "AMD ACPI2Platform devices support"
+	depends on ACPI
+	select COMMON_CLK
+	select PINCTRL
+	---help---
+	  Select to interpret AMD specific ACPI device to platform device
+	  such as I2C, UART found on AMD Carrizo and later chipsets. Selecting
+	  this option enables things like clock tree (common clock framework)
+	  and pinctrl.
+
 config IOSF_MBI
 	tristate "Intel SoC IOSF Sideband support for SoC platforms"
 	depends on PCI
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 66c7457..1eef7f0 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -40,7 +40,7 @@ acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) += processor_pdc.o
 acpi-y				+= ec.o
 acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
 acpi-y				+= pci_root.o pci_link.o pci_irq.o
-acpi-y				+= acpi_soc.o acpi_lpss.o
+acpi-y				+= acpi_soc.o acpi_lpss.o acpi_apd.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
 acpi-y				+= int340x_thermal.o
diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
new file mode 100644
index 0000000..78ba028
--- /dev/null
+++ b/drivers/acpi/acpi_apd.c
@@ -0,0 +1,71 @@
+/*
+ * AMD ACPI support for ACPI2platform device.
+ *
+ * Copyright (c) 2014, AMD Corporation.
+ * Authors: Ken Xue <Ken.Xue@amd.com>
+ *	Wu, Jeff <Jeff.Wu@amd.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+
+#include "acpi_soc.h"
+#include "internal.h"
+
+static struct acpi_soc a_soc;
+
+#ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
+#define APD_ADDR(desc)	((unsigned long)&desc)
+
+static int acpi_apd_setup(struct acpi_soc_dev_private_data *pdata)
+{
+	struct acpi_soc_dev_desc *dev_desc = pdata->dev_desc;
+	struct clk *clk = ERR_PTR(-ENODEV);
+
+	if (dev_desc->fixed_clk_rate) {
+		clk = clk_register_fixed_rate(&pdata->adev->dev,
+					dev_name(&pdata->adev->dev),
+					NULL, CLK_IS_ROOT,
+					dev_desc->fixed_clk_rate);
+		clk_register_clkdev(clk, NULL, dev_name(&pdata->adev->dev));
+	}
+
+	return 0;
+}
+
+static struct acpi_soc_dev_desc cz_i2c_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 133000000,
+};
+
+static struct acpi_soc_dev_desc cz_uart_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 48000000,
+};
+
+#else
+
+#define APD_ADDR(desc) (0UL)
+
+#endif /* CONFIG_X86_AMD_PLATFORM_DEVICE */
+
+static struct acpi_device_id acpi_apd_device_ids[] = {
+	/* Generic apd devices */
+	{ "AMD0010", APD_ADDR(cz_i2c_desc) },
+	{ "AMD0020", APD_ADDR(cz_uart_desc) },
+	{ }
+};
+
+void __init acpi_apd_init(void)
+{
+	a_soc.ids = acpi_apd_device_ids;
+#ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
+	register_acpi_soc(&a_soc, false);
+#else
+	register_acpi_soc(&a_soc, true);
+#endif /* CONFIG_X86_AMD_PLATFORM_DEVICE */
+}
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 163e82f..c24ae9d 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -68,6 +68,8 @@ static inline void acpi_debugfs_init(void) { return; }
 #endif
 void acpi_lpss_init(void);
 
+void acpi_apd_init(void);
+
 acpi_status acpi_hotplug_schedule(struct acpi_device *adev, u32 src);
 bool acpi_queue_hotplug_work(struct work_struct *work);
 void acpi_device_hotplug(struct acpi_device *adev, u32 src);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1b1cf55..ced689d 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2541,6 +2541,7 @@ int __init acpi_scan_init(void)
 	acpi_pci_link_init();
 	acpi_processor_init();
 	acpi_lpss_init();
+	acpi_apd_init();
 	acpi_cmos_rtc_init();
 	acpi_container_init();
 	acpi_memory_hotplug_init();
-- 
1.9.1



