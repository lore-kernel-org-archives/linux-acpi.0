From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/21] ACPICA: Remove unused ACPI_FREE_BUFFER macro. No functional change.
Date: Wed,  8 Jan 2014 13:43:23 +0800
Message-ID: <d7712b1846c080b74d8e05b17ea5abe8a5723e3c.1387505702.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:29750 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753895AbaAHFnc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:43:32 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This macro is no longer used by ACPICA and it is not public.
Also update comments related to the use of ACPI_ALLOCATE_BUFFER and
the use of acpi_os_free (kfree is equivalent and prefered in the
kernel) to free the buffer.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/nsxfeval.c |   23 +++++++++++++----------
 drivers/acpi/acpica/utalloc.c  |   10 +++++++---
 include/acpi/actypes.h         |   12 ++----------
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index e973e31..1f0c28b 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -84,7 +84,7 @@ acpi_evaluate_object_typed(acpi_handle handle,
 			   acpi_object_type return_type)
 {
 	acpi_status status;
-	u8 must_free = FALSE;
+	u8 free_buffer_on_error = FALSE;
 
 	ACPI_FUNCTION_TRACE(acpi_evaluate_object_typed);
 
@@ -95,14 +95,13 @@ acpi_evaluate_object_typed(acpi_handle handle,
 	}
 
 	if (return_buffer->length == ACPI_ALLOCATE_BUFFER) {
-		must_free = TRUE;
+		free_buffer_on_error = TRUE;
 	}
 
 	/* Evaluate the object */
 
-	status =
-	    acpi_evaluate_object(handle, pathname, external_params,
-				 return_buffer);
+	status = acpi_evaluate_object(handle, pathname,
+				      external_params, return_buffer);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -135,11 +134,15 @@ acpi_evaluate_object_typed(acpi_handle handle,
 					   pointer)->type),
 		    acpi_ut_get_type_name(return_type)));
 
-	if (must_free) {
-
-		/* Caller used ACPI_ALLOCATE_BUFFER, free the return buffer */
-
-		ACPI_FREE_BUFFER(*return_buffer);
+	if (free_buffer_on_error) {
+		/*
+		 * Free a buffer created via ACPI_ALLOCATE_BUFFER.
+		 * Note: We use acpi_os_free here because acpi_os_allocate was used
+		 * to allocate the buffer. This purposefully bypasses the
+		 * (optionally enabled) allocation tracking mechanism since we
+		 * only want to track internal allocations.
+		 */
+		acpi_os_free(return_buffer->pointer);
 		return_buffer->pointer = NULL;
 	}
 
diff --git a/drivers/acpi/acpica/utalloc.c b/drivers/acpi/acpica/utalloc.c
index 814267f..1851762 100644
--- a/drivers/acpi/acpica/utalloc.c
+++ b/drivers/acpi/acpica/utalloc.c
@@ -302,9 +302,13 @@ acpi_ut_initialize_buffer(struct acpi_buffer * buffer,
 		return (AE_BUFFER_OVERFLOW);
 
 	case ACPI_ALLOCATE_BUFFER:
-
-		/* Allocate a new buffer */
-
+		/*
+		 * Allocate a new buffer. We directectly call acpi_os_allocate here to
+		 * purposefully bypass the (optionally enabled) internal allocation
+		 * tracking mechanism since we only want to track internal
+		 * allocations. Note: The caller should use acpi_os_free to free this
+		 * buffer created via ACPI_ALLOCATE_BUFFER.
+		 */
 		buffer->pointer = acpi_os_allocate(required_length);
 		break;
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 809b1a0..68a3ada 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -928,8 +928,8 @@ struct acpi_object_list {
  * Miscellaneous common Data Structures used by the interfaces
  */
 #define ACPI_NO_BUFFER              0
-#define ACPI_ALLOCATE_BUFFER        (acpi_size) (-1)
-#define ACPI_ALLOCATE_LOCAL_BUFFER  (acpi_size) (-2)
+#define ACPI_ALLOCATE_BUFFER        (acpi_size) (-1)	/* Let ACPICA allocate buffer */
+#define ACPI_ALLOCATE_LOCAL_BUFFER  (acpi_size) (-2)	/* For internal use only (enables tracking) */
 
 struct acpi_buffer {
 	acpi_size length;	/* Length in bytes of the buffer */
@@ -937,14 +937,6 @@ struct acpi_buffer {
 };
 
 /*
- * Free a buffer created in an struct acpi_buffer via ACPI_ALLOCATE_BUFFER.
- * Note: We use acpi_os_free here because acpi_os_allocate was used to allocate
- * the buffer. This purposefully bypasses the internal allocation tracking
- * mechanism (if it is enabled).
- */
-#define ACPI_FREE_BUFFER(b)         acpi_os_free((b).pointer)
-
-/*
  * name_type for acpi_get_name
  */
 #define ACPI_FULL_PATHNAME              0
-- 
1.7.10

