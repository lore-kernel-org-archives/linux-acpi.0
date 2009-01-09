From: Len Brown <lenb@kernel.org>
Subject: [PATCH 34/94] ACPICA: Consolidate method arg count validation code
Date: Fri, 09 Jan 2009 04:26:36 -0500
Message-ID: <eeb4437e63c39ce19cf9b2de36a1dddbf12910c4.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:44602 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbZAIJ2F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:05 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD7004SC6AR3F8D@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:04 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Merge the code that validates control method argument counts into
the predefined validation module. Eliminates possible multiple
warnings for incorrect counts.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nseval.c   |   69 +++++-------------------
 drivers/acpi/namespace/nspredef.c |  106 ++++++++++++++++++++++++++++++-------
 include/acpi/acnamesp.h           |    3 +
 3 files changed, 104 insertions(+), 74 deletions(-)

diff --git a/drivers/acpi/namespace/nseval.c b/drivers/acpi/namespace/nseval.c
index 738a451..b95bfbb 100644
--- a/drivers/acpi/namespace/nseval.c
+++ b/drivers/acpi/namespace/nseval.c
@@ -89,6 +89,7 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 	/* Initialize the return value to an invalid object */
 
 	info->return_object = NULL;
+	info->param_count = 0;
 
 	/*
 	 * Get the actual namespace node for the target object. Handles these cases:
@@ -141,41 +142,17 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 			return_ACPI_STATUS(AE_NULL_OBJECT);
 		}
 
-		/*
-		 * Calculate the number of arguments being passed to the method
-		 */
+		/* Count the number of arguments being passed to the method */
 
-		info->param_count = 0;
 		if (info->parameters) {
-			while (info->parameters[info->param_count])
+			while (info->parameters[info->param_count]) {
+				if (info->param_count > ACPI_METHOD_MAX_ARG) {
+					return_ACPI_STATUS(AE_LIMIT);
+				}
 				info->param_count++;
+			}
 		}
 
-		/*
-		 * Warning if too few or too many arguments have been passed by the
-		 * caller. We don't want to abort here with an error because an
-		 * incorrect number of arguments may not cause the method to fail.
-		 * However, the method will fail if there are too few arguments passed
-		 * and the method attempts to use one of the missing ones.
-		 */
-
-		if (info->param_count < info->obj_desc->method.param_count) {
-			ACPI_WARNING((AE_INFO,
-				    "Insufficient arguments - "
-				    "method [%4.4s] needs %d, found %d",
-				    acpi_ut_get_node_name(info->resolved_node),
-				    info->obj_desc->method.param_count,
-				    info->param_count));
-		} else if (info->param_count >
-				info->obj_desc->method.param_count) {
-			ACPI_WARNING((AE_INFO,
-				      "Excess arguments - "
-				      "method [%4.4s] needs %d, found %d",
-				      acpi_ut_get_node_name(info->
-							    resolved_node),
-				      info->obj_desc->method.param_count,
-				      info->param_count));
-		}
 
 		ACPI_DUMP_PATHNAME(info->resolved_node, "Execute Method:",
 				   ACPI_LV_INFO, _COMPONENT);
@@ -264,31 +241,13 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 		}
 	}
 
-	/* Validation of return values for ACPI-predefined methods and objects */
-
-	if ((status == AE_OK) || (status == AE_CTRL_RETURN_VALUE)) {
-		/*
-		 * If this is the first evaluation, check the return value. This
-		 * ensures that any warnings will only be emitted during the very
-		 * first evaluation of the object.
-		 */
-		if (!(node->flags & ANOBJ_EVALUATED)) {
-			/*
-			 * Check for a predefined ACPI name. If found, validate the
-			 * returned object.
-			 *
-			 * Note: Ignore return status for now, emit warnings if there are
-			 * problems with the returned object. May change later to abort
-			 * the method on invalid return object.
-			 */
-			(void)acpi_ns_check_predefined_names(node,
-			     &info->return_object);
-		}
-
-		/* Mark the node as having been evaluated */
-
-		node->flags |= ANOBJ_EVALUATED;
-	}
+	/*
+	 * Check input argument count against the ASL-defined count for a method.
+	 * Also check predefined names: argument count and return value against
+	 * the ACPI specification. Some incorrect return value types are repaired.
+	 */
+	(void)acpi_ns_check_predefined_names(node, info->param_count,
+		status, &info->return_object);
 
 	/* Check if there is a return value that must be dealt with */
 
diff --git a/drivers/acpi/namespace/nspredef.c b/drivers/acpi/namespace/nspredef.c
index 3df1752..8d354ba 100644
--- a/drivers/acpi/namespace/nspredef.c
+++ b/drivers/acpi/namespace/nspredef.c
@@ -124,6 +124,8 @@ static const char *acpi_rtype_names[] = {
 
 acpi_status
 acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
+			       u32 user_param_count,
+			       acpi_status return_status,
 			       union acpi_operand_object **return_object_ptr)
 {
 	union acpi_operand_object *return_object = *return_object_ptr;
@@ -134,12 +136,6 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	/* Match the name for this method/object against the predefined list */
 
 	predefined = acpi_ns_check_for_predefined_name(node);
-	if (!predefined) {
-
-		/* Name was not one of the predefined names */
-
-		return (AE_OK);
-	}
 
 	/* Get the full pathname to the object, for use in error messages */
 
@@ -149,10 +145,37 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	}
 
 	/*
-	 * Check that the parameter count for this method is in accordance
-	 * with the ACPI specification.
+	 * Check that the parameter count for this method matches the ASL
+	 * definition. For predefined names, ensure that both the caller and
+	 * the method itself are in accordance with the ACPI specification.
 	 */
