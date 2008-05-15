From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 1/5] pci-acpi: remove duplicate code for _OSC
Date: Thu, 15 May 2008 15:18:53 +0900
Message-ID: <482BD5CD.6090705@jp.fujitsu.com>
References: <482BD572.30504@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:45382 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbYEOGV0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 May 2008 02:21:26 -0400
In-Reply-To: <482BD572.30504@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>

Remove the duplicated code in acpi_query_osc() and acpi_run_osc().
It simplifies the code very much.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/pci-acpi.c |  165 ++++++++++++++++---------------------------------
 1 file changed, 55 insertions(+), 110 deletions(-)

Index: linux-2.6.26-rc2-git3/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.26-rc2-git3.orig/drivers/pci/pci-acpi.c
+++ linux-2.6.26-rc2-git3/drivers/pci/pci-acpi.c
@@ -46,40 +46,15 @@ static struct acpi_osc_data *acpi_get_os
 
 static u8 OSC_UUID[16] = {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
 
-static acpi_status  
-acpi_query_osc (
-	acpi_handle	handle,
-	u32		level,
-	void		*context,
-	void		**retval )
+static acpi_status acpi_run_osc(acpi_handle handle,
+				struct acpi_osc_data *osc_data)
 {
-	acpi_status		status;
-	struct acpi_object_list	input;
-	union acpi_object 	in_params[4];
-	struct acpi_buffer	output = {ACPI_ALLOCATE_BUFFER, NULL};
-	union acpi_object 	*out_obj;
-	u32			osc_dw0;
-	acpi_status *ret_status = (acpi_status *)retval;
-	struct acpi_osc_data *osc_data;
-	u32 flags = (unsigned long)context, temp;
-	acpi_handle tmp;
-
-	status = acpi_get_handle(handle, "_OSC", &tmp);
-	if (ACPI_FAILURE(status))
-		return status;
-
-	osc_data = acpi_get_osc_data(handle);
-	if (!osc_data) {
-		printk(KERN_ERR "acpi osc data array is full\n");
-		return AE_ERROR;
-	}
-
-	osc_data->ctrlset_buf[OSC_SUPPORT_TYPE] |= (flags & OSC_SUPPORT_MASKS);
-
-	/* do _OSC query for all possible controls */
-	temp = osc_data->ctrlset_buf[OSC_CONTROL_TYPE];
-	osc_data->ctrlset_buf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
-	osc_data->ctrlset_buf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;
+	acpi_status status;
+	struct acpi_object_list input;
+	union acpi_object in_params[4];
+	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *out_obj;
+	u32 osc_dw0, flags = osc_data->ctrlset_buf[OSC_QUERY_TYPE];
 
 	/* Setting up input parameters */
 	input.count = 4;
@@ -97,14 +72,13 @@ acpi_query_osc (
 
 	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
 	if (ACPI_FAILURE(status))
-		goto out_nofree;
-	out_obj = output.pointer;
+		return status;
 
+	out_obj = output.pointer;
 	if (out_obj->type != ACPI_TYPE_BUFFER) {
-		printk(KERN_DEBUG  
-			"Evaluate _OSC returns wrong type\n");
+		printk(KERN_DEBUG "Evaluate _OSC returns wrong type\n");
 		status = AE_TYPE;
-		goto query_osc_out;
+		goto out_kfree;
 	}
 	osc_dw0 = *((u32 *) out_obj->buffer.pointer);
 	if (osc_dw0) {
@@ -115,93 +89,64 @@ acpi_query_osc (
 		if (osc_dw0 & OSC_INVALID_REVISION_ERROR)
 			printk(KERN_DEBUG "_OSC invalid revision\n"); 
 		if (osc_dw0 & OSC_CAPABILITIES_MASK_ERROR) {
-			/* Update Global Control Set */
-			osc_data->global_ctrlsets =
-				*((u32 *)(out_obj->buffer.pointer + 8));
-			status = AE_OK;
-			goto query_osc_out;
+			if (flags & OSC_QUERY_ENABLE)
+				goto out_success;
+			printk(KERN_DEBUG "_OSC FW not grant req. control\n");
+			status = AE_SUPPORT;
+			goto out_kfree;
 		}
 		status = AE_ERROR;
-		goto query_osc_out;
+		goto out_kfree;
+	}
+out_success:
+	if (flags & OSC_QUERY_ENABLE) {
+		/* Update Global Control Set */
+		osc_data->global_ctrlsets =
+			*((u32 *)(out_obj->buffer.pointer + 8));
 	}
-
-	/* Update Global Control Set */
-	osc_data->global_ctrlsets = *((u32 *)(out_obj->buffer.pointer + 8));
 	status = AE_OK;
 
-query_osc_out:
+out_kfree:
 	kfree(output.pointer);
-out_nofree:
-	*ret_status = status;
-
-	osc_data->ctrlset_buf[OSC_QUERY_TYPE] = !OSC_QUERY_ENABLE;
-	osc_data->ctrlset_buf[OSC_CONTROL_TYPE] = temp;
-	if (ACPI_FAILURE(status)) {
-		/* no osc support at all */
-		osc_data->ctrlset_buf[OSC_SUPPORT_TYPE] = 0;
-	}
-
 	return status;
 }
 
-
-static acpi_status  
-acpi_run_osc (
-	acpi_handle	handle,
-	void		*context)
+static acpi_status acpi_query_osc(acpi_handle handle,
+				  u32 level, void *context, void **retval)
 {
-	acpi_status		status;
-	struct acpi_object_list	input;
-	union acpi_object 	in_params[4];
-	struct acpi_buffer	output = {ACPI_ALLOCATE_BUFFER, NULL};
-	union acpi_object 	*out_obj;
-	u32			osc_dw0;
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
-	in_params[3].buffer.pointer 	= (u8 *)context;
+	acpi_status status;
+	acpi_status *ret_status = (acpi_status *)retval;
+	struct acpi_osc_data *osc_data;
+	u32 flags = (unsigned long)context, temp;
+	acpi_handle tmp;
 
-	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
-	if (ACPI_FAILURE (status))
+	status = acpi_get_handle(handle, "_OSC", &tmp);
+	if (ACPI_FAILURE(status))
 		return status;
 
-	out_obj = output.pointer;
-	if (out_obj->type != ACPI_TYPE_BUFFER) {
-		printk(KERN_DEBUG  
-			"Evaluate _OSC returns wrong type\n");
-		status = AE_TYPE;
-		goto run_osc_out;
+	osc_data = acpi_get_osc_data(handle);
+	if (!osc_data) {
+		printk(KERN_ERR "acpi osc data array is full\n");
+		return AE_ERROR;
 	}
-	osc_dw0 = *((u32 *) out_obj->buffer.pointer);
-	if (osc_dw0) {
-		if (osc_dw0 & OSC_REQUEST_ERROR)
-			printk(KERN_DEBUG "_OSC request fails\n"); 
-		if (osc_dw0 & OSC_INVALID_UUID_ERROR)
-			printk(KERN_DEBUG "_OSC invalid UUID\n"); 
-		if (osc_dw0 & OSC_INVALID_REVISION_ERROR)
-			printk(KERN_DEBUG "_OSC invalid revision\n"); 
-		if (osc_dw0 & OSC_CAPABILITIES_MASK_ERROR) {
-			printk(KERN_DEBUG "_OSC FW not grant req. control\n");
-			status = AE_SUPPORT;
-			goto run_osc_out;
-		}
-		status = AE_ERROR;
-		goto run_osc_out;
+
+	osc_data->ctrlset_buf[OSC_SUPPORT_TYPE] |= (flags & OSC_SUPPORT_MASKS);
+
+	/* do _OSC query for all possible controls */
+	temp = osc_data->ctrlset_buf[OSC_CONTROL_TYPE];
+	osc_data->ctrlset_buf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
+	osc_data->ctrlset_buf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;
+
+	status = acpi_run_osc(handle, osc_data);
+	*ret_status = status;
+
+	osc_data->ctrlset_buf[OSC_QUERY_TYPE] = !OSC_QUERY_ENABLE;
+	osc_data->ctrlset_buf[OSC_CONTROL_TYPE] = temp;
+	if (ACPI_FAILURE(status)) {
+		/* no osc support at all */
+		osc_data->ctrlset_buf[OSC_SUPPORT_TYPE] = 0;
 	}
-	status = AE_OK;
 
-run_osc_out:
-	kfree(output.pointer);
 	return status;
 }
 
@@ -260,7 +205,7 @@ acpi_status pci_osc_control_set(acpi_han
 		return AE_SUPPORT;
 	}
 	osc_data->ctrlset_buf[OSC_CONTROL_TYPE] |= ctrlset;
-	status = acpi_run_osc(handle, osc_data->ctrlset_buf);
+	status = acpi_run_osc(handle, osc_data);
 	if (ACPI_FAILURE (status)) {
 		osc_data->ctrlset_buf[OSC_CONTROL_TYPE] &= ~ctrlset;
 	}


