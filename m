From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/14] ACPICA: Update return value for intenal _OSI method
Date: Wed,  7 Sep 2016 14:06:47 +0800
Message-ID: <29ff63f78265023af4cc5c5c5d3500fa5d413c63.1473226204.git.lv.zheng@intel.com>
References: <cover.1473226203.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:39374 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752767AbcIGGHK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Sep 2016 02:07:10 -0400
In-Reply-To: <cover.1473226203.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 82101009c7c04845edb3495e66a274a613758bca

Instead of 0xFFFFFFFF, _OSI is now defined to return "Ones".
This is for compatibility with Windows. The ACPI spec will
be updated to reflect this.

Link: https://github.com/acpica/acpica/commit/82101009
Reported-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utosi.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 3f5fed6..f0484b0 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -390,11 +390,22 @@ struct acpi_interface_info *acpi_ut_get_interface(acpi_string interface_name)
  * PARAMETERS:  walk_state          - Current walk state
  *
  * RETURN:      Status
+ *              Integer: TRUE (0) if input string is matched
+ *                       FALSE (-1) if string is not matched
  *
  * DESCRIPTION: Implementation of the _OSI predefined control method. When
  *              an invocation of _OSI is encountered in the system AML,
  *              control is transferred to this function.
  *
+ * (August 2016)
+ * Note:  _OSI is now defined to return "Ones" to indicate a match, for
+ * compatibility with other ACPI implementations. On a 32-bit DSDT, Ones
+ * is 0xFFFFFFFF. On a 64-bit DSDT, Ones is 0xFFFFFFFFFFFFFFFF
+ * (ACPI_UINT64_MAX).
+ *
+ * This function always returns ACPI_UINT64_MAX for TRUE, and later code
+ * will truncate this to 32 bits if necessary.
+ *
  ******************************************************************************/
 
 acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
@@ -404,7 +415,7 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 	struct acpi_interface_info *interface_info;
 	acpi_interface_handler interface_handler;
 	acpi_status status;
-	u32 return_value;
+	u64 return_value;
 
 	ACPI_FUNCTION_TRACE(ut_osi_implementation);
 
@@ -444,7 +455,7 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 			acpi_gbl_osi_data = interface_info->value;
 		}
 
-		return_value = ACPI_UINT32_MAX;
+		return_value = ACPI_UINT64_MAX;
 	}
 
 	acpi_os_release_mutex(acpi_gbl_osi_mutex);
@@ -456,9 +467,10 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 	 */
 	interface_handler = acpi_gbl_interface_handler;
 	if (interface_handler) {
-		return_value =
-		    interface_handler(string_desc->string.pointer,
-				      return_value);
+		if (interface_handler
+		    (string_desc->string.pointer, (u32)return_value)) {
+			return_value = ACPI_UINT64_MAX;
+		}
 	}
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INFO,
-- 
1.7.10

