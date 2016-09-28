From: fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Subject: [PATCH v14 6/9] acpi/arm64: Add memory-mapped timer support in GTDT driver
Date: Thu, 29 Sep 2016 02:17:14 +0800
Message-ID: <1475086637-1914-7-git-send-email-fu.wei@linaro.org>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1475086637-1914-1-git-send-email-fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org, Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

On platforms booting with ACPI, architected memory-mapped timers'
configuration data is provided by firmware through the ACPI GTDT
static table.

The clocksource architected timer kernel driver requires a firmware
interface to collect timer configuration and configure its driver.
this infrastructure is present for device tree systems, but it is
missing on systems booting with ACPI.

Implement the kernel infrastructure required to parse the static
ACPI GTDT table so that the architected timer clocksource driver can
make use of it on systems booting with ACPI, therefore enabling
the corresponding timers configuration.

Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/acpi/arm64/gtdt.c            | 70 ++++++++++++++++++++++++++++++++++++
 include/clocksource/arm_arch_timer.h | 15 ++++++++
 include/linux/acpi.h                 |  1 +
 3 files changed, 86 insertions(+)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index b24844d..b6021db 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -150,3 +150,73 @@ int __init acpi_gtdt_init(struct acpi_table_header *table)
 
 	return gtdt->platform_timer_count;
 }
+
+static int __init gtdt_parse_gt_block(struct acpi_gtdt_timer_block *block,
+				      struct gt_block_data *data)
+{
+	struct acpi_gtdt_timer_entry *frame;
+	int i;
+
+	if (!block || !data)
+		return -EINVAL;
+
+	if (!block->block_address || !block->timer_count)
+		return -EINVAL;
+
+	data->cntctlbase_phy = (phys_addr_t)block->block_address;
+	data->timer_count = block->timer_count;
+
+	frame = (void *)block + block->timer_offset;
+	if (frame + block->timer_count != (void *)block + block->header.length)
+		return -EINVAL;
+
+	/*
+	 * Get the GT timer Frame data for every GT Block Timer
+	 */
+	for (i = 0; i < block->timer_count; i++, frame++) {
+		if (!frame->base_address || !frame->timer_interrupt)
+			return -EINVAL;
+
+		data->timer[i].irq = map_gt_gsi(frame->timer_interrupt,
+						frame->timer_flags);
+		if (data->timer[i].irq <= 0)
+			return -EINVAL;
+
+		if (frame->virtual_timer_interrupt) {
+			data->timer[i].virtual_irq =
+				map_gt_gsi(frame->virtual_timer_interrupt,
+					   frame->virtual_timer_flags);
+			if (data->timer[i].virtual_irq <= 0)
+				return -EINVAL;
+		}
+
+		data->timer[i].frame_nr = frame->frame_number;
+		data->timer[i].cntbase_phy = frame->base_address;
+	}
+
+	return 0;
+}
+
+/*
+ * Get the GT block info for memory-mapped timer from GTDT table.
+ */
+int __init gtdt_arch_timer_mem_init(struct gt_block_data *data)
+{
+	void *platform_timer;
+	int index = 0;
+	int ret;
+
+	for_each_platform_timer(platform_timer) {
+		if (!is_timer_block(platform_timer))
+			continue;
+		ret = gtdt_parse_gt_block(platform_timer, data + index);
+		if (ret)
+			return ret;
+		index++;
+	}
+
+	if (index)
+		pr_info("found %d memory-mapped timer block(s).\n", index);
+
+	return index;
+}
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 16dcd10..94a5d14 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -56,6 +56,8 @@ enum spi_nr {
 #define ARCH_TIMER_MEM_PHYS_ACCESS	2
 #define ARCH_TIMER_MEM_VIRT_ACCESS	3
 
+#define ARCH_TIMER_MEM_MAX_FRAME	8
+
 #define ARCH_TIMER_USR_PCT_ACCESS_EN	(1 << 0) /* physical counter */
 #define ARCH_TIMER_USR_VCT_ACCESS_EN	(1 << 1) /* virtual counter */
 #define ARCH_TIMER_VIRT_EVT_EN		(1 << 2)
@@ -71,6 +73,19 @@ struct arch_timer_kvm_info {
 	int virtual_irq;
 };
 
+struct gt_timer_data {
+	int frame_nr;
+	phys_addr_t cntbase_phy;
+	int irq;
+	int virtual_irq;
+};
+
+struct gt_block_data {
+	phys_addr_t cntctlbase_phy;
+	int timer_count;
+	struct gt_timer_data timer[ARCH_TIMER_MEM_MAX_FRAME];
+};
+
 #ifdef CONFIG_ARM_ARCH_TIMER
 
 extern u32 arch_timer_get_rate(void);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e2f9841..5dc0b85 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -571,6 +571,7 @@ int acpi_reconfig_notifier_unregister(struct notifier_block *nb);
 int acpi_gtdt_init(struct acpi_table_header *table);
 int acpi_gtdt_map_ppi(int type);
 bool acpi_gtdt_c3stop(void);
+int gtdt_arch_timer_mem_init(struct gt_block_data *data);
 #endif
 
 #else	/* !CONFIG_ACPI */
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
