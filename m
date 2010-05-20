From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/22] ACPICA: Standardize integer output for ACPICA
 warnings/errors
Date: Thu, 20 May 2010 01:18:31 -0400
Message-ID: <f6a22b0bc417042e83117f52ab1a03696af185ab.1274332657.git.len.brown@intel.com>
References: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:53982 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756Ab0ETFTO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 01:19:14 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P008O0DFHCA57@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 00:19:02 -0500 (CDT)
In-reply-to: <1274332730-27370-1-git-send-email-lenb@kernel.org>
In-reply-to: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
References: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Always use 0x prefix for hex output, use %u for integer output
(all integers are unsigned.)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/dsfield.c  |    2 +-
 drivers/acpi/acpica/dsmethod.c |    2 +-
 drivers/acpi/acpica/dsmthdat.c |   10 +++++-----
 drivers/acpi/acpica/dsobject.c |   14 +++++++-------
 drivers/acpi/acpica/dsopcode.c |   13 +++++++------
 drivers/acpi/acpica/dswexec.c  |    6 +++---
 drivers/acpi/acpica/dswstate.c |   10 +++++-----
 drivers/acpi/acpica/evevent.c  |    2 +-
 drivers/acpi/acpica/evgpe.c    |   12 ++++++------
 drivers/acpi/acpica/evgpeblk.c |    4 ++--
 drivers/acpi/acpica/evmisc.c   |    2 +-
 drivers/acpi/acpica/evxface.c  |    4 ++--
 drivers/acpi/acpica/exconvrt.c |    4 ++--
 drivers/acpi/acpica/excreate.c |    4 ++--
 drivers/acpi/acpica/exfield.c  |    2 +-
 drivers/acpi/acpica/exfldio.c  |   16 ++++++++--------
 drivers/acpi/acpica/exmisc.c   |    8 ++++----
 drivers/acpi/acpica/exmutex.c  |    4 ++--
 drivers/acpi/acpica/exnames.c  |    4 ++--
 drivers/acpi/acpica/exoparg1.c |   16 ++++++++--------
 drivers/acpi/acpica/exoparg2.c |   10 +++++-----
 drivers/acpi/acpica/exoparg3.c |    4 ++--
 drivers/acpi/acpica/exoparg6.c |    4 ++--
 drivers/acpi/acpica/exprep.c   |    4 ++--
 drivers/acpi/acpica/exregion.c |    4 ++--
 drivers/acpi/acpica/exresnte.c |    4 ++--
 drivers/acpi/acpica/exresolv.c |   11 ++++++-----
 drivers/acpi/acpica/exresop.c  |    8 ++++----
 drivers/acpi/acpica/exstore.c  |    2 +-
 drivers/acpi/acpica/exsystem.c |    2 +-
 drivers/acpi/acpica/hwregs.c   |    6 +++---
 drivers/acpi/acpica/hwsleep.c  |    2 +-
 drivers/acpi/acpica/hwvalid.c  |    2 +-
 drivers/acpi/acpica/nsaccess.c |    2 +-
 drivers/acpi/acpica/nsdump.c   |    4 ++--
 drivers/acpi/acpica/nsnames.c  |    2 +-
 drivers/acpi/acpica/nssearch.c |    2 +-
 drivers/acpi/acpica/nsutils.c  |    4 ++--
 drivers/acpi/acpica/psargs.c   |    4 ++--
 drivers/acpi/acpica/psloop.c   |    3 +--
 drivers/acpi/acpica/rscreate.c |   14 +++++++-------
 drivers/acpi/acpica/rslist.c   |    6 +++---
 drivers/acpi/acpica/rsmisc.c   |    4 ++--
 drivers/acpi/acpica/tbfadt.c   |   16 ++++++++--------
 drivers/acpi/acpica/tbutils.c  |    4 ++--
 drivers/acpi/acpica/tbxfroot.c |    6 +++---
 drivers/acpi/acpica/utalloc.c  |    2 +-
 drivers/acpi/acpica/utdelete.c |    6 +++---
 drivers/acpi/acpica/uteval.c   |    2 +-
 drivers/acpi/acpica/utmisc.c   |    6 +++---
 drivers/acpi/acpica/utmutex.c  |    4 ++--
 drivers/acpi/acpica/utobject.c |    8 ++++----
 52 files changed, 151 insertions(+), 150 deletions(-)

diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index bb13817..347bee1 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -323,7 +323,7 @@ acpi_ds_get_field_names(struct acpi_create_field_info *info,
 		default:
 
 			ACPI_ERROR((AE_INFO,
-				    "Invalid opcode in field list: %X",
+				    "Invalid opcode in field list: 0x%X",
 				    arg->common.aml_opcode));
 			return_ACPI_STATUS(AE_AML_BAD_OPCODE);
 		}
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 7210392..2a9a561 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -225,7 +225,7 @@ acpi_ds_begin_method_execution(struct acpi_namespace_node *method_node,
 		    (walk_state->thread->current_sync_level >
 		     obj_desc->method.mutex->mutex.sync_level)) {
 			ACPI_ERROR((AE_INFO,
-				    "Cannot acquire Mutex for method [%4.4s], current SyncLevel is too large (%d)",
+				    "Cannot acquire Mutex for method [%4.4s], current SyncLevel is too large (%u)",
 				    acpi_ut_get_node_name(method_node),
 				    walk_state->thread->current_sync_level));
 
diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index cc343b9..f3d52f5 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -262,7 +262,7 @@ acpi_ds_method_data_get_node(u8 type,
 
 		if (index > ACPI_METHOD_MAX_LOCAL) {
 			ACPI_ERROR((AE_INFO,
-				    "Local index %d is invalid (max %d)",
+				    "Local index %u is invalid (max %u)",
 				    index, ACPI_METHOD_MAX_LOCAL));
 			return_ACPI_STATUS(AE_AML_INVALID_INDEX);
 		}
@@ -276,7 +276,7 @@ acpi_ds_method_data_get_node(u8 type,
 
 		if (index > ACPI_METHOD_MAX_ARG) {
 			ACPI_ERROR((AE_INFO,
-				    "Arg index %d is invalid (max %d)",
+				    "Arg index %u is invalid (max %u)",
 				    index, ACPI_METHOD_MAX_ARG));
 			return_ACPI_STATUS(AE_AML_INVALID_INDEX);
 		}
@@ -287,7 +287,7 @@ acpi_ds_method_data_get_node(u8 type,
 		break;
 
 	default:
-		ACPI_ERROR((AE_INFO, "Type %d is invalid", type));
+		ACPI_ERROR((AE_INFO, "Type %u is invalid", type));
 		return_ACPI_STATUS(AE_TYPE);
 	}
 
@@ -424,7 +424,7 @@ acpi_ds_method_data_get_value(u8 type,
 			case ACPI_REFCLASS_ARG:
 
 				ACPI_ERROR((AE_INFO,
-					    "Uninitialized Arg[%d] at node %p",
+					    "Uninitialized Arg[%u] at node %p",
 					    index, node));
 
 				return_ACPI_STATUS(AE_AML_UNINITIALIZED_ARG);
@@ -440,7 +440,7 @@ acpi_ds_method_data_get_value(u8 type,
 			default:
 
 				ACPI_ERROR((AE_INFO,
-					    "Not a Arg/Local opcode: %X",
+					    "Not a Arg/Local opcode: 0x%X",
 					    type));
 				return_ACPI_STATUS(AE_AML_INTERNAL);
 			}
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 891e08b..3607adc 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -288,7 +288,7 @@ acpi_ds_build_internal_buffer_obj(struct acpi_walk_state *walk_state,
 	if (byte_list) {
 		if (byte_list->common.aml_opcode != AML_INT_BYTELIST_OP) {
 			ACPI_ERROR((AE_INFO,
-				    "Expecting bytelist, got AML opcode %X in op %p",
+				    "Expecting bytelist, found AML opcode 0x%X in op %p",
 				    byte_list->common.aml_opcode, byte_list));
 
 			acpi_ut_remove_reference(obj_desc);
@@ -511,7 +511,7 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 		}
 
 		ACPI_INFO((AE_INFO,
-			   "Actual Package length (0x%X) is larger than NumElements field (0x%X), truncated\n",
+			   "Actual Package length (%u) is larger than NumElements field (%u), truncated\n",
 			   i, element_count));
 	} else if (i < element_count) {
 		/*
@@ -519,7 +519,7 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 		 * Note: this is not an error, the package is padded out with NULLs.
 		 */
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Package List length (0x%X) smaller than NumElements count (0x%X), padded with null elements\n",
+				  "Package List length (%u) smaller than NumElements count (%u), padded with null elements\n",
 				  i, element_count));
 	}
 
@@ -701,7 +701,7 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 			default:
 
 				ACPI_ERROR((AE_INFO,
-					    "Unknown constant opcode %X",
+					    "Unknown constant opcode 0x%X",
 					    opcode));
 				status = AE_AML_OPERAND_TYPE;
 				break;
@@ -717,7 +717,7 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 			break;
 
 		default:
-			ACPI_ERROR((AE_INFO, "Unknown Integer type %X",
+			ACPI_ERROR((AE_INFO, "Unknown Integer type 0x%X",
 				    op_info->type));
 			status = AE_AML_OPERAND_TYPE;
 			break;
@@ -806,7 +806,7 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 			default:
 
 				ACPI_ERROR((AE_INFO,
-					    "Unimplemented reference type for AML opcode: %4.4X",
+					    "Unimplemented reference type for AML opcode: 0x%4.4X",
 					    opcode));
 				return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 			}
@@ -816,7 +816,7 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Unimplemented data type: %X",
+		ACPI_ERROR((AE_INFO, "Unimplemented data type: 0x%X",
 			    obj_desc->common.type));
 
 		status = AE_AML_OPERAND_TYPE;
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index bf980ca..53a7e41 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -292,7 +292,7 @@ acpi_status acpi_ds_get_buffer_arguments(union acpi_operand_object *obj_desc)
 	node = obj_desc->buffer.node;
 	if (!node) {
 		ACPI_ERROR((AE_INFO,
-			    "No pointer back to NS node in buffer obj %p",
+			    "No pointer back to namespace node in buffer object %p",
 			    obj_desc));
 		return_ACPI_STATUS(AE_AML_INTERNAL);
 	}
@@ -336,7 +336,7 @@ acpi_status acpi_ds_get_package_arguments(union acpi_operand_object *obj_desc)
 	node = obj_desc->package.node;
 	if (!node) {
 		ACPI_ERROR((AE_INFO,
-			    "No pointer back to NS node in package %p",
+			    "No pointer back to namespace node in package %p",
 			    obj_desc));
 		return_ACPI_STATUS(AE_AML_INTERNAL);
 	}
@@ -580,7 +580,8 @@ acpi_ds_init_buffer_field(u16 aml_opcode,
 	default:
 
 		ACPI_ERROR((AE_INFO,
-			    "Unknown field creation opcode %02x", aml_opcode));
+			    "Unknown field creation opcode 0x%02X",
+			    aml_opcode));
 		status = AE_AML_BAD_OPCODE;
 		goto cleanup;
 	}
@@ -589,7 +590,7 @@ acpi_ds_init_buffer_field(u16 aml_opcode,
 
 	if ((bit_offset + bit_count) > (8 * (u32) buffer_desc->buffer.length)) {
 		ACPI_ERROR((AE_INFO,
-			    "Field [%4.4s] at %d exceeds Buffer [%4.4s] size %d (bits)",
+			    "Field [%4.4s] at %u exceeds Buffer [%4.4s] size %u (bits)",
 			    acpi_ut_get_node_name(result_desc),
 			    bit_offset + bit_count,
 			    acpi_ut_get_node_name(buffer_desc->buffer.node),
@@ -693,7 +694,7 @@ acpi_ds_eval_buffer_field_operands(struct acpi_walk_state *walk_state,
 	status = acpi_ex_resolve_operands(op->common.aml_opcode,
 					  ACPI_WALK_OPERANDS, walk_state);
 	if (ACPI_FAILURE(status)) {
-		ACPI_ERROR((AE_INFO, "(%s) bad operand(s) (%X)",
+		ACPI_ERROR((AE_INFO, "(%s) bad operand(s), status 0x%X",
 			    acpi_ps_get_opcode_name(op->common.aml_opcode),
 			    status));
 
@@ -1461,7 +1462,7 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Unknown control opcode=%X Op=%p",
+		ACPI_ERROR((AE_INFO, "Unknown control opcode=0x%X Op=%p",
 			    op->common.aml_opcode, op));
 
 		status = AE_AML_BAD_OPCODE;
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 6b76c48..d555b37 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -140,7 +140,7 @@ acpi_ds_get_predicate_value(struct acpi_walk_state *walk_state,
 
 	if (local_obj_desc->common.type != ACPI_TYPE_INTEGER) {
 		ACPI_ERROR((AE_INFO,
-			    "Bad predicate (not an integer) ObjDesc=%p State=%p Type=%X",
+			    "Bad predicate (not an integer) ObjDesc=%p State=%p Type=0x%X",
 			    obj_desc, walk_state, obj_desc->common.type));
 
 		status = AE_AML_OPERAND_TYPE;
@@ -354,7 +354,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 	op_class = walk_state->op_info->class;
 
 	if (op_class == AML_CLASS_UNKNOWN) {
-		ACPI_ERROR((AE_INFO, "Unknown opcode %X",
+		ACPI_ERROR((AE_INFO, "Unknown opcode 0x%X",
 			    op->common.aml_opcode));
 		return_ACPI_STATUS(AE_NOT_IMPLEMENTED);
 	}
@@ -678,7 +678,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 		default:
 
 			ACPI_ERROR((AE_INFO,
-				    "Unimplemented opcode, class=%X type=%X Opcode=%X Op=%p",
+				    "Unimplemented opcode, class=0x%X type=0x%X Opcode=-0x%X Op=%p",
 				    op_class, op_type, op->common.aml_opcode,
 				    op));
 
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index 050df81..83155dd 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -179,7 +179,7 @@ acpi_ds_result_push(union acpi_operand_object * object,
 
 	if (!object) {
 		ACPI_ERROR((AE_INFO,
-			    "Null Object! Obj=%p State=%p Num=%X",
+			    "Null Object! Obj=%p State=%p Num=%u",
 			    object, walk_state, walk_state->result_count));
 		return (AE_BAD_PARAMETER);
 	}
@@ -223,7 +223,7 @@ static acpi_status acpi_ds_result_stack_push(struct acpi_walk_state *walk_state)
 
 	if (((u32) walk_state->result_size + ACPI_RESULTS_FRAME_OBJ_NUM) >
 	    ACPI_RESULTS_OBJ_NUM_MAX) {
-		ACPI_ERROR((AE_INFO, "Result stack overflow: State=%p Num=%X",
+		ACPI_ERROR((AE_INFO, "Result stack overflow: State=%p Num=%u",
 			    walk_state, walk_state->result_size));
 		return (AE_STACK_OVERFLOW);
 	}
@@ -314,7 +314,7 @@ acpi_ds_obj_stack_push(void *object, struct acpi_walk_state * walk_state)
 
 	if (walk_state->num_operands >= ACPI_OBJ_NUM_OPERANDS) {
 		ACPI_ERROR((AE_INFO,
-			    "Object stack overflow! Obj=%p State=%p #Ops=%X",
+			    "Object stack overflow! Obj=%p State=%p #Ops=%u",
 			    object, walk_state, walk_state->num_operands));
 		return (AE_STACK_OVERFLOW);
 	}
@@ -365,7 +365,7 @@ acpi_ds_obj_stack_pop(u32 pop_count, struct acpi_walk_state * walk_state)
 
 		if (walk_state->num_operands == 0) {
 			ACPI_ERROR((AE_INFO,
-				    "Object stack underflow! Count=%X State=%p #Ops=%X",
+				    "Object stack underflow! Count=%X State=%p #Ops=%u",
 				    pop_count, walk_state,
 				    walk_state->num_operands));
 			return (AE_STACK_UNDERFLOW);
@@ -377,7 +377,7 @@ acpi_ds_obj_stack_pop(u32 pop_count, struct acpi_walk_state * walk_state)
 		walk_state->operands[walk_state->num_operands] = NULL;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Count=%X State=%p #Ops=%X\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Count=%X State=%p #Ops=%u\n",
 			  pop_count, walk_state, walk_state->num_operands));
 
 	return (AE_OK);
diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index c1e6f47..f579591 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -302,7 +302,7 @@ static u32 acpi_ev_fixed_event_dispatch(u32 event)
 					      ACPI_DISABLE_EVENT);
 
 		ACPI_ERROR((AE_INFO,
-			    "No installed handler for fixed event [%08X]",
+			    "No installed handler for fixed event [0x%08X]",
 			    event));
 
 		return (ACPI_INTERRUPT_NOT_HANDLED);
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 78c5550..b9d50ef 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -499,7 +499,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 		status = acpi_hw_clear_gpe(gpe_event_info);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
-					"Unable to clear GPE[%2X]",
+					"Unable to clear GPE[0x%2X]",
 					gpe_number));
 			return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
 		}
@@ -532,7 +532,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 			status = acpi_hw_clear_gpe(gpe_event_info);
 			if (ACPI_FAILURE(status)) {
 				ACPI_EXCEPTION((AE_INFO, status,
-						"Unable to clear GPE[%2X]",
+					"Unable to clear GPE[0x%2X]",
 						gpe_number));
 				return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
 			}
@@ -548,7 +548,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 		status = acpi_ev_disable_gpe(gpe_event_info);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
-					"Unable to disable GPE[%2X]",
+					"Unable to disable GPE[0x%2X]",
 					gpe_number));
 			return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
 		}
@@ -562,7 +562,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 					 gpe_event_info);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
-					"Unable to queue handler for GPE[%2X] - event disabled",
+					"Unable to queue handler for GPE[0x%2X] - event disabled",
 					gpe_number));
 		}
 		break;
@@ -572,7 +572,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 		/* No handler or method to run! */
 
 		ACPI_ERROR((AE_INFO,
-			    "No handler or method for GPE[%2X], disabling event",
+			    "No handler or method for GPE[0x%2X], disabling event",
 			    gpe_number));
 
 		/*
@@ -582,7 +582,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 		status = acpi_ev_disable_gpe(gpe_event_info);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
-					"Unable to disable GPE[%2X]",
+					"Unable to disable GPE[0x%2X]",
 					gpe_number));
 			return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
 		}
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index fef7219..fa47e35 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -1139,8 +1139,8 @@ acpi_status acpi_ev_gpe_initialize(void)
 		if ((register_count0) &&
 		    (gpe_number_max >= acpi_gbl_FADT.gpe1_base)) {
 			ACPI_ERROR((AE_INFO,
-				    "GPE0 block (GPE 0 to %d) overlaps the GPE1 block "
-				    "(GPE %d to %d) - Ignoring GPE1",
+				    "GPE0 block (GPE 0 to %u) overlaps the GPE1 block "
+				    "(GPE %u to %u) - Ignoring GPE1",
 				    gpe_number_max, acpi_gbl_FADT.gpe1_base,
 				    acpi_gbl_FADT.gpe1_base +
 				    ((register_count1 *
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index 9a3cb70..df0aea9 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -590,7 +590,7 @@ void acpi_ev_terminate(void)
 			status = acpi_disable_event(i, 0);
 			if (ACPI_FAILURE(status)) {
 				ACPI_ERROR((AE_INFO,
-					    "Could not disable fixed event %d",
+					    "Could not disable fixed event %u",
 					    (u32) i));
 			}
 		}
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index b407579..ca04823 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -142,7 +142,7 @@ acpi_install_fixed_event_handler(u32 event,
 	if (ACPI_SUCCESS(status))
 		status = acpi_enable_event(event, 0);
 	if (ACPI_FAILURE(status)) {
-		ACPI_WARNING((AE_INFO, "Could not enable fixed event %X",
+		ACPI_WARNING((AE_INFO, "Could not enable fixed event 0x%X",
 			      event));
 
 		/* Remove the handler */
@@ -203,7 +203,7 @@ acpi_remove_fixed_event_handler(u32 event, acpi_event_handler handler)
 
 	if (ACPI_FAILURE(status)) {
 		ACPI_WARNING((AE_INFO,
-			      "Could not write to fixed event enable register %X",
+			      "Could not write to fixed event enable register 0x%X",
 			      event));
 	} else {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Disabled fixed event %X\n",
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index bda7aed..b73bc50 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -650,7 +650,7 @@ acpi_ex_convert_to_target_type(acpi_object_type destination_type,
 
 		default:
 			ACPI_ERROR((AE_INFO,
-				    "Bad destination type during conversion: %X",
+				    "Bad destination type during conversion: 0x%X",
 				    destination_type));
 			status = AE_AML_INTERNAL;
 			break;
@@ -665,7 +665,7 @@ acpi_ex_convert_to_target_type(acpi_object_type destination_type,
 
 	default:
 		ACPI_ERROR((AE_INFO,
-			    "Unknown Target type ID 0x%X AmlOpcode %X DestType %s",
+			    "Unknown Target type ID 0x%X AmlOpcode 0x%X DestType %s",
 			    GET_CURRENT_ARG_TYPE(walk_state->op_info->
 						 runtime_args),
 			    walk_state->opcode,
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 0aa57d9..3c61b48 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -306,12 +306,12 @@ acpi_ex_create_region(u8 * aml_start,
 	 */
 	if ((region_space >= ACPI_NUM_PREDEFINED_REGIONS) &&
 	    (region_space < ACPI_USER_REGION_BEGIN)) {
-		ACPI_ERROR((AE_INFO, "Invalid AddressSpace type %X",
+		ACPI_ERROR((AE_INFO, "Invalid AddressSpace type 0x%X",
 			    region_space));
 		return_ACPI_STATUS(AE_AML_INVALID_SPACE_ID);
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_LOAD, "Region Type - %s (%X)\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_LOAD, "Region Type - %s (0x%X)\n",
 			  acpi_ut_get_region_name(region_space), region_space));
 
 	/* Create the region descriptor */
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 6c79fec..f17d2ff 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -281,7 +281,7 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 
 		if (source_desc->buffer.length < length) {
 			ACPI_ERROR((AE_INFO,
-				    "SMBus or IPMI write requires Buffer of length %X, found length %X",
+				    "SMBus or IPMI write requires Buffer of length %u, found length %u",
 				    length, source_desc->buffer.length));
 
 			return_ACPI_STATUS(AE_AML_BUFFER_LIMIT);
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index f68a216..a6dc26f 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -94,7 +94,7 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 	/* We must have a valid region */
 
 	if (rgn_desc->common.type != ACPI_TYPE_REGION) {
-		ACPI_ERROR((AE_INFO, "Needed Region, found type %X (%s)",
+		ACPI_ERROR((AE_INFO, "Needed Region, found type 0x%X (%s)",
 			    rgn_desc->common.type,
 			    acpi_ut_get_object_type_name(rgn_desc)));
 
@@ -175,7 +175,7 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 			 * byte, and a field with Dword access specified.
 			 */
 			ACPI_ERROR((AE_INFO,
-				    "Field [%4.4s] access width (%d bytes) too large for region [%4.4s] (length %X)",
+				    "Field [%4.4s] access width (%u bytes) too large for region [%4.4s] (length %u)",
 				    acpi_ut_get_node_name(obj_desc->
 							  common_field.node),
 				    obj_desc->common_field.access_byte_width,
@@ -189,7 +189,7 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 		 * exceeds region length, indicate an error
 		 */
 		ACPI_ERROR((AE_INFO,
-			    "Field [%4.4s] Base+Offset+Width %X+%X+%X is beyond end of region [%4.4s] (length %X)",
+			    "Field [%4.4s] Base+Offset+Width %u+%u+%u is beyond end of region [%4.4s] (length %u)",
 			    acpi_ut_get_node_name(obj_desc->common_field.node),
 			    obj_desc->common_field.base_byte_offset,
 			    field_datum_byte_offset,
@@ -281,13 +281,13 @@ acpi_ex_access_region(union acpi_operand_object *obj_desc,
 	if (ACPI_FAILURE(status)) {
 		if (status == AE_NOT_IMPLEMENTED) {
 			ACPI_ERROR((AE_INFO,
-				    "Region %s(%X) not implemented",
+				    "Region %s(0x%X) not implemented",
 				    acpi_ut_get_region_name(rgn_desc->region.
 							    space_id),
 				    rgn_desc->region.space_id));
 		} else if (status == AE_NOT_EXIST) {
 			ACPI_ERROR((AE_INFO,
-				    "Region %s(%X) has no handler",
+				    "Region %s(0x%X) has no handler",
 				    acpi_ut_get_region_name(rgn_desc->region.
 							    space_id),
 				    rgn_desc->region.space_id));
@@ -525,7 +525,7 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Wrong object type in field I/O %X",
+		ACPI_ERROR((AE_INFO, "Wrong object type in field I/O %u",
 			    obj_desc->common.type));
 		status = AE_AML_INTERNAL;
 		break;
@@ -630,7 +630,7 @@ acpi_ex_write_with_update_rule(union acpi_operand_object *obj_desc,
 		default:
 
 			ACPI_ERROR((AE_INFO,
-				    "Unknown UpdateRule value: %X",
+				    "Unknown UpdateRule value: 0x%X",
 				    (obj_desc->common_field.
 				     field_flags &
 				     AML_FIELD_UPDATE_RULE_MASK)));
@@ -689,7 +689,7 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 	if (buffer_length <
 	    ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc->common_field.bit_length)) {
 		ACPI_ERROR((AE_INFO,
-			    "Field size %X (bits) is too large for buffer (%X)",
+			    "Field size %u (bits) is too large for buffer (%u)",
 			    obj_desc->common_field.bit_length, buffer_length));
 
 		return_ACPI_STATUS(AE_BUFFER_OVERFLOW);
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index c5bb1ee..95db4be 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -99,7 +99,7 @@ acpi_ex_get_object_reference(union acpi_operand_object *obj_desc,
 
 		default:
 
-			ACPI_ERROR((AE_INFO, "Unknown Reference Class %2.2X",
+			ACPI_ERROR((AE_INFO, "Unknown Reference Class 0x%2.2X",
 				    obj_desc->reference.class));
 			return_ACPI_STATUS(AE_AML_INTERNAL);
 		}
@@ -115,7 +115,7 @@ acpi_ex_get_object_reference(union acpi_operand_object *obj_desc,
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Invalid descriptor type %X",
+		ACPI_ERROR((AE_INFO, "Invalid descriptor type 0x%X",
 			    ACPI_GET_DESCRIPTOR_TYPE(obj_desc)));
 		return_ACPI_STATUS(AE_TYPE);
 	}
@@ -276,7 +276,7 @@ acpi_ex_do_concatenate(union acpi_operand_object *operand0,
 		break;
 
 	default:
-		ACPI_ERROR((AE_INFO, "Invalid object type: %X",
+		ACPI_ERROR((AE_INFO, "Invalid object type: 0x%X",
 			    operand0->common.type));
 		status = AE_AML_INTERNAL;
 	}
@@ -378,7 +378,7 @@ acpi_ex_do_concatenate(union acpi_operand_object *operand0,
 
 		/* Invalid object type, should not happen here */
 
-		ACPI_ERROR((AE_INFO, "Invalid object type: %X",
+		ACPI_ERROR((AE_INFO, "Invalid object type: 0x%X",
 			    operand0->common.type));
 		status = AE_AML_INTERNAL;
 		goto cleanup;
diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index 7116bc8..2b0d722 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -249,7 +249,7 @@ acpi_ex_acquire_mutex(union acpi_operand_object *time_desc,
 	 */
 	if (walk_state->thread->current_sync_level > obj_desc->mutex.sync_level) {
 		ACPI_ERROR((AE_INFO,
-			    "Cannot acquire Mutex [%4.4s], current SyncLevel is too large (%d)",
+			    "Cannot acquire Mutex [%4.4s], current SyncLevel is too large (%u)",
 			    acpi_ut_get_node_name(obj_desc->mutex.node),
 			    walk_state->thread->current_sync_level));
 		return_ACPI_STATUS(AE_AML_MUTEX_ORDER);
@@ -410,7 +410,7 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 	if (obj_desc->mutex.sync_level !=
 	    walk_state->thread->current_sync_level) {
 		ACPI_ERROR((AE_INFO,
-			    "Cannot release Mutex [%4.4s], SyncLevel mismatch: mutex %d current %d",
+			    "Cannot release Mutex [%4.4s], SyncLevel mismatch: mutex %u current %u",
 			    acpi_ut_get_node_name(obj_desc->mutex.node),
 			    obj_desc->mutex.sync_level,
 			    walk_state->thread->current_sync_level));
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index 679f308..d11e539 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -102,7 +102,7 @@ static char *acpi_ex_allocate_name_string(u32 prefix_count, u32 num_name_segs)
 	name_string = ACPI_ALLOCATE(size_needed);
 	if (!name_string) {
 		ACPI_ERROR((AE_INFO,
-			    "Could not allocate size %d", size_needed));
+			    "Could not allocate size %u", size_needed));
 		return_PTR(NULL);
 	}
 
@@ -216,7 +216,7 @@ static acpi_status acpi_ex_name_segment(u8 ** in_aml_address, char *name_string)
 		 */
 		status = AE_AML_BAD_NAME;
 		ACPI_ERROR((AE_INFO,
-			    "Bad character %02x in name, at %p",
+			    "Bad character 0x%02x in name, at %p",
 			    *aml_address, aml_address));
 	}
 
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index 99adbab..38e0f3c 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -110,7 +110,7 @@ acpi_status acpi_ex_opcode_0A_0T_1R(struct acpi_walk_state *walk_state)
 
 	default:		/*  Unknown opcode  */
 
-		ACPI_ERROR((AE_INFO, "Unknown AML opcode %X",
+		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
 		status = AE_AML_BAD_OPCODE;
 		break;
@@ -189,7 +189,7 @@ acpi_status acpi_ex_opcode_1A_0T_0R(struct acpi_walk_state *walk_state)
 
 	default:		/*  Unknown opcode  */
 
-		ACPI_ERROR((AE_INFO, "Unknown AML opcode %X",
+		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
 		status = AE_AML_BAD_OPCODE;
 		break;
@@ -229,7 +229,7 @@ acpi_status acpi_ex_opcode_1A_1T_0R(struct acpi_walk_state *walk_state)
 
 	default:		/* Unknown opcode */
 
-		ACPI_ERROR((AE_INFO, "Unknown AML opcode %X",
+		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
 		status = AE_AML_BAD_OPCODE;
 		goto cleanup;
@@ -399,7 +399,7 @@ acpi_status acpi_ex_opcode_1A_1T_1R(struct acpi_walk_state *walk_state)
 
 			if (digit > 0) {
 				ACPI_ERROR((AE_INFO,
-					    "Integer too large to convert to BCD: %8.8X%8.8X",
+					    "Integer too large to convert to BCD: 0x%8.8X%8.8X",
 					    ACPI_FORMAT_UINT64(operand[0]->
 							       integer.value)));
 				status = AE_AML_NUMERIC_OVERFLOW;
@@ -540,7 +540,7 @@ acpi_status acpi_ex_opcode_1A_1T_1R(struct acpi_walk_state *walk_state)
 
 	default:		/* Unknown opcode */
 
-		ACPI_ERROR((AE_INFO, "Unknown AML opcode %X",
+		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
 		status = AE_AML_BAD_OPCODE;
 		goto cleanup;
@@ -979,7 +979,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 				default:
 
 					ACPI_ERROR((AE_INFO,
-						    "Unknown Index TargetType %X in reference object %p",
+						    "Unknown Index TargetType 0x%X in reference object %p",
 						    operand[0]->reference.
 						    target_type, operand[0]));
 					status = AE_AML_OPERAND_TYPE;
@@ -1007,7 +1007,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 
 			default:
 				ACPI_ERROR((AE_INFO,
-					    "Unknown class in reference(%p) - %2.2X",
+					    "Unknown class in reference(%p) - 0x%2.2X",
 					    operand[0],
 					    operand[0]->reference.class));
 
@@ -1019,7 +1019,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Unknown AML opcode %X",
+		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
 		status = AE_AML_BAD_OPCODE;
 		goto cleanup;
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index 22841bb..3f3f48b 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -159,7 +159,7 @@ acpi_status acpi_ex_opcode_2A_0T_0R(struct acpi_walk_state *walk_state)
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Unknown AML opcode %X",
+		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
 		status = AE_AML_BAD_OPCODE;
 	}
@@ -224,7 +224,7 @@ acpi_status acpi_ex_opcode_2A_2T_1R(struct acpi_walk_state *walk_state)
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Unknown AML opcode %X",
+		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
 		status = AE_AML_BAD_OPCODE;
 		goto cleanup;
@@ -441,7 +441,7 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
-					"Index (%X%8.8X) is beyond end of object",
+					"Index (0x%8.8X%8.8X) is beyond end of object",
 					ACPI_FORMAT_UINT64(index)));
 			goto cleanup;
 		}
@@ -464,7 +464,7 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Unknown AML opcode %X",
+		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
 		status = AE_AML_BAD_OPCODE;
 		break;
@@ -572,7 +572,7 @@ acpi_status acpi_ex_opcode_2A_0T_1R(struct acpi_walk_state *walk_state)
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Unknown AML opcode %X",
+		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
 		status = AE_AML_BAD_OPCODE;
 		goto cleanup;
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 8bb1012..7a08d23 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -119,7 +119,7 @@ acpi_status acpi_ex_opcode_3A_0T_0R(struct acpi_walk_state *walk_state)
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Unknown AML opcode %X",
+		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
 		status = AE_AML_BAD_OPCODE;
 		goto cleanup;
@@ -244,7 +244,7 @@ acpi_status acpi_ex_opcode_3A_1T_1R(struct acpi_walk_state *walk_state)
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Unknown AML opcode %X",
+		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
 		status = AE_AML_BAD_OPCODE;
 		goto cleanup;
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index f256b6a..4b50730 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -245,7 +245,7 @@ acpi_status acpi_ex_opcode_6A_0T_1R(struct acpi_walk_state * walk_state)
 		index = operand[5]->integer.value;
 		if (index >= operand[0]->package.count) {
 			ACPI_ERROR((AE_INFO,
-				    "Index (%X%8.8X) beyond package end (%X)",
+				    "Index (0x%8.8X%8.8X) beyond package end (0x%X)",
 				    ACPI_FORMAT_UINT64(index),
 				    operand[0]->package.count));
 			status = AE_AML_PACKAGE_LIMIT;
@@ -314,7 +314,7 @@ acpi_status acpi_ex_opcode_6A_0T_1R(struct acpi_walk_state * walk_state)
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Unknown AML opcode %X",
+		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
 		status = AE_AML_BAD_OPCODE;
 		goto cleanup;
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 2fbfe51..25059da 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -275,7 +275,7 @@ acpi_ex_decode_field_access(union acpi_operand_object *obj_desc,
 	default:
 		/* Invalid field access type */
 
-		ACPI_ERROR((AE_INFO, "Unknown field access type %X", access));
+		ACPI_ERROR((AE_INFO, "Unknown field access type 0x%X", access));
 		return_UINT32(0);
 	}
 
@@ -430,7 +430,7 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 		type = acpi_ns_get_type(info->region_node);
 		if (type != ACPI_TYPE_REGION) {
 			ACPI_ERROR((AE_INFO,
-				    "Needed Region, found type %X (%s)",
+				    "Needed Region, found type 0x%X (%s)",
 				    type, acpi_ut_get_type_name(type)));
 
 			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 486b2e5..a8703cc 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -105,7 +105,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 		break;
 
 	default:
-		ACPI_ERROR((AE_INFO, "Invalid SystemMemory width %d",
+		ACPI_ERROR((AE_INFO, "Invalid SystemMemory width %u",
 			    bit_width));
 		return_ACPI_STATUS(AE_AML_OPERAND_VALUE);
 	}
@@ -173,7 +173,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 		mem_info->mapped_logical_address = acpi_os_map_memory((acpi_physical_address) address, map_length);
 		if (!mem_info->mapped_logical_address) {
 			ACPI_ERROR((AE_INFO,
-				    "Could not map memory at %8.8X%8.8X, size %X",
+				    "Could not map memory at 0x%8.8X%8.8X, size %u",
 				    ACPI_FORMAT_NATIVE_UINT(address),
 				    (u32) map_length));
 			mem_info->mapped_length = 0;
diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index fdc1b27..1fa4289 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -252,7 +252,7 @@ acpi_ex_resolve_node_to_value(struct acpi_namespace_node **object_ptr,
 			/* No named references are allowed here */
 
 			ACPI_ERROR((AE_INFO,
-				    "Unsupported Reference type %X",
+				    "Unsupported Reference type 0x%X",
 				    source_desc->reference.class));
 
 			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
@@ -264,7 +264,7 @@ acpi_ex_resolve_node_to_value(struct acpi_namespace_node **object_ptr,
 		/* Default case is for unknown types */
 
 		ACPI_ERROR((AE_INFO,
-			    "Node %p - Unknown object type %X",
+			    "Node %p - Unknown object type 0x%X",
 			    node, entry_type));
 
 		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index fdd6a70..7ca35ea 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -231,7 +231,7 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 				/* Invalid reference object */
 
 				ACPI_ERROR((AE_INFO,
-					    "Unknown TargetType %X in Index/Reference object %p",
+					    "Unknown TargetType 0x%X in Index/Reference object %p",
 					    stack_desc->reference.target_type,
 					    stack_desc));
 				status = AE_AML_INTERNAL;
@@ -273,8 +273,8 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 		default:
 
 			ACPI_ERROR((AE_INFO,
-				    "Unknown Reference type %X in %p", ref_type,
-				    stack_desc));
+				    "Unknown Reference type 0x%X in %p",
+				    ref_type, stack_desc));
 			status = AE_AML_INTERNAL;
 			break;
 		}
@@ -403,7 +403,8 @@ acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 
 			if (ACPI_GET_DESCRIPTOR_TYPE(node) !=
 			    ACPI_DESC_TYPE_NAMED) {
-				ACPI_ERROR((AE_INFO, "Not a NS node %p [%s]",
+				ACPI_ERROR((AE_INFO,
+					    "Not a namespace node %p [%s]",
 					    node,
 					    acpi_ut_get_descriptor_name(node)));
 				return_ACPI_STATUS(AE_AML_INTERNAL);
@@ -507,7 +508,7 @@ acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 		default:
 
 			ACPI_ERROR((AE_INFO,
-				    "Unknown Reference Class %2.2X",
+				    "Unknown Reference Class 0x%2.2X",
 				    obj_desc->reference.class));
 			return_ACPI_STATUS(AE_AML_INTERNAL);
 		}
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index c5ecd61..8c97cfd 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -153,7 +153,7 @@ acpi_ex_resolve_operands(u16 opcode,
 
 	arg_types = op_info->runtime_args;
 	if (arg_types == ARGI_INVALID_OPCODE) {
-		ACPI_ERROR((AE_INFO, "Unknown AML opcode %X", opcode));
+		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X", opcode));
 
 		return_ACPI_STATUS(AE_AML_INTERNAL);
 	}
@@ -218,7 +218,7 @@ acpi_ex_resolve_operands(u16 opcode,
 
 			if (!acpi_ut_valid_object_type(object_type)) {
 				ACPI_ERROR((AE_INFO,
-					    "Bad operand object type [%X]",
+					    "Bad operand object type [0x%X]",
 					    object_type));
 
 				return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
@@ -253,7 +253,7 @@ acpi_ex_resolve_operands(u16 opcode,
 				default:
 
 					ACPI_ERROR((AE_INFO,
-						    "Unknown Reference Class %2.2X in %p",
+						    "Unknown Reference Class 0x%2.2X in %p",
 						    obj_desc->reference.class,
 						    obj_desc));
 
@@ -665,7 +665,7 @@ acpi_ex_resolve_operands(u16 opcode,
 			/* Unknown type */
 
 			ACPI_ERROR((AE_INFO,
-				    "Internal - Unknown ARGI (required operand) type %X",
+				    "Internal - Unknown ARGI (required operand) type 0x%X",
 				    this_arg_type));
 
 			return_ACPI_STATUS(AE_BAD_PARAMETER);
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index f65d7e4..1624436 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -193,7 +193,7 @@ acpi_ex_store(union acpi_operand_object *source_desc,
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Unknown Reference Class %2.2X",
+		ACPI_ERROR((AE_INFO, "Unknown Reference Class 0x%2.2X",
 			    ref_desc->reference.class));
 		ACPI_DUMP_ENTRY(ref_desc, ACPI_LV_INFO);
 
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index e11b6cb..c9513d5 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -170,7 +170,7 @@ acpi_status acpi_ex_system_do_stall(u32 how_long)
 		 * (ACPI specifies 100 usec as max, but this gives some slack in
 		 * order to support existing BIOSs)
 		 */
-		ACPI_ERROR((AE_INFO, "Time parameter is too large (%d)",
+		ACPI_ERROR((AE_INFO, "Time parameter is too large (%u)",
 			    how_long));
 		status = AE_AML_OPERAND_VALUE;
 	} else {
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index ec7fc22..5d1273b 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -299,7 +299,7 @@ struct acpi_bit_register_info *acpi_hw_get_bit_register_info(u32 register_id)
 	ACPI_FUNCTION_ENTRY();
 
 	if (register_id > ACPI_BITREG_MAX) {
-		ACPI_ERROR((AE_INFO, "Invalid BitRegister ID: %X",
+		ACPI_ERROR((AE_INFO, "Invalid BitRegister ID: 0x%X",
 			    register_id));
 		return (NULL);
 	}
@@ -413,7 +413,7 @@ acpi_hw_register_read(u32 register_id, u32 * return_value)
 		break;
 
 	default:
-		ACPI_ERROR((AE_INFO, "Unknown Register ID: %X", register_id));
+		ACPI_ERROR((AE_INFO, "Unknown Register ID: 0x%X", register_id));
 		status = AE_BAD_PARAMETER;
 		break;
 	}
@@ -549,7 +549,7 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 		break;
 
 	default:
-		ACPI_ERROR((AE_INFO, "Unknown Register ID: %X", register_id));
+		ACPI_ERROR((AE_INFO, "Unknown Register ID: 0x%X", register_id));
 		status = AE_BAD_PARAMETER;
 		break;
 	}
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 5e6d4db..36eb803 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -245,7 +245,7 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 
 	if ((acpi_gbl_sleep_type_a > ACPI_SLEEP_TYPE_MAX) ||
 	    (acpi_gbl_sleep_type_b > ACPI_SLEEP_TYPE_MAX)) {
-		ACPI_ERROR((AE_INFO, "Sleep values out of range: A=%X B=%X",
+		ACPI_ERROR((AE_INFO, "Sleep values out of range: A=0x%X B=0x%X",
 			    acpi_gbl_sleep_type_a, acpi_gbl_sleep_type_b));
 		return_ACPI_STATUS(AE_AML_OPERAND_VALUE);
 	}
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index e26c17d..c10d587 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -150,7 +150,7 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 
 	if (last_address > ACPI_UINT16_MAX) {
 		ACPI_ERROR((AE_INFO,
-			    "Illegal I/O port address/length above 64K: 0x%p/%X",
+			    "Illegal I/O port address/length above 64K: %p/0x%X",
 			    ACPI_CAST_PTR(void, address), byte_width));
 		return_ACPI_STATUS(AE_LIMIT);
 	}
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index aa2b801..3a28146 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -222,7 +222,7 @@ acpi_status acpi_ns_root_initialize(void)
 			default:
 
 				ACPI_ERROR((AE_INFO,
-					    "Unsupported initial type value %X",
+					    "Unsupported initial type value 0x%X",
 					    init_val->type));
 				acpi_ut_remove_reference(obj_desc);
 				obj_desc = NULL;
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 0689d36..2110cc2 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -205,8 +205,8 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 		/* Check the node type and name */
 
 		if (type > ACPI_TYPE_LOCAL_MAX) {
-			ACPI_WARNING((AE_INFO, "Invalid ACPI Object Type %08X",
-				      type));
+			ACPI_WARNING((AE_INFO,
+				      "Invalid ACPI Object Type 0x%08X", type));
 		}
 
 		if (!acpi_ut_valid_acpi_name(this_node->name.integer)) {
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index 9593724..7dea003 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -107,7 +107,7 @@ acpi_ns_build_external_path(struct acpi_namespace_node *node,
 
 	if (index != 0) {
 		ACPI_ERROR((AE_INFO,
-			    "Could not construct external pathname; index=%X, size=%X, Path=%s",
+			    "Could not construct external pathname; index=%u, size=%u, Path=%s",
 			    (u32) index, (u32) size, &name_buffer[size]));
 
 		return (AE_BAD_PARAMETER);
diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index 08f8b3f..a8e42b5 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -311,7 +311,7 @@ acpi_ns_search_and_enter(u32 target_name,
 
 	if (!node || !target_name || !return_node) {
 		ACPI_ERROR((AE_INFO,
-			    "Null parameter: Node %p Name %X ReturnNode %p",
+			    "Null parameter: Node %p Name 0x%X ReturnNode %p",
 			    node, target_name, return_node));
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 24d05a8..bab5597 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -276,7 +276,7 @@ u32 acpi_ns_local(acpi_object_type type)
 
 		/* Type code out of range  */
 
-		ACPI_WARNING((AE_INFO, "Invalid Object Type %X", type));
+		ACPI_WARNING((AE_INFO, "Invalid Object Type 0x%X", type));
 		return_UINT32(ACPI_NS_NORMAL);
 	}
 
@@ -764,7 +764,7 @@ u32 acpi_ns_opens_scope(acpi_object_type type)
 
 		/* type code out of range  */
 
-		ACPI_WARNING((AE_INFO, "Invalid Object Type %X", type));
+		ACPI_WARNING((AE_INFO, "Invalid Object Type 0x%X", type));
 		return_UINT32(ACPI_NS_NORMAL);
 	}
 
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 00493e1..7df1a4c 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -460,7 +460,7 @@ acpi_ps_get_next_simple_arg(struct acpi_parse_state *parser_state,
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Invalid ArgType %X", arg_type));
+		ACPI_ERROR((AE_INFO, "Invalid ArgType 0x%X", arg_type));
 		return_VOID;
 	}
 
@@ -742,7 +742,7 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Invalid ArgType: %X", arg_type));
+		ACPI_ERROR((AE_INFO, "Invalid ArgType: 0x%X", arg_type));
 		status = AE_AML_OPERAND_TYPE;
 		break;
 	}
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 59aabae..2f2e776 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -136,7 +136,7 @@ static acpi_status acpi_ps_get_aml_opcode(struct acpi_walk_state *walk_state)
 		/* The opcode is unrecognized. Just skip unknown opcodes */
 
 		ACPI_ERROR((AE_INFO,
-			    "Found unknown opcode %X at AML address %p offset %X, ignoring",
+			    "Found unknown opcode 0x%X at AML address %p offset 0x%X, ignoring",
 			    walk_state->opcode, walk_state->parser_state.aml,
 			    walk_state->aml_offset));
 
@@ -1021,7 +1021,6 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 					if (status == AE_AML_NO_RETURN_VALUE) {
 						ACPI_EXCEPTION((AE_INFO, status,
 								"Invoked method did not return a value"));
-
 					}
 
 					ACPI_EXCEPTION((AE_INFO, status,
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index f2ee3b5..c80a2ee 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -212,7 +212,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 
 		if ((*top_object_list)->common.type != ACPI_TYPE_PACKAGE) {
 			ACPI_ERROR((AE_INFO,
-				    "(PRT[%X]) Need sub-package, found %s",
+				    "(PRT[%u]) Need sub-package, found %s",
 				    index,
 				    acpi_ut_get_object_type_name
 				    (*top_object_list)));
@@ -223,7 +223,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 
 		if ((*top_object_list)->package.count != 4) {
 			ACPI_ERROR((AE_INFO,
-				    "(PRT[%X]) Need package of length 4, found length %d",
+				    "(PRT[%u]) Need package of length 4, found length %u",
 				    index, (*top_object_list)->package.count));
 			return_ACPI_STATUS(AE_AML_PACKAGE_LIMIT);
 		}
@@ -240,7 +240,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		obj_desc = sub_object_list[0];
 		if (obj_desc->common.type != ACPI_TYPE_INTEGER) {
 			ACPI_ERROR((AE_INFO,
-				    "(PRT[%X].Address) Need Integer, found %s",
+				    "(PRT[%u].Address) Need Integer, found %s",
 				    index,
 				    acpi_ut_get_object_type_name(obj_desc)));
 			return_ACPI_STATUS(AE_BAD_DATA);
@@ -253,7 +253,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		obj_desc = sub_object_list[1];
 		if (obj_desc->common.type != ACPI_TYPE_INTEGER) {
 			ACPI_ERROR((AE_INFO,
-				    "(PRT[%X].Pin) Need Integer, found %s",
+				    "(PRT[%u].Pin) Need Integer, found %s",
 				    index,
 				    acpi_ut_get_object_type_name(obj_desc)));
 			return_ACPI_STATUS(AE_BAD_DATA);
@@ -289,7 +289,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 				if (obj_desc->reference.class !=
 				    ACPI_REFCLASS_NAME) {
 					ACPI_ERROR((AE_INFO,
-						    "(PRT[%X].Source) Need name, found Reference Class %X",
+						    "(PRT[%u].Source) Need name, found Reference Class 0x%X",
 						    index,
 						    obj_desc->reference.class));
 					return_ACPI_STATUS(AE_BAD_DATA);
@@ -340,7 +340,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 			default:
 
 				ACPI_ERROR((AE_INFO,
-					    "(PRT[%X].Source) Need Ref/String/Integer, found %s",
+					    "(PRT[%u].Source) Need Ref/String/Integer, found %s",
 					    index,
 					    acpi_ut_get_object_type_name
 					    (obj_desc)));
@@ -358,7 +358,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		obj_desc = sub_object_list[3];
 		if (obj_desc->common.type != ACPI_TYPE_INTEGER) {
 			ACPI_ERROR((AE_INFO,
-				    "(PRT[%X].SourceIndex) Need Integer, found %s",
+				    "(PRT[%u].SourceIndex) Need Integer, found %s",
 				    index,
 				    acpi_ut_get_object_type_name(obj_desc)));
 			return_ACPI_STATUS(AE_BAD_DATA);
diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index fd057c7..7335f22 100644
--- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -94,7 +94,7 @@ acpi_rs_convert_aml_to_resources(u8 * aml,
 					    [resource_index]);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status,
-				"Could not convert AML resource (Type %X)",
+				"Could not convert AML resource (Type 0x%X)",
 				*aml));
 		return_ACPI_STATUS(status);
 	}
@@ -147,7 +147,7 @@ acpi_rs_convert_resources_to_aml(struct acpi_resource *resource,
 
 		if (resource->type > ACPI_RESOURCE_TYPE_MAX) {
 			ACPI_ERROR((AE_INFO,
-				    "Invalid descriptor type (%X) in resource list",
+				    "Invalid descriptor type (0x%X) in resource list",
 				    resource->type));
 			return_ACPI_STATUS(AE_BAD_DATA);
 		}
@@ -161,7 +161,7 @@ acpi_rs_convert_resources_to_aml(struct acpi_resource *resource,
 							 [resource->type]);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
-					"Could not convert resource (type %X) to AML",
+					"Could not convert resource (type 0x%X) to AML",
 					resource->type));
 			return_ACPI_STATUS(status);
 		}
diff --git a/drivers/acpi/acpica/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
index 07de352..f8cd9e8 100644
--- a/drivers/acpi/acpica/rsmisc.c
+++ b/drivers/acpi/acpica/rsmisc.c
@@ -88,7 +88,7 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 		/* Each internal resource struct is expected to be 32-bit aligned */
 
 		ACPI_WARNING((AE_INFO,
-			      "Misaligned resource pointer (get): %p Type %2.2X Len %X",
+			      "Misaligned resource pointer (get): %p Type 0x%2.2X Length %u",
 			      resource, resource->type, resource->length));
 	}
 
@@ -541,7 +541,7 @@ if (((aml->irq.flags & 0x09) == 0x00) || ((aml->irq.flags & 0x09) == 0x09)) {
 	 * "IRQ Format"), so 0x00 and 0x09 are illegal.
 	 */
 	ACPI_ERROR((AE_INFO,
-		    "Invalid interrupt polarity/trigger in resource list, %X",
+		    "Invalid interrupt polarity/trigger in resource list, 0x%X",
 		    aml->irq.flags));
 	return_ACPI_STATUS(AE_BAD_DATA);
 }
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index f43fbe0..1728cb9 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -283,7 +283,7 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
 	if (length > sizeof(struct acpi_table_fadt)) {
 		ACPI_WARNING((AE_INFO,
 			      "FADT (revision %u) is longer than ACPI 2.0 version, "
-			      "truncating length 0x%X to 0x%X",
+			      "truncating length %u to %u",
 			      table->revision, length,
 			      (u32)sizeof(struct acpi_table_fadt)));
 	}
@@ -422,7 +422,7 @@ static void acpi_tb_convert_fadt(void)
 		if (address64->address && address32 &&
 		    (address64->address != (u64) address32)) {
 			ACPI_ERROR((AE_INFO,
-				    "32/64X address mismatch in %s: %8.8X/%8.8X%8.8X, using 32",
+				    "32/64X address mismatch in %s: 0x%8.8X/0x%8.8X%8.8X, using 32",
 				    fadt_info_table[i].name, address32,
 				    ACPI_FORMAT_UINT64(address64->address)));
 		}
@@ -481,7 +481,7 @@ static void acpi_tb_validate_fadt(void)
 	    (acpi_gbl_FADT.Xfacs != (u64) acpi_gbl_FADT.facs)) {
 		ACPI_WARNING((AE_INFO,
 			      "32/64X FACS address mismatch in FADT - "
-			      "%8.8X/%8.8X%8.8X, using 32",
+			      "0x%8.8X/0x%8.8X%8.8X, using 32",
 			      acpi_gbl_FADT.facs,
 			      ACPI_FORMAT_UINT64(acpi_gbl_FADT.Xfacs)));
 
@@ -492,7 +492,7 @@ static void acpi_tb_validate_fadt(void)
 	    (acpi_gbl_FADT.Xdsdt != (u64) acpi_gbl_FADT.dsdt)) {
 		ACPI_WARNING((AE_INFO,
 			      "32/64X DSDT address mismatch in FADT - "
-			      "%8.8X/%8.8X%8.8X, using 32",
+			      "0x%8.8X/0x%8.8X%8.8X, using 32",
 			      acpi_gbl_FADT.dsdt,
 			      ACPI_FORMAT_UINT64(acpi_gbl_FADT.Xdsdt)));
 
@@ -521,7 +521,7 @@ static void acpi_tb_validate_fadt(void)
 		if (address64->address &&
 		    (address64->bit_width != ACPI_MUL_8(length))) {
 			ACPI_WARNING((AE_INFO,
-				      "32/64X length mismatch in %s: %d/%d",
+				      "32/64X length mismatch in %s: %u/%u",
 				      name, ACPI_MUL_8(length),
 				      address64->bit_width));
 		}
@@ -534,7 +534,7 @@ static void acpi_tb_validate_fadt(void)
 			if (!address64->address || !length) {
 				ACPI_ERROR((AE_INFO,
 					    "Required field %s has zero address and/or length:"
-					    " %8.8X%8.8X/%X",
+					    " 0x%8.8X%8.8X/0x%X",
 					    name,
 					    ACPI_FORMAT_UINT64(address64->
 							       address),
@@ -550,7 +550,7 @@ static void acpi_tb_validate_fadt(void)
 			    (!address64->address && length)) {
 				ACPI_WARNING((AE_INFO,
 					      "Optional field %s has zero address or length: "
-					      "%8.8X%8.8X/%X",
+					      "0x%8.8X%8.8X/0x%X",
 					      name,
 					      ACPI_FORMAT_UINT64(address64->
 								 address),
@@ -600,7 +600,7 @@ static void acpi_tb_setup_fadt_registers(void)
 			    (fadt_info_table[i].default_length !=
 			     target64->bit_width)) {
 				ACPI_WARNING((AE_INFO,
-					      "Invalid length for %s: %d, using default %d",
+					      "Invalid length for %s: %u, using default %u",
 					      fadt_info_table[i].name,
 					      target64->bit_width,
 					      fadt_info_table[i].
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 02723a9..f47a70e 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -309,7 +309,7 @@ acpi_status acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length)
 
 	if (checksum) {
 		ACPI_WARNING((AE_INFO,
-			      "Incorrect checksum in table [%4.4s] - %2.2X, should be %2.2X",
+			      "Incorrect checksum in table [%4.4s] - 0x%2.2X, should be 0x%2.2X",
 			      table->signature, table->checksum,
 			      (u8) (table->checksum - checksum)));
 
@@ -496,7 +496,7 @@ acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
 			/* Will truncate 64-bit address to 32 bits, issue warning */
 
 			ACPI_WARNING((AE_INFO,
-				      "64-bit Physical Address in XSDT is too large (%8.8X%8.8X),"
+				      "64-bit Physical Address in XSDT is too large (0x%8.8X%8.8X),"
 				      " truncating",
 				      ACPI_FORMAT_UINT64(address64)));
 		}
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index dda6e8c..fd2c07d 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -134,7 +134,7 @@ acpi_status acpi_find_root_pointer(acpi_size *table_address)
 				       ACPI_EBDA_PTR_LENGTH);
 	if (!table_ptr) {
 		ACPI_ERROR((AE_INFO,
-			    "Could not map memory at %8.8X for length %X",
+			    "Could not map memory at 0x%8.8X for length %u",
 			    ACPI_EBDA_PTR_LOCATION, ACPI_EBDA_PTR_LENGTH));
 
 		return_ACPI_STATUS(AE_NO_MEMORY);
@@ -159,7 +159,7 @@ acpi_status acpi_find_root_pointer(acpi_size *table_address)
 					       ACPI_EBDA_WINDOW_SIZE);
 		if (!table_ptr) {
 			ACPI_ERROR((AE_INFO,
-				    "Could not map memory at %8.8X for length %X",
+				    "Could not map memory at 0x%8.8X for length %u",
 				    physical_address, ACPI_EBDA_WINDOW_SIZE));
 
 			return_ACPI_STATUS(AE_NO_MEMORY);
@@ -191,7 +191,7 @@ acpi_status acpi_find_root_pointer(acpi_size *table_address)
 
 	if (!table_ptr) {
 		ACPI_ERROR((AE_INFO,
-			    "Could not map memory at %8.8X for length %X",
+			    "Could not map memory at 0x%8.8X for length %u",
 			    ACPI_HI_RSDP_WINDOW_BASE,
 			    ACPI_HI_RSDP_WINDOW_SIZE));
 
diff --git a/drivers/acpi/acpica/utalloc.c b/drivers/acpi/acpica/utalloc.c
index 3d706b8..8f08962 100644
--- a/drivers/acpi/acpica/utalloc.c
+++ b/drivers/acpi/acpica/utalloc.c
@@ -340,7 +340,7 @@ void *acpi_ut_allocate(acpi_size size,
 		/* Report allocation error */
 
 		ACPI_WARNING((module, line,
-			      "Could not allocate size %X", (u32) size));
+			      "Could not allocate size %u", (u32) size));
 
 		return_PTR(NULL);
 	}
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 16b51c6..ed794cd 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -434,7 +434,7 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 
 	default:
 
-		ACPI_ERROR((AE_INFO, "Unknown action (%X)", action));
+		ACPI_ERROR((AE_INFO, "Unknown action (0x%X)", action));
 		break;
 	}
 
@@ -444,8 +444,8 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 	 */
 	if (count > ACPI_MAX_REFERENCE_COUNT) {
 		ACPI_WARNING((AE_INFO,
-			      "Large Reference Count (%X) in object %p", count,
-			      object));
+			      "Large Reference Count (0x%X) in object %p",
+			      count, object));
 	}
 }
 
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 7f5e734..6dfdeb6 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -307,7 +307,7 @@ acpi_ut_evaluate_object(struct acpi_namespace_node *prefix_node,
 				  prefix_node, path, AE_TYPE);
 
 		ACPI_ERROR((AE_INFO,
-			    "Type returned from %s was incorrect: %s, expected Btypes: %X",
+			    "Type returned from %s was incorrect: %s, expected Btypes: 0x%X",
 			    path,
 			    acpi_ut_get_object_type_name(info->return_object),
 			    expected_return_btypes));
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 32982e2..e8d0724 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -205,7 +205,7 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id * owner_id)
 	/* Guard against multiple allocations of ID to the same location */
 
 	if (*owner_id) {
-		ACPI_ERROR((AE_INFO, "Owner ID [%2.2X] already exists",
+		ACPI_ERROR((AE_INFO, "Owner ID [0x%2.2X] already exists",
 			    *owner_id));
 		return_ACPI_STATUS(AE_ALREADY_EXISTS);
 	}
@@ -315,7 +315,7 @@ void acpi_ut_release_owner_id(acpi_owner_id * owner_id_ptr)
 	/* Zero is not a valid owner_iD */
 
 	if (owner_id == 0) {
-		ACPI_ERROR((AE_INFO, "Invalid OwnerId: %2.2X", owner_id));
+		ACPI_ERROR((AE_INFO, "Invalid OwnerId: 0x%2.2X", owner_id));
 		return_VOID;
 	}
 
@@ -341,7 +341,7 @@ void acpi_ut_release_owner_id(acpi_owner_id * owner_id_ptr)
 		acpi_gbl_owner_id_mask[index] ^= bit;
 	} else {
 		ACPI_ERROR((AE_INFO,
-			    "Release of non-allocated OwnerId: %2.2X",
+			    "Release of non-allocated OwnerId: 0x%2.2X",
 			    owner_id + 1));
 	}
 
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 55d014e..058b3df 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -258,7 +258,7 @@ acpi_status acpi_ut_acquire_mutex(acpi_mutex_handle mutex_id)
 		acpi_gbl_mutex_info[mutex_id].thread_id = this_thread_id;
 	} else {
 		ACPI_EXCEPTION((AE_INFO, status,
-				"Thread %p could not acquire Mutex [%X]",
+				"Thread %p could not acquire Mutex [0x%X]",
 				ACPI_CAST_PTR(void, this_thread_id), mutex_id));
 	}
 
@@ -297,7 +297,7 @@ acpi_status acpi_ut_release_mutex(acpi_mutex_handle mutex_id)
 	 */
 	if (acpi_gbl_mutex_info[mutex_id].thread_id == ACPI_MUTEX_NOT_ACQUIRED) {
 		ACPI_ERROR((AE_INFO,
-			    "Mutex [%X] is not acquired, cannot release",
+			    "Mutex [0x%X] is not acquired, cannot release",
 			    mutex_id));
 
 		return (AE_NOT_ACQUIRED);
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 3356f0c..fd1fa27 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -251,7 +251,7 @@ union acpi_operand_object *acpi_ut_create_buffer_object(acpi_size buffer_size)
 
 		buffer = ACPI_ALLOCATE_ZEROED(buffer_size);
 		if (!buffer) {
-			ACPI_ERROR((AE_INFO, "Could not allocate size %X",
+			ACPI_ERROR((AE_INFO, "Could not allocate size %u",
 				    (u32) buffer_size));
 			acpi_ut_remove_reference(buffer_desc);
 			return_PTR(NULL);
@@ -303,7 +303,7 @@ union acpi_operand_object *acpi_ut_create_string_object(acpi_size string_size)
 	 */
 	string = ACPI_ALLOCATE_ZEROED(string_size + 1);
 	if (!string) {
-		ACPI_ERROR((AE_INFO, "Could not allocate size %X",
+		ACPI_ERROR((AE_INFO, "Could not allocate size %u",
 			    (u32) string_size));
 		acpi_ut_remove_reference(string_desc);
 		return_PTR(NULL);
@@ -533,7 +533,7 @@ acpi_ut_get_simple_object_size(union acpi_operand_object *internal_object,
 			 */
 			ACPI_ERROR((AE_INFO,
 				    "Cannot convert to external object - "
-				    "unsupported Reference Class [%s] %X in object %p",
+				    "unsupported Reference Class [%s] 0x%X in object %p",
 				    acpi_ut_get_reference_name(internal_object),
 				    internal_object->reference.class,
 				    internal_object));
@@ -545,7 +545,7 @@ acpi_ut_get_simple_object_size(union acpi_operand_object *internal_object,
 	default:
 
 		ACPI_ERROR((AE_INFO, "Cannot convert to external object - "
-			    "unsupported type [%s] %X in object %p",
+			    "unsupported type [%s] 0x%X in object %p",
 			    acpi_ut_get_object_type_name(internal_object),
 			    internal_object->common.type, internal_object));
 		status = AE_TYPE;
-- 
1.6.0.6

