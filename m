From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 4/9] ACPICA: Fix possible fault for methods that optionally have no return value.
Date: Thu,  8 Aug 2013 15:29:38 +0800
Message-ID: <65ea9af9068514c55a57ef608b3c355e42bcdaf5.1375946725.git.lv.zheng@intel.com>
References: <cover.1375946725.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35581 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211Ab3HHHaZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Aug 2013 03:30:25 -0400
In-Reply-To: <cover.1375946725.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Currently applies to the _WAK method only. If the method has no return
value and slack mode is not enabled, the return value validation code
can fault.

Also improves the error message when an expected return value is
missing (for any predefined name/method).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nspredef.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 24b71a0..098e766 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -151,6 +151,15 @@ acpi_ns_check_return_value(struct acpi_namespace_node *node,
 	}
 
 	/*
+	 *
+	 * 4) If there is no return value and it is optional, just return
+	 * AE_OK (_WAK).
+	 */
+	if (!(*return_object_ptr)) {
+		goto exit;
+	}
+
+	/*
 	 * For returned Package objects, check the type of all sub-objects.
 	 * Note: Package may have been newly created by call above.
 	 */
@@ -268,7 +277,12 @@ acpi_ns_check_object_type(struct acpi_evaluate_info *info,
 
 	acpi_ut_get_expected_return_types(type_buffer, expected_btypes);
 
-	if (package_index == ACPI_NOT_PACKAGE_ELEMENT) {
+	if (!return_object) {
+		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+				      info->node_flags,
+				      "Expected return object of type %s",
+				      type_buffer));
+	} else if (package_index == ACPI_NOT_PACKAGE_ELEMENT) {
 		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
 				      info->node_flags,
 				      "Return type mismatch - found %s, expected %s",
-- 
1.7.10

