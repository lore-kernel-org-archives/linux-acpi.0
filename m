From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/18] ACPI 5.0: New interface, acpi_buffer_to_resource
Date: Sun, 11 Dec 2011 12:45:45 -0500
Message-ID: <95de2215ae526dd1b5176724d8f12a47883837b1.1323625426.git.len.brown@intel.com>
References: <1323625549-10775-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36856 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930Ab1LKS0j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Dec 2011 13:26:39 -0500
Received: from localhost.localdomain ([unknown] [74.104.158.190])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LW10020XXWDDIBB@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 11 Dec 2011 12:26:39 -0600 (CST)
In-reply-to: <1323625549-10775-1-git-send-email-lenb@kernel.org>
In-reply-to: <d40ba5ad56e98f9ff96c110a0fd4e8382b82229d.1323625426.git.len.brown@intel.com>
References: <d40ba5ad56e98f9ff96c110a0fd4e8382b82229d.1323625426.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This interface converts an AML buffer to an internal ACPI_RESOURCE.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/rscreate.c |   64 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h          |    5 +++
 2 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index f61285d..06264e8 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -51,6 +51,70 @@ ACPI_MODULE_NAME("rscreate")
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_buffer_to_resource
+ *
+ * PARAMETERS:  aml_buffer          - Pointer to the resource byte stream
+ *              aml_buffer_length   - Length of the aml_buffer
+ *              resource_ptr        - Where the converted resource is returned
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Convert a raw AML buffer to a resource list
+ *
+ ******************************************************************************/
+acpi_status
+acpi_buffer_to_resource(u8 *aml_buffer,
+			u16 aml_buffer_length,
+			struct acpi_resource **resource_ptr)
+{
+	acpi_status status;
+	acpi_size list_size_needed;
+	void *resource;
+	void *current_resource_ptr;
+
+	/*
+	 * Note: we allow AE_AML_NO_RESOURCE_END_TAG, since an end tag
+	 * is not required here.
+	 */
+
+	/* Get the required length for the converted resource */
+
+	status = acpi_rs_get_list_length(aml_buffer, aml_buffer_length,
+					 &list_size_needed);
+	if (status == AE_AML_NO_RESOURCE_END_TAG) {
+		status = AE_OK;
+	}
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/* Allocate a buffer for the converted resource */
+
+	resource = ACPI_ALLOCATE_ZEROED(list_size_needed);
+	current_resource_ptr = resource;
+	if (!resource) {
+		return (AE_NO_MEMORY);
+	}
+
+	/* Perform the AML-to-Resource conversion */
+
+	status = acpi_ut_walk_aml_resources(aml_buffer, aml_buffer_length,
+					    acpi_rs_convert_aml_to_resources,
+					    &current_resource_ptr);
+	if (status == AE_AML_NO_RESOURCE_END_TAG) {
+		status = AE_OK;
+	}
+	if (ACPI_FAILURE(status)) {
+		ACPI_FREE(resource);
+	} else {
+		*resource_ptr = resource;
+	}
+
+	return (status);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_rs_create_resource_list
  *
  * PARAMETERS:  aml_buffer          - Pointer to the resource byte stream
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 726d937..5d8df1d 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -376,6 +376,11 @@ acpi_status
 acpi_resource_to_address64(struct acpi_resource *resource,
 			   struct acpi_resource_address64 *out);
 
+acpi_status
+acpi_buffer_to_resource(u8 *aml_buffer,
+			u16 aml_buffer_length,
+			struct acpi_resource **resource_ptr);
+
 /*
  * Hardware (ACPI device) interfaces
  */
-- 
1.7.7.rc0.72.g4b5ea

