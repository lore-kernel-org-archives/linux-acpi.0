From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/27] ACPICA: Eliminate some small unnecessary pathname functions.
Date: Mon, 31 Dec 2012 08:05:17 +0800
Message-ID: <6f9a8c4aa6717fc7281a42fef1408aa5732dca4e.1356668533.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48001 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAFg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:05:36 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Removed several small pathname functions to increase efficiency.
Essentially, they replace a function call with a single compare.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acmacros.h |    6 ++++
 drivers/acpi/acpica/acnamesp.h |    2 --
 drivers/acpi/acpica/acparser.h |    2 --
 drivers/acpi/acpica/nsutils.c  |   60 ++++++++--------------------------------
 drivers/acpi/acpica/nsxfeval.c |    2 +-
 drivers/acpi/acpica/nsxfname.c |    2 +-
 drivers/acpi/acpica/psargs.c   |    5 ++--
 drivers/acpi/acpica/psutils.c  |    8 ------
 8 files changed, 22 insertions(+), 65 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 3ba11d2..edfcbc8 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -311,6 +311,12 @@
 #define ACPI_EXTRACT_3BIT_FLAG(field, position)     (ACPI_GET_3BIT_FLAG ((field) >> position))
 #define ACPI_EXTRACT_4BIT_FLAG(field, position)     (ACPI_GET_4BIT_FLAG ((field) >> position))
 
+/* ACPI Pathname helpers */
+
+#define ACPI_IS_ROOT_PREFIX(c)      ((c) == (u8) 0x5C)	/* Backslash */
+#define ACPI_IS_PARENT_PREFIX(c)    ((c) == (u8) 0x5E)	/* Carat */
+#define ACPI_IS_PATH_SEPARATOR(c)   ((c) == (u8) 0x2E)	/* Period (dot) */
+
 /*
  * An object of type struct acpi_namespace_node can appear in some contexts
  * where a pointer to an object of type union acpi_operand_object can also
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 9b19d4b..b826d9c 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -333,8 +333,6 @@ acpi_ns_install_node(struct acpi_walk_state *walk_state,
 /*
  * nsutils - Utility functions
  */
-u8 acpi_ns_valid_root_prefix(char prefix);
-
 acpi_object_type acpi_ns_get_type(struct acpi_namespace_node *node);
 
 u32 acpi_ns_local(acpi_object_type type);
diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
index eefcf47..24a5905 100644
--- a/drivers/acpi/acpica/acparser.h
+++ b/drivers/acpi/acpica/acparser.h
@@ -211,8 +211,6 @@ void acpi_ps_free_op(union acpi_parse_object *op);
 
 u8 acpi_ps_is_leading_char(u32 c);
 
-u8 acpi_ps_is_prefix_char(u32 c);
-
 #ifdef	ACPI_FUTURE_USAGE
 u32 acpi_ps_get_name(union acpi_parse_object *op);
 #endif				/* ACPI_FUTURE_USAGE */
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 4479654..d2dfe61 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -51,8 +51,6 @@
 ACPI_MODULE_NAME("nsutils")
 
 /* Local prototypes */
-static u8 acpi_ns_valid_path_separator(char sep);
-
 #ifdef ACPI_OBSOLETE_FUNCTIONS
 acpi_name acpi_ns_find_parent_name(struct acpi_namespace_node *node_to_search);
 #endif
