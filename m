From: fu.wei@linaro.org
Subject: [PATCH v6 02/10] clocksource/drivers/arm_arch_timer: Add a new enum
 for spi type
Date: Thu, 30 Jun 2016 02:15:45 +0800
Message-ID: <1467224153-22873-3-git-send-email-fu.wei@linaro.org>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, marc.zyngier@arm.com, hanjun.guo@linaro.org
Cc: wei@redhat.com, harba@codeaurora.org, Fu Wei <fu.wei@linaro.org>, al.stone@linaro.org, graeme.gregory@linaro.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, timur@codeaurora.org, will.deacon@arm.com, rruigrok@codeaurora.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, wim@iguana.be, arnd@arndb.de, cov@codeaurora.org, Suravee.Suthikulpanit@amd.com, catalin.marinas@arm.com, leo.duran@amd.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This patch add a new enum "spi_nr" and use it in the driver.
Just for code's readability, no functional change.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 4 ++--
 include/clocksource/arm_arch_timer.h | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5d7272e..966c574 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -826,9 +826,9 @@ static void __init arch_timer_mem_init(struct device_node *np)
 	}
 
 	if (arch_timer_mem_use_virtual)
-		irq = irq_of_parse_and_map(best_frame, 1);
+		irq = irq_of_parse_and_map(best_frame, VIRT_SPI);
 	else
-		irq = irq_of_parse_and_map(best_frame, 0);
+		irq = irq_of_parse_and_map(best_frame, PHYS_SPI);
 
 	if (!irq) {
 		pr_err("arch_timer: Frame missing %s irq",
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 6f06481..16dcd10 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -45,6 +45,12 @@ enum ppi_nr {
 	MAX_TIMER_PPI
 };
 
+enum spi_nr {
+	PHYS_SPI,
+	VIRT_SPI,
+	MAX_TIMER_SPI
+};
+
 #define ARCH_TIMER_PHYS_ACCESS		0
 #define ARCH_TIMER_VIRT_ACCESS		1
 #define ARCH_TIMER_MEM_PHYS_ACCESS	2
-- 
2.5.5
