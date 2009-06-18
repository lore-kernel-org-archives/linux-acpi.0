From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/5] ACPI: pci_root: simplify acpi_pci_root_add() control flow
Date: Thu, 18 Jun 2009 14:46:52 -0600
Message-ID: <20090618204652.15850.62615.stgit@bob.kio>
References: <20090618203916.15850.7977.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:22723 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbZFRUqt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2009 16:46:49 -0400
In-Reply-To: <20090618203916.15850.7977.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

By looking up the segment & bus number earlier, we don't have to
worry about cleaning up if it fails.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_root.c |  100 ++++++++++++++++++-----------------------------
 1 files changed, 38 insertions(+), 62 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 7847732..c780008 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -185,19 +185,22 @@ get_root_bridge_busnr_callback(struct acpi_resource *resource, void *data)
 	return AE_OK;
 }
 
-static acpi_status try_get_root_bridge_busnr(acpi_handle handle, int *busnum)
+static acpi_status try_get_root_bridge_busnr(acpi_handle handle,
+					     unsigned long long *bus)
 {
 	acpi_status status;
+	int busnum;
 
-	*busnum = -1;
+	busnum = -1;
 	status =
 	    acpi_walk_resources(handle, METHOD_NAME__CRS,
-				get_root_bridge_busnr_callback, busnum);
+				get_root_bridge_busnr_callback, &busnum);
 	if (ACPI_FAILURE(status))
 		return status;
 	/* Check if we really get a bus number from _CRS */
-	if (*busnum == -1)
+	if (busnum == -1)
 		return AE_ERROR;
+	*bus = busnum;
 	return AE_OK;
 }
 
@@ -468,24 +471,39 @@ EXPORT_SYMBOL(acpi_pci_osc_control_set);
 
 static int __devinit acpi_pci_root_add(struct acpi_device *device)
 {
-	int result = 0;
-	struct acpi_pci_root *root = NULL;
-	acpi_status status = AE_OK;
-	unsigned long long value = 0;
-	acpi_handle handle = NULL;
+	unsigned long long segment, bus;
+	acpi_status status;
+	int result;
+	struct acpi_pci_root *root;
+	acpi_handle handle;
 	struct acpi_device *child;
 	u32 flags, base_flags;
-	int bus;
 
+	segment = 0;
+	status = acpi_evaluate_integer(device->handle, METHOD_NAME__SEG, NULL,
+				       &segment);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+		printk(KERN_ERR PREFIX "can't evaluate _SEG\n");
+		return -ENODEV;
+	}
 
-	if (!device)
-		return -EINVAL;
+	/* Check _CRS first, then _BBN.  If no _BBN, default to zero. */
+	bus = 0;
+	status = try_get_root_bridge_busnr(device->handle, &bus);
+	if (ACPI_FAILURE(status)) {
+		status = acpi_evaluate_integer(device->handle, METHOD_NAME__BBN,					       NULL, &bus);
+		if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+			printk(KERN_ERR PREFIX
+			     "no bus number in _CRS and can't evaluate _BBN\n");
+			return -ENODEV;
+		}
+	}
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)
 		return -ENOMEM;
-	INIT_LIST_HEAD(&root->node);
 
+	INIT_LIST_HEAD(&root->node);
 	root->device = device;
 	strcpy(acpi_device_name(device), ACPI_PCI_ROOT_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
@@ -498,54 +516,13 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	flags = base_flags = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
 	acpi_pci_osc_support(root, flags);
 
-	/* 
-	 * Segment
-	 * -------
-	 * Obtained via _SEG, if exists, otherwise assumed to be zero (0).
-	 */
-	status = acpi_evaluate_integer(device->handle, METHOD_NAME__SEG, NULL,
-				       &value);
-	switch (status) {
-	case AE_OK:
-		root->id.segment = (u16) value;
-		break;
-	case AE_NOT_FOUND:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Assuming segment 0 (no _SEG)\n"));
-		root->id.segment = 0;
-		break;
-	default:
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _SEG"));
-		result = -ENODEV;
-		goto end;
-	}
-
-	/* 
-	 * Bus
-	 * ---
-	 * Check _CRS first, then _BBN.  If no _BBN, default to zero.
-	 */
-	status = try_get_root_bridge_busnr(device->handle, &bus);
-	if (ACPI_SUCCESS(status))
-		root->id.bus = bus;
-	else {
-		status = acpi_evaluate_integer(device->handle, METHOD_NAME__BBN,					       NULL, &value);
-		if (ACPI_SUCCESS(status))
-			root->id.bus = (u16) value;
-		else if (status == AE_NOT_FOUND)
-			root->id.bus = 0;
-		else {
-			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BBN"));
-			result = -ENODEV;
-			goto end;
-		}
-	}
-
 	/*
 	 * Device & Function
 	 * -----------------
 	 * Obtained from _ADR (which has already been evaluated for us).
 	 */
+	root->id.segment = segment & 0xFFFF;
+	root->id.bus = bus & 0xFF;
 	root->id.device = device->pnp.bus_address >> 16;
 	root->id.function = device->pnp.bus_address & 0xFFFF;
 
@@ -611,13 +588,12 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	if (flags != base_flags)
 		acpi_pci_osc_support(root, flags);
 
-      end:
-	if (result) {
-		if (!list_empty(&root->node))
-			list_del(&root->node);
-		kfree(root);
-	}
+	return 0;
 
+end:
+	if (!list_empty(&root->node))
+		list_del(&root->node);
+	kfree(root);
 	return result;
 }
 

