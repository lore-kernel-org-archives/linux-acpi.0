From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/42] ACPICA: Core: Major update for code formatting, no functional changes
Date: Tue, 29 Dec 2015 13:54:36 +0800
Message-ID: <3a28bb455fc71ea55f97102ec1dafd5e3f5418b7.1451367388.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit dfa394471f6c01b2ee9433dbc143ec70cb9bca72

Mostly indentation inconsistencies across the code. Split
some long lines, etc.

Link: https://github.com/acpica/acpica/commit/dfa39447
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dbstats.c                      |    1 +
 drivers/acpi/acpica/dbutils.c                      |    1 +
 drivers/acpi/acpica/dsargs.c                       |    7 +-
 drivers/acpi/acpica/dsdebug.c                      |    5 +-
 drivers/acpi/acpica/dsfield.c                      |   39 +++++-----
 drivers/acpi/acpica/dsinit.c                       |    2 +-
 drivers/acpi/acpica/dsmethod.c                     |   24 +++---
 drivers/acpi/acpica/dsmthdat.c                     |   20 ++---
 drivers/acpi/acpica/dsobject.c                     |   19 +++--
 drivers/acpi/acpica/dsopcode.c                     |   21 ++---
 drivers/acpi/acpica/dsutils.c                      |   29 ++++---
 drivers/acpi/acpica/dswexec.c                      |   19 ++---
 drivers/acpi/acpica/dswload.c                      |   10 +--
 drivers/acpi/acpica/dswload2.c                     |   10 +--
 drivers/acpi/acpica/dswscope.c                     |    1 +
 drivers/acpi/acpica/evgpe.c                        |    2 +-
 drivers/acpi/acpica/evgpeblk.c                     |    1 +
 drivers/acpi/acpica/evgpeutil.c                    |    1 +
 drivers/acpi/acpica/evmisc.c                       |    5 +-
 drivers/acpi/acpica/evxface.c                      |    9 +--
 drivers/acpi/acpica/evxfregn.c                     |    1 +
 drivers/acpi/acpica/exconfig.c                     |    8 +-
 drivers/acpi/acpica/exconvrt.c                     |    9 +--
 drivers/acpi/acpica/excreate.c                     |   10 +--
 drivers/acpi/acpica/exdebug.c                      |    1 +
 drivers/acpi/acpica/exfield.c                      |   74 ++++++++++--------
 drivers/acpi/acpica/exfldio.c                      |   35 +++++----
 drivers/acpi/acpica/exmisc.c                       |   10 ++-
 drivers/acpi/acpica/exnames.c                      |    4 +-
 drivers/acpi/acpica/exoparg1.c                     |   31 +++++---
 drivers/acpi/acpica/exoparg2.c                     |   12 ++-
 drivers/acpi/acpica/exoparg3.c                     |   19 +++--
 drivers/acpi/acpica/exoparg6.c                     |    1 +
 drivers/acpi/acpica/exprep.c                       |   25 +++---
 drivers/acpi/acpica/exregion.c                     |   13 ++--
 drivers/acpi/acpica/exresnte.c                     |    2 +-
 drivers/acpi/acpica/exresolv.c                     |   10 +--
 drivers/acpi/acpica/exresop.c                      |   43 ++++++-----
 drivers/acpi/acpica/exstore.c                      |   17 ++--
 drivers/acpi/acpica/exstorob.c                     |    7 +-
 drivers/acpi/acpica/exsystem.c                     |    6 +-
 drivers/acpi/acpica/exutils.c                      |    7 +-
 drivers/acpi/acpica/hwesleep.c                     |    4 +-
 drivers/acpi/acpica/hwgpe.c                        |    7 +-
 drivers/acpi/acpica/hwsleep.c                      |    4 +-
 drivers/acpi/acpica/hwxfsleep.c                    |    1 +
 drivers/acpi/acpica/nsconvert.c                    |   18 ++---
 drivers/acpi/acpica/nsdump.c                       |    3 +
 drivers/acpi/acpica/nsload.c                       |    1 -
 drivers/acpi/acpica/nsnames.c                      |    6 +-
 drivers/acpi/acpica/nsparse.c                      |    5 +-
 drivers/acpi/acpica/nsprepkg.c                     |   10 ++-
 drivers/acpi/acpica/nsrepair.c                     |    6 +-
 drivers/acpi/acpica/nsrepair2.c                    |   22 ++++--
 drivers/acpi/acpica/nsutils.c                      |    8 +-
 drivers/acpi/acpica/nsxfeval.c                     |    4 +-
 drivers/acpi/acpica/nsxfname.c                     |    1 +
 drivers/acpi/acpica/nsxfobj.c                      |    6 +-
 drivers/acpi/acpica/psargs.c                       |    1 +
 drivers/acpi/acpica/psloop.c                       |    4 +-
 drivers/acpi/acpica/psparse.c                      |    8 +-
 drivers/acpi/acpica/psutils.c                      |    4 +-
 drivers/acpi/acpica/pswalk.c                       |    1 +
 drivers/acpi/acpica/rsaddr.c                       |    4 +-
 drivers/acpi/acpica/rscalc.c                       |   81 ++++++++++----------
 drivers/acpi/acpica/rscreate.c                     |   32 ++++----
 drivers/acpi/acpica/rsdump.c                       |    6 ++
 drivers/acpi/acpica/rslist.c                       |    9 ++-
 drivers/acpi/acpica/rsmisc.c                       |   22 +++---
 drivers/acpi/acpica/rsutils.c                      |   42 +++++-----
 drivers/acpi/acpica/rsxface.c                      |    2 +-
 drivers/acpi/acpica/tbdata.c                       |    1 +
 drivers/acpi/acpica/tbinstal.c                     |    4 +-
 drivers/acpi/acpica/tbprint.c                      |    1 +
 drivers/acpi/acpica/tbutils.c                      |    2 +-
 drivers/acpi/acpica/tbxfload.c                     |    1 +
 drivers/acpi/acpica/utcopy.c                       |   23 +++---
 drivers/acpi/acpica/utdecode.c                     |    3 +-
 drivers/acpi/acpica/utdelete.c                     |    5 +-
 drivers/acpi/acpica/uterror.c                      |   10 +--
 drivers/acpi/acpica/utfileio.c                     |    2 +
 drivers/acpi/acpica/utmath.c                       |   10 ++-
 drivers/acpi/acpica/utmisc.c                       |   11 +--
 drivers/acpi/acpica/utmutex.c                      |    5 +-
 drivers/acpi/acpica/utnonansi.c                    |    4 +-
 drivers/acpi/acpica/utobject.c                     |   20 +++--
 drivers/acpi/acpica/utosi.c                        |   11 +--
 drivers/acpi/acpica/utownerid.c                    |   12 +--
 drivers/acpi/acpica/utpredef.c                     |    6 +-
 drivers/acpi/acpica/utprint.c                      |   15 ++--
 drivers/acpi/acpica/utresrc.c                      |    8 +-
 drivers/acpi/acpica/utstate.c                      |    3 +
 drivers/acpi/acpica/utstring.c                     |    1 +
 drivers/acpi/acpica/uttrack.c                      |   50 ++++++------
 drivers/acpi/acpica/utxface.c                      |    2 -
 drivers/acpi/acpica/utxferror.c                    |    1 +
 drivers/acpi/acpica/utxfmutex.c                    |    6 +-
 tools/power/acpi/common/getopt.c                   |    1 +
 .../acpi/os_specific/service_layers/oslibcfs.c     |    3 +
 tools/power/acpi/tools/acpidump/apfiles.c          |   13 ++++
 100 files changed, 634 insertions(+), 493 deletions(-)

diff --git a/drivers/acpi/acpica/dbstats.c b/drivers/acpi/acpica/dbstats.c
index 4ba0a20..de255d9 100644
--- a/drivers/acpi/acpica/dbstats.c
+++ b/drivers/acpi/acpica/dbstats.c
@@ -382,6 +382,7 @@ acpi_status acpi_db_display_statistics(char *type_arg)
 				       acpi_gbl_node_type_count[i],
 				       acpi_gbl_obj_type_count[i]);
 		}
+
 		acpi_os_printf("%16.16s % 10ld% 10ld\n", "Misc/Unknown",
 			       acpi_gbl_node_type_count_misc,
 			       acpi_gbl_obj_type_count_misc);
diff --git a/drivers/acpi/acpica/dbutils.c b/drivers/acpi/acpica/dbutils.c
index 86790e0..8c85d85 100644
--- a/drivers/acpi/acpica/dbutils.c
+++ b/drivers/acpi/acpica/dbutils.c
@@ -173,6 +173,7 @@ void acpi_db_dump_external_object(union acpi_object *obj_desc, u32 level)
 			if (obj_desc->buffer.length > 16) {
 				acpi_os_printf("\n");
 			}
+
 			acpi_ut_debug_dump_buffer(ACPI_CAST_PTR
 						  (u8,
 						   obj_desc->buffer.pointer),
diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
index e2ab59e..76cfced 100644
--- a/drivers/acpi/acpica/dsargs.c
+++ b/drivers/acpi/acpica/dsargs.c
@@ -194,8 +194,8 @@ acpi_ds_get_buffer_field_arguments(union acpi_operand_object *obj_desc)
 	extra_desc = acpi_ns_get_secondary_object(obj_desc);
 	node = obj_desc->buffer_field.node;
 
-	ACPI_DEBUG_EXEC(acpi_ut_display_init_pathname(ACPI_TYPE_BUFFER_FIELD,
-						      node, NULL));
+	ACPI_DEBUG_EXEC(acpi_ut_display_init_pathname
+			(ACPI_TYPE_BUFFER_FIELD, node, NULL));
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "[%4.4s] BufferField Arg Init\n",
 			  acpi_ut_get_node_name(node)));
@@ -385,7 +385,8 @@ acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *obj_desc)
 	ACPI_DEBUG_EXEC(acpi_ut_display_init_pathname
 			(ACPI_TYPE_REGION, node, NULL));
 
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "[%4.4s] OpRegion Arg Init at AML %p\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+			  "[%4.4s] OpRegion Arg Init at AML %p\n",
 			  acpi_ut_get_node_name(node),
 			  extra_desc->extra.aml_start));
 
diff --git a/drivers/acpi/acpica/dsdebug.c b/drivers/acpi/acpica/dsdebug.c
index 309556e..1eb82bd 100644
--- a/drivers/acpi/acpica/dsdebug.c
+++ b/drivers/acpi/acpica/dsdebug.c
@@ -161,6 +161,7 @@ acpi_ds_dump_method_stack(acpi_status status,
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 			  "\n**** Exception %s during execution of method ",
 			  acpi_format_exception(status)));
+
 	acpi_ds_print_node_pathname(walk_state->method_node, NULL);
 
 	/* Display stack of executing methods */
