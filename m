From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
Date: Fri, 11 Mar 2005 15:29:10 -0700
Message-ID: <1110580150.4822.75.camel@eeyore>
References: <20050304234622.63e8a335.akpm@osdl.org>
	 <Pine.LNX.4.62.0503110006260.30687@alpha.polcom.net>
	 <1110559685.4822.15.camel@eeyore>
	 <Pine.LNX.4.62.0503112009070.22293@alpha.polcom.net>
	 <1110574599.4822.54.camel@eeyore>
	 <Pine.LNX.4.62.0503112239580.25254@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.62.0503112239580.25254-xO7mqm7LmoOZ0THcR2OzsA@public.gmane.org>
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

Can you do an "lspci -vvn"?  I'm looking at quirk_via_irqpic() in
2.6.9, which is what printed this:

> >    PCI: Via IRQ fixup for 0000:00:07.2, from 9 to 10
> >    PCI: Via IRQ fixup for 0000:00:07.3, from 9 to 10

but it looks like it should only run for PCI_DEVICE_ID_VIA_82C586_2,
PCI_DEVICE_ID_VIA_82C686_5, and PCI_DEVICE_ID_VIA_82C686_6.

You have:

0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
0000:00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
0000:00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])

and we apparently ran the quirk for 07.2 and 07.3.  I wouldn't
have thought those would have one of the above device IDs.  The
"lspci -vvn" should tell us for sure.

2.6.11 removed that quirk and runs quirk_via_bridge() for
all VIA devices, but only sets via_interrupt_line_quirk if
(pdev->devfn == 0), which you don't have.  So that's why
my patch didn't do anything.

> Also two more questions:
> 
> 1. What is VIA fixup? Is it some hardware bug? Or BIOS problem? Why is it 
> needed? On what hardware / software it is needed?

I really don't know much about the VIA fixup.  I just noticed
that we seem to be doing it slightly differently in 2.6.11 than
we did in 2.6.9, and thought maybe it was related to your problem.
Here's a changeset that has a couple pointers:

    http://linux.bkbits.net:8080/linux-2.5/cset%4041cb9d48DRV4TYe77gvstTawuZFYyQ

> 2. Why this patch shrinked bzImage that much:
> 
> -rw-r--r--  1 root root 1828186 mar 11 23:33 vmlinuz-2.6.11-cko1
> -rw-r--r--  1 root root 1828355 mar  2 20:48 vmlinuz-2.6.11-cko1.old

I have no idea about this.  But it's only a couple hundred bytes.

So here's another patch to try (revert the first one, then apply this).

===== drivers/acpi/pci_irq.c 1.37 vs edited =====
--- 1.37/drivers/acpi/pci_irq.c	2005-03-01 09:57:29 -07:00
+++ edited/drivers/acpi/pci_irq.c	2005-03-11 15:13:49 -07:00
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
 #include <linux/pm.h>
@@ -438,10 +439,17 @@
 		}
  	}
 
-	if (via_interrupt_line_quirk)
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq & 15);
-
 	dev->irq = acpi_register_gsi(irq, edge_level, active_high_low);
+
+	if (dev->vendor == PCI_VENDOR_ID_VIA) {
+		u8 old_irq, new_irq = dev->irq & 0xf;
+
+		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &old_irq);
+		printk(KERN_INFO PREFIX "Via IRQ fixup for %s, from %d "
+			"to %d\n", pci_name(dev), old_irq, new_irq);
+		udelay(15);
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
+	}
 
 	printk(KERN_INFO PREFIX "PCI interrupt %s[%c] -> GSI %u "
 		"(%s, %s) -> IRQ %d\n",




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
