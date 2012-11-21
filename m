From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/15] ACPICA: Debugger: Major update for the Disassemble<method> command.
Date: Wed, 21 Nov 2012 18:08:07 +0800
Message-ID: <073b1736284df7e732a93f7d3b2032f331d108ff.1353491653.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2279 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754127Ab2KUKIL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Nov 2012 05:08:11 -0500
In-Reply-To: <cover.1353491652.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

This command was downreved and did not properly disassemble control
methods with any reasonable complexity. This fix brings the command
up to the same level as the rest of the disassembler.  Adds one
new file, dmdeferred.c, which is existing code that is now common
with the main disassembler and the debugger disassembl command.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acdisasm.h |   10 ++++--
 drivers/acpi/acpica/acutils.h  |    7 ++--
 drivers/acpi/acpica/rscalc.c   |    4 ++-
 drivers/acpi/acpica/rscreate.c |    4 +--
 drivers/acpi/acpica/rslist.c   |    7 ++--
 drivers/acpi/acpica/utresrc.c  |   74 +++++++++++++++++++++-------------------
 6 files changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/acpica/acdisasm.h b/drivers/acpi/acpica/acdisasm.h
index 4294f58..5dcedba 100644
--- a/drivers/acpi/acpica/acdisasm.h
+++ b/drivers/acpi/acpica/acdisasm.h
@@ -490,9 +490,13 @@ u8 acpi_dm_is_string_buffer(union acpi_parse_object *op);
 u8 acpi_dm_is_pld_buffer(union acpi_parse_object *op);
 
 /*
- * dmextern
+ * dmdeferred
  */
+acpi_status acpi_dm_parse_deferred_ops(union acpi_parse_object *root);
 
+/*
+ * dmextern
+ */
 acpi_status acpi_dm_add_to_external_file_list(char *path_list);
 
 void acpi_dm_clear_external_file_list(void);
@@ -525,7 +529,9 @@ acpi_dm_resource_template(struct acpi_op_walk_info *info,
 			  union acpi_parse_object *op,
 			  u8 *byte_data, u32 byte_count);
 
