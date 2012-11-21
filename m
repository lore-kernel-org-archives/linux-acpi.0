From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/15] ACPICA: Fixes indent caused divergences.
Date: Wed, 21 Nov 2012 18:07:17 +0800
Message-ID: <19e3ed9ca74357210290b80d5e39c56110fdab2e.1353491652.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24522 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753127Ab2KUKHU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Nov 2012 05:07:20 -0500
In-Reply-To: <cover.1353491652.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This patch fixes divergences caused by "indent" program.
The version of "indent" used for this patch is "GNU indent 2.2.11".

This patch will not affect the generated vmlinux binary.
This will decrease 198 lines of 20121018 divergence.diff.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evxface.c   |   11 ++++++-----
 drivers/acpi/acpica/exoparg1.c  |    8 +-------
 drivers/acpi/acpica/exregion.c  |    8 ++++----
 drivers/acpi/acpica/hwacpi.c    |    3 +--
 drivers/acpi/acpica/hwregs.c    |    3 +--
 drivers/acpi/acpica/nsrepair2.c |    3 ++-
 drivers/acpi/acpica/nsutils.c   |    6 +++---
 drivers/acpi/acpica/psutils.c   |    2 +-
 drivers/acpi/acpica/rscreate.c  |    3 +--
 drivers/acpi/acpica/rsdump.c    |    3 ++-
 drivers/acpi/acpica/rsirq.c     |    6 ++----
 drivers/acpi/acpica/rsmemory.c  |    6 ++----
 drivers/acpi/acpica/rsmisc.c    |   11 ++++++-----
 drivers/acpi/acpica/rsutils.c   |    6 ++++--
 drivers/acpi/acpica/utresrc.c   |    7 +++----
 include/acpi/acpiosxf.h         |    4 +---
 16 files changed, 40 insertions(+), 50 deletions(-)

diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 74fe0f1..db82060 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -626,8 +626,9 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 	handler->address = address;
 	handler->context = context;
 	handler->method_node = gpe_event_info->dispatch.method_node;
-	handler->original_flags = gpe_event_info->flags &
-			(ACPI_GPE_XRUPT_TYPE_MASK | ACPI_GPE_DISPATCH_MASK);
+	handler->original_flags = (u8)(gpe_event_info->flags &
+				       (ACPI_GPE_XRUPT_TYPE_MASK |
+				        ACPI_GPE_DISPATCH_MASK));
 
 	/*
 	 * If the GPE is associated with a method, it may have been enabled
@@ -746,10 +747,10 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
 	 * enabled, it should be enabled at this point to restore the
 	 * post-initialization configuration.
 	 */
