From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] ACPI: simplify buffer management for evaluating _PRT
Date: Wed, 5 Mar 2008 16:42:10 -0700
Message-ID: <200803051642.10640.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:30104 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107AbYCEXj4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Mar 2008 18:39:56 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Previously, acpi_pci_irq_add_prt() did all its own buffer management.
But now that we have ACPI_ALLOCATE_BUFFER, we no longer need to do
that management.  And we don't have to call acpi_get_irq_routing_table()
twice (once to learn the size of the buffer needed, and again to
actually get the table).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work7/drivers/acpi/pci_irq.c
===================================================================
--- work7.orig/drivers/acpi/pci_irq.c	2008-03-05 14:48:51.000000000 -0700
+++ work7/drivers/acpi/pci_irq.c	2008-03-05 16:24:52.000000000 -0700
@@ -246,55 +246,29 @@
 
 int acpi_pci_irq_add_prt(acpi_handle handle, int segment, int bus)
 {
-	acpi_status status = AE_OK;
-	char *pathname = NULL;
-	struct acpi_buffer buffer = { 0, NULL };
-	struct acpi_pci_routing_table *prt = NULL;
-	struct acpi_pci_routing_table *entry = NULL;
+	acpi_status status;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_pci_routing_table *entry;
 	static int first_time = 1;
 
-
-	pathname = kzalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
-	if (!pathname)
-		return -ENOMEM;
-
 	if (first_time) {
 		acpi_prt.count = 0;
 		INIT_LIST_HEAD(&acpi_prt.entries);
 		first_time = 0;
 	}
 
-	/* 
-	 * NOTE: We're given a 'handle' to the _PRT object's parent device
-	 *       (either a PCI root bridge or PCI-PCI bridge).
-	 */
-
-	buffer.length = ACPI_PATHNAME_MAX;
-	buffer.pointer = pathname;
-	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
+	/* 'handle' is the _PRT's parent (root bridge or PCI-PCI bridge) */
+	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
 
 	printk(KERN_DEBUG "ACPI: PCI Interrupt Routing Table [%s._PRT]\n",
-	       pathname);
+	       (char *) buffer.pointer);
 
-	/* 
-	 * Evaluate this _PRT and add its entries to our global list (acpi_prt).
-	 */
+	kfree(buffer.pointer);
 
-	buffer.length = 0;
+	buffer.length = ACPI_ALLOCATE_BUFFER;
 	buffer.pointer = NULL;
-	kfree(pathname);
-	status = acpi_get_irq_routing_table(handle, &buffer);
-	if (status != AE_BUFFER_OVERFLOW) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRT [%s]",
-				acpi_format_exception(status)));
-		return -ENODEV;
-	}
-
-	prt = kzalloc(buffer.length, GFP_KERNEL);
-	if (!prt) {
-		return -ENOMEM;
-	}
-	buffer.pointer = prt;
 
 	status = acpi_get_irq_routing_table(handle, &buffer);
 	if (ACPI_FAILURE(status)) {
@@ -304,16 +278,14 @@
 		return -ENODEV;
 	}
 
-	entry = prt;
-
+	entry = buffer.pointer;
 	while (entry && (entry->length > 0)) {
 		acpi_pci_irq_add_entry(handle, segment, bus, entry);
 		entry = (struct acpi_pci_routing_table *)
 		    ((unsigned long)entry + entry->length);
 	}
 
-	kfree(prt);
-
+	kfree(buffer.pointer);
 	return 0;
 }
 