@@ -203,8 +204,8 @@ acpi_ds_dump_method_stack(acpi_status status,
 		} else {
 			/*
 			 * This method has called another method
-			 * NOTE: the method call parse subtree is already deleted at this
-			 * point, so we cannot disassemble the method invocation.
+			 * NOTE: the method call parse subtree is already deleted at
+			 * this point, so we cannot disassemble the method invocation.
 			 */
 			ACPI_DEBUG_PRINT_RAW((ACPI_DB_DISPATCH,
 					      "Call to method "));
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index 37e11a3..6bca0ec 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -106,6 +106,7 @@ acpi_ds_create_external_region(acpi_status lookup_status,
 	 * insert the name into the namespace.
 	 */
 	acpi_dm_add_op_to_external_list(op, path, ACPI_TYPE_REGION, 0, 0);
+
 	status = acpi_ns_lookup(walk_state->scope_info, path, ACPI_TYPE_REGION,
 				ACPI_IMODE_LOAD_PASS1, ACPI_NS_SEARCH_PARENT,
 				walk_state, node);
@@ -202,11 +203,10 @@ acpi_ds_create_buffer_field(union acpi_parse_object *op,
 
 		/* Enter the name_string into the namespace */
 
-		status =
-		    acpi_ns_lookup(walk_state->scope_info,
-				   arg->common.value.string, ACPI_TYPE_ANY,
-				   ACPI_IMODE_LOAD_PASS1, flags, walk_state,
-				   &node);
+		status = acpi_ns_lookup(walk_state->scope_info,
+					arg->common.value.string, ACPI_TYPE_ANY,
+					ACPI_IMODE_LOAD_PASS1, flags,
+					walk_state, &node);
 		if (ACPI_FAILURE(status)) {
 			ACPI_ERROR_NAMESPACE(arg->common.value.string, status);
 			return_ACPI_STATUS(status);
@@ -244,8 +244,8 @@ acpi_ds_create_buffer_field(union acpi_parse_object *op,
 	}
 
 	/*
-	 * Remember location in AML stream of the field unit opcode and operands --
-	 * since the buffer and index operands must be evaluated.
+	 * Remember location in AML stream of the field unit opcode and operands
+	 * -- since the buffer and index operands must be evaluated.
 	 */
 	second_desc = obj_desc->common.next_object;
 	second_desc->extra.aml_start = op->named.data;
@@ -310,8 +310,8 @@ acpi_ds_get_field_names(struct acpi_create_field_info *info,
 		switch (arg->common.aml_opcode) {
 		case AML_INT_RESERVEDFIELD_OP:
 
-			position = (u64)info->field_bit_position
-			    + (u64)arg->common.value.size;
+			position = (u64)info->field_bit_position +
+			    (u64)arg->common.value.size;
 
 			if (position > ACPI_UINT32_MAX) {
 				ACPI_ERROR((AE_INFO,
@@ -344,13 +344,13 @@ acpi_ds_get_field_names(struct acpi_create_field_info *info,
 
 			/* access_attribute (attrib_quick, attrib_byte, etc.) */
 
-			info->attribute =
-			    (u8)((arg->common.value.integer >> 8) & 0xFF);
+			info->attribute = (u8)
+			    ((arg->common.value.integer >> 8) & 0xFF);
 
 			/* access_length (for serial/buffer protocols) */
 
-			info->access_length =
-			    (u8)((arg->common.value.integer >> 16) & 0xFF);
+			info->access_length = (u8)
+			    ((arg->common.value.integer >> 16) & 0xFF);
 			break;
 
 		case AML_INT_CONNECTION_OP:
@@ -425,8 +425,8 @@ acpi_ds_get_field_names(struct acpi_create_field_info *info,
 
 			/* Keep track of bit position for the next field */
 
-			position = (u64)info->field_bit_position
-			    + (u64)arg->common.value.size;
+			position = (u64)info->field_bit_position +
+			    (u64)arg->common.value.size;
 
 			if (position > ACPI_UINT32_MAX) {
 				ACPI_ERROR((AE_INFO,
@@ -716,11 +716,12 @@ acpi_ds_create_bank_field(union acpi_parse_object *op,
 
 	/*
 	 * Use Info.data_register_node to store bank_field Op
-	 * It's safe because data_register_node will never be used when create bank field
-	 * We store aml_start and aml_length in the bank_field Op for late evaluation
-	 * Used in acpi_ex_prep_field_value(Info)
+	 * It's safe because data_register_node will never be used when create
+	 * bank field \we store aml_start and aml_length in the bank_field Op for
+	 * late evaluation. Used in acpi_ex_prep_field_value(Info)
 	 *
-	 * TBD: Or, should we add a field in struct acpi_create_field_info, like "void *ParentOp"?
+	 * TBD: Or, should we add a field in struct acpi_create_field_info, like
+	 * "void *ParentOp"?
 	 */
 	info.data_register_node = (struct acpi_namespace_node *)op;
 
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index 920f1b1..c1d8af8 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -247,7 +247,7 @@ acpi_ds_initialize_objects(u32 table_index,
 	/* Summary of objects initialized */
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "Table [%4.4s:%8.8s] (id %.2X) - %4u Objects with %3u Devices, "
+			      "Table [%4.4s: %-8.8s] (id %.2X) - %4u Objects with %3u Devices, "
 			      "%3u Regions, %4u Methods (%u/%u/%u Serial/Non/Cvt)\n",
 			      table->signature, table->oem_table_id, owner_id,
 			      info.object_count, info.device_count,
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 49ba082..6585e8e 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -118,10 +118,9 @@ acpi_ds_auto_serialize_method(struct acpi_namespace_node *node,
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
-	status =
-	    acpi_ds_init_aml_walk(walk_state, op, node,
-				  obj_desc->method.aml_start,
-				  obj_desc->method.aml_length, NULL, 0);
+	status = acpi_ds_init_aml_walk(walk_state, op, node,
+				       obj_desc->method.aml_start,
+				       obj_desc->method.aml_length, NULL, 0);
 	if (ACPI_FAILURE(status)) {
 		acpi_ds_delete_walk_state(walk_state);
 		acpi_ps_free_op(op);
@@ -375,7 +374,8 @@ acpi_ds_begin_method_execution(struct acpi_namespace_node *method_node,
 		    && (walk_state->thread->current_sync_level >
 			obj_desc->method.mutex->mutex.sync_level)) {
 			ACPI_ERROR((AE_INFO,
-				    "Cannot acquire Mutex for method [%4.4s], current SyncLevel is too large (%u)",
+				    "Cannot acquire Mutex for method [%4.4s]"
+				    ", current SyncLevel is too large (%u)",
 				    acpi_ut_get_node_name(method_node),
 				    walk_state->thread->current_sync_level));
 
@@ -512,16 +512,18 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 
 	/* Init for new method, possibly wait on method mutex */
 
-	status = acpi_ds_begin_method_execution(method_node, obj_desc,
-						this_walk_state);
+	status =
+	    acpi_ds_begin_method_execution(method_node, obj_desc,
+					   this_walk_state);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
 
 	/* Begin method parse/execution. Create a new walk state */
 
-	next_walk_state = acpi_ds_create_walk_state(obj_desc->method.owner_id,
-						    NULL, obj_desc, thread);
+	next_walk_state =
+	    acpi_ds_create_walk_state(obj_desc->method.owner_id, NULL, obj_desc,
+				      thread);
 	if (!next_walk_state) {
 		status = AE_NO_MEMORY;
 		goto cleanup;
@@ -808,7 +810,8 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 		    info_flags & ACPI_METHOD_SERIALIZED_PENDING) {
 			if (walk_state) {
 				ACPI_INFO((AE_INFO,
-					   "Marking method %4.4s as Serialized because of AE_ALREADY_EXISTS error",
+					   "Marking method %4.4s as Serialized "
+					   "because of AE_ALREADY_EXISTS error",
 					   walk_state->method_node->name.
 					   ascii));
 			}
@@ -826,6 +829,7 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 			 */
 			method_desc->method.info_flags &=
 			    ~ACPI_METHOD_SERIALIZED_PENDING;
+
 			method_desc->method.info_flags |=
 			    (ACPI_METHOD_SERIALIZED |
 			     ACPI_METHOD_IGNORE_SYNC_LEVEL);
diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index 2e4c42b..03c44f2 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -99,6 +99,7 @@ void acpi_ds_method_data_init(struct acpi_walk_state *walk_state)
 	for (i = 0; i < ACPI_METHOD_NUM_ARGS; i++) {
 		ACPI_MOVE_32_TO_32(&walk_state->arguments[i].name,
 				   NAMEOF_ARG_NTE);
+
 		walk_state->arguments[i].name.integer |= (i << 24);
 		walk_state->arguments[i].descriptor_type = ACPI_DESC_TYPE_NAMED;
 		walk_state->arguments[i].type = ACPI_TYPE_ANY;
@@ -201,7 +202,7 @@ acpi_ds_method_data_init_args(union acpi_operand_object **params,
 
 	if (!params) {
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "No param list passed to method\n"));
+				  "No parameter list passed to method\n"));
 		return_ACPI_STATUS(AE_OK);
 	}
 
@@ -214,9 +215,9 @@ acpi_ds_method_data_init_args(union acpi_operand_object **params,
 		 * Store the argument in the method/walk descriptor.
 		 * Do not copy the arg in order to implement call by reference
 		 */
-		status = acpi_ds_method_data_set_value(ACPI_REFCLASS_ARG, index,
-						       params[index],
-						       walk_state);
+		status =
+		    acpi_ds_method_data_set_value(ACPI_REFCLASS_ARG, index,
+						  params[index], walk_state);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
@@ -610,11 +611,11 @@ acpi_ds_store_object_to_local(u8 type,
 			 * do the indirect store
 			 */
 			if ((ACPI_GET_DESCRIPTOR_TYPE(current_obj_desc) ==
-			     ACPI_DESC_TYPE_OPERAND)
-			    && (current_obj_desc->common.type ==
-				ACPI_TYPE_LOCAL_REFERENCE)
-			    && (current_obj_desc->reference.class ==
-				ACPI_REFCLASS_REFOF)) {
+			     ACPI_DESC_TYPE_OPERAND) &&
+			    (current_obj_desc->common.type ==
+			     ACPI_TYPE_LOCAL_REFERENCE) &&
+			    (current_obj_desc->reference.class ==
+			     ACPI_REFCLASS_REFOF)) {
 				ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 						  "Arg (%p) is an ObjRef(Node), storing in node %p\n",
 						  new_obj_desc,
@@ -638,6 +639,7 @@ acpi_ds_store_object_to_local(u8 type,
 				if (new_obj_desc != obj_desc) {
 					acpi_ut_remove_reference(new_obj_desc);
 				}
+
 				return_ACPI_STATUS(status);
 			}
 		}
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 2beb7fd..302c91f 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -463,10 +463,10 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 						  arg->common.node);
 			}
 		} else {
-			status = acpi_ds_build_internal_object(walk_state, arg,
-							       &obj_desc->
-							       package.
-							       elements[i]);
+			status =
+			    acpi_ds_build_internal_object(walk_state, arg,
+							  &obj_desc->package.
+							  elements[i]);
 		}
 
 		if (*obj_desc_ptr) {
@@ -525,7 +525,8 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 		}
 
 		ACPI_INFO((AE_INFO,
-			   "Actual Package length (%u) is larger than NumElements field (%u), truncated",
+			   "Actual Package length (%u) is larger than "
+			   "NumElements field (%u), truncated",
 			   i, element_count));
 	} else if (i < element_count) {
 		/*
@@ -533,7 +534,8 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 		 * Note: this is not an error, the package is padded out with NULLs.
 		 */
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Package List length (%u) smaller than NumElements count (%u), padded with null elements\n",
+				  "Package List length (%u) smaller than NumElements "
+				  "count (%u), padded with null elements\n",
 				  i, element_count));
 	}
 
@@ -584,8 +586,9 @@ acpi_ds_create_node(struct acpi_walk_state *walk_state,
 
 	/* Build an internal object for the argument(s) */
 
-	status = acpi_ds_build_internal_object(walk_state, op->common.value.arg,
-					       &obj_desc);
+	status =
+	    acpi_ds_build_internal_object(walk_state, op->common.value.arg,
+					  &obj_desc);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 81d7b986..1edd66f 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -243,8 +243,9 @@ acpi_ds_init_buffer_field(u16 aml_opcode,
 	 * For field_flags, use LOCK_RULE = 0 (NO_LOCK),
 	 * UPDATE_RULE = 0 (UPDATE_PRESERVE)
 	 */
-	status = acpi_ex_prep_common_field_object(obj_desc, field_flags, 0,
-						  bit_offset, bit_count);
+	status =
+	    acpi_ex_prep_common_field_object(obj_desc, field_flags, 0,
+					     bit_offset, bit_count);
 	if (ACPI_FAILURE(status)) {
 		goto cleanup;
 	}
@@ -330,8 +331,9 @@ acpi_ds_eval_buffer_field_operands(struct acpi_walk_state *walk_state,
 
 	/* Resolve the operands */
 
-	status = acpi_ex_resolve_operands(op->common.aml_opcode,
-					  ACPI_WALK_OPERANDS, walk_state);
+	status =
+	    acpi_ex_resolve_operands(op->common.aml_opcode, ACPI_WALK_OPERANDS,
+				     walk_state);
 	if (ACPI_FAILURE(status)) {
 		ACPI_ERROR((AE_INFO, "(%s) bad operand(s), status 0x%X",
 			    acpi_ps_get_opcode_name(op->common.aml_opcode),
@@ -414,8 +416,9 @@ acpi_ds_eval_region_operands(struct acpi_walk_state *walk_state,
 
 	/* Resolve the length and address operands to numbers */
 
-	status = acpi_ex_resolve_operands(op->common.aml_opcode,
-					  ACPI_WALK_OPERANDS, walk_state);
+	status =
+	    acpi_ex_resolve_operands(op->common.aml_opcode, ACPI_WALK_OPERANDS,
+				     walk_state);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -452,7 +455,6 @@ acpi_ds_eval_region_operands(struct acpi_walk_state *walk_state,
 	/* Now the address and length are valid for this opregion */
 
 	obj_desc->region.flags |= AOPOBJ_DATA_VALID;
-
 	return_ACPI_STATUS(status);
 }
 
@@ -510,8 +512,9 @@ acpi_ds_eval_table_region_operands(struct acpi_walk_state *walk_state,
 	 * Resolve the Signature string, oem_id string,
 	 * and oem_table_id string operands
 	 */
-	status = acpi_ex_resolve_operands(op->common.aml_opcode,
-					  ACPI_WALK_OPERANDS, walk_state);
+	status =
+	    acpi_ex_resolve_operands(op->common.aml_opcode, ACPI_WALK_OPERANDS,
+				     walk_state);
 	if (ACPI_FAILURE(status)) {
 		goto cleanup;
 	}
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index cecba39..fa8e292 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -245,9 +245,9 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 			 * we will use the return value
 			 */
 			if ((walk_state->control_state->common.state ==
-			     ACPI_CONTROL_PREDICATE_EXECUTING)
-			    && (walk_state->control_state->control.
-				predicate_op == op)) {
+			     ACPI_CONTROL_PREDICATE_EXECUTING) &&
+			    (walk_state->control_state->control.predicate_op ==
+			     op)) {
 				goto result_used;
 			}
 			break;
@@ -481,10 +481,9 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 
 		/* Get the entire name string from the AML stream */
 
-		status =
-		    acpi_ex_get_name_string(ACPI_TYPE_ANY,
-					    arg->common.value.buffer,
-					    &name_string, &name_length);
+		status = acpi_ex_get_name_string(ACPI_TYPE_ANY,
+						 arg->common.value.buffer,
+						 &name_string, &name_length);
 
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
@@ -503,9 +502,8 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 		 */
 		if ((walk_state->deferred_node) &&
 		    (walk_state->deferred_node->type == ACPI_TYPE_BUFFER_FIELD)
-		    && (arg_index ==
-			(u32)((walk_state->opcode ==
-			       AML_CREATE_FIELD_OP) ? 3 : 2))) {
+		    && (arg_index == (u32)
+			((walk_state->opcode == AML_CREATE_FIELD_OP) ? 3 : 2))) {
 			obj_desc =
 			    ACPI_CAST_PTR(union acpi_operand_object,
 					  walk_state->deferred_node);
@@ -522,9 +520,10 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 			op_info =
 			    acpi_ps_get_opcode_info(parent_op->common.
 						    aml_opcode);
-			if ((op_info->flags & AML_NSNODE)
-			    && (parent_op->common.aml_opcode !=
-				AML_INT_METHODCALL_OP)
+
+			if ((op_info->flags & AML_NSNODE) &&
+			    (parent_op->common.aml_opcode !=
+			     AML_INT_METHODCALL_OP)
 			    && (parent_op->common.aml_opcode != AML_REGION_OP)
 			    && (parent_op->common.aml_opcode !=
 				AML_INT_NAMEPATH_OP)) {
@@ -633,8 +632,8 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 			return_ACPI_STATUS(AE_NOT_IMPLEMENTED);
 		}
 
-		if ((op_info->flags & AML_HAS_RETVAL)
-		    || (arg->common.flags & ACPI_PARSEOP_IN_STACK)) {
+		if ((op_info->flags & AML_HAS_RETVAL) ||
+		    (arg->common.flags & ACPI_PARSEOP_IN_STACK)) {
 			ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 					  "Argument previously created, already stacked\n"));
 
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 9cc5761..ed2f1d3 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -172,7 +172,8 @@ acpi_ds_get_predicate_value(struct acpi_walk_state *walk_state,
 
 cleanup:
 
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Completed a predicate eval=%X Op=%p\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+			  "Completed a predicate eval=%X Op=%p\n",
 			  walk_state->control_state->common.value,
 			  walk_state->op));
 
@@ -263,8 +264,8 @@ acpi_ds_exec_begin_op(struct acpi_walk_state *walk_state,
 	    (walk_state->control_state->common.state ==
 	     ACPI_CONTROL_CONDITIONAL_EXECUTING)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "Exec predicate Op=%p State=%p\n", op,
-				  walk_state));
+				  "Exec predicate Op=%p State=%p\n",
+				  op, walk_state));
 
 		walk_state->control_state->common.state =
 		    ACPI_CONTROL_PREDICATE_EXECUTING;
@@ -500,9 +501,8 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 						  "Method Reference in a Package, Op=%p\n",
 						  op));
 
-				op->common.node =
-				    (struct acpi_namespace_node *)op->asl.value.
-				    arg->asl.node;
+				op->common.node = (struct acpi_namespace_node *)
+				    op->asl.value.arg->asl.node;
 				acpi_ut_add_reference(op->asl.value.arg->asl.
 						      node->object);
 				return_ACPI_STATUS(AE_OK);
@@ -584,8 +584,8 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 				 * Put the Node on the object stack (Contains the ACPI Name
 				 * of this object)
 				 */
-				walk_state->operands[0] =
-				    (void *)op->common.parent->common.node;
+				walk_state->operands[0] = (void *)
+				    op->common.parent->common.node;
 				walk_state->num_operands = 1;
 
 				status = acpi_ds_create_node(walk_state,
@@ -690,7 +690,8 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 		default:
 
 			ACPI_ERROR((AE_INFO,
-				    "Unimplemented opcode, class=0x%X type=0x%X Opcode=0x%X Op=%p",
+				    "Unimplemented opcode, class=0x%X "
+				    "type=0x%X Opcode=0x%X Op=%p",
 				    op_class, op_type, op->common.aml_opcode,
 				    op));
 
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 097188a..b325474 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -476,13 +476,9 @@ acpi_status acpi_ds_load1_end_op(struct acpi_walk_state *walk_state)
 			status =
 			    acpi_ex_create_region(op->named.data,
 						  op->named.length,
-						  (acpi_adr_space_type) ((op->
-									  common.
-									  value.
-									  arg)->
-									 common.
-									 value.
-									 integer),
+						  (acpi_adr_space_type)
+						  ((op->common.value.arg)->
+						   common.value.integer),
 						  walk_state);
 			if (ACPI_FAILURE(status)) {
 				return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index e2c08cd..8a32153 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -598,11 +598,10 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 				 * Executing a method: initialize the region and unlock
 				 * the interpreter
 				 */
-				status =
-				    acpi_ex_create_region(op->named.data,
-							  op->named.length,
-							  region_space,
-							  walk_state);
+				status = acpi_ex_create_region(op->named.data,
+							       op->named.length,
+							       region_space,
+							       walk_state);
 				if (ACPI_FAILURE(status)) {
 					return_ACPI_STATUS(status);
 				}
@@ -664,6 +663,7 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 								  length,
 								  walk_state);
 				}
+
 				walk_state->operands[0] = NULL;
 				walk_state->num_operands = 0;
 
diff --git a/drivers/acpi/acpica/dswscope.c b/drivers/acpi/acpica/dswscope.c
index 43b3ea4..2d7a044 100644
--- a/drivers/acpi/acpica/dswscope.c
+++ b/drivers/acpi/acpica/dswscope.c
@@ -77,6 +77,7 @@ void acpi_ds_scope_stack_clear(struct acpi_walk_state *walk_state)
 				  "Popped object type (%s)\n",
 				  acpi_ut_get_type_name(scope_info->common.
 							value)));
+
 		acpi_ut_delete_generic_state(scope_info);
 	}
 }
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index ccf7932..112e821 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -92,8 +92,8 @@ acpi_ev_update_gpe_enable_mask(struct acpi_gpe_event_info *gpe_event_info)
 		ACPI_SET_BIT(gpe_register_info->enable_for_run,
 			     (u8)register_bit);
 	}
-	gpe_register_info->enable_mask = gpe_register_info->enable_for_run;
 
+	gpe_register_info->enable_mask = gpe_register_info->enable_for_run;
 	return_ACPI_STATUS(AE_OK);
 }
 
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index e0f24c5..c00a9f2 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -167,6 +167,7 @@ acpi_status acpi_ev_delete_gpe_block(struct acpi_gpe_block_info *gpe_block)
 		if (gpe_block->next) {
 			gpe_block->next->previous = gpe_block->previous;
 		}
+
 		acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	}
 
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index 3a958f3..fd5ab90 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -346,6 +346,7 @@ acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 					ACPI_FREE(notify);
 					notify = next;
 				}
+
 				gpe_event_info->dispatch.notify_list = NULL;
 				gpe_event_info->flags &=
 				    ~ACPI_GPE_DISPATCH_MASK;
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index f7c9dfe..8866f50 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -68,6 +68,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context);
 
 u8 acpi_ev_is_notify_object(struct acpi_namespace_node *node)
 {
+
 	switch (node->type) {
 	case ACPI_TYPE_DEVICE:
 	case ACPI_TYPE_PROCESSOR:
@@ -170,8 +171,8 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 			  acpi_ut_get_notify_name(notify_value, ACPI_TYPE_ANY),
 			  node));
 
-	status = acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_ev_notify_dispatch,
-				 info);
+	status = acpi_os_execute(OSL_NOTIFY_HANDLER,
+				 acpi_ev_notify_dispatch, info);
 	if (ACPI_FAILURE(status)) {
 		acpi_ut_delete_generic_state(info);
 	}
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 07d22bf..012b9de 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -879,9 +879,8 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 
 	ACPI_FUNCTION_TRACE(acpi_install_gpe_handler);
 
-	status =
-	    acpi_ev_install_gpe_handler(gpe_device, gpe_number, type, FALSE,
-					address, context);
+	status = acpi_ev_install_gpe_handler(gpe_device, gpe_number, type,
+					     FALSE, address, context);
 
 	return_ACPI_STATUS(status);
 }
@@ -914,8 +913,8 @@ acpi_install_gpe_raw_handler(acpi_handle gpe_device,
 
 	ACPI_FUNCTION_TRACE(acpi_install_gpe_raw_handler);
 
-	status = acpi_ev_install_gpe_handler(gpe_device, gpe_number, type, TRUE,
-					     address, context);
+	status = acpi_ev_install_gpe_handler(gpe_device, gpe_number, type,
+					     TRUE, address, context);
 
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index f21afba..dbd9f16 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -135,6 +135,7 @@ acpi_install_address_space_handler(acpi_handle device,
 		if (!acpi_gbl_reg_methods_executed) {
 
 			/* We will defer execution of the _REG methods for this space */
+
 			goto unlock_and_exit;
 		}
 		break;
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index b540913..adcb9c7 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -358,8 +358,8 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		}
 
 		/*
-		 * If the Region Address and Length have not been previously evaluated,
-		 * evaluate them now and save the results.
+		 * If the Region Address and Length have not been previously
+		 * evaluated, evaluate them now and save the results.
 		 */
 		if (!(obj_desc->common.flags & AOPOBJ_DATA_VALID)) {
 			status = acpi_ds_get_region_arguments(obj_desc);
@@ -454,8 +454,8 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		}
 
 		/*
-		 * Copy the table from the buffer because the buffer could be modified
-		 * or even deleted in the future
+		 * Copy the table from the buffer because the buffer could be
+		 * modified or even deleted in the future
 		 */
 		table = ACPI_ALLOCATE(length);
 		if (!table) {
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index 145de28..73c2e82 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -227,8 +227,8 @@ acpi_ex_convert_to_buffer(union acpi_operand_object *obj_desc,
 		/* Copy the integer to the buffer, LSB first */
 
 		new_buf = return_desc->buffer.pointer;
-		memcpy(new_buf,
-		       &obj_desc->integer.value, acpi_gbl_integer_byte_width);
+		memcpy(new_buf, &obj_desc->integer.value,
+		       acpi_gbl_integer_byte_width);
 		break;
 
 	case ACPI_TYPE_STRING:
@@ -354,9 +354,8 @@ acpi_ex_convert_to_ascii(u64 integer, u16 base, u8 *string, u8 data_width)
 
 			/* Get one hex digit, most significant digits first */
 
-			string[k] =
-			    (u8)acpi_ut_hex_to_ascii_char(integer,
-							  ACPI_MUL_4(j));
+			string[k] = (u8)
+			    acpi_ut_hex_to_ascii_char(integer, ACPI_MUL_4(j));
 			k++;
 		}
 		break;
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 95fe464..0f34446 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -189,9 +189,9 @@ acpi_status acpi_ex_create_event(struct acpi_walk_state *walk_state)
 
 	/* Attach object to the Node */
 
-	status =
-	    acpi_ns_attach_object((struct acpi_namespace_node *)walk_state->
-				  operands[0], obj_desc, ACPI_TYPE_EVENT);
+	status = acpi_ns_attach_object((struct acpi_namespace_node *)
+				       walk_state->operands[0], obj_desc,
+				       ACPI_TYPE_EVENT);
 
 cleanup:
 	/*
@@ -493,8 +493,8 @@ acpi_ex_create_method(u8 * aml_start,
 	 * flag, and sync_level for efficiency.
 	 */
 	method_flags = (u8)operand[1]->integer.value;
-	obj_desc->method.param_count =
-	    (u8)(method_flags & AML_METHOD_ARG_COUNT);
+	obj_desc->method.param_count = (u8)
+	    (method_flags & AML_METHOD_ARG_COUNT);
 
 	/*
 	 * Get the sync_level. If method is serialized, a mutex will be
diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
index de92458..665a4b9 100644
--- a/drivers/acpi/acpica/exdebug.c
+++ b/drivers/acpi/acpica/exdebug.c
@@ -491,6 +491,7 @@ acpi_ex_start_trace_method(struct acpi_namespace_node *method_node,
 			acpi_dbg_layer = acpi_gbl_trace_dbg_layer;
 		}
 	}
+
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 
 exit:
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index c95fd18..ad7080b 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -167,10 +167,11 @@ acpi_ex_read_data_from_field(struct acpi_walk_state * walk_state,
 		    || obj_desc->field.region_obj->region.space_id ==
 		    ACPI_ADR_SPACE_IPMI)) {
 		/*
-		 * This is an SMBus, GSBus or IPMI read. We must create a buffer to hold
-		 * the data and then directly access the region handler.
+		 * This is an SMBus, GSBus or IPMI read. We must create a buffer to
+		 * hold the data and then directly access the region handler.
 		 *
-		 * Note: SMBus and GSBus protocol value is passed in upper 16-bits of Function
+		 * Note: SMBus and GSBus protocol value is passed in upper 16-bits
+		 * of Function
 		 */
 		if (obj_desc->field.region_obj->region.space_id ==
 		    ACPI_ADR_SPACE_SMBUS) {
@@ -180,17 +181,17 @@ acpi_ex_read_data_from_field(struct acpi_walk_state * walk_state,
 		} else if (obj_desc->field.region_obj->region.space_id ==
 			   ACPI_ADR_SPACE_GSBUS) {
 			accessor_type = obj_desc->field.attribute;
-			length = acpi_ex_get_serial_access_length(accessor_type,
-								  obj_desc->
-								  field.
-								  access_length);
+			length =
+			    acpi_ex_get_serial_access_length(accessor_type,
+							     obj_desc->field.
+							     access_length);
 
 			/*
 			 * Add additional 2 bytes for the generic_serial_bus data buffer:
 			 *
-			 *     Status;      (Byte 0 of the data buffer)
-			 *     Length;      (Byte 1 of the data buffer)
-			 *     Data[x-1];   (Bytes 2-x of the arbitrary length data buffer)
+			 *     Status;    (Byte 0 of the data buffer)
+			 *     Length;    (Byte 1 of the data buffer)
+			 *     Data[x-1]: (Bytes 2-x of the arbitrary length data buffer)
 			 */
 			length += 2;
 			function = ACPI_READ | (accessor_type << 16);
@@ -216,6 +217,7 @@ acpi_ex_read_data_from_field(struct acpi_walk_state * walk_state,
 							     buffer_desc->
 							     buffer.pointer),
 					       function);
+
 		acpi_ex_release_global_lock(obj_desc->common_field.field_flags);
 		goto exit;
 	}
@@ -232,6 +234,7 @@ acpi_ex_read_data_from_field(struct acpi_walk_state * walk_state,
 	 */
 	length =
 	    (acpi_size) ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc->field.bit_length);
+
 	if (length > acpi_gbl_integer_byte_width) {
 
 		/* Field is too large for an Integer, create a Buffer instead */
@@ -273,8 +276,10 @@ acpi_ex_read_data_from_field(struct acpi_walk_state * walk_state,
 
 		/* Perform the write */
 
-		status = acpi_ex_access_region(obj_desc, 0,
-					       (u64 *)buffer, ACPI_READ);
+		status =
+		    acpi_ex_access_region(obj_desc, 0, (u64 *)buffer,
+					  ACPI_READ);
+
 		acpi_ex_release_global_lock(obj_desc->common_field.field_flags);
 		if (ACPI_FAILURE(status)) {
 			acpi_ut_remove_reference(buffer_desc);
@@ -366,19 +371,22 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 		    || obj_desc->field.region_obj->region.space_id ==
 		    ACPI_ADR_SPACE_IPMI)) {
 		/*
-		 * This is an SMBus, GSBus or IPMI write. We will bypass the entire field
-		 * mechanism and handoff the buffer directly to the handler. For
-		 * these address spaces, the buffer is bi-directional; on a write,
-		 * return data is returned in the same buffer.
+		 * This is an SMBus, GSBus or IPMI write. We will bypass the entire
+		 * field mechanism and handoff the buffer directly to the handler.
+		 * For these address spaces, the buffer is bi-directional; on a
+		 * write, return data is returned in the same buffer.
 		 *
 		 * Source must be a buffer of sufficient size:
-		 * ACPI_SMBUS_BUFFER_SIZE, ACPI_GSBUS_BUFFER_SIZE, or ACPI_IPMI_BUFFER_SIZE.
+		 * ACPI_SMBUS_BUFFER_SIZE, ACPI_GSBUS_BUFFER_SIZE, or
+		 * ACPI_IPMI_BUFFER_SIZE.
 		 *
-		 * Note: SMBus and GSBus protocol type is passed in upper 16-bits of Function
+		 * Note: SMBus and GSBus protocol type is passed in upper 16-bits
+		 * of Function
 		 */
 		if (source_desc->common.type != ACPI_TYPE_BUFFER) {
 			ACPI_ERROR((AE_INFO,
-				    "SMBus/IPMI/GenericSerialBus write requires Buffer, found type %s",
+				    "SMBus/IPMI/GenericSerialBus write requires "
+				    "Buffer, found type %s",
 				    acpi_ut_get_object_type_name(source_desc)));
 
 			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
@@ -392,17 +400,17 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 		} else if (obj_desc->field.region_obj->region.space_id ==
 			   ACPI_ADR_SPACE_GSBUS) {
 			accessor_type = obj_desc->field.attribute;
-			length = acpi_ex_get_serial_access_length(accessor_type,
-								  obj_desc->
-								  field.
-								  access_length);
+			length =
+			    acpi_ex_get_serial_access_length(accessor_type,
+							     obj_desc->field.
+							     access_length);
 
 			/*
 			 * Add additional 2 bytes for the generic_serial_bus data buffer:
 			 *
-			 *     Status;      (Byte 0 of the data buffer)
-			 *     Length;      (Byte 1 of the data buffer)
-			 *     Data[x-1];   (Bytes 2-x of the arbitrary length data buffer)
+			 *     Status;    (Byte 0 of the data buffer)
+			 *     Length;    (Byte 1 of the data buffer)
+			 *     Data[x-1]: (Bytes 2-x of the arbitrary length data buffer)
 			 */
 			length += 2;
 			function = ACPI_WRITE | (accessor_type << 16);
@@ -414,7 +422,8 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 
 		if (source_desc->buffer.length < length) {
 			ACPI_ERROR((AE_INFO,
-				    "SMBus/IPMI/GenericSerialBus write requires Buffer of length %u, found length %u",
+				    "SMBus/IPMI/GenericSerialBus write requires "
+				    "Buffer of length %u, found length %u",
 				    length, source_desc->buffer.length));
 
 			return_ACPI_STATUS(AE_AML_BUFFER_LIMIT);
@@ -438,8 +447,8 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 		 * Perform the write (returns status and perhaps data in the
 		 * same buffer)
 		 */
-		status = acpi_ex_access_region(obj_desc, 0,
-					       (u64 *)buffer, function);
+		status =
+		    acpi_ex_access_region(obj_desc, 0, (u64 *)buffer, function);
 		acpi_ex_release_global_lock(obj_desc->common_field.field_flags);
 
 		*result_desc = buffer_desc;
@@ -460,7 +469,7 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 		}
 
 		ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-				  "GPIO FieldWrite [FROM]: (%s:%X), Val %.8X  [TO]:  Pin %u Bits %u\n",
+				  "GPIO FieldWrite [FROM]: (%s:%X), Val %.8X  [TO]: Pin %u Bits %u\n",
 				  acpi_ut_get_type_name(source_desc->common.
 							type),
 				  source_desc->common.type,
@@ -476,8 +485,9 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 
 		/* Perform the write */
 
-		status = acpi_ex_access_region(obj_desc, 0,
-					       (u64 *)buffer, ACPI_WRITE);
+		status =
+		    acpi_ex_access_region(obj_desc, 0, (u64 *)buffer,
+					  ACPI_WRITE);
 		acpi_ex_release_global_lock(obj_desc->common_field.field_flags);
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 70b7bbb..0337191 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -180,7 +180,8 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 			 * byte, and a field with Dword access specified.
 			 */
 			ACPI_ERROR((AE_INFO,
-				    "Field [%4.4s] access width (%u bytes) too large for region [%4.4s] (length %u)",
+				    "Field [%4.4s] access width (%u bytes) "
+				    "too large for region [%4.4s] (length %u)",
 				    acpi_ut_get_node_name(obj_desc->
 							  common_field.node),
 				    obj_desc->common_field.access_byte_width,
@@ -194,7 +195,8 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 		 * exceeds region length, indicate an error
 		 */
 		ACPI_ERROR((AE_INFO,
-			    "Field [%4.4s] Base+Offset+Width %u+%u+%u is beyond end of region [%4.4s] (length %u)",
+			    "Field [%4.4s] Base+Offset+Width %u+%u+%u "
+			    "is beyond end of region [%4.4s] (length %u)",
 			    acpi_ut_get_node_name(obj_desc->common_field.node),
 			    obj_desc->common_field.base_byte_offset,
 			    field_datum_byte_offset,
@@ -638,15 +640,15 @@ acpi_ex_write_with_update_rule(union acpi_operand_object *obj_desc,
 
 			ACPI_ERROR((AE_INFO,
 				    "Unknown UpdateRule value: 0x%X",
-				    (obj_desc->common_field.
-				     field_flags &
+				    (obj_desc->common_field.field_flags &
 				     AML_FIELD_UPDATE_RULE_MASK)));
 			return_ACPI_STATUS(AE_AML_OPERAND_VALUE);
 		}
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-			  "Mask %8.8X%8.8X, DatumOffset %X, Width %X, Value %8.8X%8.8X, MergedValue %8.8X%8.8X\n",
+			  "Mask %8.8X%8.8X, DatumOffset %X, Width %X, "
+			  "Value %8.8X%8.8X, MergedValue %8.8X%8.8X\n",
 			  ACPI_FORMAT_UINT64(mask),
 			  field_datum_byte_offset,
 			  obj_desc->common_field.access_byte_width,
@@ -655,8 +657,9 @@ acpi_ex_write_with_update_rule(union acpi_operand_object *obj_desc,
 
 	/* Write the merged value */
 
-	status = acpi_ex_field_datum_io(obj_desc, field_datum_byte_offset,
-					&merged_value, ACPI_WRITE);
+	status =
+	    acpi_ex_field_datum_io(obj_desc, field_datum_byte_offset,
+				   &merged_value, ACPI_WRITE);
 
 	return_ACPI_STATUS(status);
 }
@@ -764,8 +767,9 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 		/* Get next input datum from the field */
 
 		field_offset += obj_desc->common_field.access_byte_width;
-		status = acpi_ex_field_datum_io(obj_desc, field_offset,
-						&raw_datum, ACPI_READ);
+		status =
+		    acpi_ex_field_datum_io(obj_desc, field_offset, &raw_datum,
+					   ACPI_READ);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
@@ -858,6 +862,7 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 	new_buffer = NULL;
 	required_length =
 	    ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc->common_field.bit_length);
+
 	/*
 	 * We must have a buffer that is at least as long as the field
 	 * we are writing to. This is because individual fields are
@@ -932,9 +937,9 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 		/* Write merged datum to the target field */
 
 		merged_datum &= mask;
-		status = acpi_ex_write_with_update_rule(obj_desc, mask,
-							merged_datum,
-							field_offset);
+		status =
+		    acpi_ex_write_with_update_rule(obj_desc, mask, merged_datum,
+						   field_offset);
 		if (ACPI_FAILURE(status)) {
 			goto exit;
 		}
@@ -990,9 +995,9 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 	/* Write the last datum to the field */
 
 	merged_datum &= mask;
-	status = acpi_ex_write_with_update_rule(obj_desc,
-						mask, merged_datum,
-						field_offset);
+	status =
+	    acpi_ex_write_with_update_rule(obj_desc, mask, merged_datum,
+					   field_offset);
 
 exit:
 	/* Free temporary buffer if we used one */
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index d02afec..b5413bb 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -267,8 +267,9 @@ acpi_ex_do_concatenate(union acpi_operand_object *operand0,
 
 	case ACPI_TYPE_STRING:
 
-		status = acpi_ex_convert_to_string(operand1, &local_operand1,
-						   ACPI_IMPLICIT_CONVERT_HEX);
+		status =
+		    acpi_ex_convert_to_string(operand1, &local_operand1,
+					      ACPI_IMPLICIT_CONVERT_HEX);
 		break;
 
 	case ACPI_TYPE_BUFFER:
@@ -591,8 +592,9 @@ acpi_ex_do_logical_op(u16 opcode,
 
 	case ACPI_TYPE_STRING:
 
-		status = acpi_ex_convert_to_string(operand1, &local_operand1,
-						   ACPI_IMPLICIT_CONVERT_HEX);
+		status =
+		    acpi_ex_convert_to_string(operand1, &local_operand1,
+					      ACPI_IMPLICIT_CONVERT_HEX);
 		break;
 
 	case ACPI_TYPE_BUFFER:
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index 20e8781..b2e911a 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -164,8 +164,8 @@ static acpi_status acpi_ex_name_segment(u8 ** in_aml_address, char *name_string)
 	ACPI_FUNCTION_TRACE(ex_name_segment);
 
 	/*
-	 * If first character is a digit, then we know that we aren't looking at a
-	 * valid name segment
+	 * If first character is a digit, then we know that we aren't looking
+	 * at a valid name segment
 	 */
 	char_buf[0] = *aml_address;
 
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index 7793068..bcdf43c 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -484,22 +484,26 @@ acpi_status acpi_ex_opcode_1A_1T_1R(struct acpi_walk_state *walk_state)
 
 	case AML_TO_DECSTRING_OP:	/* to_decimal_string (Data, Result) */
 
-		status = acpi_ex_convert_to_string(operand[0], &return_desc,
-						   ACPI_EXPLICIT_CONVERT_DECIMAL);
+		status =
+		    acpi_ex_convert_to_string(operand[0], &return_desc,
+					      ACPI_EXPLICIT_CONVERT_DECIMAL);
 		if (return_desc == operand[0]) {
 
 			/* No conversion performed, add ref to handle return value */
+
 			acpi_ut_add_reference(return_desc);
 		}
 		break;
 
 	case AML_TO_HEXSTRING_OP:	/* to_hex_string (Data, Result) */
 
-		status = acpi_ex_convert_to_string(operand[0], &return_desc,
-						   ACPI_EXPLICIT_CONVERT_HEX);
+		status =
+		    acpi_ex_convert_to_string(operand[0], &return_desc,
+					      ACPI_EXPLICIT_CONVERT_HEX);
 		if (return_desc == operand[0]) {
 
 			/* No conversion performed, add ref to handle return value */
+
 			acpi_ut_add_reference(return_desc);
 		}
 		break;
@@ -510,17 +514,20 @@ acpi_status acpi_ex_opcode_1A_1T_1R(struct acpi_walk_state *walk_state)
 		if (return_desc == operand[0]) {
 
 			/* No conversion performed, add ref to handle return value */
+
 			acpi_ut_add_reference(return_desc);
 		}
 		break;
 
 	case AML_TO_INTEGER_OP:	/* to_integer (Data, Result) */
 
-		status = acpi_ex_convert_to_integer(operand[0], &return_desc,
-						    ACPI_ANY_BASE);
+		status =
+		    acpi_ex_convert_to_integer(operand[0], &return_desc,
+					       ACPI_ANY_BASE);
 		if (return_desc == operand[0]) {
 
 			/* No conversion performed, add ref to handle return value */
+
 			acpi_ut_add_reference(return_desc);
 		}
 		break;
@@ -713,9 +720,9 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 
 		/* Get the base object */
 
-		status = acpi_ex_resolve_multiple(walk_state,
-						  operand[0], &type,
-						  &temp_desc);
+		status =
+		    acpi_ex_resolve_multiple(walk_state, operand[0], &type,
+					     &temp_desc);
 		if (ACPI_FAILURE(status)) {
 			goto cleanup;
 		}
@@ -759,8 +766,10 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 		default:
 
 			ACPI_ERROR((AE_INFO,
-				    "Operand must be Buffer/Integer/String/Package - found type %s",
+				    "Operand must be Buffer/Integer/String/Package"
+				    " - found type %s",
 				    acpi_ut_get_type_name(type)));
+
 			status = AE_AML_OPERAND_TYPE;
 			goto cleanup;
 		}
@@ -981,6 +990,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 						    "Unknown Index TargetType 0x%X in reference object %p",
 						    operand[0]->reference.
 						    target_type, operand[0]));
+
 					status = AE_AML_OPERAND_TYPE;
 					goto cleanup;
 				}
@@ -1050,6 +1060,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 
 		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
+
 		status = AE_AML_BAD_OPCODE;
 		goto cleanup;
 	}
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index b8944eb..6dad2ca 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -199,6 +199,7 @@ acpi_status acpi_ex_opcode_2A_2T_1R(struct acpi_walk_state *walk_state)
 
 		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
+
 		status = AE_AML_BAD_OPCODE;
 		goto cleanup;
 	}
@@ -299,8 +300,9 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 
 	case AML_CONCAT_OP:	/* Concatenate (Data1, Data2, Result) */
 
-		status = acpi_ex_do_concatenate(operand[0], operand[1],
-						&return_desc, walk_state);
+		status =
+		    acpi_ex_do_concatenate(operand[0], operand[1], &return_desc,
+					   walk_state);
 		break;
 
 	case AML_TO_STRING_OP:	/* to_string (Buffer, Length, Result) (ACPI 2.0) */
@@ -345,8 +347,9 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 
 		/* concatenate_res_template (Buffer, Buffer, Result) (ACPI 2.0) */
 
-		status = acpi_ex_concat_template(operand[0], operand[1],
-						 &return_desc, walk_state);
+		status =
+		    acpi_ex_concat_template(operand[0], operand[1],
+					    &return_desc, walk_state);
 		break;
 
 	case AML_INDEX_OP:	/* Index (Source Index Result) */
@@ -553,6 +556,7 @@ acpi_status acpi_ex_opcode_2A_0T_1R(struct acpi_walk_state *walk_state)
 
 		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
+
 		status = AE_AML_BAD_OPCODE;
 		goto cleanup;
 	}
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 351b82a..27fb017 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -95,7 +95,8 @@ acpi_status acpi_ex_opcode_3A_0T_0R(struct acpi_walk_state *walk_state)
 	case AML_FATAL_OP:	/* Fatal (fatal_type fatal_code fatal_arg) */
 
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "FatalOp: Type %X Code %X Arg %X <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n",
+				  "FatalOp: Type %X Code %X Arg %X "
+				  "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n",
 				  (u32)operand[0]->integer.value,
 				  (u32)operand[1]->integer.value,
 				  (u32)operand[2]->integer.value));
@@ -131,6 +132,7 @@ acpi_status acpi_ex_opcode_3A_0T_0R(struct acpi_walk_state *walk_state)
 
 		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
+
 		status = AE_AML_BAD_OPCODE;
 		goto cleanup;
 	}
@@ -193,7 +195,8 @@ acpi_status acpi_ex_opcode_3A_1T_1R(struct acpi_walk_state *walk_state)
 		/* Truncate request if larger than the actual String/Buffer */
 
 		else if ((index + length) > operand[0]->string.length) {
-			length = (acpi_size) operand[0]->string.length -
+			length =
+			    (acpi_size) operand[0]->string.length -
 			    (acpi_size) index;
 		}
 
@@ -237,8 +240,8 @@ acpi_status acpi_ex_opcode_3A_1T_1R(struct acpi_walk_state *walk_state)
 
 			/* We have a buffer, copy the portion requested */
 
-			memcpy(buffer, operand[0]->string.pointer + index,
-			       length);
+			memcpy(buffer,
+			       operand[0]->string.pointer + index, length);
 		}
 
 		/* Set the length of the new String/Buffer */
@@ -255,6 +258,7 @@ acpi_status acpi_ex_opcode_3A_1T_1R(struct acpi_walk_state *walk_state)
 
 		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
+
 		status = AE_AML_BAD_OPCODE;
 		goto cleanup;
 	}
@@ -270,12 +274,11 @@ cleanup:
 	if (ACPI_FAILURE(status) || walk_state->result_obj) {
 		acpi_ut_remove_reference(return_desc);
 		walk_state->result_obj = NULL;
-	}
+	} else {
+		/* Set the return object and exit */
 
-	/* Set the return object and exit */
-
-	else {
 		walk_state->result_obj = return_desc;
 	}
+
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index c930edd..7efc9f4 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -310,6 +310,7 @@ acpi_status acpi_ex_opcode_6A_0T_1R(struct acpi_walk_state * walk_state)
 
 		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
+
 		status = AE_AML_BAD_OPCODE;
 		goto cleanup;
 	}
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 4c2836d..1f111cc 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -1,6 +1,6 @@
 /******************************************************************************
  *
- * Module Name: exprep - ACPI AML (p-code) execution - field prep utilities
+ * Module Name: exprep - ACPI AML field prep utilities
  *
  *****************************************************************************/
 
@@ -103,8 +103,10 @@ acpi_ex_generate_access(u32 field_bit_offset,
 	/* Round Field start offset and length to "minimal" byte boundaries */
 
 	field_byte_offset = ACPI_DIV_8(ACPI_ROUND_DOWN(field_bit_offset, 8));
-	field_byte_end_offset = ACPI_DIV_8(ACPI_ROUND_UP(field_bit_length +
-							 field_bit_offset, 8));
+
+	field_byte_end_offset =
+	    ACPI_DIV_8(ACPI_ROUND_UP(field_bit_length + field_bit_offset, 8));
+
 	field_byte_length = field_byte_end_offset - field_byte_offset;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
@@ -159,7 +161,8 @@ acpi_ex_generate_access(u32 field_bit_offset,
 
 			if (accesses <= 1) {
 				ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-						  "Entire field can be accessed with one operation of size %u\n",
+						  "Entire field can be accessed "
+						  "with one operation of size %u\n",
 						  access_byte_width));
 				return_VALUE(access_byte_width);
 			}
@@ -202,6 +205,7 @@ acpi_ex_generate_access(u32 field_bit_offset,
 	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
 			  "Cannot access field in one operation, using width 8\n"));
+
 	return_VALUE(8);
 }
 #endif				/* ACPI_UNDER_DEVELOPMENT */
@@ -281,6 +285,7 @@ acpi_ex_decode_field_access(union acpi_operand_object *obj_desc,
 		/* Invalid field access type */
 
 		ACPI_ERROR((AE_INFO, "Unknown field access type 0x%X", access));
+
 		return_UINT32(0);
 	}
 
@@ -354,8 +359,8 @@ acpi_ex_prep_common_field_object(union acpi_operand_object *obj_desc,
 	 * For all other access types (Byte, Word, Dword, Qword), the Bitwidth is
 	 * the same (equivalent) as the byte_alignment.
 	 */
-	access_bit_width = acpi_ex_decode_field_access(obj_desc, field_flags,
-						       &byte_alignment);
+	access_bit_width =
+	    acpi_ex_decode_field_access(obj_desc, field_flags, &byte_alignment);
 	if (!access_bit_width) {
 		return_ACPI_STATUS(AE_AML_OPERAND_VALUE);
 	}
@@ -595,7 +600,8 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 					  access_byte_width);
 
 		ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-				  "IndexField: BitOff %X, Off %X, Value %X, Gran %X, Index %p, Data %p\n",
+				  "IndexField: BitOff %X, Off %X, Value %X, "
+				  "Gran %X, Index %p, Data %p\n",
 				  obj_desc->index_field.start_field_bit_offset,
 				  obj_desc->index_field.base_byte_offset,
 				  obj_desc->index_field.value,
@@ -615,8 +621,9 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 	 * Store the constructed descriptor (obj_desc) into the parent Node,
 	 * preserving the current type of that named_obj.
 	 */
-	status = acpi_ns_attach_object(info->field_node, obj_desc,
-				       acpi_ns_get_type(info->field_node));
+	status =
+	    acpi_ns_attach_object(info->field_node, obj_desc,
+				  acpi_ns_get_type(info->field_node));
 
 	ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
 			  "Set NamedObj %p [%4.4s], ObjDesc %p\n",
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index b4a5e44..1851a30 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -392,7 +392,8 @@ acpi_ex_pci_config_space_handler(u32 function,
 	pci_register = (u16) (u32) address;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Pci-Config %u (%u) Seg(%04x) Bus(%04x) Dev(%04x) Func(%04x) Reg(%04x)\n",
+			  "Pci-Config %u (%u) Seg(%04x) Bus(%04x) "
+			  "Dev(%04x) Func(%04x) Reg(%04x)\n",
 			  function, bit_width, pci_id->segment, pci_id->bus,
 			  pci_id->device, pci_id->function, pci_register));
 
