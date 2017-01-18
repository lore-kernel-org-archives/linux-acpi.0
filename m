From: fu.wei@linaro.org
Subject: [PATCH v20 09/17] clocksource/drivers/arm_arch_timer: Refactor
 arch_timer_needs_probing
Date: Wed, 18 Jan 2017 21:25:33 +0800
Message-ID: <20170118132541.8989-10-fu.wei@linaro.org>
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

When system init with device-tree, we don't know which node will be
initialized first. And the code in arch_timer_common_init should wait
until per-cpu timer and MMIO timer are both initialized. So we need
arch_timer_needs_probing to detect the init status of system.

But currently the code is dispersed in arch_timer_needs_probing and
arch_timer_common_init. And the function name doesn't specify that
it's only for device-tree. This is somewhat confusing.

This patch move all related code from arch_timer_common_init to
arch_timer_needs_probing, refactor it, and rename it to
arch_timer_needs_of_probing. And make sure that it will be called
only if acpi is disabled.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9482481..d10c2f7 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -796,15 +796,28 @@ static const struct of_device_id arch_timer_mem_of_match[] __initconst = {
 	{},
 };
 
-static bool __init
-arch_timer_needs_probing(int type, const struct of_device_id *matches)
+static bool __init arch_timer_needs_of_probing(void)
 {
 	struct device_node *dn;
 	bool needs_probing = false;
+	unsigned int mask = ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
 
-	dn = of_find_matching_node(NULL, matches);
-	if (dn && of_device_is_available(dn) && !(arch_timers_present & type))
+	/* We have two timers, and both device-tree nodes are probed. */
+	if ((arch_timers_present & mask) == mask)
+		return false;
+
+	/*
+	 * Only one type of timer is probed,
+	 * check if we have another type of timer node in device-tree.
+	 */
+	if (arch_timers_present & ARCH_TIMER_TYPE_CP15)
+		dn = of_find_matching_node(NULL, arch_timer_mem_of_match);
+	else
+		dn = of_find_matching_node(NULL, arch_timer_of_match);
+
+	if (dn && of_device_is_available(dn))
 		needs_probing = true;
+
 	of_node_put(dn);
 
 	return needs_probing;
@@ -812,17 +825,8 @@ arch_timer_needs_probing(int type, const struct of_device_id *matches)
 
 static int __init arch_timer_common_init(void)
 {
-	unsigned mask = ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
-
-	/* Wait until both nodes are probed if we have two timers */
-	if ((arch_timers_present & mask) != mask) {
-		if (arch_timer_needs_probing(ARCH_TIMER_TYPE_MEM,
-					     arch_timer_mem_of_match))
-			return 0;
-		if (arch_timer_needs_probing(ARCH_TIMER_TYPE_CP15,
-					     arch_timer_of_match))
-			return 0;
-	}
+	if (acpi_disabled && arch_timer_needs_of_probing())
+		return 0;
 
 	arch_timer_banner(arch_timers_present);
 	arch_counter_register(arch_timers_present);
-- 
2.9.3
