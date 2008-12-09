From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 01/20] ACPI: PCI: use conventional PCI address format
Date: Mon, 08 Dec 2008 21:30:05 -0700
Message-ID: <20081209043005.26415.72401.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:45892 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbYLIEaG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:30:06 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Use the conventional format for PCI addresses (%04x:%02x:%02x.%d).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_bind.c |   12 ++++++------
 drivers/acpi/pci_irq.c  |   10 +++++-----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index 676d0a4..cd9780c 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -101,7 +101,7 @@ acpi_status acpi_get_pci_id(acpi_handle handle, struct acpi_pci_id *id)
 	 */
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Device %s has PCI address %02x:%02x:%02x.%02x\n",
+			  "Device %s has PCI address %04x:%02x:%02x.%d\n",
 			  acpi_device_bid(device), id->segment, id->bus,
 			  id->device, id->function));
 
@@ -168,7 +168,7 @@ int acpi_pci_bind(struct acpi_device *device)
 	data->id.device = device->pnp.bus_address >> 16;
 	data->id.function = device->pnp.bus_address & 0xFFFF;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "...to %02x:%02x:%02x.%02x\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "...to %04x:%02x:%02x.%d\n",
 			  data->id.segment, data->id.bus, data->id.device,
 			  data->id.function));
 
@@ -198,7 +198,7 @@ int acpi_pci_bind(struct acpi_device *device)
 	}
 	if (!data->dev) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Device %02x:%02x:%02x.%02x not present in PCI namespace\n",
+				  "Device %04x:%02x:%02x.%d not present in PCI namespace\n",
 				  data->id.segment, data->id.bus,
 				  data->id.device, data->id.function));
 		result = -ENODEV;
@@ -206,7 +206,7 @@ int acpi_pci_bind(struct acpi_device *device)
 	}
 	if (!data->dev->bus) {
 		printk(KERN_ERR PREFIX
-			    "Device %02x:%02x:%02x.%02x has invalid 'bus' field\n",
+			    "Device %04x:%02x:%02x.%d has invalid 'bus' field\n",
 			    data->id.segment, data->id.bus,
 			    data->id.device, data->id.function);
 		result = -ENODEV;
@@ -221,7 +221,7 @@ int acpi_pci_bind(struct acpi_device *device)
 	 */
 	if (data->dev->subordinate) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Device %02x:%02x:%02x.%02x is a PCI bridge\n",
+				  "Device %04x:%02x:%02x.%d is a PCI bridge\n",
 				  data->id.segment, data->id.bus,
 				  data->id.device, data->id.function));
 		data->bus = data->dev->subordinate;
@@ -355,7 +355,7 @@ acpi_pci_bind_root(struct acpi_device *device,
 	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Binding PCI root bridge [%s] to "
-			  "%02x:%02x\n", pathname, id->segment, id->bus));
+			  "%04x:%02x\n", pathname, id->segment, id->bus));
 
 	status = acpi_attach_data(device->handle, acpi_pci_data_handler, data);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index a5ba18c..6666f74 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -224,7 +224,7 @@ acpi_pci_irq_add_entry(acpi_handle handle,
 		entry->link.index = prt->source_index;
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INFO,
-			      "      %02X:%02X:%02X[%c] -> %s[%d]\n",
+			      "      %04x:%02x:%02x[%c] -> %s[%d]\n",
 			      entry->id.segment, entry->id.bus,
 			      entry->id.device, ('A' + entry->pin), prt->source,
 			      entry->link.index));
@@ -330,8 +330,8 @@ void acpi_pci_irq_del_prt(int segment, int bus)
 	}
 
 	printk(KERN_DEBUG
-	       "ACPI: Delete PCI Interrupt Routing Table for %x:%x\n", segment,
-	       bus);
+	       "ACPI: Delete PCI Interrupt Routing Table for %04x:%02x\n",
+	       segment, bus);
 	spin_lock(&acpi_prt_lock);
 	list_for_each_safe(node, n, &acpi_prt.entries) {
 		entry = list_entry(node, struct acpi_prt_entry, node);
@@ -405,12 +405,12 @@ acpi_pci_irq_lookup(struct pci_bus *bus,
 
 
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
 

