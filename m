From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 2/5] irqchip/acpi: Add probing infrastructure for ACPI-based
 irqchips
Date: Fri,  4 Sep 2015 18:06:49 +0100
Message-ID: <1441386412-8139-3-git-send-email-marc.zyngier@arm.com>
References: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

DT enjoys a rather nice probing infrastructure for irqchips, while
ACPI is so far stuck into a very distant past.

This patch introduces a declarative API, allowing irqchips to be
self-contained and be called when a particular entry is matched
in the MADT table.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/irq.h | 11 -----------
 drivers/irqchip/irqchip.c    |  8 +++++---
 include/linux/acpi_irq.h     | 10 ----------
 include/linux/irqchip.h      | 16 ++++++++++++++++
 4 files changed, 21 insertions(+), 24 deletions(-)
 delete mode 100644 include/linux/acpi_irq.h

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index bbb251b..1a1037a 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -10,15 +10,4 @@ struct pt_regs;
 extern void migrate_irqs(void);
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
-static inline void acpi_irq_init(void)
-{
-	/*
-	 * Hardcode ACPI IRQ chip initialization to GICv2 for now.
-	 * Proper irqchip infrastructure will be implemented along with
-	 * incoming  GICv2m|GICv3|ITS bits.
-	 */
-	acpi_gic_init();
-}
-#define acpi_irq_init acpi_irq_init
-
 #endif
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index afd1af3..0644d17 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -8,7 +8,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/acpi_irq.h>
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/of_irq.h>
 #include <linux/irqchip.h>
@@ -27,6 +27,8 @@ extern struct of_device_id __irqchip_of_table[];
 void __init irqchip_init(void)
 {
 	of_irq_init(__irqchip_of_table);
-
-	acpi_irq_init();
+#if defined(CONFIG_ARM64) && defined(CONFIG_ACPI)
+	acpi_gic_init();	/* Temporary hack */
+#endif
+	acpi_probe_device_table(ACPI_SIG_MADT);
 }
diff --git a/include/linux/acpi_irq.h b/include/linux/acpi_irq.h
deleted file mode 100644
index f10c872..0000000
--- a/include/linux/acpi_irq.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef _LINUX_ACPI_IRQ_H
-#define _LINUX_ACPI_IRQ_H
-
-#include <linux/irq.h>
-
-#ifndef acpi_irq_init
-static inline void acpi_irq_init(void) { }
-#endif
-
-#endif /* _LINUX_ACPI_IRQ_H */
diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 6388873..1df3123 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -11,6 +11,7 @@
 #ifndef _LINUX_IRQCHIP_H
 #define _LINUX_IRQCHIP_H
 
+#include <linux/acpi.h>
 #include <linux/of.h>
 
 /*
@@ -25,6 +26,21 @@
  */
 #define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name, compat, fn)
 
+/*
+ * This macro must be used by the different irqchip drivers to declare
+ * the association between their version and their initialization function.
+ *
+ * @name: name that must be unique accross all IRQCHIP_ACPI_DECLARE of the
+ * same file.
+ * @subtable: Subtable to be identified in MADT
+ * @validate: Function to be called on that subtable to check its validity.
+ *            Can be NULL.
+ * @data: data to be checked by the validate function.
+ * @fn: initialization function
+ */
+#define IRQCHIP_ACPI_DECLARE(name, subtable, validate, data, fn)	\
+	ACPI_DECLARE(device, name, ACPI_SIG_MADT, subtable, validate, data, fn)
+
 #ifdef CONFIG_IRQCHIP
 void irqchip_init(void);
 #else
-- 
2.1.4
