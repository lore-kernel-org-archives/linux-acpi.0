From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Fw: [Bugme-new] [Bug 4496] New: Interrupt-problem depends on sound-playing: irq 10: nobody cared!
Date: Thu, 26 May 2005 10:07:40 -0600
Message-ID: <200505261007.40992.bjorn.helgaas@hp.com>
References: <20050525224328.734adc03.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050525224328.734adc03.akpm-3NddpPZAyC0@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, hannes-diethelm-goEDY2E6dbVyDzI6CaY1VQ@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 25 May 2005 11:43 pm, Andrew Morton wrote:
> This IRQ routing bug appears to be an ACPI thing.  Could someone
> please reassign it?
> ...
> Subject: [Bugme-new] [Bug 4496] New: Interrupt-problem depends on sound-playing: irq 10: nobody cared!
> http://bugme.osdl.org/show_bug.cgi?id=4496

The box has several VIA devices.  Can you please try 2.6.12-rc5-mm1?

If you're using PIC mode (not IOAPIC), you may also need the following
patch:

--- 2.6.12-rc3-mm3/drivers/pci/quirks.c.orig	2005-05-05 10:52:42.000000000 -0600
+++ 2.6.12-rc3-mm3/drivers/pci/quirks.c	2005-05-10 09:56:18.000000000 -0600
@@ -460,17 +460,6 @@
 
 
 /*
- * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
- * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
- * when written, it makes an internal connection to the PIC.
- * For these devices, this register is defined to be 4 bits wide.
- * Normally this is fine.  However for IO-APIC motherboards, or
- * non-x86 architectures (yes Via exists on PPC among other places),
- * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
- * interrupts delivered properly.
- */
-
-/*
  * FIXME: it is questionable that quirk_via_acpi
  * is needed.  It shows up as an ISA bridge, and does not
  * support the PCI_INTERRUPT_LINE register at all.  Therefore
@@ -492,28 +481,30 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi );
 
-static void __devinit quirk_via_irqpic(struct pci_dev *dev)
+/*
+ * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
+ * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
+ * when written, it makes an internal connection to the PIC.
+ * For these devices, this register is defined to be 4 bits wide.
+ * Normally this is fine.  However for IO-APIC motherboards, or
+ * non-x86 architectures (yes Via exists on PPC among other places),
+ * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
+ * interrupts delivered properly.
+ */
+static void __devinit quirk_via_irq(struct pci_dev *dev)
 {
 	u8 irq, new_irq;
 
-#ifdef CONFIG_X86_IO_APIC
-	if (nr_ioapics && !skip_ioapic_setup)
-		return;
-#endif
-#ifdef CONFIG_ACPI
-	if (acpi_irq_model != ACPI_IRQ_MODEL_PIC)
-		return;
-#endif
 	new_irq = dev->irq & 0xf;
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	if (new_irq != irq) {
-		printk(KERN_INFO "PCI: Via PIC IRQ fixup for %s, from %d to %d\n",
+		printk(KERN_INFO "PCI: Via IRQ fixup for %s, from %d to %d\n",
 			pci_name(dev), irq, new_irq);
 		udelay(15);	/* unknown if delay really needed */
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irqpic);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
 
 /*
  * PIIX3 USB: We have to disable USB interrupts that are



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
