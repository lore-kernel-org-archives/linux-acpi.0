From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/14] ACPICA: Namespace: Add acpi_ns_get_node_unlocked()
Date: Wed,  7 Sep 2016 14:07:02 +0800
Message-ID: <48958b2ab0752e16fa3265300e729ce1f5265388.1473226204.git.lv.zheng@intel.com>
References: <cover.1473226203.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:3204 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752707AbcIGGHJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Sep 2016 02:07:09 -0400
In-Reply-To: <cover.1473226203.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 3ef1a1bf5612fe1a629424c09eaaeb6f299d313c

Add acpi_ns_get_node_unlocked() to be used when ACPI_MTX_NAMESPACE is
locked. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/3ef1a1bf
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Greg White <gwhite@kupulau.com>
Tested-by: Dutch Guy <lucht_piloot@gmx.net>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acnamesp.h |    5 +++
 drivers/acpi/acpica/nsutils.c  |   66 ++++++++++++++++++++++++++++++----------
 2 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 829672a..bb7fca1 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -299,6 +299,11 @@ u8
 acpi_ns_pattern_match(struct acpi_namespace_node *obj_node, char *search_for);
 
 acpi_status
+acpi_ns_get_node_unlocked(struct acpi_namespace_node *prefix_node,
+			  const char *external_pathname,
+			  u32 flags, struct acpi_namespace_node **out_node);
+
+acpi_status
 acpi_ns_get_node(struct acpi_namespace_node *prefix_node,
 		 const char *external_pathname,
 		 u32 flags, struct acpi_namespace_node **out_node);
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 784a30b..691814d 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -662,7 +662,7 @@ u32 acpi_ns_opens_scope(acpi_object_type type)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ns_get_node
+ * FUNCTION:    acpi_ns_get_node_unlocked
  *
  * PARAMETERS:  *pathname   - Name to be found, in external (ASL) format. The
  *                            \ (backslash) and ^ (carat) prefixes, and the
@@ -678,20 +678,21 @@ u32 acpi_ns_opens_scope(acpi_object_type type)
  * DESCRIPTION: Look up a name relative to a given scope and return the
  *              corresponding Node. NOTE: Scope can be null.
  *
- * MUTEX:       Locks namespace
+ * MUTEX:       Doesn't locks namespace
  *
  ******************************************************************************/
 
 acpi_status
-acpi_ns_get_node(struct acpi_namespace_node *prefix_node,
-		 const char *pathname,
-		 u32 flags, struct acpi_namespace_node **return_node)
+acpi_ns_get_node_unlocked(struct acpi_namespace_node *prefix_node,
+			  const char *pathname,
+			  u32 flags, struct acpi_namespace_node **return_node)
 {
 	union acpi_generic_state scope_info;
 	acpi_status status;
 	char *internal_path;
 
-	ACPI_FUNCTION_TRACE_PTR(ns_get_node, ACPI_CAST_PTR(char, pathname));
+	ACPI_FUNCTION_TRACE_PTR(ns_get_node_unlocked,
+				ACPI_CAST_PTR(char, pathname));
 
 	/* Simplest case is a null pathname */
 
@@ -718,13 +719,6 @@ acpi_ns_get_node(struct acpi_namespace_node *prefix_node,
 		return_ACPI_STATUS(status);
 	}
 
-	/* Must lock namespace during lookup */
-
-	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
-	if (ACPI_FAILURE(status)) {
-		goto cleanup;
-	}
-
 	/* Setup lookup scope (search starting point) */
 
 	scope_info.scope.node = prefix_node;
@@ -740,9 +734,49 @@ acpi_ns_get_node(struct acpi_namespace_node *prefix_node,
 				  pathname, acpi_format_exception(status)));
 	}
 
-	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
-
-cleanup:
 	ACPI_FREE(internal_path);
 	return_ACPI_STATUS(status);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_get_node
+ *
+ * PARAMETERS:  *pathname   - Name to be found, in external (ASL) format. The
+ *                            \ (backslash) and ^ (carat) prefixes, and the
+ *                            . (period) to separate segments are supported.
+ *              prefix_node  - Root of subtree to be searched, or NS_ALL for the
+ *                            root of the name space. If Name is fully
+ *                            qualified (first s8 is '\'), the passed value
+ *                            of Scope will not be accessed.
+ *              flags       - Used to indicate whether to perform upsearch or
+ *                            not.
+ *              return_node - Where the Node is returned
+ *
+ * DESCRIPTION: Look up a name relative to a given scope and return the
+ *              corresponding Node. NOTE: Scope can be null.
+ *
+ * MUTEX:       Locks namespace
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ns_get_node(struct acpi_namespace_node *prefix_node,
+		 const char *pathname,
+		 u32 flags, struct acpi_namespace_node **return_node)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE_PTR(ns_get_node, ACPI_CAST_PTR(char, pathname));
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	status = acpi_ns_get_node_unlocked(prefix_node, pathname,
+					   flags, return_node);
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+	return_ACPI_STATUS(status);
+}
-- 
1.7.10

