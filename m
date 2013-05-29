From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/7] ACPICA: Add argument typechecking for all predefined ACPI names
Date: Wed, 29 May 2013 10:09:14 +0800
Message-ID: <6075849a48165046c8c1ab25aef528d1a16ef84b.1367913046.git.lv.zheng@intel.com>
References: <cover.1367813690.git.lv.zheng@intel.com> <cover.1367913046.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49150 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934963Ab3E2CJY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 May 2013 22:09:24 -0400
In-Reply-To: <cover.1367913046.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Fully implements typechecking on all incoming arguments for all
predefined names. This ensures that ACPI-related drivers are
passing the correct number of arguments, each of the correct
object type.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/Makefile      |    1 +
 drivers/acpi/acpica/aclocal.h     |   17 ---
 drivers/acpi/acpica/acnamesp.h    |   43 ++++--
 drivers/acpi/acpica/acpredef.h    |    4 +-
 drivers/acpi/acpica/acstruct.h    |   40 +++--
 drivers/acpi/acpica/evgpe.c       |    1 -
 drivers/acpi/acpica/evregion.c    |    2 +-
 drivers/acpi/acpica/hwxface.c     |    6 +-
 drivers/acpi/acpica/nsarguments.c |  294 +++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/nseval.c      |  247 ++++++++++++++++++-------------
 drivers/acpi/acpica/nsinit.c      |    7 +-
 drivers/acpi/acpica/nspredef.c    |  201 ++++++-------------------
 drivers/acpi/acpica/nsprepkg.c    |   76 +++++-----
 drivers/acpi/acpica/nsrepair.c    |   50 +++----
 drivers/acpi/acpica/nsrepair2.c   |   87 +++++------
 drivers/acpi/acpica/nsxfeval.c    |  162 ++++++++++++++++----
 drivers/acpi/acpica/psxface.c     |   14 +-
 drivers/acpi/acpica/rsutils.c     |    2 +-
 drivers/acpi/acpica/uteval.c      |    2 +-
 drivers/acpi/acpica/utpredef.c    |   16 +-
 include/acpi/acconfig.h           |    4 +-
 21 files changed, 800 insertions(+), 476 deletions(-)
 create mode 100644 drivers/acpi/acpica/nsarguments.c

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 7ddf29e..29b3dab 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -83,6 +83,7 @@ acpi-$(ACPI_FUTURE_USAGE) += hwtimer.o
 acpi-y +=		\
 	nsaccess.o	\
 	nsalloc.o	\
+	nsarguments.o	\
 	nsconvert.o	\
 	nsdump.o	\
 	nseval.o	\
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index d5bfbd3..dfed265 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -362,23 +362,6 @@ union acpi_predefined_info {
 
 #pragma pack()
 
-/* Data block used during object validation */
-
-struct acpi_predefined_data {
-	char *pathname;
-	const union acpi_predefined_info *predefined;
-	union acpi_operand_object *parent_package;
-	struct acpi_namespace_node *node;
-	u32 flags;
-	u32 return_btype;
-	u8 node_flags;
-};
-
-/* Defines for Flags field above */
-
-#define ACPI_OBJECT_REPAIRED    1
-#define ACPI_OBJECT_WRAPPED     2
-
 /* Return object auto-repair info */
 
 typedef acpi_status(*acpi_object_converter) (union acpi_operand_object
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index d2e4918..b83dc32 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -223,22 +223,33 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info *info);
 void acpi_ns_exec_module_code_list(void);
 
 /*
- * nspredef - Support for predefined/reserved names
+ * nsarguments - Argument count/type checking for predefined/reserved names
  */
-acpi_status
-acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
-			       u32 user_param_count,
-			       acpi_status return_status,
-			       union acpi_operand_object **return_object);
+void
+acpi_ns_check_argument_count(char *pathname,
+			     struct acpi_namespace_node *node,
+			     u32 user_param_count,
+			     const union acpi_predefined_info *info);
 
 void
-acpi_ns_check_parameter_count(char *pathname,
+acpi_ns_check_acpi_compliance(char *pathname,
 			      struct acpi_namespace_node *node,
-			      u32 user_param_count,
-			      const union acpi_predefined_info *info);
+			      const union acpi_predefined_info *predefined);
+
+void acpi_ns_check_argument_types(struct acpi_evaluate_info *info);
+
+/*
+ * nspredef - Return value checking for predefined/reserved names
+ */
+acpi_status
+acpi_ns_check_return_value(struct acpi_namespace_node *node,
+			   struct acpi_evaluate_info *info,
+			   u32 user_param_count,
+			   acpi_status return_status,
+			   union acpi_operand_object **return_object);
 
 acpi_status
-acpi_ns_check_object_type(struct acpi_predefined_data *data,
+acpi_ns_check_object_type(struct acpi_evaluate_info *info,
 			  union acpi_operand_object **return_object_ptr,
 			  u32 expected_btypes, u32 package_index);
 
@@ -246,7 +257,7 @@ acpi_ns_check_object_type(struct acpi_predefined_data *data,
  * nsprepkg - Validation of predefined name packages
  */
 acpi_status
-acpi_ns_check_package(struct acpi_predefined_data *data,
+acpi_ns_check_package(struct acpi_evaluate_info *info,
 		      union acpi_operand_object **return_object_ptr);
 
 /*
@@ -308,24 +319,24 @@ acpi_ns_get_attached_data(struct acpi_namespace_node *node,
  * predefined methods/objects
  */
 acpi_status
-acpi_ns_simple_repair(struct acpi_predefined_data *data,
+acpi_ns_simple_repair(struct acpi_evaluate_info *info,
 		      u32 expected_btypes,
 		      u32 package_index,
 		      union acpi_operand_object **return_object_ptr);
 
 acpi_status
-acpi_ns_wrap_with_package(struct acpi_predefined_data *data,
+acpi_ns_wrap_with_package(struct acpi_evaluate_info *info,
 			  union acpi_operand_object *original_object,
 			  union acpi_operand_object **obj_desc_ptr);
 
 acpi_status
-acpi_ns_repair_null_element(struct acpi_predefined_data *data,
+acpi_ns_repair_null_element(struct acpi_evaluate_info *info,
 			    u32 expected_btypes,
 			    u32 package_index,
 			    union acpi_operand_object **return_object_ptr);
 
 void
-acpi_ns_remove_null_elements(struct acpi_predefined_data *data,
+acpi_ns_remove_null_elements(struct acpi_evaluate_info *info,
 			     u8 package_type,
 			     union acpi_operand_object *obj_desc);
 
@@ -334,7 +345,7 @@ acpi_ns_remove_null_elements(struct acpi_predefined_data *data,
  * predefined methods/objects
  */
 acpi_status
-acpi_ns_complex_repairs(struct acpi_predefined_data *data,
+acpi_ns_complex_repairs(struct acpi_evaluate_info *info,
 			struct acpi_namespace_node *node,
 			acpi_status validate_status,
 			union acpi_operand_object **return_object_ptr);
diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index b22b709..f600ade 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -128,8 +128,8 @@ enum acpi_return_package_types {
 #define ARG_COUNT_IS_MINIMUM            0x8000
 #define METHOD_MAX_ARG_TYPE             ACPI_TYPE_PACKAGE
 
-#define METHOD_GET_COUNT(arg_list)      (arg_list & METHOD_ARG_MASK)
-#define METHOD_GET_NEXT_ARG(arg_list)   (arg_list >> METHOD_ARG_BIT_WIDTH)
+#define METHOD_GET_ARG_COUNT(arg_list)  ((arg_list) & METHOD_ARG_MASK)
+#define METHOD_GET_NEXT_TYPE(arg_list)  (((arg_list) >>= METHOD_ARG_BIT_WIDTH) & METHOD_ARG_MASK)
 
 /* Macros used to build the predefined info table */
 
diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index 7896d85..fc83c0a 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -178,25 +178,41 @@ union acpi_aml_operands {
 };
 
 /*
- * Structure used to pass object evaluation parameters.
+ * Structure used to pass object evaluation information and parameters.
  * Purpose is to reduce CPU stack use.
  */
 struct acpi_evaluate_info {
-	struct acpi_namespace_node *prefix_node;
-	char *pathname;
-	union acpi_operand_object *obj_desc;
-	union acpi_operand_object **parameters;
-	struct acpi_namespace_node *resolved_node;
-	union acpi_operand_object *return_object;
-	u8 param_count;
-	u8 pass_number;
-	u8 return_object_type;
-	u8 flags;
+	/* The first 3 elements are passed by the caller to acpi_ns_evaluate */
+
+	struct acpi_namespace_node *prefix_node;	/* Input: starting node */
+	char *relative_pathname;	/* Input: path relative to prefix_node */
+	union acpi_operand_object **parameters;	/* Input: argument list */
+
+	struct acpi_namespace_node *node;	/* Resolved node (prefix_node:relative_pathname) */
+	union acpi_operand_object *obj_desc;	/* Object attached to the resolved node */
+	char *full_pathname;	/* Full pathname of the resolved node */
+
+	const union acpi_predefined_info *predefined;	/* Used if Node is a predefined name */
+	union acpi_operand_object *return_object;	/* Object returned from the evaluation */
+	union acpi_operand_object *parent_package;	/* Used if return object is a Package */
+
+	u32 return_flags;	/* Used for return value analysis */
+	u32 return_btype;	/* Bitmapped type of the returned object */
+	u16 param_count;	/* Count of the input argument list */
+	u8 pass_number;		/* Parser pass number */
+	u8 return_object_type;	/* Object type of the returned object */
+	u8 node_flags;		/* Same as Node->Flags */
+	u8 flags;		/* General flags */
 };
 
 /* Values for Flags above */
 
-#define ACPI_IGNORE_RETURN_VALUE        1
+#define ACPI_IGNORE_RETURN_VALUE    1
+
+/* Defines for return_flags field above */
+
+#define ACPI_OBJECT_REPAIRED        1
+#define ACPI_OBJECT_WRAPPED         2
 
 /* Info used by acpi_ns_initialize_devices */
 
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index a493b52..ae50d6c 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -579,7 +579,6 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 					(local_gpe_event_info->dispatch.
 					 method_node)));
 		}
-
 		break;
 
 	default:
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 6555e35..8ae8f5b 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -532,7 +532,7 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
 	}
 
 	info->prefix_node = region_obj2->extra.method_REG;
-	info->pathname = NULL;
+	info->relative_pathname = NULL;
 	info->parameters = args;
 	info->flags = ACPI_IGNORE_RETURN_VALUE;
 
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 04c2e16..f4224e6 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -495,7 +495,7 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 	 * Evaluate the \_Sx namespace object containing the register values
 	 * for this state
 	 */
-	info->pathname =
+	info->relative_pathname =
 	    ACPI_CAST_PTR(char, acpi_gbl_sleep_state_names[sleep_state]);
 	status = acpi_ns_evaluate(info);
 	if (ACPI_FAILURE(status)) {
@@ -506,7 +506,7 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 
 	if (!info->return_object) {
 		ACPI_ERROR((AE_INFO, "No Sleep State object returned from [%s]",
-			    info->pathname));
+			    info->relative_pathname));
 		status = AE_AML_NO_RETURN_VALUE;
 		goto cleanup;
 	}
@@ -565,7 +565,7 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status,
 				"While evaluating Sleep State [%s]",
-				info->pathname));
+				info->relative_pathname));
 	}
 
 	ACPI_FREE(info);
