From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/42] ACPICA: acpi_get_sleep_type_data: Reduce warnings
Date: Tue, 29 Dec 2015 13:52:41 +0800
Message-ID: <008fc907b0fdd0151d3bf3c8bfaf85717735db1e.1451367388.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Prarit Bhargava <prarit@redhat.com>

ACPICA commit 7bb77313091e52a846df4c9c2bea90be31bfb9d8

Eliminate warnings for "not found" _Sx errors, since these
are optional. Original NOT_FOUND status is still returned.

Original changes by Prarit Bhargava.
ACPICA BZ 1208.

Link: https://github.com/acpica/acpica/commit/7bb77313
Link: https://bugs.acpica.org/show_bug.cgi?id=1208
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/hwxface.c |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 5f97468..b2e50d8 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -504,11 +504,20 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 	 * Evaluate the \_Sx namespace object containing the register values
 	 * for this state
 	 */
-	info->relative_pathname =
-	    ACPI_CAST_PTR(char, acpi_gbl_sleep_state_names[sleep_state]);
+	info->relative_pathname = ACPI_CAST_PTR(char,
+						acpi_gbl_sleep_state_names
+						[sleep_state]);
+
 	status = acpi_ns_evaluate(info);
 	if (ACPI_FAILURE(status)) {
-		goto cleanup;
+		if (status == AE_NOT_FOUND) {
+
+			/* The _Sx states are optional, ignore NOT_FOUND */
+
+			goto final_cleanup;
+		}
+
+		goto warning_cleanup;
 	}
 
 	/* Must have a return object */
@@ -517,7 +526,7 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 		ACPI_ERROR((AE_INFO, "No Sleep State object returned from [%s]",
 			    info->relative_pathname));
 		status = AE_AML_NO_RETURN_VALUE;
-		goto cleanup;
+		goto warning_cleanup;
 	}
 
 	/* Return object must be of type Package */
@@ -526,7 +535,7 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 		ACPI_ERROR((AE_INFO,
 			    "Sleep State return object is not a Package"));
 		status = AE_AML_OPERAND_TYPE;
-		goto cleanup1;
+		goto return_value_cleanup;
 	}
 
 	/*
@@ -570,16 +579,17 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 		break;
 	}
 
-cleanup1:
+return_value_cleanup:
 	acpi_ut_remove_reference(info->return_object);
 
-cleanup:
+warning_cleanup:
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status,
 				"While evaluating Sleep State [%s]",
 				info->relative_pathname));
 	}
 
+final_cleanup:
 	ACPI_FREE(info);
 	return_ACPI_STATUS(status);
 }
-- 
1.7.10
