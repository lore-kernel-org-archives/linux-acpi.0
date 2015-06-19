From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/32] ACPICA: Namespace: Add support to allow overriding objects.
Date: Fri, 19 Jun 2015 11:40:09 +0800
Message-ID: <c409ed36c1b05965618b29abf0bfcb522d7b8734.1434684720.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1434684719.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 6084e34e44565c6293f446c0202b5e59b055e351

This patch adds an "NamespaceOverride" flag in struct acpi_walk_state, and allows
namespace objects to be overridden when this flag is set. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/6084e34e
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acnamesp.h |    1 +
 drivers/acpi/acpica/acstruct.h |    1 +
 drivers/acpi/acpica/dswload.c  |   17 +++++++++++++----
 drivers/acpi/acpica/nsaccess.c |   10 +++++++++-
 drivers/acpi/acpica/nssearch.c |   22 ++++++++++++++++++++--
 5 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 952fbe0..0dd0882 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -66,6 +66,7 @@
 #define ACPI_NS_PREFIX_IS_SCOPE     0x10
 #define ACPI_NS_EXTERNAL            0x20
 #define ACPI_NS_TEMPORARY           0x40
+#define ACPI_NS_OVERRIDE_IF_FOUND   0x80
 
 /* Flags for acpi_ns_walk_namespace */
 
diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index 87c7860..44997ca 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -82,6 +82,7 @@ struct acpi_walk_state {
 	u8 return_used;
 	u8 scope_depth;
 	u8 pass_number;		/* Parse pass during table load */
+	u8 namespace_override;	/* Override existing objects */
 	u8 result_size;		/* Total elements for the result stack */
 	u8 result_count;	/* Current number of occupied elements of result stack */
 	u32 aml_offset;
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 843942f..845ff44 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -315,10 +315,19 @@ acpi_ds_load1_begin_op(struct acpi_walk_state * walk_state,
 		flags = ACPI_NS_NO_UPSEARCH;
 		if ((walk_state->opcode != AML_SCOPE_OP) &&
 		    (!(walk_state->parse_flags & ACPI_PARSE_DEFERRED_OP))) {
-			flags |= ACPI_NS_ERROR_IF_FOUND;
-			ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-					  "[%s] Cannot already exist\n",
-					  acpi_ut_get_type_name(object_type)));
+			if (walk_state->namespace_override) {
+				flags |= ACPI_NS_OVERRIDE_IF_FOUND;
+				ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
+						  "[%s] Override allowed\n",
+						  acpi_ut_get_type_name
+						  (object_type)));
+			} else {
+				flags |= ACPI_NS_ERROR_IF_FOUND;
+				ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
+						  "[%s] Cannot already exist\n",
+						  acpi_ut_get_type_name
+						  (object_type)));
+			}
 		} else {
 			ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 					  "[%s] Both Find or Create allowed\n",
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 24fa19a..19ad0b5 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -304,7 +304,9 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	local_flags = flags & ~(ACPI_NS_ERROR_IF_FOUND | ACPI_NS_SEARCH_PARENT);
+	local_flags = flags &
+	    ~(ACPI_NS_ERROR_IF_FOUND | ACPI_NS_OVERRIDE_IF_FOUND |
+	      ACPI_NS_SEARCH_PARENT);
 	*return_node = ACPI_ENTRY_NOT_FOUND;
 	acpi_gbl_ns_lookup_count++;
 
@@ -547,6 +549,12 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 			if (flags & ACPI_NS_ERROR_IF_FOUND) {
 				local_flags |= ACPI_NS_ERROR_IF_FOUND;
 			}
+
+			/* Set override flag according to caller */
+
+			if (flags & ACPI_NS_OVERRIDE_IF_FOUND) {
+				local_flags |= ACPI_NS_OVERRIDE_IF_FOUND;
+			}
 		}
 
 		/* Extract one ACPI name from the front of the pathname */
diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index 4a9d4a6..47fbe5b 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -325,8 +325,26 @@ acpi_ns_search_and_enter(u32 target_name,
 		 * If we found it AND the request specifies that a find is an error,
 		 * return the error
 		 */
-		if ((status == AE_OK) && (flags & ACPI_NS_ERROR_IF_FOUND)) {
-			status = AE_ALREADY_EXISTS;
+		if (status == AE_OK) {
+
+			/* The node was found in the namespace */
+
+			/*
+			 * If the namespace override feature is enabled for this node,
+			 * delete any existing node. This can only happen during the
+			 * boot stage, thus it is safe to remove the node here.
+			 */
+			if (flags & ACPI_NS_OVERRIDE_IF_FOUND) {
+				acpi_ns_delete_children(*return_node);
+				acpi_ns_remove_node(*return_node);
+				*return_node = ACPI_ENTRY_NOT_FOUND;
+			}
+
+			/* Return an error if we don't expect to find the object */
+
+			else if (flags & ACPI_NS_ERROR_IF_FOUND) {
+				status = AE_ALREADY_EXISTS;
+			}
 		}
 #ifdef ACPI_ASL_COMPILER
 		if (*return_node && (*return_node)->type == ACPI_TYPE_ANY) {
-- 
1.7.10
