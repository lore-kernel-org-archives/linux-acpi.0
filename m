From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [ACPI] [PATCH] 2.6.0-test4 Don't change BIOS allocated IRQs
Date: Tue, 16 Sep 2003 18:02:55 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030917010254.GA1640@kroah.com>
References: <200309170011.03630.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200309170011.03630.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Sep 17, 2003 at 12:11:03AM +0100, Andrew de Quincey wrote:
> With the help of Chris Wright testing several failed patches, I've tracked 
> down another ACPI IRQ problem. On many systems, the BIOS 
> pre-allocates IRQs for certain PCI devices, providing a list of alternate 
> possibilities as well.
> 
> On some systems, changing the IRQ to one of those alternate possibilities 
> works fine. On others however, it really isn't a good idea. As theres no 
> way to tell which systems are good and bad in advance, this patch simply 
> ensures that ACPI does not change an IRQ if the BIOS has pre-allocated it.

Nice, the patch below, which Chris told me is from you, fixed my
problems too.  It is against 2.6.0-test5-bk3 and fixes bug number 1186
in the bugzilla.kernel.org database.

Many thanks for this work, I really appreciate it.

thanks,

greg k-h

test5-bk_current
===== drivers/acpi/pci_link.c 1.13 vs edited =====
--- 1.13/drivers/acpi/pci_link.c	Mon Sep  8 05:51:03 2003
+++ edited/drivers/acpi/pci_link.c	Tue Sep 16 16:16:31 2003
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
