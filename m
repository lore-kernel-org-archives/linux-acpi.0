From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/34] ACPI: fix OSC regression that caused aer and pciehp not
 to load
Date: Thu, 24 Dec 2009 01:23:52 -0500
Message-ID: <9dc130fccb874f2959ef313d7922d306dc6d4f75.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755322AbZLXTbS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:18 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:31:00 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

Executing _OSC returns a buffer, which has an acpi object in it.
Don't directly returns the buffer, instead, we return the acpi object's
buffer. This fixes a regression since caller of acpi_run_osc expects
an acpi object's buffer returned.

Tested-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 65f7e33..0c1ad31 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -397,6 +397,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 	union acpi_object *out_obj;
 	u8 uuid[16];
 	u32 errors;
+	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
 
 	if (!context)
 		return AE_ERROR;
@@ -419,16 +420,16 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 	in_params[3].buffer.length 	= context->cap.length;
 	in_params[3].buffer.pointer 	= context->cap.pointer;
 
-	status = acpi_evaluate_object(handle, "_OSC", &input, &context->ret);
+	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
 	if (ACPI_FAILURE(status))
 		return status;
 
-	/* return buffer should have the same length as cap buffer */
-	if (context->ret.length != context->cap.length)
+	if (!output.length)
 		return AE_NULL_OBJECT;
 
-	out_obj = context->ret.pointer;
-	if (out_obj->type != ACPI_TYPE_BUFFER) {
+	out_obj = output.pointer;
+	if (out_obj->type != ACPI_TYPE_BUFFER
+		|| out_obj->buffer.length != context->cap.length) {
 		acpi_print_osc_error(handle, context,
 			"_OSC evaluation returned wrong type");
 		status = AE_TYPE;
@@ -457,11 +458,20 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 		goto out_kfree;
 	}
 out_success:
-	return AE_OK;
+	context->ret.length = out_obj->buffer.length;
+	context->ret.pointer = kmalloc(context->ret.length, GFP_KERNEL);
+	if (!context->ret.pointer) {
+		status =  AE_NO_MEMORY;
+		goto out_kfree;
+	}
+	memcpy(context->ret.pointer, out_obj->buffer.pointer,
+		context->ret.length);
+	status =  AE_OK;
 
 out_kfree:
-	kfree(context->ret.pointer);
-	context->ret.pointer = NULL;
+	kfree(output.pointer);
+	if (status != AE_OK)
+		context->ret.pointer = NULL;
 	return status;
 }
 EXPORT_SYMBOL(acpi_run_osc);
-- 
1.6.0.6