-	acpi_ns_check_parameter_count(pathname, node, predefined);
+	acpi_ns_check_parameter_count(pathname, node, user_param_count,
+				      predefined);
+
+	/* If not a predefined name, we cannot validate the return object */
+
+	if (!predefined) {
+		goto exit;
+	}
+
+	/* If the method failed, we cannot validate the return object */
+
+	if ((return_status != AE_OK) && (return_status != AE_CTRL_RETURN_VALUE)) {
+		goto exit;
+	}
+
+	/*
+	 * Only validate the return value on the first successful evaluation of
+	 * the method. This ensures that any warnings will only be emitted during
+	 * the very first evaluation of the method/object.
+	 */
+	if (node->flags & ANOBJ_EVALUATED) {
+		goto exit;
+	}
+
+	/* Mark the node as having been successfully evaluated */
+
+	node->flags |= ANOBJ_EVALUATED;
 
 	/*
 	 * If there is no return value, check if we require a return value for
@@ -177,7 +200,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	 * We have a return value, but if one wasn't expected, just exit, this is
 	 * not a problem
 	 *
-	 * For example, if "Implicit return value" is enabled, methods will
+	 * For example, if the "Implicit Return" feature is enabled, methods will
 	 * always return a value
 	 */
 	if (!predefined->info.expected_btypes) {
@@ -204,7 +227,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	}
 
       exit:
-	if (pathname) {
+	if (pathname != predefined->info.name) {
 		ACPI_FREE(pathname);
 	}
 
@@ -217,6 +240,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
  *
  * PARAMETERS:  Pathname        - Full pathname to the node (for error msgs)
  *              Node            - Namespace node for the method/object
+ *              user_param_count - Number of args passed in by the caller
  *              Predefined      - Pointer to entry in predefined name table
  *
  * RETURN:      None
@@ -230,32 +254,76 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 void
 acpi_ns_check_parameter_count(char *pathname,
 			      struct acpi_namespace_node *node,
+			      u32 user_param_count,
 			      const union acpi_predefined_info *predefined)
 {
 	u32 param_count;
 	u32 required_params_current;
 	u32 required_params_old;
 
-	/*
-	 * Check that the ASL-defined parameter count is what is expected for
-	 * this predefined name.
-	 *
-	 * Methods have 0-7 parameters. All other types have zero.
-	 */
+	/* Methods have 0-7 parameters. All other types have zero. */
+
 	param_count = 0;
 	if (node->type == ACPI_TYPE_METHOD) {
 		param_count = node->object->method.param_count;
 	}
 
-	/* Validate parameter count - allow two different legal counts (_SCP) */
+	/* Argument count check for non-predefined methods/objects */
+
+	if (!predefined) {
+		/*
+		 * Warning if too few or too many arguments have been passed by the
+		 * caller. An incorrect number of arguments may not cause the method
+		 * to fail. However, the method will fail if there are too few
+		 * arguments and the method attempts to use one of the missing ones.
+		 */
+		if (user_param_count < param_count) {
+			ACPI_WARNING((AE_INFO,
+				      "%s: Insufficient arguments - needs %d, found %d",
+				      pathname, param_count, user_param_count));
+		} else if (user_param_count > param_count) {
+			ACPI_WARNING((AE_INFO,
+				      "%s: Excess arguments - needs %d, found %d",
+				      pathname, param_count, user_param_count));
+		}
+		return;
+	}
+
+	/* Allow two different legal argument counts (_SCP, etc.) */
 
 	required_params_current = predefined->info.param_count & 0x0F;
 	required_params_old = predefined->info.param_count >> 4;
 
+	if (user_param_count != ACPI_UINT32_MAX) {
+
+		/* Validate the user-supplied parameter count */
+
+		if ((user_param_count != required_params_current) &&
+		    (user_param_count != required_params_old)) {
+			ACPI_WARNING((AE_INFO,
+				      "%s: Parameter count mismatch - caller passed %d, ACPI requires %d",
+				      pathname, user_param_count,
+				      required_params_current));
+		}
+	}
+
+	/*
+	 * Only validate the argument count on the first successful evaluation of
+	 * the method. This ensures that any warnings will only be emitted during
+	 * the very first evaluation of the method/object.
+	 */
+	if (node->flags & ANOBJ_EVALUATED) {
+		return;
+	}
+
+	/*
+	 * Check that the ASL-defined parameter count is what is expected for
+	 * this predefined name.
+	 */
 	if ((param_count != required_params_current) &&
 	    (param_count != required_params_old)) {
 		ACPI_WARNING((AE_INFO,
-			      "%s: Parameter count mismatch - ASL declared %d, expected %d",
+			      "%s: Parameter count mismatch - ASL declared %d, ACPI requires %d",
 			      pathname, param_count, required_params_current));
 	}
 }
diff --git a/include/acpi/acnamesp.h b/include/acpi/acnamesp.h
index db1e290..46cb5b4 100644
--- a/include/acpi/acnamesp.h
+++ b/include/acpi/acnamesp.h
@@ -182,6 +182,8 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info *info);
  */
 acpi_status
 acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
+			       u32 user_param_count,
+			       acpi_status return_status,
 			       union acpi_operand_object **return_object);
 
 const union acpi_predefined_info *acpi_ns_check_for_predefined_name(struct
@@ -191,6 +193,7 @@ const union acpi_predefined_info *acpi_ns_check_for_predefined_name(struct
 void
 acpi_ns_check_parameter_count(char *pathname,
 			      struct acpi_namespace_node *node,
+			      u32 user_param_count,
 			      const union acpi_predefined_info *info);
 
 /*
-- 
1.5.6.6

