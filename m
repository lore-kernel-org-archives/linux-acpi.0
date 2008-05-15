From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 2/5] pci-acpi: use local buffer for _OSC
Date: Thu, 15 May 2008 15:20:11 +0900
Message-ID: <482BD61B.5020202@jp.fujitsu.com>
References: <482BD572.30504@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:36252 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755752AbYEOGVS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 May 2008 02:21:18 -0400
In-Reply-To: <482BD572.30504@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>

Current pci-acpi implementation uses array in osc_data directly to
evaluate _OSC. It needs to save the old data and restore it if _OSC
evaluation fails. To make it more robust, we should use local array to
evaluate _OSC.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/pci-acpi.c |   73 ++++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 34 deletions(-)

Index: linux-2.6.26-rc2-git3/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.26-rc2-git3.orig/drivers/pci/pci-acpi.c
+++ linux-2.6.26-rc2-git3/drivers/pci/pci-acpi.c
@@ -21,12 +21,18 @@
 
 struct acpi_osc_data {
 	acpi_handle handle;
-	u32 ctrlset_buf[3];
-	u32 global_ctrlsets;
+	u32 support_set;
+	u32 control_set;
+	u32 query_result;
 	struct list_head sibiling;
 };
 static LIST_HEAD(acpi_osc_data_list);
 
+struct acpi_osc_args {
+	u32 capbuf[3];
+	u32 query_result;
+};
+
 static struct acpi_osc_data *acpi_get_osc_data(acpi_handle handle)
 {
 	struct acpi_osc_data *data;
@@ -47,14 +53,14 @@ static struct acpi_osc_data *acpi_get_os
 static u8 OSC_UUID[16] = {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
 
 static acpi_status acpi_run_osc(acpi_handle handle,
-				struct acpi_osc_data *osc_data)
+				struct acpi_osc_args *osc_args)
 {
 	acpi_status status;
 	struct acpi_object_list input;
 	union acpi_object in_params[4];
 	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object *out_obj;
-	u32 osc_dw0, flags = osc_data->ctrlset_buf[OSC_QUERY_TYPE];
+	u32 osc_dw0, flags = osc_args->capbuf[OSC_QUERY_TYPE];
 
 	/* Setting up input parameters */
 	input.count = 4;
@@ -68,7 +74,7 @@ static acpi_status acpi_run_osc(acpi_han
 	in_params[2].integer.value	= 3;
 	in_params[3].type		= ACPI_TYPE_BUFFER;
 	in_params[3].buffer.length 	= 12;
-	in_params[3].buffer.pointer 	= (u8 *)osc_data->ctrlset_buf;
+	in_params[3].buffer.pointer 	= (u8 *)osc_args->capbuf;
 
 	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
 	if (ACPI_FAILURE(status))
@@ -99,11 +105,9 @@ static acpi_status acpi_run_osc(acpi_han
 		goto out_kfree;
 	}
 out_success:
-	if (flags & OSC_QUERY_ENABLE) {
-		/* Update Global Control Set */
-		osc_data->global_ctrlsets =
+	if (flags & OSC_QUERY_ENABLE)
+		osc_args->query_result =
 			*((u32 *)(out_obj->buffer.pointer + 8));
-	}
 	status = AE_OK;
 
 out_kfree:
@@ -117,8 +121,9 @@ static acpi_status acpi_query_osc(acpi_h
 	acpi_status status;
 	acpi_status *ret_status = (acpi_status *)retval;
 	struct acpi_osc_data *osc_data;
-	u32 flags = (unsigned long)context, temp;
+	u32 flags = (unsigned long)context, support_set;
 	acpi_handle tmp;
+	struct acpi_osc_args osc_args;
 
 	status = acpi_get_handle(handle, "_OSC", &tmp);
 	if (ACPI_FAILURE(status))
@@ -130,21 +135,18 @@ static acpi_status acpi_query_osc(acpi_h
 		return AE_ERROR;
 	}
 
-	osc_data->ctrlset_buf[OSC_SUPPORT_TYPE] |= (flags & OSC_SUPPORT_MASKS);
-
 	/* do _OSC query for all possible controls */
-	temp = osc_data->ctrlset_buf[OSC_CONTROL_TYPE];
-	osc_data->ctrlset_buf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
-	osc_data->ctrlset_buf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;
+	support_set = osc_data->support_set | (flags & OSC_SUPPORT_MASKS);
+	osc_args.capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
+	osc_args.capbuf[OSC_SUPPORT_TYPE] = support_set;
+	osc_args.capbuf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;
 
-	status = acpi_run_osc(handle, osc_data);
+	status = acpi_run_osc(handle, &osc_args);
 	*ret_status = status;
 
-	osc_data->ctrlset_buf[OSC_QUERY_TYPE] = !OSC_QUERY_ENABLE;
-	osc_data->ctrlset_buf[OSC_CONTROL_TYPE] = temp;
-	if (ACPI_FAILURE(status)) {
-		/* no osc support at all */
-		osc_data->ctrlset_buf[OSC_SUPPORT_TYPE] = 0;
+	if (ACPI_SUCCESS(status)) {
+		osc_data->support_set = support_set;
+		osc_data->query_result = osc_args.query_result;
 	}
 
 	return status;
@@ -181,10 +183,11 @@ acpi_status __pci_osc_support_set(u32 fl
  **/
 acpi_status pci_osc_control_set(acpi_handle handle, u32 flags)
 {
-	acpi_status	status;
-	u32		ctrlset;
+	acpi_status status;
+	u32 ctrlset, control_set;
 	acpi_handle tmp;
 	struct acpi_osc_data *osc_data;
+	struct acpi_osc_args osc_args;
 
 	status = acpi_get_handle(handle, "_OSC", &tmp);
 	if (ACPI_FAILURE(status))
@@ -197,19 +200,21 @@ acpi_status pci_osc_control_set(acpi_han
 	}
 
 	ctrlset = (flags & OSC_CONTROL_MASKS);
-	if (!ctrlset) {
+	if (!ctrlset)
 		return AE_TYPE;
-	}
-	if (osc_data->ctrlset_buf[OSC_SUPPORT_TYPE] &&
-		((osc_data->global_ctrlsets & ctrlset) != ctrlset)) {
+
+	if (osc_data->support_set &&
+	    ((osc_data->query_result & ctrlset) != ctrlset))
 		return AE_SUPPORT;
-	}
-	osc_data->ctrlset_buf[OSC_CONTROL_TYPE] |= ctrlset;
-	status = acpi_run_osc(handle, osc_data);
-	if (ACPI_FAILURE (status)) {
-		osc_data->ctrlset_buf[OSC_CONTROL_TYPE] &= ~ctrlset;
-	}
-	
+
+	control_set = osc_data->control_set | ctrlset;
+	osc_args.capbuf[OSC_QUERY_TYPE] = 0;
+	osc_args.capbuf[OSC_SUPPORT_TYPE] = osc_data->support_set;
+	osc_args.capbuf[OSC_CONTROL_TYPE] = control_set;
+	status = acpi_run_osc(handle, &osc_args);
+	if (ACPI_SUCCESS(status))
+		osc_data->control_set = control_set;
+
 	return status;
 }
 EXPORT_SYMBOL(pci_osc_control_set);