diff --git a/drivers/acpi/acpica/nsarguments.c b/drivers/acpi/acpica/nsarguments.c
new file mode 100644
index 0000000..74b24c8
--- /dev/null
+++ b/drivers/acpi/acpica/nsarguments.c
@@ -0,0 +1,294 @@
+/******************************************************************************
+ *
+ * Module Name: nsarguments - Validation of args for ACPI predefined methods
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2013, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "acpredef.h"
+
+#define _COMPONENT          ACPI_NAMESPACE
+ACPI_MODULE_NAME("nsarguments")
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_check_argument_types
+ *
+ * PARAMETERS:  info            - Method execution information block
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Check the incoming argument count and all argument types
+ *              against the argument type list for a predefined name.
+ *
+ ******************************************************************************/
+void acpi_ns_check_argument_types(struct acpi_evaluate_info *info)
+{
+	u16 arg_type_list;
+	u8 arg_count;
+	u8 arg_type;
+	u8 user_arg_type;
+	u32 i;
+
+	/* If not a predefined name, cannot typecheck args */
+
+	if (!info->predefined) {
+		return;
+	}
+
+	arg_type_list = info->predefined->info.argument_list;
+	arg_count = METHOD_GET_ARG_COUNT(arg_type_list);
+
+	/* Typecheck all arguments */
+
+	for (i = 0; ((i < arg_count) && (i < info->param_count)); i++) {
+		arg_type = METHOD_GET_NEXT_TYPE(arg_type_list);
+		user_arg_type = info->parameters[i]->common.type;
+
+		if (user_arg_type != arg_type) {
+			ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+					      ACPI_WARN_ALWAYS,
+					      "Argument #%u type mismatch - "
+					      "Found [%s], ACPI requires [%s]",
+					      (i + 1),
+					      acpi_ut_get_type_name
+					      (user_arg_type),
+					      acpi_ut_get_type_name(arg_type)));
+		}
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_check_acpi_compliance
+ *
+ * PARAMETERS:  pathname        - Full pathname to the node (for error msgs)
+ *              node            - Namespace node for the method/object
+ *              predefined      - Pointer to entry in predefined name table
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Check that the declared parameter count (in ASL/AML) for a
+ *              predefined name is what is expected (matches what is defined in
+ *              the ACPI specification for this predefined name.)
+ *
+ ******************************************************************************/
+
+void
+acpi_ns_check_acpi_compliance(char *pathname,
+			      struct acpi_namespace_node *node,
+			      const union acpi_predefined_info *predefined)
+{
+	u32 aml_param_count;
+	u32 required_param_count;
+
+	if (!predefined) {
+		return;
+	}
+
+	/* Get the ACPI-required arg count from the predefined info table */
+
+	required_param_count =
+	    METHOD_GET_ARG_COUNT(predefined->info.argument_list);
+
+	/*
+	 * If this object is not a control method, we can check if the ACPI
+	 * spec requires that it be a method.
+	 */
+	if (node->type != ACPI_TYPE_METHOD) {
+		if (required_param_count > 0) {
+
+			/* Object requires args, must be implemented as a method */
+
+			ACPI_BIOS_ERROR_PREDEFINED((AE_INFO, pathname,
+						    ACPI_WARN_ALWAYS,
+						    "Object (%s) must be a control method with %u arguments",
+						    acpi_ut_get_type_name(node->
+									  type),
+						    required_param_count));
+		} else if (!required_param_count
+			   && !predefined->info.expected_btypes) {
+
+			/* Object requires no args and no return value, must be a method */
+
+			ACPI_BIOS_ERROR_PREDEFINED((AE_INFO, pathname,
+						    ACPI_WARN_ALWAYS,
+						    "Object (%s) must be a control method "
+						    "with no arguments and no return value",
+						    acpi_ut_get_type_name(node->
+									  type)));
+		}
+
+		return;
+	}
+
+	/*
+	 * This is a control method.
+	 * Check that the ASL/AML-defined parameter count for this method
+	 * matches the ACPI-required parameter count
+	 *
+	 * Some methods are allowed to have a "minimum" number of args (_SCP)
+	 * because their definition in ACPI has changed over time.
+	 *
+	 * Note: These are BIOS errors in the declaration of the object
+	 */
+	aml_param_count = node->object->method.param_count;
+
+	if (aml_param_count < required_param_count) {
+		ACPI_BIOS_ERROR_PREDEFINED((AE_INFO, pathname, ACPI_WARN_ALWAYS,
+					    "Insufficient arguments - "
+					    "ASL declared %u, ACPI requires %u",
+					    aml_param_count,
+					    required_param_count));
+	} else if ((aml_param_count > required_param_count)
+		   && !(predefined->info.
+			argument_list & ARG_COUNT_IS_MINIMUM)) {
+		ACPI_BIOS_ERROR_PREDEFINED((AE_INFO, pathname, ACPI_WARN_ALWAYS,
+					    "Excess arguments - "
+					    "ASL declared %u, ACPI requires %u",
+					    aml_param_count,
+					    required_param_count));
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_check_argument_count
+ *
+ * PARAMETERS:  pathname        - Full pathname to the node (for error msgs)
+ *              node            - Namespace node for the method/object
+ *              user_param_count - Number of args passed in by the caller
+ *              predefined      - Pointer to entry in predefined name table
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Check that incoming argument count matches the declared
+ *              parameter count (in the ASL/AML) for an object.
+ *
+ ******************************************************************************/
+
+void
+acpi_ns_check_argument_count(char *pathname,
+			     struct acpi_namespace_node *node,
+			     u32 user_param_count,
+			     const union acpi_predefined_info *predefined)
+{
+	u32 aml_param_count;
+	u32 required_param_count;
+
+	if (!predefined) {
+		/*
+		 * Not a predefined name. Check the incoming user argument count
+		 * against the count that is specified in the method/object.
+		 */
+		if (node->type != ACPI_TYPE_METHOD) {
+			if (user_param_count) {
+				ACPI_INFO_PREDEFINED((AE_INFO, pathname,
+						      ACPI_WARN_ALWAYS,
+						      "%u arguments were passed to a non-method ACPI object (%s)",
+						      user_param_count,
+						      acpi_ut_get_type_name
+						      (node->type)));
+			}
+
+			return;
+		}
+
+		/*
+		 * This is a control method. Check the parameter count.
+		 * We can only check the incoming argument count against the
+		 * argument count declared for the method in the ASL/AML.
+		 *
+		 * Emit a message if too few or too many arguments have been passed
+		 * by the caller.
+		 *
+		 * Note: Too many arguments will not cause the method to
+		 * fail. However, the method will fail if there are too few
+		 * arguments and the method attempts to use one of the missing ones.
+		 */
+		aml_param_count = node->object->method.param_count;
+
+		if (user_param_count < aml_param_count) {
+			ACPI_WARN_PREDEFINED((AE_INFO, pathname,
+					      ACPI_WARN_ALWAYS,
+					      "Insufficient arguments - "
+					      "Caller passed %u, method requires %u",
+					      user_param_count,
+					      aml_param_count));
+		} else if (user_param_count > aml_param_count) {
+			ACPI_INFO_PREDEFINED((AE_INFO, pathname,
+					      ACPI_WARN_ALWAYS,
+					      "Excess arguments - "
+					      "Caller passed %u, method requires %u",
+					      user_param_count,
+					      aml_param_count));
+		}
+
+		return;
+	}
+
+	/*
+	 * This is a predefined name. Validate the user-supplied parameter
+	 * count against the ACPI specification. We don't validate against
+	 * the method itself because what is important here is that the
+	 * caller is in conformance with the spec. (The arg count for the
+	 * method was checked against the ACPI spec earlier.)
+	 *
+	 * Some methods are allowed to have a "minimum" number of args (_SCP)
+	 * because their definition in ACPI has changed over time.
+	 */
+	required_param_count =
+	    METHOD_GET_ARG_COUNT(predefined->info.argument_list);
+
+	if (user_param_count < required_param_count) {
+		ACPI_WARN_PREDEFINED((AE_INFO, pathname, ACPI_WARN_ALWAYS,
+				      "Insufficient arguments - "
+				      "Caller passed %u, ACPI requires %u",
+				      user_param_count, required_param_count));
+	} else if ((user_param_count > required_param_count) &&
+		   !(predefined->info.argument_list & ARG_COUNT_IS_MINIMUM)) {
+		ACPI_INFO_PREDEFINED((AE_INFO, pathname, ACPI_WARN_ALWAYS,
+				      "Excess arguments - "
+				      "Caller passed %u, ACPI requires %u",
+				      user_param_count, required_param_count));
+	}
+}
diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index b61db69..18108bc 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -61,7 +61,7 @@ acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
  *
  * PARAMETERS:  info            - Evaluation info block, contains:
  *                  prefix_node     - Prefix or Method/Object Node to execute
- *                  pathname        - Name of method to execute, If NULL, the
+ *                  relative_path   - Name of method to execute, If NULL, the
  *                                    Node is the object to execute
  *                  parameters      - List of parameters to pass to the method,
  *                                    terminated by NULL. Params itself may be
@@ -82,10 +82,9 @@ acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
  *
  ******************************************************************************/
 
-acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
+acpi_status acpi_ns_evaluate(struct acpi_evaluate_info *info)
 {
 	acpi_status status;
-	struct acpi_namespace_node *node;
 
 	ACPI_FUNCTION_TRACE(ns_evaluate);
 
@@ -93,83 +92,138 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Initialize the return value to an invalid object */
-
-	info->return_object = NULL;
-	info->param_count = 0;
-
-	if (!info->resolved_node) {
+	if (!info->node) {
 		/*
-		 * Get the actual namespace node for the target object if we need to.
-		 * Handles these cases:
+		 * Get the actual namespace node for the target object if we
+		 * need to. Handles these cases:
 		 *
-		 * 1) Null node, Pathname (absolute path)
-		 * 2) Node, Pathname (path relative to Node)
-		 * 3) Node, Null Pathname
+		 * 1) Null node, valid pathname from root (absolute path)
+		 * 2) Node and valid pathname (path relative to Node)
+		 * 3) Node, Null pathname
 		 */
-		status = acpi_ns_get_node(info->prefix_node, info->pathname,
-					  ACPI_NS_NO_UPSEARCH,
-					  &info->resolved_node);
+		status =
+		    acpi_ns_get_node(info->prefix_node, info->relative_pathname,
+				     ACPI_NS_NO_UPSEARCH, &info->node);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
 	}
 
 	/*
-	 * For a method alias, we must grab the actual method node so that proper
-	 * scoping context will be established before execution.
+	 * For a method alias, we must grab the actual method node so that
+	 * proper scoping context will be established before execution.
 	 */
-	if (acpi_ns_get_type(info->resolved_node) ==
-	    ACPI_TYPE_LOCAL_METHOD_ALIAS) {
-		info->resolved_node =
+	if (acpi_ns_get_type(info->node) == ACPI_TYPE_LOCAL_METHOD_ALIAS) {
+		info->node =
 		    ACPI_CAST_PTR(struct acpi_namespace_node,
-				  info->resolved_node->object);
+				  info->node->object);
+	}
+
+	/* Complete the info block initialization */
+
+	info->return_object = NULL;
+	info->node_flags = info->node->flags;
+	info->obj_desc = acpi_ns_get_attached_object(info->node);
+
+	ACPI_DEBUG_PRINT((ACPI_DB_NAMES, "%s [%p] Value %p\n",
+			  info->relative_pathname, info->node,
+			  acpi_ns_get_attached_object(info->node)));
+
+	/* Get info if we have a predefined name (_HID, etc.) */
+
+	info->predefined =
+	    acpi_ut_match_predefined_method(info->node->name.ascii);
+
+	/* Get the full pathname to the object, for use in warning messages */
+
+	info->full_pathname = acpi_ns_get_external_pathname(info->node);
+	if (!info->full_pathname) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_NAMES, "%s [%p] Value %p\n", info->pathname,
-			  info->resolved_node,
-			  acpi_ns_get_attached_object(info->resolved_node)));
+	/* Count the number of arguments being passed in */
+
+	info->param_count = 0;
+	if (info->parameters) {
+		while (info->parameters[info->param_count]) {
+			info->param_count++;
+		}
+
+		/* Warn on impossible argument count */
+
+		if (info->param_count > ACPI_METHOD_NUM_ARGS) {
+			ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+					      ACPI_WARN_ALWAYS,
+					      "Excess arguments (%u) - using only %u",
+					      info->param_count,
+					      ACPI_METHOD_NUM_ARGS));
+
+			info->param_count = ACPI_METHOD_NUM_ARGS;
+		}
+	}
+
+	/*
+	 * For predefined names: Check that the declared argument count
+	 * matches the ACPI spec -- otherwise this is a BIOS error.
+	 */
+	acpi_ns_check_acpi_compliance(info->full_pathname, info->node,
+				      info->predefined);
+
+	/*
+	 * For all names: Check that the incoming argument count for
+	 * this method/object matches the actual ASL/AML definition.
+	 */
+	acpi_ns_check_argument_count(info->full_pathname, info->node,
+				     info->param_count, info->predefined);
 
