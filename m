From: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
Subject: [PATCH v5] x86/PCI: Recognize that Interrupt Line 255 means "not connected"
Date: Mon, 15 Feb 2016 11:25:32 +0800
Message-ID: <1455506732-26043-1-git-send-email-chen.fan.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:15324 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751676AbcBODax (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Feb 2016 22:30:53 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com, rafael@kernel.org

Per the x86-specific footnote to PCI spec r3.0, sec 6.2.4, the value 255 in
the Interrupt Line register means "unknown" or "no connection."
Previously, when we couldn't derive an IRQ from the _PRT, we fell back to
using the value from Interrupt Line as an IRQ.  It's questionable whether
we should do that at all, but the spec clearly suggests we shouldn't do it
for the value 255 on x86.

Calling request_irq() with IRQ 255 may succeed, but the driver won't
receive any interrupts.  Or, if IRQ 255 is shared with another device, it
may succeed, and the driver's ISR will be called at random times when the
*other* device interrupts.  Or it may fail if another device is using IRQ
255 with incompatible flags.  What we *want* is for request_irq() to fail
predictably so the driver can fall back to polling.

On x86, assume 255 in the Interrupt Line means the INTx line is not
connected.  In that case, set dev->irq to IRQ_NOTCONNECTED so request_irq()
will fail gracefully with -ENOTCONN.

We found this problem on a system where Secure Boot firmware assigned
Interrupt Line 255 to an i801_smbus device and another device was already
using MSI-X IRQ 255.  This was in v3.10, where i801_probe() fails if
request_irq() fails:

  i801_smbus 0000:00:1f.3: enabling device (0140 -> 0143)
  i801_smbus 0000:00:1f.3: can't derive routing for PCI INT C
  i801_smbus 0000:00:1f.3: PCI INT C: no GSI
  genirq: Flags mismatch irq 255. 00000080 (i801_smbus) vs. 00000000 (megasa)
  CPU: 0 PID: 2487 Comm: kworker/0:1 Not tainted 3.10.0-229.el7.x86_64 #1
  Hardware name: FUJITSU PRIMEQUEST 2800E2/D3736, BIOS PRIMEQUEST 2000 Serie5
  Call Trace:
    dump_stack+0x19/0x1b
    __setup_irq+0x54a/0x570
    request_threaded_irq+0xcc/0x170
    i801_probe+0x32f/0x508 [i2c_i801]
    local_pci_probe+0x45/0xa0
  i801_smbus 0000:00:1f.3: Failed to allocate irq 255: -16
  i801_smbus: probe of 0000:00:1f.3 failed with error -16

After aeb8a3d16ae0 ("i2c: i801: Check if interrupts are disabled"),
i801_probe() will fall back to polling if request_irq() fails.  But we
still need this patch because request_irq() may succeed or fail depending
on other devices in the system.  If request_irq() fails, i801_smbus will
work by falling back to polling, but if it succeeds, i801_smbus won't work
because it expects interrupts that it may not receive.

Signed-off-by: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_irq.c    | 29 +++++++++++++++++++++++++----
 include/linux/interrupt.h | 10 ++++++++++
 kernel/irq/manage.c       |  9 ++++++++-
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index d30184c..0227cc6 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -33,6 +33,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 
 #define PREFIX "ACPI: "
 
@@ -387,6 +388,23 @@ static inline int acpi_isa_register_gsi(struct pci_dev *dev)
 }
 #endif
 
+static inline bool acpi_pci_irq_valid(struct pci_dev *dev)
+{
+#ifdef CONFIG_X86
+	/*
+	 * On x86 irq line 0xff means "unknown" or "no connection"
+	 * (PCI 3.0, Section 6.2.4, footnote on page 223).
+	 */
+	if (dev->irq == 0xff) {
+		dev->irq = IRQ_NOTCONNECTED;
+		dev_warn(&dev->dev, "PCI INT %c: not connected\n",
+			 pin_name(pin));
+		return false;
+	}
+#endif
+	return true;
+}
+
 int acpi_pci_irq_enable(struct pci_dev *dev)
 {
 	struct acpi_prt_entry *entry;
@@ -431,11 +449,14 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	} else
 		gsi = -1;
 
-	/*
-	 * No IRQ known to the ACPI subsystem - maybe the BIOS / 
-	 * driver reported one, then use it. Exit in any case.
-	 */
 	if (gsi < 0) {
+		/*
+		 * No IRQ known to the ACPI subsystem - maybe the BIOS /
+		 * driver reported one, then use it. Exit in any case.
+		 */
+		if (!acpi_pci_irq_valid(dev, pin))
+			return 0;
+
 		if (acpi_isa_register_gsi(dev))
 			dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
 				 pin_name(pin));
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index cb30edb..12f7da4 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -125,6 +125,16 @@ struct irqaction {
 
 extern irqreturn_t no_action(int cpl, void *dev_id);
 
+/*
+ * If a (PCI) device interrupt is not connected we set dev->irq to
+ * IRQ_NOTCONNECTED. This causes request_irq() to fail with -ENOTCONN, so we
+ * can distingiush that case from other error returns.
+ *
+ * 0x80000000 is guaranteed to be outside the available range of interrupts
+ * and easy to distinguish from other possible incorrect values.
+ */
+#define IRQ_NOTCONNECTED	(1U << 31)
+
 extern int __must_check
 request_threaded_irq(unsigned int irq, irq_handler_t handler,
 		     irq_handler_t thread_fn,
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 8411872..e79e60f 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1609,6 +1609,9 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 	struct irq_desc *desc;
 	int retval;
 
+	if (irq == IRQ_NOTCONNECTED)
+		return -ENOTCONN;
+
 	/*
 	 * Sanity-check: shared interrupts must pass in a real dev-ID,
 	 * otherwise we'll have trouble later trying to figure out
@@ -1699,9 +1702,13 @@ EXPORT_SYMBOL(request_threaded_irq);
 int request_any_context_irq(unsigned int irq, irq_handler_t handler,
 			    unsigned long flags, const char *name, void *dev_id)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_desc *desc;
 	int ret;
 
+	if (irq == IRQ_NOTCONNECTED)
+		return -ENOTCONN;
+
+	desc = irq_to_desc(irq);
 	if (!desc)
 		return -EINVAL;
 
-- 
1.9.3



