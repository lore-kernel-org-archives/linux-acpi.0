From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/27] ACPICA: Resources: New interface, AcpiWalkResourceBuffer.
Date: Mon, 31 Dec 2012 08:03:58 +0800
Message-ID: <c689f959704330be4f0e794cdce256ac1f30ee85.1356668532.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49621 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAEK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:04:10 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Implements a new interface for walking resource lists that it at
a lower level than the existing AcpiWalkResources.  (Method is
not executed.)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/rsxface.c |  101 ++++++++++++++++++++++++++++-------------
 include/acpi/acpixf.h         |    5 ++
 include/acpi/actypes.h        |    4 ++
 3 files changed, 79 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index 3a5ace7..a4086aab 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -423,7 +423,7 @@ ACPI_EXPORT_SYMBOL(acpi_resource_to_address64)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Walk a resource template for the specified evice to find a
+ * DESCRIPTION: Walk a resource template for the specified device to find a
  *              vendor-defined resource that matches the supplied UUID and
  *              UUID subtype. Returns a struct acpi_resource of type Vendor.
  *
@@ -522,57 +522,42 @@ acpi_rs_match_vendor_resource(struct acpi_resource *resource, void *context)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_walk_resources
+ * FUNCTION:    acpi_walk_resource_buffer
  *
- * PARAMETERS:  device_handle   - Handle to the device object for the
- *                                device we are querying
- *              name            - Method name of the resources we want.
- *                                (METHOD_NAME__CRS, METHOD_NAME__PRS, or
- *                                METHOD_NAME__AEI)
+ * PARAMETERS:  buffer          - Formatted buffer returned by one of the
+ *                                various Get*Resource functions
  *              user_function   - Called for each resource
  *              context         - Passed to user_function
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Retrieves the current or possible resource list for the
- *              specified device. The user_function is called once for
- *              each resource in the list.
+ * DESCRIPTION: Walks the input resource template. The user_function is called
+ *              once for each resource in the list.
  *
  ******************************************************************************/
+
 acpi_status
-acpi_walk_resources(acpi_handle device_handle,
-		    char *name,
-		    acpi_walk_resource_callback user_function, void *context)
+acpi_walk_resource_buffer(struct acpi_buffer * buffer,
+			  acpi_walk_resource_callback user_function,
+			  void *context)
 {
-	acpi_status status;
-	struct acpi_buffer buffer;
+	acpi_status status = AE_OK;
 	struct acpi_resource *resource;
 	struct acpi_resource *resource_end;
 
-	ACPI_FUNCTION_TRACE(acpi_walk_resources);
+	ACPI_FUNCTION_TRACE(acpi_walk_resource_buffer);
 
 	/* Parameter validation */
 
-	if (!device_handle || !user_function || !name ||
-	    (!ACPI_COMPARE_NAME(name, METHOD_NAME__CRS) &&
-	     !ACPI_COMPARE_NAME(name, METHOD_NAME__PRS) &&
-	     !ACPI_COMPARE_NAME(name, METHOD_NAME__AEI))) {
+	if (!buffer || !buffer->pointer || !user_function) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Get the _CRS/_PRS/_AEI resource list */
-
-	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
-	status = acpi_rs_get_method_data(device_handle, name, &buffer);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/* Buffer now contains the resource list */
+	/* Buffer contains the resource list and length */
 
-	resource = ACPI_CAST_PTR(struct acpi_resource, buffer.pointer);
+	resource = ACPI_CAST_PTR(struct acpi_resource, buffer->pointer);
 	resource_end =
-	    ACPI_ADD_PTR(struct acpi_resource, buffer.pointer, buffer.length);
+	    ACPI_ADD_PTR(struct acpi_resource, buffer->pointer, buffer->length);
 
 	/* Walk the resource list until the end_tag is found (or buffer end) */
 
@@ -609,6 +594,60 @@ acpi_walk_resources(acpi_handle device_handle,
 		resource = ACPI_NEXT_RESOURCE(resource);
 	}
 
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_walk_resource_buffer)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_walk_resources
+ *
+ * PARAMETERS:  device_handle   - Handle to the device object for the
+ *                                device we are querying
+ *              name            - Method name of the resources we want.
+ *                                (METHOD_NAME__CRS, METHOD_NAME__PRS, or
+ *                                METHOD_NAME__AEI)
+ *              user_function   - Called for each resource
+ *              context         - Passed to user_function
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Retrieves the current or possible resource list for the
+ *              specified device. The user_function is called once for
+ *              each resource in the list.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_walk_resources(acpi_handle device_handle,
+		    char *name,
+		    acpi_walk_resource_callback user_function, void *context)
+{
+	acpi_status status;
+	struct acpi_buffer buffer;
+
+	ACPI_FUNCTION_TRACE(acpi_walk_resources);
+
+	/* Parameter validation */
+
+	if (!device_handle || !user_function || !name ||
+	    (!ACPI_COMPARE_NAME(name, METHOD_NAME__CRS) &&
+	     !ACPI_COMPARE_NAME(name, METHOD_NAME__PRS) &&
+	     !ACPI_COMPARE_NAME(name, METHOD_NAME__AEI))) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	/* Get the _CRS/_PRS/_AEI resource list */
+
+	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
+	status = acpi_rs_get_method_data(device_handle, name, &buffer);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Walk the resource list and cleanup */
+
+	status = acpi_walk_resource_buffer(&buffer, user_function, context);
 	ACPI_FREE(buffer.pointer);
 	return_ACPI_STATUS(status);
 }
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 3c9c783..afacb5a 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -444,6 +444,11 @@ acpi_get_event_resources(acpi_handle device_handle,
 			 struct acpi_buffer *ret_buffer);
 
 acpi_status
+acpi_walk_resource_buffer(struct acpi_buffer *buffer,
+			  acpi_walk_resource_callback user_function,
+			  void *context);
+
+acpi_status
 acpi_walk_resources(acpi_handle device,
 		    char *name,
 		    acpi_walk_resource_callback user_function, void *context);
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 6882227..3de70ed 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -881,6 +881,10 @@ struct acpi_buffer {
 	void *pointer;		/* pointer to buffer */
 };
 
+/* Free a buffer created in an struct acpi_buffer via ACPI_ALLOCATE_LOCAL_BUFFER */
+
+#define ACPI_FREE_BUFFER(b)         ACPI_FREE(b.pointer)
+
 /*
  * name_type for acpi_get_name
  */
-- 
1.7.10

