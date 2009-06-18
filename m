From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 5/5] ACPI: pci_root: remove unused dev/fn information
Date: Thu, 18 Jun 2009 14:47:07 -0600
Message-ID: <20090618204707.15850.20614.stgit@bob.kio>
References: <20090618203916.15850.7977.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:22751 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbZFRUrE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2009 16:47:04 -0400
In-Reply-To: <20090618203916.15850.7977.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alex Chiang <achiang@hp.com>

We never use the PCI device & function number, so remove it to make
it clear that it's not needed.  Many PCI host bridges don't even
appear in config space, so it's meaningless to look at stuff from
_ADR, which doesn't exist in that case.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Reviewed-by: Alex Chiang <achiang@hp.com>
---
 drivers/acpi/pci_root.c |   25 +++++++++----------------
 1 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d9d34e2..8a5bf3b 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -63,9 +63,10 @@ static struct acpi_driver acpi_pci_root_driver = {
 
 struct acpi_pci_root {
 	struct list_head node;
-	struct acpi_device * device;
-	struct acpi_pci_id id;
+	struct acpi_device *device;
 	struct pci_bus *bus;
+	u16 segment;
+	u8 bus_nr;
 
 	u32 osc_support_set;	/* _OSC state of support bits */
 	u32 osc_control_set;	/* _OSC state of control bits */
@@ -129,7 +130,7 @@ acpi_handle acpi_get_pci_rootbridge_handle(unsigned int seg, unsigned int bus)
 	struct acpi_pci_root *root;
 	
 	list_for_each_entry(root, &acpi_pci_roots, node)
-		if ((root->id.segment == (u16) seg) && (root->id.bus == (u16) bus))
+		if ((root->segment == (u16) seg) && (root->bus_nr == (u16) bus))
 			return root->device->handle;
 	return NULL;		
 }
@@ -500,6 +501,8 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 
 	INIT_LIST_HEAD(&root->node);
 	root->device = device;
+	root->segment = segment & 0xFFFF;
+	root->bus_nr = bus & 0xFF;
 	strcpy(acpi_device_name(device), ACPI_PCI_ROOT_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
 	device->driver_data = root;
@@ -512,16 +515,6 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	acpi_pci_osc_support(root, flags);
 
 	/*
-	 * Device & Function
-	 * -----------------
-	 * Obtained from _ADR (which has already been evaluated for us).
-	 */
-	root->id.segment = segment & 0xFFFF;
-	root->id.bus = bus & 0xFF;
-	root->id.device = device->pnp.bus_address >> 16;
-	root->id.function = device->pnp.bus_address & 0xFFFF;
-
-	/*
 	 * TBD: Need PCI interface for enumeration/configuration of roots.
 	 */
 
@@ -530,7 +523,7 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 
 	printk(KERN_INFO PREFIX "%s [%s] (%04x:%02x)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
-	       root->id.segment, root->id.bus);
+	       root->segment, root->bus_nr);
 
 	/*
 	 * Scan the Root Bridge
@@ -539,11 +532,11 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	 * PCI namespace does not get created until this call is made (and 
 	 * thus the root bridge's pci_dev does not exist).
 	 */
-	root->bus = pci_acpi_scan_root(device, root->id.segment, root->id.bus);
+	root->bus = pci_acpi_scan_root(device, segment, bus);
 	if (!root->bus) {
 		printk(KERN_ERR PREFIX
 			    "Bus %04x:%02x not present in PCI namespace\n",
-			    root->id.segment, root->id.bus);
+			    root->segment, root->bus_nr);
 		result = -ENODEV;
 		goto end;
 	}

