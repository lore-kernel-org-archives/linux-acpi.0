From: Len Brown <lenb@kernel.org>
Subject: [PATCH 39/94] ACPI: PCI: use conventional PCI address format
Date: Fri, 09 Jan 2009 04:26:41 -0500
Message-ID: <21a53283a012f21764f2aaaac9414849e1153d93.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56420 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbZAIJ20 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:26 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700E4Y6AUP1W2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:08 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Use the conventional format for PCI addresses (%04x:%02x:%02x.%d).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_bind.c |   12 ++++++------
 drivers/acpi/pci_irq.c  |   10 +++++-----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index 4b252ea..53f502d 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -99,7 +99,7 @@ acpi_status acpi_get_pci_id(acpi_handle handle, struct acpi_pci_id *id)
 	 */
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Device %s has PCI address %02x:%02x:%02x.%02x\n",
+			  "Device %s has PCI address %04x:%02x:%02x.%d\n",
 			  acpi_device_bid(device), id->segment, id->bus,
 			  id->device, id->function));
 
@@ -166,7 +166,7 @@ int acpi_pci_bind(struct acpi_device *device)
 	data->id.device = device->pnp.bus_address >> 16;
 	data->id.function = device->pnp.bus_address & 0xFFFF;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "...to %02x:%02x:%02x.%02x\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "...to %04x:%02x:%02x.%d\n",
 			  data->id.segment, data->id.bus, data->id.device,
 			  data->id.function));
 
@@ -196,7 +196,7 @@ int acpi_pci_bind(struct acpi_device *device)
 	}
 	if (!data->dev) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Device %02x:%02x:%02x.%02x not present in PCI namespace\n",
+				  "Device %04x:%02x:%02x.%d not present in PCI namespace\n",
 				  data->id.segment, data->id.bus,
 				  data->id.device, data->id.function));
 		result = -ENODEV;
@@ -204,7 +204,7 @@ int acpi_pci_bind(struct acpi_device *device)
 	}
 	if (!data->dev->bus) {
 		printk(KERN_ERR PREFIX
-			    "Device %02x:%02x:%02x.%02x has invalid 'bus' field\n",
+			    "Device %04x:%02x:%02x.%d has invalid 'bus' field\n",
 			    data->id.segment, data->id.bus,
 			    data->id.device, data->id.function);
 		result = -ENODEV;
@@ -219,7 +219,7 @@ int acpi_pci_bind(struct acpi_device *device)
 	 */
 	if (data->dev->subordinate) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Device %02x:%02x:%02x.%02x is a PCI bridge\n",
+				  "Device %04x:%02x:%02x.%d is a PCI bridge\n",
 				  data->id.segment, data->id.bus,
 				  data->id.device, data->id.function));
 		data->bus = data->dev->subordinate;
@@ -353,7 +353,7 @@ acpi_pci_bind_root(struct acpi_device *device,
 	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Binding PCI root bridge [%s] to "
-			  "%02x:%02x\n", pathname, id->segment, id->bus));
+			  "%04x:%02x\n", pathname, id->segment, id->bus));
 
 	status = acpi_attach_data(device->handle, acpi_pci_data_handler, data);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 11acaee..63a1326 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -222,7 +222,7 @@ acpi_pci_irq_add_entry(acpi_handle handle,
 		entry->link.index = prt->source_index;
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INFO,
-			      "      %02X:%02X:%02X[%c] -> %s[%d]\n",
+			      "      %04x:%02x:%02x[%c] -> %s[%d]\n",
 			      entry->id.segment, entry->id.bus,
 			      entry->id.device, ('A' + entry->pin), prt->source,
 			      entry->link.index));
@@ -328,8 +328,8 @@ void acpi_pci_irq_del_prt(int segment, int bus)
 	}
 
 	printk(KERN_DEBUG
-	       "ACPI: Delete PCI Interrupt Routing Table for %x:%x\n", segment,
-	       bus);
+	       "ACPI: Delete PCI Interrupt Routing Table for %04x:%02x\n",
+	       segment, bus);
 	spin_lock(&acpi_prt_lock);
 	list_for_each_safe(node, n, &acpi_prt.entries) {
 		entry = list_entry(node, struct acpi_prt_entry, node);
@@ -403,12 +403,12 @@ acpi_pci_irq_lookup(struct pci_bus *bus,
 
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Searching for PRT entry for %02x:%02x:%02x[%c]\n",
+			  "Searching for _PRT entry for %04x:%02x:%02x[%c]\n",
 			  segment, bus_nr, device, ('A' + pin)));
 
 	entry = acpi_pci_irq_find_prt_entry(segment, bus_nr, device, pin);
 	if (!entry) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "PRT entry not found\n"));
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_PRT entry not found\n"));
 		return -1;
 	}
 
-- 
1.5.6.6