-	node = info->resolved_node;
+	/* For predefined names: Typecheck all incoming arguments */
+
+	acpi_ns_check_argument_types(info);
 
 	/*
-	 * Two major cases here:
+	 * Three major evaluation cases:
 	 *
-	 * 1) The object is a control method -- execute it
-	 * 2) The object is not a method -- just return it's current value
+	 * 1) Object types that cannot be evaluated by definition
+	 * 2) The object is a control method -- execute it
+	 * 3) The object is not a method -- just return it's current value
 	 */
-	if (acpi_ns_get_type(info->resolved_node) == ACPI_TYPE_METHOD) {
+	switch (acpi_ns_get_type(info->node)) {
+	case ACPI_TYPE_DEVICE:
+	case ACPI_TYPE_EVENT:
+	case ACPI_TYPE_MUTEX:
+	case ACPI_TYPE_REGION:
+	case ACPI_TYPE_THERMAL:
+	case ACPI_TYPE_LOCAL_SCOPE:
+		/*
+		 * 1) Disallow evaluation of certain object types. For these,
+		 *    object evaluation is undefined and not supported.
+		 */
+		ACPI_ERROR((AE_INFO,
+			    "%s: Evaluation of object type [%s] is not supported",
+			    info->full_pathname,
+			    acpi_ut_get_type_name(info->node->type)));
+
+		status = AE_TYPE;
+		goto cleanup;
+
+	case ACPI_TYPE_METHOD:
 		/*
-		 * 1) Object is a control method - execute it
+		 * 2) Object is a control method - execute it
 		 */
 
 		/* Verify that there is a method object associated with this node */
 
-		info->obj_desc =
-		    acpi_ns_get_attached_object(info->resolved_node);
 		if (!info->obj_desc) {
 			ACPI_ERROR((AE_INFO,
-				    "Control method has no attached sub-object"));
-			return_ACPI_STATUS(AE_NULL_OBJECT);
+				    "%s: Method has no attached sub-object",
+				    info->full_pathname));
+			status = AE_NULL_OBJECT;
+			goto cleanup;
 		}
 
-		/* Count the number of arguments being passed to the method */
-
-		if (info->parameters) {
-			while (info->parameters[info->param_count]) {
-				if (info->param_count > ACPI_METHOD_MAX_ARG) {
-					return_ACPI_STATUS(AE_LIMIT);
-				}
-				info->param_count++;
-			}
-		}
-
-
-		ACPI_DUMP_PATHNAME(info->resolved_node, "ACPI: Execute Method",
-				   ACPI_LV_INFO, _COMPONENT);
-
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "Method at AML address %p Length %X\n",
+				  "**** Execute method [%s] at AML address %p length %X\n",
+				  info->full_pathname,
 				  info->obj_desc->method.aml_start + 1,
 				  info->obj_desc->method.aml_length - 1));
 
@@ -184,81 +238,61 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 		acpi_ex_enter_interpreter();
 		status = acpi_ps_execute_method(info);
 		acpi_ex_exit_interpreter();
-	} else {
+		break;
+
+	default:
 		/*
-		 * 2) Object is not a method, return its current value
-		 *
-		 * Disallow certain object types. For these, "evaluation" is undefined.
+		 * 3) All other non-method objects -- get the current object value
 		 */
-		switch (info->resolved_node->type) {
-		case ACPI_TYPE_DEVICE:
-		case ACPI_TYPE_EVENT:
-		case ACPI_TYPE_MUTEX:
-		case ACPI_TYPE_REGION:
-		case ACPI_TYPE_THERMAL:
-		case ACPI_TYPE_LOCAL_SCOPE:
-
-			ACPI_ERROR((AE_INFO,
-				    "[%4.4s] Evaluation of object type [%s] is not supported",
-				    info->resolved_node->name.ascii,
-				    acpi_ut_get_type_name(info->resolved_node->
-							  type)));
-
-			return_ACPI_STATUS(AE_TYPE);
-
-		default:
-			break;
-		}
 
 		/*
-		 * Objects require additional resolution steps (e.g., the Node may be
-		 * a field that must be read, etc.) -- we can't just grab the object
-		 * out of the node.
+		 * Some objects require additional resolution steps (e.g., the Node
+		 * may be a field that must be read, etc.) -- we can't just grab
+		 * the object out of the node.
 		 *
 		 * Use resolve_node_to_value() to get the associated value.
 		 *
 		 * NOTE: we can get away with passing in NULL for a walk state because
-		 * resolved_node is guaranteed to not be a reference to either a method
+		 * the Node is guaranteed to not be a reference to either a method
 		 * local or a method argument (because this interface is never called
 		 * from a running method.)
 		 *
 		 * Even though we do not directly invoke the interpreter for object
-		 * resolution, we must lock it because we could access an opregion.
-		 * The opregion access code assumes that the interpreter is locked.
+		 * resolution, we must lock it because we could access an op_region.
+		 * The op_region access code assumes that the interpreter is locked.
 		 */
 		acpi_ex_enter_interpreter();
 
-		/* Function has a strange interface */
+		/* TBD: resolve_node_to_value has a strange interface, fix */
+
+		info->return_object =
+		    ACPI_CAST_PTR(union acpi_operand_object, info->node);
 
 		status =
-		    acpi_ex_resolve_node_to_value(&info->resolved_node, NULL);
+		    acpi_ex_resolve_node_to_value(ACPI_CAST_INDIRECT_PTR
+						  (struct acpi_namespace_node,
+						   &info->return_object), NULL);
 		acpi_ex_exit_interpreter();
 
-		/*
-		 * If acpi_ex_resolve_node_to_value() succeeded, the return value was placed
-		 * in resolved_node.
-		 */
-		if (ACPI_SUCCESS(status)) {
-			status = AE_CTRL_RETURN_VALUE;
-			info->return_object =
-			    ACPI_CAST_PTR(union acpi_operand_object,
-					  info->resolved_node);
-
-			ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
-					  "Returning object %p [%s]\n",
-					  info->return_object,
-					  acpi_ut_get_object_type_name(info->
-								       return_object)));
+		if (ACPI_FAILURE(status)) {
+			goto cleanup;
 		}
+
+		ACPI_DEBUG_PRINT((ACPI_DB_NAMES, "Returned object %p [%s]\n",
+				  info->return_object,
+				  acpi_ut_get_object_type_name(info->
+							       return_object)));
+
+		status = AE_CTRL_RETURN_VALUE;	/* Always has a "return value" */
+		break;
 	}
 
 	/*
-	 * Check input argument count against the ASL-defined count for a method.
-	 * Also check predefined names: argument count and return value against
-	 * the ACPI specification. Some incorrect return value types are repaired.
+	 * For predefined names, check the return value against the ACPI
+	 * specification. Some incorrect return value types are repaired.
 	 */
-	(void)acpi_ns_check_predefined_names(node, info->param_count,
-		status, &info->return_object);
+	(void)acpi_ns_check_return_value(info->node, info, info->param_count,
+					 status, &info->return_object);
 
 	/* Check if there is a return value that must be dealt with */
 
@@ -278,12 +312,15 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 
 	ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
 			  "*** Completed evaluation of object %s ***\n",
-			  info->pathname));
+			  info->relative_pathname));
 
+ cleanup:
 	/*
 	 * Namespace was unlocked by the handling acpi_ns* function, so we
-	 * just return
+	 * just free the pathname and return
 	 */
+	ACPI_FREE(info->full_pathname);
+	info->full_pathname = NULL;
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 46f0f83..23e426f 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -176,7 +176,7 @@ acpi_status acpi_ns_initialize_devices(void)
 	 * part of the ACPI specification.
 	 */
 	info.evaluate_info->prefix_node = acpi_gbl_root_node;
-	info.evaluate_info->pathname = METHOD_NAME__INI;
+	info.evaluate_info->relative_pathname = METHOD_NAME__INI;
 	info.evaluate_info->parameters = NULL;
 	info.evaluate_info->flags = ACPI_IGNORE_RETURN_VALUE;
 
@@ -560,7 +560,7 @@ acpi_ns_init_one_device(acpi_handle obj_handle,
 
 	ACPI_MEMSET(info, 0, sizeof(struct acpi_evaluate_info));
 	info->prefix_node = device_node;
-	info->pathname = METHOD_NAME__INI;
+	info->relative_pathname = METHOD_NAME__INI;
 	info->parameters = NULL;
 	info->flags = ACPI_IGNORE_RETURN_VALUE;
 
@@ -574,8 +574,7 @@ acpi_ns_init_one_device(acpi_handle obj_handle,
 
 		/* Ignore error and move on to next device */
 
-		char *scope_name =
-		    acpi_ns_get_external_pathname(info->resolved_node);
+		char *scope_name = acpi_ns_get_external_pathname(info->node);
 
 		ACPI_EXCEPTION((AE_INFO, status, "during %s._INI execution",
 				scope_name));
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 8a52916..7ab7ddb 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -61,28 +61,29 @@ ACPI_MODULE_NAME("nspredef")
  * There are several areas that are validated:
  *
  *  1) The number of input arguments as defined by the method/object in the
- *      ASL is validated against the ACPI specification.
+ *     ASL is validated against the ACPI specification.
  *  2) The type of the return object (if any) is validated against the ACPI
- *      specification.
+ *     specification.
  *  3) For returned package objects, the count of package elements is
- *      validated, as well as the type of each package element. Nested
- *      packages are supported.
+ *     validated, as well as the type of each package element. Nested
+ *     packages are supported.
  *
  * For any problems found, a warning message is issued.
  *
  ******************************************************************************/
 /* Local prototypes */
 static acpi_status
