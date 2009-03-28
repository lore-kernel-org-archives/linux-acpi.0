From: Len Brown <lenb@kernel.org>
Subject: [PATCH 29/98] ACPICA: Remove ACPI_GET_OBJECT_TYPE macro
Date: Sat, 28 Mar 2009 00:31:04 -0400
Message-ID: <3371c19c294a4cb3649aa4e84606be8a1d999e61.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:8294 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374AbZC1EdN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:13 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700ECQ8MEIT8M@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:40 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Remove all instances of this obsolete macro, since it is now a
simple reference to ->common.type. There were about 150 invocations
of the macro across 41 files. ACPICA BZ 755.

http://www.acpica.org/bugzilla/show_bug.cgi?id=755

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acmacros.h |    4 ----
 drivers/acpi/acpica/dsmthdat.c |    2 +-
 drivers/acpi/acpica/dsobject.c |    6 +++---
 drivers/acpi/acpica/dsopcode.c |    8 +++-----
 drivers/acpi/acpica/dsutils.c  |    2 +-
 drivers/acpi/acpica/dswexec.c  |    5 ++---
 drivers/acpi/acpica/evgpeblk.c |    8 ++++----
 drivers/acpi/acpica/evregion.c |    2 +-
 drivers/acpi/acpica/exconfig.c |    4 ++--
 drivers/acpi/acpica/exconvrt.c |   11 +++++------
 drivers/acpi/acpica/exdump.c   |   19 ++++++++-----------
 drivers/acpi/acpica/exfield.c  |   29 +++++++++++++----------------
 drivers/acpi/acpica/exfldio.c  |    8 ++++----
 drivers/acpi/acpica/exmisc.c   |   14 +++++++-------
 drivers/acpi/acpica/exoparg1.c |   13 +++++--------
 drivers/acpi/acpica/exoparg2.c |    2 +-
 drivers/acpi/acpica/exoparg3.c |    7 +++----
 drivers/acpi/acpica/exprep.c   |    2 +-
 drivers/acpi/acpica/exresnte.c |    8 ++++----
 drivers/acpi/acpica/exresolv.c |    9 ++++-----
 drivers/acpi/acpica/exresop.c  |   23 +++++++++++------------
 drivers/acpi/acpica/exstore.c  |   18 ++++++++----------
 drivers/acpi/acpica/exstoren.c |   29 ++++++++++++-----------------
 drivers/acpi/acpica/exutils.c  |    2 +-
 drivers/acpi/acpica/hwxface.c  |    6 +++---
 drivers/acpi/acpica/nsaccess.c |    3 +--
 drivers/acpi/acpica/nsdump.c   |    2 +-
 drivers/acpi/acpica/nsobject.c |   18 ++++++++----------
 drivers/acpi/acpica/nspredef.c |    8 ++++----
 drivers/acpi/acpica/nsxfeval.c |    3 +--
 drivers/acpi/acpica/rscalc.c   |    7 +++----
 drivers/acpi/acpica/rscreate.c |   15 +++++++--------
 drivers/acpi/acpica/utcopy.c   |   25 ++++++++++++-------------
 drivers/acpi/acpica/utdelete.c |    6 +++---
 drivers/acpi/acpica/uteval.c   |   12 ++++++------
 drivers/acpi/acpica/utglobal.c |    2 +-
 drivers/acpi/acpica/utmisc.c   |    3 +--
 drivers/acpi/acpica/utobject.c |    7 +++----
 38 files changed, 158 insertions(+), 194 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 9c127e8..91ac7d7 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -292,10 +292,6 @@
 #define ACPI_GET_DESCRIPTOR_TYPE(d)     (((union acpi_descriptor *)(void *)(d))->common.descriptor_type)
 #define ACPI_SET_DESCRIPTOR_TYPE(d, t)  (((union acpi_descriptor *)(void *)(d))->common.descriptor_type = t)
 
-/* Macro to test the object type */
-
-#define ACPI_GET_OBJECT_TYPE(d)         (((union acpi_operand_object *)(void *)(d))->common.type)
-
 /*
  * Macros for the master AML opcode table
  */
diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index da0f546..22b1a3c 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -713,6 +713,6 @@ acpi_ds_method_data_get_type(u16 opcode,
 
 	/* Get the object type */
 
-	return_VALUE(ACPI_GET_OBJECT_TYPE(object));
+	return_VALUE(object->type);
 }
 #endif
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 15c628e..dab3f48 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -565,7 +565,7 @@ acpi_ds_create_node(struct acpi_walk_state *walk_state,
 
 	/* Re-type the object according to its argument */
 
-	node->type = ACPI_GET_OBJECT_TYPE(obj_desc);
+	node->type = obj_desc->common.type;
 
 	/* Attach obj to node */
 
@@ -619,7 +619,7 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 
 	/* Perform per-object initialization */
 
-	switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+	switch (obj_desc->common.type) {
 	case ACPI_TYPE_BUFFER:
 
 		/*
@@ -803,7 +803,7 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 	default:
 
 		ACPI_ERROR((AE_INFO, "Unimplemented data type: %X",
-			    ACPI_GET_OBJECT_TYPE(obj_desc)));
+			    obj_desc->common.type));
 
 		status = AE_AML_OPERAND_TYPE;
 		break;
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 0c3b4dd..602ddaa 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -484,7 +484,7 @@ acpi_ds_init_buffer_field(u16 aml_opcode,
 
 	/* Host object must be a Buffer */
 
-	if (ACPI_GET_OBJECT_TYPE(buffer_desc) != ACPI_TYPE_BUFFER) {
+	if (buffer_desc->common.type != ACPI_TYPE_BUFFER) {
 		ACPI_ERROR((AE_INFO,
 			    "Target of Create Field is not a Buffer object - %s",
 			    acpi_ut_get_object_type_name(buffer_desc)));
@@ -1365,10 +1365,8 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
 			if ((ACPI_GET_DESCRIPTOR_TYPE
 			     (walk_state->results->results.obj_desc[0]) ==
 			     ACPI_DESC_TYPE_OPERAND)
-			    &&
-			    (ACPI_GET_OBJECT_TYPE
-			     (walk_state->results->results.obj_desc[0]) ==
-			     ACPI_TYPE_LOCAL_REFERENCE)
+			    && ((walk_state->results->results.obj_desc[0])->
+				common.type == ACPI_TYPE_LOCAL_REFERENCE)
 			    && ((walk_state->results->results.obj_desc[0])->
 				reference.class != ACPI_REFCLASS_INDEX)) {
 				status =
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index dabc23a..dfa1041 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -816,7 +816,7 @@ acpi_status acpi_ds_evaluate_name_path(struct acpi_walk_state *walk_state)
 		goto push_result;
 	}
 
-	type = ACPI_GET_OBJECT_TYPE(*operand);
+	type = (*operand)->common.type;
 
 	status = acpi_ex_resolve_to_value(operand, walk_state);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 350e665..f028085 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -138,11 +138,10 @@ acpi_ds_get_predicate_value(struct acpi_walk_state *walk_state,
 		goto cleanup;
 	}
 
-	if (ACPI_GET_OBJECT_TYPE(local_obj_desc) != ACPI_TYPE_INTEGER) {
+	if (local_obj_desc->common.type != ACPI_TYPE_INTEGER) {
 		ACPI_ERROR((AE_INFO,
 			    "Bad predicate (not an integer) ObjDesc=%p State=%p Type=%X",
-			    obj_desc, walk_state,
-			    ACPI_GET_OBJECT_TYPE(obj_desc)));
+			    obj_desc, walk_state, obj_desc->common.type));
 
 		status = AE_AML_OPERAND_TYPE;
 		goto cleanup;
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 484cc05..f7b3d2a 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -408,7 +408,7 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
 	 */
 	obj_desc = pkg_desc->package.elements[0];
 
-	if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_INTEGER) {
+	if (obj_desc->common.type == ACPI_TYPE_INTEGER) {
 
 		/* Use FADT-defined GPE device (from definition of _PRW) */
 
@@ -417,14 +417,14 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
 		/* Integer is the GPE number in the FADT described GPE blocks */
 
 		gpe_number = (u32) obj_desc->integer.value;
-	} else if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_PACKAGE) {
+	} else if (obj_desc->common.type == ACPI_TYPE_PACKAGE) {
 
 		/* Package contains a GPE reference and GPE number within a GPE block */
 
 		if ((obj_desc->package.count < 2) ||
-		    (ACPI_GET_OBJECT_TYPE(obj_desc->package.elements[0]) !=
+		    ((obj_desc->package.elements[0])->common.type !=
 		     ACPI_TYPE_LOCAL_REFERENCE)
-		    || (ACPI_GET_OBJECT_TYPE(obj_desc->package.elements[1]) !=
+		    || ((obj_desc->package.elements[1])->common.type !=
 			ACPI_TYPE_INTEGER)) {
 			goto cleanup;
 		}
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 665c088..86cbbdb 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -691,7 +691,7 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 
 	/* Devices are handled different than regions */
 
-	if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_DEVICE) {
+	if (obj_desc->common.type == ACPI_TYPE_DEVICE) {
 
 		/* Check if this Device already has a handler for this address space */
 
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 932bbc2..70b39c7 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -291,7 +291,7 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 
 	/* Source Object can be either an op_region or a Buffer/Field */
 
-	switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+	switch (obj_desc->common.type) {
 	case ACPI_TYPE_REGION:
 
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
@@ -501,7 +501,7 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 	 */
 	if ((!ddb_handle) ||
 	    (ACPI_GET_DESCRIPTOR_TYPE(ddb_handle) != ACPI_DESC_TYPE_OPERAND) ||
-	    (ACPI_GET_OBJECT_TYPE(ddb_handle) != ACPI_TYPE_LOCAL_REFERENCE)) {
+	    (ddb_handle->common.type != ACPI_TYPE_LOCAL_REFERENCE)) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index 0be1018..37d0d39 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -82,7 +82,7 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
 
 	ACPI_FUNCTION_TRACE_PTR(ex_convert_to_integer, obj_desc);
 
-	switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+	switch (obj_desc->common.type) {
 	case ACPI_TYPE_INTEGER:
 
 		/* No conversion necessary */
@@ -116,7 +116,7 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
 
 	/* String conversion is different than Buffer conversion */
 
-	switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+	switch (obj_desc->common.type) {
 	case ACPI_TYPE_STRING:
 
 		/*
@@ -206,7 +206,7 @@ acpi_ex_convert_to_buffer(union acpi_operand_object *obj_desc,
 
 	ACPI_FUNCTION_TRACE_PTR(ex_convert_to_buffer, obj_desc);
 
-	switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+	switch (obj_desc->common.type) {
 	case ACPI_TYPE_BUFFER:
 
 		/* No conversion necessary */
@@ -409,7 +409,7 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 
 	ACPI_FUNCTION_TRACE_PTR(ex_convert_to_string, obj_desc);
 
-	switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+	switch (obj_desc->common.type) {
 	case ACPI_TYPE_STRING:
 
 		/* No conversion necessary */
@@ -605,8 +605,7 @@ acpi_ex_convert_to_target_type(acpi_object_type destination_type,
 		default:
 			/* No conversion allowed for these types */
 
-			if (destination_type !=
-			    ACPI_GET_OBJECT_TYPE(source_desc)) {
+			if (destination_type != source_desc->common.type) {
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 						  "Explicit operator, will store (%s) over existing type (%s)\n",
 						  acpi_ut_get_object_type_name
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index aa31357..193d233 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -492,7 +492,7 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 
 	/* Decode object type */
 
-	switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+	switch (obj_desc->common.type) {
 	case ACPI_TYPE_LOCAL_REFERENCE:
 
 		acpi_os_printf("Reference: [%s] ",
@@ -531,7 +531,7 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 
 			acpi_os_printf("%X", obj_desc->reference.value);
 
-			if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_INTEGER) {
+			if (obj_desc->common.type == ACPI_TYPE_INTEGER) {
 
 				/* Value is an Integer */
 
@@ -548,7 +548,7 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 
 			acpi_os_printf("%X", obj_desc->reference.value);
 
-			if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_INTEGER) {
+			if (obj_desc->common.type == ACPI_TYPE_INTEGER) {
 
 				/* Value is an Integer */
 
@@ -686,9 +686,8 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 
 		if (!obj_desc->buffer_field.buffer_obj) {
 			ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "*NULL*\n"));
-		} else
-		    if (ACPI_GET_OBJECT_TYPE(obj_desc->buffer_field.buffer_obj)
-			!= ACPI_TYPE_BUFFER) {
+		} else if ((obj_desc->buffer_field.buffer_obj)->common.type !=
+			   ACPI_TYPE_BUFFER) {
 			acpi_os_printf("*not a Buffer*\n");
 		} else {
 			acpi_ex_dump_operand(obj_desc->buffer_field.buffer_obj,
@@ -737,8 +736,7 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 	default:
 		/* Unknown Type */
 
-		acpi_os_printf("Unknown Type %X\n",
-			       ACPI_GET_OBJECT_TYPE(obj_desc));
+		acpi_os_printf("Unknown Type %X\n", obj_desc->common.type);
 		break;
 	}
 
@@ -939,7 +937,7 @@ acpi_ex_dump_package_obj(union acpi_operand_object *obj_desc,
 
 	/* Packages may only contain a few object types */
 
-	switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+	switch (obj_desc->common.type) {
 	case ACPI_TYPE_INTEGER:
 
 		acpi_os_printf("[Integer] = %8.8X%8.8X\n",
@@ -990,8 +988,7 @@ acpi_ex_dump_package_obj(union acpi_operand_object *obj_desc,
 
 	default:
 
-		acpi_os_printf("[Unknown Type] %X\n",
-			       ACPI_GET_OBJECT_TYPE(obj_desc));
+		acpi_os_printf("[Unknown Type] %X\n", obj_desc->common.type);
 		break;
 	}
 }
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index a352d02..546dcdd 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -84,7 +84,7 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_BUFFER_FIELD) {
+	if (obj_desc->common.type == ACPI_TYPE_BUFFER_FIELD) {
 		/*
 		 * If the buffer_field arguments have not been previously evaluated,
 		 * evaluate them now and save the results.
@@ -95,9 +95,8 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 				return_ACPI_STATUS(status);
 			}
 		}
-	} else
-	    if ((ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_LOCAL_REGION_FIELD)
-		&& (obj_desc->field.region_obj->region.space_id ==
+	} else if ((obj_desc->common.type == ACPI_TYPE_LOCAL_REGION_FIELD) &&
+		   (obj_desc->field.region_obj->region.space_id ==
 		    ACPI_ADR_SPACE_SMBUS)) {
 		/*
 		 * This is an SMBus read.  We must create a buffer to hold the data
@@ -163,7 +162,7 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 
 	ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
 			  "FieldRead [TO]:   Obj %p, Type %X, Buf %p, ByteLen %X\n",
-			  obj_desc, ACPI_GET_OBJECT_TYPE(obj_desc), buffer,
+			  obj_desc, obj_desc->common.type, buffer,
 			  (u32) length));
 	ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
 			  "FieldRead [FROM]: BitLen %X, BitOff %X, ByteOff %X\n",
@@ -222,7 +221,7 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 		return_ACPI_STATUS(AE_AML_NO_OPERAND);
 	}
 
-	if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_BUFFER_FIELD) {
+	if (obj_desc->common.type == ACPI_TYPE_BUFFER_FIELD) {
 		/*
 		 * If the buffer_field arguments have not been previously evaluated,
 		 * evaluate them now and save the results.
@@ -233,9 +232,8 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 				return_ACPI_STATUS(status);
 			}
 		}
-	} else
-	    if ((ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_LOCAL_REGION_FIELD)
-		&& (obj_desc->field.region_obj->region.space_id ==
+	} else if ((obj_desc->common.type == ACPI_TYPE_LOCAL_REGION_FIELD) &&
+		   (obj_desc->field.region_obj->region.space_id ==
 		    ACPI_ADR_SPACE_SMBUS)) {
 		/*
 		 * This is an SMBus write.  We will bypass the entire field mechanism
@@ -243,7 +241,7 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 		 *
 		 * Source must be a buffer of sufficient size (ACPI_SMBUS_BUFFER_SIZE).
 		 */
-		if (ACPI_GET_OBJECT_TYPE(source_desc) != ACPI_TYPE_BUFFER) {
+		if (source_desc->common.type != ACPI_TYPE_BUFFER) {
 			ACPI_ERROR((AE_INFO,
 				    "SMBus write requires Buffer, found type %s",
 				    acpi_ut_get_object_type_name(source_desc)));
@@ -291,7 +289,7 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 
 	/* Get a pointer to the data to be written */
 
-	switch (ACPI_GET_OBJECT_TYPE(source_desc)) {
+	switch (source_desc->common.type) {
 	case ACPI_TYPE_INTEGER:
 		buffer = &source_desc->integer.value;
 		length = sizeof(source_desc->integer.value);
@@ -314,15 +312,14 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 	ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
 			  "FieldWrite [FROM]: Obj %p (%s:%X), Buf %p, ByteLen %X\n",
 			  source_desc,
-			  acpi_ut_get_type_name(ACPI_GET_OBJECT_TYPE
-						(source_desc)),
-			  ACPI_GET_OBJECT_TYPE(source_desc), buffer, length));
+			  acpi_ut_get_type_name(source_desc->common.type),
+			  source_desc->common.type, buffer, length));
 
 	ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
 			  "FieldWrite [TO]:   Obj %p (%s:%X), BitLen %X, BitOff %X, ByteOff %X\n",
 			  obj_desc,
-			  acpi_ut_get_type_name(ACPI_GET_OBJECT_TYPE(obj_desc)),
-			  ACPI_GET_OBJECT_TYPE(obj_desc),
+			  acpi_ut_get_type_name(obj_desc->common.type),
+			  obj_desc->common.type,
 			  obj_desc->common_field.bit_length,
 			  obj_desc->common_field.start_field_bit_offset,
 			  obj_desc->common_field.base_byte_offset));
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index ef58ac4..1053e7c 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -94,9 +94,9 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 
 	/* We must have a valid region */
 
-	if (ACPI_GET_OBJECT_TYPE(rgn_desc) != ACPI_TYPE_REGION) {
+	if (rgn_desc->common.type != ACPI_TYPE_REGION) {
 		ACPI_ERROR((AE_INFO, "Needed Region, found type %X (%s)",
-			    ACPI_GET_OBJECT_TYPE(rgn_desc),
+			    rgn_desc->common.type,
 			    acpi_ut_get_object_type_name(rgn_desc)));
 
 		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
@@ -390,7 +390,7 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 	 * index_field - Write to an Index Register, then read/write from/to a
 	 *               Data Register
 	 */
-	switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+	switch (obj_desc->common.type) {
 	case ACPI_TYPE_BUFFER_FIELD:
 		/*
 		 * If the buffer_field arguments have not been previously evaluated,
@@ -527,7 +527,7 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 	default:
 
 		ACPI_ERROR((AE_INFO, "Wrong object type in field I/O %X",
-			    ACPI_GET_OBJECT_TYPE(obj_desc)));
+			    obj_desc->common.type));
 		status = AE_AML_INTERNAL;
 		break;
 	}
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index 6b0747a..998eac3 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -80,7 +80,7 @@ acpi_ex_get_object_reference(union acpi_operand_object *obj_desc,
 	switch (ACPI_GET_DESCRIPTOR_TYPE(obj_desc)) {
 	case ACPI_DESC_TYPE_OPERAND:
 
-		if (ACPI_GET_OBJECT_TYPE(obj_desc) != ACPI_TYPE_LOCAL_REFERENCE) {
+		if (obj_desc->common.type != ACPI_TYPE_LOCAL_REFERENCE) {
 			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 		}
 
@@ -260,7 +260,7 @@ acpi_ex_do_concatenate(union acpi_operand_object *operand0,
 	 * guaranteed to be either Integer/String/Buffer by the operand
 	 * resolution mechanism.
 	 */
-	switch (ACPI_GET_OBJECT_TYPE(operand0)) {
+	switch (operand0->common.type) {
 	case ACPI_TYPE_INTEGER:
 		status =
 		    acpi_ex_convert_to_integer(operand1, &local_operand1, 16);
@@ -277,7 +277,7 @@ acpi_ex_do_concatenate(union acpi_operand_object *operand0,
 
 	default:
 		ACPI_ERROR((AE_INFO, "Invalid object type: %X",
-			    ACPI_GET_OBJECT_TYPE(operand0)));
+			    operand0->common.type));
 		status = AE_AML_INTERNAL;
 	}
 
@@ -298,7 +298,7 @@ acpi_ex_do_concatenate(union acpi_operand_object *operand0,
 	 * 2) Two Strings concatenated to produce a new String
 	 * 3) Two Buffers concatenated to produce a new Buffer
 	 */
-	switch (ACPI_GET_OBJECT_TYPE(operand0)) {
+	switch (operand0->common.type) {
 	case ACPI_TYPE_INTEGER:
 
 		/* Result of two Integers is a Buffer */
@@ -379,7 +379,7 @@ acpi_ex_do_concatenate(union acpi_operand_object *operand0,
 		/* Invalid object type, should not happen here */
 
 		ACPI_ERROR((AE_INFO, "Invalid object type: %X",
-			    ACPI_GET_OBJECT_TYPE(operand0)));
+			    operand0->common.type));
 		status = AE_AML_INTERNAL;
 		goto cleanup;
 	}
@@ -581,7 +581,7 @@ acpi_ex_do_logical_op(u16 opcode,
 	 * guaranteed to be either Integer/String/Buffer by the operand
 	 * resolution mechanism.
 	 */
-	switch (ACPI_GET_OBJECT_TYPE(operand0)) {
+	switch (operand0->common.type) {
 	case ACPI_TYPE_INTEGER:
 		status =
 		    acpi_ex_convert_to_integer(operand1, &local_operand1, 16);
@@ -608,7 +608,7 @@ acpi_ex_do_logical_op(u16 opcode,
 	/*
 	 * Two cases: 1) Both Integers, 2) Both Strings or Buffers
 	 */
-	if (ACPI_GET_OBJECT_TYPE(operand0) == ACPI_TYPE_INTEGER) {
+	if (operand0->common.type == ACPI_TYPE_INTEGER) {
 		/*
 		 * 1) Both operands are of type integer
 		 *    Note: local_operand1 may have changed above
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index b530480..9635d21 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -807,11 +807,9 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 							 acpi_namespace_node *)
 							operand[0]);
 			if (temp_desc
-			    &&
-			    ((ACPI_GET_OBJECT_TYPE(temp_desc) ==
-			      ACPI_TYPE_STRING)
-			     || (ACPI_GET_OBJECT_TYPE(temp_desc) ==
-				 ACPI_TYPE_LOCAL_REFERENCE))) {
+			    && ((temp_desc->common.type == ACPI_TYPE_STRING)
+				|| (temp_desc->common.type ==
+				    ACPI_TYPE_LOCAL_REFERENCE))) {
 				operand[0] = temp_desc;
 				acpi_ut_add_reference(temp_desc);
 			} else {
@@ -819,7 +817,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 				goto cleanup;
 			}
 		} else {
-			switch (ACPI_GET_OBJECT_TYPE(operand[0])) {
+			switch ((operand[0])->common.type) {
 			case ACPI_TYPE_LOCAL_REFERENCE:
 				/*
 				 * This is a deref_of (local_x | arg_x)
@@ -877,8 +875,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 
 		if (ACPI_GET_DESCRIPTOR_TYPE(operand[0]) !=
 		    ACPI_DESC_TYPE_NAMED) {
-			if (ACPI_GET_OBJECT_TYPE(operand[0]) ==
-			    ACPI_TYPE_STRING) {
+			if ((operand[0])->common.type == ACPI_TYPE_STRING) {
 				/*
 				 * This is a deref_of (String). The string is a reference
 				 * to a named ACPI object.
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index 0b4f513..85d95c9 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -399,7 +399,7 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 		 * At this point, the Source operand is a String, Buffer, or Package.
 		 * Verify that the index is within range.
 		 */
-		switch (ACPI_GET_OBJECT_TYPE(operand[0])) {
+		switch ((operand[0])->common.type) {
 		case ACPI_TYPE_STRING:
 
 			if (index >= operand[0]->string.length) {
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index c6520bb..253f9e1 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -161,9 +161,8 @@ acpi_status acpi_ex_opcode_3A_1T_1R(struct acpi_walk_state *walk_state)
 		 * Create the return object.  The Source operand is guaranteed to be
 		 * either a String or a Buffer, so just use its type.
 		 */
-		return_desc =
-		    acpi_ut_create_internal_object(ACPI_GET_OBJECT_TYPE
-						   (operand[0]));
+		return_desc = acpi_ut_create_internal_object((operand[0])->
+							     common.type);
 		if (!return_desc) {
 			status = AE_NO_MEMORY;
 			goto cleanup;
@@ -191,7 +190,7 @@ acpi_status acpi_ex_opcode_3A_1T_1R(struct acpi_walk_state *walk_state)
 
 		/* Strings always have a sub-pointer, not so for buffers */
 
-		switch (ACPI_GET_OBJECT_TYPE(operand[0])) {
+		switch ((operand[0])->common.type) {
 		case ACPI_TYPE_STRING:
 
 			/* Always allocate a new buffer for the String */
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index a226f74..52fec07 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -279,7 +279,7 @@ acpi_ex_decode_field_access(union acpi_operand_object *obj_desc,
 		return_UINT32(0);
 	}
 
-	if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_BUFFER_FIELD) {
+	if (obj_desc->common.type == ACPI_TYPE_BUFFER_FIELD) {
 		/*
 		 * buffer_field access can be on any byte boundary, so the
 		 * byte_alignment is always 1 byte -- regardless of any byte_alignment
diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index a063a74..607958f 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -136,7 +136,7 @@ acpi_ex_resolve_node_to_value(struct acpi_namespace_node **object_ptr,
 	switch (entry_type) {
 	case ACPI_TYPE_PACKAGE:
 
-		if (ACPI_GET_OBJECT_TYPE(source_desc) != ACPI_TYPE_PACKAGE) {
+		if (source_desc->common.type != ACPI_TYPE_PACKAGE) {
 			ACPI_ERROR((AE_INFO, "Object not a Package, type %s",
 				    acpi_ut_get_object_type_name(source_desc)));
 			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
@@ -154,7 +154,7 @@ acpi_ex_resolve_node_to_value(struct acpi_namespace_node **object_ptr,
 
 	case ACPI_TYPE_BUFFER:
 
-		if (ACPI_GET_OBJECT_TYPE(source_desc) != ACPI_TYPE_BUFFER) {
+		if (source_desc->common.type != ACPI_TYPE_BUFFER) {
 			ACPI_ERROR((AE_INFO, "Object not a Buffer, type %s",
 				    acpi_ut_get_object_type_name(source_desc)));
 			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
@@ -172,7 +172,7 @@ acpi_ex_resolve_node_to_value(struct acpi_namespace_node **object_ptr,
 
 	case ACPI_TYPE_STRING:
 
-		if (ACPI_GET_OBJECT_TYPE(source_desc) != ACPI_TYPE_STRING) {
+		if (source_desc->common.type != ACPI_TYPE_STRING) {
 			ACPI_ERROR((AE_INFO, "Object not a String, type %s",
 				    acpi_ut_get_object_type_name(source_desc)));
 			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
@@ -186,7 +186,7 @@ acpi_ex_resolve_node_to_value(struct acpi_namespace_node **object_ptr,
 
 	case ACPI_TYPE_INTEGER:
 
-		if (ACPI_GET_OBJECT_TYPE(source_desc) != ACPI_TYPE_INTEGER) {
+		if (source_desc->common.type != ACPI_TYPE_INTEGER) {
 			ACPI_ERROR((AE_INFO, "Object not a Integer, type %s",
 				    acpi_ut_get_object_type_name(source_desc)));
 			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index f6105a6..c93b54c 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -149,7 +149,7 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 
 	/* This is a union acpi_operand_object    */
 
-	switch (ACPI_GET_OBJECT_TYPE(stack_desc)) {
+	switch (stack_desc->common.type) {
 	case ACPI_TYPE_LOCAL_REFERENCE:
 
 		ref_type = stack_desc->reference.class;
@@ -297,8 +297,7 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 				  "FieldRead SourceDesc=%p Type=%X\n",
-				  stack_desc,
-				  ACPI_GET_OBJECT_TYPE(stack_desc)));
+				  stack_desc, stack_desc->common.type));
 
 		status =
 		    acpi_ex_read_data_from_field(walk_state, stack_desc,
@@ -386,7 +385,7 @@ acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 	 * specification of the object_type and size_of operators). This means
 	 * traversing the list of possibly many nested references.
 	 */
-	while (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_LOCAL_REFERENCE) {
+	while (obj_desc->common.type == ACPI_TYPE_LOCAL_REFERENCE) {
 		switch (obj_desc->reference.class) {
 		case ACPI_REFCLASS_REFOF:
 		case ACPI_REFCLASS_NAME:
@@ -518,7 +517,7 @@ acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 	 * Now we are guaranteed to have an object that has not been created
 	 * via the ref_of or Index operators.
 	 */
-	type = ACPI_GET_OBJECT_TYPE(obj_desc);
+	type = obj_desc->common.type;
 
       exit:
 	/* Convert internal types to external types */
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 3c38027..5c729a9 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -212,7 +212,7 @@ acpi_ex_resolve_operands(u16 opcode,
 
 			/* ACPI internal object */
 
-			object_type = ACPI_GET_OBJECT_TYPE(obj_desc);
+			object_type = obj_desc->common.type;
 
 			/* Check for bad acpi_object_type */
 
@@ -287,8 +287,7 @@ acpi_ex_resolve_operands(u16 opcode,
 
 			if ((ACPI_GET_DESCRIPTOR_TYPE(obj_desc) ==
 			     ACPI_DESC_TYPE_OPERAND)
-			    && (ACPI_GET_OBJECT_TYPE(obj_desc) ==
-				ACPI_TYPE_STRING)) {
+			    && (obj_desc->common.type == ACPI_TYPE_STRING)) {
 				/*
 				 * String found - the string references a named object and
 				 * must be resolved to a node
@@ -336,7 +335,7 @@ acpi_ex_resolve_operands(u16 opcode,
 			 * -- All others must be resolved below.
 			 */
 			if ((opcode == AML_STORE_OP) &&
-			    (ACPI_GET_OBJECT_TYPE(*stack_ptr) ==
+			    ((*stack_ptr)->common.type ==
 			     ACPI_TYPE_LOCAL_REFERENCE)
 			    && ((*stack_ptr)->reference.class == ACPI_REFCLASS_INDEX)) {
 				goto next_operand;
@@ -490,7 +489,7 @@ acpi_ex_resolve_operands(u16 opcode,
 
 			/* Need an operand of type INTEGER, STRING or BUFFER */
 
-			switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+			switch (obj_desc->common.type) {
 			case ACPI_TYPE_INTEGER:
 			case ACPI_TYPE_STRING:
 			case ACPI_TYPE_BUFFER:
@@ -512,7 +511,7 @@ acpi_ex_resolve_operands(u16 opcode,
 
 			/* Need an operand of type STRING or BUFFER */
 
-			switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+			switch (obj_desc->common.type) {
 			case ACPI_TYPE_STRING:
 			case ACPI_TYPE_BUFFER:
 
@@ -553,7 +552,7 @@ acpi_ex_resolve_operands(u16 opcode,
 			 * The only reference allowed here is a direct reference to
 			 * a namespace node.
 			 */
-			switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+			switch (obj_desc->common.type) {
 			case ACPI_TYPE_PACKAGE:
 			case ACPI_TYPE_STRING:
 			case ACPI_TYPE_BUFFER:
@@ -576,7 +575,7 @@ acpi_ex_resolve_operands(u16 opcode,
 
 			/* Need a buffer or package or (ACPI 2.0) String */
 
-			switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+			switch (obj_desc->common.type) {
 			case ACPI_TYPE_PACKAGE:
 			case ACPI_TYPE_STRING:
 			case ACPI_TYPE_BUFFER:
@@ -598,7 +597,7 @@ acpi_ex_resolve_operands(u16 opcode,
 
 			/* Need an operand of type REGION or a BUFFER (which could be a resolved region field) */
 
-			switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+			switch (obj_desc->common.type) {
 			case ACPI_TYPE_BUFFER:
 			case ACPI_TYPE_REGION:
 
@@ -619,7 +618,7 @@ acpi_ex_resolve_operands(u16 opcode,
 
 			/* Used by the Store() operator only */
 
-			switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+			switch (obj_desc->common.type) {
 			case ACPI_TYPE_INTEGER:
 			case ACPI_TYPE_PACKAGE:
 			case ACPI_TYPE_STRING:
@@ -677,8 +676,8 @@ acpi_ex_resolve_operands(u16 opcode,
 		 * required object type (Simple cases only).
 		 */
 		status = acpi_ex_check_object_type(type_needed,
-						   ACPI_GET_OBJECT_TYPE
-						   (*stack_ptr), *stack_ptr);
+						   (*stack_ptr)->common.type,
+						   *stack_ptr);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index e35e9b4..90d6061 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -129,7 +129,7 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 
 	/* source_desc is of type ACPI_DESC_TYPE_OPERAND */
 
-	switch (ACPI_GET_OBJECT_TYPE(source_desc)) {
+	switch (source_desc->common.type) {
 	case ACPI_TYPE_INTEGER:
 
 		/* Output correct integer width */
@@ -324,7 +324,7 @@ acpi_ex_store(union acpi_operand_object *source_desc,
 
 	/* Destination object must be a Reference or a Constant object */
 
-	switch (ACPI_GET_OBJECT_TYPE(dest_desc)) {
+	switch (dest_desc->common.type) {
 	case ACPI_TYPE_LOCAL_REFERENCE:
 		break;
 
@@ -460,9 +460,8 @@ acpi_ex_store_object_to_index(union acpi_operand_object *source_desc,
 		 */
 		obj_desc = *(index_desc->reference.where);
 
-		if (ACPI_GET_OBJECT_TYPE(source_desc) ==
-		    ACPI_TYPE_LOCAL_REFERENCE
-		    && source_desc->reference.class == ACPI_REFCLASS_TABLE) {
+		if (source_desc->common.type == ACPI_TYPE_LOCAL_REFERENCE &&
+		    source_desc->reference.class == ACPI_REFCLASS_TABLE) {
 
 			/* This is a DDBHandle, just add a reference to it */
 
@@ -520,8 +519,8 @@ acpi_ex_store_object_to_index(union acpi_operand_object *source_desc,
 		 * by the INDEX_OP code.
 		 */
 		obj_desc = index_desc->reference.object;
-		if ((ACPI_GET_OBJECT_TYPE(obj_desc) != ACPI_TYPE_BUFFER) &&
-		    (ACPI_GET_OBJECT_TYPE(obj_desc) != ACPI_TYPE_STRING)) {
+		if ((obj_desc->common.type != ACPI_TYPE_BUFFER) &&
+		    (obj_desc->common.type != ACPI_TYPE_STRING)) {
 			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 		}
 
@@ -529,7 +528,7 @@ acpi_ex_store_object_to_index(union acpi_operand_object *source_desc,
 		 * The assignment of the individual elements will be slightly
 		 * different for each source type.
 		 */
-		switch (ACPI_GET_OBJECT_TYPE(source_desc)) {
+		switch (source_desc->common.type) {
 		case ACPI_TYPE_INTEGER:
 
 			/* Use the least-significant byte of the integer */
@@ -707,8 +706,7 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 		/* No conversions for all other types.  Just attach the source object */
 
 		status = acpi_ns_attach_object(node, source_desc,
-					       ACPI_GET_OBJECT_TYPE
-					       (source_desc));
+					       source_desc->common.type);
 		break;
 	}
 
diff --git a/drivers/acpi/acpica/exstoren.c b/drivers/acpi/acpica/exstoren.c
index 145d153..608e838 100644
--- a/drivers/acpi/acpica/exstoren.c
+++ b/drivers/acpi/acpica/exstoren.c
@@ -96,8 +96,7 @@ acpi_ex_resolve_object(union acpi_operand_object **source_desc_ptr,
 		 * are all essentially the same.  This case handles the
 		 * "interchangeable" types Integer, String, and Buffer.
 		 */
-		if (ACPI_GET_OBJECT_TYPE(source_desc) ==
-		    ACPI_TYPE_LOCAL_REFERENCE) {
+		if (source_desc->common.type == ACPI_TYPE_LOCAL_REFERENCE) {
 
 			/* Resolve a reference object first */
 
@@ -117,13 +116,11 @@ acpi_ex_resolve_object(union acpi_operand_object **source_desc_ptr,
 
 		/* Must have a Integer, Buffer, or String */
 
-		if ((ACPI_GET_OBJECT_TYPE(source_desc) != ACPI_TYPE_INTEGER) &&
-		    (ACPI_GET_OBJECT_TYPE(source_desc) != ACPI_TYPE_BUFFER) &&
-		    (ACPI_GET_OBJECT_TYPE(source_desc) != ACPI_TYPE_STRING) &&
-		    !((ACPI_GET_OBJECT_TYPE(source_desc) ==
-		       ACPI_TYPE_LOCAL_REFERENCE)
-		      && (source_desc->reference.class ==
-			  ACPI_REFCLASS_TABLE))) {
+		if ((source_desc->common.type != ACPI_TYPE_INTEGER) &&
+		    (source_desc->common.type != ACPI_TYPE_BUFFER) &&
+		    (source_desc->common.type != ACPI_TYPE_STRING) &&
+		    !((source_desc->common.type == ACPI_TYPE_LOCAL_REFERENCE) &&
+		      (source_desc->reference.class == ACPI_REFCLASS_TABLE))) {
 
 			/* Conversion successful but still not a valid type */
 
@@ -218,8 +215,7 @@ acpi_ex_store_object_to_object(union acpi_operand_object *source_desc,
 		return_ACPI_STATUS(status);
 	}
 
-	if (ACPI_GET_OBJECT_TYPE(source_desc) !=
-	    ACPI_GET_OBJECT_TYPE(dest_desc)) {
+	if (source_desc->common.type != dest_desc->common.type) {
 		/*
 		 * The source type does not match the type of the destination.
 		 * Perform the "implicit conversion" of the source to the current type
@@ -229,11 +225,10 @@ acpi_ex_store_object_to_object(union acpi_operand_object *source_desc,
 		 * Otherwise, actual_src_desc is a temporary object to hold the
 		 * converted object.
 		 */
-		status =
-		    acpi_ex_convert_to_target_type(ACPI_GET_OBJECT_TYPE
-						   (dest_desc), source_desc,
-						   &actual_src_desc,
-						   walk_state);
+		status = acpi_ex_convert_to_target_type(dest_desc->common.type,
+							source_desc,
+							&actual_src_desc,
+							walk_state);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
@@ -252,7 +247,7 @@ acpi_ex_store_object_to_object(union acpi_operand_object *source_desc,
 	 * We now have two objects of identical types, and we can perform a
 	 * copy of the *value* of the source object.
 	 */
-	switch (ACPI_GET_OBJECT_TYPE(dest_desc)) {
+	switch (dest_desc->common.type) {
 	case ACPI_TYPE_INTEGER:
 
 		dest_desc->integer.value = actual_src_desc->integer.value;
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 32b85d6..87730e9 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -221,7 +221,7 @@ void acpi_ex_truncate_for32bit_table(union acpi_operand_object *obj_desc)
 	 */
 	if ((!obj_desc) ||
 	    (ACPI_GET_DESCRIPTOR_TYPE(obj_desc) != ACPI_DESC_TYPE_OPERAND) ||
-	    (ACPI_GET_OBJECT_TYPE(obj_desc) != ACPI_TYPE_INTEGER)) {
+	    (obj_desc->common.type != ACPI_TYPE_INTEGER)) {
 		return;
 	}
 
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index f67562e..4df9eac 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -532,7 +532,7 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 
 	/* It must be of type Package */
 
-	else if (ACPI_GET_OBJECT_TYPE(info->return_object) != ACPI_TYPE_PACKAGE) {
+	else if (info->return_object->common.type != ACPI_TYPE_PACKAGE) {
 		ACPI_ERROR((AE_INFO,
 			    "Sleep State return object is not a Package"));
 		status = AE_AML_OPERAND_TYPE;
@@ -553,9 +553,9 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 
 	/* The first two elements must both be of type Integer */
 
-	else if ((ACPI_GET_OBJECT_TYPE(info->return_object->package.elements[0])
+	else if (((info->return_object->package.elements[0])->common.type
 		  != ACPI_TYPE_INTEGER) ||
-		 (ACPI_GET_OBJECT_TYPE(info->return_object->package.elements[1])
+		 ((info->return_object->package.elements[1])->common.type
 		  != ACPI_TYPE_INTEGER)) {
 		ACPI_ERROR((AE_INFO,
 			    "Sleep State return package elements are not both Integers (%s, %s)",
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 88303eb..b6968a6 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -234,8 +234,7 @@ acpi_status acpi_ns_root_initialize(void)
 			/* Store pointer to value descriptor in the Node */
 
 			status = acpi_ns_attach_object(new_node, obj_desc,
-						       ACPI_GET_OBJECT_TYPE
-						       (obj_desc));
+						       obj_desc->common.type);
 
 			/* Remove local reference to the object */
 
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index e96d37a..7bfa6c1 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -515,7 +515,7 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 
 		case ACPI_DESC_TYPE_OPERAND:
 
-			obj_type = ACPI_GET_OBJECT_TYPE(obj_desc);
+			obj_type = obj_desc->common.type;
 
 			if (obj_type > ACPI_TYPE_LOCAL_MAX) {
 				acpi_os_printf
diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index 08a97a5..3eb20bf 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -209,8 +209,7 @@ void acpi_ns_detach_object(struct acpi_namespace_node *node)
 
 	obj_desc = node->object;
 
-	if (!obj_desc ||
-	    (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_LOCAL_DATA)) {
+	if (!obj_desc || (obj_desc->common.type == ACPI_TYPE_LOCAL_DATA)) {
 		return_VOID;
 	}
 
@@ -220,8 +219,7 @@ void acpi_ns_detach_object(struct acpi_namespace_node *node)
 	if (ACPI_GET_DESCRIPTOR_TYPE(obj_desc) == ACPI_DESC_TYPE_OPERAND) {
 		node->object = obj_desc->common.next_object;
 		if (node->object &&
-		    (ACPI_GET_OBJECT_TYPE(node->object) !=
-		     ACPI_TYPE_LOCAL_DATA)) {
+		    ((node->object)->common.type != ACPI_TYPE_LOCAL_DATA)) {
 			node->object = node->object->common.next_object;
 		}
 	}
@@ -267,7 +265,7 @@ union acpi_operand_object *acpi_ns_get_attached_object(struct
 	    ((ACPI_GET_DESCRIPTOR_TYPE(node->object) != ACPI_DESC_TYPE_OPERAND)
 	     && (ACPI_GET_DESCRIPTOR_TYPE(node->object) !=
 		 ACPI_DESC_TYPE_NAMED))
-	    || (ACPI_GET_OBJECT_TYPE(node->object) == ACPI_TYPE_LOCAL_DATA)) {
+	    || ((node->object)->common.type == ACPI_TYPE_LOCAL_DATA)) {
 		return_PTR(NULL);
 	}
 
@@ -294,9 +292,9 @@ union acpi_operand_object *acpi_ns_get_secondary_object(union
 	ACPI_FUNCTION_TRACE_PTR(ns_get_secondary_object, obj_desc);
 
 	if ((!obj_desc) ||
-	    (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_LOCAL_DATA) ||
+	    (obj_desc->common.type == ACPI_TYPE_LOCAL_DATA) ||
 	    (!obj_desc->common.next_object) ||
-	    (ACPI_GET_OBJECT_TYPE(obj_desc->common.next_object) ==
+	    ((obj_desc->common.next_object)->common.type ==
 	     ACPI_TYPE_LOCAL_DATA)) {
 		return_PTR(NULL);
 	}
@@ -331,7 +329,7 @@ acpi_ns_attach_data(struct acpi_namespace_node *node,
 	prev_obj_desc = NULL;
 	obj_desc = node->object;
 	while (obj_desc) {
-		if ((ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_LOCAL_DATA) &&
+		if ((obj_desc->common.type == ACPI_TYPE_LOCAL_DATA) &&
 		    (obj_desc->data.handler == handler)) {
 			return (AE_ALREADY_EXISTS);
 		}
@@ -385,7 +383,7 @@ acpi_ns_detach_data(struct acpi_namespace_node * node,
 	prev_obj_desc = NULL;
 	obj_desc = node->object;
 	while (obj_desc) {
-		if ((ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_LOCAL_DATA) &&
+		if ((obj_desc->common.type == ACPI_TYPE_LOCAL_DATA) &&
 		    (obj_desc->data.handler == handler)) {
 			if (prev_obj_desc) {
 				prev_obj_desc->common.next_object =
@@ -428,7 +426,7 @@ acpi_ns_get_attached_data(struct acpi_namespace_node * node,
 
 	obj_desc = node->object;
 	while (obj_desc) {
-		if ((ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_LOCAL_DATA) &&
+		if ((obj_desc->common.type == ACPI_TYPE_LOCAL_DATA) &&
 		    (obj_desc->data.handler == handler)) {
 			*data = obj_desc->data.pointer;
 			return (AE_OK);
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 4527032..72dd7b1 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -221,7 +221,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 
 	/* For returned Package objects, check the type of all sub-objects */
 
-	if (ACPI_GET_OBJECT_TYPE(return_object) == ACPI_TYPE_PACKAGE) {
+	if (return_object->common.type == ACPI_TYPE_PACKAGE) {
 		status =
 		    acpi_ns_check_package(pathname, return_object_ptr,
 					  predefined);
@@ -858,7 +858,7 @@ acpi_ns_check_object_type(char *pathname,
 	 * from all of the predefined names (including elements of returned
 	 * packages)
 	 */
-	switch (ACPI_GET_OBJECT_TYPE(return_object)) {
+	switch (return_object->common.type) {
 	case ACPI_TYPE_INTEGER:
 		return_btype = ACPI_RTYPE_INTEGER;
 		break;
@@ -901,7 +901,7 @@ acpi_ns_check_object_type(char *pathname,
 
 	/* For reference objects, check that the reference type is correct */
 
-	if (ACPI_GET_OBJECT_TYPE(return_object) == ACPI_TYPE_LOCAL_REFERENCE) {
+	if (return_object->common.type == ACPI_TYPE_LOCAL_REFERENCE) {
 		status = acpi_ns_check_reference(pathname, return_object);
 	}
 
@@ -1006,7 +1006,7 @@ acpi_ns_repair_object(u32 expected_btypes,
 	union acpi_operand_object *new_object;
 	acpi_size length;
 
-	switch (ACPI_GET_OBJECT_TYPE(return_object)) {
+	switch (return_object->common.type) {
 	case ACPI_TYPE_BUFFER:
 
 		if (!(expected_btypes & ACPI_RTYPE_STRING)) {
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 22a7171..2583a66 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -387,8 +387,7 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
 
 	/* We are interested in reference objects only */
 
-	if (ACPI_GET_OBJECT_TYPE(info->return_object) !=
-	    ACPI_TYPE_LOCAL_REFERENCE) {
+	if ((info->return_object)->common.type != ACPI_TYPE_LOCAL_REFERENCE) {
 		return;
 	}
 
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 52865ee..b6667ff 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -557,9 +557,9 @@ acpi_rs_get_pci_routing_table_length(union acpi_operand_object *package_object,
 		     table_index++) {
 			if (*sub_object_list &&	/* Null object allowed */
 			    ((ACPI_TYPE_STRING ==
-			      ACPI_GET_OBJECT_TYPE(*sub_object_list)) ||
+			      (*sub_object_list)->common.type) ||
 			     ((ACPI_TYPE_LOCAL_REFERENCE ==
-			       ACPI_GET_OBJECT_TYPE(*sub_object_list)) &&
+			       (*sub_object_list)->common.type) &&
 			      ((*sub_object_list)->reference.class ==
 			       ACPI_REFCLASS_NAME)))) {
 				name_found = TRUE;
@@ -575,8 +575,7 @@ acpi_rs_get_pci_routing_table_length(union acpi_operand_object *package_object,
 		/* Was a String type found? */
 
 		if (name_found) {
-			if (ACPI_GET_OBJECT_TYPE(*sub_object_list) ==
-			    ACPI_TYPE_STRING) {
+			if ((*sub_object_list)->common.type == ACPI_TYPE_STRING) {
 				/*
 				 * The length String.Length field does not include the
 				 * terminating NULL, add 1
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index 61566b1..663f692 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -212,7 +212,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 
 		/* Each element of the top-level package must also be a package */
 
-		if (ACPI_GET_OBJECT_TYPE(*top_object_list) != ACPI_TYPE_PACKAGE) {
+		if ((*top_object_list)->common.type != ACPI_TYPE_PACKAGE) {
 			ACPI_ERROR((AE_INFO,
 				    "(PRT[%X]) Need sub-package, found %s",
 				    index,
@@ -240,7 +240,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		/* 1) First subobject: Dereference the PRT.Address */
 
 		obj_desc = sub_object_list[0];
-		if (ACPI_GET_OBJECT_TYPE(obj_desc) != ACPI_TYPE_INTEGER) {
+		if (obj_desc->common.type != ACPI_TYPE_INTEGER) {
 			ACPI_ERROR((AE_INFO,
 				    "(PRT[%X].Address) Need Integer, found %s",
 				    index,
@@ -253,7 +253,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		/* 2) Second subobject: Dereference the PRT.Pin */
 
 		obj_desc = sub_object_list[1];
-		if (ACPI_GET_OBJECT_TYPE(obj_desc) != ACPI_TYPE_INTEGER) {
+		if (obj_desc->common.type != ACPI_TYPE_INTEGER) {
 			ACPI_ERROR((AE_INFO,
 				    "(PRT[%X].Pin) Need Integer, found %s",
 				    index,
@@ -265,7 +265,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		 * If BIOS erroneously reversed the _PRT source_name and source_index,
 		 * then reverse them back.
 		 */
-		if (ACPI_GET_OBJECT_TYPE(sub_object_list[3]) !=
+		if ((sub_object_list[3])->common.type !=
 		    ACPI_TYPE_INTEGER) {
 			if (acpi_gbl_enable_interpreter_slack) {
 				source_name_index = 3;
@@ -291,8 +291,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		 * other ACPI implementations.
 		 */
 		obj_desc = sub_object_list[3];
-		if (!obj_desc
-		    || (ACPI_GET_OBJECT_TYPE(obj_desc) != ACPI_TYPE_INTEGER)) {
+		if (!obj_desc || (obj_desc->common.type != ACPI_TYPE_INTEGER)) {
 			sub_object_list[3] = sub_object_list[2];
 			sub_object_list[2] = obj_desc;
 
@@ -307,7 +306,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		 */
 		obj_desc = sub_object_list[source_name_index];
 		if (obj_desc) {
-			switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+			switch (obj_desc->common.type) {
 			case ACPI_TYPE_LOCAL_REFERENCE:
 
 				if (obj_desc->reference.class !=
@@ -380,7 +379,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		/* 4) Fourth subobject: Dereference the PRT.source_index */
 
 		obj_desc = sub_object_list[source_index_index];
-		if (ACPI_GET_OBJECT_TYPE(obj_desc) != ACPI_TYPE_INTEGER) {
+		if (obj_desc->common.type != ACPI_TYPE_INTEGER) {
 			ACPI_ERROR((AE_INFO,
 				    "(PRT[%X].SourceIndex) Need Integer, found %s",
 				    index,
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index b0dcfd3..cabe860 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -135,11 +135,11 @@ acpi_ut_copy_isimple_to_esimple(union acpi_operand_object *internal_object,
 	 * In general, the external object will be the same type as
 	 * the internal object
 	 */
-	external_object->type = ACPI_GET_OBJECT_TYPE(internal_object);
+	external_object->type = internal_object->common.type;
 
 	/* However, only a limited number of external types are supported */
 
-	switch (ACPI_GET_OBJECT_TYPE(internal_object)) {
+	switch (internal_object->common.type) {
 	case ACPI_TYPE_STRING:
 
 		external_object->string.pointer = (char *)data_space;
@@ -222,8 +222,8 @@ acpi_ut_copy_isimple_to_esimple(union acpi_operand_object *internal_object,
 		 */
 		ACPI_ERROR((AE_INFO,
 			    "Unsupported object type, cannot convert to external object: %s",
-			    acpi_ut_get_type_name(ACPI_GET_OBJECT_TYPE
-						  (internal_object))));
+			    acpi_ut_get_type_name(internal_object->common.
+						  type)));
 
 		return_ACPI_STATUS(AE_SUPPORT);
 	}
@@ -355,7 +355,7 @@ acpi_ut_copy_ipackage_to_epackage(union acpi_operand_object *internal_object,
 	info.object_space = 0;
 	info.num_packages = 1;
 
-	external_object->type = ACPI_GET_OBJECT_TYPE(internal_object);
+	external_object->type = internal_object->common.type;
 	external_object->package.count = internal_object->package.count;
 	external_object->package.elements = ACPI_CAST_PTR(union acpi_object,
 							  info.free_space);
@@ -399,7 +399,7 @@ acpi_ut_copy_iobject_to_eobject(union acpi_operand_object *internal_object,
 
 	ACPI_FUNCTION_TRACE(ut_copy_iobject_to_eobject);
 
-	if (ACPI_GET_OBJECT_TYPE(internal_object) == ACPI_TYPE_PACKAGE) {
+	if (internal_object->common.type == ACPI_TYPE_PACKAGE) {
 		/*
 		 * Package object:  Copy all subobjects (including
 		 * nested packages)
@@ -697,7 +697,7 @@ acpi_ut_copy_simple_object(union acpi_operand_object *source_desc,
 
 	/* Handle the objects with extra data */
 
-	switch (ACPI_GET_OBJECT_TYPE(dest_desc)) {
+	switch (dest_desc->common.type) {
 	case ACPI_TYPE_BUFFER:
 		/*
 		 * Allocate and copy the actual buffer if and only if:
@@ -814,8 +814,8 @@ acpi_ut_copy_ielement_to_ielement(u8 object_type,
 			 * This is a simple object, just copy it
 			 */
 			target_object =
-			    acpi_ut_create_internal_object(ACPI_GET_OBJECT_TYPE
-							   (source_object));
+			    acpi_ut_create_internal_object(source_object->
+							   common.type);
 			if (!target_object) {
 				return (AE_NO_MEMORY);
 			}
@@ -892,7 +892,7 @@ acpi_ut_copy_ipackage_to_ipackage(union acpi_operand_object *source_obj,
 
 	ACPI_FUNCTION_TRACE(ut_copy_ipackage_to_ipackage);
 
-	dest_obj->common.type = ACPI_GET_OBJECT_TYPE(source_obj);
+	dest_obj->common.type = source_obj->common.type;
 	dest_obj->common.flags = source_obj->common.flags;
 	dest_obj->package.count = source_obj->package.count;
 
@@ -950,15 +950,14 @@ acpi_ut_copy_iobject_to_iobject(union acpi_operand_object *source_desc,
 
 	/* Create the top level object */
 
-	*dest_desc =
-	    acpi_ut_create_internal_object(ACPI_GET_OBJECT_TYPE(source_desc));
+	*dest_desc = acpi_ut_create_internal_object(source_desc->common.type);
 	if (!*dest_desc) {
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
 	/* Copy the object and possible subobjects */
 
-	if (ACPI_GET_OBJECT_TYPE(source_desc) == ACPI_TYPE_PACKAGE) {
+	if (source_desc->common.type == ACPI_TYPE_PACKAGE) {
 		status =
 		    acpi_ut_copy_ipackage_to_ipackage(source_desc, *dest_desc,
 						      walk_state);
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index a0be9e3..a5ee23b 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -86,7 +86,7 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 	 * Must delete or free any pointers within the object that are not
 	 * actual ACPI objects (for example, a raw buffer pointer).
 	 */
-	switch (ACPI_GET_OBJECT_TYPE(object)) {
+	switch (object->common.type) {
 	case ACPI_TYPE_STRING:
 
 		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
@@ -382,7 +382,7 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 					  object, new_count));
 		}
 
-		if (ACPI_GET_OBJECT_TYPE(object) == ACPI_TYPE_METHOD) {
+		if (object->common.type == ACPI_TYPE_METHOD) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
 					  "Method Obj %p Refs=%X, [Decremented]\n",
 					  object, new_count));
@@ -469,7 +469,7 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 		 * All sub-objects must have their reference count incremented also.
 		 * Different object types have different subobjects.
 		 */
-		switch (ACPI_GET_OBJECT_TYPE(object)) {
+		switch (object->common.type) {
 		case ACPI_TYPE_DEVICE:
 		case ACPI_TYPE_PROCESSOR:
 		case ACPI_TYPE_POWER:
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 9c9897d..99bfbd2 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -248,7 +248,7 @@ acpi_ut_evaluate_object(struct acpi_namespace_node *prefix_node,
 
 	/* Map the return object type to the bitmapped type */
 
-	switch (ACPI_GET_OBJECT_TYPE(info->return_object)) {
+	switch ((info->return_object)->common.type) {
 	case ACPI_TYPE_INTEGER:
 		return_btype = ACPI_BTYPE_INTEGER;
 		break;
@@ -418,7 +418,7 @@ acpi_ut_execute_HID(struct acpi_namespace_node *device_node,
 		return_ACPI_STATUS(status);
 	}
 
-	if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_INTEGER) {
+	if (obj_desc->common.type == ACPI_TYPE_INTEGER) {
 
 		/* Convert the Numeric HID to string */
 
@@ -459,7 +459,7 @@ acpi_ut_translate_one_cid(union acpi_operand_object *obj_desc,
 			  struct acpi_compatible_id *one_cid)
 {
 
-	switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+	switch (obj_desc->common.type) {
 	case ACPI_TYPE_INTEGER:
 
 		/* Convert the Numeric CID to string */
@@ -527,7 +527,7 @@ acpi_ut_execute_CID(struct acpi_namespace_node * device_node,
 	/* Get the number of _CIDs returned */
 
 	count = 1;
-	if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_PACKAGE) {
+	if (obj_desc->common.type == ACPI_TYPE_PACKAGE) {
 		count = obj_desc->package.count;
 	}
 
@@ -555,7 +555,7 @@ acpi_ut_execute_CID(struct acpi_namespace_node * device_node,
 
 	/* The _CID object can be either a single CID or a package (list) of CIDs */
 
-	if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_PACKAGE) {
+	if (obj_desc->common.type == ACPI_TYPE_PACKAGE) {
 
 		/* Translate each package element */
 
@@ -620,7 +620,7 @@ acpi_ut_execute_UID(struct acpi_namespace_node *device_node,
 		return_ACPI_STATUS(status);
 	}
 
-	if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_INTEGER) {
+	if (obj_desc->common.type == ACPI_TYPE_INTEGER) {
 
 		/* Convert the Numeric UID to string */
 
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index bec0e21..7fc35d3 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -473,7 +473,7 @@ char *acpi_ut_get_object_type_name(union acpi_operand_object *obj_desc)
 		return ("[NULL Object Descriptor]");
 	}
 
-	return (acpi_ut_get_type_name(ACPI_GET_OBJECT_TYPE(obj_desc)));
+	return (acpi_ut_get_type_name(obj_desc->common.type));
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index c1f7f4e..1c9e250 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -938,8 +938,7 @@ acpi_ut_walk_package_tree(union acpi_operand_object * source_object,
 		if ((!this_source_obj) ||
 		    (ACPI_GET_DESCRIPTOR_TYPE(this_source_obj) !=
 		     ACPI_DESC_TYPE_OPERAND)
-		    || (ACPI_GET_OBJECT_TYPE(this_source_obj) !=
-			ACPI_TYPE_PACKAGE)) {
+		    || (this_source_obj->common.type != ACPI_TYPE_PACKAGE)) {
 			status =
 			    walk_callback(ACPI_COPY_TYPE_SIMPLE,
 					  this_source_obj, state, context);
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index fd5ea75..ae337a7 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -457,7 +457,7 @@ acpi_ut_get_simple_object_size(union acpi_operand_object *internal_object,
 	 * must be accessed bytewise or there may be alignment problems on
 	 * certain processors
 	 */
-	switch (ACPI_GET_OBJECT_TYPE(internal_object)) {
+	switch (internal_object->common.type) {
 	case ACPI_TYPE_STRING:
 
 		length += (acpi_size) internal_object->string.length + 1;
@@ -518,8 +518,7 @@ acpi_ut_get_simple_object_size(union acpi_operand_object *internal_object,
 		ACPI_ERROR((AE_INFO, "Cannot convert to external object - "
 			    "unsupported type [%s] %X in object %p",
 			    acpi_ut_get_object_type_name(internal_object),
-			    ACPI_GET_OBJECT_TYPE(internal_object),
-			    internal_object));
+			    internal_object->common.type, internal_object));
 		status = AE_TYPE;
 		break;
 	}
@@ -664,7 +663,7 @@ acpi_ut_get_object_size(union acpi_operand_object *internal_object,
 
 	if ((ACPI_GET_DESCRIPTOR_TYPE(internal_object) ==
 	     ACPI_DESC_TYPE_OPERAND)
-	    && (ACPI_GET_OBJECT_TYPE(internal_object) == ACPI_TYPE_PACKAGE)) {
+	    && (internal_object->common.type == ACPI_TYPE_PACKAGE)) {
 		status =
 		    acpi_ut_get_package_object_size(internal_object,
 						    obj_length);
-- 
1.6.0.6