-acpi_status acpi_dm_is_resource_template(union acpi_parse_object *op);
+acpi_status
+acpi_dm_is_resource_template(struct acpi_walk_state *walk_state,
+			     union acpi_parse_object *op);
 
 void acpi_dm_bit_list(u16 mask);
 
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index b0f5f92..6e51d193 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -535,12 +535,15 @@ acpi_ut_display_init_pathname(u8 type,
  * utresrc
  */
 acpi_status
-acpi_ut_walk_aml_resources(u8 *aml,
+acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
+			   u8 *aml,
 			   acpi_size aml_length,
 			   acpi_walk_aml_callback user_function,
 			   void **context);
 
-acpi_status acpi_ut_validate_resource(void *aml, u8 *return_index);
+acpi_status
+acpi_ut_validate_resource(struct acpi_walk_state *walk_state,
+			  void *aml, u8 *return_index);
 
 u32 acpi_ut_get_descriptor_length(void *aml);
 
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 4f39bd6..da178b4 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -407,7 +407,9 @@ acpi_rs_get_list_length(u8 * aml_buffer,
 
 		/* Validate the Resource Type and Resource Length */
 
-		status = acpi_ut_validate_resource(aml_buffer, &resource_index);
+		status =
+		    acpi_ut_validate_resource(NULL, aml_buffer,
+					      &resource_index);
 		if (ACPI_FAILURE(status)) {
 			/*
 			 * Exit on failure. Cannot continue because the descriptor length
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index 8133326..55e0908 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -98,7 +98,7 @@ acpi_buffer_to_resource(u8 *aml_buffer,
 
 	/* Perform the AML-to-Resource conversion */
 
-	status = acpi_ut_walk_aml_resources(aml_buffer, aml_buffer_length,
+	status = acpi_ut_walk_aml_resources(NULL, aml_buffer, aml_buffer_length,
 					    acpi_rs_convert_aml_to_resources,
 					    &current_resource_ptr);
 	if (status == AE_AML_NO_RESOURCE_END_TAG) {
@@ -174,7 +174,7 @@ acpi_rs_create_resource_list(union acpi_operand_object *aml_buffer,
 	/* Do the conversion */
 
 	resource = output_buffer->pointer;
-	status = acpi_ut_walk_aml_resources(aml_start, aml_buffer_length,
+	status = acpi_ut_walk_aml_resources(NULL, aml_start, aml_buffer_length,
 					    acpi_rs_convert_aml_to_resources,
 					    &resource);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index 8b64db9..83e6158 100644
--- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -217,9 +217,10 @@ acpi_rs_convert_resources_to_aml(struct acpi_resource *resource,
 
 		/* Perform final sanity check on the new AML resource descriptor */
 
-		status =
-		    acpi_ut_validate_resource(ACPI_CAST_PTR
-					      (union aml_resource, aml), NULL);
+		status = acpi_ut_validate_resource(NULL,
+						   ACPI_CAST_PTR(union
+								 aml_resource,
+								 aml), NULL);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index 7d0a1b5..546ea73 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -383,26 +383,16 @@ static const u8 acpi_gbl_resource_types[] = {
 	ACPI_VARIABLE_LENGTH	/* 0E *serial_bus */
 };
 
-/*
- * For the iASL compiler/disassembler, we don't want any error messages
- * because the disassembler uses the resource validation code to determine
- * if Buffer objects are actually Resource Templates.
- */
-#ifdef ACPI_ASL_COMPILER
-#define ACPI_RESOURCE_ERROR(plist)
-#else
-#define ACPI_RESOURCE_ERROR(plist)  ACPI_ERROR(plist)
-#endif
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_walk_aml_resources
  *
- * PARAMETERS:  aml             - Pointer to the raw AML resource template
- *              aml_length      - Length of the entire template
- *              user_function   - Called once for each descriptor found. If
- *                                NULL, a pointer to the end_tag is returned
- *              context         - Passed to user_function
+ * PARAMETERS:  walk_state          - Current walk info
+ * PARAMETERS:  aml                 - Pointer to the raw AML resource template
+ *              aml_length          - Length of the entire template
+ *              user_function       - Called once for each descriptor found. If
+ *                                    NULL, a pointer to the end_tag is returned
+ *              context             - Passed to user_function
  *
  * RETURN:      Status
  *
@@ -412,7 +402,8 @@ static const u8 acpi_gbl_resource_types[] = {
  ******************************************************************************/
 
 acpi_status
-acpi_ut_walk_aml_resources(u8 *aml,
+acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
+			   u8 *aml,
 			   acpi_size aml_length,
 			   acpi_walk_aml_callback user_function, void **context)
 {
@@ -441,7 +432,8 @@ acpi_ut_walk_aml_resources(u8 *aml,
 
 		/* Validate the Resource Type and Resource Length */
 
-		status = acpi_ut_validate_resource(aml, &resource_index);
+		status =
+		    acpi_ut_validate_resource(walk_state, aml, &resource_index);
 		if (ACPI_FAILURE(status)) {
 			/*
 			 * Exit on failure. Cannot continue because the descriptor length
@@ -498,7 +490,8 @@ acpi_ut_walk_aml_resources(u8 *aml,
 
 		/* Insert an end_tag anyway. acpi_rs_get_list_length always leaves room */
 
-		(void)acpi_ut_validate_resource(end_tag, &resource_index);
+		(void)acpi_ut_validate_resource(walk_state, end_tag,
+						&resource_index);
 		status =
 		    user_function(end_tag, 2, offset, resource_index, context);
 		if (ACPI_FAILURE(status)) {
@@ -513,9 +506,10 @@ acpi_ut_walk_aml_resources(u8 *aml,
  *
  * FUNCTION:    acpi_ut_validate_resource
  *
- * PARAMETERS:  aml             - Pointer to the raw AML resource descriptor
- *              return_index    - Where the resource index is returned. NULL
- *                                if the index is not required.
+ * PARAMETERS:  walk_state          - Current walk info
+ *              aml                 - Pointer to the raw AML resource descriptor
+ *              return_index        - Where the resource index is returned. NULL
+ *                                    if the index is not required.
  *
  * RETURN:      Status, and optionally the Index into the global resource tables
  *
@@ -525,7 +519,9 @@ acpi_ut_walk_aml_resources(u8 *aml,
  *
  ******************************************************************************/
 
-acpi_status acpi_ut_validate_resource(void *aml, u8 *return_index)
+acpi_status
+acpi_ut_validate_resource(struct acpi_walk_state *walk_state,
+			  void *aml, u8 *return_index)
 {
 	union aml_resource *aml_resource;
 	u8 resource_type;
@@ -627,10 +623,12 @@ acpi_status acpi_ut_validate_resource(void *aml, u8 *return_index)
 		if ((aml_resource->common_serial_bus.type == 0) ||
 		    (aml_resource->common_serial_bus.type >
 		     AML_RESOURCE_MAX_SERIALBUSTYPE)) {
-			ACPI_RESOURCE_ERROR((AE_INFO,
-					     "Invalid/unsupported SerialBus resource descriptor: BusType 0x%2.2X",
-					     aml_resource->common_serial_bus.
-					     type));
+			if (walk_state) {
+				ACPI_ERROR((AE_INFO,
+					    "Invalid/unsupported SerialBus resource descriptor: BusType 0x%2.2X",
+					    aml_resource->common_serial_bus.
+					    type));
+			}
 			return (AE_AML_INVALID_RESOURCE_TYPE);
 		}
 	}
@@ -645,18 +643,22 @@ acpi_status acpi_ut_validate_resource(void *aml, u8 *return_index)
 
       invalid_resource:
 
-	ACPI_RESOURCE_ERROR((AE_INFO,
-			     "Invalid/unsupported resource descriptor: Type 0x%2.2X",
-			     resource_type));
+	if (walk_state) {
+		ACPI_ERROR((AE_INFO,
+			    "Invalid/unsupported resource descriptor: Type 0x%2.2X",
+			    resource_type));
+	}
 	return (AE_AML_INVALID_RESOURCE_TYPE);
 
       bad_resource_length:
 
-	ACPI_RESOURCE_ERROR((AE_INFO,
-			     "Invalid resource descriptor length: Type "
-			     "0x%2.2X, Length 0x%4.4X, MinLength 0x%4.4X",
-			     resource_type, resource_length,
-			     minimum_resource_length));
+	if (walk_state) {
+		ACPI_ERROR((AE_INFO,
+			    "Invalid resource descriptor length: Type "
+			    "0x%2.2X, Length 0x%4.4X, MinLength 0x%4.4X",
+			    resource_type, resource_length,
+			    minimum_resource_length));
+	}
 	return (AE_AML_BAD_RESOURCE_LENGTH);
 }
 
@@ -815,7 +817,7 @@ acpi_ut_get_resource_end_tag(union acpi_operand_object *obj_desc, u8 **end_tag)
 
 	/* Validate the template and get a pointer to the end_tag */
 
-	status = acpi_ut_walk_aml_resources(obj_desc->buffer.pointer,
+	status = acpi_ut_walk_aml_resources(NULL, obj_desc->buffer.pointer,
 					    obj_desc->buffer.length, NULL,
 					    (void **)end_tag);
 
-- 
1.7.10