-
-	if ((handler->original_flags & ACPI_GPE_DISPATCH_METHOD)
-	    && handler->originally_enabled)
+	if ((handler->original_flags & ACPI_GPE_DISPATCH_METHOD) &&
+	    handler->originally_enabled) {
 		(void)acpi_ev_add_gpe_reference(gpe_event_info);
+	}
 
 	/* Now we can free the handler object */
 
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index bbf01e9..cf50c6c 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -948,13 +948,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 					 */
 					return_desc =
 					    acpi_ut_create_integer_object((u64)
-									  temp_desc->
-									  buffer.
-									  pointer
-									  [operand
-									   [0]->
-									   reference.
-									   value]);
+									  temp_desc->buffer.pointer[operand[0]->reference.value]);
 					if (!return_desc) {
 						status = AE_NO_MEMORY;
 						goto cleanup;
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 48c660a..06a4924 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -239,19 +239,19 @@ acpi_ex_system_memory_space_handler(u32 function,
 
 		switch (bit_width) {
 		case 8:
-			ACPI_SET8(logical_addr_ptr) = (u8) * value;
+			ACPI_SET8(logical_addr_ptr) = (u8)*value;
 			break;
 
 		case 16:
-			ACPI_SET16(logical_addr_ptr) = (u16) * value;
+			ACPI_SET16(logical_addr_ptr) = (u16)*value;
 			break;
 
 		case 32:
-			ACPI_SET32(logical_addr_ptr) = (u32) * value;
+			ACPI_SET32(logical_addr_ptr) = (u32)*value;
 			break;
 
 		case 64:
-			ACPI_SET64(logical_addr_ptr) = (u64) * value;
+			ACPI_SET64(logical_addr_ptr) = (u64)*value;
 			break;
 
 		default:
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index 90a9aea..effa2b0 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -108,8 +108,7 @@ acpi_status acpi_hw_set_mode(u32 mode)
 		 * enable bits to default
 		 */
 		status = acpi_hw_write_port(acpi_gbl_FADT.smi_command,
-					    (u32) acpi_gbl_FADT.acpi_disable,
-					    8);
+					    (u32)acpi_gbl_FADT.acpi_disable, 8);
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Attempting to enable Legacy (non-ACPI) mode\n"));
 		break;
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 165395f..83f73cf 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -364,8 +364,7 @@ acpi_status acpi_hw_write_pm1_control(u32 pm1a_control, u32 pm1b_control)
  * DESCRIPTION: Read from the specified ACPI register
  *
  ******************************************************************************/
-acpi_status
-acpi_hw_register_read(u32 register_id, u32 * return_value)
+acpi_status acpi_hw_register_read(u32 register_id, u32 *return_value)
 {
 	u32 value = 0;
 	acpi_status status;
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 9018925..fdb818d 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -55,7 +55,8 @@ ACPI_MODULE_NAME("nsrepair2")
  */
 typedef
 acpi_status(*acpi_repair_function) (struct acpi_predefined_data *data,
-				    union acpi_operand_object **return_object_ptr);
+				    union acpi_operand_object
+				    **return_object_ptr);
 
 typedef struct acpi_repair_info {
 	char name[ACPI_NAME_SIZE];
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index b5b4cb7..7bfaa6f 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -112,7 +112,7 @@ acpi_ns_print_node_pathname(struct acpi_namespace_node *node,
 u8 acpi_ns_valid_root_prefix(char prefix)
 {
 
-	return ((u8) (prefix == '\\'));
+	return ((u8)(prefix == '\\'));
 }
 
 /*******************************************************************************
@@ -130,7 +130,7 @@ u8 acpi_ns_valid_root_prefix(char prefix)
 static u8 acpi_ns_valid_path_separator(char sep)
 {
 
-	return ((u8) (sep == '.'));
+	return ((u8)(sep == '.'));
 }
 
 /*******************************************************************************
@@ -674,7 +674,7 @@ u32 acpi_ns_opens_scope(acpi_object_type type)
 		return_UINT32(ACPI_NS_NORMAL);
 	}
 
-	return_UINT32(((u32) acpi_gbl_ns_properties[type]) & ACPI_NS_NEWSCOPE);
+	return_UINT32(((u32)acpi_gbl_ns_properties[type]) & ACPI_NS_NEWSCOPE);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index 4137dcb..afefb3a1 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -206,7 +206,7 @@ u8 acpi_ps_is_leading_char(u32 c)
  */
 u8 acpi_ps_is_prefix_char(u32 c)
 {
-	return ((u8) (c == '\\' || c == '^'));
+	return ((u8)(c == '\\' || c == '^'));
 }
 
 /*
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index 311cbc4..8133326 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -480,8 +480,7 @@ acpi_rs_create_aml_resources(struct acpi_resource *linked_list_buffer,
 	status = acpi_rs_get_aml_length(linked_list_buffer, &aml_size_needed);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "AmlSizeNeeded=%X, %s\n",
-			  (u32) aml_size_needed,
-			  acpi_format_exception(status)));
+			  (u32)aml_size_needed, acpi_format_exception(status)));
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 4d11b072..276e52f 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -654,7 +654,8 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table)
 			/*
 			 * Optional resource_source for Address resources
 			 */
-			acpi_rs_dump_resource_source(ACPI_CAST_PTR(struct
+			acpi_rs_dump_resource_source(ACPI_CAST_PTR
+						     (struct
 								   acpi_resource_source,
 								   target));
 			break;
diff --git a/drivers/acpi/acpica/rsirq.c b/drivers/acpi/acpica/rsirq.c
index e23a9ec..a718eca 100644
--- a/drivers/acpi/acpica/rsirq.c
+++ b/drivers/acpi/acpica/rsirq.c
@@ -212,15 +212,13 @@ struct acpi_rsconvert_info acpi_rs_convert_ext_irq[9] = {
 
 	{ACPI_RSC_COUNT, ACPI_RS_OFFSET(data.extended_irq.interrupt_count),
 	 AML_OFFSET(extended_irq.interrupt_count),
-	 sizeof(u32)}
-	,
+	 sizeof(u32)},
 
 	/* Copy every IRQ in the table, each is 32 bits */
 
 	{ACPI_RSC_MOVE32, ACPI_RS_OFFSET(data.extended_irq.interrupts[0]),
 	 AML_OFFSET(extended_irq.interrupts[0]),
-	 0}
-	,
+	 0},
 
 	/* Optional resource_source (Index and String) */
 
diff --git a/drivers/acpi/acpica/rsmemory.c b/drivers/acpi/acpica/rsmemory.c
index 4fd611a..d446103 100644
--- a/drivers/acpi/acpica/rsmemory.c
+++ b/drivers/acpi/acpica/rsmemory.c
@@ -156,8 +156,7 @@ struct acpi_rsconvert_info acpi_rs_get_vendor_small[3] = {
 
 	{ACPI_RSC_COUNT16, ACPI_RS_OFFSET(data.vendor.byte_length),
 	 0,
-	 sizeof(u8)}
-	,
+	 sizeof(u8)},
 
 	/* Vendor data */
 
@@ -181,8 +180,7 @@ struct acpi_rsconvert_info acpi_rs_get_vendor_large[3] = {
 
 	{ACPI_RSC_COUNT16, ACPI_RS_OFFSET(data.vendor.byte_length),
 	 0,
-	 sizeof(u8)}
-	,
+	 sizeof(u8)},
 
 	/* Vendor data */
 
diff --git a/drivers/acpi/acpica/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
index c6f291c..3d0e15c 100644
--- a/drivers/acpi/acpica/rsmisc.c
+++ b/drivers/acpi/acpica/rsmisc.c
@@ -159,7 +159,7 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 		case ACPI_RSC_COUNT:
 
 			item_count = ACPI_GET8(source);
-			ACPI_SET8(destination) = (u8) item_count;
+			ACPI_SET8(destination) = (u8)item_count;
 
 			resource->length = resource->length +
 			    (info->value * (item_count - 1));
@@ -385,7 +385,7 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 			}
 
 			target = ACPI_ADD_PTR(char, resource, info->value);
-			ACPI_SET8(target) = (u8) item_count;
+			ACPI_SET8(target) = (u8)item_count;
 			break;
 
 		case ACPI_RSC_BITMASK16:
@@ -401,7 +401,7 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 			}
 
 			target = ACPI_ADD_PTR(char, resource, info->value);
-			ACPI_SET8(target) = (u8) item_count;
+			ACPI_SET8(target) = (u8)item_count;
 			break;
 
 		case ACPI_RSC_EXIT_NE:
@@ -544,7 +544,7 @@ acpi_rs_convert_resource_to_aml(struct acpi_resource *resource,
 		case ACPI_RSC_COUNT:
 
 			item_count = ACPI_GET8(source);
-			ACPI_SET8(destination) = (u8) item_count;
+			ACPI_SET8(destination) = (u8)item_count;
 
 			aml_length =
 			    (u16) (aml_length +
@@ -686,7 +686,8 @@ acpi_rs_convert_resource_to_aml(struct acpi_resource *resource,
 			 * Optional resource_source (Index and String)
 			 */
 			aml_length =
-			    acpi_rs_set_resource_source(aml, (acpi_rs_length)
+			    acpi_rs_set_resource_source(aml,
+							(acpi_rs_length)
 							aml_length, source);
 			acpi_rs_set_resource_length(aml_length, aml);
 			break;
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index 37d5241..441447f 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -358,8 +358,10 @@ acpi_rs_get_resource_source(acpi_rs_length resource_length,
 		 *
 		 * Zero the entire area of the buffer.
 		 */
-		total_length = (u32)
-		ACPI_STRLEN(ACPI_CAST_PTR(char, &aml_resource_source[1])) + 1;
+		total_length =
+		    (u32)
+		    ACPI_STRLEN(ACPI_CAST_PTR(char, &aml_resource_source[1])) +
+		    1;
 		total_length = (u32) ACPI_ROUND_UP_TO_NATIVE_WORD(total_length);
 
 		ACPI_MEMSET(resource_source->string_ptr, 0, total_length);
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index e38bef4..7d0a1b5 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -412,7 +412,7 @@ static const u8 acpi_gbl_resource_types[] = {
  ******************************************************************************/
 
 acpi_status
-acpi_ut_walk_aml_resources(u8 * aml,
+acpi_ut_walk_aml_resources(u8 *aml,
 			   acpi_size aml_length,
 			   acpi_walk_aml_callback user_function, void **context)
 {
@@ -525,7 +525,7 @@ acpi_ut_walk_aml_resources(u8 * aml,
  *
  ******************************************************************************/
 
-acpi_status acpi_ut_validate_resource(void *aml, u8 * return_index)
+acpi_status acpi_ut_validate_resource(void *aml, u8 *return_index)
 {
 	union aml_resource *aml_resource;
 	u8 resource_type;
@@ -800,8 +800,7 @@ u32 acpi_ut_get_descriptor_length(void *aml)
  ******************************************************************************/
 
 acpi_status
-acpi_ut_get_resource_end_tag(union acpi_operand_object * obj_desc,
-			     u8 ** end_tag)
+acpi_ut_get_resource_end_tag(union acpi_operand_object *obj_desc, u8 **end_tag)
 {
 	acpi_status status;
 
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 4315274..7d0895b 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -102,10 +102,8 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
 /*
  * Spinlock primitives
  */
-
 #ifndef acpi_os_create_lock
-acpi_status
-acpi_os_create_lock(acpi_spinlock *out_handle);
+acpi_status acpi_os_create_lock(acpi_spinlock * out_handle);
 #endif
 
 void acpi_os_delete_lock(acpi_spinlock handle);
-- 
1.7.10

