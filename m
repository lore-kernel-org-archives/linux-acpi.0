From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 3/5] ACPI: pci_root: use driver data rather than list lookup
Date: Thu, 18 Jun 2009 14:46:57 -0600
Message-ID: <20090618204657.15850.22025.stgit@bob.kio>
References: <20090618203916.15850.7977.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:16568 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbZFRUqy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2009 16:46:54 -0400
In-Reply-To: <20090618203916.15850.7977.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

There's no need to search the list to find the acpi_pci_root
structure.  We saved it as device->driver_data when we added
the device.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_root.c |   21 ++++-----------------
 1 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index c780008..e490a2e 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -599,30 +599,17 @@ end:
 
 static int acpi_pci_root_start(struct acpi_device *device)
 {
-	struct acpi_pci_root *root;
-
+	struct acpi_pci_root *root = acpi_driver_data(device);
 
-	list_for_each_entry(root, &acpi_pci_roots, node) {
-		if (root->device == device) {
-			pci_bus_add_devices(root->bus);
-			return 0;
-		}
-	}
-	return -ENODEV;
+	pci_bus_add_devices(root->bus);
+	return 0;
 }
 
 static int acpi_pci_root_remove(struct acpi_device *device, int type)
 {
-	struct acpi_pci_root *root = NULL;
-
-
-	if (!device || !acpi_driver_data(device))
-		return -EINVAL;
-
-	root = acpi_driver_data(device);
+	struct acpi_pci_root *root = acpi_driver_data(device);
 
 	kfree(root);
-
 	return 0;
 }
 

