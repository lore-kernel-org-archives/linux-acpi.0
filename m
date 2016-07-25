From: fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Subject: [PATCH v9 8/9] clocksource/drivers/arm_arch_timer: Add GTDT support for memory-mapped timer
Date: Mon, 25 Jul 2016 23:27:06 +0800
Message-ID: <1469460427-8643-9-git-send-email-fu.wei@linaro.org>
References: <1469460427-8643-1-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1469460427-8643-1-git-send-email-fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

=46rom: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

The patch add memory-mapped timer register support by using the informa=
tion
provided by the new GTDT driver of ACPI.

Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/clocksource/arm_arch_timer.c | 127 +++++++++++++++++++++++++++=
+++++++-
 1 file changed, 124 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource=
/arm_arch_timer.c
index d285a87..e4909b2 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -840,7 +840,128 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm=
,armv7-timer-mem",
 		       arch_timer_mem_init);
=20
 #ifdef CONFIG_ACPI_GTDT
-/* Initialize per-processor generic timer */
+static struct gt_timer_data __init *arch_timer_mem_get_timer(
+						struct gt_block_data *gt_blocks)
+{
+	struct gt_block_data *gt_block =3D gt_blocks;
+	struct gt_timer_data *best_frame =3D NULL;
+	void __iomem *cntctlbase;
+	u32 cnttidr;
+	int i;
+
+	/*
+	 * According to ARMv8 Architecture Reference Manual(ARM),
+	 * the size of CNTCTLBase frame of memory-mapped timer
+	 * is SZ_4K(Offset 0x000 =E2=80=93 0xFFF).
+	 */
+	cntctlbase =3D ioremap(gt_block->cntctlbase_phy, SZ_4K);
+	if (!cntctlbase) {
+		pr_err("Failed to map mem timer control frame base address\n");
+		return NULL;
+	}
+	cnttidr =3D readl_relaxed(cntctlbase + CNTTIDR);
+
+	/*
+	 * Try to find a virtual capable frame. Otherwise fall back to a
+	 * physical capable frame.
+	 */
+	for (i =3D 0; i < gt_block->timer_count; i++) {
+		int n;
+		u32 cntacr;
+
+		n =3D gt_block->timer[i].frame_nr;
+
+		/* Try enabling everything, and see what sticks */
+		cntacr =3D CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
+			 CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
+		writel_relaxed(cntacr, cntctlbase + CNTACR(n));
+		cntacr =3D readl_relaxed(cntctlbase + CNTACR(n));
+
+		if ((cnttidr & CNTTIDR_VIRT(n)) &&
+		    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT))) {
+			best_frame =3D &gt_block->timer[i];
+			arch_timer_mem_use_virtual =3D true;
+			break;
+		}
+
+		if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
+			continue;
+
+		best_frame =3D &gt_block->timer[i];
+	}
+	iounmap(cntctlbase);
+
+	return best_frame;
+}
+
+static int __init arch_timer_mem_acpi_init(size_t timer_count)
+{
+	struct gt_block_data *gt_blocks;
+	struct gt_timer_data *gt_timer;
+	void __iomem *timer_cntbase;
+	int ret =3D -EINVAL;
+	int timer_irq;
+
+	/*
+	 * If we don't have any Platform Timer Structures, just return.
+	 */
+	if (!timer_count)
+		return 0;
+
+	/*
+	 * before really check all the Platform Timer Structures,
+	 * we assume they are GT block, and allocate memory for them.
+	 * We will free these memory once we finish the initialization.
+	 */
+	gt_blocks =3D kcalloc(timer_count, sizeof(*gt_blocks), GFP_KERNEL);
+	if (!gt_blocks)
+		return -ENOMEM;
+
+	if (gtdt_arch_timer_mem_init(gt_blocks) > 0) {
+		gt_timer =3D arch_timer_mem_get_timer(gt_blocks);
+		if (!gt_timer) {
+			pr_err("Failed to get mem timer info.\n");
+			goto error;
+		}
+
+		if (arch_timer_mem_use_virtual)
+			timer_irq =3D gt_timer->virtual_irq;
+		else
+			timer_irq =3D gt_timer->irq;
+		if (!timer_irq) {
+			pr_err("Failed to get %s irq for mem timer.",
+			       arch_timer_mem_use_virtual ? "virt" : "phys");
+			goto error;
+		}
+
+		/*
+		 * According to ARMv8 Architecture Reference Manual(ARM),
+		 * the size of CNTBaseN frames of memory-mapped timer
+		 * is SZ_4K(Offset 0x000 =E2=80=93 0xFFF).
+		 */
+		timer_cntbase =3D ioremap(gt_timer->cntbase_phy, SZ_4K);
+		if (!timer_cntbase) {
+			pr_err("Failed to map mem timer base address.\n");
+			goto error;
+		}
+
+		ret =3D arch_timer_mem_register(timer_cntbase, timer_irq);
+		if (ret) {
+			iounmap(timer_cntbase);
+			pr_err("Failed to register mem timer.\n");
+			goto error;
+		}
+
+		arch_counter_base =3D timer_cntbase;
+		arch_timers_present |=3D ARCH_MEM_TIMER;
+	}
+
+error:
+	kfree(gt_blocks);
+	return ret;
+}
+
+/* Initialize per-processor generic timer and memory-mapped timer(if p=
resent) */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table=
)
 {
 	int timer_count;
@@ -864,8 +985,8 @@ static int __init arch_timer_acpi_init(struct acpi_=
table_header *table)
 	/* Get the frequency from CNTFRQ */
 	arch_timer_detect_rate(NULL, NULL);
=20
-	if (timer_count < 0)
-		pr_err("Failed to get platform timer info, skipping.\n");
+	if (timer_count < 0 || arch_timer_mem_acpi_init((size_t)timer_count))
+		pr_err("Failed to initialize memory-mapped timer, skipping.\n");
=20
 	arch_timer_init();
=20
--=20
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
