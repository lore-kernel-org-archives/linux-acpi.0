From: Adam Goode <agoode@google.com>
Subject: [PATCH] Register a global handler for SystemCMOS accesses
Date: Fri,  1 May 2015 21:04:30 -0400
Message-ID: <1430528670-21156-1-git-send-email-agoode@google.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:34777 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbbEBBEy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 May 2015 21:04:54 -0400
Received: by yhw29 with SMTP id 29so20845667yhw.1
        for <linux-acpi@vger.kernel.org>; Fri, 01 May 2015 18:04:53 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Adam Goode <agoode@google.com>

(This patch requires an update to acpica, sent to the acpica list
at https://lists.acpica.org/pipermail/devel/2015-May/000698.html)

The acpi_cmos_rtc driver registers too late for early
initialization as found on the Macmini7,1. So instead
of matching against the PNP0B* names, just define a
global handler for this kind of access.

Without this patch, BIOS-based Thunderbolt hotplug on this hardware does
not work.

Signed-off-by: Adam Goode <agoode@google.com>
---
 drivers/acpi/Makefile        |  1 -
 drivers/acpi/acpi_cmos_rtc.c | 90 --------------------------------------------
 drivers/acpi/internal.h      |  5 ---
 drivers/acpi/osl.c           | 52 +++++++++++++++++++++++++
 drivers/acpi/scan.c          |  1 -
 5 files changed, 52 insertions(+), 97 deletions(-)
 delete mode 100644 drivers/acpi/acpi_cmos_rtc.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 8a063e2..f19e745 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -48,7 +48,6 @@ acpi-y				+= power.o
 acpi-y				+= event.o
 acpi-y				+= sysfs.o
 acpi-y				+= property.o
-acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
 acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
 acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
diff --git a/drivers/acpi/acpi_cmos_rtc.c b/drivers/acpi/acpi_cmos_rtc.c
deleted file mode 100644
index 81dc750..0000000
--- a/drivers/acpi/acpi_cmos_rtc.c
+++ /dev/null
@@ -1,90 +0,0 @@
-/*
- * ACPI support for CMOS RTC Address Space access
- *
- * Copyright (C) 2013, Intel Corporation
- * Authors: Lan Tianyu <tianyu.lan@intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/acpi.h>
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <asm-generic/rtc.h>
-
-#include "internal.h"
-
-ACPI_MODULE_NAME("cmos rtc");
-
-static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
-	{ "PNP0B00" },
-	{ "PNP0B01" },
-	{ "PNP0B02" },
-	{}
-};
-
-static acpi_status
-acpi_cmos_rtc_space_handler(u32 function, acpi_physical_address address,
-		      u32 bits, u64 *value64,
-		      void *handler_context, void *region_context)
-{
-	int i;
-	u8 *value = (u8 *)value64;
-
-	if (address > 0xff || !value64)
-		return AE_BAD_PARAMETER;
-
-	if (function != ACPI_WRITE && function != ACPI_READ)
-		return AE_BAD_PARAMETER;
-
-	spin_lock_irq(&rtc_lock);
-
-	for (i = 0; i < DIV_ROUND_UP(bits, 8); ++i, ++address, ++value)
-		if (function == ACPI_READ)
-			*value = CMOS_READ(address);
-		else
-			CMOS_WRITE(*value, address);
-
-	spin_unlock_irq(&rtc_lock);
-
-	return AE_OK;
-}
-
-static int acpi_install_cmos_rtc_space_handler(struct acpi_device *adev,
-		const struct acpi_device_id *id)
-{
-	acpi_status status;
-
-	status = acpi_install_address_space_handler(adev->handle,
-			ACPI_ADR_SPACE_CMOS,
-			&acpi_cmos_rtc_space_handler,
-			NULL, NULL);
-	if (ACPI_FAILURE(status)) {
-		pr_err(PREFIX "Error installing CMOS-RTC region handler\n");
-		return -ENODEV;
-	}
-
-	return 1;
-}
-
-static void acpi_remove_cmos_rtc_space_handler(struct acpi_device *adev)
-{
-	if (ACPI_FAILURE(acpi_remove_address_space_handler(adev->handle,
-			ACPI_ADR_SPACE_CMOS, &acpi_cmos_rtc_space_handler)))
-		pr_err(PREFIX "Error removing CMOS-RTC region handler\n");
-}
-
-static struct acpi_scan_handler cmos_rtc_handler = {
-	.ids = acpi_cmos_rtc_ids,
-	.attach = acpi_install_cmos_rtc_space_handler,
-	.detach = acpi_remove_cmos_rtc_space_handler,
-};
-
-void __init acpi_cmos_rtc_init(void)
-{
-	acpi_scan_add_handler(&cmos_rtc_handler);
-}
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index ba4a61e..e9dfd1b 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -53,11 +53,6 @@ static inline void register_dock_dependent_device(struct acpi_device *adev,
 static inline int dock_notify(struct acpi_device *adev, u32 event) { return -ENODEV; }
 static inline void acpi_dock_add(struct acpi_device *adev) {}
 #endif
-#ifdef CONFIG_X86
-void acpi_cmos_rtc_init(void);
-#else
-static inline void acpi_cmos_rtc_init(void) {}
-#endif
 
 extern bool acpi_force_hot_remove;
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 39748bb..cd84914 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -45,6 +45,10 @@
 #include <linux/jiffies.h>
 #include <linux/semaphore.h>
 
+#if defined(CONFIG_X86)
+#include <asm-generic/rtc.h>
+#endif
+
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
@@ -929,6 +933,54 @@ acpi_status acpi_os_write_port(acpi_io_address port, u32 value, u32 width)
 
 EXPORT_SYMBOL(acpi_os_write_port);
 
+acpi_status acpi_os_read_cmos(acpi_io_address address, u64 *value, u32 width)
+{
+#if defined(CONFIG_X86)
+	int i;
+	u8 *value8 = (u8 *)value;
+
+	if (address > 0xff || !value)
+		return AE_BAD_PARAMETER;
+
+	spin_lock_irq(&rtc_lock);
+
+	for (i = 0; i < DIV_ROUND_UP(width, 8); ++i, ++address, ++value8)
+		*value8 = CMOS_READ(address);
+
+	spin_unlock_irq(&rtc_lock);
+
+	return AE_OK;
+#else
+	return AE_SUPPORT;
+#endif
+}
+
+EXPORT_SYMBOL(acpi_os_read_cmos);
+
+acpi_status acpi_os_write_cmos(acpi_io_address address, u64 value, u32 width)
+{
+#if defined(CONFIG_X86)
+	int i;
+	u8 *value8 = (u8 *)&value;
+
+	if (address > 0xff)
+		return AE_BAD_PARAMETER;
+
+	spin_lock_irq(&rtc_lock);
+
+	for (i = 0; i < DIV_ROUND_UP(width, 8); ++i, ++address, ++value8)
+		CMOS_WRITE(*value8, address);
+
+	spin_unlock_irq(&rtc_lock);
+
+	return AE_OK;
+#else
+	return AE_SUPPORT;
+#endif
+}
+
+EXPORT_SYMBOL(acpi_os_write_cmos);
+
 #ifdef readq
 static inline u64 read64(const volatile void __iomem *addr)
 {
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 03141aa..65f9fa5 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2648,7 +2648,6 @@ int __init acpi_scan_init(void)
 	acpi_processor_init();
 	acpi_lpss_init();
 	acpi_apd_init();
-	acpi_cmos_rtc_init();
 	acpi_container_init();
 	acpi_memory_hotplug_init();
 	acpi_pnp_init();
-- 
2.3.7

