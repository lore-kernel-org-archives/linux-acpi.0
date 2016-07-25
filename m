From: fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Subject: [PATCH v9 6/9] clocksource/drivers/arm_arch_timer: Simplify ACPI support code.
Date: Mon, 25 Jul 2016 23:27:04 +0800
Message-ID: <1469460427-8643-7-git-send-email-fu.wei@linaro.org>
References: <1469460427-8643-1-git-send-email-fu.wei@linaro.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1469460427-8643-1-git-send-email-fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

The patch update arm_arch_timer driver to use the function
provided by the new GTDT driver of ACPI.
By this way, arm_arch_timer.c can be simplified, and separate
all the ACPI GTDT knowledge from this timer driver.

Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/clocksource/Kconfig          |  1 +
 drivers/clocksource/arm_arch_timer.c | 48 +++++++++---------------------------
 2 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 108dbc3..61dc160 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -8,6 +8,7 @@ config CLKSRC_OF
 config CLKSRC_ACPI
 	bool
 	select CLKSRC_PROBE
+	select ACPI_GTDT if ARM64
 
 config CLKSRC_PROBE
 	bool
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 483d2f9..d285a87 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -839,60 +839,36 @@ out:
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
 		       arch_timer_mem_init);
 
-#ifdef CONFIG_ACPI
-static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
-{
-	int trigger, polarity;
-
-	if (!interrupt)
-		return 0;
-
-	trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
-			: ACPI_LEVEL_SENSITIVE;
-
-	polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
-			: ACPI_ACTIVE_HIGH;
-
-	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
-}
-
+#ifdef CONFIG_ACPI_GTDT
 /* Initialize per-processor generic timer */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
-	struct acpi_table_gtdt *gtdt;
+	int timer_count;
 
 	if (arch_timers_present & ARCH_CP15_TIMER) {
 		pr_warn("already initialized, skipping\n");
 		return -EINVAL;
 	}
 
-	gtdt = container_of(table, struct acpi_table_gtdt, header);
-
 	arch_timers_present |= ARCH_CP15_TIMER;
 
-	arch_timer_ppi[PHYS_SECURE_PPI] =
-		map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
-		gtdt->secure_el1_flags);
-
-	arch_timer_ppi[PHYS_NONSECURE_PPI] =
-		map_generic_timer_interrupt(gtdt->non_secure_el1_interrupt,
-		gtdt->non_secure_el1_flags);
-
-	arch_timer_ppi[VIRT_PPI] =
-		map_generic_timer_interrupt(gtdt->virtual_timer_interrupt,
-		gtdt->virtual_timer_flags);
+	timer_count = acpi_gtdt_init(table);
 
-	arch_timer_ppi[HYP_PPI] =
-		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
-		gtdt->non_secure_el2_flags);
+	arch_timer_ppi[PHYS_SECURE_PPI] = acpi_gtdt_map_ppi(PHYS_SECURE_PPI);
+	arch_timer_ppi[PHYS_NONSECURE_PPI] = acpi_gtdt_map_ppi(PHYS_NONSECURE_PPI);
+	arch_timer_ppi[VIRT_PPI] = acpi_gtdt_map_ppi(VIRT_PPI);
+	arch_timer_ppi[HYP_PPI] = acpi_gtdt_map_ppi(HYP_PPI);
+	/* Always-on capability */
+	arch_timer_c3stop = acpi_gtdt_c3stop();
 
 	/* Get the frequency from CNTFRQ */
 	arch_timer_detect_rate(NULL, NULL);
 
-	/* Always-on capability */
-	arch_timer_c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
+	if (timer_count < 0)
+		pr_err("Failed to get platform timer info, skipping.\n");
 
 	arch_timer_init();
+
 	return 0;
 }
 CLOCKSOURCE_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
