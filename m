From: Len Brown <lenb@kernel.org>
Subject: [PATCH 106/140] ACPICA: Fixes for load() operator.
Date: Wed,  7 Feb 2007 13:52:00 -0500
Message-ID: <11708745214032-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <a6823e12ca3f79a8c0f8b2d14976ab2152d117e5.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:24742 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422776AbXBGSz2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:28 -0500
In-Reply-To: <11708745202061-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Optimized the Load operator in the case where the source operand is an
operation region. Simply map the operation region memory, instead of
performing a bytewise read.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exconfig.c |  160 ++++++++------------------------------
 drivers/acpi/executer/exresop.c  |   10 +--
 include/acpi/acopcode.h          |    2 +-
 include/acpi/amlcode.h           |    2 +-
 4 files changed, 40 insertions(+), 134 deletions(-)

diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/executer/exconfig.c
index 7aa18f9..61ec855 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -119,7 +119,7 @@ acpi_ex_add_table(acpi_native_uint table_index,
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Load an ACPI table
+ * DESCRIPTION: Load an ACPI table from the RSDT/XSDT
  *
  ******************************************************************************/
 
@@ -138,21 +138,7 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 
 	ACPI_FUNCTION_TRACE(ex_load_table_op);
 
-#if 0
-	/*
-	 * Make sure that the signature does not match one of the tables that
-	 * is already loaded.
-	 */
-	status = acpi_tb_match_signature(operand[0]->string.pointer, NULL);
-	if (status == AE_OK) {
-
-		/* Signature matched -- don't allow override */
-
-		return_ACPI_STATUS(AE_ALREADY_EXISTS);
-	}
-#endif
-
-	/* Find the ACPI table */
+	/* Find the ACPI table in the RSDT/XSDT */
 
 	status = acpi_tb_find_table(operand[0]->string.pointer,
 				    operand[1]->string.pointer,
@@ -256,7 +242,7 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
  *
  * FUNCTION:    acpi_ex_load_op
  *
- * PARAMETERS:  obj_desc        - Region or Field where the table will be
+ * PARAMETERS:  obj_desc        - Region or Buffer/Field where the table will be
  *                                obtained
  *              Target          - Where a handle to the table will be stored
  *              walk_state      - Current state
@@ -265,6 +251,12 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
  *
  * DESCRIPTION: Load an ACPI table from a field or operation region
  *
+ * NOTE: Region Fields (Field, bank_field, index_fields) are resolved to buffer
+ *       objects before this code is reached.
+ *
+ *       If source is an operation region, it must refer to system_memory, as
+ *       per the ACPI specification.
+ *
  ******************************************************************************/
 
 acpi_status
@@ -272,24 +264,26 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		union acpi_operand_object *target,
 		struct acpi_walk_state *walk_state)
 {
-	acpi_status status;
 	union acpi_operand_object *ddb_handle;
-	union acpi_operand_object *buffer_desc = NULL;
-	struct acpi_table_header *table_ptr = NULL;
-	acpi_native_uint table_index;
-	acpi_physical_address address;
-	struct acpi_table_header table_header;
 	struct acpi_table_desc table_desc;
-	acpi_integer temp;
-	u32 i;
+	acpi_native_uint table_index;
+	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ex_load_op);
 
-	/* Object can be either an op_region or a Field */
 	ACPI_MEMSET(&table_desc, 0, sizeof(struct acpi_table_desc));
+
+	/* Source Object can be either an op_region or a Buffer/Field */
+
 	switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
 	case ACPI_TYPE_REGION:
 
+		/* Region must be system_memory (from ACPI spec) */
+
+		if (obj_desc->region.space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
+		}
+
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Load from Region %p %s\n",
 				  obj_desc,
 				  acpi_ut_get_object_type_name(obj_desc)));
@@ -305,113 +299,31 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 			}
 		}
 
