From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/14] ACPICA: Deploy new create integer interface where
 appropriate
Date: Wed, 09 Dec 2009 12:22:13 -0500
Message-ID: <dc95a270c684e771b25dce0b60559cc80c033f22.1260379153.git.len.brown@intel.com>
References: <1260379335-24263-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:57852 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756349AbZLIR6R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 12:58:17 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUE007Q3CKWILQ0@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 09 Dec 2009 11:58:21 -0600 (CST)
In-reply-to: <1260379335-24263-1-git-send-email-lenb@kernel.org>
In-reply-to: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
References: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Simplifies creation of simple integer objects.
ACPICA BZ 823.

http://www.acpica.org/bugzilla/show_bug.cgi?id=823

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/dsmthdat.c |    4 +---
 drivers/acpi/acpica/evregion.c |   11 ++++-------
 drivers/acpi/acpica/exconfig.c |    4 +---
 drivers/acpi/acpica/exconvrt.c |    3 +--
 drivers/acpi/acpica/exfield.c  |    3 +--
 drivers/acpi/acpica/exoparg1.c |   38 +++++++++++++++++---------------------
 drivers/acpi/acpica/exoparg6.c |    7 ++-----
 drivers/acpi/acpica/psparse.c  |    8 ++------
 drivers/acpi/acpica/psxface.c  |    4 +---
 9 files changed, 30 insertions(+), 52 deletions(-)

diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index 7d077bb..0ba19f8 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -409,13 +409,11 @@ acpi_ds_method_data_get_value(u8 type,
 		/* If slack enabled, init the local_x/arg_x to an Integer of value zero */
 
 		if (acpi_gbl_enable_interpreter_slack) {
-			object =
-			    acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+			object = acpi_ut_create_integer_object((u64) 0);
 			if (!object) {
 				return_ACPI_STATUS(AE_NO_MEMORY);
 			}
 
-			object->integer.value = 0;
 			node->object = object;
 		}
 
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 582b0af..0bc807c 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -289,23 +289,20 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
 	 *  connection status 1 for connecting the handler, 0 for disconnecting
 	 *  the handler (Passed as a parameter)
 	 */
-	args[0] = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+	args[0] =
+	    acpi_ut_create_integer_object((u64) region_obj->region.space_id);
 	if (!args[0]) {
 		status = AE_NO_MEMORY;
 		goto cleanup1;
 	}
 
-	args[1] = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+	args[1] = acpi_ut_create_integer_object((u64) function);
 	if (!args[1]) {
 		status = AE_NO_MEMORY;
 		goto cleanup2;
 	}
 
-	/* Setup the parameter objects */
-
-	args[0]->integer.value = region_obj->region.space_id;
-	args[1]->integer.value = function;
-	args[2] = NULL;
+	args[2] = NULL;		/* Terminate list */
 
 	/* Execute the method, no return value */
 
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 24afef8..46adfa5 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -170,14 +170,12 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 
 		/* Table not found, return an Integer=0 and AE_OK */
 
-		ddb_handle = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		ddb_handle = acpi_ut_create_integer_object((u64) 0);
 		if (!ddb_handle) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
-		ddb_handle->integer.value = 0;
 		*return_desc = ddb_handle;
-
 		return_ACPI_STATUS(AE_OK);
 	}
 
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index 37d0d39..51d5f22 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -167,7 +167,7 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
 
 	/* Create a new integer */
 
-	return_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+	return_desc = acpi_ut_create_integer_object(result);
 	if (!return_desc) {
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
@@ -177,7 +177,6 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
 
 	/* Save the Result */
 
-	return_desc->integer.value = result;
 	acpi_ex_truncate_for32bit_table(return_desc);
 	*result_desc = return_desc;
 	return_ACPI_STATUS(AE_OK);
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 0b33d6c..1588a2d 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -162,13 +162,12 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 	} else {
 		/* Field will fit within an Integer (normal case) */
 
-		buffer_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		buffer_desc = acpi_ut_create_integer_object((u64) 0);
 		if (!buffer_desc) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
 		length = acpi_gbl_integer_byte_width;
-		buffer_desc->integer.value = 0;
 		buffer = &buffer_desc->integer.value;
 	}
 
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index 9635d21..752fe48 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -100,12 +100,12 @@ acpi_status acpi_ex_opcode_0A_0T_1R(struct acpi_walk_state *walk_state)
 
 		/* Create a return object of type Integer */
 
-		return_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		return_desc =
+		    acpi_ut_create_integer_object(acpi_os_get_timer());
 		if (!return_desc) {
 			status = AE_NO_MEMORY;
 			goto cleanup;
 		}
