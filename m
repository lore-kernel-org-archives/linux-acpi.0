From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [ACPI] [PATCH] 2 of 6 add acpi_irq_to_vector for x86_64
Date: Tue, 9 Mar 2004 16:25:37 -0700
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <200403091625.37344.bjorn.helgaas@hp.com>
References: <200403091619.04333.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <200403091619.04333.bjorn.helgaas@hp.com>
Content-Disposition: inline
To: acpi-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>, "Nakajima, Jun" <jun.nakajima@intel.com>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

x86_64: Add acpi_irq_to_vector() to follow i386

diff -Nru a/arch/x86_64/kernel/acpi/boot.c b/arch/x86_64/kernel/acpi/boot.c
--- a/arch/x86_64/kernel/acpi/boot.c	Tue Mar  9 13:21:53 2004
+++ b/arch/x86_64/kernel/acpi/boot.c	Tue Mar  9 13:21:53 2004
@@ -323,6 +323,15 @@
 
 #endif /* CONFIG_ACPI_BUS */
 
+#ifdef CONFIG_X86_IO_APIC
+int acpi_irq_to_vector(u32 irq)
+{
+	if (use_pci_vector() && !platform_legacy_irq(irq))
+ 		irq = IO_APIC_VECTOR(irq);
+	return irq;
+}
+#endif
+
 static unsigned long __init
 acpi_scan_rsdp (
 	unsigned long		start,
diff -Nru a/arch/x86_64/kernel/mpparse.c b/arch/x86_64/kernel/mpparse.c
--- a/arch/x86_64/kernel/mpparse.c	Tue Mar  9 13:21:53 2004
+++ b/arch/x86_64/kernel/mpparse.c	Tue Mar  9 13:21:53 2004
@@ -998,17 +998,13 @@
 		if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
 			Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
 				mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
- 			if (use_pci_vector() && !platform_legacy_irq(irq))
- 				irq = IO_APIC_VECTOR(irq);
-			entry->irq = irq;
+			entry->irq = acpi_irq_to_vector(irq);
 			continue;
 		}
 
 		mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
 		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq, edge_level, active_high_low)) {
- 			if (use_pci_vector() && !platform_legacy_irq(irq))
- 				irq = IO_APIC_VECTOR(irq);
-			entry->irq = irq;
+			entry->irq = acpi_irq_to_vector(irq);
 		}
 		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
 			entry->id.segment, entry->id.bus,

