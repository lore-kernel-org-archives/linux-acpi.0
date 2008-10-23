From: Len Brown <lenb@kernel.org>
Subject: [PATCH 115/122] ACPICA: New: Validation for predefined ACPI
 methods/objects
Date: Thu, 23 Oct 2008 02:39:29 -0400
Message-ID: <e8707b340fb5b6313cde784b944a568dfd770ddd.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:40898 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215AbYJWGk1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:27 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K96000TWIJ9YBQ2@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:22 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Validates predefined ACPI objects that appear in the namespace,
at the time they are evaluated. The argument count and the type of
the returned object are validated. The purpose of this validation
is to detect problems with the BIOS-exposed predefined ACPI objects
before the results are returned to the ACPI-related drivers.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/Makefile   |    2 +-
 drivers/acpi/namespace/nseval.c   |   35 ++-
 drivers/acpi/namespace/nsnames.c  |    2 -
 drivers/acpi/namespace/nspredef.c |  900 +++++++++++++++++++++++++++++++++++++
 include/acpi/acdebug.h            |    4 +
 include/acpi/aclocal.h            |   77 ++++
 include/acpi/acnamesp.h           |   16 +
 include/acpi/acpredef.h           |  371 +++++++++++++++
 8 files changed, 1401 insertions(+), 6 deletions(-)
 create mode 100644 drivers/acpi/namespace/nspredef.c
 create mode 100644 include/acpi/acpredef.h

diff --git a/drivers/acpi/namespace/Makefile b/drivers/acpi/namespace/Makefile
index 3f63d36..371a2da 100644
--- a/drivers/acpi/namespace/Makefile
+++ b/drivers/acpi/namespace/Makefile
@@ -5,7 +5,7 @@
 obj-y := nsaccess.o  nsload.o    nssearch.o  nsxfeval.o \
 	 nsalloc.o   nseval.o    nsnames.o   nsutils.o   nsxfname.o \
 	 nsdump.o    nsinit.o    nsobject.o  nswalk.o    nsxfobj.o  \
-	 nsparse.o
+	 nsparse.o   nspredef.o
 
 obj-$(ACPI_FUTURE_USAGE) += nsdumpdv.o
 
diff --git a/drivers/acpi/namespace/nseval.c b/drivers/acpi/namespace/nseval.c
index 42dae12..4cdf03a 100644
--- a/drivers/acpi/namespace/nseval.c
+++ b/drivers/acpi/namespace/nseval.c
@@ -78,6 +78,7 @@ ACPI_MODULE_NAME("nseval")
 acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 {
 	acpi_status status;
+	struct acpi_namespace_node *node;
 
 	ACPI_FUNCTION_TRACE(ns_evaluate);
 
@@ -117,6 +118,8 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 			  info->resolved_node,
 			  acpi_ns_get_attached_object(info->resolved_node)));
 
+	node = info->resolved_node;
+
 	/*
 	 * Two major cases here:
 	 *
@@ -261,9 +264,35 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 		}
 	}
 
-	/*
-	 * Check if there is a return value that must be dealt with
-	 */
+	/* Validation of return values for ACPI-predefined methods and objects */
+
+	if ((status == AE_OK) || (status == AE_CTRL_RETURN_VALUE)) {
+		/*
+		 * If this is the first evaluation, check the return value. This
+		 * ensures that any warnings will only be emitted during the very
+		 * first evaluation of the object.
+		 */
+		if (!(node->flags & ANOBJ_EVALUATED)) {
+			/*
+			 * Check for a predefined ACPI name. If found, validate the
+			 * returned object.
+			 *
+			 * Note: Ignore return status for now, emit warnings if there are
+			 * problems with the returned object. May change later to abort
+			 * the method on invalid return object.
+			 */
+			(void)acpi_ns_check_predefined_names(node,
+							     info->
+							     return_object);
+		}
+
+		/* Mark the node as having been evaluated */
+
+		node->flags |= ANOBJ_EVALUATED;
+	}
+
+	/* Check if there is a return value that must be dealt with */
+
 	if (status == AE_CTRL_RETURN_VALUE) {
 
 		/* If caller does not want the return value, delete it */
diff --git a/drivers/acpi/namespace/nsnames.c b/drivers/acpi/namespace/nsnames.c
index 9c587bd..42a39a7 100644
--- a/drivers/acpi/namespace/nsnames.c
+++ b/drivers/acpi/namespace/nsnames.c
@@ -115,7 +115,6 @@ acpi_ns_build_external_path(struct acpi_namespace_node *node,
 	return (AE_OK);
 }
 
-#ifdef ACPI_DEBUG_OUTPUT
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_get_external_pathname
@@ -163,7 +162,6 @@ char *acpi_ns_get_external_pathname(struct acpi_namespace_node *node)
 
 	return_PTR(name_buffer);
 }
