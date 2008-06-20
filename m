From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/70] ACPICA: Add const qualifier for appropriate string
 constants
Date: Fri, 20 Jun 2008 03:43:23 -0400
Message-ID: <5d215ab86489f54daf1229ebf2eac027a97a98de.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:38101 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbYFTHon (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:43 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2R00D38467S7T1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:44:32 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Mostly MODULE_NAME and printf format strings.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exdump.c    |    5 ++-
 drivers/acpi/namespace/nsutils.c  |   24 +++++++------
 drivers/acpi/utilities/utalloc.c  |    5 ++-
 drivers/acpi/utilities/utdebug.c  |   26 +++++++++-----
 drivers/acpi/utilities/utmisc.c   |   11 +++---
 drivers/acpi/utilities/utobject.c |    5 ++-
 include/acpi/acinterp.h           |    5 ++-
 include/acpi/aclocal.h            |    4 +-
 include/acpi/acmacros.h           |    2 +-
 include/acpi/acnamesp.h           |   20 ++++++-----
 include/acpi/acutils.h            |   66 +++++++++++++++++++++---------------
 11 files changed, 99 insertions(+), 74 deletions(-)

diff --git a/drivers/acpi/executer/exdump.c b/drivers/acpi/executer/exdump.c
index 976016f..c94638d 100644
--- a/drivers/acpi/executer/exdump.c
+++ b/drivers/acpi/executer/exdump.c
@@ -771,9 +771,10 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 void
 acpi_ex_dump_operands(union acpi_operand_object **operands,
 		      acpi_interpreter_mode interpreter_mode,
-		      char *ident,
+		      const char *ident,
 		      u32 num_levels,
-		      char *note, char *module_name, u32 line_number)
+		      const char *note,
+		      const char *module_name, u32 line_number)
 {
 	u32 i;
 
diff --git a/drivers/acpi/namespace/nsutils.c b/drivers/acpi/namespace/nsutils.c
index 5b5619c..b0817e1 100644
--- a/drivers/acpi/namespace/nsutils.c
+++ b/drivers/acpi/namespace/nsutils.c
@@ -73,9 +73,9 @@ acpi_name acpi_ns_find_parent_name(struct acpi_namespace_node *node_to_search);
  ******************************************************************************/
 
 void
-acpi_ns_report_error(char *module_name,
+acpi_ns_report_error(const char *module_name,
 		     u32 line_number,
-		     char *internal_name, acpi_status lookup_status)
+		     const char *internal_name, acpi_status lookup_status)
 {
 	acpi_status status;
 	u32 bad_name;
@@ -130,11 +130,11 @@ acpi_ns_report_error(char *module_name,
  ******************************************************************************/
 
 void
-acpi_ns_report_method_error(char *module_name,
+acpi_ns_report_method_error(const char *module_name,
 			    u32 line_number,
-			    char *message,
+			    const char *message,
 			    struct acpi_namespace_node *prefix_node,
-			    char *path, acpi_status method_status)
+			    const char *path, acpi_status method_status)
 {
 	acpi_status status;
 	struct acpi_namespace_node *node = prefix_node;
@@ -167,7 +167,8 @@ acpi_ns_report_method_error(char *module_name,
  ******************************************************************************/
 
 void
-acpi_ns_print_node_pathname(struct acpi_namespace_node *node, char *message)
+acpi_ns_print_node_pathname(struct acpi_namespace_node *node,
+			    const char *message)
 {
 	struct acpi_buffer buffer;
 	acpi_status status;
@@ -296,7 +297,7 @@ u32 acpi_ns_local(acpi_object_type type)
 
 void acpi_ns_get_internal_name_length(struct acpi_namestring_info *info)
 {
-	char *next_external_char;
+	const char *next_external_char;
 	u32 i;
 
 	ACPI_FUNCTION_ENTRY();
@@ -363,7 +364,7 @@ acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info)
 {
 	u32 num_segments = info->num_segments;
 	char *internal_name = info->internal_name;
-	char *external_name = info->next_external_char;
+	const char *external_name = info->next_external_char;
 	char *result = NULL;
 	u32 i;
 
@@ -471,7 +472,8 @@ acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info)
  *
  *******************************************************************************/
 
-acpi_status acpi_ns_internalize_name(char *external_name, char **converted_name)
+acpi_status
+acpi_ns_internalize_name(const char *external_name, char **converted_name)
 {
 	char *internal_name;
 	struct acpi_namestring_info info;
@@ -527,7 +529,7 @@ acpi_status acpi_ns_internalize_name(char *external_name, char **converted_name)
 
 acpi_status
 acpi_ns_externalize_name(u32 internal_name_length,
-			 char *internal_name,
+			 const char *internal_name,
 			 u32 * converted_name_length, char **converted_name)
 {
 	u32 names_index = 0;
@@ -821,7 +823,7 @@ u32 acpi_ns_opens_scope(acpi_object_type type)
 
 acpi_status
 acpi_ns_get_node(struct acpi_namespace_node *prefix_node,
-		 char *pathname,
+		 const char *pathname,
 		 u32 flags, struct acpi_namespace_node **return_node)
 {
 	union acpi_generic_state scope_info;
diff --git a/drivers/acpi/utilities/utalloc.c b/drivers/acpi/utilities/utalloc.c
index ede0848..3dfb8a4 100644
--- a/drivers/acpi/utilities/utalloc.c
+++ b/drivers/acpi/utilities/utalloc.c
@@ -309,7 +309,8 @@ acpi_ut_initialize_buffer(struct acpi_buffer * buffer,
  *
  ******************************************************************************/
 
-void *acpi_ut_allocate(acpi_size size, u32 component, char *module, u32 line)
+void *acpi_ut_allocate(acpi_size size,
+		       u32 component, const char *module, u32 line)
 {
 	void *allocation;
 
@@ -353,7 +354,7 @@ void *acpi_ut_allocate(acpi_size size, u32 component, char *module, u32 line)
  ******************************************************************************/
 
 void *acpi_ut_allocate_zeroed(acpi_size size,
-			      u32 component, char *module, u32 line)
+			      u32 component, const char *module, u32 line)
 {
 	void *allocation;
 
diff --git a/drivers/acpi/utilities/utdebug.c b/drivers/acpi/utilities/utdebug.c
index 3919fe5..fd66ecb 100644
--- a/drivers/acpi/utilities/utdebug.c
+++ b/drivers/acpi/utilities/utdebug.c
@@ -157,7 +157,8 @@ void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_debug_print(u32 requested_debug_level,
 		    u32 line_number,
 		    const char *function_name,
-		    char *module_name, u32 component_id, char *format, ...)
+		    const char *module_name,
+		    u32 component_id, const char *format, ...)
 {
 	acpi_thread_id thread_id;
 	va_list args;
@@ -228,7 +229,8 @@ void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_debug_print_raw(u32 requested_debug_level,
 			u32 line_number,
 			const char *function_name,
-			char *module_name, u32 component_id, char *format, ...)
+			const char *module_name,
+			u32 component_id, const char *format, ...)
 {
 	va_list args;
 
@@ -261,7 +263,8 @@ ACPI_EXPORT_SYMBOL(acpi_ut_debug_print_raw)
  ******************************************************************************/
 void
 acpi_ut_trace(u32 line_number,
-	      const char *function_name, char *module_name, u32 component_id)
+	      const char *function_name,
+	      const char *module_name, u32 component_id)
 {
 
 	acpi_gbl_nesting_level++;
@@ -293,7 +296,7 @@ ACPI_EXPORT_SYMBOL(acpi_ut_trace)
 void
 acpi_ut_trace_ptr(u32 line_number,
 		  const char *function_name,
-		  char *module_name, u32 component_id, void *pointer)
+		  const char *module_name, u32 component_id, void *pointer)
 {
 	acpi_gbl_nesting_level++;
 	acpi_ut_track_stack_ptr();
@@ -324,7 +327,7 @@ acpi_ut_trace_ptr(u32 line_number,
 void
 acpi_ut_trace_str(u32 line_number,
 		  const char *function_name,
-		  char *module_name, u32 component_id, char *string)
+		  const char *module_name, u32 component_id, char *string)
 {
 
 	acpi_gbl_nesting_level++;
@@ -356,7 +359,7 @@ acpi_ut_trace_str(u32 line_number,
 void
 acpi_ut_trace_u32(u32 line_number,
 		  const char *function_name,
-		  char *module_name, u32 component_id, u32 integer)
+		  const char *module_name, u32 component_id, u32 integer)
 {
 
 	acpi_gbl_nesting_level++;
@@ -386,7 +389,8 @@ acpi_ut_trace_u32(u32 line_number,
 
 void
 acpi_ut_exit(u32 line_number,
-	     const char *function_name, char *module_name, u32 component_id)
+	     const char *function_name,
+	     const char *module_name, u32 component_id)
 {
 
 	acpi_ut_debug_print(ACPI_LV_FUNCTIONS,
@@ -417,7 +421,8 @@ ACPI_EXPORT_SYMBOL(acpi_ut_exit)
 void
 acpi_ut_status_exit(u32 line_number,
 		    const char *function_name,
-		    char *module_name, u32 component_id, acpi_status status)
+		    const char *module_name,
+		    u32 component_id, acpi_status status)
 {
 
 	if (ACPI_SUCCESS(status)) {
@@ -458,7 +463,8 @@ ACPI_EXPORT_SYMBOL(acpi_ut_status_exit)
 void
 acpi_ut_value_exit(u32 line_number,
 		   const char *function_name,
-		   char *module_name, u32 component_id, acpi_integer value)
+		   const char *module_name,
+		   u32 component_id, acpi_integer value)
 {
 
 	acpi_ut_debug_print(ACPI_LV_FUNCTIONS,
@@ -490,7 +496,7 @@ ACPI_EXPORT_SYMBOL(acpi_ut_value_exit)
 void
 acpi_ut_ptr_exit(u32 line_number,
 		 const char *function_name,
-		 char *module_name, u32 component_id, u8 * ptr)
+		 const char *module_name, u32 component_id, u8 *ptr)
 {
 
 	acpi_ut_debug_print(ACPI_LV_FUNCTIONS,
diff --git a/drivers/acpi/utilities/utmisc.c b/drivers/acpi/utilities/utmisc.c
index 6175ca5..f34be67 100644
--- a/drivers/acpi/utilities/utmisc.c
+++ b/drivers/acpi/utilities/utmisc.c
@@ -1020,7 +1020,7 @@ acpi_ut_walk_package_tree(union acpi_operand_object * source_object,
  ******************************************************************************/
 
 void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_error(char *module_name, u32 line_number, char *format, ...)
+acpi_ut_error(const char *module_name, u32 line_number, const char *format, ...)
 {
 	va_list args;
 
@@ -1033,8 +1033,8 @@ acpi_ut_error(char *module_name, u32 line_number, char *format, ...)
 }
 
 void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_exception(char *module_name,
-		  u32 line_number, acpi_status status, char *format, ...)
+acpi_ut_exception(const char *module_name,
+		  u32 line_number, acpi_status status, const char *format, ...)
 {
 	va_list args;
 
@@ -1050,7 +1050,8 @@ acpi_ut_exception(char *module_name,
 EXPORT_SYMBOL(acpi_ut_exception);
 
 void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_warning(char *module_name, u32 line_number, char *format, ...)
+acpi_ut_warning(const char *module_name,
+		u32 line_number, const char *format, ...)
 {
 	va_list args;
 
@@ -1063,7 +1064,7 @@ acpi_ut_warning(char *module_name, u32 line_number, char *format, ...)
 }
 
 void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_info(char *module_name, u32 line_number, char *format, ...)
+acpi_ut_info(const char *module_name, u32 line_number, const char *format, ...)
 {
 	va_list args;
 
diff --git a/drivers/acpi/utilities/utobject.c b/drivers/acpi/utilities/utobject.c
index ede6a80..e254844 100644
--- a/drivers/acpi/utilities/utobject.c
+++ b/drivers/acpi/utilities/utobject.c
@@ -83,7 +83,8 @@ acpi_ut_get_element_length(u8 object_type,
  *
  ******************************************************************************/
 
-union acpi_operand_object *acpi_ut_create_internal_object_dbg(char *module_name,
+union acpi_operand_object *acpi_ut_create_internal_object_dbg(const char
+							      *module_name,
 							      u32 line_number,
 							      u32 component_id,
 							      acpi_object_type
@@ -347,7 +348,7 @@ u8 acpi_ut_valid_internal_object(void *object)
  *
  ******************************************************************************/
 
-void *acpi_ut_allocate_object_desc_dbg(char *module_name,
+void *acpi_ut_allocate_object_desc_dbg(const char *module_name,
 				       u32 line_number, u32 component_id)
 {
 	union acpi_operand_object *object;
diff --git a/include/acpi/acinterp.h b/include/acpi/acinterp.h
index e249ce5..accd120 100644
--- a/include/acpi/acinterp.h
+++ b/include/acpi/acinterp.h
@@ -367,9 +367,10 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth);
 void
 acpi_ex_dump_operands(union acpi_operand_object **operands,
 		      acpi_interpreter_mode interpreter_mode,
-		      char *ident,
+		      const char *ident,
 		      u32 num_levels,
-		      char *note, char *module_name, u32 line_number);
+		      const char *note,
+		      const char *module_name, u32 line_number);
 
 #ifdef	ACPI_FUTURE_USAGE
 void
diff --git a/include/acpi/aclocal.h b/include/acpi/aclocal.h
index c5cdc32..39dcda7 100644
--- a/include/acpi/aclocal.h
+++ b/include/acpi/aclocal.h
@@ -282,8 +282,8 @@ struct acpi_predefined_names {
 /* Info structure used to convert external<->internal namestrings */
 
 struct acpi_namestring_info {
-	char *external_name;
-	char *next_external_char;
+	const char *external_name;
+	const char *next_external_char;
 	char *internal_name;
 	u32 length;
 	u32 num_segments;
diff --git a/include/acpi/acmacros.h b/include/acpi/acmacros.h
index 9039ea8..fcdf709 100644
--- a/include/acpi/acmacros.h
+++ b/include/acpi/acmacros.h
@@ -414,7 +414,7 @@ struct acpi_integer_overlay {
  * error messages. The __FILE__ macro is not very useful for this, because it
  * often includes the entire pathname to the module
  */
-#define ACPI_MODULE_NAME(name)          static char ACPI_UNUSED_VAR _acpi_module_name[] = name;
+#define ACPI_MODULE_NAME(name)          static const char ACPI_UNUSED_VAR _acpi_module_name[] = name;
 #else
 #define ACPI_MODULE_NAME(name)
 #endif
diff --git a/include/acpi/acnamesp.h b/include/acpi/acnamesp.h
index d622c30..9ed70a0 100644
--- a/include/acpi/acnamesp.h
+++ b/include/acpi/acnamesp.h
@@ -199,7 +199,7 @@ acpi_ns_pattern_match(struct acpi_namespace_node *obj_node, char *search_for);
 
 acpi_status
 acpi_ns_get_node(struct acpi_namespace_node *prefix_node,
-		 char *external_pathname,
+		 const char *external_pathname,
 		 u32 flags, struct acpi_namespace_node **out_node);
 
 acpi_size acpi_ns_get_pathname_length(struct acpi_namespace_node *node);
@@ -263,28 +263,30 @@ acpi_object_type acpi_ns_get_type(struct acpi_namespace_node *node);
 u32 acpi_ns_local(acpi_object_type type);
 
 void
-acpi_ns_report_error(char *module_name,
+acpi_ns_report_error(const char *module_name,
 		     u32 line_number,
-		     char *internal_name, acpi_status lookup_status);
+		     const char *internal_name, acpi_status lookup_status);
 
 void
-acpi_ns_report_method_error(char *module_name,
+acpi_ns_report_method_error(const char *module_name,
 			    u32 line_number,
-			    char *message,
+			    const char *message,
 			    struct acpi_namespace_node *node,
-			    char *path, acpi_status lookup_status);
+			    const char *path, acpi_status lookup_status);
 
-void acpi_ns_print_node_pathname(struct acpi_namespace_node *node, char *msg);
+void
+acpi_ns_print_node_pathname(struct acpi_namespace_node *node, const char *msg);
 
 acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info);
 
 void acpi_ns_get_internal_name_length(struct acpi_namestring_info *info);
 
-acpi_status acpi_ns_internalize_name(char *dotted_name, char **converted_name);
+acpi_status
+acpi_ns_internalize_name(const char *dotted_name, char **converted_name);
 
 acpi_status
 acpi_ns_externalize_name(u32 internal_name_length,
-			 char *internal_name,
+			 const char *internal_name,
 			 u32 * converted_name_length, char **converted_name);
 
 struct acpi_namespace_node *acpi_ns_map_handle_to_node(acpi_handle handle);
diff --git a/include/acpi/acutils.h b/include/acpi/acutils.h
index 3f663a0..69f8888 100644
--- a/include/acpi/acutils.h
+++ b/include/acpi/acutils.h
@@ -245,41 +245,45 @@ void acpi_ut_track_stack_ptr(void);
 
 void
 acpi_ut_trace(u32 line_number,
-	      const char *function_name, char *module_name, u32 component_id);
+	      const char *function_name,
+	      const char *module_name, u32 component_id);
 
 void
 acpi_ut_trace_ptr(u32 line_number,
 		  const char *function_name,
-		  char *module_name, u32 component_id, void *pointer);
+		  const char *module_name, u32 component_id, void *pointer);
 
 void
 acpi_ut_trace_u32(u32 line_number,
 		  const char *function_name,
-		  char *module_name, u32 component_id, u32 integer);
+		  const char *module_name, u32 component_id, u32 integer);
 
 void
 acpi_ut_trace_str(u32 line_number,
 		  const char *function_name,
-		  char *module_name, u32 component_id, char *string);
+		  const char *module_name, u32 component_id, char *string);
 
 void
 acpi_ut_exit(u32 line_number,
-	     const char *function_name, char *module_name, u32 component_id);
+	     const char *function_name,
+	     const char *module_name, u32 component_id);
 
 void
 acpi_ut_status_exit(u32 line_number,
 		    const char *function_name,
-		    char *module_name, u32 component_id, acpi_status status);
+		    const char *module_name,
+		    u32 component_id, acpi_status status);
 
 void
 acpi_ut_value_exit(u32 line_number,
 		   const char *function_name,
-		   char *module_name, u32 component_id, acpi_integer value);
+		   const char *module_name,
+		   u32 component_id, acpi_integer value);
 
 void
 acpi_ut_ptr_exit(u32 line_number,
 		 const char *function_name,
-		 char *module_name, u32 component_id, u8 * ptr);
+		 const char *module_name, u32 component_id, u8 *ptr);
 
 void acpi_ut_dump_buffer(u8 * buffer, u32 count, u32 display, u32 component_id);
 
@@ -297,33 +301,35 @@ void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_debug_print(u32 requested_debug_level,
 		    u32 line_number,
 		    const char *function_name,
-		    char *module_name,
-		    u32 component_id, char *format, ...) ACPI_PRINTF_LIKE(6);
+		    const char *module_name,
+		    u32 component_id,
+		    const char *format, ...) ACPI_PRINTF_LIKE(6);
 
 void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_debug_print_raw(u32 requested_debug_level,
 			u32 line_number,
 			const char *function_name,
-			char *module_name,
+			const char *module_name,
 			u32 component_id,
-			char *format, ...) ACPI_PRINTF_LIKE(6);
+			const char *format, ...) ACPI_PRINTF_LIKE(6);
 
 void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_error(char *module_name,
-	      u32 line_number, char *format, ...) ACPI_PRINTF_LIKE(3);
+acpi_ut_error(const char *module_name,
+	      u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE(3);
 
 void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_exception(char *module_name,
+acpi_ut_exception(const char *module_name,
 		  u32 line_number,
-		  acpi_status status, char *format, ...) ACPI_PRINTF_LIKE(4);
+		  acpi_status status,
+		  const char *format, ...) ACPI_PRINTF_LIKE(4);
 
 void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_warning(char *module_name,
-		u32 line_number, char *format, ...) ACPI_PRINTF_LIKE(3);
+acpi_ut_warning(const char *module_name,
+		u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE(3);
 
 void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_info(char *module_name,
-	     u32 line_number, char *format, ...) ACPI_PRINTF_LIKE(3);
+acpi_ut_info(const char *module_name,
+	     u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE(3);
 
 /*
  * utdelete - Object deletion and reference counts
@@ -376,13 +382,14 @@ acpi_ut_execute_sxds(struct acpi_namespace_node *device_node, u8 * highest);
 /*
  * utobject - internal object create/delete/cache routines
  */
-union acpi_operand_object *acpi_ut_create_internal_object_dbg(char *module_name,
+union acpi_operand_object *acpi_ut_create_internal_object_dbg(const char
+							      *module_name,
 							      u32 line_number,
 							      u32 component_id,
 							      acpi_object_type
 							      type);
 
-void *acpi_ut_allocate_object_desc_dbg(char *module_name,
+void *acpi_ut_allocate_object_desc_dbg(const char *module_name,
 				       u32 line_number, u32 component_id);
 
 #define acpi_ut_create_internal_object(t) acpi_ut_create_internal_object_dbg (_acpi_module_name,__LINE__,_COMPONENT,t)
@@ -543,26 +550,29 @@ acpi_status
 acpi_ut_initialize_buffer(struct acpi_buffer *buffer,
 			  acpi_size required_length);
 
-void *acpi_ut_allocate(acpi_size size, u32 component, char *module, u32 line);
+void *acpi_ut_allocate(acpi_size size,
+		       u32 component, const char *module, u32 line);
 
 void *acpi_ut_allocate_zeroed(acpi_size size,
-			      u32 component, char *module, u32 line);
+			      u32 component, const char *module, u32 line);
 
 #ifdef ACPI_DBG_TRACK_ALLOCATIONS
 void *acpi_ut_allocate_and_track(acpi_size size,
-				 u32 component, char *module, u32 line);
+				 u32 component, const char *module, u32 line);
 
 void *acpi_ut_allocate_zeroed_and_track(acpi_size size,
-					u32 component, char *module, u32 line);
+					u32 component,
+					const char *module, u32 line);
 
 void
-acpi_ut_free_and_track(void *address, u32 component, char *module, u32 line);
+acpi_ut_free_and_track(void *address,
+		       u32 component, const char *module, u32 line);
 
 #ifdef	ACPI_FUTURE_USAGE
 void acpi_ut_dump_allocation_info(void);
 #endif				/* ACPI_FUTURE_USAGE */
 
-void acpi_ut_dump_allocations(u32 component, char *module);
+void acpi_ut_dump_allocations(u32 component, const char *module);
 
 acpi_status
 acpi_ut_create_list(char *list_name,
-- 
1.5.6

