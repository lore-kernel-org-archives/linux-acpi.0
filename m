From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [ACPI] [PATCH] 1 of 6 sync mpparse
Date: Tue, 9 Mar 2004 16:24:50 -0700
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <200403091624.50746.bjorn.helgaas@hp.com>
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

i386, x86_64: sync mpparse.c slightly

This cleans up a little whitespace and a couple typos to remove
needless differences between mpparse.c for i386 and x86_64.

diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Tue Mar  9 13:13:20 2004
+++ b/arch/i386/kernel/mpparse.c	Tue Mar  9 13:13:20 2004
@@ -1,5 +1,5 @@
 /*
- *	Intel Multiprocessor Specificiation 1.1 and 1.4
+ *	Intel Multiprocessor Specification 1.1 and 1.4
  *	compliant MP-table parsing routines.
  *
  *	(c) 1995 Alan Cox, Building #3 <alan@redhat.com>
@@ -1158,19 +1158,19 @@
 		if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
 			Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
 				mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
- 			entry->irq = acpi_irq_to_vector(irq);
+			entry->irq = acpi_irq_to_vector(irq);
 			continue;
 		}
 
 		mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
 
 		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq, edge_level, active_high_low)) {
- 			entry->irq = acpi_irq_to_vector(irq);
- 		}
+			entry->irq = acpi_irq_to_vector(irq);
+		}
 		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
-			entry->id.segment, entry->id.bus, 
-			entry->id.device, ('A' + entry->pin), 
-			mp_ioapic_routing[ioapic].apic_id, ioapic_pin, 
+			entry->id.segment, entry->id.bus,
+			entry->id.device, ('A' + entry->pin),
+			mp_ioapic_routing[ioapic].apic_id, ioapic_pin,
 			entry->irq);
 	}
 
diff -Nru a/arch/x86_64/kernel/mpparse.c b/arch/x86_64/kernel/mpparse.c
--- a/arch/x86_64/kernel/mpparse.c	Tue Mar  9 13:13:20 2004
+++ b/arch/x86_64/kernel/mpparse.c	Tue Mar  9 13:13:20 2004
@@ -9,7 +9,7 @@
  *		Erich Boleyn	:	MP v1.4 and additional changes.
  *		Alan Cox	:	Added EBDA scanning
  *		Ingo Molnar	:	various cleanups and rewrites
- *	Maciej W. Rozycki	:	Bits for default MP configurations
+ *		Maciej W. Rozycki:	Bits for default MP configurations
  *		Paul Diefenbaugh:	Added full ACPI support
  */
 
@@ -1009,14 +1009,14 @@
  			if (use_pci_vector() && !platform_legacy_irq(irq))
  				irq = IO_APIC_VECTOR(irq);
 			entry->irq = irq;
- 		}
-		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d"
-			" -> IRQ %d\n", entry->id.segment, entry->id.bus, 
-			entry->id.device, ('A' + entry->pin), 
+		}
+		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
+			entry->id.segment, entry->id.bus,
+			entry->id.device, ('A' + entry->pin),
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin,
 			entry->irq);
 	}
-	
+
 	print_IO_APIC();
 
 	return;

