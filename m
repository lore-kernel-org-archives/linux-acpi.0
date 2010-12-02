From: Stefan Assmann <sassmann@redhat.com>
Subject: [PATCH 5/5 v2] PCI, ACPI: re-add boot interrupt reroute code in separate files
Date: Thu, 2 Dec 2010 10:34:04 -0500
Message-ID: <20101202153430.29125.73405.sendpatchset@localhost6.localdomain6>
References: <20101202153344.29125.86670.sendpatchset@localhost6.localdomain6>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20101202153344.29125.86670.sendpatchset@localhost6.localdomain6>
Sender: linux-pci-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, linux-pci@vger.kernel.org, JBeulich@novell.com, jbarnes@virtuousgeek.org, Stefan Assmann <sassmann@redhat.com>, mingo@elte.hu, bjorn.helgaas@hp.com, tglx@linutronix.de, Olaf.Dabrunz@gmx.net
List-Id: linux-acpi@vger.kernel.org

From: Stefan Assmann <sassmann@redhat.com>

During the 2.6.29 merge major parts of e1d3a90846b40ad3160bf4b648d36c6badad39ac
got lost because of other ACPI changes. As suggested by Ingo Molnar the missing
boot interrupt reroute parts are re-added in separate files. The code has
been updated to be less ifdeffy and play along with the current ACPI code. The
printks have been converted to dev_info(). Also the implementation of
bridge_has_boot_interrupt_variant() has been dropped in favor to the existing
pci_find_upstream_pcie_bridge().

By request of Bjorn Helgaas I've created a bugzilla entry at
https://bugzilla.kernel.org/show_bug.cgi?id=21882
to gather information about the boot interrupt reroute problem.

Signed-off-by: Stefan Assmann <sassmann@redhat.com>
---
 arch/x86/include/asm/boot_irq.h |   28 +++++++++++++++++
 arch/x86/kernel/apic/Makefile   |    3 ++
 arch/x86/kernel/apic/boot_irq.c |   63 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/pci_irq.c          |    4 ++
 4 files changed, 98 insertions(+), 0 deletions(-)
 create mode 100644 arch/x86/include/asm/boot_irq.h
 create mode 100644 arch/x86/kernel/apic/boot_irq.c

diff --git a/arch/x86/include/asm/boot_irq.h b/arch/x86/include/asm/boot_irq.h
new file mode 100644
index 0000000..0cc35e1
--- /dev/null
+++ b/arch/x86/include/asm/boot_irq.h
@@ -0,0 +1,28 @@
+#ifndef _ASM_X86_BOOT_IRQ_H
+#define _ASM_X86_BOOT_IRQ_H
+
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Workaround for boot interrupts that cannot be disabled in hardware: makes
+ * affected devices always use the boot interrupt, the original interrupt line
+ * for the device remains disabled.
+ */
+
+#include <linux/pci.h>
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#endif /* CONFIG_ACPI */
+
+#ifdef CONFIG_X86_IO_APIC
+#ifdef CONFIG_ACPI
+extern struct acpi_prt_entry *boot_irq_reroute (struct pci_dev *dev, struct acpi_prt_entry *entry);
+#endif /* CONFIG_ACPI */
+#else
+static inline struct acpi_prt_entry *boot_irq_reroute (struct pci_dev *dev, struct acpi_prt_entry *entry)
+	{ return entry; }
+#endif /* CONFIG_X86_IO_APIC */
+
+#endif /* _ASM_X86_BOOT_IRQ_H */
diff --git a/arch/x86/kernel/apic/Makefile b/arch/x86/kernel/apic/Makefile
index 910f20b..4603b66 100644
--- a/arch/x86/kernel/apic/Makefile
+++ b/arch/x86/kernel/apic/Makefile
@@ -9,6 +9,9 @@ endif
 obj-$(CONFIG_HARDLOCKUP_DETECTOR)	+= hw_nmi.o
 
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
+ifeq ($(CONFIG_ACPI),y)
+obj-$(CONFIG_X86_IO_APIC)	+= boot_irq.o
+endif
 obj-$(CONFIG_SMP)		+= ipi.o
 
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/apic/boot_irq.c b/arch/x86/kernel/apic/boot_irq.c
new file mode 100644
index 0000000..297d590
--- /dev/null
+++ b/arch/x86/kernel/apic/boot_irq.c
@@ -0,0 +1,63 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Workaround for boot interrupts that cannot be disabled in hardware: makes
+ * affected devices always use the boot interrupt, the original interrupt line
+ * for the device remains disabled.
+ */
+
+#include <linux/types.h>
+#include <asm/boot_irq.h>
+
+/*
+ * On it's way to the CPU a PCI IRQ might pass multiple PCI bridges therefore
+ * we need to inspect all of them.
+ */
+static int boot_irq_check_broken_bridge(struct pci_dev *pdev)
+{
+	struct pci_dev *tmp_pdev;
+
+	tmp_pdev = pci_find_upstream_pcie_bridge(pdev);
+
+	if (tmp_pdev)
+		return tmp_pdev->irq_reroute_variant;
+	else
+		return 0;
+}
+
+/*
+ * Some chipsets (e.g. intel 6700PXH) generate a legacy INTx when the IRQ entry
+ * in the chipset's IO-APIC is masked (as, e.g. the RT kernel does during
+ * interrupt handling). When this INTx generation cannot be disabled, we
+ * reroute these interrupts to their legacy equivalent to get rid of spurious
+ * interrupts.
+ */
+struct acpi_prt_entry *boot_irq_reroute(struct pci_dev *dev, struct acpi_prt_entry *entry)
+{
+	u32 orig_index;
+
+	switch (boot_irq_check_broken_bridge(dev)) {
+	case 0:
+		break; /* no rerouting necessary */
+
+	case INTEL_IRQ_REROUTE_VARIANT:
+		/*
+		 * Remap according to INTx routing table in 6700PXH specs,
+		 * intel order number 302628-002, section 2.15.2. Other
+		 * chipsets (80332, ...) have the same mapping and are handled
+		 * here as well.
+		 */
+		orig_index = entry->index;
+		entry->index = (entry->index % 4) + 16;
+		dev_info(&dev->dev, "PCI IRQ %d -> rerouted to legacy boot IRQ %d\n", orig_index, entry->index);
+		break;
+
+	default:
+		dev_info(&dev->dev, "Not rerouting PCI IRQ %d: unknown mapping\n", entry->index);
+		break;
+	}
+
+	return entry;
+}
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index e1632b2..83eb5f6 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -39,6 +39,7 @@
 #include <linux/slab.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <asm/boot_irq.h>
 
 #define PREFIX "ACPI: "
 
@@ -309,6 +310,9 @@ static struct acpi_prt_entry *acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
 	if (entry) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %s[%c] _PRT entry\n",
 				  pci_name(dev), pin_name(pin)));
+		if (!noioapicquirk)
+			entry = boot_irq_reroute(dev, entry);
+
 		return entry;
 	}
 
-- 
1.7.3.2