@@ -400,14 +401,16 @@ acpi_ex_pci_config_space_handler(u32 function,
 	case ACPI_READ:
 
 		*value = 0;
-		status = acpi_os_read_pci_configuration(pci_id, pci_register,
-							value, bit_width);
+		status =
+		    acpi_os_read_pci_configuration(pci_id, pci_register, value,
+						   bit_width);
 		break;
 
 	case ACPI_WRITE:
 
-		status = acpi_os_write_pci_configuration(pci_id, pci_register,
-							 *value, bit_width);
+		status =
+		    acpi_os_write_pci_configuration(pci_id, pci_register,
+						    *value, bit_width);
 		break;
 
 	default:
diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index 1b372ef..6793dcc 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -112,7 +112,7 @@ acpi_ex_resolve_node_to_value(struct acpi_namespace_node **object_ptr,
 
 	/*
 	 * Several object types require no further processing:
-	 * 1) Device/Thermal objects don't have a "real" subobject, return the Node
+	 * 1) Device/Thermal objects don't have a "real" subobject, return Node
 	 * 2) Method locals and arguments have a pseudo-Node
 	 * 3) 10/2007: Added method type to assist with Package construction.
 	 */
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index a1afe1a..7f9260b 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -217,7 +217,8 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 					 * the package, can't dereference it
 					 */
 					ACPI_ERROR((AE_INFO,
-						    "Attempt to dereference an Index to NULL package element Idx=%p",
+						    "Attempt to dereference an Index to "
+						    "NULL package element Idx=%p",
 						    stack_desc));
 					status = AE_AML_UNINITIALIZED_ELEMENT;
 				}
@@ -361,10 +362,9 @@ acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 
 		if (type == ACPI_TYPE_LOCAL_ALIAS) {
 			type = ((struct acpi_namespace_node *)obj_desc)->type;
-			obj_desc =
-			    acpi_ns_get_attached_object((struct
-							 acpi_namespace_node *)
-							obj_desc);
+			obj_desc = acpi_ns_get_attached_object((struct
+								acpi_namespace_node
+								*)obj_desc);
 		}
 
 		if (!obj_desc) {
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 424442d..861453e 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -90,8 +90,8 @@ acpi_ex_check_object_type(acpi_object_type type_needed,
 		 * specification, a store to a constant is a noop.)
 		 */
 		if ((this_type == ACPI_TYPE_INTEGER) &&
-		    (((union acpi_operand_object *)object)->common.
-		     flags & AOPOBJ_AML_CONSTANT)) {
+		    (((union acpi_operand_object *)object)->common.flags &
+		     AOPOBJ_AML_CONSTANT)) {
 			return (AE_OK);
 		}
 	}
@@ -196,10 +196,10 @@ acpi_ex_resolve_operands(u16 opcode,
 			 * thus, the attached object is always the aliased namespace node
 			 */
 			if (object_type == ACPI_TYPE_LOCAL_ALIAS) {
-				obj_desc =
-				    acpi_ns_get_attached_object((struct
-								 acpi_namespace_node
-								 *)obj_desc);
+				obj_desc = acpi_ns_get_attached_object((struct
+									acpi_namespace_node
+									*)
+								       obj_desc);
 				*stack_ptr = obj_desc;
 				object_type =
 				    ((struct acpi_namespace_node *)obj_desc)->
@@ -285,8 +285,8 @@ acpi_ex_resolve_operands(u16 opcode,
 		case ARGI_REF_OR_STRING:	/* Can be a String or Reference */
 
 			if ((ACPI_GET_DESCRIPTOR_TYPE(obj_desc) ==
-			     ACPI_DESC_TYPE_OPERAND)
-			    && (obj_desc->common.type == ACPI_TYPE_STRING)) {
+			     ACPI_DESC_TYPE_OPERAND) &&
+			    (obj_desc->common.type == ACPI_TYPE_STRING)) {
 				/*
 				 * String found - the string references a named object and
 				 * must be resolved to a node
@@ -465,8 +465,9 @@ acpi_ex_resolve_operands(u16 opcode,
 			 * But we can implicitly convert from a BUFFER or INTEGER
 			 * aka - "Implicit Source Operand Conversion"
 			 */
-			status = acpi_ex_convert_to_string(obj_desc, stack_ptr,
-							   ACPI_IMPLICIT_CONVERT_HEX);
+			status =
+			    acpi_ex_convert_to_string(obj_desc, stack_ptr,
+						      ACPI_IMPLICIT_CONVERT_HEX);
 			if (ACPI_FAILURE(status)) {
 				if (status == AE_TYPE) {
 					ACPI_ERROR((AE_INFO,
@@ -597,8 +598,10 @@ acpi_ex_resolve_operands(u16 opcode,
 
 		case ARGI_REGION_OR_BUFFER:	/* Used by Load() only */
 
-			/* Need an operand of type REGION or a BUFFER (which could be a resolved region field) */
-
+			/*
+			 * Need an operand of type REGION or a BUFFER
+			 * (which could be a resolved region field)
+			 */
 			switch (obj_desc->common.type) {
 			case ACPI_TYPE_BUFFER:
 			case ACPI_TYPE_REGION:
@@ -640,9 +643,9 @@ acpi_ex_resolve_operands(u16 opcode,
 
 				if (acpi_gbl_enable_interpreter_slack) {
 					/*
-					 * Enable original behavior of Store(), allowing any and all
-					 * objects as the source operand. The ACPI spec does not
-					 * allow this, however.
+					 * Enable original behavior of Store(), allowing any
+					 * and all objects as the source operand. The ACPI
+					 * spec does not allow this, however.
 					 */
 					break;
 				}
@@ -655,7 +658,8 @@ acpi_ex_resolve_operands(u16 opcode,
 				}
 
 				ACPI_ERROR((AE_INFO,
-					    "Needed Integer/Buffer/String/Package/Ref/Ddb], found [%s] %p",
+					    "Needed Integer/Buffer/String/Package/Ref/Ddb]"
+					    ", found [%s] %p",
 					    acpi_ut_get_object_type_name
 					    (obj_desc), obj_desc));
 
@@ -678,9 +682,10 @@ acpi_ex_resolve_operands(u16 opcode,
 		 * Make sure that the original object was resolved to the
 		 * required object type (Simple cases only).
 		 */
-		status = acpi_ex_check_object_type(type_needed,
-						   (*stack_ptr)->common.type,
-						   *stack_ptr);
+		status =
+		    acpi_ex_check_object_type(type_needed,
+					      (*stack_ptr)->common.type,
+					      *stack_ptr);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index c076e91..d3afbcb 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -467,7 +467,8 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 		case ACPI_TYPE_THERMAL:
 
 			ACPI_ERROR((AE_INFO,
-				    "Target must be [Buffer/Integer/String/Reference], found [%s] (%4.4s)",
+				    "Target must be [Buffer/Integer/String/Reference]"
+				    ", found [%s] (%4.4s)",
 				    acpi_ut_get_type_name(node->type),
 				    node->name.ascii));
 
@@ -504,8 +505,9 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 			 * an implicit conversion, as per the ACPI specification.
 			 * A direct store is performed instead.
 			 */
-			status = acpi_ex_store_direct_to_node(source_desc, node,
-							      walk_state);
+			status =
+			    acpi_ex_store_direct_to_node(source_desc, node,
+							 walk_state);
 			break;
 		}
 
@@ -528,8 +530,9 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 			 * store has been performed such that the node/object type
 			 * has been changed.
 			 */
-			status = acpi_ns_attach_object(node, new_desc,
-						       new_desc->common.type);
+			status =
+			    acpi_ns_attach_object(node, new_desc,
+						  new_desc->common.type);
 
 			ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 					  "Store type [%s] into [%s] via Convert/Attach\n",
@@ -563,8 +566,8 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 		 * operator. (Note, for this default case, all normal
 		 * Store/Target operations exited above with an error).
 		 */
-		status = acpi_ex_store_direct_to_node(source_desc, node,
-						      walk_state);
+		status =
+		    acpi_ex_store_direct_to_node(source_desc, node, walk_state);
 		break;
 	}
 
diff --git a/drivers/acpi/acpica/exstorob.c b/drivers/acpi/acpica/exstorob.c
index e1d4f4d..ad3bc92 100644
--- a/drivers/acpi/acpica/exstorob.c
+++ b/drivers/acpi/acpica/exstorob.c
@@ -1,6 +1,6 @@
 /******************************************************************************
  *
- * Module Name: exstorob - AML Interpreter object store support, store to object
+ * Module Name: exstorob - AML object store support, store to object
  *
  *****************************************************************************/
 
@@ -203,8 +203,9 @@ acpi_ex_store_string_to_string(union acpi_operand_object *source_desc,
 			ACPI_FREE(target_desc->string.pointer);
 		}
 
-		target_desc->string.pointer = ACPI_ALLOCATE_ZEROED((acpi_size)
-								   length + 1);
+		target_desc->string.pointer =
+		    ACPI_ALLOCATE_ZEROED((acpi_size) length + 1);
+
 		if (!target_desc->string.pointer) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index 0545065..7c91c1f 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -78,7 +78,6 @@ acpi_status acpi_ex_system_wait_semaphore(acpi_semaphore semaphore, u16 timeout)
 		/* We must wait, so unlock the interpreter */
 
 		acpi_ex_exit_interpreter();
-
 		status = acpi_os_wait_semaphore(semaphore, 1, timeout);
 
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
@@ -124,7 +123,6 @@ acpi_status acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout)
 		/* We must wait, so unlock the interpreter */
 
 		acpi_ex_exit_interpreter();
-
 		status = acpi_os_acquire_mutex(mutex, timeout);
 
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
@@ -169,8 +167,8 @@ acpi_status acpi_ex_system_do_stall(u32 how_long)
 		 * (ACPI specifies 100 usec as max, but this gives some slack in
 		 * order to support existing BIOSs)
 		 */
-		ACPI_ERROR((AE_INFO, "Time parameter is too large (%u)",
-			    how_long));
+		ACPI_ERROR((AE_INFO,
+			    "Time parameter is too large (%u)", how_long));
 		status = AE_AML_OPERAND_VALUE;
 	} else {
 		acpi_os_stall(how_long);
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 30c3f46..8ae7634 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -167,8 +167,8 @@ u8 acpi_ex_truncate_for32bit_table(union acpi_operand_object *obj_desc)
 	if ((acpi_gbl_integer_byte_width == 4) &&
 	    (obj_desc->integer.value > (u64)ACPI_UINT32_MAX)) {
 		/*
-		 * We are executing in a 32-bit ACPI table.
-		 * Truncate the value to 32 bits by zeroing out the upper 32-bit field
+		 * We are executing in a 32-bit ACPI table. Truncate
+		 * the value to 32 bits by zeroing out the upper 32-bit field
 		 */
 		obj_desc->integer.value &= (u64)ACPI_UINT32_MAX;
 		return (TRUE);
@@ -323,7 +323,8 @@ void acpi_ex_eisa_id_to_string(char *out_string, u64 compressed_id)
 
 	if (compressed_id > ACPI_UINT32_MAX) {
 		ACPI_WARNING((AE_INFO,
-			      "Expected EISAID is larger than 32 bits: 0x%8.8X%8.8X, truncating",
+			      "Expected EISAID is larger than 32 bits: "
+			      "0x%8.8X%8.8X, truncating",
 			      ACPI_FORMAT_UINT64(compressed_id)));
 	}
 
diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesleep.c
index e5599f6..d0319a2 100644
--- a/drivers/acpi/acpica/hwesleep.c
+++ b/drivers/acpi/acpica/hwesleep.c
@@ -117,8 +117,8 @@ acpi_status acpi_hw_extended_sleep(u8 sleep_state)
 
 	/* Clear wake status (WAK_STS) */
 
-	status =
-	    acpi_write((u64)ACPI_X_WAKE_STATUS, &acpi_gbl_FADT.sleep_status);
+	status = acpi_write((u64)ACPI_X_WAKE_STATUS,
+			    &acpi_gbl_FADT.sleep_status);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index da4a923..8272f96 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -187,9 +187,8 @@ acpi_status acpi_hw_clear_gpe(struct acpi_gpe_event_info * gpe_event_info)
 	 */
 	register_bit = acpi_hw_get_gpe_register_bit(gpe_event_info);
 
-	status = acpi_hw_write(register_bit,
-			       &gpe_register_info->status_address);
-
+	status =
+	    acpi_hw_write(register_bit, &gpe_register_info->status_address);
 	return (status);
 }
 
@@ -297,8 +296,8 @@ acpi_hw_gpe_enable_write(u8 enable_mask,
 	acpi_status status;
 
 	gpe_register_info->enable_mask = enable_mask;
-	status = acpi_hw_write(enable_mask, &gpe_register_info->enable_address);
 
+	status = acpi_hw_write(enable_mask, &gpe_register_info->enable_address);
 	return (status);
 }
 
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 7d21cae..ac5b7f7 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -80,8 +80,8 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
 
 	/* Clear wake status */
 
-	status =
-	    acpi_write_bit_register(ACPI_BITREG_WAKE_STATUS, ACPI_CLEAR_STATUS);
+	status = acpi_write_bit_register(ACPI_BITREG_WAKE_STATUS,
+					 ACPI_CLEAR_STATUS);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index d62a616..f8af1ab 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -286,6 +286,7 @@ acpi_status acpi_enter_sleep_state_s4bios(void)
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
+
 	} while (!in_value);
 
 	return_ACPI_STATUS(AE_OK);
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
index da55a1c..749a189 100644
--- a/drivers/acpi/acpica/nsconvert.c
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -96,9 +96,9 @@ acpi_ns_convert_to_integer(union acpi_operand_object *original_object,
 		/* Extract each buffer byte to create the integer */
 
 		for (i = 0; i < original_object->buffer.length; i++) {
-			value |=
-			    ((u64)original_object->buffer.
-			     pointer[i] << (i * 8));
+			value |= ((u64)
+				  original_object->buffer.pointer[i] << (i *
+									 8));
 		}
 		break;
 
@@ -153,10 +153,9 @@ acpi_ns_convert_to_string(union acpi_operand_object *original_object,
 				return (AE_NO_MEMORY);
 			}
 		} else {
-			status =
-			    acpi_ex_convert_to_string(original_object,
-						      &new_object,
-						      ACPI_IMPLICIT_CONVERT_HEX);
+			status = acpi_ex_convert_to_string(original_object,
+							   &new_object,
+							   ACPI_IMPLICIT_CONVERT_HEX);
 			if (ACPI_FAILURE(status)) {
 				return (status);
 			}
@@ -244,9 +243,8 @@ acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
 
 		/* String-to-Buffer conversion. Simple data copy */
 
-		new_object =
-		    acpi_ut_create_buffer_object(original_object->string.
-						 length);
+		new_object = acpi_ut_create_buffer_object
+		    (original_object->string.length);
 		if (!new_object) {
 			return (AE_NO_MEMORY);
 		}
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index e071956..bc5ff35 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -539,11 +539,13 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 				acpi_os_printf
 				    ("(Pointer to ACPI Object type %.2X [UNKNOWN])\n",
 				     obj_type);
+
 				bytes_to_dump = 32;
 			} else {
 				acpi_os_printf
 				    ("(Pointer to ACPI Object type %.2X [%s])\n",
 				     obj_type, acpi_ut_get_type_name(obj_type));
+
 				bytes_to_dump =
 				    sizeof(union acpi_operand_object);
 			}
@@ -573,6 +575,7 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 			 */
 			bytes_to_dump = obj_desc->string.length;
 			obj_desc = (void *)obj_desc->string.pointer;
+
 			acpi_os_printf("(Buffer/String pointer %p length %X)\n",
 				       obj_desc, bytes_to_dump);
 			ACPI_DUMP_BUFFER(obj_desc, bytes_to_dump);
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index 14ab836..c106916 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -321,7 +321,6 @@ acpi_status acpi_ns_unload_namespace(acpi_handle handle)
 	/* This function does the real work */
 
 	status = acpi_ns_delete_subtree(handle);
-
 	return_ACPI_STATUS(status);
 }
 #endif
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index 8934b4e..521031f 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -70,7 +70,6 @@ char *acpi_ns_get_external_pathname(struct acpi_namespace_node *node)
 	ACPI_FUNCTION_TRACE_PTR(ns_get_external_pathname, node);
 
 	name_buffer = acpi_ns_get_normalized_pathname(node, FALSE);
-
 	return_PTR(name_buffer);
 }
 
@@ -93,7 +92,6 @@ acpi_size acpi_ns_get_pathname_length(struct acpi_namespace_node *node)
 	ACPI_FUNCTION_ENTRY();
 
 	size = acpi_ns_build_normalized_path(node, NULL, 0, FALSE);
-
 	return (size);
 }
 
@@ -217,6 +215,7 @@ acpi_ns_build_normalized_path(struct acpi_namespace_node *node,
 			ACPI_PATH_PUT8(full_path, path_size,
 				       AML_DUAL_NAME_PREFIX, length);
 		}
+
 		ACPI_MOVE_32_TO_32(name, &next_node->name);
 		do_no_trailing = no_trailing;
 		for (i = 0; i < 4; i++) {
@@ -228,8 +227,10 @@ acpi_ns_build_normalized_path(struct acpi_namespace_node *node,
 				ACPI_PATH_PUT8(full_path, path_size, c, length);
 			}
 		}
+
 		next_node = next_node->parent;
 	}
+
 	ACPI_PATH_PUT8(full_path, path_size, AML_ROOT_PREFIX, length);
 
 	/* Reverse the path string */
@@ -237,6 +238,7 @@ acpi_ns_build_normalized_path(struct acpi_namespace_node *node,
 	if (length <= path_size) {
 		left = full_path;
 		right = full_path + length - 1;
+
 		while (left < right) {
 			c = *left;
 			*left++ = *right;
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index 3736d43b..43b45a8 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -141,8 +141,8 @@ acpi_ns_one_complete_parse(u32 pass_number,
 
 	/* Parse the AML */
 
-	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "*PARSE* pass %u parse\n",
-			  pass_number));
+	ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
+			  "*PARSE* pass %u parse\n", pass_number));
 	status = acpi_ps_parse_aml(walk_state);
 
 cleanup:
@@ -181,6 +181,7 @@ acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node *start_node)
 	 * performs another complete parse of the AML.
 	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start pass 1\n"));
+
 	status = acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS1,
 					    table_index, start_node);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index 9bb2519..c05a83b 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -233,8 +233,9 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 
 		/* First element is the (Integer) revision */
 
-		status = acpi_ns_check_object_type(info, elements,
-						   ACPI_RTYPE_INTEGER, 0);
+		status =
+		    acpi_ns_check_object_type(info, elements,
+					      ACPI_RTYPE_INTEGER, 0);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
@@ -252,8 +253,9 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 
 		/* First element is the (Integer) count of subpackages to follow */
 
-		status = acpi_ns_check_object_type(info, elements,
-						   ACPI_RTYPE_INTEGER, 0);
+		status =
+		    acpi_ns_check_object_type(info, elements,
+					      ACPI_RTYPE_INTEGER, 0);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 77d8103..360e3ab 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -366,6 +366,7 @@ static const struct acpi_simple_repair_info *acpi_ns_match_simple_repair(struct
 
 			return (NULL);
 		}
+
 		this_name++;
 	}
 
@@ -521,6 +522,7 @@ acpi_ns_remove_null_elements(struct acpi_evaluate_info *info,
 			*dest = *source;
 			dest++;
 		}
+
 		source++;
 	}
 
