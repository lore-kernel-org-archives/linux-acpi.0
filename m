From: fu.wei@linaro.org
Subject: [PATCH v20 14/17] clocksource/drivers/arm_arch_timer: Simplify ACPI
 support code.
Date: Wed, 18 Jan 2017 21:25:38 +0800
Message-ID: <20170118132541.8989-15-fu.wei@linaro.org>
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

The patch update arm_arch_timer driver to use the function
provided by the new GTDT driver of ACPI.
By this way, arm_arch_timer.c can be simplified, and separate
all the ACPI GTDT knowledge from this timer driver.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/clocksource/arm_arch_timer.c | 46 ++++++++++--------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 6e8a20c..79dc004 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1076,59 +1076,36 @@ static int __init arch_timer_mem_of_init(struct device_node *np)
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
 		       arch_timer_mem_of_init);
 
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
 	int ret;
-	struct acpi_table_gtdt *gtdt;
 
 	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
 		pr_warn("already initialized, skipping\n");
 		return -EINVAL;
 	}
 
-	gtdt = container_of(table, struct acpi_table_gtdt, header);
-
 	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
 
-	arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI] =
-		map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
-		gtdt->secure_el1_flags);
+	ret = acpi_gtdt_init(table, NULL);
+	if (ret) {
+		pr_err("Failed to init GTDT table.\n");
+		return ret;
+	}
 
 	arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI] =
-		map_generic_timer_interrupt(gtdt->non_secure_el1_interrupt,
-		gtdt->non_secure_el1_flags);
+		acpi_gtdt_map_ppi(ARCH_TIMER_PHYS_NONSECURE_PPI);
 
 	arch_timer_ppi[ARCH_TIMER_VIRT_PPI] =
-		map_generic_timer_interrupt(gtdt->virtual_timer_interrupt,
-		gtdt->virtual_timer_flags);
+		acpi_gtdt_map_ppi(ARCH_TIMER_VIRT_PPI);
 
 	arch_timer_ppi[ARCH_TIMER_HYP_PPI] =
-		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
-		gtdt->non_secure_el2_flags);
+		acpi_gtdt_map_ppi(ARCH_TIMER_HYP_PPI);
 
 	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
 
-	/* Get the frequency from the sysreg CNTFRQ */
-	arch_timer_detect_rate();
-
 	arch_timer_uses_ppi = arch_timer_select_ppi();
 	if (!arch_timer_ppi[arch_timer_uses_ppi]) {
 		pr_err("No interrupt available, giving up\n");
@@ -1136,7 +1113,10 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	}
 
 	/* Always-on capability */
-	arch_timer_c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
+	arch_timer_c3stop = acpi_gtdt_c3stop(arch_timer_uses_ppi);
+
+	/* Get the frequency from the sysreg CNTFRQ */
+	arch_timer_detect_rate();
 
 	ret = arch_timer_register();
 	if (ret)
-- 
2.9.3
