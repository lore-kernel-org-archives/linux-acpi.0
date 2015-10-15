From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/13] ACPICA: Improve typechecking, both compile-time and runtime
Date: Thu, 15 Oct 2015 10:08:20 +0800
Message-ID: <7ad7b9ae97d4b717afc9124fbedd95c4fbbda7eb.1444874756.git.lv.zheng@intel.com>
References: <cover.1444874756.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444874756.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 8d0f96e2a11a4ceabb2cae4b41e0ce1f4d3786b9

Adds much stricter typechecking in the iASL compiler, and
also adds some additional checking in the interpreter.

Link: https://github.com/acpica/acpica/commit/8d0f96e2
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h  |    8 ++-
 drivers/acpi/acpica/acopcode.h |    4 +-
 drivers/acpi/acpica/amlcode.h  |   11 ++--
 drivers/acpi/acpica/exconvrt.c |    1 +
 drivers/acpi/acpica/exresolv.c |    1 -
 drivers/acpi/acpica/exresop.c  |    2 +
 drivers/acpi/acpica/exstore.c  |  120 ++++++++++++++++++++++++++++++----------
 drivers/acpi/acpica/exstoren.c |    5 +-
 drivers/acpi/acpica/nspredef.c |    2 +-
 drivers/acpi/acpica/utdecode.c |   19 ++++++-
 include/acpi/acexcep.h         |    7 ++-
 11 files changed, 134 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 918f70d..4e41b43 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -285,13 +285,17 @@ acpi_status(*acpi_internal_method) (struct acpi_walk_state * walk_state);
 #define ACPI_BTYPE_BUFFER_FIELD         0x00002000
 #define ACPI_BTYPE_DDB_HANDLE           0x00004000
 #define ACPI_BTYPE_DEBUG_OBJECT         0x00008000
-#define ACPI_BTYPE_REFERENCE            0x00010000
+#define ACPI_BTYPE_REFERENCE_OBJECT     0x00010000	/* From Index(), ref_of(), etc (type6_opcodes) */
 #define ACPI_BTYPE_RESOURCE             0x00020000
+#define ACPI_BTYPE_NAMED_REFERENCE      0x00040000	/* Generic unresolved Name or Namepath */
 
 #define ACPI_BTYPE_COMPUTE_DATA         (ACPI_BTYPE_INTEGER | ACPI_BTYPE_STRING | ACPI_BTYPE_BUFFER)
 
 #define ACPI_BTYPE_DATA                 (ACPI_BTYPE_COMPUTE_DATA  | ACPI_BTYPE_PACKAGE)
-#define ACPI_BTYPE_DATA_REFERENCE       (ACPI_BTYPE_DATA | ACPI_BTYPE_REFERENCE | ACPI_BTYPE_DDB_HANDLE)
+
+	/* Used by Copy, de_ref_of, Store, Printf, Fprintf */
+
+#define ACPI_BTYPE_DATA_REFERENCE       (ACPI_BTYPE_DATA | ACPI_BTYPE_REFERENCE_OBJECT | ACPI_BTYPE_DDB_HANDLE)
 #define ACPI_BTYPE_DEVICE_OBJECTS       (ACPI_BTYPE_DEVICE | ACPI_BTYPE_THERMAL | ACPI_BTYPE_PROCESSOR)
 #define ACPI_BTYPE_OBJECTS_AND_REFS     0x0001FFFF	/* ARG or LOCAL */
 #define ACPI_BTYPE_ALL_OBJECTS          0x0000FFFF
diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index fd85ad0..f9acf92 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -211,7 +211,7 @@
 #define ARGI_ARG4                       ARG_NONE
 #define ARGI_ARG5                       ARG_NONE
 #define ARGI_ARG6                       ARG_NONE
