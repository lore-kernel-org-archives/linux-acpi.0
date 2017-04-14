From: fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Subject: [PATCH v24 05/11] clocksource: arm_arch_timer: split MMIO timer probing.
Date: Sat, 15 Apr 2017 02:40:08 +0800
Message-ID: <20170414184014.8524-6-fu.wei@linaro.org>
References: <20170414184014.8524-1-fu.wei@linaro.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170414184014.8524-1-fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org, Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Currently the code to probe MMIO architected timers mixes DT parsing with
actual poking of hardware. This makes the code harder than necessary to
understand, and makes it difficult to add support for probing via ACPI.

This patch splits the DT parsing from HW probing. The DT parsing now
lives in arch_timer_mem_of_init(), which fills in an arch_timer_mem
structure that it hands to probing functions that can be reused for ACPI
support.

Since the rate detection logic will be slight different when using ACPI,
the probing is performed as a number of steps. This results in more code
for the moment, and some arguably redundant work, but simplifies matters
considerably when ACPI support is added.

Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
[Mark: refactor the probing split]
Signed-off-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
---
 drivers/clocksource/arm_arch_timer.c | 186 +++++++++++++++++++++++++++--------
 1 file changed, 143 insertions(+), 43 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index e5e8708..dad0264 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1197,18 +1197,37 @@ static int __init arch_timer_of_init(struct device_node *np)
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
 CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
 