-#endif
 
 /*******************************************************************************
  *
diff --git a/drivers/acpi/namespace/nspredef.c b/drivers/acpi/namespace/nspredef.c
new file mode 100644
index 0000000..0f17cf0
--- /dev/null
+++ b/drivers/acpi/namespace/nspredef.c
@@ -0,0 +1,900 @@
+/******************************************************************************
+ *
+ * Module Name: nspredef - Validation of ACPI predefined methods and objects
+ *              $Revision: 1.1 $
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2008, Intel Corp.
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
+#include <acpi/acnamesp.h>
+#include <acpi/acpredef.h>
+
+#define _COMPONENT          ACPI_NAMESPACE
+ACPI_MODULE_NAME("nspredef")
+
+/*******************************************************************************
+ *
+ * This module validates predefined ACPI objects that appear in the namespace,
+ * at the time they are evaluated (via acpi_evaluate_object). The purpose of this
+ * validation is to detect problems with BIOS-exposed predefined ACPI objects
+ * before the results are returned to the ACPI-related drivers.
+ *
+ * There are several areas that are validated:
+ *
+ *  1) The number of input arguments as defined by the method/object in the
+ *      ASL is validated against the ACPI specification.
+ *  2) The type of the return object (if any) is validated against the ACPI
+ *      specification.
+ *  3) For returned package objects, the count of package elements is
+ *      validated, as well as the type of each package element. Nested
+ *      packages are supported.
+ *
+ * For any problems found, a warning message is issued.
+ *
+ ******************************************************************************/
+/* Local prototypes */
+static acpi_status
+acpi_ns_check_package(char *pathname,
+		      union acpi_operand_object *return_object,
+		      const union acpi_predefined_info *predefined);
+
+static acpi_status
+acpi_ns_check_package_elements(char *pathname,
+			       union acpi_operand_object **elements,
+			       u8 type1, u32 count1, u8 type2, u32 count2);
+
+static acpi_status
+acpi_ns_check_object_type(char *pathname,
+			  union acpi_operand_object *return_object,
+			  u32 expected_btypes, u32 package_index);
+
+static acpi_status
+acpi_ns_check_reference(char *pathname,
+			union acpi_operand_object *return_object);
+
+/*
+ * Names for the types that can be returned by the predefined objects.
+ * Used for warning messages. Must be in the same order as the ACPI_RTYPEs
+ */
+static const char *acpi_rtype_names[] = {
+	"/Integer",
+	"/String",
+	"/Buffer",
+	"/Package",
+	"/Reference",
+};
+
+#define ACPI_NOT_PACKAGE    ACPI_UINT32_MAX
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_check_predefined_names
+ *
+ * PARAMETERS:  Node            - Namespace node for the method/object
+ *              return_object   - Object returned from the evaluation of this
+ *                                method/object
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Check an ACPI name for a match in the predefined name list.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
+			       union acpi_operand_object *return_object)
+{
+	acpi_status status = AE_OK;
+	const union acpi_predefined_info *predefined;
+	char *pathname;
+
+	/* Match the name for this method/object against the predefined list */
+
+	predefined = acpi_ns_check_for_predefined_name(node);
+	if (!predefined) {
+
+		/* Name was not one of the predefined names */
+
+		return (AE_OK);
+	}
+
+	/* Get the full pathname to the object, for use in error messages */
+
+	pathname = acpi_ns_get_external_pathname(node);
+	if (!pathname) {
+		pathname = ACPI_CAST_PTR(char, predefined->info.name);
+	}
+
+	/*
+	 * Check that the parameter count for this method is in accordance
+	 * with the ACPI specification.
+	 */
+	acpi_ns_check_parameter_count(pathname, node, predefined);
+
+	/*
+	 * If there is no return value, check if we require a return value for
+	 * this predefined name. Either one return value is expected, or none,
+	 * for both methods and other objects.
+	 *
+	 * Exit now if there is no return object. Warning if one was expected.
+	 */
+	if (!return_object) {
+		if ((predefined->info.expected_btypes) &&
+		    (!(predefined->info.expected_btypes & ACPI_RTYPE_NONE))) {
+			ACPI_ERROR((AE_INFO,
+				    "%s: Missing expected return value",
+				    pathname));
+
+			status = AE_AML_NO_RETURN_VALUE;
+		}
+		goto exit;
+	}
+
+	/*
+	 * We have a return value, but if one wasn't expected, just exit, this is
+	 * not a problem
+	 *
+	 * For example, if "Implicit return value" is enabled, methods will
+	 * always return a value
+	 */
+	if (!predefined->info.expected_btypes) {
+		goto exit;
+	}
+
+	/*
+	 * Check that the type of the return object is what is expected for
+	 * this predefined name
+	 */
+	status = acpi_ns_check_object_type(pathname, return_object,
+					   predefined->info.expected_btypes,
+					   ACPI_NOT_PACKAGE);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	/* For returned Package objects, check the type of all sub-objects */
+
+	if (ACPI_GET_OBJECT_TYPE(return_object) == ACPI_TYPE_PACKAGE) {
+		status =
+		    acpi_ns_check_package(pathname, return_object, predefined);
+	}
+
+      exit:
+	if (pathname) {
+		ACPI_FREE(pathname);
+	}
+
+	return (status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_check_parameter_count
+ *
+ * PARAMETERS:  Pathname        - Full pathname to the node (for error msgs)
+ *              Node            - Namespace node for the method/object
+ *              Predefined      - Pointer to entry in predefined name table
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Check that the declared (in ASL/AML) parameter count for a
+ *              predefined name is what is expected (i.e., what is defined in
+ *              the ACPI specification for this predefined name.)
+ *
+ ******************************************************************************/
+
+void
+acpi_ns_check_parameter_count(char *pathname,
+			      struct acpi_namespace_node *node,
+			      const union acpi_predefined_info *predefined)
+{
+	u32 param_count;
+	u32 required_params_current;
+	u32 required_params_old;
+
+	/*
+	 * Check that the ASL-defined parameter count is what is expected for
+	 * this predefined name.
+	 *
+	 * Methods have 0-7 parameters. All other types have zero.
+	 */
+	param_count = 0;
+	if (node->type == ACPI_TYPE_METHOD) {
+		param_count = node->object->method.param_count;
+	}
+
+	/* Validate parameter count - allow two different legal counts (_SCP) */
+
+	required_params_current = predefined->info.param_count & 0x0F;
+	required_params_old = predefined->info.param_count >> 4;
+
+	if ((param_count != required_params_current) &&
+	    (param_count != required_params_old)) {
+		ACPI_WARNING((AE_INFO,
+			      "%s: Parameter count mismatch - ASL declared %d, expected %d",
+			      pathname, param_count, required_params_current));
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_check_for_predefined_name
+ *
+ * PARAMETERS:  Node            - Namespace node for the method/object
+ *
+ * RETURN:      Pointer to entry in predefined table. NULL indicates not found.
+ *
+ * DESCRIPTION: Check an object name against the predefined object list.
+ *
+ ******************************************************************************/
+
+const union acpi_predefined_info *acpi_ns_check_for_predefined_name(struct
+								    acpi_namespace_node
+								    *node)
+{
+	const union acpi_predefined_info *this_name;
+
+	/* Quick check for a predefined name, first character must be underscore */
+
+	if (node->name.ascii[0] != '_') {
+		return (NULL);
+	}
+
+	/* Search info table for a predefined method/object name */
+
+	this_name = predefined_names;
+	while (this_name->info.name[0]) {
+		if (ACPI_COMPARE_NAME(node->name.ascii, this_name->info.name)) {
+
+			/* Return pointer to this table entry */
+
+			return (this_name);
+		}
+
+		/*
+		 * Skip next entry in the table if this name returns a Package
+		 * (next entry contains the package info)
+		 */
+		if (this_name->info.expected_btypes & ACPI_RTYPE_PACKAGE) {
+			this_name++;
+		}
+
+		this_name++;
+	}
+
+	return (NULL);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_check_package
+ *
+ * PARAMETERS:  Pathname        - Full pathname to the node (for error msgs)
+ *              return_object   - Object returned from the evaluation of a
+ *                                method or object
+ *              Predefined      - Pointer to entry in predefined name table
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Check a returned package object for the correct count and
+ *              correct type of all sub-objects.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_ns_check_package(char *pathname,
+		      union acpi_operand_object *return_object,
+		      const union acpi_predefined_info *predefined)
+{
+	const union acpi_predefined_info *package;
+	union acpi_operand_object *sub_package;
+	union acpi_operand_object **elements;
+	union acpi_operand_object **sub_elements;
+	acpi_status status;
+	u32 expected_count;
+	u32 count;
+	u32 i;
+	u32 j;
+
+	ACPI_FUNCTION_NAME(ns_check_package);
+
+	/* The package info for this name is in the next table entry */
+
+	package = predefined + 1;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
+			  "%s Validating return Package of Type %X, Count %X\n",
+			  pathname, package->ret_info.type,
+			  return_object->package.count));
+
+	/* Extract package count and elements array */
+
+	elements = return_object->package.elements;
+	count = return_object->package.count;
+
+	/* The package must have at least one element, else invalid */
+
+	if (!count) {
+		ACPI_WARNING((AE_INFO,
+			      "%s: Return Package has no elements (empty)",
+			      pathname));
+
+		return (AE_AML_OPERAND_VALUE);
+	}
+
+	/*
+	 * Decode the type of the expected package contents
+	 *
+	 * PTYPE1 packages contain no subpackages
+	 * PTYPE2 packages contain sub-packages
+	 */
+	switch (package->ret_info.type) {
+	case ACPI_PTYPE1_FIXED:
+
+		/*
+		 * The package count is fixed and there are no sub-packages
+		 *
+		 * If package is too small, exit.
+		 * If package is larger than expected, issue warning but continue
+		 */
+		expected_count =
+		    package->ret_info.count1 + package->ret_info.count2;
+		if (count < expected_count) {
+			goto package_too_small;
+		} else if (count > expected_count) {
+			ACPI_WARNING((AE_INFO,
+				      "%s: Return Package is larger than needed - "
+				      "found %u, expected %u", pathname, count,
+				      expected_count));
+		}
+
+		/* Validate all elements of the returned package */
+
+		status = acpi_ns_check_package_elements(pathname, elements,
+							package->ret_info.
+							object_type1,
+							package->ret_info.
+							count1,
+							package->ret_info.
+							object_type2,
+							package->ret_info.
+							count2);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+		break;
+
+	case ACPI_PTYPE1_VAR:
+
+		/*
+		 * The package count is variable, there are no sub-packages, and all
+		 * elements must be of the same type
+		 */
+		for (i = 0; i < count; i++) {
+			status = acpi_ns_check_object_type(pathname, *elements,
+							   package->ret_info.
+							   object_type1, i);
+			if (ACPI_FAILURE(status)) {
+				return (status);
+			}
+			elements++;
+		}
+		break;
+
+	case ACPI_PTYPE1_OPTION:
+
+		/*
+		 * The package count is variable, there are no sub-packages. There are
+		 * a fixed number of required elements, and a variable number of
+		 * optional elements.
+		 *
+		 * Check if package is at least as large as the minimum required
+		 */
+		expected_count = package->ret_info3.count;
+		if (count < expected_count) {
+			goto package_too_small;
+		}
+
+		/* Variable number of sub-objects */
+
+		for (i = 0; i < count; i++) {
+			if (i < package->ret_info3.count) {
+
+				/* These are the required package elements (0, 1, or 2) */
+
+				status =
+				    acpi_ns_check_object_type(pathname,
+							      *elements,
+							      package->
+							      ret_info3.
+							      object_type[i],
+							      i);
+				if (ACPI_FAILURE(status)) {
+					return (status);
+				}
+			} else {
+				/* These are the optional package elements */
+
+				status =
+				    acpi_ns_check_object_type(pathname,
+							      *elements,
+							      package->
+							      ret_info3.
+							      tail_object_type,
+							      i);
+				if (ACPI_FAILURE(status)) {
+					return (status);
+				}
+			}
+			elements++;
+		}
+		break;
+
+	case ACPI_PTYPE2_PKG_COUNT:
+
+		/* First element is the (Integer) count of sub-packages to follow */
+
+		status = acpi_ns_check_object_type(pathname, *elements,
+						   ACPI_RTYPE_INTEGER, 0);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+
+		/*
+		 * Count cannot be larger than the parent package length, but allow it
+		 * to be smaller. The >= accounts for the Integer above.
+		 */
+		expected_count = (u32) (*elements)->integer.value;
+		if (expected_count >= count) {
+			goto package_too_small;
+		}
+
+		count = expected_count;
+		elements++;
+
+		/* Now we can walk the sub-packages */
+
+		/*lint -fallthrough */
+
+	case ACPI_PTYPE2:
+	case ACPI_PTYPE2_FIXED:
+	case ACPI_PTYPE2_MIN:
+	case ACPI_PTYPE2_COUNT:
+
+		/*
+		 * These types all return a single package that consists of a variable
+		 * number of sub-packages
+		 */
+		for (i = 0; i < count; i++) {
+			sub_package = *elements;
+			sub_elements = sub_package->package.elements;
+
+			/* Each sub-object must be of type Package */
+
+			status =
+			    acpi_ns_check_object_type(pathname, sub_package,
+						      ACPI_RTYPE_PACKAGE, i);
+			if (ACPI_FAILURE(status)) {
+				return (status);
+			}
+
+			/* Examine the different types of sub-packages */
+
+			switch (package->ret_info.type) {
+			case ACPI_PTYPE2:
+			case ACPI_PTYPE2_PKG_COUNT:
+
+				/* Each subpackage has a fixed number of elements */
+
+				expected_count =
+				    package->ret_info.count1 +
+				    package->ret_info.count2;
+				if (sub_package->package.count !=
+				    expected_count) {
+					count = sub_package->package.count;
+					goto package_too_small;
+				}
+
+				status =
+				    acpi_ns_check_package_elements(pathname,
+								   sub_elements,
+								   package->
+								   ret_info.
+								   object_type1,
+								   package->
+								   ret_info.
+								   count1,
+								   package->
+								   ret_info.
+								   object_type2,
+								   package->
+								   ret_info.
+								   count2);
+				if (ACPI_FAILURE(status)) {
+					return (status);
+				}
+				break;
+
+			case ACPI_PTYPE2_FIXED:
+
+				/* Each sub-package has a fixed length */
+
+				expected_count = package->ret_info2.count;
+				if (sub_package->package.count < expected_count) {
+					count = sub_package->package.count;
+					goto package_too_small;
+				}
+
+				/* Check the type of each sub-package element */
+
+				for (j = 0; j < expected_count; j++) {
+					status =
+					    acpi_ns_check_object_type(pathname,
+								      sub_elements
+								      [j],
+								      package->
+								      ret_info2.
+								      object_type
+								      [j], j);
+					if (ACPI_FAILURE(status)) {
+						return (status);
+					}
+				}
+				break;
+
+			case ACPI_PTYPE2_MIN:
+
+				/* Each sub-package has a variable but minimum length */
+
+				expected_count = package->ret_info.count1;
+				if (sub_package->package.count < expected_count) {
+					count = sub_package->package.count;
+					goto package_too_small;
+				}
+
+				/* Check the type of each sub-package element */
+
+				status =
+				    acpi_ns_check_package_elements(pathname,
+								   sub_elements,
+								   package->
+								   ret_info.
+								   object_type1,
+								   sub_package->
+								   package.
+								   count, 0, 0);
+				if (ACPI_FAILURE(status)) {
+					return (status);
+				}
+				break;
+
+			case ACPI_PTYPE2_COUNT:
+
+				/* First element is the (Integer) count of elements to follow */
+
+				status =
+				    acpi_ns_check_object_type(pathname,
+							      *sub_elements,
+							      ACPI_RTYPE_INTEGER,
+							      0);
+				if (ACPI_FAILURE(status)) {
+					return (status);
+				}
+
+				/* Make sure package is large enough for the Count */
+
+				expected_count =
+				    (u32) (*sub_elements)->integer.value;
+				if (sub_package->package.count < expected_count) {
+					count = sub_package->package.count;
+					goto package_too_small;
+				}
+
+				/* Check the type of each sub-package element */
+
+				status =
+				    acpi_ns_check_package_elements(pathname,
+								   (sub_elements
+								    + 1),
+								   package->
+								   ret_info.
+								   object_type1,
+								   (expected_count
+								    - 1), 0, 0);
+				if (ACPI_FAILURE(status)) {
+					return (status);
+				}
+				break;
+
+			default:
+				break;
+			}
+
+			elements++;
+		}
+		break;
+
+	default:
+
+		/* Should not get here if predefined info table is correct */
+
+		ACPI_WARNING((AE_INFO,
+			      "%s: Invalid internal return type in table entry: %X",
+			      pathname, package->ret_info.type));
+
+		return (AE_AML_INTERNAL);
+	}
+
+	return (AE_OK);
+
+      package_too_small:
+
+	/* Error exit for the case with an incorrect package count */
+
+	ACPI_WARNING((AE_INFO, "%s: Return Package is too small - "
+		      "found %u, expected %u", pathname, count,
+		      expected_count));
+
+	return (AE_AML_OPERAND_VALUE);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_check_package_elements
+ *
+ * PARAMETERS:  Pathname        - Full pathname to the node (for error msgs)
+ *              Elements        - Pointer to the package elements array
+ *              Type1           - Object type for first group
+ *              Count1          - Count for first group
+ *              Type2           - Object type for second group
+ *              Count2          - Count for second group
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Check that all elements of a package are of the correct object
+ *              type. Supports up to two groups of different object types.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_ns_check_package_elements(char *pathname,
+			       union acpi_operand_object **elements,
+			       u8 type1, u32 count1, u8 type2, u32 count2)
+{
+	union acpi_operand_object **this_element = elements;
+	acpi_status status;
+	u32 i;
+
+	/*
+	 * Up to two groups of package elements are supported by the data
+	 * structure. All elements in each group must be of the same type.
+	 * The second group can have a count of zero.
+	 */
+	for (i = 0; i < count1; i++) {
+		status = acpi_ns_check_object_type(pathname, *this_element,
+						   type1, i);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+		this_element++;
+	}
+
+	for (i = 0; i < count2; i++) {
+		status = acpi_ns_check_object_type(pathname, *this_element,
+						   type2, (i + count1));
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+		this_element++;
+	}
+
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_check_object_type
+ *
+ * PARAMETERS:  Pathname        - Full pathname to the node (for error msgs)
+ *              return_object   - Object return from the execution of this
+ *                                method/object
+ *              expected_btypes - Bitmap of expected return type(s)
+ *              package_index   - Index of object within parent package (if
+ *                                applicable - ACPI_NOT_PACKAGE otherwise)
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Check the type of the return object against the expected object
+ *              type(s). Use of Btype allows multiple expected object types.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_ns_check_object_type(char *pathname,
+			  union acpi_operand_object *return_object,
+			  u32 expected_btypes, u32 package_index)
+{
+	acpi_status status = AE_OK;
+	u32 return_btype;
+	char type_buffer[48];	/* Room for 5 types */
+	u32 this_rtype;
+	u32 i;
+	u32 j;
+
+	/*
+	 * If we get a NULL return_object here, it is a NULL package element,
+	 * and this is always an error.
+	 */
+	if (!return_object) {
+		goto type_error_exit;
+	}
+
+	/* A Namespace node should not get here, but make sure */
+
+	if (ACPI_GET_DESCRIPTOR_TYPE(return_object) == ACPI_DESC_TYPE_NAMED) {
+		ACPI_WARNING((AE_INFO,
+			      "%s: Invalid return type - Found a Namespace node [%4.4s] type %s",
+			      pathname, return_object->node.name.ascii,
+			      acpi_ut_get_type_name(return_object->node.type)));
+		return (AE_AML_OPERAND_TYPE);
+	}
+
+	/*
+	 * Convert the object type (ACPI_TYPE_xxx) to a bitmapped object type.
+	 * The bitmapped type allows multiple possible return types.
+	 *
+	 * Note, the cases below must handle all of the possible types returned
+	 * from all of the predefined names (including elements of returned
+	 * packages)
+	 */
+	switch (ACPI_GET_OBJECT_TYPE(return_object)) {
+	case ACPI_TYPE_INTEGER:
+		return_btype = ACPI_RTYPE_INTEGER;
+		break;
+
+	case ACPI_TYPE_BUFFER:
+		return_btype = ACPI_RTYPE_BUFFER;
+		break;
+
+	case ACPI_TYPE_STRING:
+		return_btype = ACPI_RTYPE_STRING;
+		break;
+
+	case ACPI_TYPE_PACKAGE:
+		return_btype = ACPI_RTYPE_PACKAGE;
+		break;
+
+	case ACPI_TYPE_LOCAL_REFERENCE:
+		return_btype = ACPI_RTYPE_REFERENCE;
+		break;
+
+	default:
+		/* Not one of the supported objects, must be incorrect */
+
+		goto type_error_exit;
+	}
+
+	/* Is the object one of the expected types? */
+
+	if (!(return_btype & expected_btypes)) {
+		goto type_error_exit;
+	}
+
+	/* For reference objects, check that the reference type is correct */
+
+	if (ACPI_GET_OBJECT_TYPE(return_object) == ACPI_TYPE_LOCAL_REFERENCE) {
+		status = acpi_ns_check_reference(pathname, return_object);
+	}
+
+	return (status);
+
+      type_error_exit:
+
+	/* Create a string with all expected types for this predefined object */
+
+	j = 1;
+	type_buffer[0] = 0;
+	this_rtype = ACPI_RTYPE_INTEGER;
+
+	for (i = 0; i < ACPI_NUM_RTYPES; i++) {
+
+		/* If one of the expected types, concatenate the name of this type */
+
+		if (expected_btypes & this_rtype) {
+			ACPI_STRCAT(type_buffer, &acpi_rtype_names[i][j]);
+			j = 0;	/* Use name separator from now on */
+		}
+		this_rtype <<= 1;	/* Next Rtype */
+	}
+
+	if (package_index == ACPI_NOT_PACKAGE) {
+		ACPI_WARNING((AE_INFO,
+			      "%s: Return type mismatch - found %s, expected %s",
+			      pathname,
+			      acpi_ut_get_object_type_name(return_object),
+			      type_buffer));
+	} else {
+		ACPI_WARNING((AE_INFO,
+			      "%s: Return Package type mismatch at index %u - "
+			      "found %s, expected %s", pathname, package_index,
+			      acpi_ut_get_object_type_name(return_object),
+			      type_buffer));
+	}
+
+	return (AE_AML_OPERAND_TYPE);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_check_reference
+ *
+ * PARAMETERS:  Pathname        - Full pathname to the node (for error msgs)
+ *              return_object   - Object returned from the evaluation of a
+ *                                method or object
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Check a returned reference object for the correct reference
+ *              type. The only reference type that can be returned from a
+ *              predefined method is a named reference. All others are invalid.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_ns_check_reference(char *pathname,
+			union acpi_operand_object *return_object)
+{
+
+	/*
+	 * Check the reference object for the correct reference type (opcode).
+	 * The only type of reference that can be converted to an union acpi_object is
+	 * a reference to a named object (reference class: NAME)
+	 */
+	if (return_object->reference.class == ACPI_REFCLASS_NAME) {
+		return (AE_OK);
+	}
+
+	ACPI_WARNING((AE_INFO,
+		      "%s: Return type mismatch - unexpected reference object type [%s] %2.2X",
+		      pathname, acpi_ut_get_reference_name(return_object),
+		      return_object->reference.class));
+
+	return (AE_AML_OPERAND_TYPE);
+}
diff --git a/include/acpi/acdebug.h b/include/acpi/acdebug.h
index a4fb001..62c59df 100644
--- a/include/acpi/acdebug.h
+++ b/include/acpi/acdebug.h
@@ -154,6 +154,10 @@ void
 acpi_db_display_argument_object(union acpi_operand_object *obj_desc,
 				struct acpi_walk_state *walk_state);
 
+void acpi_db_check_predefined_names(void);
+
+void acpi_db_batch_execute(void);
+
 /*
  * dbexec - debugger control method execution
  */
diff --git a/include/acpi/aclocal.h b/include/acpi/aclocal.h
index b221c85..ecab527 100644
--- a/include/acpi/aclocal.h
+++ b/include/acpi/aclocal.h
@@ -208,6 +208,7 @@ struct acpi_namespace_node {
 #define ANOBJ_METHOD_ARG                0x04	/* Node is a method argument */
 #define ANOBJ_METHOD_LOCAL              0x08	/* Node is a method local */
 #define ANOBJ_SUBTREE_HAS_INI           0x10	/* Used to optimize device initialization */
+#define ANOBJ_EVALUATED                 0x20	/* Set on first evaluation of node */
 
 #define ANOBJ_IS_EXTERNAL               0x08	/* i_aSL only: This object created via External() */
 #define ANOBJ_METHOD_NO_RETVAL          0x10	/* i_aSL only: Method has no return value */
@@ -340,6 +341,82 @@ acpi_status(*ACPI_INTERNAL_METHOD) (struct acpi_walk_state * walk_state);
 #define ACPI_BTYPE_OBJECTS_AND_REFS     0x0001FFFF	/* ARG or LOCAL */
 #define ACPI_BTYPE_ALL_OBJECTS          0x0000FFFF
 
+/*
+ * Information structure for ACPI predefined names.
+ * Each entry in the table contains the following items:
+ *
+ * Name                 - The ACPI reserved name
+ * param_count          - Number of arguments to the method
+ * expected_return_btypes - Allowed type(s) for the return value
+ */
+struct acpi_name_info {
+	char name[ACPI_NAME_SIZE];
+	u8 param_count;
+	u8 expected_btypes;
+};
+
+/*
+ * Secondary information structures for ACPI predefined objects that return
+ * package objects. This structure appears as the next entry in the table
+ * after the NAME_INFO structure above.
+ *
+ * The reason for this is to minimize the size of the predefined name table.
+ */
+
+/*
+ * Used for ACPI_PTYPE1_FIXED, ACPI_PTYPE1_VAR, ACPI_PTYPE2,
+ * ACPI_PTYPE2_MIN, ACPI_PTYPE2_PKG_COUNT, ACPI_PTYPE2_COUNT
+ */
+struct acpi_package_info {
+	u8 type;
+	u8 object_type1;
+	u8 count1;
+	u8 object_type2;
+	u8 count2;
+	u8 reserved;
+};
+
+/* Used for ACPI_PTYPE2_FIXED */
+
+struct acpi_package_info2 {
+	u8 type;
+	u8 count;
+	u8 object_type[4];
+};
+
+/* Used for ACPI_PTYPE1_OPTION */
+
+struct acpi_package_info3 {
+	u8 type;
+	u8 count;
+	u8 object_type[2];
+	u8 tail_object_type;
+	u8 reserved;
+};
+
+union acpi_predefined_info {
+	struct acpi_name_info info;
+	struct acpi_package_info ret_info;
+	struct acpi_package_info2 ret_info2;
+	struct acpi_package_info3 ret_info3;
+};
+
+/*
+ * Bitmapped return value types
+ * Note: the actual data types must be contiguous, a loop in nspredef.c
+ * depends on this.
+ */
+#define ACPI_RTYPE_ANY                  0x00
+#define ACPI_RTYPE_NONE                 0x01
+#define ACPI_RTYPE_INTEGER              0x02
+#define ACPI_RTYPE_STRING               0x04
+#define ACPI_RTYPE_BUFFER               0x08
+#define ACPI_RTYPE_PACKAGE              0x10
+#define ACPI_RTYPE_REFERENCE            0x20
+#define ACPI_RTYPE_ALL                  0x3F
+
+#define ACPI_NUM_RTYPES                 5	/* Number of actual object types */
+
 /*****************************************************************************
  *
  * Event typedefs and structs
diff --git a/include/acpi/acnamesp.h b/include/acpi/acnamesp.h
index c340085..db4e6f6 100644
--- a/include/acpi/acnamesp.h
+++ b/include/acpi/acnamesp.h
@@ -178,6 +178,22 @@ acpi_ns_dump_objects(acpi_object_type type,
 acpi_status acpi_ns_evaluate(struct acpi_evaluate_info *info);
 
 /*
+ * nspredef - Support for predefined/reserved names
+ */
+acpi_status
+acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
+			       union acpi_operand_object *return_object);
+
+const union acpi_predefined_info *acpi_ns_check_for_predefined_name(struct
+								    acpi_namespace_node
+								    *node);
+
+void
+acpi_ns_check_parameter_count(char *pathname,
+			      struct acpi_namespace_node *node,
+			      const union acpi_predefined_info *info);
+
+/*
  * nsnames - Name and Scope manipulation
  */
 u32 acpi_ns_opens_scope(acpi_object_type type);
diff --git a/include/acpi/acpredef.h b/include/acpi/acpredef.h
new file mode 100644
index 0000000..619fb75
--- /dev/null
+++ b/include/acpi/acpredef.h
@@ -0,0 +1,371 @@
+/******************************************************************************
+ *
+ * Name: acpredef - Information table for ACPI predefined methods and objects
+ *              $Revision: 1.1 $
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2008, Intel Corp.
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
+#ifndef __ACPREDEF_H__
+#define __ACPREDEF_H__
+
+/******************************************************************************
+ *
+ * Return Package types
+ *
+ * 1) PTYPE1 packages do not contain sub-packages.
+ *
+ * ACPI_PTYPE1_FIXED: Fixed length, 1 or 2 object types:
+ *     object type
+ *     count
+ *     object type
+ *     count
+ *
+ * ACPI_PTYPE1_VAR: Variable length:
+ *    object type (Int/Buf/Ref)
+ *
+ * ACPI_PTYPE1_OPTION: Package has some required and some optional elements:
+ *      Used for _PRW
+ *
+ *
+ * 2) PTYPE2 packages contain a variable number of sub-packages. Each of the
+ *    different types describe the contents of each of the sub-packages.
+ *
+ * ACPI_PTYPE2: Each subpackage contains 1 or 2 object types:
+ *     object type
+ *     count
+ *     object type
+ *     count
+ *
+ * ACPI_PTYPE2_COUNT: Each subpackage has a count as first element:
+ *     object type
+ *
+ * ACPI_PTYPE2_PKG_COUNT: Count of subpackages at start, 1 or 2 object types:
+ *     object type
+ *     count
+ *     object type
+ *     count
+ *
+ * ACPI_PTYPE2_FIXED: Each subpackage is of fixed length:
+ *      Used for _PRT
+ *
+ * ACPI_PTYPE2_MIN: Each subpackage has a variable but minimum length
+ *      Used for _HPX
+ *
+ *****************************************************************************/
+
+enum acpi_return_package_types {
+	ACPI_PTYPE1_FIXED = 1,
+	ACPI_PTYPE1_VAR = 2,
+	ACPI_PTYPE1_OPTION = 3,
+	ACPI_PTYPE2 = 4,
+	ACPI_PTYPE2_COUNT = 5,
+	ACPI_PTYPE2_PKG_COUNT = 6,
+	ACPI_PTYPE2_FIXED = 7,
+	ACPI_PTYPE2_MIN = 8
+};
+
+/*
+ * Predefined method/object information table.
+ *
+ * These are the names that can actually be evaluated via acpi_evaluate_object.
+ * Not present in this table are the following:
+ *
+ *      1) Predefined/Reserved names that are never evaluated via acpi_evaluate_object:
+ *          _Lxx and _Exx GPE methods
+ *          _Qxx EC methods
+ *          _T_x compiler temporary variables
+ *
+ *      2) Predefined names that never actually exist within the AML code:
+ *          Predefined resource descriptor field names
+ *
+ *      3) Predefined names that are implemented within ACPICA:
+ *          _OSI
+ *
+ *      4) Some predefined names that are not documented within the ACPI spec.
+ *          _WDG, _WED
+ *
+ * The main entries in the table each contain the following items:
+ *
+ * Name                 - The ACPI reserved name
+ * param_count          - Number of arguments to the method
+ * expected_btypes      - Allowed type(s) for the return value.
+ *                        0 means that no return value is expected.
+ *
+ * For methods that return packages, the next entry in the table contains
+ * information about the expected structure of the package. This information
+ * is saved here (rather than in a separate table) in order to minimize the
+ * overall size of the stored data.
+ */
+static const union acpi_predefined_info predefined_names[] = {
+	{.info = {"_AC0", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_AC1", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_AC2", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_AC3", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_AC4", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_AC5", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_AC6", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_AC7", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_AC8", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_AC9", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_ADR", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_AL0", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0}},	/* variable (Refs) */
+	{.info = {"_AL1", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0}},	/* variable (Refs) */
+	{.info = {"_AL2", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0}},	/* variable (Refs) */
+	{.info = {"_AL3", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0}},	/* variable (Refs) */
+	{.info = {"_AL4", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0}},	/* variable (Refs) */
+	{.info = {"_AL5", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0}},	/* variable (Refs) */
+	{.info = {"_AL6", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0}},	/* variable (Refs) */
+	{.info = {"_AL7", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0}},	/* variable (Refs) */
+	{.info = {"_AL8", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0}},	/* variable (Refs) */
+	{.info = {"_AL9", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0}},	/* variable (Refs) */
+	{.info = {"_ALC", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_ALI", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_ALP", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_ALR", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE2, ACPI_RTYPE_INTEGER, 2, 0, 0, 0}},	/* variable (Pkgs) each 2 (Ints) */
+	{.info = {"_ALT", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_BBN", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_BCL", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 0, 0, 0, 0}},	/* variable (Ints) */
+	{.info = {"_BCM", 1, 0}},
+	{.info = {"_BDN", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_BFS", 1, 0}},
+	{.info = {"_BIF", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER,
+					  9,
+					  ACPI_RTYPE_STRING, 4, 0}},	/* fixed (9 Int),(4 Str) */
+	{.info = {"_BLT", 3, 0}},
+	{.info = {"_BMC", 1, 0}},
+	{.info = {"_BMD", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 5, 0, 0, 0}},	/* fixed (5 Int) */
+	{.info = {"_BQC", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_BST", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 4, 0, 0, 0}},	/* fixed (4 Int) */
+	{.info = {"_BTM", 1, ACPI_RTYPE_INTEGER}},
+	{.info = {"_BTP", 1, 0}},
+	{.info = {"_CBA", 0, ACPI_RTYPE_INTEGER}},	/* see PCI firmware spec 3.0 */
+	{.info = {"_CID", 0,
+	 ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING | ACPI_RTYPE_PACKAGE}},
+	{.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING, 0, 0, 0, 0}},	/* variable (Ints/Strs) */
+	{.info = {"_CRS", 0, ACPI_RTYPE_BUFFER}},
+	{.info = {"_CRT", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_CSD", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE2_COUNT, ACPI_RTYPE_INTEGER, 0, 0, 0, 0}},	/* variable (1 Int(n), n-1 Int) */
+	{.info = {"_CST", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE2_PKG_COUNT,
+					  ACPI_RTYPE_BUFFER, 1,
+					  ACPI_RTYPE_INTEGER, 3, 0}},	/* variable (1 Int(n), n Pkg (1 Buf/3 Int) */
+	{.info = {"_DCK", 1, ACPI_RTYPE_INTEGER}},
+	{.info = {"_DCS", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_DDC", 1, ACPI_RTYPE_INTEGER | ACPI_RTYPE_BUFFER}},
+	{.info = {"_DDN", 0, ACPI_RTYPE_STRING}},
+	{.info = {"_DGS", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_DIS", 0, 0}},
+	{.info = {"_DMA", 0, ACPI_RTYPE_BUFFER}},
+	{.info = {"_DOD", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 0, 0, 0, 0}},	/* variable (Ints) */
+	{.info = {"_DOS", 1, 0}},
+	{.info = {"_DSM", 4, ACPI_RTYPE_ALL}},	/* Must return a type, but it can be of any type */
+	{.info = {"_DSS", 1, 0}},
+	{.info = {"_DSW", 3, 0}},
+	{.info = {"_EC_", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_EDL", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0}},	/* variable (Refs) */
+	{.info = {"_EJ0", 1, 0}},
+	{.info = {"_EJ1", 1, 0}},
+	{.info = {"_EJ2", 1, 0}},
+	{.info = {"_EJ3", 1, 0}},
+	{.info = {"_EJ4", 1, 0}},
+	{.info = {"_EJD", 0, ACPI_RTYPE_STRING}},
+	{.info = {"_FDE", 0, ACPI_RTYPE_BUFFER}},
+	{.info = {"_FDI", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 16, 0, 0, 0}},	/* fixed (16 Int) */
+	{.info = {"_FDM", 1, 0}},
+	{.info = {"_FIX", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 0, 0, 0, 0}},	/* variable (Ints) */
+	{.info = {"_GLK", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_GPD", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_GPE", 0, ACPI_RTYPE_INTEGER}},	/* _GPE method, not _GPE scope */
+	{.info = {"_GSB", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_GTF", 0, ACPI_RTYPE_BUFFER}},
+	{.info = {"_GTM", 0, ACPI_RTYPE_BUFFER}},
+	{.info = {"_GTS", 1, 0}},
+	{.info = {"_HID", 0, ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING}},
+	{.info = {"_HOT", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_HPP", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 4, 0, 0, 0}},	/* fixed (4 Int) */
+
+	/*
+	 * For _HPX, a single package is returned, containing a variable number of sub-packages.
+	 * Each sub-package contains a PCI record setting. There are several different type of
+	 * record settings, of different lengths, but all elements of all settings are Integers.
+	 */
+	{.info = {"_HPX", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE2_MIN, ACPI_RTYPE_INTEGER, 5, 0, 0, 0}},	/* variable (Pkgs) each (var Ints) */
+	{.info = {"_IFT", 0, ACPI_RTYPE_INTEGER}},	/* see IPMI spec */
+	{.info = {"_INI", 0, 0}},
+	{.info = {"_IRC", 0, 0}},
+	{.info = {"_LCK", 1, 0}},
+	{.info = {"_LID", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_MAT", 0, ACPI_RTYPE_BUFFER}},
+	{.info = {"_MLS", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE2, ACPI_RTYPE_STRING, 2, 0, 0, 0}},	/* variable (Pkgs) each (2 Str) */
+	{.info = {"_MSG", 1, 0}},
+	{.info = {"_OFF", 0, 0}},
+	{.info = {"_ON_", 0, 0}},
+	{.info = {"_OS_", 0, ACPI_RTYPE_STRING}},
+	{.info = {"_OSC", 4, ACPI_RTYPE_BUFFER}},
+	{.info = {"_OST", 3, 0}},
+	{.info = {"_PCL", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0}},	/* variable (Refs) */
+	{.info = {"_PCT", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_FIXED, ACPI_RTYPE_BUFFER, 2, 0, 0, 0}},	/* fixed (2 Buf) */
+	{.info = {"_PDC", 1, 0}},
+	{.info = {"_PIC", 1, 0}},
+	{.info = {"_PLD", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_BUFFER, 0, 0, 0, 0}},	/* variable (Bufs) */
+	{.info = {"_PPC", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_PPE", 0, ACPI_RTYPE_INTEGER}},	/* see dig64 spec */
+	{.info = {"_PR0", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0}},	/* variable (Refs) */
+	{.info = {"_PR1", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0}},	/* variable (Refs) */
+	{.info = {"_PR2", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0}},	/* variable (Refs) */
+	{.info = {"_PRS", 0, ACPI_RTYPE_BUFFER}},
+
+	/*
+	 * For _PRT, many BIOSs reverse the 2nd and 3rd Package elements. This bug is so prevalent that there
+	 * is code in the ACPICA Resource Manager to detect this and switch them back. For now, do not allow
+	 * and issue a warning. To allow this and eliminate the warning, add the ACPI_RTYPE_REFERENCE
+	 * type to the 2nd element (index 1) in the statement below.
+	 */
+	{.info = {"_PRT", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE2_FIXED, 4,
+					  ACPI_RTYPE_INTEGER,
+					  ACPI_RTYPE_INTEGER,
+					  ACPI_RTYPE_INTEGER | ACPI_RTYPE_REFERENCE, ACPI_RTYPE_INTEGER}},	/* variable (Pkgs) each (4): Int,Int,Int/Ref,Int */
+
+	{.info = {"_PRW", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_OPTION, 2,
+					  ACPI_RTYPE_INTEGER |
+					  ACPI_RTYPE_PACKAGE,
+					  ACPI_RTYPE_INTEGER, ACPI_RTYPE_REFERENCE, 0}},	/* variable (Pkgs) each: Pkg/Int,Int,[variable Refs] (Pkg is Ref/Int) */
+
+	{.info = {"_PS0", 0, 0}},
+	{.info = {"_PS1", 0, 0}},
+	{.info = {"_PS2", 0, 0}},
+	{.info = {"_PS3", 0, 0}},
+	{.info = {"_PSC", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_PSD", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE2_COUNT, ACPI_RTYPE_INTEGER, 0, 0, 0, 0}},	/* variable (Pkgs) each (5 Int) with count */
+	{.info = {"_PSL", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0}},	/* variable (Refs) */
+	{.info = {"_PSR", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_PSS", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE2, ACPI_RTYPE_INTEGER, 6, 0, 0, 0}},	/* variable (Pkgs) each (6 Int) */
+	{.info = {"_PSV", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_PSW", 1, 0}},
+	{.info = {"_PTC", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_FIXED, ACPI_RTYPE_BUFFER, 2, 0, 0, 0}},	/* fixed (2 Buf) */
+	{.info = {"_PTS", 1, 0}},
+	{.info = {"_PXM", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_REG", 2, 0}},
+	{.info = {"_REV", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_RMV", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_ROM", 2, ACPI_RTYPE_BUFFER}},
+	{.info = {"_RTV", 0, ACPI_RTYPE_INTEGER}},
+
+	/*
+	 * For _S0_ through _S5_, the ACPI spec defines a return Package containing 1 Integer,
+	 * but most DSDTs have it wrong - 2,3, or 4 integers. Allow this by making the objects "variable length",
+	 * but all elements must be Integers.
+	 */
+	{.info = {"_S0_", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1, 0, 0, 0}},	/* fixed (1 Int) */
+	{.info = {"_S1_", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1, 0, 0, 0}},	/* fixed (1 Int) */
+	{.info = {"_S2_", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1, 0, 0, 0}},	/* fixed (1 Int) */
+	{.info = {"_S3_", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1, 0, 0, 0}},	/* fixed (1 Int) */
+	{.info = {"_S4_", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1, 0, 0, 0}},	/* fixed (1 Int) */
+	{.info = {"_S5_", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1, 0, 0, 0}},	/* fixed (1 Int) */
+
+	{.info = {"_S1D", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_S2D", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_S3D", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_S4D", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_S0W", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_S1W", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_S2W", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_S3W", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_S4W", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_SBS", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_SCP", 0x13, 0}},	/* Acpi 1.0 allowed 1 arg. Acpi 3.0 expanded to 3 args. Allow both. */
+	/* Note: the 3-arg definition may be removed for ACPI 4.0 */
+	{.info = {"_SDD", 1, 0}},
+	{.info = {"_SEG", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_SLI", 0, ACPI_RTYPE_BUFFER}},
+	{.info = {"_SPD", 1, ACPI_RTYPE_INTEGER}},
+	{.info = {"_SRS", 1, 0}},
+	{.info = {"_SRV", 0, ACPI_RTYPE_INTEGER}},	/* see IPMI spec */
+	{.info = {"_SST", 1, 0}},
+	{.info = {"_STA", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_STM", 3, 0}},
+	{.info = {"_STR", 0, ACPI_RTYPE_BUFFER}},
+	{.info = {"_SUN", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_SWS", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_TC1", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_TC2", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_TMP", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_TPC", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_TPT", 1, 0}},
+	{.info = {"_TRT", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE2, ACPI_RTYPE_REFERENCE, 2,
+					  ACPI_RTYPE_INTEGER, 6, 0}},	/* variable (Pkgs) each 2_ref/6_int */
+	{.info = {"_TSD", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE2_COUNT, ACPI_RTYPE_INTEGER, 5, 0, 0, 0}},	/* variable (Pkgs) each 5_int with count */
+	{.info = {"_TSP", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_TSS", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE2, ACPI_RTYPE_INTEGER, 5, 0, 0, 0}},	/* variable (Pkgs) each 5_int */
+	{.info = {"_TST", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_TTS", 1, 0}},
+	{.info = {"_TZD", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0}},	/* variable (Refs) */
+	{.info = {"_TZM", 0, ACPI_RTYPE_REFERENCE}},
+	{.info = {"_TZP", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_UID", 0, ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING}},
+	{.info = {"_UPC", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 4, 0, 0, 0}},	/* fixed (4 Int) */
+	{.info = {"_UPD", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_UPP", 0, ACPI_RTYPE_INTEGER}},
+	{.info = {"_VPO", 0, ACPI_RTYPE_INTEGER}},
+
+	/* Acpi 1.0 defined _WAK with no return value. Later, it was changed to return a package */
+
+	{.info = {"_WAK", 1, ACPI_RTYPE_NONE | ACPI_RTYPE_PACKAGE}},
+	{.ret_info = {ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 2, 0, 0, 0}},	/* fixed (2 Int), but is optional */
+	{.ret_info = {0, 0, 0, 0, 0, 0}}	/* Table terminator */
+};
+
+#if 0
+	/* Not implemented */
+
+{
+"_WDG", 0, ACPI_RTYPE_BUFFER},	/* MS Extension */
+
+{
+"_WED", 1, ACPI_RTYPE_PACKAGE},	/* MS Extension */
+
+    /* This is an internally implemented control method, no need to check */
+{
+"_OSI", 1, ACPI_RTYPE_INTEGER},
+
+    /* TBD: */
+    _PRT - currently ignore reversed entries.attempt to fix here ?
+    think about code that attempts to fix package elements like _BIF, etc.
+#endif
+#endif
-- 
1.5.5.1

