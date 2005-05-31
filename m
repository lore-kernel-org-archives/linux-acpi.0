From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Fw: [Bugme-new] [Bug 4496] New: Interrupt-problem depends on sound-playing: irq 10: nobody cared!
Date: Tue, 31 May 2005 09:57:28 -0600
Message-ID: <200505310957.28789.bjorn.helgaas@hp.com>
References: <20050525224328.734adc03.akpm@osdl.org> <200505261546.31915.bjorn.helgaas@hp.com> <1117486138.4887.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1117486138.4887.19.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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
To: Hannes Diethelm <hannes-diethelm-goEDY2E6dbVyDzI6CaY1VQ@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 30 May 2005 2:48 pm, Hannes Diethelm wrote:
> Ok, i'm running 2.6.12-rc5-mm1 now. I've tryed your patches but i'm not
> able to aply those patches...

At least one of the patches you tried to apply was already
in 2.6.12-rc5-mm1, so that caused some rejects.

Can you start again with 2.6.12-rc5-mm1, and apply the following
patch?

Thanks for your helpful testing reports.  I really appreciate the
work you're doing.

Bjorn


--- 2.6.12-rc5-mm1/drivers/pci/quirks.c.orig	2005-05-31 09:42:17.000000000 -0600
+++ 2.6.12-rc5-mm1/drivers/pci/quirks.c	2005-05-31 09:44:07.000000000 -0600
@@ -499,28 +499,20 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi );
 
-static void __devinit quirk_via_irqpic(struct pci_dev *dev)
+static void quirk_via_irq(struct pci_dev *dev)
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