-		return_desc->integer.value = acpi_os_get_timer();
 		break;
 
 	default:		/*  Unknown opcode  */
@@ -599,7 +599,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 	switch (walk_state->opcode) {
 	case AML_LNOT_OP:	/* LNot (Operand) */
 
-		return_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		return_desc = acpi_ut_create_integer_object((u64) 0);
 		if (!return_desc) {
 			status = AE_NO_MEMORY;
 			goto cleanup;
@@ -702,13 +702,11 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 
 		/* Allocate a descriptor to hold the type. */
 
-		return_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		return_desc = acpi_ut_create_integer_object((u64) type);
 		if (!return_desc) {
 			status = AE_NO_MEMORY;
 			goto cleanup;
 		}
-
-		return_desc->integer.value = type;
 		break;
 
 	case AML_SIZE_OF_OP:	/* size_of (source_object) */
@@ -777,13 +775,11 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 		 * Now that we have the size of the object, create a result
 		 * object to hold the value
 		 */
-		return_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		return_desc = acpi_ut_create_integer_object(value);
 		if (!return_desc) {
 			status = AE_NO_MEMORY;
 			goto cleanup;
 		}
-
-		return_desc->integer.value = value;
 		break;
 
 	case AML_REF_OF_OP:	/* ref_of (source_object) */
@@ -946,24 +942,24 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 					 * NOTE: index into a buffer is NOT a pointer to a
 					 * sub-buffer of the main buffer, it is only a pointer to a
 					 * single element (byte) of the buffer!
+					 *
+					 * Since we are returning the value of the buffer at the
+					 * indexed location, we don't need to add an additional
+					 * reference to the buffer itself.
 					 */
 					return_desc =
-					    acpi_ut_create_internal_object
-					    (ACPI_TYPE_INTEGER);
+					    acpi_ut_create_integer_object((u64)
+									  temp_desc->
+									  buffer.
+									  pointer
+									  [operand
+									   [0]->
+									   reference.
+									   value]);
 					if (!return_desc) {
 						status = AE_NO_MEMORY;
 						goto cleanup;
 					}
-
-					/*
-					 * Since we are returning the value of the buffer at the
-					 * indexed location, we don't need to add an additional
-					 * reference to the buffer itself.
-					 */
-					return_desc->integer.value =
-					    temp_desc->buffer.
-					    pointer[operand[0]->reference.
-						    value];
 					break;
 
 				case ACPI_TYPE_PACKAGE:
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index ae43f76..295542e 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -253,18 +253,15 @@ acpi_status acpi_ex_opcode_6A_0T_1R(struct acpi_walk_state * walk_state)
 		}
 
 		/* Create an integer for the return value */
+		/* Default return value is ACPI_INTEGER_MAX if no match found */
 
-		return_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		return_desc = acpi_ut_create_integer_object(ACPI_INTEGER_MAX);
 		if (!return_desc) {
 			status = AE_NO_MEMORY;
 			goto cleanup;
 
 		}
 
-		/* Default return value if no match found */
-
-		return_desc->integer.value = ACPI_INTEGER_MAX;
-
 		/*
 		 * Examine each element until a match is found. Both match conditions
 		 * must be satisfied for a match to occur. Within the loop,
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 70838e9..4df8f13 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -610,17 +610,13 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 					    implicit_return_obj) {
 						previous_walk_state->
 						    implicit_return_obj =
-						    acpi_ut_create_internal_object
-						    (ACPI_TYPE_INTEGER);
+						    acpi_ut_create_integer_object
+						    ((u64) 0);
 						if (!previous_walk_state->
 						    implicit_return_obj) {
 							return_ACPI_STATUS
 							    (AE_NO_MEMORY);
 						}
-
-						previous_walk_state->
-						    implicit_return_obj->
-						    integer.value = 0;
 					}
 
 					/* Restart the calling control method */
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index dd9731c..12934ad 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -306,14 +306,12 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 	 */
 	if (acpi_gbl_enable_interpreter_slack) {
 		walk_state->implicit_return_obj =
-		    acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		    acpi_ut_create_integer_object((u64) 0);
 		if (!walk_state->implicit_return_obj) {
 			status = AE_NO_MEMORY;
 			acpi_ds_delete_walk_state(walk_state);
 			goto cleanup;
 		}
-
-		walk_state->implicit_return_obj->integer.value = 0;
 	}
 
 	/* Parse the AML */
-- 
1.6.0.6

