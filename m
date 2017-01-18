From: fu.wei@linaro.org
Subject: [PATCH v20 13/17] acpi/arm64: Add GTDT table parse driver
Date: Wed, 18 Jan 2017 21:25:37 +0800
Message-ID: <20170118132541.8989-14-fu.wei@linaro.org>
References: <20170118132541.8989-1-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170118132541.8989-1-fu.wei@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, marc.zyngier@arm.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, hanjun.guo@linaro.org
Cc: linaro-acpi@lists.linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, wim@iguana.be, Fu Wei <fu.wei@linaro.org>, wei@redhat.com, al.stone@linaro.org, tn@semihalf.com, timur@codeaurora.org, linux-acpi@vger.kernel.org, linux@roeck-us.net, harba@codeaurora.org, julien.grall@arm.com, linux-watchdog@vger.kernel.org, arnd@arndb.de, jcm@redhat.com, cov@codeaurora.org, linux-arm-kernel@lists.infradead.org, graeme.gregory@linaro.org, rruigrok@codeaurora.org, leo.duran@amd.com, Suravee.Suthikulpanit@amd.com, christoffer.dall@linaro.org
List-Id: linux-acpi@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This patch adds support for parsing arch timer info in GTDT,
provides some kernel APIs to parse all the PPIs and
always-on info in GTDT and export them.

By this driver, we can simplify arm_arch_timer drivers, and
separate the ACPI GTDT knowledge from it.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 arch/arm64/Kconfig          |   1 +
 drivers/acpi/arm64/Kconfig  |   3 +
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/gtdt.c   | 157 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h        |   6 ++
 5 files changed, 168 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1117421..ab1ee10 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2,6 +2,7 @@ config ARM64
 	def_bool y
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_GTDT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if ACPI
 	select ACPI_SPCR_TABLE if ACPI
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
index 0000000..d93a790
--- /dev/null
+++ b/drivers/acpi/arm64/gtdt.c
@@ -0,0 +1,157 @@
+/*
+ * ARM Specific GTDT table Support
+ *
+ * Copyright (C) 2016, Linaro Ltd.
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *         Fu Wei <fu.wei@linaro.org>
+ *         Hanjun Guo <hanjun.guo@linaro.org>
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
+/**
+ * struct acpi_gtdt_descriptor - Store the key info of GTDT for all functions
+ * @gtdt:	The pointer to the struct acpi_table_gtdt of GTDT table.
+ * @gtdt_end:	The pointer to the end of GTDT table.
+ * @platform_timer:	The pointer to the start of Platform Timer Structure
+ *
+ * The struct store the key info of GTDT table, it should be initialized by
+ * acpi_gtdt_init.
+ */
+struct acpi_gtdt_descriptor {
+	struct acpi_table_gtdt *gtdt;
+	void *gtdt_end;
+	void *platform_timer;
+};
+
+static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
+
+static int __init map_gt_gsi(u32 interrupt, u32 flags)
+{
+	int trigger, polarity;
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
+/**
+ * acpi_gtdt_map_ppi() - Map the PPIs of per-cpu arch_timer.
+ * @type:	the type of PPI.
+ *
+ * Note: Linux on arm64 isn't supported on the secure side.
+ * So we only handle the non-secure timer PPIs,
+ * ARCH_TIMER_PHYS_SECURE_PPI is treated as invalid type.
+ *
+ * Return: the mapped PPI value, 0 if error.
+ */
+int __init acpi_gtdt_map_ppi(int type)
+{
+	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
+
+	switch (type) {
+	case ARCH_TIMER_PHYS_NONSECURE_PPI:
+		return map_gt_gsi(gtdt->non_secure_el1_interrupt,
+				  gtdt->non_secure_el1_flags);
+	case ARCH_TIMER_VIRT_PPI:
+		return map_gt_gsi(gtdt->virtual_timer_interrupt,
+				  gtdt->virtual_timer_flags);
+
+	case ARCH_TIMER_HYP_PPI:
+		return map_gt_gsi(gtdt->non_secure_el2_interrupt,
+				  gtdt->non_secure_el2_flags);
+	default:
+		pr_err("Failed to map timer interrupt: invalid type.\n");
+	}
+
+	return 0;
+}
+
+/**
+ * acpi_gtdt_c3stop() - Got c3stop info from GTDT according to the type of PPI.
+ * @type:	the type of PPI.
+ *
+ * Return: 1 if the timer can be in deep idle state, 0 otherwise.
+ */
+bool __init acpi_gtdt_c3stop(int type)
+{
+	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
+
+	switch (type) {
+	case ARCH_TIMER_PHYS_NONSECURE_PPI:
+		return !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
+
+	case ARCH_TIMER_VIRT_PPI:
+		return !(gtdt->virtual_timer_flags & ACPI_GTDT_ALWAYS_ON);
+
+	case ARCH_TIMER_HYP_PPI:
+		return !(gtdt->non_secure_el2_flags & ACPI_GTDT_ALWAYS_ON);
+
+	default:
+		pr_err("Failed to get c3stop info: invalid type.\n");
+	}
+
+	return 0;
+}
+
+/**
+ * acpi_gtdt_init() - Get the info of GTDT table to prepare for further init.
+ * @table:	The pointer to GTDT table.
+ * @platform_timer_count:	The pointer of int variate for returning the
+ *				number of platform timers. It can be NULL, if
+ *				driver don't need this info.
+ *
+ * Return: 0 if success, -EINVAL if error.
+ */
+int __init acpi_gtdt_init(struct acpi_table_header *table,
+			  int *platform_timer_count)
+{
+	int ret = 0;
+	int timer_count = 0;
+	void *platform_timer = NULL;
+	struct acpi_table_gtdt *gtdt;
+
+	gtdt = container_of(table, struct acpi_table_gtdt, header);
+	acpi_gtdt_desc.gtdt = gtdt;
+	acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
+
+	if (table->revision < 2)
+		pr_debug("Revision:%d doesn't support Platform Timers.\n",
+			 table->revision);
+	else if (!gtdt->platform_timer_count)
+		pr_debug("No Platform Timer.\n");
+	else
+		timer_count = gtdt->platform_timer_count;
+
+	if (timer_count) {
+		platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
+		if (platform_timer < (void *)table +
+				     sizeof(struct acpi_table_gtdt)) {
+			pr_err(FW_BUG "invalid timer data.\n");
+			timer_count = 0;
+			platform_timer = NULL;
+			ret = -EINVAL;
+		}
+	}
+
+	acpi_gtdt_desc.platform_timer = platform_timer;
+	if (platform_timer_count)
+		*platform_timer_count = timer_count;
+
+	return ret;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5b36974..d0b271e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -597,6 +597,12 @@ enum acpi_reconfig_event  {
 int acpi_reconfig_notifier_register(struct notifier_block *nb);
 int acpi_reconfig_notifier_unregister(struct notifier_block *nb);
 
+#ifdef CONFIG_ACPI_GTDT
+int acpi_gtdt_init(struct acpi_table_header *table, int *platform_timer_count);
+int acpi_gtdt_map_ppi(int type);
+bool acpi_gtdt_c3stop(int type);
+#endif
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
-- 
2.9.3
