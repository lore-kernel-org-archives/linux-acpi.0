From: Len Brown <lenb@kernel.org>
Subject: [PATCH 41/94] ACPI: PCI: simplify buffer management for evaluating _PRT
Date: Fri, 09 Jan 2009 04:26:43 -0500
Message-ID: <2320ac6cb078eec77bf93742895dc35e64fae124.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:44602 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454AbZAIJ2K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:10 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700BC66AWP297@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:09 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Previously, acpi_pci_irq_add_prt() did all its own buffer management.
But now that we have ACPI_ALLOCATE_BUFFER, we no longer need to do
that management.  And we don't have to call acpi_get_irq_routing_table()
twice (once to learn the size of the buffer needed, and again to
actually get the table).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   52 +++++++++++------------------------------------
 1 files changed, 12 insertions(+), 40 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 6c04060..6a9f3dd 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -243,55 +243,29 @@ acpi_pci_irq_del_entry(int segment, int bus, struct acpi_prt_entry *entry)
 
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
@@ -301,16 +275,14 @@ int acpi_pci_irq_add_prt(acpi_handle handle, int segment, int bus)
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
 
-- 
1.5.6.6

