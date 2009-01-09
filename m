From: Len Brown <lenb@kernel.org>
Subject: [PATCH 72/94] ACPI: io_acpi_init.c: call acpi_get_name to get node
 fullname
Date: Fri, 09 Jan 2009 04:27:14 -0500
Message-ID: <a8ce4471fe74cf749bcfef7e557a7b94f725c494.1231492611.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:59678 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542AbZAIJ3M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:29:12 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700LIO6BEX3C7@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:28 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

acpi_ns_print_node_pathname is internal used only
use acpi_get_name instead to get node fullname

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/sn/kernel/io_acpi_init.c |  102 ++++++++++++++++++++----------------
 1 files changed, 56 insertions(+), 46 deletions(-)

diff --git a/arch/ia64/sn/kernel/io_acpi_init.c b/arch/ia64/sn/kernel/io_acpi_init.c
index bc610a6..4c8bc8e 100644
--- a/arch/ia64/sn/kernel/io_acpi_init.c
+++ b/arch/ia64/sn/kernel/io_acpi_init.c
@@ -64,6 +64,7 @@ static acpi_status __init
 sn_acpi_hubdev_init(acpi_handle handle, u32 depth, void *context, void **ret)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer name_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	u64 addr;
 	struct hubdev_info *hubdev;
 	struct hubdev_info *hubdev_ptr;
@@ -77,11 +78,12 @@ sn_acpi_hubdev_init(acpi_handle handle, u32 depth, void *context, void **ret)
 	status = acpi_get_vendor_resource(handle, METHOD_NAME__CRS,
 					  &sn_uuid, &buffer);
 	if (ACPI_FAILURE(status)) {
+		acpi_get_name(handle, ACPI_FULL_PATHNAME, &name_buffer);
 		printk(KERN_ERR
 		       "sn_acpi_hubdev_init: acpi_get_vendor_resource() "
-		       "(0x%x) failed for: ", status);
-		acpi_ns_print_node_pathname(handle, NULL);
-		printk("\n");
+		       "(0x%x) failed for: %s\n", status,
+			(char *)name_buffer.pointer);
+		kfree(name_buffer.pointer);
 		return AE_OK;		/* Continue walking namespace */
 	}
 
@@ -89,11 +91,12 @@ sn_acpi_hubdev_init(acpi_handle handle, u32 depth, void *context, void **ret)
 	vendor = &resource->data.vendor_typed;
 	if ((vendor->byte_length - sizeof(struct acpi_vendor_uuid)) !=
 	    sizeof(struct hubdev_info *)) {
+		acpi_get_name(handle, ACPI_FULL_PATHNAME, &name_buffer);
 		printk(KERN_ERR
-		       "sn_acpi_hubdev_init: Invalid vendor data length: %d for: ",
-		        vendor->byte_length);
-		acpi_ns_print_node_pathname(handle, NULL);
-		printk("\n");
+		       "sn_acpi_hubdev_init: Invalid vendor data length: "
+		       "%d for: %s\n",
+			vendor->byte_length, (char *)name_buffer.pointer);
+		kfree(name_buffer.pointer);
 		goto exit;
 	}
 
@@ -120,6 +123,7 @@ sn_get_bussoft_ptr(struct pci_bus *bus)
 {
 	u64 addr;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer name_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	acpi_handle handle;
 	struct pcibus_bussoft *prom_bussoft_ptr;
 	struct acpi_resource *resource;
@@ -131,11 +135,11 @@ sn_get_bussoft_ptr(struct pci_bus *bus)
 	status = acpi_get_vendor_resource(handle, METHOD_NAME__CRS,
 					  &sn_uuid, &buffer);
 	if (ACPI_FAILURE(status)) {
+		acpi_get_name(handle, ACPI_FULL_PATHNAME, &name_buffer);
 		printk(KERN_ERR "%s: "
-		       "acpi_get_vendor_resource() failed (0x%x) for: ",
-		       __func__, status);
-		acpi_ns_print_node_pathname(handle, NULL);
-		printk("\n");
+		       "acpi_get_vendor_resource() failed (0x%x) for: %s\n",
+		       __func__, status, (char *)name_buffer.pointer);
+		kfree(name_buffer.pointer);
 		return NULL;
 	}
 	resource = buffer.pointer;