-		/* Get the base physical address of the region */
-
-		address = obj_desc->region.address;
-
-		/* Get part of the table header to get the table length */
-
-		table_header.length = 0;
-		for (i = 0; i < 8; i++) {
-			status =
-			    acpi_ev_address_space_dispatch(obj_desc, ACPI_READ,
-							   (acpi_physical_address)
-							   (i + address), 8,
-							   &temp);
-			if (ACPI_FAILURE(status)) {
-				return_ACPI_STATUS(status);
-			}
-
-			/* Get the one valid byte of the returned 64-bit value */
-
-			ACPI_CAST_PTR(u8, &table_header)[i] = (u8) temp;
-		}
-
-		/* Sanity check the table length */
-
-		if (table_header.length < sizeof(struct acpi_table_header)) {
-			return_ACPI_STATUS(AE_BAD_HEADER);
-		}
-
-		/* Allocate a buffer for the entire table */
-
-		table_ptr = ACPI_ALLOCATE(table_header.length);
-		if (!table_ptr) {
-			return_ACPI_STATUS(AE_NO_MEMORY);
-		}
-
-		/* Get the entire table from the op region */
-
-		for (i = 0; i < table_header.length; i++) {
-			status =
-			    acpi_ev_address_space_dispatch(obj_desc, ACPI_READ,
-							   (acpi_physical_address)
-							   (i + address), 8,
-							   &temp);
-			if (ACPI_FAILURE(status)) {
-				goto cleanup;
-			}
-
-			/* Get the one valid byte of the returned 64-bit value */
-
-			ACPI_CAST_PTR(u8, table_ptr)[i] = (u8) temp;
-		}
+		table_desc.address = obj_desc->region.address;
+		table_desc.length = obj_desc->region.length;
+		table_desc.flags = ACPI_TABLE_ORIGIN_MAPPED;
 		break;
 
-	case ACPI_TYPE_LOCAL_REGION_FIELD:
-	case ACPI_TYPE_LOCAL_BANK_FIELD:
-	case ACPI_TYPE_LOCAL_INDEX_FIELD:
+	case ACPI_TYPE_BUFFER:	/* Buffer or resolved region_field */
 
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Load from Field %p %s\n",
-				  obj_desc,
-				  acpi_ut_get_object_type_name(obj_desc)));
+		/* Simply extract the buffer from the buffer object */
 
-		/*
-		 * The length of the field must be at least as large as the table.
-		 * Read the entire field and thus the entire table.  Buffer is
-		 * allocated during the read.
-		 */
-		status =
-		    acpi_ex_read_data_from_field(walk_state, obj_desc,
-						 &buffer_desc);
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
-
-		table_ptr = ACPI_CAST_PTR(struct acpi_table_header,
-					  buffer_desc->buffer.pointer);
-
-		/* All done with the buffer_desc, delete it */
-
-		buffer_desc->buffer.pointer = NULL;
-		acpi_ut_remove_reference(buffer_desc);
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+				  "Load from Buffer or Field %p %s\n", obj_desc,
+				  acpi_ut_get_object_type_name(obj_desc)));
 
-		/* Sanity check the table length */
+		table_desc.pointer = ACPI_CAST_PTR(struct acpi_table_header,
+						   obj_desc->buffer.pointer);
+		table_desc.length = table_desc.pointer->length;
+		table_desc.flags = ACPI_TABLE_ORIGIN_ALLOCATED;
 
-		if (table_ptr->length < sizeof(struct acpi_table_header)) {
-			status = AE_BAD_HEADER;
-			goto cleanup;
-		}
+		obj_desc->buffer.pointer = NULL;
 		break;
 
 	default:
 		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 	}
 
-	/* The table must be either an SSDT or a PSDT */
-
-	if ((!ACPI_COMPARE_NAME(table_ptr->signature, ACPI_SIG_PSDT)) &&
-	    (!ACPI_COMPARE_NAME(table_ptr->signature, ACPI_SIG_SSDT))) {
-		ACPI_ERROR((AE_INFO,
-			    "Table has invalid signature [%4.4s], must be SSDT or PSDT",
-			    table_ptr->signature));
-		status = AE_BAD_SIGNATURE;
-		goto cleanup;
-	}
-
-	table_desc.pointer = table_ptr;
-	table_desc.length = table_ptr->length;
-	table_desc.flags = ACPI_TABLE_ORIGIN_ALLOCATED;
 	/*
 	 * Install the new table into the local data structures
 	 */
