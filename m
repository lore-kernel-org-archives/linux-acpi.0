From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/6] ACPICA: Resources: Fix loop termination for the get AML length function.
Date: Thu, 21 Nov 2013 12:17:34 +0800
Message-ID: <b6242ac52c48aed0300aae453c6581b4c992a88e.1384747397.git.lv.zheng@intel.com>
References: <cover.1384747396.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53209 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456Ab3KUESS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Nov 2013 23:18:18 -0500
In-Reply-To: <cover.1384747396.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

The loop terminates on a NULL resource pointer, which can never happen
since the loop simply increments a valid resource pointer. This fix
changes the loop to terminate on an end-of-buffer condition.

Problem can be seen by callers to AcpiSetCurrentResources with an invalid
or corrupted resource descriptor; or a resource descriptor without an
END_TAG descriptor.

(refined by Bob Moore)
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acresrc.h  |    6 +++---
 drivers/acpi/acpica/rscalc.c   |    9 +++++++--
 drivers/acpi/acpica/rscreate.c |   36 +++++++++++++++++-------------------
 drivers/acpi/acpica/rsutils.c  |    2 +-
 4 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index f691d0e..ff97430 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -184,7 +184,7 @@ acpi_rs_create_resource_list(union acpi_operand_object *aml_buffer,
 			     struct acpi_buffer *output_buffer);
 
 acpi_status
-acpi_rs_create_aml_resources(struct acpi_resource *linked_list_buffer,
+acpi_rs_create_aml_resources(struct acpi_buffer *resource_list,
 			     struct acpi_buffer *output_buffer);
 
 acpi_status
@@ -227,8 +227,8 @@ acpi_rs_get_list_length(u8 * aml_buffer,
 			u32 aml_buffer_length, acpi_size * size_needed);
 
 acpi_status
-acpi_rs_get_aml_length(struct acpi_resource *linked_list_buffer,
-		       acpi_size * size_needed);
+acpi_rs_get_aml_length(struct acpi_resource *resource_list,
+		       acpi_size resource_list_size, acpi_size * size_needed);
 
 acpi_status
 acpi_rs_get_pci_routing_table_length(union acpi_operand_object *package_object,
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index b62a0f4..b60c9cf 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -174,6 +174,7 @@ acpi_rs_stream_option_length(u32 resource_length,
  * FUNCTION:    acpi_rs_get_aml_length
  *
  * PARAMETERS:  resource            - Pointer to the resource linked list
+ *              resource_list_size  - Size of the resource linked list
  *              size_needed         - Where the required size is returned
  *
  * RETURN:      Status
@@ -185,16 +186,20 @@ acpi_rs_stream_option_length(u32 resource_length,
  ******************************************************************************/
 
 acpi_status
-acpi_rs_get_aml_length(struct acpi_resource * resource, acpi_size * size_needed)
+acpi_rs_get_aml_length(struct acpi_resource *resource,
+		       acpi_size resource_list_size, acpi_size * size_needed)
 {
 	acpi_size aml_size_needed = 0;
+	struct acpi_resource *resource_end;
 	acpi_rs_length total_size;
 
 	ACPI_FUNCTION_TRACE(rs_get_aml_length);
 
 	/* Traverse entire list of internal resource descriptors */
 
-	while (resource) {
+	resource_end =
+	    ACPI_ADD_PTR(struct acpi_resource, resource, resource_list_size);
+	while (resource < resource_end) {
 
 		/* Validate the descriptor type */
 
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index 65f3e1c..3a2ace9 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -418,22 +418,21 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
  *
  * FUNCTION:    acpi_rs_create_aml_resources
  *
- * PARAMETERS:  linked_list_buffer      - Pointer to the resource linked list
- *              output_buffer           - Pointer to the user's buffer
+ * PARAMETERS:  resource_list           - Pointer to the resource list buffer
+ *              output_buffer           - Where the AML buffer is returned
  *
  * RETURN:      Status  AE_OK if okay, else a valid acpi_status code.
  *              If the output_buffer is too small, the error will be
  *              AE_BUFFER_OVERFLOW and output_buffer->Length will point
  *              to the size buffer needed.
  *
- * DESCRIPTION: Takes the linked list of device resources and
- *              creates a bytestream to be used as input for the
- *              _SRS control method.
+ * DESCRIPTION: Converts a list of device resources to an AML bytestream
+ *              to be used as input for the _SRS control method.
  *
  ******************************************************************************/
 
 acpi_status
-acpi_rs_create_aml_resources(struct acpi_resource *linked_list_buffer,
+acpi_rs_create_aml_resources(struct acpi_buffer *resource_list,
 			     struct acpi_buffer *output_buffer)
 {
 	acpi_status status;
@@ -441,16 +440,16 @@ acpi_rs_create_aml_resources(struct acpi_resource *linked_list_buffer,
 
 	ACPI_FUNCTION_TRACE(rs_create_aml_resources);
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "LinkedListBuffer = %p\n",
-			  linked_list_buffer));
+	/* Params already validated, no need to re-validate here */
 
-	/*
-	 * Params already validated, so we don't re-validate here
-	 *
-	 * Pass the linked_list_buffer into a module that calculates
-	 * the buffer size needed for the byte stream.
-	 */
-	status = acpi_rs_get_aml_length(linked_list_buffer, &aml_size_needed);
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "ResourceList Buffer = %p\n",
+			  resource_list->pointer));
+
+	/* Get the buffer size needed for the AML byte stream */
+
+	status = acpi_rs_get_aml_length(resource_list->pointer,
+					resource_list->length,
+					&aml_size_needed);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "AmlSizeNeeded=%X, %s\n",
 			  (u32)aml_size_needed, acpi_format_exception(status)));
@@ -467,10 +466,9 @@ acpi_rs_create_aml_resources(struct acpi_resource *linked_list_buffer,
 
 	/* Do the conversion */
 
-	status =
-	    acpi_rs_convert_resources_to_aml(linked_list_buffer,
-					     aml_size_needed,
-					     output_buffer->pointer);
+	status = acpi_rs_convert_resources_to_aml(resource_list->pointer,
+						  aml_size_needed,
+						  output_buffer->pointer);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index aef303d..14a7982 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -753,7 +753,7 @@ acpi_rs_set_srs_method_data(struct acpi_namespace_node *node,
 	 * Convert the linked list into a byte stream
 	 */
 	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
-	status = acpi_rs_create_aml_resources(in_buffer->pointer, &buffer);
+	status = acpi_rs_create_aml_resources(in_buffer, &buffer);
 	if (ACPI_FAILURE(status)) {
 		goto cleanup;
 	}
-- 
1.7.10