@@ -168,6 +172,7 @@ sn_extract_device_info(acpi_handle handle, struct pcidev_info **pcidev_info,
 {
 	u64 addr;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer name_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct sn_irq_info *irq_info, *irq_info_prom;
 	struct pcidev_info *pcidev_ptr, *pcidev_prom_ptr;
 	struct acpi_resource *resource;
@@ -182,11 +187,11 @@ sn_extract_device_info(acpi_handle handle, struct pcidev_info **pcidev_info,
 	status = acpi_get_vendor_resource(handle, METHOD_NAME__CRS,
 					  &sn_uuid, &buffer);
 	if (ACPI_FAILURE(status)) {
+		acpi_get_name(handle, ACPI_FULL_PATHNAME, &name_buffer);
 		printk(KERN_ERR
-		       "%s: acpi_get_vendor_resource() failed (0x%x) for: ",
-		        __func__, status);
-		acpi_ns_print_node_pathname(handle, NULL);
-		printk("\n");
+		       "%s: acpi_get_vendor_resource() failed (0x%x) for: %s\n",
+			__func__, status, (char *)name_buffer.pointer);
+		kfree(name_buffer.pointer);
 		return 1;
 	}
 
@@ -194,11 +199,12 @@ sn_extract_device_info(acpi_handle handle, struct pcidev_info **pcidev_info,
 	vendor = &resource->data.vendor_typed;
 	if ((vendor->byte_length - sizeof(struct acpi_vendor_uuid)) !=
 	    sizeof(struct pci_devdev_info *)) {
+		acpi_get_name(handle, ACPI_FULL_PATHNAME, &name_buffer);
 		printk(KERN_ERR
-		       "%s: Invalid vendor data length: %d for: ",
-		        __func__, vendor->byte_length);
-		acpi_ns_print_node_pathname(handle, NULL);
-		printk("\n");
+		       "%s: Invalid vendor data length: %d for: %s\n",
+			 __func__, vendor->byte_length,
+			(char *)name_buffer.pointer);
+		kfree(name_buffer.pointer);
 		ret = 1;
 		goto exit;
 	}
@@ -239,6 +245,9 @@ get_host_devfn(acpi_handle device_handle, acpi_handle rootbus_handle)
 	acpi_handle parent;
 	int slot;
 	acpi_status status;
+	struct acpi_buffer name_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+
+	acpi_get_name(device_handle, ACPI_FULL_PATHNAME, &name_buffer);
 
 	/*
 	 * Do an upward search to find the root bus device, and
@@ -249,9 +258,8 @@ get_host_devfn(acpi_handle device_handle, acpi_handle rootbus_handle)
 		status = acpi_get_parent(child, &parent);
 		if (ACPI_FAILURE(status)) {
 			printk(KERN_ERR "%s: acpi_get_parent() failed "
-			       "(0x%x) for: ", __func__, status);
-			acpi_ns_print_node_pathname(child, NULL);
-			printk("\n");
+			       "(0x%x) for: %s\n", __func__, status,
+				(char *)name_buffer.pointer);
 			panic("%s: Unable to find host devfn\n", __func__);
 		}
 		if (parent == rootbus_handle)
@@ -259,22 +267,20 @@ get_host_devfn(acpi_handle device_handle, acpi_handle rootbus_handle)
 		child = parent;
 	}
 	if (!child) {
-		printk(KERN_ERR "%s: Unable to find root bus for: ",
-		       __func__);
-		acpi_ns_print_node_pathname(device_handle, NULL);
-		printk("\n");
+		printk(KERN_ERR "%s: Unable to find root bus for: %s\n",
+		       __func__, (char *)name_buffer.pointer);
 		BUG();
 	}
 
 	status = acpi_evaluate_integer(child, METHOD_NAME__ADR, NULL, &adr);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR "%s: Unable to get _ADR (0x%x) for: ",
-		       __func__, status);
-		acpi_ns_print_node_pathname(child, NULL);
-		printk("\n");
+		printk(KERN_ERR "%s: Unable to get _ADR (0x%x) for: %s\n",
+		       __func__, status, (char *)name_buffer.pointer);
 		panic("%s: Unable to find host devfn\n", __func__);
 	}
 
+	kfree(name_buffer.pointer);
+
 	slot = (adr >> 16) & 0xffff;
 	function = adr & 0xffff;
 	devfn = PCI_DEVFN(slot, function);
@@ -300,27 +306,28 @@ find_matching_device(acpi_handle handle, u32 lvl, void *context, void **rv)
 	int function;
 	int slot;
 	struct sn_pcidev_match *info = context;
+	struct acpi_buffer name_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
         status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL,
                                        &adr);
         if (ACPI_SUCCESS(status)) {
 		status = acpi_get_parent(handle, &parent);
 		if (ACPI_FAILURE(status)) {
+			acpi_get_name(handle, ACPI_FULL_PATHNAME, &name_buffer);
 			printk(KERN_ERR
-			       "%s: acpi_get_parent() failed (0x%x) for: ",
-					__func__, status);
-			acpi_ns_print_node_pathname(handle, NULL);
-			printk("\n");
+			       "%s: acpi_get_parent() failed (0x%x) for: %s\n",
+				__func__, status, (char *)name_buffer.pointer);
+			kfree(name_buffer.pointer);
 			return AE_OK;
 		}
 		status = acpi_evaluate_integer(parent, METHOD_NAME__BBN,
 					       NULL, &bbn);
 		if (ACPI_FAILURE(status)) {
+			acpi_get_name(handle, ACPI_FULL_PATHNAME, &name_buffer);
 			printk(KERN_ERR
-			  "%s: Failed to find _BBN in parent of: ",
-					__func__);
-			acpi_ns_print_node_pathname(handle, NULL);
-			printk("\n");
+			  "%s: Failed to find _BBN in parent of: %s\n",
+					__func__, (char *)name_buffer.pointer);
+			kfree(name_buffer.pointer);
 			return AE_OK;
 		}
 
@@ -350,24 +357,27 @@ sn_acpi_get_pcidev_info(struct pci_dev *dev, struct pcidev_info **pcidev_info,
 	acpi_handle rootbus_handle;
 	unsigned long long segment;
 	acpi_status status;
+	struct acpi_buffer name_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 	rootbus_handle = PCI_CONTROLLER(dev)->acpi_handle;
         status = acpi_evaluate_integer(rootbus_handle, METHOD_NAME__SEG, NULL,
                                        &segment);
         if (ACPI_SUCCESS(status)) {
 		if (segment != pci_domain_nr(dev)) {
+			acpi_get_name(rootbus_handle, ACPI_FULL_PATHNAME,
+				&name_buffer);
 			printk(KERN_ERR
-			       "%s: Segment number mismatch, 0x%llx vs 0x%x for: ",
-			       __func__, segment, pci_domain_nr(dev));
-			acpi_ns_print_node_pathname(rootbus_handle, NULL);
-			printk("\n");
+			       "%s: Segment number mismatch, 0x%llx vs 0x%x for: %s\n",
+			       __func__, segment, pci_domain_nr(dev),
+			       (char *)name_buffer.pointer);
+			kfree(name_buffer.pointer);
 			return 1;
 		}
 	} else {
-		printk(KERN_ERR "%s: Unable to get __SEG from: ",
-		       __func__);
-		acpi_ns_print_node_pathname(rootbus_handle, NULL);
-		printk("\n");
+		acpi_get_name(rootbus_handle, ACPI_FULL_PATHNAME, &name_buffer);
+		printk(KERN_ERR "%s: Unable to get __SEG from: %s\n",
+		       __func__, (char *)name_buffer.pointer);
+		kfree(name_buffer.pointer);
 		return 1;
 	}
 
-- 
1.5.6.6

