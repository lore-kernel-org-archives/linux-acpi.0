From: Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>
Subject: Re: [PATCH] 2.6.0-test4 Don't change BIOS allocated IRQs
Date: Tue, 16 Sep 2003 17:29:47 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030916172947.K22486@osdlab.pdx.osdl.net>
References: <200309170011.03630.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200309170011.03630.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>; from adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org on Wed, Sep 17, 2003 at 12:11:03AM +0100
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

* Andrew de Quincey (adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org) wrote:
> With the help of Chris Wright testing several failed patches, I've tracked 
> down another ACPI IRQ problem. On many systems, the BIOS 
> pre-allocates IRQs for certain PCI devices, providing a list of alternate 
> possibilities as well.

As Andrew showed me, this manifested itself like:

ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *6 7 10 11 12)
...
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10

whereas the patch does:

ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *6 7 10 11 12)
...
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 6

> On some systems, changing the IRQ to one of those alternate possibilities 
> works fine. On others however, it really isn't a good idea. As theres no 
> way to tell which systems are good and bad in advance, this patch simply 
> ensures that ACPI does not change an IRQ if the BIOS has pre-allocated it.

Thanks for the patch Andrew ;-)  I tested this patch (or applicable
variation) on test3-bk3 (where the original breakage ocurred) up through
test5-mm2, all worked fine.  This patch doesn't actually apply to current
test5-bk (inline patch and url below) or test5-mm2 (inline patch and
url below) for those who'd like to test.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

2.6.0-test5-bk_current acpi pci irq fix:
http://developer.osdl.org/chrisw/acpi/2.6.0-test5/test5-bk-acpi_pci_irq_fix.diff

===== drivers/acpi/pci_link.c 1.17 vs edited =====
--- 1.17/drivers/acpi/pci_link.c	Sun Aug 31 16:14:25 2003
+++ edited/drivers/acpi/pci_link.c	Tue Sep 16 16:59:46 2003
@@ -456,7 +456,6 @@
 		irq = link->irq.active;
 	} else {
 		irq = link->irq.possible[0];
-	}
 
 		/* 
 		 * Select the best IRQ.  This is done in reverse to promote 
@@ -466,6 +465,7 @@
 			if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
 				irq = link->irq.possible[i];
 		}
+	}
 
 	/* Attempt to enable the link device at this IRQ. */
 	if (acpi_pci_link_set(link, irq)) {


2.6.0-test5-mm2 acpi pci irq fix:
http://developer.osdl.org/chrisw/acpi/2.6.0-test5-mm2/mm2-acpi_pci_irq_fix.diff

--- 2.6.0-test5-mm2-clean/drivers/acpi/pci_link.c	2003-09-16 14:17:27.000000000 -0700
+++ 2.6.0-test5-mm2/drivers/acpi/pci_link.c	2003-09-16 15:01:31.000000000 -0700
@@ -509,15 +509,15 @@
 		irq = link->irq.active;
 	} else {
 		irq = link->irq.possible[0];
-	}
 
-	/*
-	 * Select the best IRQ.  This is done in reverse to promote
-	 * the use of IRQs 9, 10, 11, and >15.
-	 */
-	for (i=(link->irq.possible_count-1); i>0; i--) {
-		if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
-			irq = link->irq.possible[i];
+		/*
+		 * Select the best IRQ.  This is done in reverse to promote
+		 * the use of IRQs 9, 10, 11, and >15.
+		 */
+		for (i=(link->irq.possible_count-1); i>0; i--) {
+			if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
+				irq = link->irq.possible[i];
+		}
 	}
 
 	/* Attempt to enable the link device at this IRQ. */
