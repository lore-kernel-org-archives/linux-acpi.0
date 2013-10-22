From: <brandon.anderson@amd.com>
Subject: [RFC PATCH 2/3] ACPI: Prototype of AMBA bus 'connector resource'
Date: Mon, 21 Oct 2013 19:33:48 -0500
Message-ID: <1382402029-13381-3-git-send-email-brandon.anderson@amd.com>
References: <1382402029-13381-1-git-send-email-brandon.anderson@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from co1ehsobe002.messaging.microsoft.com ([216.32.180.185]:10737
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752128Ab3JVAew (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Oct 2013 20:34:52 -0400
In-Reply-To: <1382402029-13381-1-git-send-email-brandon.anderson@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rjw@sisk.pl, naresh.bhat@linaro.org, hanjun.guo@linaro.org, graeme.gregory@linaro.org, Suravee.Suthikulpanit@amd.com, Brandon Anderson <brandon.anderson@amd.com>

From: Brandon Anderson <brandon.anderson@amd.com>

Add AMBA bus 'connector resource' module to call amba_device_add() for each device under the top-level 'AMBA0000' entry. Clock handling is yet to be implemented.


Signed-off-by: Brandon Anderson <brandon.anderson@amd.com>
---
 drivers/acpi/acpi_platform.c |    2 +
 drivers/amba/Makefile        |    2 +-
 drivers/amba/acpi.c          |  162 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 drivers/amba/acpi.c

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 37b8af8..fdfa990 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -36,6 +36,8 @@ static const struct acpi_device_id acpi_platform_device_ids[] = {
 	{ "LINA0007" }, /* armv8 pmu */
 	{ "LINA0008" }, /* Fixed clock */
 
+	{ "AMBA0000" },
+
 	{ }
 };
 
diff --git a/drivers/amba/Makefile b/drivers/amba/Makefile
index 66e81c2..6d088e7 100644
--- a/drivers/amba/Makefile
+++ b/drivers/amba/Makefile
@@ -1,2 +1,2 @@
-obj-$(CONFIG_ARM_AMBA)		+= bus.o
+obj-$(CONFIG_ARM_AMBA)		+= bus.o acpi.o
 obj-$(CONFIG_TEGRA_AHB)		+= tegra-ahb.o
diff --git a/drivers/amba/acpi.c b/drivers/amba/acpi.c
new file mode 100644
index 0000000..04efcbd
--- /dev/null
+++ b/drivers/amba/acpi.c
@@ -0,0 +1,162 @@
+/*
+ * AMBA Connector Resource for ACPI 
+ *
+ * Copyright (C) 2013 Advanced Micro Devices, Inc.
+ *
+ * Author: Brandon Anderson <brandon.anderson@amd.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifdef CONFIG_ACPI
+
+#include <linux/module.h>
+#include <linux/amba/bus.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+#include <linux/clkdev.h>
+
+static int acpi_amba_add_resource(struct acpi_resource *ares, void *data)
+{
+	struct amba_device *dev = data;
+	struct resource r;
+	int irq_idx;
+
+	switch (ares->type)
+	{
+		case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
+			if (!acpi_dev_resource_memory(ares, &dev->res)) {
+				pr_err("%s: failed to map memory resource\n", __func__);
+			}
+		break;
+		case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+			for (irq_idx = 0; irq_idx < AMBA_NR_IRQS; irq_idx++) {
+				if (acpi_dev_resource_interrupt(ares, irq_idx, &r)) {
+					dev->irq[irq_idx] = r.start;
+				} else {
+					break;
+				}
+			}
+
+		break;
+		default:
+			pr_debug("%s: unhandled acpi resource type= %d\n", __func__,
+					ares->type);
+		break;
+	}
+
+	return 1; /* Tell ACPI core to skip this resource */
+}
+
+static void acpi_amba_register_clk(struct acpi_device *adev) 
+{
+	/* TODO: Retrieve clock details from ACPI and register the appropriate
+	   clock under this device for amba subsystem and drivers to reference */
+}
+
+/* acpi_amba_add_device()
+ *
+ * ACPI equivalent to of_amba_device_create() 
+ */
+static acpi_status acpi_amba_add_device(acpi_handle handle, u32 lvl_not_used,
+				 void *data, void **not_used)
+{
+	struct list_head resource_list;
+	struct acpi_device *adev;
+	struct amba_device *dev;
+	int ret;
+	struct platform_device *pdata = data;
+
+	if (acpi_bus_get_device(handle, &adev)) {
+		pr_err("%s: acpi_bus_get_device failed\n", __func__);
+		return AE_OK;
+	}
+
+	pr_debug("Creating amba device %s\n", dev_name(&adev->dev));
+
+	dev = amba_device_alloc(NULL, 0, 0);
+	if (!dev) {
+		pr_err("%s(): amba_device_alloc() failed for %s\n",
+		       __func__, dev_name(&adev->dev));
+		return AE_CTRL_TERMINATE;
+	}
+
+	/* setup generic device info */
+	dev->dev.coherent_dma_mask = ~0;
+	dev->dev.parent = pdata->dev.parent;
+	//dev->dev.platform_data = platform_data; //FIXME: is this needed by any drivers?
+	dev_set_name(&dev->dev, "%s", dev_name(&adev->dev));
+
+	/* setup amba-specific device info */
+	dev->dma_mask = ~0;
+
+	ACPI_HANDLE_SET(&dev->dev, handle);
+
+	INIT_LIST_HEAD(&resource_list);
+	acpi_dev_get_resources(adev, &resource_list,
+				     acpi_amba_add_resource, dev);
+	acpi_dev_free_resource_list(&resource_list);
+
+	/* Add clocks */
+	acpi_amba_register_clk(adev);
+
+	/* Read AMBA hardware ID and add device to system. If a driver matching
+	 *	hardware ID has already been registered, bind this device to it.
+	 *	Otherwise, the platform subsystem will match up the hardware ID when
+	 *	the matching driver is registered.
+	*/
+	ret = amba_device_add(dev, &iomem_resource);
+	if (ret) {
+		pr_err("%s(): amba_device_add() failed (%d) for %s\n",
+		       __func__, ret, dev_name(&adev->dev));
+		goto err_free;
+	}
+
+	return AE_OK;
+
+err_free:
+	amba_device_put(dev);
+	return AE_CTRL_TERMINATE;
+}
+
+static int acpi_amba_bus_probe(struct platform_device *pdev)  
+{
+	// see if there's a top-level clock to use as default for sub-devices
+	//TODO
+
+	// probe each device
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_HANDLE(&pdev->dev), 1,
+			acpi_amba_add_device, NULL, pdev, NULL);
+
+	return 0;
+}
+
+static const struct acpi_device_id amba_bus_acpi_match[] = {
+	{ "AMBA0000", 0 },
+	{ },
+};
+
+static struct platform_driver amba_bus_acpi_driver = {
+	.driver = {
+		.name = "amba-acpi",
+		.owner = THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(amba_bus_acpi_match),
+	},
+	.probe	= acpi_amba_bus_probe,
+};
+
+static int __init acpi_amba_bus_init(void)
+{
+	return platform_driver_register(&amba_bus_acpi_driver);
+}
+
+postcore_initcall(acpi_amba_bus_init);
+
+MODULE_AUTHOR("Brandon Anderson <brandon.anderson@amd.com>");
+MODULE_DESCRIPTION("ACPI Connector Resource for AMBA bus");
+MODULE_LICENSE("GPLv2");
+MODULE_ALIAS("platform:amba-acpi");
+
+#endif //CONFIG_ACPI
-- 
1.7.9.5