@@ -98,42 +96,6 @@ acpi_ns_print_node_pathname(struct acpi_namespace_node *node,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ns_valid_root_prefix
- *
- * PARAMETERS:  prefix          - Character to be checked
- *
- * RETURN:      TRUE if a valid prefix
- *
- * DESCRIPTION: Check if a character is a valid ACPI Root prefix
- *
- ******************************************************************************/
-
-u8 acpi_ns_valid_root_prefix(char prefix)
-{
-
-	return ((u8)(prefix == '\\'));
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ns_valid_path_separator
- *
- * PARAMETERS:  sep         - Character to be checked
- *
- * RETURN:      TRUE if a valid path separator
- *
- * DESCRIPTION: Check if a character is a valid ACPI path separator
- *
- ******************************************************************************/
-
-static u8 acpi_ns_valid_path_separator(char sep)
-{
-
-	return ((u8)(sep == '.'));
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ns_get_type
  *
  * PARAMETERS:  node        - Parent Node to be examined
@@ -217,19 +179,19 @@ void acpi_ns_get_internal_name_length(struct acpi_namestring_info *info)
 	 *
 	 * strlen() + 1 covers the first name_seg, which has no path separator
 	 */
-	if (acpi_ns_valid_root_prefix(*next_external_char)) {
+	if (ACPI_IS_ROOT_PREFIX(*next_external_char)) {
 		info->fully_qualified = TRUE;
 		next_external_char++;
 
 		/* Skip redundant root_prefix, like \\_SB.PCI0.SBRG.EC0 */
 
-		while (acpi_ns_valid_root_prefix(*next_external_char)) {
+		while (ACPI_IS_ROOT_PREFIX(*next_external_char)) {
 			next_external_char++;
 		}
 	} else {
 		/* Handle Carat prefixes */
 
-		while (*next_external_char == '^') {
+		while (ACPI_IS_PARENT_PREFIX(*next_external_char)) {
 			info->num_carats++;
 			next_external_char++;
 		}
@@ -243,7 +205,7 @@ void acpi_ns_get_internal_name_length(struct acpi_namestring_info *info)
 	if (*next_external_char) {
 		info->num_segments = 1;
 		for (i = 0; next_external_char[i]; i++) {
-			if (acpi_ns_valid_path_separator(next_external_char[i])) {
+			if (ACPI_IS_PATH_SEPARATOR(next_external_char[i])) {
 				info->num_segments++;
 			}
 		}
@@ -281,7 +243,7 @@ acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info)
 	/* Setup the correct prefixes, counts, and pointers */
 
 	if (info->fully_qualified) {
-		internal_name[0] = '\\';
+		internal_name[0] = AML_ROOT_PREFIX;
 
 		if (num_segments <= 1) {
 			result = &internal_name[1];
@@ -301,7 +263,7 @@ acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info)
 		i = 0;
 		if (info->num_carats) {
 			for (i = 0; i < info->num_carats; i++) {
-				internal_name[i] = '^';
+				internal_name[i] = AML_PARENT_PREFIX;
 			}
 		}
 
@@ -321,7 +283,7 @@ acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info)
 
 	for (; num_segments; num_segments--) {
 		for (i = 0; i < ACPI_NAME_SIZE; i++) {
-			if (acpi_ns_valid_path_separator(*external_name) ||
+			if (ACPI_IS_PATH_SEPARATOR(*external_name) ||
 			    (*external_name == 0)) {
 
 				/* Pad the segment with underscore(s) if segment is short */
@@ -338,7 +300,7 @@ acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info)
 
 		/* Now we must have a path separator, or the pathname is bad */
 
-		if (!acpi_ns_valid_path_separator(*external_name) &&
+		if (!ACPI_IS_PATH_SEPARATOR(*external_name) &&
 		    (*external_name != 0)) {
 			return_ACPI_STATUS(AE_BAD_PATHNAME);
 		}
@@ -456,13 +418,13 @@ acpi_ns_externalize_name(u32 internal_name_length,
 	/* Check for a prefix (one '\' | one or more '^') */
 
 	switch (internal_name[0]) {
-	case '\\':
+	case AML_ROOT_PREFIX:
 		prefix_length = 1;
 		break;
 
-	case '^':
+	case AML_PARENT_PREFIX:
 		for (i = 0; i < internal_name_length; i++) {
-			if (internal_name[i] == '^') {
+			if (ACPI_IS_PARENT_PREFIX(internal_name[i])) {
 				prefix_length = i + 1;
 			} else {
 				break;
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index ef29925..1070eee 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -236,7 +236,7 @@ acpi_evaluate_object(acpi_handle handle,
 	 * 2) No handle, not fully qualified pathname (error)
 	 * 3) Valid handle
 	 */
-	if ((pathname) && (acpi_ns_valid_root_prefix(pathname[0]))) {
+	if ((pathname) && (ACPI_IS_ROOT_PREFIX(pathname[0]))) {
 
 		/* The path is fully qualified, just evaluate by name */
 
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index a8deae8..1664fad 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -107,7 +107,7 @@ acpi_get_handle(acpi_handle parent,
 	 *
 	 * Error for <null Parent + relative path>
 	 */
-	if (acpi_ns_valid_root_prefix(pathname[0])) {
+	if (ACPI_IS_ROOT_PREFIX(pathname[0])) {
 
 		/* Pathname is fully qualified (starts with '\') */
 
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index cb79e2d..9f31893 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -162,7 +162,7 @@ char *acpi_ps_get_next_namestring(struct acpi_parse_state *parser_state)
 
 	/* Point past any namestring prefix characters (backslash or carat) */
 
-	while (acpi_ps_is_prefix_char(*end)) {
+	while (ACPI_IS_ROOT_PREFIX(*end) || ACPI_IS_PARENT_PREFIX(*end)) {
 		end++;
 	}
 
@@ -798,7 +798,8 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 		subop = acpi_ps_peek_opcode(parser_state);
 		if (subop == 0 ||
 		    acpi_ps_is_leading_char(subop) ||
-		    acpi_ps_is_prefix_char(subop)) {
+		    ACPI_IS_ROOT_PREFIX(subop) ||
+		    ACPI_IS_PARENT_PREFIX(subop)) {
 
 			/* null_name or name_string */
 
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index afefb3a1..2bbf670 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -202,14 +202,6 @@ u8 acpi_ps_is_leading_char(u32 c)
 }
 
 /*
- * Is "c" a namestring prefix character?
- */
-u8 acpi_ps_is_prefix_char(u32 c)
-{
-	return ((u8)(c == '\\' || c == '^'));
-}
-
-/*
  * Get op's name (4-byte name segment) or 0 if unnamed
  */
 #ifdef ACPI_FUTURE_USAGE
-- 
1.7.10