@@ -440,13 +352,9 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(status);
 	}
 
-	ACPI_INFO((AE_INFO,
-		   "Dynamic SSDT Load - OemId [%6.6s] OemTableId [%8.8s]",
-		   table_ptr->oem_id, table_ptr->oem_table_id));
-
       cleanup:
 	if (ACPI_FAILURE(status)) {
-		ACPI_FREE(table_ptr);
+		acpi_tb_delete_table(&table_desc);
 	}
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/executer/exresop.c b/drivers/acpi/executer/exresop.c
index 4c93d09..411d120 100644
--- a/drivers/acpi/executer/exresop.c
+++ b/drivers/acpi/executer/exresop.c
@@ -611,22 +611,20 @@ acpi_ex_resolve_operands(u16 opcode,
 			}
 			goto next_operand;
 
-		case ARGI_REGION_OR_FIELD:
+		case ARGI_REGION_OR_BUFFER:	/* Used by Load() only */
 
-			/* Need an operand of type REGION or a FIELD in a region */
+			/* Need an operand of type REGION or a BUFFER (which could be a resolved region field) */
 
 			switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
+			case ACPI_TYPE_BUFFER:
 			case ACPI_TYPE_REGION:
-			case ACPI_TYPE_LOCAL_REGION_FIELD:
-			case ACPI_TYPE_LOCAL_BANK_FIELD:
-			case ACPI_TYPE_LOCAL_INDEX_FIELD:
 
 				/* Valid operand */
 				break;
 
 			default:
 				ACPI_ERROR((AE_INFO,
-					    "Needed [Region/RegionField], found [%s] %p",
+					    "Needed [Region/Buffer], found [%s] %p",
 					    acpi_ut_get_object_type_name
 					    (obj_desc), obj_desc));
 
diff --git a/include/acpi/acopcode.h b/include/acpi/acopcode.h
index 7659a46..d71f5d9 100644
--- a/include/acpi/acopcode.h
+++ b/include/acpi/acopcode.h
@@ -257,7 +257,7 @@
 #define ARGI_LLESSEQUAL_OP              ARGI_INVALID_OPCODE
 #define ARGI_LNOT_OP                    ARGI_LIST1 (ARGI_INTEGER)
 #define ARGI_LNOTEQUAL_OP               ARGI_INVALID_OPCODE
-#define ARGI_LOAD_OP                    ARGI_LIST2 (ARGI_REGION_OR_FIELD,ARGI_TARGETREF)
+#define ARGI_LOAD_OP                    ARGI_LIST2 (ARGI_REGION_OR_BUFFER,ARGI_TARGETREF)
 #define ARGI_LOAD_TABLE_OP              ARGI_LIST6 (ARGI_STRING,     ARGI_STRING,        ARGI_STRING,       ARGI_STRING,    ARGI_STRING, ARGI_ANYTYPE)
 #define ARGI_LOCAL0                     ARG_NONE
 #define ARGI_LOCAL1                     ARG_NONE
diff --git a/include/acpi/amlcode.h b/include/acpi/amlcode.h
index cf18426..fd0c722 100644
--- a/include/acpi/amlcode.h
+++ b/include/acpi/amlcode.h
@@ -273,7 +273,7 @@
 #define ARGI_DATAOBJECT             0x12	/* Buffer, String, package or reference to a Node - Used only by size_of operator */
 #define ARGI_COMPLEXOBJ             0x13	/* Buffer, String, or package (Used by INDEX op only) */
 #define ARGI_REF_OR_STRING          0x14	/* Reference or String (Used by DEREFOF op only) */
-#define ARGI_REGION_OR_FIELD        0x15	/* Used by LOAD op only */
+#define ARGI_REGION_OR_BUFFER       0x15	/* Used by LOAD op only */
 #define ARGI_DATAREFOBJ             0x16
 
 /* Note: types above can expand to 0x1F maximum */
-- 
1.5.0.rc3.39.gec804
