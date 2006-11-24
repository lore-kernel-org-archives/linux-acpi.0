From: Len Brown <len.brown@intel.com>
Subject: [PATCH 60/65] ACPICA: Fixes for load() operator.
Date: Fri, 24 Nov 2006 02:19:10 -0500
Message-ID: <11643528201749-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com> <11643527992802-git-send-email-len.brown@intel.com> <11643528001078-git-send-email-len.brown@intel.com> <11643528013509-git-send-email-len.brown@intel.com> <11643528022585-git-send-email-len.brown@intel.com> <11643528032291-git-send-email-len.brown@intel.com> <11643528042439-git-send-email-len.brown@intel.com> <11643528053298-git-send-email-len.brown@intel.com> <11643528062723-git-send-email-len.brown@intel.com> <1164352807227-git-send-email-len.brown@intel.com> <11643528083991-git-send-email-len.brown@intel.com> <1164352808199-git-send-email-len.brown@intel.com> <11643528091601-git-send-email-len.brown@intel.com> <11643528111088-git-send-email-len.brown@intel.com> <11643528124177-git-send-email-len.brown@int
 el.com> <11643528134106-git-send-email-len.brown@intel.com> <11643528141248-git-send-email-len.brown@intel.com> <11643528153363-git-send-email-len.brown@intel.com> <11643528161204-git-send-email-len.brown@intel.com> <11643528173586-git-send-email-len.brown@intel.com> <11643528181135-git-send-email-len.brown@intel.com> <11643528181927-git-send-email-len.brown@intel.com> <1164352819583-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:52563 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934470AbWKXHQW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:22 -0500
In-Reply-To: <1164352819583-git-send-email-len.brown@intel.com>
Message-Id: <a799ea72f1f893ef9e3a46f60b6f310df8bc097c.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Optimized the Load operator in the case where the source operand is an
operation region. Simply map the operation region memory, instead of
performing a bytewise read.

Signed-off-by: Robert Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exconfig.c |  159 +++++++++-----------------------------
 drivers/acpi/executer/exresop.c  |   10 +--
 include/acpi/acopcode.h          |    2 +-
 include/acpi/amlcode.h           |    2 +-
 4 files changed, 42 insertions(+), 131 deletions(-)

diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/executer/exconfig.c
index 20a5ab8..75b54ac 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -119,7 +119,7 @@ acpi_ex_add_table(acpi_native_uint table
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Load an ACPI table
+ * DESCRIPTION: Load an ACPI table from the RSDT/XSDT
  *
  ******************************************************************************/
 
@@ -138,21 +138,7 @@ acpi_ex_load_table_op(struct acpi_walk_s
 
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
@@ -256,7 +242,7 @@ acpi_ex_load_table_op(struct acpi_walk_s
  *
  * FUNCTION:    acpi_ex_load_op
  *
- * PARAMETERS:  obj_desc        - Region or Field where the table will be
+ * PARAMETERS:  obj_desc        - Region or Buffer/Field where the table will be
  *                                obtained
  *              Target          - Where a handle to the table will be stored
  *              walk_state      - Current state
@@ -265,6 +251,12 @@ acpi_ex_load_table_op(struct acpi_walk_s
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
@@ -272,23 +264,27 @@ acpi_ex_load_op(union acpi_operand_objec
 		union acpi_operand_object *target,
 		struct acpi_walk_state *walk_state)
 {
-	acpi_status status;
 	union acpi_operand_object *ddb_handle;
-	union acpi_operand_object *buffer_desc = NULL;
-	struct acpi_table_header *table_ptr = NULL;
+	struct acpi_table_desc table_desc;
 	acpi_native_uint table_index;
-	acpi_physical_address address;
-	struct acpi_table_header table_header;
-	acpi_integer temp;
-	u32 i;
+	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ex_load_op);
 
-	/* Object can be either an op_region or a Field */
+	ACPI_MEMSET(&table_desc, 0, sizeof(struct acpi_table_desc));
+	table_desc.flags = ACPI_TABLE_ORIGIN_ALLOCATED;
+
+	/* Source Object can be either an op_region or a Buffer/Field */
 
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
@@ -304,114 +300,35 @@ acpi_ex_load_op(union acpi_operand_objec
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
 	/*
 	 * Install the new table into the local data structures
 	 */
-	status = acpi_tb_add_table(table_ptr, &table_index);
+	status = acpi_tb_add_table(&table_desc, &table_index);
 	if (ACPI_FAILURE(status)) {
 		goto cleanup;
 	}
@@ -436,13 +353,9 @@ acpi_ex_load_op(union acpi_operand_objec
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
1.4.4.1
