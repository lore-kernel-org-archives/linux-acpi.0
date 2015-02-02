From: Ken Xue <Ken.Xue@amd.com>
Subject: [PATCH V2] acpi:apd:add AMD ACPI2Platform device support for x86
 system.
Date: Mon, 2 Feb 2015 17:50:52 +0800
Message-ID: <1422870652.2528.6.camel@kxue-X58A-UD3R>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-by2on0107.outbound.protection.outlook.com ([207.46.100.107]:28448
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754583AbbBBKQy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Feb 2015 05:16:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

>From b9654ecbfaebde00aee746a024eec9fe8de24b97 Mon Sep 17 00:00:00 2001
From: Ken Xue <Ken.Xue@amd.com>
Date: Mon, 2 Feb 2015 17:32:24 +0800
Subject: [PATCH] This new feature is to interpret AMD specific ACPI device to
 platform device such as I2C, UART found on AMD CZ and later chipsets. It
 based on example INTEL LPSS. Now, it can support AMD I2C & UART.

Signed-off-by: Ken Xue <Ken.Xue@amd.com>
---
 arch/x86/Kconfig        |  11 +++
 drivers/acpi/Makefile   |   2 +-
 drivers/acpi/acpi_apd.c | 208 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h |   2 +
 drivers/acpi/scan.c     |   1 +
 5 files changed, 223 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/acpi_apd.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0dc9d01..ddf8d42 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -496,6 +496,17 @@ config X86_INTEL_LPSS
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
index f74317c..0071141 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -40,7 +40,7 @@ acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) += processor_pdc.o
 acpi-y				+= ec.o
 acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
 acpi-y				+= pci_root.o pci_link.o pci_irq.o
-acpi-y				+= acpi_lpss.o
+acpi-y				+= acpi_lpss.o acpi_apd.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
 acpi-y				+= int340x_thermal.o
diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
new file mode 100644
index 0000000..b875ef6
--- /dev/null
+++ b/drivers/acpi/acpi_apd.c
@@ -0,0 +1,208 @@
+/*
+ * AMD ACPI support for ACPI2platform device.
+ *
+ * Copyright (c) 2014,2015 AMD Corporation.
+ * Authors: Ken Xue <Ken.Xue@amd.com>
+ *	Wu, Jeff <Jeff.Wu@amd.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/clkdev.h>
+#include <linux/acpi.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/pm.h>
+
+#include "internal.h"
+
+
+ACPI_MODULE_NAME("acpi_apd");
+struct apd_private_data;
+
+/**
+ * device flags of acpi_apd_dev_desc.
+ * ACPI_APD_SYSFS : add device attributes in sysfs
+ * ACPI_APD_PM : attach power domain to device
+ * ACPI_APD_PM_ON : power on device when attach power domain
+ */
+#define ACPI_APD_SYSFS	BIT(0)
+#define ACPI_APD_PM	BIT(1)
+#define ACPI_APD_PM_ON	BIT(2)
+
+/**
+ * struct apd_device_desc - a descriptor for apd device
+ * @flags: device flags like ACPI_APD_SYSFS ACPI_APD_PM ACPI_APD_PM_ON
+ * @fixed_clk_rate: fixed rate input clock source for acpi device;
+ *			0 means no fixed rate input clock source
+ * @setup: a hook routine to set device resource during create platform device
+ *
+ * device description defined as acpi_device_id.driver_data
+ */
+struct apd_device_desc {
+	unsigned int flags;
+	unsigned int fixed_clk_rate;
+	int (*setup)(struct apd_private_data *pdata);
+};
+
+struct apd_private_data {
+	struct clk *clk;
+	struct acpi_device *adev;
+	struct apd_device_desc *dev_desc;
+};
+
+
+#ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
+#define APD_ADDR(desc)	((unsigned long)&desc)
+
+static int acpi_apd_setup(struct apd_private_data *pdata)
+{
+	struct apd_device_desc *dev_desc = pdata->dev_desc;
+	struct clk *clk = ERR_PTR(-ENODEV);
+
+	if (dev_desc->fixed_clk_rate) {
+		clk = clk_register_fixed_rate(&pdata->adev->dev,
+					dev_name(&pdata->adev->dev),
+					NULL, CLK_IS_ROOT,
+					dev_desc->fixed_clk_rate);
+		clk_register_clkdev(clk, NULL, dev_name(&pdata->adev->dev));
+		pdata->clk = clk;
+	}
+
+	return 0;
+}
+
+static struct apd_device_desc cz_i2c_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 133000000,
+};
+
+static struct apd_device_desc cz_uart_desc = {
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
+static int acpi_apd_create_device(struct acpi_device *adev,
+				   const struct acpi_device_id *id)
+{
+	struct apd_private_data *pdata;
+	struct apd_device_desc *dev_desc;
+	struct platform_device *pdev;
+	int ret;
+
+	dev_desc = (struct apd_device_desc *)id->driver_data;
+	if (!dev_desc) {
+		pdev = acpi_create_platform_device(adev);
+		return IS_ERR_OR_NULL(pdev) ? PTR_ERR(pdev) : 1;
+	}
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->adev = adev;
+	pdata->dev_desc = dev_desc;
+
+	if (dev_desc->setup) {
+		ret = dev_desc->setup(pdata);
+		if (ret)
+			goto err_out;
+	}
+
+	adev->driver_data = pdata;
+	pdev = acpi_create_platform_device(adev);
+	if (!IS_ERR_OR_NULL(pdev))
+		return 1;
+
+	ret = PTR_ERR(pdev);
+	adev->driver_data = NULL;
+
+ err_out:
+	kfree(pdata);
+	return ret;
+}
+
+static struct acpi_device_id acpi_apd_device_ids[] = {
+	/* Generic apd devices */
+	{ "AMD0010", APD_ADDR(cz_i2c_desc) },
+	{ "AMD0020", APD_ADDR(cz_uart_desc) },
+	{ }
+};
+
+#ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
+static int acpi_apd_platform_notify(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	struct platform_device *pdev = to_platform_device(data);
+	struct apd_private_data *pdata;
+	const struct acpi_device_id *id = NULL;
+	struct acpi_device *adev;
+	int ret;
+
+	id = acpi_match_device(acpi_apd_device_ids, &pdev->dev);
+	if (!id || !id->driver_data)
+		return 0;
+
+	if (!id || !id->driver_data)
+		return 0;
+
+	if (acpi_bus_get_device(ACPI_HANDLE(&pdev->dev), &adev))
+		return 0;
+
+	pdata = acpi_driver_data(adev);
+	if (!pdata || !pdata->dev_desc)
+		return 0;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		if (pdata->dev_desc->flags & ACPI_APD_PM) {
+			if (pdata->dev_desc->flags & ACPI_APD_PM_ON)
+				ret = dev_pm_domain_attach(&pdev->dev, true);
+			else
+				ret = dev_pm_domain_attach(&pdev->dev, false);
+
+			if (ret)
+				dev_dbg(&pdev->dev,
+				"failed to attached pm domain (%d)\n", ret);
+		}
+		break;
+	case BUS_NOTIFY_DEL_DEVICE:
+		if (pdata->dev_desc->flags & ACPI_APD_PM) {
+			if (pdata->dev_desc->flags & ACPI_APD_PM_ON)
+				dev_pm_domain_detach(&pdev->dev, true);
+			else
+				dev_pm_domain_detach(&pdev->dev, false);
+		}
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block acpi_apd_nb = {
+	.notifier_call = acpi_apd_platform_notify,
+};
+#endif
+
+static struct acpi_scan_handler apd_handler = {
+	.ids = acpi_apd_device_ids,
+	.attach = acpi_apd_create_device,
+};
+
+void __init acpi_apd_init(void)
+{
+#ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
+	bus_register_notifier(&platform_bus_type, &acpi_apd_nb);
+#endif
+
+	acpi_scan_add_handler(&apd_handler);
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
index dc4d896..bbca783 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2544,6 +2544,7 @@ int __init acpi_scan_init(void)
 	acpi_pci_link_init();
 	acpi_processor_init();
 	acpi_lpss_init();
+	acpi_apd_init();
 	acpi_cmos_rtc_init();
 	acpi_container_init();
 	acpi_memory_hotplug_init();
-- 
1.9.1



