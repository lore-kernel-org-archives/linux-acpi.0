From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/15] ACPICA: Performance enhancement for ACPI package objects.
Date: Wed, 21 Nov 2012 18:07:50 +0800
Message-ID: <bb01583eb98c7b57f3f4f77d865013cab4813685.1353491653.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63378 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754294Ab2KUKHy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Nov 2012 05:07:54 -0500
In-Reply-To: <cover.1353491652.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Chao Guan <chao.guan@intel.com>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Chao Guan <chao.guan@intel.com>

This change greatly increases the performance of package objects
within the interpreter. It changes the processing of reference
counts for packages by optimizing for the most common case where
the package subobjects are either integers, strings, or buffers.
Increases the performance of the ASLTS test suite by 1.5X.
Chao Guan. ACPICA BZ 943.
https://www.acpica.org/bugzilla/show_bug.cgi?id=943

Signed-off-by: Chao Guan <chao.guan@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utdelete.c |   42 +++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 7981054..e806fb0 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -530,18 +530,42 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 			 */
 			for (i = 0; i < object->package.count; i++) {
 				/*
-				 * Push each element onto the stack for later processing.
-				 * Note: There can be null elements within the package,
-				 * these are simply ignored
+				 * Null package elements are legal and can be simply
+				 * ignored.
 				 */
-				status =
-				    acpi_ut_create_update_state_and_push
-				    (object->package.elements[i], action,
-				     &state_list);
-				if (ACPI_FAILURE(status)) {
-					goto error_exit;
+				next_object = object->package.elements[i];
+				if (!next_object) {
+					continue;
+				}
+
+				switch (next_object->common.type) {
+				case ACPI_TYPE_INTEGER:
+				case ACPI_TYPE_STRING:
+				case ACPI_TYPE_BUFFER:
+					/*
+					 * For these very simple sub-objects, we can just
+					 * update the reference count here and continue.
+					 * Greatly increases performance of this operation.
+					 */
+					acpi_ut_update_ref_count(next_object,
+								 action);
+					break;
+
+				default:
+					/*
+					 * For complex sub-objects, push them onto the stack
+					 * for later processing (this eliminates recursion.)
+					 */
+					status =
+					    acpi_ut_create_update_state_and_push
+					    (next_object, action, &state_list);
+					if (ACPI_FAILURE(status)) {
+						goto error_exit;
+					}
+					break;
 				}
 			}
+			next_object = NULL;
 			break;
 
 		case ACPI_TYPE_BUFFER_FIELD:
-- 
1.7.10

