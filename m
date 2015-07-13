From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [RFCv2 PATCH 5/8] arm64: Adding arch-specific acpi_init_irq_alloc_info
Date: Mon, 13 Jul 2015 16:14:21 +0700
Message-ID: <1436778864-17645-6-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tglx@linutronix.de, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, tomasz.nowicki@linaro.org
Cc: rjw@rjwysocki.net, al.stone@linaro.org, catalin.marinas@arm.com, sherry.hurwitz@amd.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, leo.duran@amd.com, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, msalter@redhat.com, grant.likely@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

This patch addes ARM64-specific hook for calling arch-specific
irq_domain_ops.ini_alloc_info() before allocating irqs.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 arch/arm64/kernel/acpi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index d6463bb..f3709dc 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -20,6 +20,7 @@
 #include <linux/cpumask.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/irqdomain.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
@@ -205,3 +206,15 @@ void __init acpi_boot_table_init(void)
 			disable_acpi();
 	}
 }
+
+int acpi_init_irq_alloc_info(struct irq_domain *domain, u32 gsi, unsigned int irq_type,
+			 void **info)
+{
+	int ret;
+	uint32_t data[3] = {GIC_INT_TYPE_GSI, gsi, irq_type};
+
+	if (domain && domain->ops->init_alloc_info)
+		ret = domain->ops->init_alloc_info(data, 3, NULL, info);
+
+	return 0;
+}
-- 
2.1.0