@@ -572,8 +574,8 @@ acpi_ns_wrap_with_package(struct acpi_evaluate_info *info,
 	ACPI_FUNCTION_NAME(ns_wrap_with_package);
 
 	/*
-	 * Create the new outer package and populate it. The new package will
-	 * have a single element, the lone sub-object.
+	 * Create the new outer package and populate it. The new
+	 * package will have a single element, the lone sub-object.
 	 */
 	pkg_obj_desc = acpi_ut_create_package_object(1);
 	if (!pkg_obj_desc) {
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 7ca8f2b..f6dd2a8 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -225,6 +225,7 @@ static const struct acpi_repair_info *acpi_ns_match_complex_repair(struct
 		if (ACPI_COMPARE_NAME(node->name.ascii, this_name->name)) {
 			return (this_name);
 		}
+
 		this_name++;
 	}
 
@@ -301,7 +302,8 @@ acpi_ns_repair_FDE(struct acpi_evaluate_info *info,
 		/* We can only repair if we have exactly 5 BYTEs */
 
 		if (return_object->buffer.length != ACPI_FDE_BYTE_BUFFER_SIZE) {
-			ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+			ACPI_WARN_PREDEFINED((AE_INFO,
+					      info->full_pathname,
 					      info->node_flags,
 					      "Incorrect return buffer length %u, expected %u",
 					      return_object->buffer.length,
@@ -321,8 +323,8 @@ acpi_ns_repair_FDE(struct acpi_evaluate_info *info,
 		/* Expand each byte to a DWORD */
 
 		byte_buffer = return_object->buffer.pointer;
-		dword_buffer =
-		    ACPI_CAST_PTR(u32, buffer_object->buffer.pointer);
+		dword_buffer = ACPI_CAST_PTR(u32,
+					     buffer_object->buffer.pointer);
 
 		for (i = 0; i < ACPI_FDE_FIELD_COUNT; i++) {
 			*dword_buffer = (u32) *byte_buffer;
@@ -461,7 +463,8 @@ acpi_ns_repair_CST(struct acpi_evaluate_info *info,
 		removing = FALSE;
 
 		if ((*outer_elements)->package.count == 0) {
-			ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+			ACPI_WARN_PREDEFINED((AE_INFO,
+					      info->full_pathname,
 					      info->node_flags,
 					      "SubPackage[%u] - removing entry due to zero count",
 					      i));
@@ -471,7 +474,8 @@ acpi_ns_repair_CST(struct acpi_evaluate_info *info,
 
 		obj_desc = (*outer_elements)->package.elements[1];	/* Index1 = Type */
 		if ((u32)obj_desc->integer.value == 0) {
-			ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+			ACPI_WARN_PREDEFINED((AE_INFO,
+					      info->full_pathname,
 					      info->node_flags,
 					      "SubPackage[%u] - removing entry due to invalid Type(0)",
 					      i));
@@ -538,8 +542,8 @@ acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 	}
 
 	if (return_object->string.length == 0) {
-		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
-				      info->node_flags,
+		ACPI_WARN_PREDEFINED((AE_INFO,
+				      info->full_pathname, info->node_flags,
 				      "Invalid zero-length _HID or _CID string"));
 
 		/* Return AE_OK anyway, let driver handle it */
@@ -711,7 +715,8 @@ acpi_ns_repair_PSS(struct acpi_evaluate_info *info,
 		obj_desc = elements[1];	/* Index1 = power_dissipation */
 
 		if ((u32)obj_desc->integer.value > previous_value) {
-			ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+			ACPI_WARN_PREDEFINED((AE_INFO,
+					      info->full_pathname,
 					      info->node_flags,
 					      "SubPackage[%u,%u] - suspicious power dissipation values",
 					      i - 1, i));
@@ -969,6 +974,7 @@ acpi_ns_remove_element(union acpi_operand_object *obj_desc, u32 index)
 			*dest = *source;
 			dest++;
 		}
+
 		source++;
 	}
 
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index de325ae..32f1d95 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -173,9 +173,10 @@ void acpi_ns_get_internal_name_length(struct acpi_namestring_info *info)
 	info->fully_qualified = FALSE;
 
 	/*
-	 * For the internal name, the required length is 4 bytes per segment, plus
-	 * 1 each for root_prefix, multi_name_prefix_op, segment count, trailing null
-	 * (which is not really needed, but no there's harm in putting it there)
+	 * For the internal name, the required length is 4 bytes per segment,
+	 * plus 1 each for root_prefix, multi_name_prefix_op, segment count,
+	 * trailing null (which is not really needed, but no there's harm in
+	 * putting it there)
 	 *
 	 * strlen() + 1 covers the first name_seg, which has no path separator
 	 */
@@ -699,6 +700,7 @@ acpi_ns_get_node(struct acpi_namespace_node *prefix_node,
 		if (!prefix_node) {
 			*return_node = acpi_gbl_root_node;
 		}
+
 		return_ACPI_STATUS(AE_OK);
 	}
 
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 6ee1e52..429f0d2 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -750,8 +750,8 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
 
 	/* We have a valid device, invoke the user function */
 
-	status = info->user_function(obj_handle, nesting_level, info->context,
-				     return_value);
+	status = info->user_function(obj_handle, nesting_level,
+				     info->context, return_value);
 	return (status);
 }
 
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 138cf5e..c19d86c 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -591,6 +591,7 @@ acpi_status acpi_install_method(u8 *buffer)
 	parser_state.aml += acpi_ps_get_opcode_size(opcode);
 	parser_state.pkg_end = acpi_ps_get_next_package_end(&parser_state);
 	path = acpi_ps_get_next_namestring(&parser_state);
+
 	method_flags = *parser_state.aml++;
 	aml_start = parser_state.aml;
 	aml_length = ACPI_PTR_DIFF(parser_state.pkg_end, aml_start);
diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index 7933835..6e1389b 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -74,10 +74,8 @@ acpi_status acpi_get_type(acpi_handle handle, acpi_object_type * ret_type)
 		return (AE_BAD_PARAMETER);
 	}
 
-	/*
-	 * Special case for the predefined Root Node
-	 * (return type ANY)
-	 */
+	/* Special case for the predefined Root Node (return type ANY) */
+
 	if (handle == ACPI_ROOT_OBJECT) {
 		*ret_type = ACPI_TYPE_ANY;
 		return (AE_OK);
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 29d8b7b..3f0ffee 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -733,6 +733,7 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 		if (!arg) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
+
 		acpi_ps_get_next_simple_arg(parser_state, arg_type, arg);
 		break;
 
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 03ac8c9..c660006 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -124,8 +124,8 @@ acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
 		/*
 		 * Op is not a constant or string, append each argument to the Op
 		 */
-		while (GET_CURRENT_ARG_TYPE(walk_state->arg_types)
-		       && !walk_state->arg_count) {
+		while (GET_CURRENT_ARG_TYPE(walk_state->arg_types) &&
+		       !walk_state->arg_count) {
 			walk_state->aml = walk_state->parser_state.aml;
 
 			status =
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 98001d7..b729d9b 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -526,8 +526,8 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 			}
 
 			/*
-			 * If the transfer to the new method method call worked, a new walk
-			 * state was created -- get it
+			 * If the transfer to the new method method call worked
+			 *, a new walk state was created -- get it
 			 */
 			walk_state = acpi_ds_get_current_walk_state(thread);
 			continue;
@@ -544,8 +544,8 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 			/* Check for possible multi-thread reentrancy problem */
 
 			if ((status == AE_ALREADY_EXISTS) &&
-			    (!(walk_state->method_desc->method.
-			       info_flags & ACPI_METHOD_SERIALIZED))) {
+			    (!(walk_state->method_desc->method.info_flags &
+			       ACPI_METHOD_SERIALIZED))) {
 				/*
 				 * Method is not serialized and tried to create an object
 				 * twice. The probable cause is that the method cannot
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index 71d2877..6cb02a2 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -175,8 +175,8 @@ void acpi_ps_free_op(union acpi_parse_object *op)
 	ACPI_FUNCTION_NAME(ps_free_op);
 
 	if (op->common.aml_opcode == AML_INT_RETURN_VALUE_OP) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS, "Free retval op: %p\n",
-				  op));
+		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
+				  "Free retval op: %p\n", op));
 	}
 
 	if (op->common.flags & ACPI_PARSEOP_GENERIC) {
diff --git a/drivers/acpi/acpica/pswalk.c b/drivers/acpi/acpica/pswalk.c
index ba5f691..f620d43 100644
--- a/drivers/acpi/acpica/pswalk.c
+++ b/drivers/acpi/acpica/pswalk.c
@@ -99,6 +99,7 @@ void acpi_ps_delete_parse_tree(union acpi_parse_object *subtree_root)
 		if (op == subtree_root) {
 			return_VOID;
 		}
+
 		if (next) {
 			op = next;
 		} else {
diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
index 66d406e..bdb7e73 100644
--- a/drivers/acpi/acpica/rsaddr.c
+++ b/drivers/acpi/acpica/rsaddr.c
@@ -312,8 +312,8 @@ acpi_rs_get_address_common(struct acpi_resource *resource,
 
 	/* Validate the Resource Type */
 
-	if ((aml->address.resource_type > 2)
-	    && (aml->address.resource_type < 0xC0)) {
+	if ((aml->address.resource_type > 2) &&
+	    (aml->address.resource_type < 0xC0)) {
 		return (FALSE);
 	}
 
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index cb739a6..88fce58 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -143,16 +143,17 @@ acpi_rs_stream_option_length(u32 resource_length,
 	ACPI_FUNCTION_ENTRY();
 
 	/*
-	 * The resource_source_index and resource_source are optional elements of some
-	 * Large-type resource descriptors.
+	 * The resource_source_index and resource_source are optional elements of
+	 * some Large-type resource descriptors.
 	 */
 
 	/*
-	 * If the length of the actual resource descriptor is greater than the ACPI
-	 * spec-defined minimum length, it means that a resource_source_index exists
-	 * and is followed by a (required) null terminated string. The string length
-	 * (including the null terminator) is the resource length minus the minimum
-	 * length, minus one byte for the resource_source_index itself.
+	 * If the length of the actual resource descriptor is greater than the
+	 * ACPI spec-defined minimum length, it means that a resource_source_index
+	 * exists and is followed by a (required) null terminated string. The
+	 * string length (including the null terminator) is the resource length
+	 * minus the minimum length, minus one byte for the resource_source_index
+	 * itself.
 	 */
 	if (resource_length > minimum_aml_resource_length) {
 
@@ -277,11 +278,11 @@ acpi_rs_get_aml_length(struct acpi_resource *resource,
 			 * 16-Bit Address Resource:
 			 * Add the size of the optional resource_source info
 			 */
-			total_size = (acpi_rs_length)
-			    (total_size +
-			     acpi_rs_struct_option_length(&resource->data.
-							  address16.
-							  resource_source));
+			total_size = (acpi_rs_length) (total_size +
+						       acpi_rs_struct_option_length
+						       (&resource->data.
+							address16.
+							resource_source));
 			break;
 
 		case ACPI_RESOURCE_TYPE_ADDRESS32:
@@ -289,11 +290,11 @@ acpi_rs_get_aml_length(struct acpi_resource *resource,
 			 * 32-Bit Address Resource:
 			 * Add the size of the optional resource_source info
 			 */
-			total_size = (acpi_rs_length)
-			    (total_size +
-			     acpi_rs_struct_option_length(&resource->data.
-							  address32.
-							  resource_source));
+			total_size = (acpi_rs_length) (total_size +
+						       acpi_rs_struct_option_length
+						       (&resource->data.
+							address32.
+							resource_source));
 			break;
 
 		case ACPI_RESOURCE_TYPE_ADDRESS64:
@@ -301,11 +302,11 @@ acpi_rs_get_aml_length(struct acpi_resource *resource,
 			 * 64-Bit Address Resource:
 			 * Add the size of the optional resource_source info
 			 */
-			total_size = (acpi_rs_length)
-			    (total_size +
-			     acpi_rs_struct_option_length(&resource->data.
-							  address64.
-							  resource_source));
+			total_size = (acpi_rs_length) (total_size +
+						       acpi_rs_struct_option_length
+						       (&resource->data.
+							address64.
+							resource_source));
 			break;
 
 		case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
@@ -314,26 +315,28 @@ acpi_rs_get_aml_length(struct acpi_resource *resource,
 			 * Add the size of each additional optional interrupt beyond the
 			 * required 1 (4 bytes for each u32 interrupt number)
 			 */
-			total_size = (acpi_rs_length)
-			    (total_size +
-			     ((resource->data.extended_irq.interrupt_count -
-			       1) * 4) +
-			     /* Add the size of the optional resource_source info */
-			     acpi_rs_struct_option_length(&resource->data.
-							  extended_irq.
-							  resource_source));
+			total_size = (acpi_rs_length) (total_size +
+						       ((resource->data.
+							 extended_irq.
+							 interrupt_count -
+							 1) * 4) +
+						       /* Add the size of the optional resource_source info */
+						       acpi_rs_struct_option_length
+						       (&resource->data.
+							extended_irq.
+							resource_source));
 			break;
 
 		case ACPI_RESOURCE_TYPE_GPIO:
 
-			total_size =
-			    (acpi_rs_length) (total_size +
-					      (resource->data.gpio.
-					       pin_table_length * 2) +
-					      resource->data.gpio.
-					      resource_source.string_length +
-					      resource->data.gpio.
-					      vendor_length);
+			total_size = (acpi_rs_length) (total_size +
+						       (resource->data.gpio.
+							pin_table_length * 2) +
+						       resource->data.gpio.
+						       resource_source.
+						       string_length +
+						       resource->data.gpio.
+						       vendor_length);
 
 			break;
 
@@ -566,8 +569,8 @@ acpi_rs_get_list_length(u8 * aml_buffer,
 			    acpi_gbl_resource_struct_sizes[resource_index] +
 			    extra_struct_bytes;
 		}
-		buffer_size = (u32)ACPI_ROUND_UP_TO_NATIVE_WORD(buffer_size);
 
+		buffer_size = (u32)ACPI_ROUND_UP_TO_NATIVE_WORD(buffer_size);
 		*size_needed += buffer_size;
 
 		ACPI_DEBUG_PRINT((ACPI_DB_RESOURCES,
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index a534442..603e544 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -81,8 +81,9 @@ acpi_buffer_to_resource(u8 *aml_buffer,
 
 	/* Get the required length for the converted resource */
 
-	status = acpi_rs_get_list_length(aml_buffer, aml_buffer_length,
-					 &list_size_needed);
+	status =
+	    acpi_rs_get_list_length(aml_buffer, aml_buffer_length,
+				    &list_size_needed);
 	if (status == AE_AML_NO_RESOURCE_END_TAG) {
 		status = AE_OK;
 	}
@@ -232,8 +233,9 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 
 	/* Get the required buffer length */
 
-	status = acpi_rs_get_pci_routing_table_length(package_object,
-						      &buffer_size_needed);
+	status =
+	    acpi_rs_get_pci_routing_table_length(package_object,
+						 &buffer_size_needed);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -270,9 +272,9 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		user_prt = ACPI_CAST_PTR(struct acpi_pci_routing_table, buffer);
 
 		/*
-		 * Fill in the Length field with the information we have at this point.
-		 * The minus four is to subtract the size of the u8 Source[4] member
-		 * because it is added below.
+		 * Fill in the Length field with the information we have at this
+		 * point. The minus four is to subtract the size of the u8
+		 * Source[4] member because it is added below.
 		 */
 		user_prt->length = (sizeof(struct acpi_pci_routing_table) - 4);
 
@@ -345,11 +347,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 					   (u8 *) output_buffer->pointer);
 				path_buffer.pointer = user_prt->source;
 
-				status =
-				    acpi_ns_handle_to_pathname((acpi_handle)
-							       node,
-							       &path_buffer,
-							       FALSE);
+				status = acpi_ns_handle_to_pathname((acpi_handle) node, &path_buffer, FALSE);
 
 				/* +1 to include null terminator */
 
@@ -371,8 +369,8 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 
 			case ACPI_TYPE_INTEGER:
 				/*
-				 * If this is a number, then the Source Name is NULL, since the
-				 * entire buffer was zeroed out, we can leave this alone.
+				 * If this is a number, then the Source Name is NULL, since
+				 * the entire buffer was zeroed out, we can leave this alone.
 				 *
 				 * Add to the Length field the length of the u32 NULL
 				 */
@@ -451,9 +449,9 @@ acpi_rs_create_aml_resources(struct acpi_buffer *resource_list,
 
 	/* Get the buffer size needed for the AML byte stream */
 
-	status = acpi_rs_get_aml_length(resource_list->pointer,
-					resource_list->length,
-					&aml_size_needed);
+	status =
+	    acpi_rs_get_aml_length(resource_list->pointer,
+				   resource_list->length, &aml_size_needed);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "AmlSizeNeeded=%X, %s\n",
 			  (u32)aml_size_needed, acpi_format_exception(status)));
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 2a09288..05cc560 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -483,6 +483,7 @@ static void acpi_rs_dump_address_common(union acpi_resource_data *resource)
 
 static void acpi_rs_out_string(char *title, char *value)
 {
+
 	acpi_os_printf("%27s : %s", title, value);
 	if (!*value) {
 		acpi_os_printf("[NULL NAMESTRING]");
@@ -497,21 +498,25 @@ static void acpi_rs_out_integer8(char *title, u8 value)
 
 static void acpi_rs_out_integer16(char *title, u16 value)
 {
+
 	acpi_os_printf("%27s : %4.4X\n", title, value);
 }
 
 static void acpi_rs_out_integer32(char *title, u32 value)
 {
+
 	acpi_os_printf("%27s : %8.8X\n", title, value);
 }
 
 static void acpi_rs_out_integer64(char *title, u64 value)
 {
+
 	acpi_os_printf("%27s : %8.8X%8.8X\n", title, ACPI_FORMAT_UINT64(value));
 }
 
 static void acpi_rs_out_title(char *title)
 {
+
 	acpi_os_printf("%27s : ", title);
 }
 
@@ -544,6 +549,7 @@ static void acpi_rs_dump_short_byte_list(u8 length, u8 * data)
 	for (i = 0; i < length; i++) {
 		acpi_os_printf("%X ", data[i]);
 	}
+
 	acpi_os_printf("\n");
 }
 
diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index 50d5be2..286ccb461 100644
--- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -89,6 +89,7 @@ acpi_rs_convert_aml_to_resources(u8 * aml,
 	/* Get the appropriate conversion info table */
 
 	aml_resource = ACPI_CAST_PTR(union aml_resource, aml);
+
 	if (acpi_ut_get_resource_type(aml) == ACPI_RESOURCE_NAME_SERIAL_BUS) {
 		if (aml_resource->common_serial_bus.type >
 		    AML_RESOURCE_MAX_SERIALBUSTYPE) {
@@ -225,10 +226,10 @@ acpi_rs_convert_resources_to_aml(struct acpi_resource *resource,
 
 		/* Perform final sanity check on the new AML resource descriptor */
 
-		status = acpi_ut_validate_resource(NULL,
-						   ACPI_CAST_PTR(union
-								 aml_resource,
-								 aml), NULL);
+		status =
+		    acpi_ut_validate_resource(NULL,
+					      ACPI_CAST_PTR(union aml_resource,
+							    aml), NULL);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
diff --git a/drivers/acpi/acpica/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
index b528ed90..b112c7b 100644
--- a/drivers/acpi/acpica/rsmisc.c
+++ b/drivers/acpi/acpica/rsmisc.c
@@ -189,8 +189,8 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 			item_count = ACPI_GET8(source);
 			ACPI_SET8(destination, item_count);
 
-			resource->length = resource->length +
-			    (info->value * item_count);
+			resource->length =
+			    resource->length + (info->value * item_count);
 			break;
 
 		case ACPI_RSC_COUNT_GPIO_RES:
@@ -445,8 +445,8 @@ exit:
 
 		/* Round the resource struct length up to the next boundary (32 or 64) */
 
-		resource->length =
-		    (u32)ACPI_ROUND_UP_TO_NATIVE_WORD(resource->length);
+		resource->length = (u32)
+		    ACPI_ROUND_UP_TO_NATIVE_WORD(resource->length);
 	}
 	return_ACPI_STATUS(AE_OK);
 }
@@ -550,9 +550,8 @@ acpi_rs_convert_resource_to_aml(struct acpi_resource *resource,
 			item_count = ACPI_GET8(source);
 			ACPI_SET8(destination, item_count);
 
-			aml_length =
-			    (u16)(aml_length +
-				  (info->value * (item_count - 1)));
+			aml_length = (u16)
+			    (aml_length + (info->value * (item_count - 1)));
 			break;
 
 		case ACPI_RSC_COUNT16:
@@ -723,11 +722,10 @@ acpi_rs_convert_resource_to_aml(struct acpi_resource *resource,
 			/*
 			 * 16-bit encoded bitmask (IRQ macro)
 			 */
-			temp16 = acpi_rs_encode_bitmask(source,
-							*ACPI_ADD_PTR(u8,
-								      resource,
-								      info->
-								      value));
+			temp16 =
+			    acpi_rs_encode_bitmask(source,
+						   *ACPI_ADD_PTR(u8, resource,
+								 info->value));
 			ACPI_MOVE_16_TO_16(destination, &temp16);
 			break;
 
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index 9486992..33e558c 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -221,14 +221,13 @@ acpi_rs_set_resource_length(acpi_rsdesc_size total_length,
 		ACPI_MOVE_16_TO_16(&aml->large_header.resource_length,
 				   &resource_length);
 	} else {
-		/* Small descriptor -- bits 2:0 of byte 0 contain the length */
-
+		/*
+		 * Small descriptor -- bits 2:0 of byte 0 contain the length
+		 * Clear any existing length, preserving descriptor type bits
+		 */
 		aml->small_header.descriptor_type = (u8)
-
-		    /* Clear any existing length, preserving descriptor type bits */
-		    ((aml->small_header.
-		      descriptor_type & ~ACPI_RESOURCE_NAME_SMALL_LENGTH_MASK)
-
+		    ((aml->small_header.descriptor_type &
+		      ~ACPI_RESOURCE_NAME_SMALL_LENGTH_MASK)
 		     | resource_length);
 	}
 }
@@ -333,8 +332,8 @@ acpi_rs_get_resource_source(acpi_rs_length resource_length,
 	aml_resource_source = ACPI_ADD_PTR(u8, aml, minimum_length);
 
 	/*
-	 * resource_source is present if the length of the descriptor is longer than
-	 * the minimum length.
+	 * resource_source is present if the length of the descriptor is longer
+	 * than the minimum length.
 	 *
 	 * Note: Some resource descriptors will have an additional null, so
 	 * we add 1 to the minimum length.
@@ -366,6 +365,7 @@ acpi_rs_get_resource_source(acpi_rs_length resource_length,
 		total_length =
 		    (u32)strlen(ACPI_CAST_PTR(char, &aml_resource_source[1])) +
 		    1;
+
 		total_length = (u32)ACPI_ROUND_UP_TO_NATIVE_WORD(total_length);
 
 		memset(resource_source->string_ptr, 0, total_length);
@@ -438,8 +438,8 @@ acpi_rs_set_resource_source(union aml_resource * aml,
 		 * Add the length of the string (+ 1 for null terminator) to the
 		 * final descriptor length
 		 */
-		descriptor_length +=
-		    ((acpi_rsdesc_size) resource_source->string_length + 1);
+		descriptor_length += ((acpi_rsdesc_size)
+				      resource_source->string_length + 1);
 	}
 
 	/* Return the new total length of the AML descriptor */
@@ -478,8 +478,9 @@ acpi_rs_get_prt_method_data(struct acpi_namespace_node * node,
 
 	/* Execute the method, no parameters */
 
-	status = acpi_ut_evaluate_object(node, METHOD_NAME__PRT,
-					 ACPI_BTYPE_PACKAGE, &obj_desc);
+	status =
+	    acpi_ut_evaluate_object(node, METHOD_NAME__PRT, ACPI_BTYPE_PACKAGE,
+				    &obj_desc);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -527,8 +528,9 @@ acpi_rs_get_crs_method_data(struct acpi_namespace_node *node,
 
 	/* Execute the method, no parameters */
 
-	status = acpi_ut_evaluate_object(node, METHOD_NAME__CRS,
-					 ACPI_BTYPE_BUFFER, &obj_desc);
+	status =
+	    acpi_ut_evaluate_object(node, METHOD_NAME__CRS, ACPI_BTYPE_BUFFER,
+				    &obj_desc);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -577,8 +579,9 @@ acpi_rs_get_prs_method_data(struct acpi_namespace_node *node,
 
 	/* Execute the method, no parameters */
 
-	status = acpi_ut_evaluate_object(node, METHOD_NAME__PRS,
-					 ACPI_BTYPE_BUFFER, &obj_desc);
+	status =
+	    acpi_ut_evaluate_object(node, METHOD_NAME__PRS, ACPI_BTYPE_BUFFER,
+				    &obj_desc);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -627,8 +630,9 @@ acpi_rs_get_aei_method_data(struct acpi_namespace_node *node,
 
 	/* Execute the method, no parameters */
 
-	status = acpi_ut_evaluate_object(node, METHOD_NAME__AEI,
-					 ACPI_BTYPE_BUFFER, &obj_desc);
+	status =
+	    acpi_ut_evaluate_object(node, METHOD_NAME__AEI, ACPI_BTYPE_BUFFER,
+				    &obj_desc);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index 1e8cd57..308bfd6 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -53,7 +53,7 @@ ACPI_MODULE_NAME("rsxface")
 
 /* Local macros for 16,32-bit to 64-bit conversion */
 #define ACPI_COPY_FIELD(out, in, field)  ((out)->field = (in)->field)
-#define ACPI_COPY_ADDRESS(out, in)                      \
+#define ACPI_COPY_ADDRESS(out, in)                       \
 	ACPI_COPY_FIELD(out, in, resource_type);             \
 	ACPI_COPY_FIELD(out, in, producer_consumer);         \
 	ACPI_COPY_FIELD(out, in, decode);                    \
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 5c9d5ab..4a81527 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -407,6 +407,7 @@ acpi_tb_verify_temp_table(struct acpi_table_desc * table_desc, char *signature)
 					table_desc->signature.ascii : "????",
 					ACPI_FORMAT_UINT64(table_desc->
 							   address)));
+
 			goto invalidate_and_exit;
 		}
 	}
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 6319b42..bd87801 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -337,8 +337,8 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 			 * need to be unregistered when they are unloaded, and slots in the
 			 * root table list should be reused when empty.
 			 */
-			if (acpi_gbl_root_table_list.tables[i].
-			    flags & ACPI_TABLE_IS_LOADED) {
+			if (acpi_gbl_root_table_list.tables[i].flags &
+			    ACPI_TABLE_IS_LOADED) {
 
 				/* Table is still loaded, this is an error */
 
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index 709d511..d0d1259 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -76,6 +76,7 @@ static void acpi_tb_fix_string(char *string, acpi_size length)
 		if (!isprint((int)*string)) {
 			*string = '?';
 		}
+
 		string++;
 		length--;
 	}
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index d8ddef3..72bcccf 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -121,6 +121,7 @@ void acpi_tb_check_dsdt_header(void)
 		ACPI_BIOS_ERROR((AE_INFO,
 				 "The DSDT has been corrupted or replaced - "
 				 "old, new headers below"));
+
 		acpi_tb_print_table_header(0, &acpi_gbl_original_dsdt_header);
 		acpi_tb_print_table_header(0, acpi_gbl_DSDT);
 
@@ -379,7 +380,6 @@ next_table:
 	}
 
 	acpi_os_unmap_memory(table, length);
-
 	return_ACPI_STATUS(AE_OK);
 }
 
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 55ee14c..9a7d72b 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -191,6 +191,7 @@ acpi_status acpi_tb_load_namespace(void)
 					"(%4.4s:%8.8s) while loading table",
 					table->signature.ascii,
 					table->pointer->oem_table_id));
+
 			tables_failed++;
 
 			ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 257221d..ade8acf 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -257,9 +257,9 @@ acpi_ut_copy_ielement_to_eelement(u8 object_type,
 	ACPI_FUNCTION_ENTRY();
 
 	this_index = state->pkg.index;
-	target_object = (union acpi_object *)
-	    &((union acpi_object *)(state->pkg.dest_object))->package.
-	    elements[this_index];
+	target_object = (union acpi_object *)&((union acpi_object *)
+					       (state->pkg.dest_object))->
+	    package.elements[this_index];
 
 	switch (object_type) {
 	case ACPI_COPY_TYPE_SIMPLE:
@@ -348,15 +348,15 @@ acpi_ut_copy_ipackage_to_epackage(union acpi_operand_object *internal_object,
 	 * Free space begins right after the first package
 	 */
 	info.length = ACPI_ROUND_UP_TO_NATIVE_WORD(sizeof(union acpi_object));
-	info.free_space =
-	    buffer + ACPI_ROUND_UP_TO_NATIVE_WORD(sizeof(union acpi_object));
+	info.free_space = buffer +
+	    ACPI_ROUND_UP_TO_NATIVE_WORD(sizeof(union acpi_object));
 	info.object_space = 0;
 	info.num_packages = 1;
 
 	external_object->type = internal_object->common.type;
 	external_object->package.count = internal_object->package.count;
-	external_object->package.elements = ACPI_CAST_PTR(union acpi_object,
-							  info.free_space);
+	external_object->package.elements =
+	    ACPI_CAST_PTR(union acpi_object, info.free_space);
 
 	/*
 	 * Leave room for an array of ACPI_OBJECTS in the buffer
@@ -593,8 +593,8 @@ acpi_ut_copy_epackage_to_ipackage(union acpi_object *external_object,
 	package_elements = package_object->package.elements;
 
 	/*
-	 * Recursive implementation. Probably ok, since nested external packages
-	 * as parameters should be very rare.
+	 * Recursive implementation. Probably ok, since nested external
+	 * packages as parameters should be very rare.
 	 */
 	for (i = 0; i < external_object->package.count; i++) {
 		status =
@@ -649,9 +649,8 @@ acpi_ut_copy_eobject_to_iobject(union acpi_object *external_object,
 		/*
 		 * Build a simple object (no nested objects)
 		 */
-		status =
-		    acpi_ut_copy_esimple_to_isimple(external_object,
-						    internal_object);
+		status = acpi_ut_copy_esimple_to_isimple(external_object,
+							 internal_object);
 	}
 
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 7e14400..3533135 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -180,7 +180,8 @@ const char *acpi_ut_get_event_name(u32 event_id)
  *
  * The type ACPI_TYPE_ANY (Untyped) is used as a "don't care" when searching;
  * when stored in a table it really means that we have thus far seen no
- * evidence to indicate what type is actually going to be stored for this entry.
+ * evidence to indicate what type is actually going to be stored for this
+ & entry.
  */
 static const char acpi_gbl_bad_type[] = "UNDEFINED";
 
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 1638312..1afd742 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -209,6 +209,7 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 			acpi_ut_delete_object_desc(object->method.mutex);
 			object->method.mutex = NULL;
 		}
+
 		if (object->method.node) {
 			object->method.node = NULL;
 		}
@@ -515,8 +516,8 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 		}
 
 		/*
-		 * All sub-objects must have their reference count incremented also.
-		 * Different object types have different subobjects.
+		 * All sub-objects must have their reference count incremented
+		 * also. Different object types have different subobjects.
 		 */
 		switch (object->common.type) {
 		case ACPI_TYPE_DEVICE:
diff --git a/drivers/acpi/acpica/uterror.c b/drivers/acpi/acpica/uterror.c
index 9ef80f2..f93bb90 100644
--- a/drivers/acpi/acpica/uterror.c
+++ b/drivers/acpi/acpica/uterror.c
@@ -217,8 +217,9 @@ acpi_ut_namespace_error(const char *module_name,
 	} else {
 		/* Convert path to external format */
 
-		status = acpi_ns_externalize_name(ACPI_UINT32_MAX,
-						  internal_name, NULL, &name);
+		status =
+		    acpi_ns_externalize_name(ACPI_UINT32_MAX, internal_name,
+					     NULL, &name);
 
 		/* Print target name */
 
@@ -271,9 +272,8 @@ acpi_ut_method_error(const char *module_name,
 	acpi_os_printf(ACPI_MSG_ERROR);
 
 	if (path) {
-		status =
-		    acpi_ns_get_node(prefix_node, path, ACPI_NS_NO_UPSEARCH,
-				     &node);
+		status = acpi_ns_get_node(prefix_node, path,
+					  ACPI_NS_NO_UPSEARCH, &node);
 		if (ACPI_FAILURE(status)) {
 			acpi_os_printf("[Could not get node by pathname]");
 		}
diff --git a/drivers/acpi/acpica/utfileio.c b/drivers/acpi/acpica/utfileio.c
index d435b7b..be49c71 100644
--- a/drivers/acpi/acpica/utfileio.c
+++ b/drivers/acpi/acpica/utfileio.c
@@ -106,6 +106,7 @@ acpi_ut_check_text_mode_corruption(u8 *table, u32 table_length, u32 file_length)
 
 				pairs++;
 			}
+
 			i++;
 		}
 	}
@@ -125,6 +126,7 @@ acpi_ut_check_text_mode_corruption(u8 *table, u32 table_length, u32 file_length)
 	acpi_os_printf("Table has been corrupted by text mode conversion\n");
 	acpi_os_printf("All LFs (%u) were changed to CR/LF pairs\n", pairs);
 	acpi_os_printf("Table cannot be repaired!\n");
+
 	return (AE_BAD_VALUE);
 }
 
diff --git a/drivers/acpi/acpica/utmath.c b/drivers/acpi/acpica/utmath.c
index f9ff100..58b5d42 100644
--- a/drivers/acpi/acpica/utmath.c
+++ b/drivers/acpi/acpica/utmath.c
@@ -111,6 +111,7 @@ acpi_ut_short_divide(u64 dividend,
 	 */
 	ACPI_DIV_64_BY_32(0, dividend_ovl.part.hi, divisor,
 			  quotient.part.hi, remainder32);
+
 	ACPI_DIV_64_BY_32(remainder32, dividend_ovl.part.lo, divisor,
 			  quotient.part.lo, remainder32);
 
@@ -179,6 +180,7 @@ acpi_ut_divide(u64 in_dividend,
 		 */
 		ACPI_DIV_64_BY_32(0, dividend.part.hi, divisor.part.lo,
 				  quotient.part.hi, partial1);
+
 		ACPI_DIV_64_BY_32(partial1, dividend.part.lo, divisor.part.lo,
 				  quotient.part.lo, remainder.part.lo);
 	}
@@ -206,12 +208,12 @@ acpi_ut_divide(u64 in_dividend,
 
 		ACPI_DIV_64_BY_32(normalized_dividend.part.hi,
 				  normalized_dividend.part.lo,
-				  normalized_divisor.part.lo,
-				  quotient.part.lo, partial1);
+				  normalized_divisor.part.lo, quotient.part.lo,
+				  partial1);
 
 		/*
-		 * The quotient is always 32 bits, and simply requires adjustment.
-		 * The 64-bit remainder must be generated.
+		 * The quotient is always 32 bits, and simply requires
+		 * adjustment. The 64-bit remainder must be generated.
 		 */
 		partial1 = quotient.part.lo * divisor.part.hi;
 		partial2.full = (u64) quotient.part.lo * divisor.part.lo;
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index bd4443b..eab1cfe 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -264,8 +264,8 @@ acpi_ut_walk_package_tree(union acpi_operand_object *source_object,
 		 */
 		if ((!this_source_obj) ||
 		    (ACPI_GET_DESCRIPTOR_TYPE(this_source_obj) !=
-		     ACPI_DESC_TYPE_OPERAND)
-		    || (this_source_obj->common.type != ACPI_TYPE_PACKAGE)) {
+		     ACPI_DESC_TYPE_OPERAND) ||
+		    (this_source_obj->common.type != ACPI_TYPE_PACKAGE)) {
 			status =
 			    walk_callback(ACPI_COPY_TYPE_SIMPLE,
 					  this_source_obj, state, context);
@@ -318,9 +318,10 @@ acpi_ut_walk_package_tree(union acpi_operand_object *source_object,
 			 * The callback above returned a new target package object.
 			 */
 			acpi_ut_push_generic_state(&state_list, state);
-			state = acpi_ut_create_pkg_state(this_source_obj,
-							 state->pkg.
-							 this_target_obj, 0);
+			state =
+			    acpi_ut_create_pkg_state(this_source_obj,
+						     state->pkg.this_target_obj,
+						     0);
 			if (!state) {
 
 				/* Free any stacked Update State objects */
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index ea0c207..038ff84 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -273,8 +273,9 @@ acpi_status acpi_ut_acquire_mutex(acpi_mutex_handle mutex_id)
 			  (u32)this_thread_id,
 			  acpi_ut_get_mutex_name(mutex_id)));
 
-	status = acpi_os_acquire_mutex(acpi_gbl_mutex_info[mutex_id].mutex,
-				       ACPI_WAIT_FOREVER);
+	status =
+	    acpi_os_acquire_mutex(acpi_gbl_mutex_info[mutex_id].mutex,
+				  ACPI_WAIT_FOREVER);
 	if (ACPI_SUCCESS(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
 				  "Thread %u acquired Mutex [%s]\n",
diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
index 1d5f6b1..9c3cadc 100644
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -282,8 +282,8 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 
 		/* Divide the digit into the correct position */
 
-		(void)acpi_ut_short_divide((dividend - (u64)this_digit),
-					   base, &quotient, NULL);
+		(void)acpi_ut_short_divide((dividend - (u64)this_digit), base,
+					   &quotient, NULL);
 
 		if (return_value > quotient) {
 			if (to_integer_op) {
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index c7e11cc..787eccf 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -112,9 +112,9 @@ union acpi_operand_object *acpi_ut_create_internal_object_dbg(const char
 
 		/* These types require a secondary object */
 
-		second_object = acpi_ut_allocate_object_desc_dbg(module_name,
-								 line_number,
-								 component_id);
+		second_object =
+		    acpi_ut_allocate_object_desc_dbg(module_name, line_number,
+						     component_id);
 		if (!second_object) {
 			acpi_ut_delete_object_desc(object);
 			return_PTR(NULL);
@@ -254,6 +254,7 @@ union acpi_operand_object *acpi_ut_create_buffer_object(acpi_size buffer_size)
 		if (!buffer) {
 			ACPI_ERROR((AE_INFO, "Could not allocate size %u",
 				    (u32)buffer_size));
+
 			acpi_ut_remove_reference(buffer_desc);
 			return_PTR(NULL);
 		}
@@ -306,6 +307,7 @@ union acpi_operand_object *acpi_ut_create_string_object(acpi_size string_size)
 	if (!string) {
 		ACPI_ERROR((AE_INFO, "Could not allocate size %u",
 			    (u32)string_size));
+
 		acpi_ut_remove_reference(string_desc);
 		return_PTR(NULL);
 	}
@@ -649,8 +651,9 @@ acpi_ut_get_package_object_size(union acpi_operand_object *internal_object,
 	info.object_space = 0;
 	info.num_packages = 1;
 
-	status = acpi_ut_walk_package_tree(internal_object, NULL,
-					   acpi_ut_get_element_length, &info);
+	status =
+	    acpi_ut_walk_package_tree(internal_object, NULL,
+				      acpi_ut_get_element_length, &info);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -660,7 +663,8 @@ acpi_ut_get_package_object_size(union acpi_operand_object *internal_object,
 	 * just add the length of the package objects themselves.
 	 * Round up to the next machine word.
 	 */
-	info.length += ACPI_ROUND_UP_TO_NATIVE_WORD(sizeof(union acpi_object)) *
+	info.length +=
+	    ACPI_ROUND_UP_TO_NATIVE_WORD(sizeof(union acpi_object)) *
 	    (acpi_size) info.num_packages;
 
 	/* Return the total package length */
@@ -692,8 +696,8 @@ acpi_ut_get_object_size(union acpi_operand_object *internal_object,
 	ACPI_FUNCTION_ENTRY();
 
 	if ((ACPI_GET_DESCRIPTOR_TYPE(internal_object) ==
-	     ACPI_DESC_TYPE_OPERAND)
-	    && (internal_object->common.type == ACPI_TYPE_PACKAGE)) {
+	     ACPI_DESC_TYPE_OPERAND) &&
+	    (internal_object->common.type == ACPI_TYPE_PACKAGE)) {
 		status =
 		    acpi_ut_get_package_object_size(internal_object,
 						    obj_length);
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 8f3d203a..0809d73 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -269,9 +269,10 @@ acpi_status acpi_ut_remove_interface(acpi_string interface_name)
 	previous_interface = next_interface = acpi_gbl_supported_interfaces;
 	while (next_interface) {
 		if (!strcmp(interface_name, next_interface->name)) {
-
-			/* Found: name is in either the static list or was added at runtime */
-
+			/*
+			 * Found: name is in either the static list
+			 * or was added at runtime
+			 */
 			if (next_interface->flags & ACPI_OSI_DYNAMIC) {
 
 				/* Interface was added dynamically, remove and free it */
@@ -288,8 +289,8 @@ acpi_status acpi_ut_remove_interface(acpi_string interface_name)
 				ACPI_FREE(next_interface);
 			} else {
 				/*
-				 * Interface is in static list. If marked invalid, then it
-				 * does not actually exist. Else, mark it invalid.
+				 * Interface is in static list. If marked invalid, then
+				 * it does not actually exist. Else, mark it invalid.
 				 */
 				if (next_interface->flags & ACPI_OSI_INVALID) {
 					return (AE_NOT_EXIST);
diff --git a/drivers/acpi/acpica/utownerid.c b/drivers/acpi/acpica/utownerid.c
index 2959217..ebb811c 100644
--- a/drivers/acpi/acpica/utownerid.c
+++ b/drivers/acpi/acpica/utownerid.c
@@ -73,8 +73,8 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id * owner_id)
 	/* Guard against multiple allocations of ID to the same location */
 
 	if (*owner_id) {
-		ACPI_ERROR((AE_INFO, "Owner ID [0x%2.2X] already exists",
-			    *owner_id));
+		ACPI_ERROR((AE_INFO,
+			    "Owner ID [0x%2.2X] already exists", *owner_id));
 		return_ACPI_STATUS(AE_ALREADY_EXISTS);
 	}
 
@@ -87,8 +87,8 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id * owner_id)
 
 	/*
 	 * Find a free owner ID, cycle through all possible IDs on repeated
-	 * allocations. (ACPI_NUM_OWNERID_MASKS + 1) because first index may have
-	 * to be scanned twice.
+	 * allocations. (ACPI_NUM_OWNERID_MASKS + 1) because first index
+	 * may have to be scanned twice.
 	 */
 	for (i = 0, j = acpi_gbl_last_owner_id_index;
 	     i < (ACPI_NUM_OWNERID_MASKS + 1); i++, j++) {
@@ -141,8 +141,8 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id * owner_id)
 	 * they are released when a table is unloaded or a method completes
 	 * execution.
 	 *
-	 * If this error happens, there may be very deep nesting of invoked control
-	 * methods, or there may be a bug where the IDs are not released.
+	 * If this error happens, there may be very deep nesting of invoked
+	 * control methods, or there may be a bug where the IDs are not released.
 	 */
 	status = AE_OWNER_ID_LIMIT;
 	ACPI_ERROR((AE_INFO,
diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utpredef.c
index 97898ed..9f8e415 100644
--- a/drivers/acpi/acpica/utpredef.c
+++ b/drivers/acpi/acpica/utpredef.c
@@ -225,8 +225,10 @@ const union acpi_predefined_info *acpi_ut_match_resource_name(char *name)
 {
 	const union acpi_predefined_info *this_name;
 
-	/* Quick check for a predefined name, first character must be underscore */
-
+	/*
+	 * Quick check for a predefined name, first character must
+	 * be underscore
+	 */
 	if (name[0] != '_') {
 		return (NULL);
 	}
diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index b26297c..01f04da 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -314,8 +314,9 @@ static char *acpi_ut_format_number(char *string,
 	if (need_prefix) {
 		string = acpi_ut_bound_string_output(string, end, '0');
 		if (base == 16) {
-			string = acpi_ut_bound_string_output(string, end,
-							     upper ? 'X' : 'x');
+			string =
+			    acpi_ut_bound_string_output(string, end,
+							upper ? 'X' : 'x');
 		}
 	}
 	if (!(type & ACPI_FORMAT_LEFT)) {
@@ -400,6 +401,7 @@ acpi_ut_vsnprintf(char *string,
 			} else {
 				break;
 			}
+
 		} while (1);
 
 		/* Process width */
@@ -429,6 +431,7 @@ acpi_ut_vsnprintf(char *string,
 				++format;
 				precision = va_arg(args, int);
 			}
+
 			if (precision < 0) {
 				precision = 0;
 			}
@@ -488,10 +491,12 @@ acpi_ut_vsnprintf(char *string,
 									' ');
 				}
 			}
+
 			for (i = 0; i < length; ++i) {
 				pos = acpi_ut_bound_string_output(pos, end, *s);
 				++s;
 			}
+
 			while (length < width--) {
 				pos =
 				    acpi_ut_bound_string_output(pos, end, ' ');
@@ -529,9 +534,9 @@ acpi_ut_vsnprintf(char *string,
 			}
 
 			p = va_arg(args, void *);
-			pos = acpi_ut_format_number(pos, end,
-						    ACPI_TO_INTEGER(p), 16,
-						    width, precision, type);
+			pos =
+			    acpi_ut_format_number(pos, end, ACPI_TO_INTEGER(p),
+						  16, width, precision, type);
 			continue;
 
 		default:
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index b3505db..d50b41c 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -441,8 +441,8 @@ acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
 		    acpi_ut_validate_resource(walk_state, aml, &resource_index);
 		if (ACPI_FAILURE(status)) {
 			/*
-			 * Exit on failure. Cannot continue because the descriptor length
-			 * may be bogus also.
+			 * Exit on failure. Cannot continue because the descriptor
+			 * length may be bogus also.
 			 */
 			return_ACPI_STATUS(status);
 		}
@@ -568,8 +568,8 @@ acpi_ut_validate_resource(struct acpi_walk_state *walk_state,
 	}
 
 	/*
-	 * Check validity of the resource type, via acpi_gbl_resource_types. Zero
-	 * indicates an invalid resource.
+	 * Check validity of the resource type, via acpi_gbl_resource_types.
+	 * Zero indicates an invalid resource.
 	 */
 	if (!acpi_gbl_resource_types[resource_index]) {
 		goto invalid_resource;
diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/utstate.c
index f201171..0050e00 100644
--- a/drivers/acpi/acpica/utstate.c
+++ b/drivers/acpi/acpica/utstate.c
@@ -246,6 +246,7 @@ union acpi_generic_state *acpi_ut_create_pkg_state(void *internal_object,
 	state->pkg.dest_object = external_object;
 	state->pkg.index = index;
 	state->pkg.num_packages = 1;
+
 	return (state);
 }
 
@@ -279,6 +280,7 @@ union acpi_generic_state *acpi_ut_create_control_state(void)
 
 	state->common.descriptor_type = ACPI_DESC_TYPE_STATE_CONTROL;
 	state->common.state = ACPI_CONTROL_CONDITIONAL_EXECUTING;
+
 	return (state);
 }
 
@@ -304,5 +306,6 @@ void acpi_ut_delete_generic_state(union acpi_generic_state *state)
 	if (state) {
 		(void)acpi_os_release_object(acpi_gbl_state_cache, state);
 	}
+
 	return;
 }
diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index 4ddd105..0c2e2d2 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -135,6 +135,7 @@ void acpi_ut_print_string(char *string, u16 max_length)
 			break;
 		}
 	}
+
 	acpi_os_printf("\"");
 
 	if (i == max_length && string[i]) {
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index 9a7dc81..ea698e9 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -150,9 +150,9 @@ void *acpi_ut_allocate_and_track(acpi_size size,
 		return (NULL);
 	}
 
-	status = acpi_ut_track_allocation(allocation, size,
-					  ACPI_MEM_MALLOC, component, module,
-					  line);
+	status =
+	    acpi_ut_track_allocation(allocation, size, ACPI_MEM_MALLOC,
+				     component, module, line);
 	if (ACPI_FAILURE(status)) {
 		acpi_os_free(allocation);
 		return (NULL);
@@ -161,6 +161,7 @@ void *acpi_ut_allocate_and_track(acpi_size size,
 	acpi_gbl_global_list->total_allocated++;
 	acpi_gbl_global_list->total_size += (u32)size;
 	acpi_gbl_global_list->current_total_size += (u32)size;
+
 	if (acpi_gbl_global_list->current_total_size >
 	    acpi_gbl_global_list->max_occupied) {
 		acpi_gbl_global_list->max_occupied =
@@ -223,6 +224,7 @@ void *acpi_ut_allocate_zeroed_and_track(acpi_size size,
 	acpi_gbl_global_list->total_allocated++;
 	acpi_gbl_global_list->total_size += (u32)size;
 	acpi_gbl_global_list->current_total_size += (u32)size;
+
 	if (acpi_gbl_global_list->current_total_size >
 	    acpi_gbl_global_list->max_occupied) {
 		acpi_gbl_global_list->max_occupied =
@@ -269,8 +271,8 @@ acpi_ut_free_and_track(void *allocation,
 	acpi_gbl_global_list->total_freed++;
 	acpi_gbl_global_list->current_total_size -= debug_block->size;
 
-	status = acpi_ut_remove_allocation(debug_block,
-					   component, module, line);
+	status =
+	    acpi_ut_remove_allocation(debug_block, component, module, line);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Could not free memory"));
 	}
@@ -525,35 +527,35 @@ void acpi_ut_dump_allocation_info(void)
 
 /*
 	ACPI_DEBUG_PRINT (TRACE_ALLOCATIONS | TRACE_TABLES,
-			  ("%30s: %4d (%3d Kb)\n", "Current allocations",
-			  mem_list->current_count,
-			  ROUND_UP_TO_1K (mem_list->current_size)));
+		("%30s: %4d (%3d Kb)\n", "Current allocations",
+		mem_list->current_count,
+		ROUND_UP_TO_1K (mem_list->current_size)));
 
 	ACPI_DEBUG_PRINT (TRACE_ALLOCATIONS | TRACE_TABLES,
-			  ("%30s: %4d (%3d Kb)\n", "Max concurrent allocations",
-			  mem_list->max_concurrent_count,
-			  ROUND_UP_TO_1K (mem_list->max_concurrent_size)));
+		("%30s: %4d (%3d Kb)\n", "Max concurrent allocations",
+		mem_list->max_concurrent_count,
+		ROUND_UP_TO_1K (mem_list->max_concurrent_size)));
 
 	ACPI_DEBUG_PRINT (TRACE_ALLOCATIONS | TRACE_TABLES,
-			  ("%30s: %4d (%3d Kb)\n", "Total (all) internal objects",
-			  running_object_count,
-			  ROUND_UP_TO_1K (running_object_size)));
+		("%30s: %4d (%3d Kb)\n", "Total (all) internal objects",
+		running_object_count,
+		ROUND_UP_TO_1K (running_object_size)));
 
 	ACPI_DEBUG_PRINT (TRACE_ALLOCATIONS | TRACE_TABLES,
-			  ("%30s: %4d (%3d Kb)\n", "Total (all) allocations",
-			  running_alloc_count,
-			  ROUND_UP_TO_1K (running_alloc_size)));
+		("%30s: %4d (%3d Kb)\n", "Total (all) allocations",
+		running_alloc_count,
+		ROUND_UP_TO_1K (running_alloc_size)));
 
 	ACPI_DEBUG_PRINT (TRACE_ALLOCATIONS | TRACE_TABLES,
-			  ("%30s: %4d (%3d Kb)\n", "Current Nodes",
-			  acpi_gbl_current_node_count,
-			  ROUND_UP_TO_1K (acpi_gbl_current_node_size)));
+		("%30s: %4d (%3d Kb)\n", "Current Nodes",
+		acpi_gbl_current_node_count,
+		ROUND_UP_TO_1K (acpi_gbl_current_node_size)));
 
 	ACPI_DEBUG_PRINT (TRACE_ALLOCATIONS | TRACE_TABLES,
-			  ("%30s: %4d (%3d Kb)\n", "Max Nodes",
-			  acpi_gbl_max_concurrent_node_count,
-			  ROUND_UP_TO_1K ((acpi_gbl_max_concurrent_node_count *
-					 sizeof (struct acpi_namespace_node)))));
+		("%30s: %4d (%3d Kb)\n", "Max Nodes",
+		acpi_gbl_max_concurrent_node_count,
+		ROUND_UP_TO_1K ((acpi_gbl_max_concurrent_node_count *
+			sizeof (struct acpi_namespace_node)))));
 */
 	return_VOID;
 }
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index f9c8f9c..9f3f0a1 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -154,7 +154,6 @@ acpi_status acpi_get_system_info(struct acpi_buffer * out_buffer)
 	 * Populate the return buffer
 	 */
 	info_ptr = (struct acpi_system_info *)out_buffer->pointer;
-
 	info_ptr->acpi_ca_version = ACPI_CA_VERSION;
 
 	/* System flags (ACPI capabilities) */
@@ -216,7 +215,6 @@ acpi_status acpi_get_statistics(struct acpi_statistics *stats)
 	/* Other counters */
 
 	stats->method_count = acpi_method_count;
-
 	return_ACPI_STATUS(AE_OK);
 }
 
diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index 98d5787..f6cbaf4 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -117,6 +117,7 @@ acpi_exception(const char *module_name,
 		acpi_os_printf(ACPI_MSG_EXCEPTION "%s, ",
 			       acpi_format_exception(status));
 	}
+
 	va_start(arg_list, format);
 	acpi_os_vprintf(format, arg_list);
 	ACPI_MSG_SUFFIX;
diff --git a/drivers/acpi/acpica/utxfmutex.c b/drivers/acpi/acpica/utxfmutex.c
index f2606af..95d6123 100644
--- a/drivers/acpi/acpica/utxfmutex.c
+++ b/drivers/acpi/acpica/utxfmutex.c
@@ -89,9 +89,9 @@ acpi_ut_get_mutex_object(acpi_handle handle,
 
 	mutex_node = handle;
 	if (pathname != NULL) {
-		status = acpi_get_handle(handle, pathname,
-					 ACPI_CAST_PTR(acpi_handle,
-						       &mutex_node));
+		status =
+		    acpi_get_handle(handle, pathname,
+				    ACPI_CAST_PTR(acpi_handle, &mutex_node));
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
diff --git a/tools/power/acpi/common/getopt.c b/tools/power/acpi/common/getopt.c
index 326e826..2496629 100644
--- a/tools/power/acpi/common/getopt.c
+++ b/tools/power/acpi/common/getopt.c
@@ -85,6 +85,7 @@ static int current_char_ptr = 1;
 
 int acpi_getopt_argument(int argc, char **argv)
 {
+
 	acpi_gbl_optind--;
 	current_char_ptr++;
 
diff --git a/tools/power/acpi/os_specific/service_layers/oslibcfs.c b/tools/power/acpi/os_specific/service_layers/oslibcfs.c
index b51e40a..6df7583 100644
--- a/tools/power/acpi/os_specific/service_layers/oslibcfs.c
+++ b/tools/power/acpi/os_specific/service_layers/oslibcfs.c
@@ -73,6 +73,7 @@ ACPI_FILE acpi_os_open_file(const char *path, u8 modes)
 	if (modes & ACPI_FILE_WRITING) {
 		modes_str[i++] = 'w';
 	}
+
 	if (modes & ACPI_FILE_BINARY) {
 		modes_str[i++] = 'b';
 	}
@@ -101,6 +102,7 @@ ACPI_FILE acpi_os_open_file(const char *path, u8 modes)
 
 void acpi_os_close_file(ACPI_FILE file)
 {
+
 	fclose(file);
 }
 
@@ -202,6 +204,7 @@ acpi_status acpi_os_set_file_offset(ACPI_FILE file, long offset, u8 from)
 	if (from == ACPI_FILE_BEGIN) {
 		ret = fseek(file, offset, SEEK_SET);
 	}
+
 	if (from == ACPI_FILE_END) {
 		ret = fseek(file, offset, SEEK_END);
 	}
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index a1c62de..bbdf9e8 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -48,6 +48,18 @@
 
 static int ap_is_existing_file(char *pathname);
 
+/******************************************************************************
+ *
+ * FUNCTION:    ap_is_existing_file
+ *
+ * PARAMETERS:  pathname            - Output filename
+ *
+ * RETURN:      0 on success
+ *
+ * DESCRIPTION: Query for file overwrite if it already exists.
+ *
+ ******************************************************************************/
+
 static int ap_is_existing_file(char *pathname)
 {
 #ifndef _GNU_EFI
@@ -136,6 +148,7 @@ int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 	} else {
 		ACPI_MOVE_NAME(filename, table->signature);
 	}
+
 	filename[0] = (char)tolower((int)filename[0]);
 	filename[1] = (char)tolower((int)filename[1]);
 	filename[2] = (char)tolower((int)filename[2]);
-- 
1.7.10
