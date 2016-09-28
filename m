From: fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Subject: [PATCH v14 4/9] acpi/arm64: Add GTDT table parse driver
Date: Thu, 29 Sep 2016 02:17:12 +0800
Message-ID: <1475086637-1914-5-git-send-email-fu.wei@linaro.org>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1475086637-1914-1-git-send-email-fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org, Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This patch adds support for parsing arch timer in GTDT,
provides some kernel APIs to parse all the PPIs and
always-on info in GTDT and export them.

By this driver, we can simplify arm_arch_timer drivers, and
separate the ACPI GTDT knowledge from it.

Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 arch/arm64/Kconfig          |   1 +
 drivers/acpi/arm64/Kconfig  |   3 +
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/gtdt.c   | 152 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clocksource/Kconfig |   1 -
 include/linux/acpi.h        |   6 ++
 6 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bc3f00f..0607728 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2,6 +2,7 @@ config ARM64
 	def_bool y
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_GTDT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if ACPI
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index 4616da4..5a6f80f 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -4,3 +4,6 @@
 
 config ACPI_IORT
 	bool
+
+config ACPI_GTDT
+	bool
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 72331f2..1017def 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_ACPI_IORT) 	+= iort.o
+obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
new file mode 100644
index 0000000..b24844d
--- /dev/null
+++ b/drivers/acpi/arm64/gtdt.c
@@ -0,0 +1,152 @@
+/*
+ * ARM Specific GTDT table Support
+ *
+ * Copyright (C) 2016, Linaro Ltd.
+ * Author: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
+ *         Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
+ *         Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include <clocksource/arm_arch_timer.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "ACPI GTDT: " fmt
+
+struct acpi_gtdt_descriptor {
+	struct acpi_table_gtdt *gtdt;
+	void *platform_timer_start;
+	void *gtdt_end;
+};
+
+static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
+
+static inline void *next_platform_timer(void *platform_timer)
+{
+	struct acpi_gtdt_header *gh = platform_timer;
+
+	platform_timer += gh->length;
+	if (platform_timer < acpi_gtdt_desc.gtdt_end)
+		return platform_timer;
+
+	return NULL;
+}
+
+#define for_each_platform_timer(_g)				\
+	for (_g = acpi_gtdt_desc.platform_timer_start; _g;	\
+	     _g = next_platform_timer(_g))
+
+static inline bool is_timer_block(void *platform_timer)
+{
+	struct acpi_gtdt_header *gh = platform_timer;
+
+	return gh->type == ACPI_GTDT_TYPE_TIMER_BLOCK;
+}
+
+static inline bool is_watchdog(void *platform_timer)
+{
+	struct acpi_gtdt_header *gh = platform_timer;
+
+	return gh->type == ACPI_GTDT_TYPE_WATCHDOG;
+}
+
+static int __init map_gt_gsi(u32 interrupt, u32 flags)
+{
+	int trigger, polarity;
+
+	if (!interrupt)
+		return 0;
+
+	trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
+			: ACPI_LEVEL_SENSITIVE;
+
+	polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
+			: ACPI_ACTIVE_HIGH;
+
+	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
+}
+
+/*
+ * Map the PPIs of per-cpu arch_timer.
+ * @type: the type of PPI
+ * Returns 0 if error.
+ */
+int __init acpi_gtdt_map_ppi(int type)
+{
+	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
+
+	switch (type) {
+	case PHYS_SECURE_PPI:
+		return map_gt_gsi(gtdt->secure_el1_interrupt,
+				  gtdt->secure_el1_flags);
+	case PHYS_NONSECURE_PPI:
+		return map_gt_gsi(gtdt->non_secure_el1_interrupt,
+				  gtdt->non_secure_el1_flags);
+	case VIRT_PPI:
+		return map_gt_gsi(gtdt->virtual_timer_interrupt,
+				  gtdt->virtual_timer_flags);
+
+	case HYP_PPI:
+		return map_gt_gsi(gtdt->non_secure_el2_interrupt,
+				  gtdt->non_secure_el2_flags);
+	default:
+		pr_err("Failed to map timer interrupt: invalid type.\n");
+	}
+
+	return 0;
+}
+
+/*
+ * acpi_gtdt_c3stop - got c3stop info from GTDT
+ *
+ * Returns 1 if the timer is powered in deep idle state, 0 otherwise.
+ */
+bool __init acpi_gtdt_c3stop(void)
+{
+	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
+
+	return !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
+}
+
+/*
+ * Get some basic info from GTDT table, and init the global variables above
+ * for all timers initialization of Generic Timer.
+ * This function does some validation on GTDT table.
+ */
+int __init acpi_gtdt_init(struct acpi_table_header *table)
+{
+	void *start;
+	struct acpi_table_gtdt *gtdt;
+
+	gtdt = container_of(table, struct acpi_table_gtdt, header);
+
+	acpi_gtdt_desc.gtdt = gtdt;
+	acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
+
+	if (table->revision < 2) {
+		pr_debug("Revision:%d doesn't support Platform Timers.\n",
+			 table->revision);
+		return 0;
+	}
+
+	if (!gtdt->platform_timer_count) {
+		pr_debug("No Platform Timer.\n");
+		return 0;
+	}
+
+	start = (void *)gtdt + gtdt->platform_timer_offset;
+	if (start < (void *)table + sizeof(struct acpi_table_gtdt)) {
+		pr_err(FW_BUG "Failed to retrieve timer info from firmware: invalid data.\n");
+		return -EINVAL;
+	}
+	acpi_gtdt_desc.platform_timer_start = start;
+
+	return gtdt->platform_timer_count;
+}
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5677886..b58d259 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -285,7 +285,6 @@ config CLKSRC_MPS2
 config ARM_ARCH_TIMER
 	bool
 	select CLKSRC_OF if OF
-	select CLKSRC_ACPI if ACPI
 
 config ARM_ARCH_TIMER_EVTSTREAM
 	bool "Enable ARM architected timer event stream generation by default"
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c5eaf2f..e2f9841 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -567,6 +567,12 @@ enum acpi_reconfig_event  {
 int acpi_reconfig_notifier_register(struct notifier_block *nb);
 int acpi_reconfig_notifier_unregister(struct notifier_block *nb);
 
+#ifdef CONFIG_ACPI_GTDT
+int acpi_gtdt_init(struct acpi_table_header *table);
+int acpi_gtdt_map_ppi(int type);
+bool acpi_gtdt_c3stop(void);
+#endif
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