-#define ARGI_BANK_FIELD_OP              ARGI_INVALID_OPCODE
+#define ARGI_BANK_FIELD_OP              ARGI_LIST1 (ARGI_INTEGER)
 #define ARGI_BIT_AND_OP                 ARGI_LIST3 (ARGI_INTEGER,    ARGI_INTEGER,       ARGI_TARGETREF)
 #define ARGI_BIT_NAND_OP                ARGI_LIST3 (ARGI_INTEGER,    ARGI_INTEGER,       ARGI_TARGETREF)
 #define ARGI_BIT_NOR_OP                 ARGI_LIST3 (ARGI_INTEGER,    ARGI_INTEGER,       ARGI_TARGETREF)
@@ -307,7 +307,7 @@
 #define ARGI_SLEEP_OP                   ARGI_LIST1 (ARGI_INTEGER)
 #define ARGI_STALL_OP                   ARGI_LIST1 (ARGI_INTEGER)
 #define ARGI_STATICSTRING_OP            ARGI_INVALID_OPCODE
-#define ARGI_STORE_OP                   ARGI_LIST2 (ARGI_DATAREFOBJ, ARGI_TARGETREF)
+#define ARGI_STORE_OP                   ARGI_LIST2 (ARGI_DATAREFOBJ, ARGI_STORE_TARGET)
 #define ARGI_STRING_OP                  ARGI_INVALID_OPCODE
 #define ARGI_SUBTRACT_OP                ARGI_LIST3 (ARGI_INTEGER,    ARGI_INTEGER,       ARGI_TARGETREF)
 #define ARGI_THERMAL_ZONE_OP            ARGI_INVALID_OPCODE
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index be9fd00..883f20c 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -277,14 +277,15 @@
 #define ARGI_TARGETREF              0x0F	/* Target, subject to implicit conversion */
 #define ARGI_FIXED_TARGET           0x10	/* Target, no implicit conversion */
 #define ARGI_SIMPLE_TARGET          0x11	/* Name, Local, Arg -- no implicit conversion */
+#define ARGI_STORE_TARGET           0x12	/* Target for store is TARGETREF + package objects */
 
 /* Multiple/complex types */
 
