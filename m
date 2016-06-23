From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] acpi: move int340x_thermal.c to dptf folder
Date: Thu, 23 Jun 2016 14:56:33 -0700
Message-ID: <1466718993-18096-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22073 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbcFWVzI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jun 2016 17:55:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Since dptf has its own folder under ACPI, move this file also
there.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/Makefile               |  1 -
 drivers/acpi/dptf/Makefile          |  1 +
 drivers/acpi/dptf/int340x_thermal.c | 53 +++++++++++++++++++++++++++++++++++++
 drivers/acpi/int340x_thermal.c      | 53 -------------------------------------
 4 files changed, 54 insertions(+), 54 deletions(-)
 create mode 100644 drivers/acpi/dptf/int340x_thermal.c
 delete mode 100644 drivers/acpi/int340x_thermal.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 8555c14..f739b43 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -44,7 +44,6 @@ acpi-y				+= acpi_lpss.o acpi_apd.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
 acpi-$(CONFIG_ARM_AMBA)	+= acpi_amba.o
-acpi-y				+= int340x_thermal.o
 acpi-y				+= power.o
 acpi-y				+= event.o
 acpi-$(CONFIG_ACPI_REDUCED_HARDWARE_ONLY) += evged.o
diff --git a/drivers/acpi/dptf/Makefile b/drivers/acpi/dptf/Makefile
index 1b6d8bd..471d1af 100644
--- a/drivers/acpi/dptf/Makefile
+++ b/drivers/acpi/dptf/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_ACPI)		+= int340x_thermal.o
 obj-$(CONFIG_DPTF_POWER)	+= dptf_power.o
 
 ccflags-y += -Idrivers/acpi
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
new file mode 100644
index 0000000..33505c6
--- /dev/null
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -0,0 +1,53 @@
+/*
+ * ACPI support for int340x thermal drivers
+ *
+ * Copyright (C) 2014, Intel Corporation
+ * Authors: Zhang Rui <rui.zhang@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/module.h>
+
+#include "internal.h"
+
+#define INT3401_DEVICE 0X01
+static const struct acpi_device_id int340x_thermal_device_ids[] = {
+	{"INT3400"},
+	{"INT3401", INT3401_DEVICE},
+	{"INT3402"},
+	{"INT3403"},
+	{"INT3404"},
+	{"INT3406"},
+	{"INT3407"},
+	{"INT3408"},
+	{"INT3409"},
+	{"INT340A"},
+	{"INT340B"},
+	{""},
+};
+
+static int int340x_thermal_handler_attach(struct acpi_device *adev,
+					const struct acpi_device_id *id)
+{
+	if (IS_ENABLED(CONFIG_INT340X_THERMAL))
+		acpi_create_platform_device(adev);
+	/* Intel SoC DTS thermal driver needs INT3401 to set IRQ descriptor */
+	else if (IS_ENABLED(CONFIG_INTEL_SOC_DTS_THERMAL) &&
+		 id->driver_data == INT3401_DEVICE)
+		acpi_create_platform_device(adev);
+	return 1;
+}
+
+static struct acpi_scan_handler int340x_thermal_handler = {
+	.ids = int340x_thermal_device_ids,
+	.attach = int340x_thermal_handler_attach,
+};
+
+void __init acpi_int340x_thermal_init(void)
+{
+	acpi_scan_add_handler(&int340x_thermal_handler);
+}
diff --git a/drivers/acpi/int340x_thermal.c b/drivers/acpi/int340x_thermal.c
deleted file mode 100644
index 33505c6..0000000
--- a/drivers/acpi/int340x_thermal.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * ACPI support for int340x thermal drivers
- *
- * Copyright (C) 2014, Intel Corporation
- * Authors: Zhang Rui <rui.zhang@intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/acpi.h>
-#include <linux/module.h>
-
-#include "internal.h"
-
-#define INT3401_DEVICE 0X01
-static const struct acpi_device_id int340x_thermal_device_ids[] = {
-	{"INT3400"},
-	{"INT3401", INT3401_DEVICE},
-	{"INT3402"},
-	{"INT3403"},
-	{"INT3404"},
-	{"INT3406"},
-	{"INT3407"},
-	{"INT3408"},
-	{"INT3409"},
-	{"INT340A"},
-	{"INT340B"},
-	{""},
-};
-
-static int int340x_thermal_handler_attach(struct acpi_device *adev,
-					const struct acpi_device_id *id)
-{
-	if (IS_ENABLED(CONFIG_INT340X_THERMAL))
-		acpi_create_platform_device(adev);
-	/* Intel SoC DTS thermal driver needs INT3401 to set IRQ descriptor */
-	else if (IS_ENABLED(CONFIG_INTEL_SOC_DTS_THERMAL) &&
-		 id->driver_data == INT3401_DEVICE)
-		acpi_create_platform_device(adev);
-	return 1;
-}
-
-static struct acpi_scan_handler int340x_thermal_handler = {
-	.ids = int340x_thermal_device_ids,
-	.attach = int340x_thermal_handler_attach,
-};
-
-void __init acpi_int340x_thermal_init(void)
-{
-	acpi_scan_add_handler(&int340x_thermal_handler);
-}
-- 
2.5.5

