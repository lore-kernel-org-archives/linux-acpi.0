From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: [PATCH] 2.4.23-pre3 ACPI fixes series (2/3)
Date: Sat, 6 Sep 2003 01:15:36 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200309060115.36772.adq_dvb@lidskialf.net>
References: <200309051958.02818.adq_dvb@lidskialf.net> <200309060016.16545.adq_dvb@lidskialf.net> <3F590E28.6090101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3F590E28.6090101-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
To: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Cc: torvalds-3NddpPZAyC0@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This patch retries IRQ programming with an extended IRQ resource descriptor
if using a standard IRQ descriptor fails.


--- linux-2.4.23-pre3.picmode/drivers/acpi/pci_link.c	2003-09-05 23:54:45.522947816 +0100
+++ linux-2.4.23-pre3.extirq/drivers/acpi/pci_link.c	2003-09-05 23:54:59.945755216 +0100
@@ -290,7 +290,8 @@
 	struct acpi_buffer	buffer = {sizeof(resource)+1, &resource};
 	int			i = 0;
 	int			valid = 0;
-
+	int			resource_type = 0;
+   
 	ACPI_FUNCTION_TRACE("acpi_pci_link_set");
 
 	if (!link || !irq)
@@ -312,13 +313,24 @@
 			return_VALUE(-EINVAL);
 		}
 	}
+ 
+	/* If IRQ<=15, first try with a "normal" IRQ descriptor. If that fails, try with
+	 * an extended one */
+	if (irq <= 15) {
+		resource_type = ACPI_RSTYPE_IRQ;
+	} else {
+		resource_type = ACPI_RSTYPE_EXT_IRQ;
+	}
+
+retry_programming:
    
 	memset(&resource, 0, sizeof(resource));
 
 	/* NOTE: PCI interrupts are always level / active_low / shared. But not all
 	   interrupts > 15 are PCI interrupts. Rely on the ACPI IRQ definition for 
 	   parameters */
-	if (irq <= 15) {	
+	switch(resource_type) {
+	case ACPI_RSTYPE_IRQ:
 		resource.res.id = ACPI_RSTYPE_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
 		resource.res.data.irq.edge_level = link->irq.edge_level;
@@ -326,8 +338,9 @@
 		resource.res.data.irq.shared_exclusive = ACPI_SHARED;
 		resource.res.data.irq.number_of_interrupts = 1;
 		resource.res.data.irq.interrupts[0] = irq;
-	}
-	else {
+		break;
+	 
+	case ACPI_RSTYPE_EXT_IRQ:
 		resource.res.id = ACPI_RSTYPE_EXT_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
 		resource.res.data.extended_irq.producer_consumer = ACPI_CONSUMER;
@@ -337,11 +350,21 @@
 		resource.res.data.extended_irq.number_of_interrupts = 1;
 		resource.res.data.extended_irq.interrupts[0] = irq;
 		/* ignore resource_source, it's optional */
+		break;
 	}
 	resource.end.id = ACPI_RSTYPE_END_TAG;
 
 	/* Attempt to set the resource */
 	status = acpi_set_current_resources(link->handle, &buffer);
+   
+	/* if we failed and IRQ <= 15, try again with an extended descriptor */
+	if (ACPI_FAILURE(status) && (resource_type == ACPI_RSTYPE_IRQ)) {
+                resource_type = ACPI_RSTYPE_EXT_IRQ;
+                printk(PREFIX "Retrying with extended IRQ descriptor\n");
+                goto retry_programming;
+	}
+
+	/* check for total failure */
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _SRS\n"));
 		return_VALUE(-ENODEV);
