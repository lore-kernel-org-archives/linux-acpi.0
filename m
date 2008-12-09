From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 03/20] ACPI: PCI: simplify buffer management for evaluating
	_PRT
Date: Mon, 08 Dec 2008 21:30:15 -0700
Message-ID: <20081209043015.26415.63813.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:35968 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbYLIEaQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:30:16 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
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
---
 drivers/acpi/pci_irq.c |   52 +++++++++++-------------------------------------
 1 files changed, 12 insertions(+), 40 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 8250c55..0a31527 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -245,55 +245,29 @@ acpi_pci_irq_del_entry(int segment, int bus, struct acpi_prt_entry *entry)
 
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
@@ -303,16 +277,14 @@ int acpi_pci_irq_add_prt(acpi_handle handle, int segment, int bus)
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
 