-acpi_ns_check_reference(struct acpi_predefined_data *data,
+acpi_ns_check_reference(struct acpi_evaluate_info *info,
 			union acpi_operand_object *return_object);
 
 static u32 acpi_ns_get_bitmapped_type(union acpi_operand_object *return_object);
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ns_check_predefined_names
+ * FUNCTION:    acpi_ns_check_return_value
  *
  * PARAMETERS:  node            - Namespace node for the method/object
+ *              info            - Method execution information block
  *              user_param_count - Number of parameters actually passed
  *              return_status   - Status from the object evaluation
  *              return_object_ptr - Pointer to the object returned from the
@@ -90,44 +91,28 @@ static u32 acpi_ns_get_bitmapped_type(union acpi_operand_object *return_object);
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Check an ACPI name for a match in the predefined name list.
+ * DESCRIPTION: Check the value returned from a predefined name.
  *
  ******************************************************************************/
 
 acpi_status
-acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
-			       u32 user_param_count,
-			       acpi_status return_status,
-			       union acpi_operand_object **return_object_ptr)
+acpi_ns_check_return_value(struct acpi_namespace_node *node,
+			   struct acpi_evaluate_info *info,
+			   u32 user_param_count,
+			   acpi_status return_status,
+			   union acpi_operand_object **return_object_ptr)
 {
-	acpi_status status = AE_OK;
+	acpi_status status;
 	const union acpi_predefined_info *predefined;
 	char *pathname;
-	struct acpi_predefined_data *data;
-
-	/* Match the name for this method/object against the predefined list */
-
-	predefined = acpi_ut_match_predefined_method(node->name.ascii);
 
-	/* Get the full pathname to the object, for use in warning messages */
-
-	pathname = acpi_ns_get_external_pathname(node);
-	if (!pathname) {
-		return (AE_OK);	/* Could not get pathname, ignore */
-	}
-
-	/*
-	 * Check that the parameter count for this method matches the ASL
-	 * definition. For predefined names, ensure that both the caller and
-	 * the method itself are in accordance with the ACPI specification.
-	 */
-	acpi_ns_check_parameter_count(pathname, node, user_param_count,
-				      predefined);
+	predefined = info->predefined;
+	pathname = info->full_pathname;
 
 	/* If not a predefined name, we cannot validate the return object */
 
 	if (!predefined) {
-		goto cleanup;
+		return (AE_OK);
 	}
 
 	/*
@@ -135,7 +120,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	 * validate the return object
 	 */
 	if ((return_status != AE_OK) && (return_status != AE_CTRL_RETURN_VALUE)) {
-		goto cleanup;
+		return (AE_OK);
 	}
 
 	/*
@@ -154,25 +139,14 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	if (acpi_gbl_disable_auto_repair ||
 	    (!predefined->info.expected_btypes) ||
 	    (predefined->info.expected_btypes == ACPI_RTYPE_ALL)) {
-		goto cleanup;
-	}
-
-	/* Create the parameter data block for object validation */
-
-	data = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_predefined_data));
-	if (!data) {
-		goto cleanup;
+		return (AE_OK);
 	}
-	data->predefined = predefined;
-	data->node = node;
-	data->node_flags = node->flags;
-	data->pathname = pathname;
 
 	/*
 	 * Check that the type of the main return object is what is expected
 	 * for this predefined name
 	 */
