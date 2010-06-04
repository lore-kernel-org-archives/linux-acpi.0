From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/16] ACPICA: Core: Replace all %d format specifiers with %u
 (unsigned)
Date: Fri, 04 Jun 2010 15:51:37 -0400
Message-ID: <d7d85cac5d948e880541ba3922ecf8b824556511.1275680880.git.len.brown@intel.com>
References: <1275681106-8450-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:56531 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391Ab0FDTvy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 15:51:54 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3I001AK9UDEZB0@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 04 Jun 2010 14:51:51 -0500 (CDT)
In-reply-to: <1275681106-8450-1-git-send-email-lenb@kernel.org>
In-reply-to: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
References: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

With only a few exceptions, ACPICA does not use signed integers.
Therefore, %d is incorrect.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/dsmethod.c |    2 +-
 drivers/acpi/acpica/dsmthdat.c |   10 +++++-----
 drivers/acpi/acpica/dsutils.c  |    4 ++--
 drivers/acpi/acpica/exdump.c   |    4 ++--
 drivers/acpi/acpica/exfldio.c  |    4 ++--
 drivers/acpi/acpica/exprep.c   |   14 +++++++-------
 drivers/acpi/acpica/exregion.c |    6 +++---
 drivers/acpi/acpica/hwsleep.c  |    2 +-
 drivers/acpi/acpica/nsaccess.c |    4 ++--
 drivers/acpi/acpica/nsdump.c   |    2 +-
 drivers/acpi/acpica/nsparse.c  |    4 ++--
 11 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 2a9a561..0084633 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -605,7 +605,7 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 		 * we immediately reuse it for the next thread executing this method
 		 */
 		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-				  "*** Completed execution of one thread, %d threads remaining\n",
+				  "*** Completed execution of one thread, %u threads remaining\n",
 				  method_desc->method.thread_count));
 	} else {
 		/* This is the only executing thread for this method */
diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index f3d52f5..d5e927f 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -146,7 +146,7 @@ void acpi_ds_method_data_delete_all(struct acpi_walk_state *walk_state)
 
 	for (index = 0; index < ACPI_METHOD_NUM_LOCALS; index++) {
 		if (walk_state->local_variables[index].object) {
-			ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Deleting Local%d=%p\n",
+			ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Deleting Local%u=%p\n",
 					  index,
 					  walk_state->local_variables[index].
 					  object));
@@ -162,7 +162,7 @@ void acpi_ds_method_data_delete_all(struct acpi_walk_state *walk_state)
 
 	for (index = 0; index < ACPI_METHOD_NUM_ARGS; index++) {
 		if (walk_state->arguments[index].object) {
-			ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Deleting Arg%d=%p\n",
+			ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Deleting Arg%u=%p\n",
 					  index,
 					  walk_state->arguments[index].object));
 
@@ -226,7 +226,7 @@ acpi_ds_method_data_init_args(union acpi_operand_object **params,
 		index++;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%d args passed to method\n", index));
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%u args passed to method\n", index));
 	return_ACPI_STATUS(AE_OK);
 }
 
@@ -323,7 +323,7 @@ acpi_ds_method_data_set_value(u8 type,
 	ACPI_FUNCTION_TRACE(ds_method_data_set_value);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-			  "NewObj %p Type %2.2X, Refs=%d [%s]\n", object,
+			  "NewObj %p Type %2.2X, Refs=%u [%s]\n", object,
 			  type, object->common.reference_count,
 			  acpi_ut_get_type_name(object->common.type)));
 
@@ -543,7 +543,7 @@ acpi_ds_store_object_to_local(u8 type,
 	union acpi_operand_object *new_obj_desc;
 
 	ACPI_FUNCTION_TRACE(ds_store_object_to_local);
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Type=%2.2X Index=%d Obj=%p\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Type=%2.2X Index=%u Obj=%p\n",
 			  type, index, obj_desc));
 
 	/* Parameter validation */
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index 306c62a..15135c2 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -746,7 +746,7 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 		index--;
 
 		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-				  "Arg #%d (%p) done, Arg1=%p\n", index, arg,
+				  "Arg #%u (%p) done, Arg1=%p\n", index, arg,
 				  first_arg));
 	}
 
@@ -760,7 +760,7 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 	 */
 	acpi_ds_obj_stack_pop_and_delete(arg_count, walk_state);
 
-	ACPI_EXCEPTION((AE_INFO, status, "While creating Arg %d", index));
+	ACPI_EXCEPTION((AE_INFO, status, "While creating Arg %u", index));
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index d39d438..cdb66d1 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -742,7 +742,7 @@ acpi_ex_dump_operands(union acpi_operand_object **operands,
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-			  "**** Start operand dump for opcode [%s], %d operands\n",
+			  "**** Start operand dump for opcode [%s], %u operands\n",
 			  opcode_name, num_operands));
 
 	if (num_operands == 0) {
@@ -945,7 +945,7 @@ acpi_ex_dump_package_obj(union acpi_operand_object *obj_desc,
 
 	case ACPI_TYPE_PACKAGE:
 
-		acpi_os_printf("[Package] Contains %d Elements:\n",
+		acpi_os_printf("[Package] Contains %u Elements:\n",
 			       obj_desc->package.count);
 
 		for (i = 0; i < obj_desc->package.count; i++) {
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index a6dc26f..0472173 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -534,13 +534,13 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 	if (ACPI_SUCCESS(status)) {
 		if (read_write == ACPI_READ) {
 			ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-					  "Value Read %8.8X%8.8X, Width %d\n",
+					  "Value Read %8.8X%8.8X, Width %u\n",
 					  ACPI_FORMAT_UINT64(*value),
 					  obj_desc->common_field.
 					  access_byte_width));
 		} else {
 			ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-					  "Value Written %8.8X%8.8X, Width %d\n",
+					  "Value Written %8.8X%8.8X, Width %u\n",
 					  ACPI_FORMAT_UINT64(*value),
 					  obj_desc->common_field.
 					  access_byte_width));
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 25059da..0686f27 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -108,11 +108,11 @@ acpi_ex_generate_access(u32 field_bit_offset,
 	field_byte_length = field_byte_end_offset - field_byte_offset;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-			  "Bit length %d, Bit offset %d\n",
+			  "Bit length %u, Bit offset %u\n",
 			  field_bit_length, field_bit_offset));
 
 	ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-			  "Byte Length %d, Byte Offset %d, End Offset %d\n",
+			  "Byte Length %u, Byte Offset %u, End Offset %u\n",
 			  field_byte_length, field_byte_offset,
 			  field_byte_end_offset));
 