-static int __init arch_timer_mem_init(struct device_node *np)
+static u32 __init
+arch_timer_mem_frame_get_cntfrq(struct arch_timer_mem_frame *frame)
 {
-	struct device_node *frame, *best_frame = NULL;
-	void __iomem *cntctlbase, *base;
-	unsigned int irq, ret = -EINVAL;
-	u32 cnttidr, rate;
+	void __iomem *base;
+	u32 rate;
 
-	arch_timers_present |= ARCH_TIMER_TYPE_MEM;
-	cntctlbase = of_iomap(np, 0);
+	base = ioremap(frame->cntbase, frame->size);
+	if (!base) {
+		pr_err("Unable to map frame @ %pa\n", &frame->cntbase);
+		return 0;
+	}
+
+	rate = readl_relaxed(frame + CNTFRQ);
+
+	iounmap(frame);
+
+	return rate;
+}
+
+static struct arch_timer_mem_frame * __init
+arch_timer_mem_find_best_frame(struct arch_timer_mem *timer_mem)
+{
+	struct arch_timer_mem_frame *frame, *best_frame = NULL;
+	void __iomem *cntctlbase;
+	u32 cnttidr;
+	int i;
+
+	cntctlbase = ioremap(timer_mem->cntctlbase, timer_mem->size);
 	if (!cntctlbase) {
-		pr_err("Can't find CNTCTLBase\n");
-		return -ENXIO;
+		pr_err("Can't map CNTCTLBase @ %pa\n", &timer_mem->cntctlbase);
+		return NULL;
 	}
 
 	cnttidr = readl_relaxed(cntctlbase + CNTTIDR);
@@ -1217,25 +1236,20 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	 * Try to find a virtual capable frame. Otherwise fall back to a
 	 * physical capable frame.
 	 */
-	for_each_available_child_of_node(np, frame) {
-		int n;
-		u32 cntacr;
+	for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
+		u32 cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
+			     CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
 
-		if (of_property_read_u32(frame, "frame-number", &n)) {
-			pr_err("Missing frame-number\n");
-			of_node_put(frame);
-			goto out;
-		}
+		frame = &timer_mem->frame[i];
+		if (!frame->valid)
+			continue;
 
 		/* Try enabling everything, and see what sticks */
-		cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
-			 CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
-		writel_relaxed(cntacr, cntctlbase + CNTACR(n));
-		cntacr = readl_relaxed(cntctlbase + CNTACR(n));
+		writel_relaxed(cntacr, cntctlbase + CNTACR(i));
+		cntacr = readl_relaxed(cntctlbase + CNTACR(i));
 
-		if ((cnttidr & CNTTIDR_VIRT(n)) &&
+		if ((cnttidr & CNTTIDR_VIRT(i)) &&
 		    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT))) {
-			of_node_put(best_frame);
 			best_frame = frame;
 			arch_timer_mem_use_virtual = true;
 			break;
@@ -1244,45 +1258,131 @@ static int __init arch_timer_mem_init(struct device_node *np)
 		if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
 			continue;
 
-		of_node_put(best_frame);
-		best_frame = of_node_get(frame);
+		best_frame = frame;
 	}
 
-	ret= -ENXIO;
-	base = arch_counter_base = of_io_request_and_map(best_frame, 0,
-							 "arch_mem_timer");
-	if (IS_ERR(base)) {
-		pr_err("Can't map frame's registers\n");
-		goto out;
-	}
+	iounmap(cntctlbase);
+
+	if (!best_frame)
+		pr_err("Unable to find a suitable frame in timer @ %pa\n",
+		       &timer_mem->cntctlbase);
+
+	return frame;
+}
+
+static int __init
+arch_timer_mem_frame_register(struct arch_timer_mem_frame *frame)
+{
+	void __iomem *base;
+	int ret, irq = 0;
 
 	if (arch_timer_mem_use_virtual)
-		irq = irq_of_parse_and_map(best_frame, ARCH_TIMER_VIRT_SPI);
+		irq = frame->virt_irq;
 	else
-		irq = irq_of_parse_and_map(best_frame, ARCH_TIMER_PHYS_SPI);
+		irq = frame->phys_irq;
 
-	ret = -EINVAL;
 	if (!irq) {
 		pr_err("Frame missing %s irq.\n",
 		       arch_timer_mem_use_virtual ? "virt" : "phys");
-		goto out;
+		return -EINVAL;
+	}
+
+	if (!request_mem_region(frame->cntbase, frame->size,
+				"arch_mem_timer"))
+		return -EBUSY;
+
+	base = ioremap(frame->cntbase, frame->size);
+	if (!base) {
+		pr_err("Can't map frame's registers\n");
+		return -ENXIO;
 	}
 
-	rate = readl(base + CNTFRQ);
-	arch_timer_of_configure_rate(rate, np);
 	ret = arch_timer_mem_register(base, irq);
-	if (ret)
+	if (ret) {
+		iounmap(base);
+		return ret;
+	}
+
+	arch_counter_base = base;
+	arch_timers_present |= ARCH_TIMER_TYPE_MEM;
+
+	return 0;
+}
+
+static int __init arch_timer_mem_of_init(struct device_node *np)
+{
+	struct arch_timer_mem *timer_mem;
+	struct arch_timer_mem_frame *frame;
+	struct device_node *frame_node;
+	struct resource res;
+	int ret = -EINVAL;
+	u32 rate;
+
+	timer_mem = kzalloc(sizeof(*timer_mem), GFP_KERNEL);
+	if (!timer_mem)
+		return -ENOMEM;
+
+	if (of_address_to_resource(np, 0, &res))
 		goto out;
+	timer_mem->cntctlbase = res.start;
+	timer_mem->size = resource_size(&res);
 
-	if (!arch_timer_needs_of_probing())
+	for_each_available_child_of_node(np, frame_node) {
+		u32 n;
+		struct arch_timer_mem_frame *frame;
+
+		if (of_property_read_u32(frame_node, "frame-number", &n)) {
+			pr_err(FW_BUG "Missing frame-number.\n");
+			of_node_put(frame_node);
+			goto out;
+		}
+		if (n >= ARCH_TIMER_MEM_MAX_FRAMES) {
+			pr_err(FW_BUG "Wrong frame-number, only 0-%u are permitted.\n",
+			       ARCH_TIMER_MEM_MAX_FRAMES - 1);
+			of_node_put(frame_node);
+			goto out;
+		}
+		frame = &timer_mem->frame[n];
+
+		if (frame->valid) {
+			pr_err(FW_BUG "Duplicated frame-number.\n");
+			of_node_put(frame_node);
+			goto out;
+		}
+
+		if (of_address_to_resource(frame_node, 0, &res)) {
+			of_node_put(frame_node);
+			goto out;
+		}
+		frame->cntbase = res.start;
+		frame->size = resource_size(&res);
+
+		frame->virt_irq = irq_of_parse_and_map(frame_node,
+						       ARCH_TIMER_VIRT_SPI);
+		frame->phys_irq = irq_of_parse_and_map(frame_node,
+						       ARCH_TIMER_PHYS_SPI);
+
+		frame->valid = true;
+	}
+
+	frame = arch_timer_mem_find_best_frame(timer_mem);
+	if (!frame) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	rate = arch_timer_mem_frame_get_cntfrq(frame);
+	arch_timer_of_configure_rate(rate, np);
+
+	ret = arch_timer_mem_frame_register(frame);
+	if (!ret && !arch_timer_needs_of_probing())
 		ret = arch_timer_common_init();
 out:
-	iounmap(cntctlbase);
-	of_node_put(best_frame);
+	kfree(timer_mem);
 	return ret;
 }
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
-		       arch_timer_mem_init);
+		       arch_timer_mem_of_init);
 
 #ifdef CONFIG_ACPI
 static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
