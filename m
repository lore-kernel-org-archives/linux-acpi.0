From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [patch] pci-acpi: handle multiple _OSC
Date: Fri, 09 May 2008 16:43:47 +0900
Message-ID: <482400B3.4020808@jp.fujitsu.com>
References: <1210238510.23649.2.camel@sli10-desk.sh.intel.com>	 <4822F80C.2060704@jp.fujitsu.com> <1210297604.8716.5.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:37942 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbYEIHot (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 May 2008 03:44:49 -0400
In-Reply-To: <1210297604.8716.5.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, linux acpi <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>

Hi,

One more thing, sorry.

+	if (osc_data->ctrlset_buf[OSC_SUPPORT_TYPE] && 

Trailing white space here.

Your patch is conflicting with the patch "PCI ACPI: fix uninitialized variable
in __pci_osc_support_set" that is currently in Jesse's tree. I'm attaching the
fixed one that removes the conflict. It also removes the trailing white space.
Please use it if necessary.

Thanks,
Kenji Kaneshige


There is an IA64 system here which have two pci root bridges with _OSC.
One _OSC disables SHPC control bit but the other not. Below patch makes
_OSC data per-device instead of one global, otherwise linux takes both
root bridges don't support SHPC.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

---
 drivers/pci/pci-acpi.c |   92 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 29 deletions(-)

Index: linux-2.6.26-rc1/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.26-rc1.orig/drivers/pci/pci-acpi.c
+++ linux-2.6.26-rc1/drivers/pci/pci-acpi.c
@@ -19,8 +19,29 @@
 #include <linux/pci-acpi.h>
 #include "pci.h"
 
-static u32 ctrlset_buf[3] = {0, 0, 0};
-static u32 global_ctrlsets = 0;
+#define MAX_ACPI_OSC 30 /* Should be enough */
+static struct acpi_osc_data {
+	acpi_handle handle;
+	u32 ctrlset_buf[3];
+	u32 global_ctrlsets;
+} acpi_osc_data_array[MAX_ACPI_OSC];
+
+static struct acpi_osc_data *acpi_get_osc_data(acpi_handle handle)
+{
+	int i;
+
+	for (i = 0; i < MAX_ACPI_OSC; i++) {
+		if (acpi_osc_data_array[i].handle == handle)
+			return &acpi_osc_data_array[i];
+		if (acpi_osc_data_array[i].handle == NULL)
+			break;
+	}
+	if (i >= MAX_ACPI_OSC)
+		return NULL;
+	acpi_osc_data_array[i].handle = handle;
+	return &acpi_osc_data_array[i];
+}
+
 static u8 OSC_UUID[16] = {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
 
 static acpi_status  
@@ -37,8 +58,21 @@ acpi_query_osc (
 	union acpi_object 	*out_obj;
 	u32			osc_dw0;
 	acpi_status *ret_status = (acpi_status *)retval;
+	struct acpi_osc_data *osc_data = acpi_get_osc_data(handle);
+	u32 flags = (unsigned long)context, temp;
+
+	if (!osc_data) {
+		printk(KERN_ERR "acpi osc data array is full\n");
+		return AE_ERROR;
+	}
+
+	osc_data->ctrlset_buf[OSC_SUPPORT_TYPE] |= (flags & OSC_SUPPORT_MASKS);
+
+	/* do _OSC query for all possible controls */
+	temp = osc_data->ctrlset_buf[OSC_CONTROL_TYPE];
+	osc_data->ctrlset_buf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
+	osc_data->ctrlset_buf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;
 
-	
 	/* Setting up input parameters */
 	input.count = 4;
 	input.pointer = in_params;
@@ -51,13 +85,11 @@ acpi_query_osc (
 	in_params[2].integer.value	= 3;
 	in_params[3].type		= ACPI_TYPE_BUFFER;
 	in_params[3].buffer.length 	= 12;
-	in_params[3].buffer.pointer 	= (u8 *)context;
+	in_params[3].buffer.pointer 	= (u8 *)osc_data->ctrlset_buf;
 
 	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
-	if (ACPI_FAILURE (status)) {
-		*ret_status = status;
-		return status;
-	}
+	if (ACPI_FAILURE (status))
+		goto out_nofree;
 	out_obj = output.pointer;
 
 	if (out_obj->type != ACPI_TYPE_BUFFER) {
@@ -76,7 +108,7 @@ acpi_query_osc (
 			printk(KERN_DEBUG "_OSC invalid revision\n"); 
 		if (osc_dw0 & OSC_CAPABILITIES_MASK_ERROR) {
 			/* Update Global Control Set */
-			global_ctrlsets = *((u32 *)(out_obj->buffer.pointer+8));
+			osc_data->global_ctrlsets = *((u32 *)(out_obj->buffer.pointer+8));
 			status = AE_OK;
 			goto query_osc_out;
 		}
@@ -85,12 +117,21 @@ acpi_query_osc (
 	}
 
 	/* Update Global Control Set */
-	global_ctrlsets = *((u32 *)(out_obj->buffer.pointer + 8));
+	osc_data->global_ctrlsets = *((u32 *)(out_obj->buffer.pointer + 8));
 	status = AE_OK;
 
 query_osc_out:
 	kfree(output.pointer);
+out_nofree:
 	*ret_status = status;
+
+	osc_data->ctrlset_buf[OSC_QUERY_TYPE] = !OSC_QUERY_ENABLE;
+	osc_data->ctrlset_buf[OSC_CONTROL_TYPE] = temp;
+	if (ACPI_FAILURE(status)) {
+		/* no osc support at all */
+		osc_data->ctrlset_buf[OSC_SUPPORT_TYPE] = 0;
+	}
+
 	return status;
 }
 
@@ -165,28 +206,15 @@ run_osc_out:
  **/
 acpi_status __pci_osc_support_set(u32 flags, const char *hid)
 {
-	u32 temp;
 	acpi_status retval = AE_NOT_FOUND;
 
 	if (!(flags & OSC_SUPPORT_MASKS)) {
 		return AE_TYPE;
 	}
-	ctrlset_buf[OSC_SUPPORT_TYPE] |= (flags & OSC_SUPPORT_MASKS);
-
-	/* do _OSC query for all possible controls */
-	temp = ctrlset_buf[OSC_CONTROL_TYPE];
-	ctrlset_buf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
-	ctrlset_buf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;
 	acpi_get_devices(hid,
 			acpi_query_osc,
-			ctrlset_buf,
+			(void *)(unsigned long)flags,
 			(void **) &retval );
-	ctrlset_buf[OSC_QUERY_TYPE] = !OSC_QUERY_ENABLE;
-	ctrlset_buf[OSC_CONTROL_TYPE] = temp;
-	if (ACPI_FAILURE(retval)) {
-		/* no osc support at all */
-		ctrlset_buf[OSC_SUPPORT_TYPE] = 0;
-	}
 	return AE_OK;
 }
 
@@ -201,19 +229,25 @@ acpi_status pci_osc_control_set(acpi_han
 {
 	acpi_status	status;
 	u32		ctrlset;
+	struct acpi_osc_data *osc_data = acpi_get_osc_data(handle);
+
+	if (!osc_data) {
+		printk(KERN_ERR "acpi osc data array is full\n");
+		return AE_ERROR;
+	}
 
 	ctrlset = (flags & OSC_CONTROL_MASKS);
 	if (!ctrlset) {
 		return AE_TYPE;
 	}
-	if (ctrlset_buf[OSC_SUPPORT_TYPE] && 
-	 	((global_ctrlsets & ctrlset) != ctrlset)) {
+	if (osc_data->ctrlset_buf[OSC_SUPPORT_TYPE] &&
+	 	((osc_data->global_ctrlsets & ctrlset) != ctrlset)) {
 		return AE_SUPPORT;
 	}
-	ctrlset_buf[OSC_CONTROL_TYPE] |= ctrlset;
-	status = acpi_run_osc(handle, ctrlset_buf);
+	osc_data->ctrlset_buf[OSC_CONTROL_TYPE] |= ctrlset;
+	status = acpi_run_osc(handle, osc_data->ctrlset_buf);
 	if (ACPI_FAILURE (status)) {
-		ctrlset_buf[OSC_CONTROL_TYPE] &= ~ctrlset;
+		osc_data->ctrlset_buf[OSC_CONTROL_TYPE] &= ~ctrlset;
 	}
 	
 	return status;


