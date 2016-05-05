From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 02/13] ACPICA: Refactor evaluate_object to reduce nesting
Date: Thu,  5 May 2016 12:58:00 +0800
Message-ID: <ccc9b965ca570f93f98849ea72b3eca52ab80c59.1462418912.git.lv.zheng@intel.com>
References: <cover.1462331120.git.lv.zheng@intel.com> <cover.1462418912.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462418912.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 599e9159f53565e4a3f3e67f6a03f81fcb10a4cf

Original patch from hanjun.guo@linaro.org
ACPICA BZ 1072.

Link: https://github.com/acpica/acpica/commit/599e9159
Link: https://bugs.acpica.org/show_bug.cgi?id=1072
Original-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsxfeval.c |  111 ++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 56 deletions(-)

diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 614e4ba..d2a9b4f 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -280,13 +280,12 @@ acpi_evaluate_object(acpi_handle handle,
 		info->parameters[info->param_count] = NULL;
 	}
 
-#if 0
+#ifdef _FUTURE_FEATURE
 
 	/*
 	 * Begin incoming argument count analysis. Check for too few args
 	 * and too many args.
 	 */
-
 	switch (acpi_ns_get_type(info->node)) {
 	case ACPI_TYPE_METHOD:
 
@@ -370,68 +369,68 @@ acpi_evaluate_object(acpi_handle handle,
 	 * If we are expecting a return value, and all went well above,
 	 * copy the return value to an external object.
 	 */
-	if (return_buffer) {
-		if (!info->return_object) {
-			return_buffer->length = 0;
-		} else {
-			if (ACPI_GET_DESCRIPTOR_TYPE(info->return_object) ==
-			    ACPI_DESC_TYPE_NAMED) {
-				/*
-				 * If we received a NS Node as a return object, this means that
-				 * the object we are evaluating has nothing interesting to
-				 * return (such as a mutex, etc.)  We return an error because
-				 * these types are essentially unsupported by this interface.
-				 * We don't check up front because this makes it easier to add
-				 * support for various types at a later date if necessary.
-				 */
-				status = AE_TYPE;
-				info->return_object = NULL;	/* No need to delete a NS Node */
-				return_buffer->length = 0;
-			}
+	if (!return_buffer) {
+		goto cleanup_return_object;
+	}
 
-			if (ACPI_SUCCESS(status)) {
+	if (!info->return_object) {
+		return_buffer->length = 0;
+		goto cleanup;
+	}
 
-				/* Dereference Index and ref_of references */
+	if (ACPI_GET_DESCRIPTOR_TYPE(info->return_object) ==
+	    ACPI_DESC_TYPE_NAMED) {
+		/*
+		 * If we received a NS Node as a return object, this means that
+		 * the object we are evaluating has nothing interesting to
+		 * return (such as a mutex, etc.)  We return an error because
+		 * these types are essentially unsupported by this interface.
+		 * We don't check up front because this makes it easier to add
+		 * support for various types at a later date if necessary.
+		 */
+		status = AE_TYPE;
+		info->return_object = NULL;	/* No need to delete a NS Node */
+		return_buffer->length = 0;
+	}
 
-				acpi_ns_resolve_references(info);
+	if (ACPI_FAILURE(status)) {
+		goto cleanup_return_object;
+	}
 
-				/* Get the size of the returned object */
+	/* Dereference Index and ref_of references */
 
-				status =
-				    acpi_ut_get_object_size(info->return_object,
-							    &buffer_space_needed);
-				if (ACPI_SUCCESS(status)) {
-
-					/* Validate/Allocate/Clear caller buffer */
-
-					status =
-					    acpi_ut_initialize_buffer
-					    (return_buffer,
-					     buffer_space_needed);
-					if (ACPI_FAILURE(status)) {
-						/*
-						 * Caller's buffer is too small or a new one can't
-						 * be allocated
-						 */
-						ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-								  "Needed buffer size %X, %s\n",
-								  (u32)
-								  buffer_space_needed,
-								  acpi_format_exception
-								  (status)));
-					} else {
-						/* We have enough space for the object, build it */
-
-						status =
-						    acpi_ut_copy_iobject_to_eobject
-						    (info->return_object,
-						     return_buffer);
-					}
-				}
-			}
+	acpi_ns_resolve_references(info);
+
+	/* Get the size of the returned object */
+
+	status = acpi_ut_get_object_size(info->return_object,
+					 &buffer_space_needed);
+	if (ACPI_SUCCESS(status)) {
+
+		/* Validate/Allocate/Clear caller buffer */
+
+		status = acpi_ut_initialize_buffer(return_buffer,
+						   buffer_space_needed);
+		if (ACPI_FAILURE(status)) {
+			/*
+			 * Caller's buffer is too small or a new one can't
+			 * be allocated
+			 */
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+					  "Needed buffer size %X, %s\n",
+					  (u32)buffer_space_needed,
+					  acpi_format_exception(status)));
+		} else {
+			/* We have enough space for the object, build it */
+
+			status =
+			    acpi_ut_copy_iobject_to_eobject(info->return_object,
+							    return_buffer);
 		}
 	}
 
+cleanup_return_object:
+
 	if (info->return_object) {
 		/*
 		 * Delete the internal return object. NOTE: Interpreter must be
-- 
1.7.10
