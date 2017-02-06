From: fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Subject: [PATCH v21 02/13] clocksource: arm_arch_timer: separate out device-tree code from arch_timer_detect_rate
Date: Tue,  7 Feb 2017 02:50:04 +0800
Message-ID: <20170206185015.12296-3-fu.wei@linaro.org>
References: <20170206185015.12296-1-fu.wei@linaro.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170206185015.12296-1-fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org, Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Currently, the counter frequency detection call(arch_timer_detect_rate)
include getting the frequency from the device-tree property.
But reading device-tree property will be needed only when system boot with
device-tree.

This patch separate out device-tree code, keep them in device-tree init
function.

Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Tested-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/clocksource/arm_arch_timer.c | 38 ++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 1d273d6..aa14305 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -571,24 +571,19 @@ static u32 arch_timer_get_mmio_freq(void __iomem *cntbase)
 	return readl_relaxed(cntbase + CNTFRQ);
 }
 
-static void
-arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
+static void arch_timer_detect_rate(void __iomem *cntbase)
 {
 	/* Who has more than one independent system counter? */
 	if (arch_timer_rate)
 		return;
 
 	/*
-	 * Try to determine the frequency from the device tree or CNTFRQ,
-	 * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
+	 * Try to determine the frequency from the MMIO timer or the sysreg.
 	 */
-	if (!acpi_disabled ||
-	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
-		if (cntbase)
-			arch_timer_rate = arch_timer_get_mmio_freq(cntbase);
-		else
-			arch_timer_rate = arch_timer_get_sysreg_freq();
-	}
+	if (cntbase)
+		arch_timer_rate = arch_timer_get_mmio_freq(cntbase);
+	else
+		arch_timer_rate = arch_timer_get_sysreg_freq();
 
 	/* Check the timer frequency. */
 	if (arch_timer_rate == 0)
@@ -969,7 +964,13 @@ static int __init arch_timer_of_init(struct device_node *np)
 	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++)
 		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
 
-	arch_timer_detect_rate(NULL, np);
+	/*
+	 * Try to determine the frequency from the device tree,
+	 * if fail, get the frequency from the sysreg CNTFRQ.
+	 */
+	if (!arch_timer_rate &&
+	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
+		arch_timer_detect_rate(NULL);
 
 	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
 
@@ -1080,7 +1081,14 @@ static int __init arch_timer_mem_init(struct device_node *np)
 		goto out;
 	}
 
-	arch_timer_detect_rate(base, np);
+	/*
+	 * Try to determine the frequency from the device tree,
+	 * if fail, get the frequency from the CNTFRQ reg of MMIO timer.
+	 */
+	if (!arch_timer_rate &&
+	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
+		arch_timer_detect_rate(base);
+
 	ret = arch_timer_mem_register(base, irq);
 	if (ret)
 		goto out;
@@ -1141,8 +1149,8 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
 		gtdt->non_secure_el2_flags);
 
-	/* Get the frequency from CNTFRQ */
-	arch_timer_detect_rate(NULL, NULL);
+	/* Get the frequency from the sysreg CNTFRQ */
+	arch_timer_detect_rate(NULL);
 
 	arch_timer_uses_ppi = arch_timer_select_ppi();
 	if (!arch_timer_ppi[arch_timer_uses_ppi]) {
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
