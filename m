From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: 2.4 PATCH: Fix acpi for bigsur
Date: Wed, 6 Aug 2003 15:54:49 -0600
Sender: linux-ia64-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200308061554.49572.bjorn.helgaas@hp.com>
References: <20030806154504.GC28899@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030806154504.GC28899-8HFB7qzu3A/YtjvyW6yDsg@public.gmane.org>
Content-Disposition: inline
To: "H. J. Lu" <hjl-8HFB7qzu3A/YtjvyW6yDsg@public.gmane.org>, linux ia64 kernel <linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> I need this patch to get the current 2.4 kernel to boot on bigsur.

I reproduced that problem, and applied the following patch for 2.4
(this is what we had in 2.4.21, prior to the big ACPI update in 2.4).

Andy, can you apply this to ACPI?  It's needed for both 2.4 and 2.5
ia64 kernels.  The problem is that on machines with an 8259, the
SCI interrupt might be a legacy ISA IRQ, not a GSI.

I'm not thrilled about the name "acpi_irq_to_vector".  Something
like "acpi_interrupt_to_irq" seems like it would fit the usage better.
Suggestions?

Bjorn


===== drivers/acpi/osl.c 1.27 vs edited =====
--- 1.27/drivers/acpi/osl.c	Thu Jul 10 04:20:31 2003
+++ edited/drivers/acpi/osl.c	Wed Aug  6 16:16:38 2003
@@ -251,7 +251,12 @@
 	irq = acpi_fadt.sci_int;
 
 #ifdef CONFIG_IA64
-	irq = gsi_to_vector(irq);
+	irq = acpi_irq_to_vector(irq);
+	if (irq < 0) {
+		printk(KERN_ERR PREFIX "SCI (ACPI interrupt %d) not registerd\n",
+		       acpi_fadt.sci_int);
+		return AE_OK;
+	}
 #endif
 	acpi_irq_irq = irq;
 	acpi_irq_handler = handler;
@@ -269,7 +274,7 @@
 {
 	if (acpi_irq_handler) {
 #ifdef CONFIG_IA64
-		irq = gsi_to_vector(irq);
+		irq = acpi_irq_to_vector(irq);
 #endif
 		free_irq(irq, acpi_irq);
 		acpi_irq_handler = NULL;

-
To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
