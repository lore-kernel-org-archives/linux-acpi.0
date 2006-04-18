From: mochel@linux.intel.com
Subject: [PATCH 16/24] Remove unneeded debugging macros in drivers/acpi/pci_root.c
Date: Mon, 17 Apr 2006 18:21:54 -0700
Message-ID: <11453233144190-git-send-email-mochel@linux.intel.com>
References: <11453233142184-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:60047 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932127AbWDRBZ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:26 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr002.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PPBH025145
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:25 GMT
In-Reply-To: <11453233142184-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/pci_root.c |   28 ++++++++++------------------
 1 files changed, 10 insertions(+), 18 deletions(-)

applies-to: c6ff3432977bb902db1ed7a95e60aad33ca3ab67
9c5964188934da0cb084a3beafc750255f2abb02
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 0f661dd..3dcc091 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -160,14 +160,12 @@ static int acpi_pci_root_add(struct acpi
 	unsigned long value = 0;
 	acpi_handle handle = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_root_add");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	root = kmalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	memset(root, 0, sizeof(struct acpi_pci_root));
 	INIT_LIST_HEAD(&root->node);
 
@@ -307,46 +305,40 @@ static int acpi_pci_root_add(struct acpi
 		kfree(root);
 	}
 
-	return_VALUE(result);
+	return result;
 }
 
 static int acpi_pci_root_start(struct acpi_device *device)
 {
 	struct acpi_pci_root *root;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_root_start");
-
 	list_for_each_entry(root, &acpi_pci_roots, node) {
 		if (root->handle == device->handle) {
 			pci_bus_add_devices(root->bus);
-			return_VALUE(0);
+			return 0;
 		}
 	}
-	return_VALUE(-ENODEV);
+	return -ENODEV;
 }
 
 static int acpi_pci_root_remove(struct acpi_device *device, int type)
 {
 	struct acpi_pci_root *root = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_root_remove");
-
 	if (!device || !acpi_driver_data(device))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	root = (struct acpi_pci_root *)acpi_driver_data(device);
 
 	kfree(root);
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int __init acpi_pci_root_init(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_pci_root_init");
-
 	if (acpi_pci_disabled)
-		return_VALUE(0);
+		return 0;
 
 	/* DEBUG:
 	   acpi_dbg_layer = ACPI_PCI_COMPONENT;
@@ -354,9 +346,9 @@ static int __init acpi_pci_root_init(voi
 	 */
 
 	if (acpi_bus_register_driver(&acpi_pci_root_driver) < 0)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
-	return_VALUE(0);
+	return 0;
 }
 
 subsys_initcall(acpi_pci_root_init);
---
0.99.9.GIT


