From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 2/3]cleanup pci root _OSC
Date: Thu, 29 Oct 2009 11:04:50 +0800
Message-ID: <20091029030450.GB5150@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2536 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299AbZJ2DEy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Oct 2009 23:04:54 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, bjorn.helgaas@hp.com, kaneshige.kenji@jp.fujitsu.com, aystarik@gmail.com

Cleanup pci_root _OSC code.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/pci_root.c |   76 ++++++++----------------------------------------
 include/linux/acpi.h    |    5 +--
 2 files changed, 17 insertions(+), 64 deletions(-)

Index: linux/drivers/acpi/pci_root.c
===================================================================
--- linux.orig/drivers/acpi/pci_root.c	2009-10-28 11:03:12.000000000 +0800
+++ linux/drivers/acpi/pci_root.c	2009-10-29 10:30:59.000000000 +0800
@@ -202,72 +202,24 @@ static void acpi_pci_bridge_scan(struct 
 		}
 }
 
-static u8 OSC_UUID[16] = {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40,
-			  0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
+static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
 
 static acpi_status acpi_pci_run_osc(acpi_handle handle,
 				    const u32 *capbuf, u32 *retval)
 {
+	struct acpi_osc_context context = {
+		.uuid_str = pci_osc_uuid_str,
+		.rev = 1,
+		.cap.length = 12,
+		.cap.pointer = (void *)capbuf,
+	};
 	acpi_status status;
-	struct acpi_object_list input;
-	union acpi_object in_params[4];
-	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
-	union acpi_object *out_obj;
-	u32 errors;
-
-	/* Setting up input parameters */
-	input.count = 4;
-	input.pointer = in_params;
-	in_params[0].type 		= ACPI_TYPE_BUFFER;
-	in_params[0].buffer.length 	= 16;
-	in_params[0].buffer.pointer	= OSC_UUID;
-	in_params[1].type 		= ACPI_TYPE_INTEGER;
-	in_params[1].integer.value 	= 1;
-	in_params[2].type 		= ACPI_TYPE_INTEGER;
-	in_params[2].integer.value	= 3;
-	in_params[3].type		= ACPI_TYPE_BUFFER;
-	in_params[3].buffer.length 	= 12;
-	in_params[3].buffer.pointer 	= (u8 *)capbuf;
 
-	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
-	if (ACPI_FAILURE(status))
-		return status;
-
-	if (!output.length)
-		return AE_NULL_OBJECT;
-
-	out_obj = output.pointer;
-	if (out_obj->type != ACPI_TYPE_BUFFER) {
-		printk(KERN_DEBUG "_OSC evaluation returned wrong type\n");
-		status = AE_TYPE;
-		goto out_kfree;
-	}
-	/* Need to ignore the bit0 in result code */
-	errors = *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
-	if (errors) {
-		if (errors & OSC_REQUEST_ERROR)
-			printk(KERN_DEBUG "_OSC request failed\n");
-		if (errors & OSC_INVALID_UUID_ERROR)
-			printk(KERN_DEBUG "_OSC invalid UUID\n");
-		if (errors & OSC_INVALID_REVISION_ERROR)
-			printk(KERN_DEBUG "_OSC invalid revision\n");
-		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
-			if (capbuf[OSC_QUERY_TYPE] & OSC_QUERY_ENABLE)
-				goto out_success;
-			printk(KERN_DEBUG
-			       "Firmware did not grant requested _OSC control\n");
-			status = AE_SUPPORT;
-			goto out_kfree;
-		}
-		status = AE_ERROR;
-		goto out_kfree;
+	status = acpi_run_osc(handle, &context);
+	if (ACPI_SUCCESS(status)) {
+		*retval = *((u32 *)(context.ret.pointer + 8));
+		kfree(context.ret.pointer);
 	}
-out_success:
-	*retval = *((u32 *)(out_obj->buffer.pointer + 8));
-	status = AE_OK;
-
-out_kfree:
-	kfree(output.pointer);
 	return status;
 }
 
@@ -277,10 +229,10 @@ static acpi_status acpi_pci_query_osc(st
 	u32 support_set, result, capbuf[3];
 
 	/* do _OSC query for all possible controls */
-	support_set = root->osc_support_set | (flags & OSC_SUPPORT_MASKS);
+	support_set = root->osc_support_set | (flags & OSC_PCI_SUPPORT_MASKS);
 	capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
 	capbuf[OSC_SUPPORT_TYPE] = support_set;
-	capbuf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;
+	capbuf[OSC_CONTROL_TYPE] = OSC_PCI_CONTROL_MASKS;
 
 	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
 	if (ACPI_SUCCESS(status)) {
@@ -427,7 +379,7 @@ acpi_status acpi_pci_osc_control_set(acp
 	if (ACPI_FAILURE(status))
 		return status;
 
-	control_req = (flags & OSC_CONTROL_MASKS);
+	control_req = (flags & OSC_PCI_CONTROL_MASKS);
 	if (!control_req)
 		return AE_TYPE;
 
Index: linux/include/linux/acpi.h
===================================================================
--- linux.orig/include/linux/acpi.h	2009-10-29 09:21:21.000000000 +0800
+++ linux/include/linux/acpi.h	2009-10-29 10:37:51.000000000 +0800
@@ -263,7 +263,6 @@ struct acpi_osc_context {
 #define OSC_QUERY_TYPE			0
 #define OSC_SUPPORT_TYPE 		1
 #define OSC_CONTROL_TYPE		2
-#define OSC_SUPPORT_MASKS		0x1f
 
 /* _OSC DW0 Definition */
 #define OSC_QUERY_ENABLE		1
@@ -274,12 +273,14 @@ struct acpi_osc_context {
 
 acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 
+/* PCI defined _OSC bits */
 /* _OSC DW1 Definition (OS Support Fields) */
 #define OSC_EXT_PCI_CONFIG_SUPPORT		1
 #define OSC_ACTIVE_STATE_PWR_SUPPORT 		2
 #define OSC_CLOCK_PWR_CAPABILITY_SUPPORT	4
 #define OSC_PCI_SEGMENT_GROUPS_SUPPORT		8
 #define OSC_MSI_SUPPORT				16
+#define OSC_PCI_SUPPORT_MASKS			0x1f
 
 /* _OSC DW1 Definition (OS Control Fields) */
 #define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL	1
@@ -288,7 +289,7 @@ acpi_status acpi_run_osc(acpi_handle han
 #define OSC_PCI_EXPRESS_AER_CONTROL		8
 #define OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL	16
 
-#define OSC_CONTROL_MASKS 	(OSC_PCI_EXPRESS_NATIVE_HP_CONTROL | 	\
+#define OSC_PCI_CONTROL_MASKS 	(OSC_PCI_EXPRESS_NATIVE_HP_CONTROL | 	\
 				OSC_SHPC_NATIVE_HP_CONTROL | 		\
 				OSC_PCI_EXPRESS_PME_CONTROL |		\
 				OSC_PCI_EXPRESS_AER_CONTROL |		\
