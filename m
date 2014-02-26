From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/18] ACPICA: Restore code that repairs NULL package elements in return values.
Date: Wed, 26 Feb 2014 10:29:40 +0800
Message-ID: <c301a9a7b1a82f33b4f9bf7278400025a1de4007.1393379348.git.lv.zheng@intel.com>
References: <cover.1393379348.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:19044 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163AbaBZCaV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Feb 2014 21:30:21 -0500
In-Reply-To: <cover.1393379348.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

The original code was lost accidently, it was not generated along with the
following commit of mechanism improvements and thus not get merged:

  Commit: d5a36100f62fa6db5541344e08b361b34e9114c5
  Subject: ACPICA: Add mechanism for early object repairs on a per-name basis

  Adds the framework to allow object repairs very early in the
  return object analysis. Enables repairs like string->unicode,
  etc.

This patch restores the implementation of the NULL element repair code for
ACPI_RTYPE_NONE.  In the original design, ACPI_RTYPE_NONE is defined to
collect simple NULL object repairs.
Lv Zheng.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=67901
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Cc: <stable@vger.kernel.org> # 3.10.x
---
 drivers/acpi/acpica/nsrepair.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 904f7c3..21b6402 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -207,13 +207,30 @@ acpi_ns_simple_repair(struct acpi_evaluate_info *info,
 	 * this predefined name. Either one return value is expected, or none,
 	 * for both methods and other objects.
 	 *
-	 * Exit now if there is no return object. Warning if one was expected.
+	 * Try to fix if there was no return object. Warning if failed to fix.
 	 */
 	if (!return_object) {
 		if (expected_btypes && (!(expected_btypes & ACPI_RTYPE_NONE))) {
-			ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
-					      ACPI_WARN_ALWAYS,
-					      "Missing expected return value"));
+			if (package_index != ACPI_NOT_PACKAGE_ELEMENT) {
+				ACPI_WARN_PREDEFINED((AE_INFO,
+						      info->full_pathname,
+						      ACPI_WARN_ALWAYS,
+						      "Found unexpected NULL package element"));
+
+				status =
+				    acpi_ns_repair_null_element(info,
+								expected_btypes,
+								package_index,
+								return_object_ptr);
+				if (ACPI_SUCCESS(status)) {
+					return (AE_OK);	/* Repair was successful */
+				}
+			} else {
+				ACPI_WARN_PREDEFINED((AE_INFO,
+						      info->full_pathname,
+						      ACPI_WARN_ALWAYS,
+						      "Missing expected return value"));
+			}
 
 			return (AE_AML_NO_RETURN_VALUE);
 		}
-- 
1.7.10

