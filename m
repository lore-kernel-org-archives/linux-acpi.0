From: Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>
Subject: [PATCH] ACPI pci irq routing fix
Date: Fri, 26 Sep 2003 18:21:28 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030926182128.C24360@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

If irq.active is set from _CRS, make sure to use it, rather than trying
anything from the from the _PRS list, as some machines don't handle this
properly.  This patch is against current linux-acpi-test-2.6.0.  It's
been floating about for a while, and fixes bug #1186.

Patch originally from Andrew de Quincey.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== drivers/acpi/pci_link.c 1.19 vs edited =====
--- 1.19/drivers/acpi/pci_link.c	Thu Sep 18 11:29:36 2003
+++ edited/drivers/acpi/pci_link.c	Fri Sep 26 14:36:15 2003
@@ -500,15 +500,15 @@
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
