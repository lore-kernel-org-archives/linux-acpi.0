From: Len Brown <lenb@kernel.org>
Subject: [PATCH 33/73] ACPICA: Cosmetic changes only, no functional changes
Date: Sat, 12 Apr 2008 00:25:16 -0400
Message-ID: <bd2d226a2b2d0751a849f3b0c7d627a3bc63e7a4.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:47253 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753300AbYDLE2J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:09 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Lint changes, fix compiler warnings, etc.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evmisc.c      |    7 ++++---
 drivers/acpi/events/evregion.c    |    2 +-
 drivers/acpi/hardware/hwsleep.c   |   14 ++++++++------
 drivers/acpi/namespace/nsdump.c   |    9 +++++----
 drivers/acpi/namespace/nsload.c   |    2 +-
 drivers/acpi/namespace/nsnames.c  |    2 +-
 drivers/acpi/namespace/nsparse.c  |   17 +++++++++++------
 drivers/acpi/resources/rscalc.c   |    6 +++---
 drivers/acpi/resources/rsutils.c  |    6 +++---
 drivers/acpi/utilities/utalloc.c  |    2 +-
 drivers/acpi/utilities/utcopy.c   |    2 +-
 drivers/acpi/utilities/utdebug.c  |   10 ++++------
 drivers/acpi/utilities/utglobal.c |    2 +-
 13 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index d075062..4e7a13a 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -349,9 +349,10 @@ acpi_status acpi_ev_init_global_lock_handler(void)
 
 	ACPI_FUNCTION_TRACE(ev_init_global_lock_handler);
 
-	status =
-	    acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
-				    (struct acpi_table_header **)&facs);
+	status = acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
+					 ACPI_CAST_INDIRECT_PTR(struct
+								acpi_table_header,
+								&facs));
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/events/evregion.c b/drivers/acpi/events/evregion.c
index 58ad097..03624e9 100644
--- a/drivers/acpi/events/evregion.c
+++ b/drivers/acpi/events/evregion.c
@@ -394,7 +394,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
 			  "Handler %p (@%p) Address %8.8X%8.8X [%s]\n",
 			  &region_obj->region.handler->address_space, handler,
-			  ACPI_FORMAT_UINT64(address),
+			  ACPI_FORMAT_NATIVE_UINT(address),
 			  acpi_ut_get_region_name(region_obj->region.
 						  space_id)));
 
diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index 4290e01..202f11a 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -70,9 +70,10 @@ acpi_set_firmware_waking_vector(acpi_physical_address physical_address)
 
 	/* Get the FACS */
 
-	status =
-	    acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
-				    (struct acpi_table_header **)&facs);
+	status = acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
+					 ACPI_CAST_INDIRECT_PTR(struct
+								acpi_table_header,
+								&facs));
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -124,9 +125,10 @@ acpi_get_firmware_waking_vector(acpi_physical_address * physical_address)
 
 	/* Get the FACS */
 
-	status =
-	    acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
-				    (struct acpi_table_header **)&facs);
+	status = acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
+					 ACPI_CAST_INDIRECT_PTR(struct
+								acpi_table_header,
+								&facs));
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/namespace/nsdump.c b/drivers/acpi/namespace/nsdump.c
index 1fc4f86..3068e20 100644
--- a/drivers/acpi/namespace/nsdump.c
+++ b/drivers/acpi/namespace/nsdump.c
@@ -249,7 +249,9 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 			acpi_os_printf("ID %X Len %.4X Addr %p\n",
 				       obj_desc->processor.proc_id,
 				       obj_desc->processor.length,
-				       (char *)obj_desc->processor.address);
+				       ACPI_CAST_PTR(void,
+						     obj_desc->processor.
+						     address));
 			break;
 
 		case ACPI_TYPE_DEVICE:
@@ -320,9 +322,8 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 							       space_id));
 			if (obj_desc->region.flags & AOPOBJ_DATA_VALID) {
 				acpi_os_printf(" Addr %8.8X%8.8X Len %.4X\n",
-					       ACPI_FORMAT_UINT64(obj_desc->
-								  region.
-								  address),
+					       ACPI_FORMAT_NATIVE_UINT
+					       (obj_desc->region.address),
 					       obj_desc->region.length);
 			} else {
 				acpi_os_printf
diff --git a/drivers/acpi/namespace/nsload.c b/drivers/acpi/namespace/nsload.c
index 545010d..1bfcb6f 100644
--- a/drivers/acpi/namespace/nsload.c
+++ b/drivers/acpi/namespace/nsload.c
@@ -111,7 +111,7 @@ acpi_ns_load_table(acpi_native_uint table_index,
 	if (ACPI_SUCCESS(status)) {
 		acpi_tb_set_table_loaded_flag(table_index, TRUE);
 	} else {
-		acpi_tb_release_owner_id(table_index);
+		(void)acpi_tb_release_owner_id(table_index);
 	}
 
       unlock:
diff --git a/drivers/acpi/namespace/nsnames.c b/drivers/acpi/namespace/nsnames.c
index e14a141..ba1a4f0 100644
--- a/drivers/acpi/namespace/nsnames.c
+++ b/drivers/acpi/namespace/nsnames.c
@@ -182,7 +182,7 @@ acpi_size acpi_ns_get_pathname_length(struct acpi_namespace_node *node)
 	while (next_node && (next_node != acpi_gbl_root_node)) {
 		if (ACPI_GET_DESCRIPTOR_TYPE(next_node) != ACPI_DESC_TYPE_NAMED) {
 			ACPI_ERROR((AE_INFO,
-				    "Invalid NS Node (%X) while traversing path",
+				    "Invalid NS Node (%p) while traversing path",
 				    next_node));
 			return 0;
 		}
diff --git a/drivers/acpi/namespace/nsparse.c b/drivers/acpi/namespace/nsparse.c
index 86bd6e5..f260b69 100644
--- a/drivers/acpi/namespace/nsparse.c
+++ b/drivers/acpi/namespace/nsparse.c
@@ -112,21 +112,25 @@ acpi_ns_one_complete_parse(acpi_native_uint pass_number,
 		aml_start = (u8 *) table + sizeof(struct acpi_table_header);
 		aml_length = table->length - sizeof(struct acpi_table_header);
 		status = acpi_ds_init_aml_walk(walk_state, parse_root, NULL,
-					       aml_start, aml_length, NULL,
-					       (u8) pass_number);
+					       aml_start, (u32) aml_length,
+					       NULL, (u8) pass_number);
 	}
 
 	if (ACPI_FAILURE(status)) {
 		acpi_ds_delete_walk_state(walk_state);
-		acpi_ps_delete_parse_tree(parse_root);
-		return_ACPI_STATUS(status);
+		goto cleanup;
 	}
 
 	/* start_node is the default location to load the table */
 
 	if (start_node && start_node != acpi_gbl_root_node) {
-		acpi_ds_scope_stack_push(start_node, ACPI_TYPE_METHOD,
-					 walk_state);
+		status =
+		    acpi_ds_scope_stack_push(start_node, ACPI_TYPE_METHOD,
+					     walk_state);
+		if (ACPI_FAILURE(status)) {
+			acpi_ds_delete_walk_state(walk_state);
+			goto cleanup;
+		}
 	}
 
 	/* Parse the AML */
@@ -135,6 +139,7 @@ acpi_ns_one_complete_parse(acpi_native_uint pass_number,
 			  (unsigned)pass_number));
 	status = acpi_ps_parse_aml(walk_state);
 
+      cleanup:
 	acpi_ps_delete_parse_tree(parse_root);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/resources/rscalc.c b/drivers/acpi/resources/rscalc.c
index 0dd2ce8..dcc51e9 100644
--- a/drivers/acpi/resources/rscalc.c
+++ b/drivers/acpi/resources/rscalc.c
@@ -73,7 +73,7 @@ acpi_rs_stream_option_length(u32 resource_length, u32 minimum_total_length);
 
 static u8 acpi_rs_count_set_bits(u16 bit_field)
 {
-	u8 bits_set;
+	acpi_native_uint bits_set;
 
 	ACPI_FUNCTION_ENTRY();
 
@@ -81,10 +81,10 @@ static u8 acpi_rs_count_set_bits(u16 bit_field)
 
 		/* Zero the least significant bit that is set */
 
-		bit_field &= (bit_field - 1);
+		bit_field &= (u16) (bit_field - 1);
 	}
 
-	return (bits_set);
+	return ((u8) bits_set);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/resources/rsutils.c b/drivers/acpi/resources/rsutils.c
index 11c0bd7..935a482 100644
--- a/drivers/acpi/resources/rsutils.c
+++ b/drivers/acpi/resources/rsutils.c
@@ -97,17 +97,17 @@ u8 acpi_rs_decode_bitmask(u16 mask, u8 * list)
 u16 acpi_rs_encode_bitmask(u8 * list, u8 count)
 {
 	acpi_native_uint i;
-	u16 mask;
+	acpi_native_uint mask;
 
 	ACPI_FUNCTION_ENTRY();
 
 	/* Encode the list into a single bitmask */
 
 	for (i = 0, mask = 0; i < count; i++) {
-		mask |= (0x0001 << list[i]);
+		mask |= (0x1 << list[i]);
 	}
 
-	return (mask);
+	return ((u16) mask);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/utilities/utalloc.c b/drivers/acpi/utilities/utalloc.c
index 6e56d5f..181e669 100644
--- a/drivers/acpi/utilities/utalloc.c
+++ b/drivers/acpi/utilities/utalloc.c
@@ -147,7 +147,7 @@ acpi_status acpi_ut_delete_caches(void)
 
 	if (acpi_gbl_display_final_mem_stats) {
 		ACPI_STRCPY(buffer, "MEMORY");
-		acpi_db_display_statistics(buffer);
+		(void)acpi_db_display_statistics(buffer);
 	}
 #endif
 
diff --git a/drivers/acpi/utilities/utcopy.c b/drivers/acpi/utilities/utcopy.c
index 879eaa1..b56953d 100644
--- a/drivers/acpi/utilities/utcopy.c
+++ b/drivers/acpi/utilities/utcopy.c
@@ -570,7 +570,7 @@ acpi_ut_copy_epackage_to_ipackage(union acpi_object *external_object,
 
 			/* Truncate package and delete it */
 
-			package_object->package.count = i;
+			package_object->package.count = (u32) i;
 			package_elements[i] = NULL;
 			acpi_ut_remove_reference(package_object);
 			return_ACPI_STATUS(status);
diff --git a/drivers/acpi/utilities/utdebug.c b/drivers/acpi/utilities/utdebug.c
index a914867..2d6a78f 100644
--- a/drivers/acpi/utilities/utdebug.c
+++ b/drivers/acpi/utilities/utdebug.c
@@ -68,9 +68,9 @@ static const char *acpi_ut_trim_function_name(const char *function_name);
 
 void acpi_ut_init_stack_ptr_trace(void)
 {
-	u32 current_sp;
+	acpi_size current_sp;
 
-	acpi_gbl_entry_stack_pointer = ACPI_PTR_DIFF(&current_sp, NULL);
+	acpi_gbl_entry_stack_pointer = &current_sp;
 }
 
 /*******************************************************************************
@@ -89,10 +89,8 @@ void acpi_ut_track_stack_ptr(void)
 {
 	acpi_size current_sp;
 
-	current_sp = ACPI_PTR_DIFF(&current_sp, NULL);
-
-	if (current_sp < acpi_gbl_lowest_stack_pointer) {
-		acpi_gbl_lowest_stack_pointer = current_sp;
+	if (&current_sp < acpi_gbl_lowest_stack_pointer) {
+		acpi_gbl_lowest_stack_pointer = &current_sp;
 	}
 
 	if (acpi_gbl_nesting_level > acpi_gbl_deepest_nesting) {
diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index 4442543..d2097de 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -723,7 +723,7 @@ void acpi_ut_init_globals(void)
 	acpi_gbl_root_node_struct.flags = ANOBJ_END_OF_PEER_LIST;
 
 #ifdef ACPI_DEBUG_OUTPUT
-	acpi_gbl_lowest_stack_pointer = ACPI_SIZE_MAX;
+	acpi_gbl_lowest_stack_pointer = ACPI_CAST_PTR(acpi_size, ACPI_SIZE_MAX);
 #endif
 
 #ifdef ACPI_DBG_TRACK_ALLOCATIONS
-- 
1.5.5.29.g7134

