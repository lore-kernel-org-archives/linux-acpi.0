From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 03/11] arm64: pmu: Hoist pmu platform device name
Date: Tue, 21 Jun 2016 12:11:41 -0500
Message-ID: <1466529109-21715-4-git-send-email-jeremy.linton@arm.com>
References: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, Lorenzo.Pieralisi@arm.com, mlangsdorf@redhat.com, alexander.shishkin@linux.intel.com, catalin.marinas@arm.com, punit.agrawal@arm.com, will.deacon@arm.com, acme@kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, Steve.Capper@arm.com
List-Id: linux-acpi@vger.kernel.org

Move the PMU name into a common header file so it may
be referenced by other users.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/perf_event.c | 2 +-
 include/linux/perf/arm_pmu.h   | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index f650548..356fa6c 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1099,7 +1099,7 @@ static int armv8_pmu_device_probe(struct platform_device *pdev)
 
 static struct platform_driver armv8_pmu_driver = {
 	.driver		= {
-		.name	= "armv8-pmu",
+		.name	= ARMV8_PMU_PDEV_NAME,
 		.of_match_table = armv8_pmu_of_device_ids,
 	},
 	.probe		= armv8_pmu_device_probe,
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 7e814fe..0ef963b 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -154,6 +154,8 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 			 const struct of_device_id *of_table,
 			 const struct pmu_probe_info *probe_table);
 
+#define ARMV8_PMU_PDEV_NAME "armv8-pmu"
+
 #endif /* CONFIG_ARM_PMU */
 
 #endif /* __ARM_PMU_H__ */
-- 
2.5.5
