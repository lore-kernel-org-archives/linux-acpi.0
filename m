From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
Date: Fri, 11 Mar 2005 13:56:39 -0700
Message-ID: <1110574599.4822.54.camel@eeyore>
References: <20050304234622.63e8a335.akpm@osdl.org>
	 <Pine.LNX.4.62.0503110006260.30687@alpha.polcom.net>
	 <1110559685.4822.15.camel@eeyore>
	 <Pine.LNX.4.62.0503112009070.22293@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.62.0503112009070.22293-xO7mqm7LmoOZ0THcR2OzsA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Grzegorz Kulewski <kangur-ghbW0t/Qn0CsTnJN9+BGXg@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2005-03-11 at 20:36 +0100, Grzegorz Kulewski wrote:
> On Fri, 11 Mar 2005, Bjorn Helgaas wrote:
> > Can you check to see whether there are any BIOS updates available
> > for your box?  It looks to me like your USB controllers are wired
> > to IRQ9, and that's how the BIOS is leaving them configured.
> 
> And if this is a BIOS issue then why it worked for 3 years with all 
> kernels up to at least 2.6.9

Good point.

Thanks for posting the 2.6.9 output as well.  It contains this:

    ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
    ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
    ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 (level, low) -> IRQ 10
    PCI: Via IRQ fixup for 0000:00:07.2, from 9 to 10
    PCI: Via IRQ fixup for 0000:00:07.3, from 9 to 10

In 2.6.9, we did all the ACPI IRQ routing early, then did the
Via IRQ fixups.  In 2.6.11, ACPI IRQ routing is done only when
a driver claims a device, and the Via IRQ fixup is done a little
differently.  In fact, the Via fixup happens before we twiddle
the IOAPIC, where in 2.6.9, it happened after.

Can you try the attached patch to see whether it makes any
difference?

===== drivers/acpi/pci_irq.c 1.37 vs edited =====
--- 1.37/drivers/acpi/pci_irq.c	2005-03-01 09:57:29 -07:00
+++ edited/drivers/acpi/pci_irq.c	2005-03-11 13:45:56 -07:00
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
 #include <linux/pm.h>
@@ -438,10 +439,19 @@
 		}
  	}
 
-	if (via_interrupt_line_quirk)
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq & 15);
-
 	dev->irq = acpi_register_gsi(irq, edge_level, active_high_low);
+
+	if (via_interrupt_line_quirk) {
+		u8 old_irq, new_irq = dev->irq & 0xf;
+
+		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &old_irq);
+		if (new_irq != old_irq) {
+			printk(KERN_INFO PREFIX "Via IRQ fixup for %s, from %d "
+				"to %d\n", pci_name(dev), old_irq, new_irq);
+			udelay(15);
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
+		}
+	}
 
 	printk(KERN_INFO PREFIX "PCI interrupt %s[%c] -> GSI %u "
 		"(%s, %s) -> IRQ %d\n",




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
