From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 8/9] ACPICA: Update names for walk_namespace callbacks to clarify usage.
Date: Thu,  8 Aug 2013 15:30:05 +0800
Message-ID: <ac017d08aedd80d6adb7691f1bbc8c2031b26f17.1375946725.git.lv.zheng@intel.com>
References: <cover.1375946725.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:29250 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933825Ab3HHHaU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Aug 2013 03:30:20 -0400
In-Reply-To: <cover.1375946725.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Use of "preorder" and "postorder" was incorrect. The callbacks are
simply invoked during tree ascent and descent during the
depth-first walk.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acnamesp.h |    4 ++--
 drivers/acpi/acpica/nswalk.c   |   26 +++++++++++++-------------
 drivers/acpi/acpica/nsxfeval.c |   16 ++++++++--------
 include/acpi/acpixf.h          |    4 ++--
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index b83dc32..40b04bd 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -104,8 +104,8 @@ acpi_ns_walk_namespace(acpi_object_type type,
 		       acpi_handle start_object,
 		       u32 max_depth,
 		       u32 flags,
-		       acpi_walk_callback pre_order_visit,
-		       acpi_walk_callback post_order_visit,
+		       acpi_walk_callback descending_callback,
+		       acpi_walk_callback ascending_callback,
 		       void *context, void **return_value);
 
 struct acpi_namespace_node *acpi_ns_get_next_node(struct acpi_namespace_node
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index e70911a..e81f15e 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -156,9 +156,9 @@ struct acpi_namespace_node *acpi_ns_get_next_node_typed(acpi_object_type type,
  *              max_depth           - Depth to which search is to reach
  *              flags               - Whether to unlock the NS before invoking
  *                                    the callback routine
- *              pre_order_visit     - Called during tree pre-order visit
+ *              descending_callback - Called during tree descent
  *                                    when an object of "Type" is found
- *              post_order_visit    - Called during tree post-order visit
+ *              ascending_callback  - Called during tree ascent
  *                                    when an object of "Type" is found
  *              context             - Passed to user function(s) above
  *              return_value        - from the user_function if terminated
@@ -185,8 +185,8 @@ acpi_ns_walk_namespace(acpi_object_type type,
 		       acpi_handle start_node,
 		       u32 max_depth,
 		       u32 flags,
-		       acpi_walk_callback pre_order_visit,
-		       acpi_walk_callback post_order_visit,
+		       acpi_walk_callback descending_callback,
+		       acpi_walk_callback ascending_callback,
 		       void *context, void **return_value)
 {
 	acpi_status status;
@@ -255,22 +255,22 @@ acpi_ns_walk_namespace(acpi_object_type type,
 			}
 
 			/*
-			 * Invoke the user function, either pre-order or post-order
+			 * Invoke the user function, either descending, ascending,
 			 * or both.
 			 */
 			if (!node_previously_visited) {
-				if (pre_order_visit) {
+				if (descending_callback) {
 					status =
-					    pre_order_visit(child_node, level,
-							    context,
-							    return_value);
+					    descending_callback(child_node,
+								level, context,
+								return_value);
 				}
 			} else {
-				if (post_order_visit) {
+				if (ascending_callback) {
 					status =
-					    post_order_visit(child_node, level,
-							     context,
-							     return_value);
+					    ascending_callback(child_node,
+							       level, context,
+							       return_value);
 				}
 			}
 
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index f553cfd..b38b4b0 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -533,9 +533,9 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
  * PARAMETERS:  type                - acpi_object_type to search for
  *              start_object        - Handle in namespace where search begins
  *              max_depth           - Depth to which search is to reach
- *              pre_order_visit     - Called during tree pre-order visit
+ *              descending_callback - Called during tree descent
  *                                    when an object of "Type" is found
- *              post_order_visit    - Called during tree post-order visit
+ *              ascending_callback  - Called during tree ascent
  *                                    when an object of "Type" is found
  *              context             - Passed to user function(s) above
  *              return_value        - Location where return value of
@@ -563,8 +563,8 @@ acpi_status
 acpi_walk_namespace(acpi_object_type type,
 		    acpi_handle start_object,
 		    u32 max_depth,
-		    acpi_walk_callback pre_order_visit,
-		    acpi_walk_callback post_order_visit,
+		    acpi_walk_callback descending_callback,
+		    acpi_walk_callback ascending_callback,
 		    void *context, void **return_value)
 {
 	acpi_status status;
@@ -574,7 +574,7 @@ acpi_walk_namespace(acpi_object_type type,
 	/* Parameter validation */
 
 	if ((type > ACPI_TYPE_LOCAL_MAX) ||
-	    (!max_depth) || (!pre_order_visit && !post_order_visit)) {
+	    (!max_depth) || (!descending_callback && !ascending_callback)) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
@@ -606,9 +606,9 @@ acpi_walk_namespace(acpi_object_type type,
 	}
 
 	status = acpi_ns_walk_namespace(type, start_object, max_depth,
-					ACPI_NS_WALK_UNLOCK, pre_order_visit,
-					post_order_visit, context,
-					return_value);
+					ACPI_NS_WALK_UNLOCK,
+					descending_callback, ascending_callback,
+					context, return_value);
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 0dd03f2..e53f16a 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -212,8 +212,8 @@ acpi_status
 acpi_walk_namespace(acpi_object_type type,
 		    acpi_handle start_object,
 		    u32 max_depth,
-		    acpi_walk_callback pre_order_visit,
-		    acpi_walk_callback post_order_visit,
+		    acpi_walk_callback descending_callback,
+		    acpi_walk_callback ascending_callback,
 		    void *context, void **return_value);
 
 acpi_status
-- 
1.7.10

