From: fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Subject: [PATCH v19 03/15] clocksource/drivers/arm_arch_timer: Improve printk relevant code
Date: Wed, 21 Dec 2016 14:45:51 +0800
Message-ID: <20161221064603.11830-4-fu.wei@linaro.org>
References: <20161221064603.11830-1-fu.wei@linaro.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161221064603.11830-1-fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org, Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This patch defines pr_fmt(fmt) for all pr_* functions,
then the pr_* doesn't need to add "arch_timer:" everytime.

According to the suggestion from checkpatch.pl:
(1) delete some Blank Spaces in arch_timer_banner;
(2) delete a redundant Tab in a bland line of arch_timer_init(void)

No functional change.

Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/clocksource/arm_arch_timer.c | 49 ++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9aba1c0..7203f95 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -32,6 +32,9 @@
 
 #include <clocksource/arm_arch_timer.h>
 
+#undef pr_fmt
+#define pr_fmt(fmt) "arch_timer: " fmt
+
 #define CNTTIDR		0x08
 #define CNTTIDR_VIRT(n)	(BIT(1) << ((n) * 4))
 
@@ -505,22 +508,22 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
 
 	/* Check the timer frequency. */
 	if (arch_timer_rate == 0)
-		pr_warn("Architected timer frequency not available\n");
+		pr_warn("frequency not available\n");
 }
 
 static void arch_timer_banner(unsigned type)
 {
-	pr_info("Architected %s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
-		     type & ARCH_CP15_TIMER ? "cp15" : "",
-		     type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " : "",
-		     type & ARCH_MEM_TIMER ? "mmio" : "",
-		     (unsigned long)arch_timer_rate / 1000000,
-		     (unsigned long)(arch_timer_rate / 10000) % 100,
-		     type & ARCH_CP15_TIMER ?
-		     (arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
+	pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
+		type & ARCH_CP15_TIMER ? "cp15" : "",
+		type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " : "",
+		type & ARCH_MEM_TIMER ? "mmio" : "",
+		(unsigned long)arch_timer_rate / 1000000,
+		(unsigned long)(arch_timer_rate / 10000) % 100,
+		type & ARCH_CP15_TIMER ?
+			(arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
 			"",
-		     type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  "/" : "",
-		     type & ARCH_MEM_TIMER ?
+		type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  "/" : "",
+		type & ARCH_MEM_TIMER ?
 			arch_timer_mem_use_virtual ? "virt" : "phys" :
 			"");
 }
@@ -621,8 +624,7 @@ static void __init arch_counter_register(unsigned type)
 
 static void arch_timer_stop(struct clock_event_device *clk)
 {
-	pr_debug("arch_timer_teardown disable IRQ%d cpu #%d\n",
-		 clk->irq, smp_processor_id());
+	pr_debug("disable IRQ%d cpu #%d\n", clk->irq, smp_processor_id());
 
 	disable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi]);
 	if (arch_timer_has_nonsecure_ppi())
@@ -715,8 +717,7 @@ static int __init arch_timer_register(void)
 	}
 
 	if (err) {
-		pr_err("arch_timer: can't register interrupt %d (%d)\n",
-		       ppi, err);
+		pr_err("can't register interrupt %d (%d)\n", ppi, err);
 		goto out_free;
 	}
 
@@ -769,7 +770,7 @@ static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
 
 	ret = request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &t->evt);
 	if (ret) {
-		pr_err("arch_timer: Failed to request mem timer irq\n");
+		pr_err("Failed to request mem timer irq\n");
 		kfree(t);
 	}
 
@@ -847,7 +848,7 @@ static int __init arch_timer_init(void)
 		}
 
 		if (!has_ppi) {
-			pr_warn("arch_timer: No interrupt available, giving up\n");
+			pr_warn("No interrupt available, giving up\n");
 			return -EINVAL;
 		}
 	}
@@ -861,7 +862,7 @@ static int __init arch_timer_init(void)
 		return ret;
 
 	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[VIRT_PPI];
-	
+
 	return 0;
 }
 
@@ -870,7 +871,7 @@ static int __init arch_timer_of_init(struct device_node *np)
 	int i;
 
 	if (arch_timers_present & ARCH_CP15_TIMER) {
-		pr_warn("arch_timer: multiple nodes in dt, skipping\n");
+		pr_warn("multiple nodes in dt, skipping\n");
 		return 0;
 	}
 
@@ -918,7 +919,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	arch_timers_present |= ARCH_MEM_TIMER;
 	cntctlbase = of_iomap(np, 0);
 	if (!cntctlbase) {
-		pr_err("arch_timer: Can't find CNTCTLBase\n");
+		pr_err("Can't find CNTCTLBase\n");
 		return -ENXIO;
 	}
 
@@ -933,7 +934,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
 		u32 cntacr;
 
 		if (of_property_read_u32(frame, "frame-number", &n)) {
-			pr_err("arch_timer: Missing frame-number\n");
+			pr_err("Missing frame-number\n");
 			of_node_put(frame);
 			goto out;
 		}
@@ -963,7 +964,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	base = arch_counter_base = of_io_request_and_map(best_frame, 0,
 							 "arch_mem_timer");
 	if (IS_ERR(base)) {
-		pr_err("arch_timer: Can't map frame's registers\n");
+		pr_err("Can't map frame's registers\n");
 		goto out;
 	}
 
@@ -974,7 +975,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
 
 	ret = -EINVAL;
 	if (!irq) {
-		pr_err("arch_timer: Frame missing %s irq",
+		pr_err("Frame missing %s irq.\n",
 		       arch_timer_mem_use_virtual ? "virt" : "phys");
 		goto out;
 	}
@@ -1016,7 +1017,7 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	struct acpi_table_gtdt *gtdt;
 
 	if (arch_timers_present & ARCH_CP15_TIMER) {
-		pr_warn("arch_timer: already initialized, skipping\n");
+		pr_warn("already initialized, skipping\n");
 		return -EINVAL;
 	}
 
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