-	status = acpi_ns_check_object_type(data, return_object_ptr,
+	status = acpi_ns_check_object_type(info, return_object_ptr,
 					   predefined->info.expected_btypes,
 					   ACPI_NOT_PACKAGE_ELEMENT);
 	if (ACPI_FAILURE(status)) {
@@ -184,8 +158,8 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	 * Note: Package may have been newly created by call above.
 	 */
 	if ((*return_object_ptr)->common.type == ACPI_TYPE_PACKAGE) {
-		data->parent_package = *return_object_ptr;
-		status = acpi_ns_check_package(data, return_object_ptr);
+		info->parent_package = *return_object_ptr;
+		status = acpi_ns_check_package(info, return_object_ptr);
 		if (ACPI_FAILURE(status)) {
 			goto exit;
 		}
@@ -199,7 +173,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	 * performed on a per-name basis, i.e., the code is specific to
 	 * particular predefined names.
 	 */
-	status = acpi_ns_complex_repairs(data, node, status, return_object_ptr);
+	status = acpi_ns_complex_repairs(info, node, status, return_object_ptr);
 
 exit:
 	/*
@@ -207,112 +181,18 @@ exit:
 	 * or more objects, mark the parent node to suppress further warning
 	 * messages during the next evaluation of the same method/object.
 	 */
-	if (ACPI_FAILURE(status) || (data->flags & ACPI_OBJECT_REPAIRED)) {
+	if (ACPI_FAILURE(status) || (info->return_flags & ACPI_OBJECT_REPAIRED)) {
 		node->flags |= ANOBJ_EVALUATED;
 	}
-	ACPI_FREE(data);
 
-cleanup:
-	ACPI_FREE(pathname);
 	return (status);
 }
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ns_check_parameter_count
- *
- * PARAMETERS:  pathname        - Full pathname to the node (for error msgs)
- *              node            - Namespace node for the method/object
- *              user_param_count - Number of args passed in by the caller
- *              predefined      - Pointer to entry in predefined name table
- *
- * RETURN:      None
- *
- * DESCRIPTION: Check that the declared (in ASL/AML) parameter count for a
- *              predefined name is what is expected (i.e., what is defined in
- *              the ACPI specification for this predefined name.)
- *
- ******************************************************************************/
-
-void
-acpi_ns_check_parameter_count(char *pathname,
-			      struct acpi_namespace_node *node,
-			      u32 user_param_count,
-			      const union acpi_predefined_info *predefined)
-{
-	u32 param_count;
-	u32 required_params_current;
-	u32 required_params_old;
-
-	/* Methods have 0-7 parameters. All other types have zero. */
-
-	param_count = 0;
-	if (node->type == ACPI_TYPE_METHOD) {
-		param_count = node->object->method.param_count;
-	}
-
-	if (!predefined) {
-		/*
-		 * Check the parameter count for non-predefined methods/objects.
-		 *
-		 * Warning if too few or too many arguments have been passed by the
-		 * caller. An incorrect number of arguments may not cause the method
-		 * to fail. However, the method will fail if there are too few
-		 * arguments and the method attempts to use one of the missing ones.
-		 */
-		if (user_param_count < param_count) {
-			ACPI_WARN_PREDEFINED((AE_INFO, pathname,
-					      ACPI_WARN_ALWAYS,
-					      "Insufficient arguments - needs %u, found %u",
-					      param_count, user_param_count));
-		} else if (user_param_count > param_count) {
-			ACPI_WARN_PREDEFINED((AE_INFO, pathname,
-					      ACPI_WARN_ALWAYS,
-					      "Excess arguments - needs %u, found %u",
-					      param_count, user_param_count));
-		}
-		return;
-	}
-
-	/*
-	 * Validate the user-supplied parameter count.
-	 * Allow two different legal argument counts (_SCP, etc.)
-	 */
-	required_params_current =
-	    predefined->info.argument_list & METHOD_ARG_MASK;
-	required_params_old =
-	    predefined->info.argument_list >> METHOD_ARG_BIT_WIDTH;
-
-	if (user_param_count != ACPI_UINT32_MAX) {
-		if ((user_param_count != required_params_current) &&
-		    (user_param_count != required_params_old)) {
-			ACPI_WARN_PREDEFINED((AE_INFO, pathname,
-					      ACPI_WARN_ALWAYS,
-					      "Parameter count mismatch - "
-					      "caller passed %u, ACPI requires %u",
-					      user_param_count,
-					      required_params_current));
-		}
-	}
-
-	/*
-	 * Check that the ASL-defined parameter count is what is expected for
-	 * this predefined name (parameter count as defined by the ACPI
-	 * specification)
-	 */
-	if ((param_count != required_params_current) &&
-	    (param_count != required_params_old)) {
-		ACPI_WARN_PREDEFINED((AE_INFO, pathname, node->flags,
-				      "Parameter count mismatch - ASL declared %u, ACPI requires %u",
-				      param_count, required_params_current));
-	}
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ns_check_object_type
  *
- * PARAMETERS:  data            - Pointer to validation data structure
+ * PARAMETERS:  info            - Method execution information block
  *              return_object_ptr - Pointer to the object returned from the
  *                                evaluation of a method or object
  *              expected_btypes - Bitmap of expected return type(s)
@@ -328,7 +208,7 @@ acpi_ns_check_parameter_count(char *pathname,
  ******************************************************************************/
 
 acpi_status
-acpi_ns_check_object_type(struct acpi_predefined_data *data,
+acpi_ns_check_object_type(struct acpi_evaluate_info *info,
 			  union acpi_operand_object **return_object_ptr,
 			  u32 expected_btypes, u32 package_index)
 {
@@ -340,7 +220,8 @@ acpi_ns_check_object_type(struct acpi_predefined_data *data,
 
 	if (return_object &&
 	    ACPI_GET_DESCRIPTOR_TYPE(return_object) == ACPI_DESC_TYPE_NAMED) {
-		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+				      info->node_flags,
 				      "Invalid return type - Found a Namespace node [%4.4s] type %s",
 				      return_object->node.name.ascii,
 				      acpi_ut_get_type_name(return_object->node.
@@ -356,8 +237,8 @@ acpi_ns_check_object_type(struct acpi_predefined_data *data,
 	 * from all of the predefined names (including elements of returned
 	 * packages)
 	 */
-	data->return_btype = acpi_ns_get_bitmapped_type(return_object);
-	if (data->return_btype == ACPI_RTYPE_ANY) {
+	info->return_btype = acpi_ns_get_bitmapped_type(return_object);
+	if (info->return_btype == ACPI_RTYPE_ANY) {
 
 		/* Not one of the supported objects, must be incorrect */
 		goto type_error_exit;
@@ -365,16 +246,18 @@ acpi_ns_check_object_type(struct acpi_predefined_data *data,
 
 	/* For reference objects, check that the reference type is correct */
 
-	if ((data->return_btype & expected_btypes) == ACPI_RTYPE_REFERENCE) {
-		status = acpi_ns_check_reference(data, return_object);
+	if ((info->return_btype & expected_btypes) == ACPI_RTYPE_REFERENCE) {
+		status = acpi_ns_check_reference(info, return_object);
 		return (status);
 	}
 
 	/* Attempt simple repair of the returned object if necessary */
 
-	status = acpi_ns_simple_repair(data, expected_btypes,
+	status = acpi_ns_simple_repair(info, expected_btypes,
 				       package_index, return_object_ptr);
-	return (status);
+	if (ACPI_SUCCESS(status)) {
+		return (AE_OK);	/* Successful repair */
+	}
 
       type_error_exit:
 
@@ -383,12 +266,14 @@ acpi_ns_check_object_type(struct acpi_predefined_data *data,
 	acpi_ut_get_expected_return_types(type_buffer, expected_btypes);
 
 	if (package_index == ACPI_NOT_PACKAGE_ELEMENT) {
-		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+				      info->node_flags,
 				      "Return type mismatch - found %s, expected %s",
 				      acpi_ut_get_object_type_name
 				      (return_object), type_buffer));
 	} else {
-		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+				      info->node_flags,
 				      "Return Package type mismatch at index %u - "
 				      "found %s, expected %s", package_index,
 				      acpi_ut_get_object_type_name
@@ -402,7 +287,7 @@ acpi_ns_check_object_type(struct acpi_predefined_data *data,
  *
  * FUNCTION:    acpi_ns_check_reference
  *
- * PARAMETERS:  data            - Pointer to validation data structure
+ * PARAMETERS:  info            - Method execution information block
  *              return_object   - Object returned from the evaluation of a
  *                                method or object
  *
@@ -415,7 +300,7 @@ acpi_ns_check_object_type(struct acpi_predefined_data *data,
  ******************************************************************************/
 
 static acpi_status
-acpi_ns_check_reference(struct acpi_predefined_data *data,
+acpi_ns_check_reference(struct acpi_evaluate_info *info,
 			union acpi_operand_object *return_object)
 {
 
@@ -428,7 +313,7 @@ acpi_ns_check_reference(struct acpi_predefined_data *data,
 		return (AE_OK);
 	}
 
-	ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+	ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname, info->node_flags,
 			      "Return type mismatch - unexpected reference object type [%s] %2.2X",
 			      acpi_ut_get_reference_name(return_object),
 			      return_object->reference.class));
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index 77cdd53..ab2a3f4 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -51,12 +51,12 @@ ACPI_MODULE_NAME("nsprepkg")
 
 /* Local prototypes */
 static acpi_status
-acpi_ns_check_package_list(struct acpi_predefined_data *data,
+acpi_ns_check_package_list(struct acpi_evaluate_info *info,
 			   const union acpi_predefined_info *package,
 			   union acpi_operand_object **elements, u32 count);
 
 static acpi_status
-acpi_ns_check_package_elements(struct acpi_predefined_data *data,
+acpi_ns_check_package_elements(struct acpi_evaluate_info *info,
 			       union acpi_operand_object **elements,
 			       u8 type1,
 			       u32 count1,
@@ -66,7 +66,7 @@ acpi_ns_check_package_elements(struct acpi_predefined_data *data,
  *
  * FUNCTION:    acpi_ns_check_package
  *
- * PARAMETERS:  data                - Pointer to validation data structure
+ * PARAMETERS:  info                - Method execution information block
  *              return_object_ptr   - Pointer to the object returned from the
  *                                    evaluation of a method or object
  *
@@ -78,7 +78,7 @@ acpi_ns_check_package_elements(struct acpi_predefined_data *data,
  ******************************************************************************/
 
 acpi_status
-acpi_ns_check_package(struct acpi_predefined_data *data,
+acpi_ns_check_package(struct acpi_evaluate_info *info,
 		      union acpi_operand_object **return_object_ptr)
 {
 	union acpi_operand_object *return_object = *return_object_ptr;
@@ -93,18 +93,18 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 
 	/* The package info for this name is in the next table entry */
 
-	package = data->predefined + 1;
+	package = info->predefined + 1;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
 			  "%s Validating return Package of Type %X, Count %X\n",
-			  data->pathname, package->ret_info.type,
+			  info->full_pathname, package->ret_info.type,
 			  return_object->package.count));
 
 	/*
 	 * For variable-length Packages, we can safely remove all embedded
 	 * and trailing NULL package elements
 	 */
-	acpi_ns_remove_null_elements(data, package->ret_info.type,
+	acpi_ns_remove_null_elements(info, package->ret_info.type,
 				     return_object);
 
 	/* Extract package count and elements array */
@@ -121,7 +121,8 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 			return (AE_OK);
 		}
 
-		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+				      info->node_flags,
 				      "Return Package has no elements (empty)"));
 
 		return (AE_AML_OPERAND_VALUE);
@@ -150,13 +151,13 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 			ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
 					  "%s: Return Package is larger than needed - "
 					  "found %u, expected %u\n",
-					  data->pathname, count,
+					  info->full_pathname, count,
 					  expected_count));
 		}
 
 		/* Validate all elements of the returned package */
 
-		status = acpi_ns_check_package_elements(data, elements,
+		status = acpi_ns_check_package_elements(info, elements,
 							package->ret_info.
 							object_type1,
 							package->ret_info.
@@ -174,7 +175,7 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 		 * elements must be of the same type
 		 */
 		for (i = 0; i < count; i++) {
-			status = acpi_ns_check_object_type(data, elements,
+			status = acpi_ns_check_object_type(info, elements,
 							   package->ret_info.
 							   object_type1, i);
 			if (ACPI_FAILURE(status)) {
@@ -206,7 +207,7 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 				/* These are the required package elements (0, 1, or 2) */
 
 				status =
-				    acpi_ns_check_object_type(data, elements,
+				    acpi_ns_check_object_type(info, elements,
 							      package->
 							      ret_info3.
 							      object_type[i],
@@ -218,7 +219,7 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 				/* These are the optional package elements */
 
 				status =
-				    acpi_ns_check_object_type(data, elements,
+				    acpi_ns_check_object_type(info, elements,
 							      package->
 							      ret_info3.
 							      tail_object_type,
@@ -235,7 +236,7 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 
 		/* First element is the (Integer) revision */
 
-		status = acpi_ns_check_object_type(data, elements,
+		status = acpi_ns_check_object_type(info, elements,
 						   ACPI_RTYPE_INTEGER, 0);
 		if (ACPI_FAILURE(status)) {
 			return (status);
@@ -247,14 +248,14 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 		/* Examine the sub-packages */
 
 		status =
-		    acpi_ns_check_package_list(data, package, elements, count);
+		    acpi_ns_check_package_list(info, package, elements, count);
 		break;
 
 	case ACPI_PTYPE2_PKG_COUNT:
 
 		/* First element is the (Integer) count of sub-packages to follow */
 
-		status = acpi_ns_check_object_type(data, elements,
+		status = acpi_ns_check_object_type(info, elements,
 						   ACPI_RTYPE_INTEGER, 0);
 		if (ACPI_FAILURE(status)) {
 			return (status);
@@ -275,7 +276,7 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 		/* Examine the sub-packages */
 
 		status =
-		    acpi_ns_check_package_list(data, package, elements, count);
+		    acpi_ns_check_package_list(info, package, elements, count);
 		break;
 
 	case ACPI_PTYPE2:
@@ -300,7 +301,7 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 			/* Create the new outer package and populate it */
 
 			status =
-			    acpi_ns_wrap_with_package(data, return_object,
+			    acpi_ns_wrap_with_package(info, return_object,
 						      return_object_ptr);
 			if (ACPI_FAILURE(status)) {
 				return (status);
@@ -316,14 +317,15 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 		/* Examine the sub-packages */
 
 		status =
-		    acpi_ns_check_package_list(data, package, elements, count);
+		    acpi_ns_check_package_list(info, package, elements, count);
 		break;
 
 	default:
 
 		/* Should not get here if predefined info table is correct */
 
-		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+				      info->node_flags,
 				      "Invalid internal return type in table entry: %X",
 				      package->ret_info.type));
 
@@ -336,7 +338,7 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 
 	/* Error exit for the case with an incorrect package count */
 
-	ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+	ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname, info->node_flags,
 			      "Return Package is too small - found %u elements, expected %u",
 			      count, expected_count));
 
@@ -347,7 +349,7 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
  *
  * FUNCTION:    acpi_ns_check_package_list
  *
- * PARAMETERS:  data            - Pointer to validation data structure
+ * PARAMETERS:  info            - Method execution information block
  *              package         - Pointer to package-specific info for method
  *              elements        - Element list of parent package. All elements
  *                                of this list should be of type Package.
@@ -360,7 +362,7 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
  ******************************************************************************/
 
 static acpi_status
-acpi_ns_check_package_list(struct acpi_predefined_data *data,
+acpi_ns_check_package_list(struct acpi_evaluate_info *info,
 			   const union acpi_predefined_info *package,
 			   union acpi_operand_object **elements, u32 count)
 {
@@ -381,11 +383,11 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 	for (i = 0; i < count; i++) {
 		sub_package = *elements;
 		sub_elements = sub_package->package.elements;
-		data->parent_package = sub_package;
+		info->parent_package = sub_package;
 
 		/* Each sub-object must be of type Package */
 
-		status = acpi_ns_check_object_type(data, &sub_package,
+		status = acpi_ns_check_object_type(info, &sub_package,
 						   ACPI_RTYPE_PACKAGE, i);
 		if (ACPI_FAILURE(status)) {
 			return (status);
@@ -393,7 +395,7 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 
 		/* Examine the different types of expected sub-packages */
 
-		data->parent_package = sub_package;
+		info->parent_package = sub_package;
 		switch (package->ret_info.type) {
 		case ACPI_PTYPE2:
 		case ACPI_PTYPE2_PKG_COUNT:
@@ -408,7 +410,7 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 			}
 
 			status =
-			    acpi_ns_check_package_elements(data, sub_elements,
+			    acpi_ns_check_package_elements(info, sub_elements,
 							   package->ret_info.
 							   object_type1,
 							   package->ret_info.
@@ -434,7 +436,7 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 			}
 
 			status =
-			    acpi_ns_check_package_elements(data, sub_elements,
+			    acpi_ns_check_package_elements(info, sub_elements,
 							   package->ret_info.
 							   object_type1,
 							   package->ret_info.
@@ -463,7 +465,7 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 
 			for (j = 0; j < expected_count; j++) {
 				status =
-				    acpi_ns_check_object_type(data,
+				    acpi_ns_check_object_type(info,
 							      &sub_elements[j],
 							      package->
 							      ret_info2.
@@ -487,7 +489,7 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 			/* Check the type of each sub-package element */
 
 			status =
-			    acpi_ns_check_package_elements(data, sub_elements,
+			    acpi_ns_check_package_elements(info, sub_elements,
 							   package->ret_info.
 							   object_type1,
 							   sub_package->package.
@@ -503,7 +505,7 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 			 * First element is the (Integer) count of elements, including
 			 * the count field (the ACPI name is num_elements)
 			 */
-			status = acpi_ns_check_object_type(data, sub_elements,
+			status = acpi_ns_check_object_type(info, sub_elements,
 							   ACPI_RTYPE_INTEGER,
 							   0);
 			if (ACPI_FAILURE(status)) {
@@ -537,7 +539,7 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 			/* Check the type of each sub-package element */
 
 			status =
-			    acpi_ns_check_package_elements(data,
+			    acpi_ns_check_package_elements(info,
 							   (sub_elements + 1),
 							   package->ret_info.
 							   object_type1,
@@ -562,7 +564,7 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 
 	/* The sub-package count was smaller than required */
 
-	ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+	ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname, info->node_flags,
 			      "Return Sub-Package[%u] is too small - found %u elements, expected %u",
 			      i, sub_package->package.count, expected_count));
 
@@ -573,7 +575,7 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
  *
  * FUNCTION:    acpi_ns_check_package_elements
  *
- * PARAMETERS:  data            - Pointer to validation data structure
+ * PARAMETERS:  info            - Method execution information block
  *              elements        - Pointer to the package elements array
  *              type1           - Object type for first group
  *              count1          - Count for first group
@@ -589,7 +591,7 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
  ******************************************************************************/
 
 static acpi_status
-acpi_ns_check_package_elements(struct acpi_predefined_data *data,
+acpi_ns_check_package_elements(struct acpi_evaluate_info *info,
 			       union acpi_operand_object **elements,
 			       u8 type1,
 			       u32 count1,
@@ -605,7 +607,7 @@ acpi_ns_check_package_elements(struct acpi_predefined_data *data,
 	 * The second group can have a count of zero.
 	 */
 	for (i = 0; i < count1; i++) {
-		status = acpi_ns_check_object_type(data, this_element,
+		status = acpi_ns_check_object_type(info, this_element,
 						   type1, i + start_index);
 		if (ACPI_FAILURE(status)) {
 			return (status);
@@ -614,7 +616,7 @@ acpi_ns_check_package_elements(struct acpi_predefined_data *data,
 	}
 
 	for (i = 0; i < count2; i++) {
-		status = acpi_ns_check_object_type(data, this_element,
+		status = acpi_ns_check_object_type(info, this_element,
 						   type2,
 						   (i + count1 + start_index));
 		if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 18f02e4..89caef0 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -130,7 +130,7 @@ static const struct acpi_simple_repair_info acpi_object_repair_info[] = {
  *
  * FUNCTION:    acpi_ns_simple_repair
  *
- * PARAMETERS:  data                - Pointer to validation data structure
+ * PARAMETERS:  info                - Method execution information block
  *              expected_btypes     - Object types expected
  *              package_index       - Index of object within parent package (if
  *                                    applicable - ACPI_NOT_PACKAGE_ELEMENT
@@ -146,7 +146,7 @@ static const struct acpi_simple_repair_info acpi_object_repair_info[] = {
  ******************************************************************************/
 
 acpi_status
-acpi_ns_simple_repair(struct acpi_predefined_data *data,
+acpi_ns_simple_repair(struct acpi_evaluate_info *info,
 		      u32 expected_btypes,
 		      u32 package_index,
 		      union acpi_operand_object **return_object_ptr)
@@ -162,12 +162,12 @@ acpi_ns_simple_repair(struct acpi_predefined_data *data,
 	 * Special repairs for certain names that are in the repair table.
 	 * Check if this name is in the list of repairable names.
 	 */
-	predefined = acpi_ns_match_simple_repair(data->node,
-						 data->return_btype,
+	predefined = acpi_ns_match_simple_repair(info->node,
+						 info->return_btype,
 						 package_index);
 	if (predefined) {
 		if (!return_object) {
-			ACPI_WARN_PREDEFINED((AE_INFO, data->pathname,
+			ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
 					      ACPI_WARN_ALWAYS,
 					      "Missing expected return value"));
 		}
@@ -191,7 +191,7 @@ acpi_ns_simple_repair(struct acpi_predefined_data *data,
 	 * Do not perform simple object repair unless the return type is not
 	 * expected.
 	 */
-	if (data->return_btype & expected_btypes) {
+	if (info->return_btype & expected_btypes) {
 		return (AE_OK);
 	}
 
@@ -211,7 +211,7 @@ acpi_ns_simple_repair(struct acpi_predefined_data *data,
 	 */
 	if (!return_object) {
 		if (expected_btypes && (!(expected_btypes & ACPI_RTYPE_NONE))) {
-			ACPI_WARN_PREDEFINED((AE_INFO, data->pathname,
+			ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
 					      ACPI_WARN_ALWAYS,
 					      "Missing expected return value"));
 
@@ -247,14 +247,14 @@ acpi_ns_simple_repair(struct acpi_predefined_data *data,
 		 * for correct contents (expected object type or types).
 		 */
 		status =
-		    acpi_ns_wrap_with_package(data, return_object, &new_object);
+		    acpi_ns_wrap_with_package(info, return_object, &new_object);
 		if (ACPI_SUCCESS(status)) {
 			/*
 			 * The original object just had its reference count
 			 * incremented for being inserted into the new package.
 			 */
 			*return_object_ptr = new_object;	/* New Package object */
-			data->flags |= ACPI_OBJECT_REPAIRED;
+			info->return_flags |= ACPI_OBJECT_REPAIRED;
 			return (AE_OK);
 		}
 	}
@@ -277,7 +277,7 @@ acpi_ns_simple_repair(struct acpi_predefined_data *data,
 		 * package object as part of the repair, we don't need to
 		 * change the reference count.
 		 */
-		if (!(data->flags & ACPI_OBJECT_WRAPPED)) {
+		if (!(info->return_flags & ACPI_OBJECT_WRAPPED)) {
 			new_object->common.reference_count =
 			    return_object->common.reference_count;
 
@@ -288,14 +288,14 @@ acpi_ns_simple_repair(struct acpi_predefined_data *data,
 
 		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
 				  "%s: Converted %s to expected %s at Package index %u\n",
-				  data->pathname,
+				  info->full_pathname,
 				  acpi_ut_get_object_type_name(return_object),
 				  acpi_ut_get_object_type_name(new_object),
 				  package_index));
 	} else {
 		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
 				  "%s: Converted %s to expected %s\n",
-				  data->pathname,
+				  info->full_pathname,
 				  acpi_ut_get_object_type_name(return_object),
 				  acpi_ut_get_object_type_name(new_object)));
 	}
@@ -304,7 +304,7 @@ acpi_ns_simple_repair(struct acpi_predefined_data *data,
 
 	acpi_ut_remove_reference(return_object);
 	*return_object_ptr = new_object;
-	data->flags |= ACPI_OBJECT_REPAIRED;
+	info->return_flags |= ACPI_OBJECT_REPAIRED;
 	return (AE_OK);
 }
 
@@ -359,7 +359,7 @@ static const struct acpi_simple_repair_info *acpi_ns_match_simple_repair(struct
  *
  * FUNCTION:    acpi_ns_repair_null_element
  *
- * PARAMETERS:  data                - Pointer to validation data structure
+ * PARAMETERS:  info                - Method execution information block
  *              expected_btypes     - Object types expected
  *              package_index       - Index of object within parent package (if
  *                                    applicable - ACPI_NOT_PACKAGE_ELEMENT
@@ -374,7 +374,7 @@ static const struct acpi_simple_repair_info *acpi_ns_match_simple_repair(struct
  ******************************************************************************/
 
 acpi_status
-acpi_ns_repair_null_element(struct acpi_predefined_data *data,
+acpi_ns_repair_null_element(struct acpi_evaluate_info * info,
 			    u32 expected_btypes,
 			    u32 package_index,
 			    union acpi_operand_object **return_object_ptr)
@@ -424,16 +424,16 @@ acpi_ns_repair_null_element(struct acpi_predefined_data *data,
 	/* Set the reference count according to the parent Package object */
 
 	new_object->common.reference_count =
-	    data->parent_package->common.reference_count;
+	    info->parent_package->common.reference_count;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
 			  "%s: Converted NULL package element to expected %s at index %u\n",
-			  data->pathname,
+			  info->full_pathname,
 			  acpi_ut_get_object_type_name(new_object),
 			  package_index));
 
 	*return_object_ptr = new_object;
-	data->flags |= ACPI_OBJECT_REPAIRED;
+	info->return_flags |= ACPI_OBJECT_REPAIRED;
 	return (AE_OK);
 }
 
@@ -441,7 +441,7 @@ acpi_ns_repair_null_element(struct acpi_predefined_data *data,
  *
  * FUNCTION:    acpi_ns_remove_null_elements
  *
- * PARAMETERS:  data                - Pointer to validation data structure
+ * PARAMETERS:  info                - Method execution information block
  *              package_type        - An acpi_return_package_types value
  *              obj_desc            - A Package object
  *
@@ -454,7 +454,7 @@ acpi_ns_repair_null_element(struct acpi_predefined_data *data,
  *****************************************************************************/
 
 void
-acpi_ns_remove_null_elements(struct acpi_predefined_data *data,
+acpi_ns_remove_null_elements(struct acpi_evaluate_info *info,
 			     u8 package_type,
 			     union acpi_operand_object *obj_desc)
 {
@@ -511,7 +511,7 @@ acpi_ns_remove_null_elements(struct acpi_predefined_data *data,
 	if (new_count < count) {
 		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
 				  "%s: Found and removed %u NULL elements\n",
-				  data->pathname, (count - new_count)));
+				  info->full_pathname, (count - new_count)));
 
 		/* NULL terminate list and update the package count */
 
@@ -524,7 +524,7 @@ acpi_ns_remove_null_elements(struct acpi_predefined_data *data,
  *
  * FUNCTION:    acpi_ns_wrap_with_package
  *
- * PARAMETERS:  data                - Pointer to validation data structure
+ * PARAMETERS:  info                - Method execution information block
  *              original_object     - Pointer to the object to repair.
  *              obj_desc_ptr        - The new package object is returned here
  *
@@ -545,7 +545,7 @@ acpi_ns_remove_null_elements(struct acpi_predefined_data *data,
  ******************************************************************************/
 
 acpi_status
-acpi_ns_wrap_with_package(struct acpi_predefined_data *data,
+acpi_ns_wrap_with_package(struct acpi_evaluate_info *info,
 			  union acpi_operand_object *original_object,
 			  union acpi_operand_object **obj_desc_ptr)
 {
@@ -566,12 +566,12 @@ acpi_ns_wrap_with_package(struct acpi_predefined_data *data,
 
 	ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
 			  "%s: Wrapped %s with expected Package object\n",
-			  data->pathname,
+			  info->full_pathname,
 			  acpi_ut_get_object_type_name(original_object)));
 
 	/* Return the new object in the object pointer */
 
 	*obj_desc_ptr = pkg_obj_desc;
-	data->flags |= ACPI_OBJECT_REPAIRED | ACPI_OBJECT_WRAPPED;
+	info->return_flags |= ACPI_OBJECT_REPAIRED | ACPI_OBJECT_WRAPPED;
 	return (AE_OK);
 }
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 149e9b9..39acc4e 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -54,7 +54,7 @@ ACPI_MODULE_NAME("nsrepair2")
  * be repaired on a per-name basis.
  */
 typedef
-acpi_status(*acpi_repair_function) (struct acpi_predefined_data *data,
+acpi_status(*acpi_repair_function) (struct acpi_evaluate_info * info,
 				    union acpi_operand_object
 				    **return_object_ptr);
 
@@ -71,31 +71,31 @@ static const struct acpi_repair_info *acpi_ns_match_complex_repair(struct
 								   *node);
 
 static acpi_status
-acpi_ns_repair_ALR(struct acpi_predefined_data *data,
+acpi_ns_repair_ALR(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr);
 
 static acpi_status
-acpi_ns_repair_CID(struct acpi_predefined_data *data,
+acpi_ns_repair_CID(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr);
 
 static acpi_status
-acpi_ns_repair_FDE(struct acpi_predefined_data *data,
+acpi_ns_repair_FDE(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr);
 
 static acpi_status
-acpi_ns_repair_HID(struct acpi_predefined_data *data,
+acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr);
 
 static acpi_status
-acpi_ns_repair_PSS(struct acpi_predefined_data *data,
+acpi_ns_repair_PSS(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr);
 
 static acpi_status
-acpi_ns_repair_TSS(struct acpi_predefined_data *data,
+acpi_ns_repair_TSS(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr);
 
 static acpi_status
-acpi_ns_check_sorted_list(struct acpi_predefined_data *data,
+acpi_ns_check_sorted_list(struct acpi_evaluate_info *info,
 			  union acpi_operand_object *return_object,
 			  u32 expected_count,
 			  u32 sort_index,
@@ -150,7 +150,7 @@ static const struct acpi_repair_info acpi_ns_repairable_names[] = {
  *
  * FUNCTION:    acpi_ns_complex_repairs
  *
- * PARAMETERS:  data                - Pointer to validation data structure
+ * PARAMETERS:  info                - Method execution information block
  *              node                - Namespace node for the method/object
  *              validate_status     - Original status of earlier validation
  *              return_object_ptr   - Pointer to the object returned from the
@@ -165,7 +165,7 @@ static const struct acpi_repair_info acpi_ns_repairable_names[] = {
  *****************************************************************************/
 
 acpi_status
-acpi_ns_complex_repairs(struct acpi_predefined_data *data,
+acpi_ns_complex_repairs(struct acpi_evaluate_info *info,
 			struct acpi_namespace_node *node,
 			acpi_status validate_status,
 			union acpi_operand_object **return_object_ptr)
@@ -180,7 +180,7 @@ acpi_ns_complex_repairs(struct acpi_predefined_data *data,
 		return (validate_status);
 	}
 
-	status = predefined->repair_function(data, return_object_ptr);
+	status = predefined->repair_function(info, return_object_ptr);
 	return (status);
 }
 
@@ -219,7 +219,7 @@ static const struct acpi_repair_info *acpi_ns_match_complex_repair(struct
  *
  * FUNCTION:    acpi_ns_repair_ALR
  *
- * PARAMETERS:  data                - Pointer to validation data structure
+ * PARAMETERS:  info                - Method execution information block
  *              return_object_ptr   - Pointer to the object returned from the
  *                                    evaluation of a method or object
  *
@@ -231,13 +231,13 @@ static const struct acpi_repair_info *acpi_ns_match_complex_repair(struct
  *****************************************************************************/
 
 static acpi_status
-acpi_ns_repair_ALR(struct acpi_predefined_data *data,
+acpi_ns_repair_ALR(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr)
 {
 	union acpi_operand_object *return_object = *return_object_ptr;
 	acpi_status status;
 
-	status = acpi_ns_check_sorted_list(data, return_object, 2, 1,
+	status = acpi_ns_check_sorted_list(info, return_object, 2, 1,
 					   ACPI_SORT_ASCENDING,
 					   "AmbientIlluminance");
 
@@ -248,7 +248,7 @@ acpi_ns_repair_ALR(struct acpi_predefined_data *data,
  *
  * FUNCTION:    acpi_ns_repair_FDE
  *
- * PARAMETERS:  data                - Pointer to validation data structure
+ * PARAMETERS:  info                - Method execution information block
  *              return_object_ptr   - Pointer to the object returned from the
  *                                    evaluation of a method or object
  *
@@ -262,7 +262,7 @@ acpi_ns_repair_ALR(struct acpi_predefined_data *data,
  *****************************************************************************/
 
 static acpi_status
-acpi_ns_repair_FDE(struct acpi_predefined_data *data,
+acpi_ns_repair_FDE(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr)
 {
 	union acpi_operand_object *return_object = *return_object_ptr;
@@ -285,8 +285,8 @@ acpi_ns_repair_FDE(struct acpi_predefined_data *data,
 		/* We can only repair if we have exactly 5 BYTEs */
 
 		if (return_object->buffer.length != ACPI_FDE_BYTE_BUFFER_SIZE) {
-			ACPI_WARN_PREDEFINED((AE_INFO, data->pathname,
-					      data->node_flags,
+			ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+					      info->node_flags,
 					      "Incorrect return buffer length %u, expected %u",
 					      return_object->buffer.length,
 					      ACPI_FDE_DWORD_BUFFER_SIZE));
@@ -316,7 +316,7 @@ acpi_ns_repair_FDE(struct acpi_predefined_data *data,
 
 		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
 				  "%s Expanded Byte Buffer to expected DWord Buffer\n",
-				  data->pathname));
+				  info->full_pathname));
 		break;
 
 	default:
@@ -328,7 +328,7 @@ acpi_ns_repair_FDE(struct acpi_predefined_data *data,
 	acpi_ut_remove_reference(return_object);
 	*return_object_ptr = buffer_object;
 
-	data->flags |= ACPI_OBJECT_REPAIRED;
+	info->return_flags |= ACPI_OBJECT_REPAIRED;
 	return (AE_OK);
 }
 
@@ -336,7 +336,7 @@ acpi_ns_repair_FDE(struct acpi_predefined_data *data,
  *
  * FUNCTION:    acpi_ns_repair_CID
  *
- * PARAMETERS:  data                - Pointer to validation data structure
+ * PARAMETERS:  info                - Method execution information block
  *              return_object_ptr   - Pointer to the object returned from the
  *                                    evaluation of a method or object
  *
@@ -349,7 +349,7 @@ acpi_ns_repair_FDE(struct acpi_predefined_data *data,
  *****************************************************************************/
 
 static acpi_status
-acpi_ns_repair_CID(struct acpi_predefined_data *data,
+acpi_ns_repair_CID(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr)
 {
 	acpi_status status;
@@ -362,7 +362,7 @@ acpi_ns_repair_CID(struct acpi_predefined_data *data,
 	/* Check for _CID as a simple string */
 
 	if (return_object->common.type == ACPI_TYPE_STRING) {
-		status = acpi_ns_repair_HID(data, return_object_ptr);
+		status = acpi_ns_repair_HID(info, return_object_ptr);
 		return (status);
 	}
 
@@ -379,7 +379,7 @@ acpi_ns_repair_CID(struct acpi_predefined_data *data,
 		original_element = *element_ptr;
 		original_ref_count = original_element->common.reference_count;
 
-		status = acpi_ns_repair_HID(data, element_ptr);
+		status = acpi_ns_repair_HID(info, element_ptr);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
@@ -406,7 +406,7 @@ acpi_ns_repair_CID(struct acpi_predefined_data *data,
  *
  * FUNCTION:    acpi_ns_repair_HID
  *
- * PARAMETERS:  data                - Pointer to validation data structure
+ * PARAMETERS:  info                - Method execution information block
  *              return_object_ptr   - Pointer to the object returned from the
  *                                    evaluation of a method or object
  *
@@ -418,7 +418,7 @@ acpi_ns_repair_CID(struct acpi_predefined_data *data,
  *****************************************************************************/
 
 static acpi_status
-acpi_ns_repair_HID(struct acpi_predefined_data *data,
+acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr)
 {
 	union acpi_operand_object *return_object = *return_object_ptr;
@@ -435,12 +435,13 @@ acpi_ns_repair_HID(struct acpi_predefined_data *data,
 	}
 
 	if (return_object->string.length == 0) {
-		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+				      info->node_flags,
 				      "Invalid zero-length _HID or _CID string"));
 
 		/* Return AE_OK anyway, let driver handle it */
 
-		data->flags |= ACPI_OBJECT_REPAIRED;
+		info->return_flags |= ACPI_OBJECT_REPAIRED;
 		return (AE_OK);
 	}
 
@@ -464,7 +465,7 @@ acpi_ns_repair_HID(struct acpi_predefined_data *data,
 
 		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
 				  "%s: Removed invalid leading asterisk\n",
-				  data->pathname));
+				  info->full_pathname));
 	}
 
 	/*
@@ -488,7 +489,7 @@ acpi_ns_repair_HID(struct acpi_predefined_data *data,
  *
  * FUNCTION:    acpi_ns_repair_TSS
  *
- * PARAMETERS:  data                - Pointer to validation data structure
+ * PARAMETERS:  info                - Method execution information block
  *              return_object_ptr   - Pointer to the object returned from the
  *                                    evaluation of a method or object
  *
@@ -500,7 +501,7 @@ acpi_ns_repair_HID(struct acpi_predefined_data *data,
  *****************************************************************************/
 
 static acpi_status
-acpi_ns_repair_TSS(struct acpi_predefined_data *data,
+acpi_ns_repair_TSS(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr)
 {
 	union acpi_operand_object *return_object = *return_object_ptr;
@@ -515,13 +516,13 @@ acpi_ns_repair_TSS(struct acpi_predefined_data *data,
 	 * In this case, it is best to just return the _TSS package as-is.
 	 * (May, 2011)
 	 */
-	status =
-	    acpi_ns_get_node(data->node, "^_PSS", ACPI_NS_NO_UPSEARCH, &node);
+	status = acpi_ns_get_node(info->node, "^_PSS",
+				  ACPI_NS_NO_UPSEARCH, &node);
 	if (ACPI_SUCCESS(status)) {
 		return (AE_OK);
 	}
 
-	status = acpi_ns_check_sorted_list(data, return_object, 5, 1,
+	status = acpi_ns_check_sorted_list(info, return_object, 5, 1,
 					   ACPI_SORT_DESCENDING,
 					   "PowerDissipation");
 
@@ -532,7 +533,7 @@ acpi_ns_repair_TSS(struct acpi_predefined_data *data,
  *
  * FUNCTION:    acpi_ns_repair_PSS
  *
- * PARAMETERS:  data                - Pointer to validation data structure
+ * PARAMETERS:  info                - Method execution information block
  *              return_object_ptr   - Pointer to the object returned from the
  *                                    evaluation of a method or object
  *
@@ -546,7 +547,7 @@ acpi_ns_repair_TSS(struct acpi_predefined_data *data,
  *****************************************************************************/
 
 static acpi_status
-acpi_ns_repair_PSS(struct acpi_predefined_data *data,
+acpi_ns_repair_PSS(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr)
 {
 	union acpi_operand_object *return_object = *return_object_ptr;
@@ -564,7 +565,7 @@ acpi_ns_repair_PSS(struct acpi_predefined_data *data,
 	 * incorrectly sorted, sort it. We sort by cpu_frequency, since this
 	 * should be proportional to the power.
 	 */
-	status = acpi_ns_check_sorted_list(data, return_object, 6, 0,
+	status = acpi_ns_check_sorted_list(info, return_object, 6, 0,
 					   ACPI_SORT_DESCENDING,
 					   "CpuFrequency");
 	if (ACPI_FAILURE(status)) {
@@ -584,8 +585,8 @@ acpi_ns_repair_PSS(struct acpi_predefined_data *data,
 		obj_desc = elements[1];	/* Index1 = power_dissipation */
 
 		if ((u32) obj_desc->integer.value > previous_value) {
-			ACPI_WARN_PREDEFINED((AE_INFO, data->pathname,
-					      data->node_flags,
+			ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+					      info->node_flags,
 					      "SubPackage[%u,%u] - suspicious power dissipation values",
 					      i - 1, i));
 		}
@@ -601,7 +602,7 @@ acpi_ns_repair_PSS(struct acpi_predefined_data *data,
  *
  * FUNCTION:    acpi_ns_check_sorted_list
  *
- * PARAMETERS:  data                - Pointer to validation data structure
+ * PARAMETERS:  info                - Method execution information block
  *              return_object       - Pointer to the top-level returned object
  *              expected_count      - Minimum length of each sub-package
  *              sort_index          - Sub-package entry to sort on
@@ -617,7 +618,7 @@ acpi_ns_repair_PSS(struct acpi_predefined_data *data,
  *****************************************************************************/
 
 static acpi_status
-acpi_ns_check_sorted_list(struct acpi_predefined_data *data,
+acpi_ns_check_sorted_list(struct acpi_evaluate_info *info,
 			  union acpi_operand_object *return_object,
 			  u32 expected_count,
 			  u32 sort_index,
@@ -689,11 +690,11 @@ acpi_ns_check_sorted_list(struct acpi_predefined_data *data,
 					  outer_element_count, sort_index,
 					  sort_direction);
 
-			data->flags |= ACPI_OBJECT_REPAIRED;
+			info->return_flags |= ACPI_OBJECT_REPAIRED;
 
 			ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
 					  "%s: Repaired unsorted list - now sorted by %s\n",
-					  data->pathname, sort_key_name));
+					  info->full_pathname, sort_key_name));
 			return (AE_OK);
 		}
 
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index fc69949..82bec40 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -187,8 +187,6 @@ acpi_evaluate_object(acpi_handle handle,
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
-	info->pathname = pathname;
-
 	/* Convert and validate the device handle */
 
 	info->prefix_node = acpi_ns_validate_handle(handle);
@@ -198,17 +196,64 @@ acpi_evaluate_object(acpi_handle handle,
 	}
 
 	/*
-	 * If there are parameters to be passed to a control method, the external
-	 * objects must all be converted to internal objects
+	 * Get the actual namespace node for the target object.
+	 * Handles these cases:
+	 *
+	 * 1) Null node, valid pathname from root (absolute path)
+	 * 2) Node and valid pathname (path relative to Node)
+	 * 3) Node, Null pathname
+	 */
+	if ((pathname) && (ACPI_IS_ROOT_PREFIX(pathname[0]))) {
+
+		/* The path is fully qualified, just evaluate by name */
+
+		info->prefix_node = NULL;
+	} else if (!handle) {
+		/*
+		 * A handle is optional iff a fully qualified pathname is specified.
+		 * Since we've already handled fully qualified names above, this is
+		 * an error.
+		 */
+		if (!pathname) {
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+					  "Both Handle and Pathname are NULL"));
+		} else {
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+					  "Null Handle with relative pathname [%s]",
+					  pathname));
+		}
+
+		status = AE_BAD_PARAMETER;
+		goto cleanup;
+	}
+
+	info->relative_pathname = pathname;
+
+	/*
+	 * Convert all external objects passed as arguments to the
+	 * internal version(s).
 	 */
 	if (external_params && external_params->count) {
+		info->param_count = (u16)external_params->count;
+
+		/* Warn on impossible argument count */
+
+		if (info->param_count > ACPI_METHOD_NUM_ARGS) {
+			ACPI_WARN_PREDEFINED((AE_INFO, pathname,
+					      ACPI_WARN_ALWAYS,
+					      "Excess arguments (%u) - using only %u",
+					      info->param_count,
+					      ACPI_METHOD_NUM_ARGS));
+
+			info->param_count = ACPI_METHOD_NUM_ARGS;
+		}
+
 		/*
 		 * Allocate a new parameter block for the internal objects
 		 * Add 1 to count to allow for null terminated internal list
 		 */
-		info->parameters = ACPI_ALLOCATE_ZEROED(((acpi_size)
-							 external_params->
-							 count +
+		info->parameters = ACPI_ALLOCATE_ZEROED(((acpi_size) info->
+							 param_count +
 							 1) * sizeof(void *));
 		if (!info->parameters) {
 			status = AE_NO_MEMORY;
@@ -217,7 +262,7 @@ acpi_evaluate_object(acpi_handle handle,
 
 		/* Convert each external object in the list to an internal object */
 
-		for (i = 0; i < external_params->count; i++) {
+		for (i = 0; i < info->param_count; i++) {
 			status =
 			    acpi_ut_copy_eobject_to_iobject(&external_params->
 							    pointer[i],
@@ -227,43 +272,96 @@ acpi_evaluate_object(acpi_handle handle,
 				goto cleanup;
 			}
 		}
-		info->parameters[external_params->count] = NULL;
+
+		info->parameters[info->param_count] = NULL;
 	}
 
+#if 0
+
 	/*
-	 * Three major cases:
-	 * 1) Fully qualified pathname
-	 * 2) No handle, not fully qualified pathname (error)
-	 * 3) Valid handle
+	 * Begin incoming argument count analysis. Check for too few args
+	 * and too many args.
 	 */
-	if ((pathname) && (ACPI_IS_ROOT_PREFIX(pathname[0]))) {
 
-		/* The path is fully qualified, just evaluate by name */
+	switch (acpi_ns_get_type(info->node)) {
+	case ACPI_TYPE_METHOD:
+
+		/* Check incoming argument count against the method definition */
+
+		if (info->obj_desc->method.param_count > info->param_count) {
+			ACPI_ERROR((AE_INFO,
+				    "Insufficient arguments (%u) - %u are required",
+				    info->param_count,
+				    info->obj_desc->method.param_count));
+
+			status = AE_MISSING_ARGUMENTS;
+			goto cleanup;
+		}
+
+		else if (info->obj_desc->method.param_count < info->param_count) {
+			ACPI_WARNING((AE_INFO,
+				      "Excess arguments (%u) - only %u are required",
+				      info->param_count,
+				      info->obj_desc->method.param_count));
+
+			/* Just pass the required number of arguments */
+
+			info->param_count = info->obj_desc->method.param_count;
+		}
 
-		info->prefix_node = NULL;
-		status = acpi_ns_evaluate(info);
-	} else if (!handle) {
 		/*
-		 * A handle is optional iff a fully qualified pathname is specified.
-		 * Since we've already handled fully qualified names above, this is
-		 * an error
+		 * Any incoming external objects to be passed as arguments to the
+		 * method must be converted to internal objects
 		 */
-		if (!pathname) {
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "Both Handle and Pathname are NULL"));
-		} else {
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "Null Handle with relative pathname [%s]",
-					  pathname));
+		if (info->param_count) {
+			/*
+			 * Allocate a new parameter block for the internal objects
+			 * Add 1 to count to allow for null terminated internal list
+			 */
+			info->parameters = ACPI_ALLOCATE_ZEROED(((acpi_size)
+								 info->
+								 param_count +
+								 1) *
+								sizeof(void *));
+			if (!info->parameters) {
+				status = AE_NO_MEMORY;
+				goto cleanup;
+			}
+
+			/* Convert each external object in the list to an internal object */
+
+			for (i = 0; i < info->param_count; i++) {
+				status =
+				    acpi_ut_copy_eobject_to_iobject
+				    (&external_params->pointer[i],
+				     &info->parameters[i]);
+				if (ACPI_FAILURE(status)) {
+					goto cleanup;
+				}
+			}
+
+			info->parameters[info->param_count] = NULL;
 		}
+		break;
 
-		status = AE_BAD_PARAMETER;
-	} else {
-		/* We have a namespace a node and a possible relative path */
+	default:
 
-		status = acpi_ns_evaluate(info);
+		/* Warn if arguments passed to an object that is not a method */
+
+		if (info->param_count) {
+			ACPI_WARNING((AE_INFO,
+				      "%u arguments were passed to a non-method ACPI object",
+				      info->param_count));
+		}
+		break;
 	}
 
+#endif
+
+	/* Now we can evaluate the object */
+
+	status = acpi_ns_evaluate(info);
+
 	/*
 	 * If we are expecting a return value, and all went well above,
 	 * copy the return value to an external object.
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index f682542..11b99ab 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -125,7 +125,7 @@ static void acpi_ps_start_trace(struct acpi_evaluate_info *info)
 	}
 
 	if ((!acpi_gbl_trace_method_name) ||
-	    (acpi_gbl_trace_method_name != info->resolved_node->name.integer)) {
+	    (acpi_gbl_trace_method_name != info->node->name.integer)) {
 		goto exit;
 	}
 
@@ -170,7 +170,7 @@ static void acpi_ps_stop_trace(struct acpi_evaluate_info *info)
 	}
 
 	if ((!acpi_gbl_trace_method_name) ||
-	    (acpi_gbl_trace_method_name != info->resolved_node->name.integer)) {
+	    (acpi_gbl_trace_method_name != info->node->name.integer)) {
 		goto exit;
 	}
 
@@ -226,15 +226,14 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 
 	/* Validate the Info and method Node */
 
-	if (!info || !info->resolved_node) {
+	if (!info || !info->node) {
 		return_ACPI_STATUS(AE_NULL_ENTRY);
 	}
 
 	/* Init for new method, wait on concurrency semaphore */
 
 	status =
-	    acpi_ds_begin_method_execution(info->resolved_node, info->obj_desc,
-					   NULL);
+	    acpi_ds_begin_method_execution(info->node, info->obj_desc, NULL);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -253,8 +252,7 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
 			  "**** Begin Method Parse/Execute [%4.4s] **** Node=%p Obj=%p\n",
-			  info->resolved_node->name.ascii, info->resolved_node,
-			  info->obj_desc));
+			  info->node->name.ascii, info->node, info->obj_desc));
 
 	/* Create and init a Root Node */
 
@@ -275,7 +273,7 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 		goto cleanup;
 	}
 
-	status = acpi_ds_init_aml_walk(walk_state, op, info->resolved_node,
+	status = acpi_ds_init_aml_walk(walk_state, op, info->node,
 				       info->obj_desc->method.aml_start,
 				       info->obj_desc->method.aml_length, info,
 				       info->pass_number);
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index a44953c..59bdf37 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -736,7 +736,7 @@ acpi_rs_set_srs_method_data(struct acpi_namespace_node *node,
 	}
 
 	info->prefix_node = node;
-	info->pathname = METHOD_NAME__SRS;
+	info->relative_pathname = METHOD_NAME__SRS;
 	info->parameters = args;
 	info->flags = ACPI_IGNORE_RETURN_VALUE;
 
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index c3f3a7e..1673ddd 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -87,7 +87,7 @@ acpi_ut_evaluate_object(struct acpi_namespace_node * prefix_node,
 	}
 
 	info->prefix_node = prefix_node;
-	info->pathname = path;
+	info->relative_pathname = path;
 
 	/* Evaluate the object/method */
 
diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utpredef.c
index 2945947..2b1ce4c 100644
--- a/drivers/acpi/acpica/utpredef.c
+++ b/drivers/acpi/acpica/utpredef.c
@@ -147,6 +147,11 @@ void acpi_ut_get_expected_return_types(char *buffer, u32 expected_btypes)
 	u32 i;
 	u32 j;
 
+	if (!expected_btypes) {
+		ACPI_STRCPY(buffer, "NONE");
+		return;
+	}
+
 	j = 1;
 	buffer[0] = 0;
 	this_rtype = ACPI_RTYPE_INTEGER;
@@ -328,9 +333,7 @@ static u32 acpi_ut_get_argument_types(char *buffer, u16 argument_types)
 
 	/* First field in the types list is the count of args to follow */
 
-	arg_count = (argument_types & METHOD_ARG_MASK);
-	argument_types >>= METHOD_ARG_BIT_WIDTH;
-
+	arg_count = METHOD_GET_ARG_COUNT(argument_types);
 	if (arg_count > METHOD_PREDEF_ARGS_MAX) {
 		printf("**** Invalid argument count (%u) "
 		       "in predefined info structure\n", arg_count);
@@ -340,7 +343,8 @@ static u32 acpi_ut_get_argument_types(char *buffer, u16 argument_types)
 	/* Get each argument from the list, convert to ascii, store to buffer */
 
 	for (i = 0; i < arg_count; i++) {
-		this_argument_type = (argument_types & METHOD_ARG_MASK);
+		this_argument_type = METHOD_GET_NEXT_TYPE(argument_types);
+
 		if (!this_argument_type
 		    || (this_argument_type > METHOD_MAX_ARG_TYPE)) {
 			printf("**** Invalid argument type (%u) "
@@ -351,10 +355,6 @@ static u32 acpi_ut_get_argument_types(char *buffer, u16 argument_types)
 
 		strcat(buffer,
 		       ut_external_type_names[this_argument_type] + sub_index);
-
-		/* Shift to next argument type field */
-
-		argument_types >>= METHOD_ARG_BIT_WIDTH;
 		sub_index = 0;
 	}
 
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 14ceff7..1c16f82 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -219,8 +219,8 @@
  *
  *****************************************************************************/
 
-#define ACPI_DEBUGGER_MAX_ARGS          8	/* Must be max method args + 1 */
-#define ACPI_DB_LINE_BUFFER_SIZE	512
+#define ACPI_DEBUGGER_MAX_ARGS          ACPI_METHOD_NUM_ARGS + 4	/* Max command line arguments */
+#define ACPI_DB_LINE_BUFFER_SIZE        512
 
 #define ACPI_DEBUGGER_COMMAND_PROMPT    '-'
 #define ACPI_DEBUGGER_EXECUTE_PROMPT    '%'
-- 
1.7.10