@@ -147,11 +147,11 @@ acpi_ex_generate_access(u32 field_bit_offset,
 			accesses = field_end_offset - field_start_offset;
 
 			ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-					  "AccessWidth %d end is within region\n",
+					  "AccessWidth %u end is within region\n",
 					  access_byte_width));
 
 			ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-					  "Field Start %d, Field End %d -- requires %d accesses\n",
+					  "Field Start %u, Field End %u -- requires %u accesses\n",
 					  field_start_offset, field_end_offset,
 					  accesses));
 
@@ -159,7 +159,7 @@ acpi_ex_generate_access(u32 field_bit_offset,
 
 			if (accesses <= 1) {
 				ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-						  "Entire field can be accessed with one operation of size %d\n",
+						  "Entire field can be accessed with one operation of size %u\n",
 						  access_byte_width));
 				return_VALUE(access_byte_width);
 			}
@@ -174,7 +174,7 @@ acpi_ex_generate_access(u32 field_bit_offset,
 			}
 		} else {
 			ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-					  "AccessWidth %d end is NOT within region\n",
+					  "AccessWidth %u end is NOT within region\n",
 					  access_byte_width));
 			if (access_byte_width == 1) {
 				ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
@@ -190,7 +190,7 @@ acpi_ex_generate_access(u32 field_bit_offset,
 			 * previous access
 			 */
 			ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-					  "Backing off to previous optimal access width of %d\n",
+					  "Backing off to previous optimal access width of %u\n",
 					  minimum_access_width));
 			return_VALUE(minimum_access_width);
 		}
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 531000f..8819d2a 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -194,7 +194,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 	    ((u64) address - (u64) mem_info->mapped_physical_address);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "System-Memory (width %d) R/W %d Address=%8.8X%8.8X\n",
+			  "System-Memory (width %u) R/W %u Address=%8.8X%8.8X\n",
 			  bit_width, function,
 			  ACPI_FORMAT_NATIVE_UINT(address)));
 
@@ -297,7 +297,7 @@ acpi_ex_system_io_space_handler(u32 function,
 	ACPI_FUNCTION_TRACE(ex_system_io_space_handler);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "System-IO (width %d) R/W %d Address=%8.8X%8.8X\n",
+			  "System-IO (width %u) R/W %u Address=%8.8X%8.8X\n",
 			  bit_width, function,
 			  ACPI_FORMAT_NATIVE_UINT(address)));
 
@@ -373,7 +373,7 @@ acpi_ex_pci_config_space_handler(u32 function,
 	pci_register = (u16) (u32) address;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Pci-Config %d (%d) Seg(%04x) Bus(%04x) Dev(%04x) Func(%04x) Reg(%04x)\n",
+			  "Pci-Config %u (%u) Seg(%04x) Bus(%04x) Dev(%04x) Func(%04x) Reg(%04x)\n",
 			  function, bit_width, pci_id->segment, pci_id->bus,
 			  pci_id->device, pci_id->function, pci_register));
 
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 36eb803..3796811 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -307,7 +307,7 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 		return_ACPI_STATUS(status);
 	}
 	ACPI_DEBUG_PRINT((ACPI_DB_INIT,
-			  "Entering sleep state [S%d]\n", sleep_state));
+			  "Entering sleep state [S%u]\n", sleep_state));
 
 	/* Clear the SLP_EN and SLP_TYP fields */
 
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 3a28146..2cebfa9 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -433,7 +433,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 
 			if (search_parent_flag == ACPI_NS_NO_UPSEARCH) {
 				ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
-						  "Search scope is [%4.4s], path has %d carat(s)\n",
+						  "Search scope is [%4.4s], path has %u carat(s)\n",
 						  acpi_ut_get_node_name
 						  (this_node), num_carats));
 			}
@@ -495,7 +495,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 			path++;
 
 			ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
-					  "Multi Pathname (%d Segments, Flags=%X)\n",
+					  "Multi Pathname (%u Segments, Flags=%X)\n",
 					  num_segments, flags));
 			break;
 
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 2110cc2..a54dc39 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -441,7 +441,7 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 			return (AE_OK);
 		}
 
-		acpi_os_printf("(R%d)", obj_desc->common.reference_count);
+		acpi_os_printf("(R%u)", obj_desc->common.reference_count);
 
 		switch (type) {
 		case ACPI_TYPE_METHOD:
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index 27cda52..5808c89 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -136,8 +136,8 @@ acpi_ns_one_complete_parse(u32 pass_number,
 
 	/* Parse the AML */
 
-	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "*PARSE* pass %d parse\n",
-			  (unsigned)pass_number));
+	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "*PARSE* pass %u parse\n",
+			  pass_number));
 	status = acpi_ps_parse_aml(walk_state);
 
       cleanup:
-- 
1.6.0.6

