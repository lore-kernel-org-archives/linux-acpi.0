From: fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Subject: [PATCH v18 08/15] clocksource/drivers/arm_arch_timer: move arch_timer_needs_of_probing into DT init call
Date: Fri,  9 Dec 2016 01:33:12 +0800
Message-ID: <20161208173319.6618-9-fu.wei@linaro.org>
References: <20161208173319.6618-1-fu.wei@linaro.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161208173319.6618-1-fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org, Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Because arch_timer_needs_of_probing is only for booting with device-tree,
but arch_timer_common_init is a generic init call which shouldn't include
the FW-specific code. It's better to put arch_timer_needs_of_probing into
DT init function.

But for per-cpu timer, the arch_timer_common_init is called from
arch_timer_init. For reaching the goal above, this patch disassemble
arch_timer_init and use arch_timer_register and arch_timer_common_init
directly, just like arch_timer_mem init code is doing.
By this way, all the DT relevant code are only called from DT init call.

Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/clocksource/arm_arch_timer.c | 46 ++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 2c9085a..8c813da 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -821,9 +821,6 @@ static bool __init arch_timer_needs_of_probing(void)
 
 static int __init arch_timer_common_init(void)
 {
-	if (acpi_disabled && arch_timer_needs_of_probing())
-		return 0;
-
 	arch_timer_banner(arch_timers_present);
 	arch_counter_register(arch_timers_present);
 	return arch_timer_arch_init();
@@ -861,26 +858,9 @@ static enum arch_timer_ppi_nr __init arch_timer_select_ppi(void)
 	return ARCH_TIMER_PHYS_SECURE_PPI;
 }
 
-static int __init arch_timer_init(void)
-{
-	int ret;
-
-	ret = arch_timer_register();
-	if (ret)
-		return ret;
-
-	ret = arch_timer_common_init();
-	if (ret)
-		return ret;
-
-	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
-
-	return 0;
-}
-
 static int __init arch_timer_of_init(struct device_node *np)
 {
-	int i;
+	int i, ret;
 
 	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
 		pr_warn("multiple nodes in dt, skipping\n");
@@ -891,6 +871,8 @@ static int __init arch_timer_of_init(struct device_node *np)
 	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++)
 		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
 
+	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
+
 	if (!arch_timer_rate &&
 	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
 		arch_timer_detect_rate();
@@ -921,7 +903,14 @@ static int __init arch_timer_of_init(struct device_node *np)
 		return -EINVAL;
 	}
 
-	return arch_timer_init();
+	ret = arch_timer_register();
+	if (ret)
+		return ret;
+
+	if (arch_timer_needs_of_probing())
+		return 0;
+
+	return arch_timer_common_init();
 }
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
 CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
@@ -1008,7 +997,8 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	if (ret)
 		goto out;
 
-	return arch_timer_common_init();
+	if (!arch_timer_needs_of_probing())
+		ret = arch_timer_common_init();
 out:
 	iounmap(cntctlbase);
 	of_node_put(best_frame);
@@ -1037,6 +1027,7 @@ static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
 /* Initialize per-processor generic timer */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
+	int ret;
 	struct acpi_table_gtdt *gtdt;
 
 	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
@@ -1064,6 +1055,8 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
 		gtdt->non_secure_el2_flags);
 
+	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
+
 	/* Get the frequency from CNTFRQ */
 	arch_timer_detect_rate();
 
@@ -1076,8 +1069,11 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	/* Always-on capability */
 	arch_timer_c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
 
-	arch_timer_init();
-	return 0;
+	ret = arch_timer_register();
+	if (ret)
+		return ret;
+
+	return arch_timer_common_init();
 }
 CLOCKSOURCE_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
 #endif
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
