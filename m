From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Fw: 2.6.11.4: ACPI, IRQ 11 disabled, Ethernet/USB stops
	working
Date: Thu, 24 Mar 2005 11:41:30 -0700
Message-ID: <1111689690.24547.31.camel@eeyore>
References: <20050323023629.5723f9bc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050323023629.5723f9bc.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel-UNdit3cmHfQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> I have a brand new Toshiba M45 S331 notebook and am experiencing (like 
> some other guys who are trying to get Linux (with kernel 2.6.11.4) 
> running on this machine) some problems...
> 
> Here the probably kernel related part:
> 
> Symptoms:
> First, if I boot with the option "acpi=off" USB/Ethernet is fine - 
> except that I am missing ACPI functionality ;-(
> 
> If I activate ACPI I get the following message during boot:
> # Mar 17 07:42:57 linux kernel: irq 11: nobody cared!
> # Mar 17 07:42:57 linux kernel:  [<c010868c>] __report_bad_irq+0x1c/0x70
> # Mar 17 07:42:57 linux kernel:  [<c010875b>] note_interrupt+0x5b/0x80
> # <zip> whole boot.msg attached at the end...
> # Mar 17 07:42:57 linux kernel: Disabling IRQ #11

Can you try the attached patch, please?


In PIC mode, some Via devices update IRQ routing when
PCI_INTERRUPT_LINE is written.  So if we've updated the
device's IRQ, we also need to update PCI_INTERRUPT_LINE.

This also restores the mysterious "udelay(15)" before the
update because we don't know whether it's necessary and
haven't seen an argument for its removal.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

===== arch/i386/pci/irq.c 1.55 vs edited =====
--- 1.55/arch/i386/pci/irq.c	2005-02-07 22:39:15 -07:00
+++ edited/arch/i386/pci/irq.c	2005-03-15 10:11:44 -07:00
@@ -1026,7 +1026,6 @@
 static int pirq_enable_irq(struct pci_dev *dev)
 {
 	u8 pin;
-	extern int via_interrupt_line_quirk;
 	struct pci_dev *temp_dev;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
@@ -1081,10 +1080,6 @@
 		printk(KERN_WARNING "PCI: No IRQ known for interrupt pin %c of device %s.%s\n",
 		       'A' + pin, pci_name(dev), msg);
 	}
-	/* VIA bridges use interrupt line for apic/pci steering across
-	   the V-Link */
-	else if (via_interrupt_line_quirk)
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq & 15);
 	return 0;
 }
 
===== drivers/acpi/pci_irq.c 1.37 vs edited =====
--- 1.37/drivers/acpi/pci_irq.c	2005-03-01 09:57:29 -07:00
+++ edited/drivers/acpi/pci_irq.c	2005-03-15 10:10:57 -07:00
@@ -388,7 +388,6 @@
 	u8			pin = 0;
 	int			edge_level = ACPI_LEVEL_SENSITIVE;
 	int			active_high_low = ACPI_ACTIVE_LOW;
-	extern int		via_interrupt_line_quirk;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_enable");
 
@@ -437,9 +436,6 @@
 			return_VALUE(0);
 		}
  	}
-
-	if (via_interrupt_line_quirk)
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq & 15);
 
 	dev->irq = acpi_register_gsi(irq, edge_level, active_high_low);
 
===== drivers/pci/quirks.c 1.72 vs edited =====
--- 1.72/drivers/pci/quirks.c	2005-03-10 01:38:25 -07:00
+++ edited/drivers/pci/quirks.c	2005-03-24 11:07:19 -07:00
@@ -683,19 +683,41 @@
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb );
 
-/*
- *	VIA northbridges care about PCI_INTERRUPT_LINE
- */
-int via_interrupt_line_quirk;
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#endif
 
-static void __devinit quirk_via_bridge(struct pci_dev *pdev)
+static void __devinit quirk_via_irqpic(struct pci_dev *dev)
 {
-	if(pdev->devfn == 0) {
-		printk(KERN_INFO "PCI: Via IRQ fixup\n");
-		via_interrupt_line_quirk = 1;
+	u8 irq, new_irq;
+
+#ifdef CONFIG_X86_IO_APIC
+	if (nr_ioapics && !skip_ioapic_setup)
+		return;
+#endif
+#ifdef CONFIG_ACPI
+	if (acpi_irq_model != ACPI_IRQ_MODEL_PIC)
+		return;
+#endif
+	/*
+	 * Some Via devices make an internal connection to the PIC when the
+	 * PCI_INTERRUPT_LINE register is written.  If we've changed the
+	 * device's IRQ, we need to update this routing.
+	 *
+	 * I suspect this only happens for devices on the same chip as the
+	 * PIC, but I don't know how to identify those without listing them
+	 * all individually, which is a maintenance problem.
+	 */
+	new_irq = dev->irq & 0xf;
+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
+	if (new_irq != irq) {
+		printk(KERN_INFO "PCI: Via PIC IRQ fixup for %s, from %d to %d\n",
+			pci_name(dev), irq, new_irq);
+		udelay(15);
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_ANY_ID,                     quirk_via_bridge );
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irqpic);
 
 /*
  *	Serverworks CSB5 IDE does not fully support native mode




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
