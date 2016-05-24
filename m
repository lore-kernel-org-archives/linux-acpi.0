From: fu.wei@linaro.org
Subject: [PATCH v5 6/6] clocksource/drivers/arm_arch_timer: Add GTDT support for memory-mapped timer
Date: Tue, 24 May 2016 21:30:33 +0800
Message-ID: <1464096633-9309-7-git-send-email-fu.wei@linaro.org>
References: <1464096633-9309-1-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464096633-9309-1-git-send-email-fu.wei@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, marc.zyngier@arm.com, hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de, wim@iguana.be, catalin.marinas@arm.com, will.deacon@arm.com, Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, Fu Wei <fu.wei@linaro.org>
List-Id: linux-acpi@vger.kernel.org

=46rom: Fu Wei <fu.wei@linaro.org>

The patch add memory-mapped timer register support by using the informa=
tion
provided by the new GTDT driver of ACPI.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 147 +++++++++++++++++++++++++++=
++++++--
 1 file changed, 142 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource=
/arm_arch_timer.c
index 505e65c..3ac0fda 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -849,24 +849,161 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "ar=
m,armv7-timer-mem",
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
+		pr_err("Can't map CNTCTLBase\n");
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
+static int __init arch_timer_mem_acpi_init(u32 timer_count)
+{
+	struct gt_block_data *gt_blocks;
+	struct gt_timer_data *gt_timer;
+	void __iomem *timer_cntbase;
+	int ret =3D -EINVAL;
+	int timer_irq;
+
+	/*
+	 * If we have some Platform Timer Structures,
+	 * try to find and register a memory-mapped timer.
+	 * If not, just return.
+	 */
+	if (!timer_count)
+		return 0;
+
+	if (arch_timers_present & ARCH_MEM_TIMER) {
+		pr_warn("memory-mapped timer already initialized, skipping\n");
+		return 0;
+	}
+	arch_timers_present |=3D ARCH_MEM_TIMER;
+	/*
+	 * before really check all the Platform Timer Structures,
+	 * we assume they are GT block, and allocate memory for them.
+	 * We will free these memory once we finish the initialization.
+	 */
+	gt_blocks =3D kcalloc(timer_count, sizeof(*gt_blocks), GFP_KERNEL);
+	if (!gt_blocks)
+		return -ENOMEM;
+
+	if (gtdt_arch_timer_mem_init(gt_blocks)) {
+		gt_timer =3D arch_timer_mem_get_timer(gt_blocks);
+		if (!gt_timer) {
+			pr_err("Failed to get mem timer info.\n");
+			goto error;
+		}
+
+		if (arch_timer_mem_use_virtual)
+			timer_irq =3D gt_timer->virt_irq;
+		else
+			timer_irq =3D gt_timer->irq;
+		if (!timer_irq) {
+			pr_err("Frame missing %s irq",
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
+			pr_err("Can't map CntBase.\n");
+			goto error;
+		}
+		arch_counter_base =3D timer_cntbase;
+		ret =3D arch_timer_mem_register(timer_cntbase, timer_irq);
+		if (ret) {
+			iounmap(timer_cntbase);
+			arch_counter_base =3D NULL;
+			pr_err("Failed to register mem timer.\n");
+		}
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
+	u32 timer_count;
+
 	if (arch_timers_present & ARCH_CP15_TIMER) {
 		pr_warn("already initialized, skipping\n");
 		return -EINVAL;
 	}
-
 	arch_timers_present |=3D ARCH_CP15_TIMER;
=20
+	/*
+	 * Get the per-processor generic timer info.
+	 */
 	if (gtdt_arch_timer_init(table, arch_timer_ppi, &arch_timer_c3stop,
-				 NULL))
+				 &timer_count))
 		return -EINVAL;
=20
-	/* Get the frequency from CNTFRQ */
+	/*
+	 * Because in a system that implements both Secure and
+	 * Non-secure states, CNTFRQ is only accessible in Secure state.
+	 * So we just try to get the system counter frequency from cntfrq_el0
+	 * (system coprocessor register) here .
+	 */
 	arch_timer_detect_rate(NULL, NULL);
-	arch_timer_init();
=20
+	if (arch_timer_mem_acpi_init(timer_count))
+		pr_err("Failed to initialize memory-mapped timer, skipping\n");
+
+	arch_timer_init();
 	return 0;
 }
 CLOCKSOURCE_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_in=
it);
--=20
2.5.5