-#define ARGI_DATAOBJECT             0x12	/* Buffer, String, package or reference to a node - Used only by size_of operator */
-#define ARGI_COMPLEXOBJ             0x13	/* Buffer, String, or package (Used by INDEX op only) */
-#define ARGI_REF_OR_STRING          0x14	/* Reference or String (Used by DEREFOF op only) */
-#define ARGI_REGION_OR_BUFFER       0x15	/* Used by LOAD op only */
-#define ARGI_DATAREFOBJ             0x16
+#define ARGI_DATAOBJECT             0x13	/* Buffer, String, package or reference to a node - Used only by size_of operator */
+#define ARGI_COMPLEXOBJ             0x14	/* Buffer, String, or package (Used by INDEX op only) */
+#define ARGI_REF_OR_STRING          0x15	/* Reference or String (Used by DEREFOF op only) */
+#define ARGI_REGION_OR_BUFFER       0x16	/* Used by LOAD op only */
+#define ARGI_DATAREFOBJ             0x17
 
 /* Note: types above can expand to 0x1F maximum */
 
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index 075d654..1e4c5b6 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -618,6 +618,7 @@ acpi_ex_convert_to_target_type(acpi_object_type destination_type,
 		break;
 
 	case ARGI_TARGETREF:
+	case ARGI_STORE_TARGET:
 
 		switch (destination_type) {
 		case ACPI_TYPE_INTEGER:
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index 7b10912..a1afe1a 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -209,7 +209,6 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 					 * (i.e., dereference the package index)
 					 * Delete the ref object, increment the returned object
 					 */
-					acpi_ut_remove_reference(stack_desc);
 					acpi_ut_add_reference(obj_desc);
 					*stack_ptr = obj_desc;
 				} else {
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index d2964af..424442d 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -307,6 +307,8 @@ acpi_ex_resolve_operands(u16 opcode,
 		case ARGI_TARGETREF:	/* Allows implicit conversion rules before store */
 		case ARGI_FIXED_TARGET:	/* No implicit conversion before store to target */
 		case ARGI_SIMPLE_TARGET:	/* Name, Local, or arg - no implicit conversion  */
+		case ARGI_STORE_TARGET:
+
 			/*
 			 * Need an operand of type ACPI_TYPE_LOCAL_REFERENCE
 			 * A Namespace Node is OK as-is
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index a7eee24..c076e91 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -137,7 +137,7 @@ acpi_ex_store(union acpi_operand_object *source_desc,
 		/* Destination is not a Reference object */
 
 		ACPI_ERROR((AE_INFO,
-			    "Target is not a Reference or Constant object - %s [%p]",
+			    "Target is not a Reference or Constant object - [%s] %p",
 			    acpi_ut_get_object_type_name(dest_desc),
 			    dest_desc));
 
@@ -189,7 +189,7 @@ acpi_ex_store(union acpi_operand_object *source_desc,
 		 * displayed and otherwise has no effect -- see ACPI Specification
 		 */
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "**** Write to Debug Object: Object %p %s ****:\n\n",
+				  "**** Write to Debug Object: Object %p [%s] ****:\n\n",
 				  source_desc,
 				  acpi_ut_get_object_type_name(source_desc)));
 
@@ -341,7 +341,7 @@ acpi_ex_store_object_to_index(union acpi_operand_object *source_desc,
 			/* All other types are invalid */
 
 			ACPI_ERROR((AE_INFO,
-				    "Source must be Integer/Buffer/String type, not %s",
+				    "Source must be type [Integer/Buffer/String], found [%s]",
 				    acpi_ut_get_object_type_name(source_desc)));
 			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 		}
@@ -352,8 +352,9 @@ acpi_ex_store_object_to_index(union acpi_operand_object *source_desc,
 		break;
 
 	default:
-		ACPI_ERROR((AE_INFO, "Target is not a Package or BufferField"));
-		status = AE_AML_OPERAND_TYPE;
+		ACPI_ERROR((AE_INFO,
+			    "Target is not of type [Package/BufferField]"));
+		status = AE_AML_TARGET_TYPE;
 		break;
 	}
 
@@ -373,20 +374,20 @@ acpi_ex_store_object_to_index(union acpi_operand_object *source_desc,
  *
  * DESCRIPTION: Store the object to the named object.
  *
- *              The Assignment of an object to a named object is handled here
- *              The value passed in will replace the current value (if any)
- *              with the input value.
+ * The assignment of an object to a named object is handled here.
+ * The value passed in will replace the current value (if any)
+ * with the input value.
  *
- *              When storing into an object the data is converted to the
- *              target object type then stored in the object. This means
- *              that the target object type (for an initialized target) will
- *              not be changed by a store operation. A copy_object can change
- *              the target type, however.
+ * When storing into an object the data is converted to the
+ * target object type then stored in the object. This means
+ * that the target object type (for an initialized target) will
+ * not be changed by a store operation. A copy_object can change
+ * the target type, however.
  *
- *              The implicit_conversion flag is set to NO/FALSE only when
- *              storing to an arg_x -- as per the rules of the ACPI spec.
+ * The implicit_conversion flag is set to NO/FALSE only when
+ * storing to an arg_x -- as per the rules of the ACPI spec.
  *
- *              Assumes parameters are already validated.
+ * Assumes parameters are already validated.
  *
  ******************************************************************************/
 
@@ -408,11 +409,75 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 	target_type = acpi_ns_get_type(node);
 	target_desc = acpi_ns_get_attached_object(node);
 
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Storing %p (%s) to node %p (%s)\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Storing %p [%s] to node %p [%s]\n",
 			  source_desc,
 			  acpi_ut_get_object_type_name(source_desc), node,
 			  acpi_ut_get_type_name(target_type)));
 
+	/* Only limited target types possible for everything except copy_object */
+
+	if (walk_state->opcode != AML_COPY_OP) {
+		/*
+		 * Only copy_object allows all object types to be overwritten. For
+		 * target_ref(s), there are restrictions on the object types that
+		 * are allowed.
+		 *
+		 * Allowable operations/typing for Store:
+		 *
+		 * 1) Simple Store
+		 *      Integer     --> Integer (Named/Local/Arg)
+		 *      String      --> String  (Named/Local/Arg)
+		 *      Buffer      --> Buffer  (Named/Local/Arg)
+		 *      Package     --> Package (Named/Local/Arg)
+		 *
+		 * 2) Store with implicit conversion
+		 *      Integer     --> String or Buffer  (Named)
+		 *      String      --> Integer or Buffer (Named)
+		 *      Buffer      --> Integer or String (Named)
+		 */
+		switch (target_type) {
+		case ACPI_TYPE_PACKAGE:
+			/*
+			 * Here, can only store a package to an existing package.
+			 * Storing a package to a Local/Arg is OK, and handled
+			 * elsewhere.
+			 */
+			if (walk_state->opcode == AML_STORE_OP) {
+				if (source_desc->common.type !=
+				    ACPI_TYPE_PACKAGE) {
+					ACPI_ERROR((AE_INFO,
+						    "Cannot assign type [%s] to [Package] "
+						    "(source must be type Pkg)",
+						    acpi_ut_get_object_type_name
+						    (source_desc)));
+
+					return_ACPI_STATUS(AE_AML_TARGET_TYPE);
+				}
+				break;
+			}
+
+			/* Fallthrough */
+
+		case ACPI_TYPE_DEVICE:
+		case ACPI_TYPE_EVENT:
+		case ACPI_TYPE_MUTEX:
+		case ACPI_TYPE_REGION:
+		case ACPI_TYPE_POWER:
+		case ACPI_TYPE_PROCESSOR:
+		case ACPI_TYPE_THERMAL:
+
+			ACPI_ERROR((AE_INFO,
+				    "Target must be [Buffer/Integer/String/Reference], found [%s] (%4.4s)",
+				    acpi_ut_get_type_name(node->type),
+				    node->name.ascii));
+
+			return_ACPI_STATUS(AE_AML_TARGET_TYPE);
+
+		default:
+			break;
+		}
+	}
+
 	/*
 	 * Resolve the source object to an actual value
 	 * (If it is a reference object)
@@ -425,13 +490,13 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 	/* Do the actual store operation */
 
 	switch (target_type) {
-	case ACPI_TYPE_INTEGER:
-	case ACPI_TYPE_STRING:
-	case ACPI_TYPE_BUFFER:
 		/*
 		 * The simple data types all support implicit source operand
 		 * conversion before the store.
 		 */
+	case ACPI_TYPE_INTEGER:
+	case ACPI_TYPE_STRING:
+	case ACPI_TYPE_BUFFER:
 
 		if ((walk_state->opcode == AML_COPY_OP) || !implicit_conversion) {
 			/*
@@ -467,7 +532,7 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 						       new_desc->common.type);
 
 			ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-					  "Store %s into %s via Convert/Attach\n",
+					  "Store type [%s] into [%s] via Convert/Attach\n",
 					  acpi_ut_get_object_type_name
 					  (source_desc),
 					  acpi_ut_get_object_type_name
@@ -491,15 +556,12 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 
 	default:
 		/*
-		 * No conversions for all other types. Directly store a copy of
-		 * the source object. This is the ACPI spec-defined behavior for
-		 * the copy_object operator.
+		 * copy_object operator: No conversions for all other types.
+		 * Instead, directly store a copy of the source object.
 		 *
-		 * NOTE: For the Store operator, this is a departure from the
-		 * ACPI spec, which states "If conversion is impossible, abort
-		 * the running control method". Instead, this code implements
-		 * "If conversion is impossible, treat the Store operation as
-		 * a CopyObject".
+		 * This is the ACPI spec-defined behavior for the copy_object
+		 * operator. (Note, for this default case, all normal
+		 * Store/Target operations exited above with an error).
 		 */
 		status = acpi_ex_store_direct_to_node(source_desc, node,
 						      walk_state);
diff --git a/drivers/acpi/acpica/exstoren.c b/drivers/acpi/acpica/exstoren.c
index 3101607..d1841de 100644
--- a/drivers/acpi/acpica/exstoren.c
+++ b/drivers/acpi/acpica/exstoren.c
@@ -122,9 +122,10 @@ acpi_ex_resolve_object(union acpi_operand_object **source_desc_ptr,
 			/* Conversion successful but still not a valid type */
 
 			ACPI_ERROR((AE_INFO,
-				    "Cannot assign type %s to %s (must be type Int/Str/Buf)",
+				    "Cannot assign type [%s] to [%s] (must be type Int/Str/Buf)",
 				    acpi_ut_get_object_type_name(source_desc),
 				    acpi_ut_get_type_name(target_type)));
+
 			status = AE_AML_OPERAND_TYPE;
 		}
 		break;
@@ -275,7 +276,7 @@ acpi_ex_store_object_to_object(union acpi_operand_object *source_desc,
 		/*
 		 * All other types come here.
 		 */
-		ACPI_WARNING((AE_INFO, "Store into type %s not implemented",
+		ACPI_WARNING((AE_INFO, "Store into type [%s] not implemented",
 			      acpi_ut_get_object_type_name(dest_desc)));
 
 		status = AE_NOT_IMPLEMENTED;
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 0eb5431..0c20980 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -226,7 +226,7 @@ acpi_ns_check_object_type(struct acpi_evaluate_info *info,
 {
 	union acpi_operand_object *return_object = *return_object_ptr;
 	acpi_status status = AE_OK;
-	char type_buffer[48];	/* Room for 5 types */
+	char type_buffer[96];	/* Room for 10 types */
 
 	/* A Namespace node should not get here, but make sure */
 
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index d452a78..ecaaaff 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -232,12 +232,27 @@ char *acpi_ut_get_type_name(acpi_object_type type)
 
 char *acpi_ut_get_object_type_name(union acpi_operand_object *obj_desc)
 {
+	ACPI_FUNCTION_TRACE(ut_get_object_type_name);
 
 	if (!obj_desc) {
-		return ("[NULL Object Descriptor]");
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Null Object Descriptor\n"));
+		return_PTR("[NULL Object Descriptor]");
 	}
 
-	return (acpi_ut_get_type_name(obj_desc->common.type));
+	/* These descriptor types share a common area */
+
+	if ((ACPI_GET_DESCRIPTOR_TYPE(obj_desc) != ACPI_DESC_TYPE_OPERAND) &&
+	    (ACPI_GET_DESCRIPTOR_TYPE(obj_desc) != ACPI_DESC_TYPE_NAMED)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+				  "Invalid object descriptor type: 0x%2.2X [%s] (%p)\n",
+				  ACPI_GET_DESCRIPTOR_TYPE(obj_desc),
+				  acpi_ut_get_descriptor_name(obj_desc),
+				  obj_desc));
+
+		return_PTR("Invalid object");
+	}
+
+	return_PTR(acpi_ut_get_type_name(obj_desc->common.type));
 }
 
 /*******************************************************************************
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 9f20eb4a..204f581 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -193,8 +193,9 @@ struct acpi_exception_info {
 #define AE_AML_ILLEGAL_ADDRESS          EXCEP_AML (0x0020)
 #define AE_AML_INFINITE_LOOP            EXCEP_AML (0x0021)
 #define AE_AML_UNINITIALIZED_NODE       EXCEP_AML (0x0022)
+#define AE_AML_TARGET_TYPE              EXCEP_AML (0x0023)
 
-#define AE_CODE_AML_MAX                 0x0022
+#define AE_CODE_AML_MAX                 0x0023
 
 /*
  * Internal exceptions used for control
@@ -358,7 +359,9 @@ static const struct acpi_exception_info acpi_gbl_exception_names_aml[] = {
 	EXCEP_TXT("AE_AML_INFINITE_LOOP",
 		  "An apparent infinite AML While loop, method was aborted"),
 	EXCEP_TXT("AE_AML_UNINITIALIZED_NODE",
-		  "A namespace node is uninitialized or unresolved")
+		  "A namespace node is uninitialized or unresolved"),
+	EXCEP_TXT("AE_AML_TARGET_TYPE",
+		  "A target operand of an incorrect type was encountered")
 };
 
 static const struct acpi_exception_info acpi_gbl_exception_names_ctrl[] = {
-- 
1.7.10
