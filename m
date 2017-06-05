From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 42/53] ACPICA: Update two error messages to emit control method name
Date: Mon,  5 Jun 2017 16:41:23 +0800
Message-ID: <121f24299491a60ca40fc1bd25054c23d5d69fd9.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:5296 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbdFEIl0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:41:26 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 73f7fab1376d5dbfda24cf51c1bb04df0d31b48e

Intention is to improve debugging by clarifying which method
has caused the error, in acpi_evaluate_object_typed.

Link: https://github.com/acpica/acpica/commit/73f7fab1
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsxfeval.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index c944ff5..538c616 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -85,6 +85,8 @@ acpi_evaluate_object_typed(acpi_handle handle,
 {
 	acpi_status status;
 	u8 free_buffer_on_error = FALSE;
+	acpi_handle target_handle;
+	char *full_pathname;
 
 	ACPI_FUNCTION_TRACE(acpi_evaluate_object_typed);
 
@@ -98,38 +100,51 @@ acpi_evaluate_object_typed(acpi_handle handle,
 		free_buffer_on_error = TRUE;
 	}
 
+	status = acpi_get_handle(handle, pathname, &target_handle);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	full_pathname = acpi_ns_get_external_pathname(target_handle);
+	if (!full_pathname) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+
 	/* Evaluate the object */
 
-	status = acpi_evaluate_object(handle, pathname,
-				      external_params, return_buffer);
+	status = acpi_evaluate_object(target_handle, NULL, external_params,
+				      return_buffer);
 	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
+		goto exit;
 	}
 
-	/* Type ANY means "don't care" */
+	/* Type ANY means "don't care about return value type" */
 
 	if (return_type == ACPI_TYPE_ANY) {
-		return_ACPI_STATUS(AE_OK);
+		goto exit;
 	}
 
 	if (return_buffer->length == 0) {
 
 		/* Error because caller specifically asked for a return value */
 
-		ACPI_ERROR((AE_INFO, "No return value"));
-		return_ACPI_STATUS(AE_NULL_OBJECT);
+		ACPI_ERROR((AE_INFO, "%s did not return any object",
+			    full_pathname));
+		status = AE_NULL_OBJECT;
+		goto exit;
 	}
 
 	/* Examine the object type returned from evaluate_object */
 
 	if (((union acpi_object *)return_buffer->pointer)->type == return_type) {
-		return_ACPI_STATUS(AE_OK);
+		goto exit;
 	}
 
 	/* Return object type does not match requested type */
 
 	ACPI_ERROR((AE_INFO,
-		    "Incorrect return type [%s] requested [%s]",
+		    "Incorrect return type from %s - received [%s], requested [%s]",
+		    full_pathname,
 		    acpi_ut_get_type_name(((union acpi_object *)return_buffer->
 					   pointer)->type),
 		    acpi_ut_get_type_name(return_type)));
@@ -147,7 +162,11 @@ acpi_evaluate_object_typed(acpi_handle handle,
 	}
 
 	return_buffer->length = 0;
-	return_ACPI_STATUS(AE_TYPE);
+	status = AE_TYPE;
+
+exit:
+	ACPI_FREE(full_pathname);
+	return_ACPI_STATUS(status);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_evaluate_object_typed)
-- 
2.7.4

