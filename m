From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: [PATCH] 2.4.23-pre3 Don't change BIOS allocated IRQs
Date: Wed, 17 Sep 2003 00:06:59 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200309170006.59980.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

With the help of Chris Wright testing several failed patches, I've tracked 
down another ACPI IRQ problem. On many systems, the BIOS 
pre-allocates IRQs for certain PCI devices, providing a list of alternate 
possibilities as well.

On some systems, changing the IRQ to one of those alternate possibilities 
works fine. On others however, it really isn't a good idea. As theres no 
way to tell which systems are good and bad in advance, this patch simply 
ensures that ACPI does not change an IRQ if the BIOS has pre-allocated it.


--- linux-2.4.23-pre3.null_crs/drivers/acpi/pci_link.c	2003-09-05 23:57:39.000000000 +0100
+++ linux-2.4.23-pre3.nochangeirq/drivers/acpi/pci_link.c	2003-09-16 23:59:49.212387016 +0100
@@ -507,15 +507,15 @@
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
