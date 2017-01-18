From: fu.wei@linaro.org
Subject: [PATCH v20 06/17] clocksource/drivers/arm_arch_timer: rework PPI
 determination
Date: Wed, 18 Jan 2017 21:25:30 +0800
Message-ID: <20170118132541.8989-7-fu.wei@linaro.org>
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

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/clocksource/arm_arch_timer.c | 77 +++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index ca73513..674d89f 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -702,7 +702,7 @@ static int __init arch_timer_register(void)
 	case ARCH_TIMER_PHYS_NONSECURE_PPI:
 		err = request_percpu_irq(ppi, arch_timer_handler_phys,
 					 "arch_timer", arch_timer_evt);
-		if (!err && arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]) {
+		if (!err && arch_timer_has_nonsecure_ppi()) {
 			ppi = arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI];
 			err = request_percpu_irq(ppi, arch_timer_handler_phys,
 						 "arch_timer", arch_timer_evt);
@@ -824,39 +824,41 @@ static int __init arch_timer_common_init(void)
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
+	if (is_kernel_in_hyp_mode())
+		return ARCH_TIMER_HYP_PPI;
 
-		if (is_kernel_in_hyp_mode()) {
-			arch_timer_uses_ppi = ARCH_TIMER_HYP_PPI;
-			has_ppi = !!arch_timer_ppi[ARCH_TIMER_HYP_PPI];
-		} else {
-			arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
-			has_ppi = (!!arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI] ||
-				   !!arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
-		}
+	if (!is_hyp_mode_available() && arch_timer_ppi[ARCH_TIMER_VIRT_PPI])
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
@@ -904,6 +906,13 @@ static int __init arch_timer_of_init(struct device_node *np)
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
 
 	/* On some systems, the counter stops ticking when in suspend. */
 	arch_counter_suspend_stop = of_property_read_bool(np,
@@ -1049,6 +1058,12 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
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
