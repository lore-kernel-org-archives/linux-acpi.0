From: fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Subject: [PATCH v17 05/15] clocksource/drivers/arm_arch_timer: rework PPI determination
Date: Fri, 25 Nov 2016 16:46:13 +0800
Message-ID: <20161125084623.22515-6-fu.wei@linaro.org>
References: <20161125084623.22515-1-fu.wei@linaro.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161125084623.22515-1-fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org, Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Currently, the arch timer driver uses ARCH_TIMER_PHYS_SECURE_PPI to
mean the driver will use the secure PPI *and* potentialy also use the
non-secure PPI. This is somewhat confusing.

For arm64, where it never makes sense to use the secure PPI, this
means we must always request the useless secure PPI, adding to the
confusion. For ACPI, where we may not even have a valid secure PPI
number, this is additionally problematic. We need the driver to be
able to use *only* the non-secure PPI.

The logic to choose which PPI to use is intertwined with other logic
in arch_timer_init(). This patch factors the PPI determination out
into a new function named arch_timer_select_ppi, and then reworks it
so that we can handle having only a non-secure PPI.

This patch also moves arch_timer_ppi verification out to caller,
because we can verify the configuration from device-tree for ARM by this
way.

Meanwhile, because we will select ARCH_TIMER_PHYS_NONSECURE_PPI for ARM64,
the logic in arch_timer_register also need to be updated.

Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/clocksource/arm_arch_timer.c | 77 +++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 231175b..e43be0a 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -699,7 +699,7 @@ static int __init arch_timer_register(void)
 	case ARCH_TIMER_PHYS_NONSECURE_PPI:
 		err = request_percpu_irq(ppi, arch_timer_handler_phys,
 					 "arch_timer", arch_timer_evt);
-		if (!err && arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]) {
+		if (!err && arch_timer_has_nonsecure_ppi()) {
 			ppi = arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI];
 			err = request_percpu_irq(ppi, arch_timer_handler_phys,
 						 "arch_timer", arch_timer_evt);
@@ -821,39 +821,41 @@ static int __init arch_timer_common_init(void)
 	return arch_timer_arch_init();
 }
 
-static int __init arch_timer_init(void)
+/**
+ * arch_timer_select_ppi() - Select suitable PPI for the current system.
+ *
+ * If HYP mode is available, we know that the physical timer
+ * has been configured to be accessible from PL1. Use it, so
+ * that a guest can use the virtual timer instead.
+ *
+ * On ARMv8.1 with VH extensions, the kernel runs in HYP. VHE
+ * accesses to CNTP_*_EL1 registers are silently redirected to
+ * their CNTHP_*_EL2 counterparts, and use a different PPI
+ * number.
+ *
+ * If no interrupt provided for virtual timer, we'll have to
+ * stick to the physical timer. It'd better be accessible...
+ * For arm64 we never use the secure interrupt.
+ *
+ * Return: a suitable PPI type for the current system.
+ */
+static enum arch_timer_ppi_nr __init arch_timer_select_ppi(void)
 {
-	int ret;
-	/*
-	 * If HYP mode is available, we know that the physical timer
-	 * has been configured to be accessible from PL1. Use it, so
-	 * that a guest can use the virtual timer instead.
-	 *
-	 * If no interrupt provided for virtual timer, we'll have to
-	 * stick to the physical timer. It'd better be accessible...
-	 *
-	 * On ARMv8.1 with VH extensions, the kernel runs in HYP. VHE
-	 * accesses to CNTP_*_EL1 registers are silently redirected to
-	 * their CNTHP_*_EL2 counterparts, and use a different PPI
-	 * number.
-	 */
-	if (is_hyp_mode_available() || !arch_timer_ppi[ARCH_TIMER_VIRT_PPI]) {
-		bool has_ppi;
+	if (is_hyp_mode_available() && is_kernel_in_hyp_mode())
+		return ARCH_TIMER_HYP_PPI;
 
-		if (is_kernel_in_hyp_mode()) {
-			arch_timer_uses_ppi = ARCH_TIMER_HYP_PPI;
-			has_ppi = !!arch_timer_ppi[ARCH_TIMER_HYP_PPI];
-		} else {
-			arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
-			has_ppi = (!!arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI] ||
-				   !!arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
-		}
+	if (arch_timer_ppi[ARCH_TIMER_VIRT_PPI])
+		return ARCH_TIMER_VIRT_PPI;
 
-		if (!has_ppi) {
-			pr_warn("No interrupt available, giving up\n");
-			return -EINVAL;
-		}
-	}
+	if (IS_ENABLED(CONFIG_ARM64))
+		return ARCH_TIMER_PHYS_NONSECURE_PPI;
+
+	return ARCH_TIMER_PHYS_SECURE_PPI;
+}
+
+static int __init arch_timer_init(void)
+{
+	int ret;
 
 	ret = arch_timer_register();
 	if (ret)
@@ -901,6 +903,13 @@ static int __init arch_timer_of_init(struct device_node *np)
 	if (IS_ENABLED(CONFIG_ARM) &&
 	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
 		arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
+	else
+		arch_timer_uses_ppi = arch_timer_select_ppi();
+
+	if (!arch_timer_ppi[arch_timer_uses_ppi]) {
+		pr_err("No interrupt available, giving up\n");
+		return -EINVAL;
+	}
 
 	return arch_timer_init();
 }
@@ -1041,6 +1050,12 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	/* Get the frequency from CNTFRQ */
 	arch_timer_detect_rate(NULL, NULL);
 
+	arch_timer_uses_ppi = arch_timer_select_ppi();
+	if (!arch_timer_ppi[arch_timer_uses_ppi]) {
+		pr_err("No interrupt available, giving up\n");
+		return -EINVAL;
+	}
+
 	/* Always-on capability */
 	arch_timer_c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
 
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
