From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 19/30] ACPICA: All: const keyword changes across the ACPICA source
Date: Thu, 24 Mar 2016 09:40:40 +0800
Message-ID: <87c1184a632c31b9f877b8ada1cd65552997750a.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit a240cbb93647bddf525b3daf6e9d31b8b9bca34e

Integrated most changes proposed by net_BSD.
>From joerg@net_BSD.org (Joerg Sonnenberger)
ACPICA BZ 732.

Link: https://github.com/acpica/acpica/commit/a240cbb9
Link: https://bugs.acpica.org/show_bug.cgi?id=732
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acdebug.h  |    4 ++--
 drivers/acpi/acpica/acglobal.h |    2 ++
 drivers/acpi/acpica/acinterp.h |    2 +-
 drivers/acpi/acpica/acnamesp.h |    5 ++--
 drivers/acpi/acpica/acparser.h |    2 +-
 drivers/acpi/acpica/acresrc.h  |    4 ++--
 drivers/acpi/acpica/acstruct.h |    2 +-
 drivers/acpi/acpica/acutils.h  |   14 ++++++-----
 drivers/acpi/acpica/dbinput.c  |   13 ++++++-----
 drivers/acpi/acpica/dbutils.c  |    9 ++++----
 drivers/acpi/acpica/evregion.c |    3 ++-
 drivers/acpi/acpica/exdump.c   |   15 ++++++------
 drivers/acpi/acpica/hwxface.c  |    4 +---
 drivers/acpi/acpica/nsaccess.c |    7 +++---
 drivers/acpi/acpica/nsdump.c   |    9 ++++++--
 drivers/acpi/acpica/psopinfo.c |    2 +-
 drivers/acpi/acpica/rsdump.c   |   50 +++++++++++++++++-----------------------
 drivers/acpi/acpica/rsutils.c  |    2 +-
 drivers/acpi/acpica/tbfadt.c   |    8 +++----
 drivers/acpi/acpica/utdebug.c  |   47 ++++++++++++++++++-------------------
 drivers/acpi/acpica/uteval.c   |    4 ++--
 drivers/acpi/acpica/utglobal.c |    5 ++++
 drivers/acpi/acpica/utmisc.c   |    2 +-
 drivers/acpi/acpica/utprint.c  |    5 ----
 drivers/acpi/acpica/uttrack.c  |    2 +-
 include/acpi/actypes.h         |    4 ++--
 26 files changed, 113 insertions(+), 113 deletions(-)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 993af9e..9e2e080 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -53,7 +53,7 @@
 #define ACPI_DEBUG_BUFFER_SIZE  0x4000	/* 16K buffer for return objects */
 
 struct acpi_db_command_info {
-	char *name;		/* Command Name */
+	const char *name;	/* Command Name */
 	u8 min_args;		/* Minimum arguments required */
 };
 
@@ -64,7 +64,7 @@ struct acpi_db_command_help {
 };
 
 struct acpi_db_argument_info {
-	char *name;		/* Argument Name */
+	const char *name;	/* Argument Name */
 };
 
 struct acpi_db_execute_walk {
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 54b42a5..fded776 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -187,6 +187,8 @@ extern const char *acpi_gbl_sleep_state_names[ACPI_S_STATE_COUNT];
 extern const char *acpi_gbl_lowest_dstate_names[ACPI_NUM_sx_w_METHODS];
 extern const char *acpi_gbl_highest_dstate_names[ACPI_NUM_sx_d_METHODS];
 extern const char *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS];
+extern const char acpi_gbl_lower_hex_digits[];
+extern const char acpi_gbl_upper_hex_digits[];
 extern const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES];
 
 #ifdef ACPI_DBG_TRACK_ALLOCATIONS
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index bae1a35..8b09d28 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -67,7 +67,7 @@
 typedef const struct acpi_exdump_info {
 	u8 opcode;
 	u8 offset;
-	char *name;
+	const char *name;
 
 } acpi_exdump_info;
 
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 022d69c..f33a4ba 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -206,9 +206,10 @@ void acpi_ns_dump_tables(acpi_handle search_base, u32 max_depth);
 void acpi_ns_dump_entry(acpi_handle handle, u32 debug_level);
 
 void
-acpi_ns_dump_pathname(acpi_handle handle, char *msg, u32 level, u32 component);
+acpi_ns_dump_pathname(acpi_handle handle,
+		      const char *msg, u32 level, u32 component);
 
-void acpi_ns_print_pathname(u32 num_segments, char *pathname);
+void acpi_ns_print_pathname(u32 num_segments, const char *pathname);
 
 acpi_status
 acpi_ns_dump_one_object(acpi_handle obj_handle,
diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
index 7da639d..fc30577 100644
--- a/drivers/acpi/acpica/acparser.h
+++ b/drivers/acpi/acpica/acparser.h
@@ -139,7 +139,7 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
  */
 const struct acpi_opcode_info *acpi_ps_get_opcode_info(u16 opcode);
 
-char *acpi_ps_get_opcode_name(u16 opcode);
+const char *acpi_ps_get_opcode_name(u16 opcode);
 
 u8 acpi_ps_get_argument_count(u32 op_type);
 
diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index 5dd58be..83e9a29 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -124,7 +124,7 @@ typedef enum {
 typedef const struct acpi_rsdump_info {
 	u8 opcode;
 	u8 offset;
-	char *name;
+	const char *name;
 	const char **pointer;
 
 } acpi_rsdump_info;
@@ -209,7 +209,7 @@ acpi_rs_get_prs_method_data(struct acpi_namespace_node *node,
 
 acpi_status
 acpi_rs_get_method_data(acpi_handle handle,
-			char *path, struct acpi_buffer *ret_buffer);
+			const char *path, struct acpi_buffer *ret_buffer);
 
 acpi_status
 acpi_rs_set_srs_method_data(struct acpi_namespace_node *node,
diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index b3b386e..6235642 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -184,7 +184,7 @@ struct acpi_evaluate_info {
 	/* The first 3 elements are passed by the caller to acpi_ns_evaluate */
 
 	struct acpi_namespace_node *prefix_node;	/* Input: starting node */
-	char *relative_pathname;	/* Input: path relative to prefix_node */
+	const char *relative_pathname;	/* Input: path relative to prefix_node */
 	union acpi_operand_object **parameters;	/* Input: argument list */
 
 	struct acpi_namespace_node *node;	/* Resolved node (prefix_node:relative_pathname) */
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 7422ff7..4ff971c 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -273,7 +273,8 @@ acpi_ut_trace(u32 line_number,
 void
 acpi_ut_trace_ptr(u32 line_number,
 		  const char *function_name,
-		  const char *module_name, u32 component_id, void *pointer);
+		  const char *module_name,
+		  u32 component_id, const void *pointer);
 
 void
 acpi_ut_trace_u32(u32 line_number,
@@ -283,7 +284,8 @@ acpi_ut_trace_u32(u32 line_number,
 void
 acpi_ut_trace_str(u32 line_number,
 		  const char *function_name,
-		  const char *module_name, u32 component_id, char *string);
+		  const char *module_name,
+		  u32 component_id, const char *string);
 
 void
 acpi_ut_exit(u32 line_number,
@@ -342,12 +344,12 @@ void acpi_ut_delete_internal_object_list(union acpi_operand_object **obj_list);
  */
 acpi_status
 acpi_ut_evaluate_object(struct acpi_namespace_node *prefix_node,
-			char *path,
+			const char *path,
 			u32 expected_return_btypes,
 			union acpi_operand_object **return_desc);
 
 acpi_status
-acpi_ut_evaluate_numeric_object(char *object_name,
+acpi_ut_evaluate_numeric_object(const char *object_name,
 				struct acpi_namespace_node *device_node,
 				u64 *value);
 
@@ -533,7 +535,7 @@ void acpi_ut_set_integer_width(u8 revision);
 void
 acpi_ut_display_init_pathname(u8 type,
 			      struct acpi_namespace_node *obj_handle,
-			      char *path);
+			      const char *path);
 #endif
 
 /*
@@ -635,7 +637,7 @@ void acpi_ut_dump_allocation_info(void);
 void acpi_ut_dump_allocations(u32 component, const char *module);
 
 acpi_status
-acpi_ut_create_list(char *list_name,
+acpi_ut_create_list(const char *list_name,
 		    u16 object_size, struct acpi_memory_list **return_cache);
 
 #endif				/* ACPI_DBG_TRACK_ALLOCATIONS */
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index 417c02a..f53cb30 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -57,12 +57,12 @@ static u32 acpi_db_get_line(char *input_buffer);
 
 static u32 acpi_db_match_command(char *user_command);
 
-static void acpi_db_display_command_info(char *command, u8 display_all);
+static void acpi_db_display_command_info(const char *command, u8 display_all);
 
 static void acpi_db_display_help(char *command);
 
 static u8
-acpi_db_match_command_help(char *command,
+acpi_db_match_command_help(const char *command,
 			   const struct acpi_db_command_help *help);
 
 /*
@@ -348,7 +348,7 @@ static const struct acpi_db_command_help acpi_gbl_db_command_help[] = {
  ******************************************************************************/
 
 static u8
-acpi_db_match_command_help(char *command,
+acpi_db_match_command_help(const char *command,
 			   const struct acpi_db_command_help *help)
 {
 	char *invocation = help->invocation;
@@ -402,7 +402,7 @@ acpi_db_match_command_help(char *command,
  *
  ******************************************************************************/
 
-static void acpi_db_display_command_info(char *command, u8 display_all)
+static void acpi_db_display_command_info(const char *command, u8 display_all)
 {
 	const struct acpi_db_command_help *next;
 	u8 matched;
@@ -656,8 +656,9 @@ static u32 acpi_db_match_command(char *user_command)
 	}
 
 	for (i = CMD_FIRST_VALID; acpi_gbl_db_commands[i].name; i++) {
-		if (strstr(acpi_gbl_db_commands[i].name, user_command) ==
-		    acpi_gbl_db_commands[i].name) {
+		if (strstr
+		    (ACPI_CAST_PTR(char, acpi_gbl_db_commands[i].name),
+		     user_command) == acpi_gbl_db_commands[i].name) {
 			return (i);
 		}
 	}
diff --git a/drivers/acpi/acpica/dbutils.c b/drivers/acpi/acpica/dbutils.c
index b37a2c7..ae80106 100644
--- a/drivers/acpi/acpica/dbutils.c
+++ b/drivers/acpi/acpica/dbutils.c
@@ -56,8 +56,6 @@ acpi_status acpi_db_second_pass_parse(union acpi_parse_object *root);
 void acpi_db_dump_buffer(u32 address);
 #endif
 
-static char *gbl_hex_to_ascii = "0123456789ABCDEF";
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_db_match_argument
@@ -82,8 +80,9 @@ acpi_db_match_argument(char *user_argument,
 	}
 
 	for (i = 0; arguments[i].name; i++) {
-		if (strstr(arguments[i].name, user_argument) ==
-		    arguments[i].name) {
+		if (strstr(ACPI_CAST_PTR(char, arguments[i].name),
+			   ACPI_CAST_PTR(char,
+					 user_argument)) == arguments[i].name) {
 			return (i);
 		}
 	}
@@ -339,7 +338,7 @@ void acpi_db_uint32_to_hex_string(u32 value, char *buffer)
 	buffer[8] = '\0';
 
 	for (i = 7; i >= 0; i--) {
-		buffer[i] = gbl_hex_to_ascii[value & 0x0F];
+		buffer[i] = acpi_gbl_upper_hex_digits[value & 0x0F];
 		value = value >> 4;
 	}
 }
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 63924d1..17d61c6 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -538,7 +538,8 @@ acpi_ev_attach_region(union acpi_operand_object *handler_obj,
 
 void acpi_ev_associate_reg_method(union acpi_operand_object *region_obj)
 {
-	acpi_name *reg_name_ptr = (acpi_name *) METHOD_NAME__REG;
+	const acpi_name *reg_name_ptr =
+	    ACPI_CAST_PTR(acpi_name, METHOD_NAME__REG);
 	struct acpi_namespace_node *method_node;
 	struct acpi_namespace_node *node;
 	union acpi_operand_object *region_obj2;
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index ee30974..fce6b2e 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -55,9 +55,9 @@ ACPI_MODULE_NAME("exdump")
  */
 #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
 /* Local prototypes */
-static void acpi_ex_out_string(char *title, char *value);
+static void acpi_ex_out_string(const char *title, const char *value);
 
-static void acpi_ex_out_pointer(char *title, void *value);
+static void acpi_ex_out_pointer(const char *title, const void *value);
 
 static void
 acpi_ex_dump_object(union acpi_operand_object *obj_desc,
@@ -365,8 +365,7 @@ acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 		    struct acpi_exdump_info *info)
 {
 	u8 *target;
-	char *name;
-	const char *reference_name;
+	const char *name;
 	u8 count;
 	union acpi_operand_object *start;
 	union acpi_operand_object *data = NULL;
@@ -459,9 +458,9 @@ acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 
 		case ACPI_EXD_REFERENCE:
 
-			reference_name = acpi_ut_get_reference_name(obj_desc);
 			acpi_ex_out_string("Class Name",
-					   ACPI_CAST_PTR(char, reference_name));
+					   acpi_ut_get_reference_name
+					   (obj_desc));
 			acpi_ex_dump_reference_obj(obj_desc);
 			break;
 
@@ -934,12 +933,12 @@ acpi_ex_dump_operands(union acpi_operand_object **operands,
  *
  ******************************************************************************/
 
-static void acpi_ex_out_string(char *title, char *value)
+static void acpi_ex_out_string(const char *title, const char *value)
 {
 	acpi_os_printf("%20s : %s\n", title, value);
 }
 
-static void acpi_ex_out_pointer(char *title, void *value)
+static void acpi_ex_out_pointer(const char *title, const void *value)
 {
 	acpi_os_printf("%20s : %p\n", title, value);
 }
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index a01ddb3..7caaaf3 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -504,9 +504,7 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 	 * Evaluate the \_Sx namespace object containing the register values
 	 * for this state
 	 */
-	info->relative_pathname = ACPI_CAST_PTR(char,
-						acpi_gbl_sleep_state_names
-						[sleep_state]);
+	info->relative_pathname = acpi_gbl_sleep_state_names[sleep_state];
 
 	status = acpi_ns_evaluate(info);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 697af81..426a630 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -107,9 +107,10 @@ acpi_status acpi_ns_root_initialize(void)
 			continue;
 		}
 
-		status = acpi_ns_lookup(NULL, init_val->name, init_val->type,
-					ACPI_IMODE_LOAD_PASS2,
-					ACPI_NS_NO_UPSEARCH, NULL, &new_node);
+		status =
+		    acpi_ns_lookup(NULL, (char *)init_val->name, init_val->type,
+				   ACPI_IMODE_LOAD_PASS2, ACPI_NS_NO_UPSEARCH,
+				   NULL, &new_node);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"Could not create predefined name %s",
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index af236e3..ce1f860 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -81,7 +81,7 @@ acpi_ns_get_max_depth(acpi_handle obj_handle,
  *
  ******************************************************************************/
 
-void acpi_ns_print_pathname(u32 num_segments, char *pathname)
+void acpi_ns_print_pathname(u32 num_segments, const char *pathname)
 {
 	u32 i;
 
@@ -114,6 +114,9 @@ void acpi_ns_print_pathname(u32 num_segments, char *pathname)
 	acpi_os_printf("]\n");
 }
 
+#ifdef ACPI_OBSOLETE_FUNCTIONS
+/* Not used at this time, perhaps later */
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_dump_pathname
@@ -131,7 +134,8 @@ void acpi_ns_print_pathname(u32 num_segments, char *pathname)
  ******************************************************************************/
 
 void
-acpi_ns_dump_pathname(acpi_handle handle, char *msg, u32 level, u32 component)
+acpi_ns_dump_pathname(acpi_handle handle,
+		      const char *msg, u32 level, u32 component)
 {
 
 	ACPI_FUNCTION_TRACE(ns_dump_pathname);
@@ -148,6 +152,7 @@ acpi_ns_dump_pathname(acpi_handle handle, char *msg, u32 level, u32 component)
 	acpi_os_printf("\n");
 	return_VOID;
 }
+#endif
 
 /*******************************************************************************
  *
diff --git a/drivers/acpi/acpica/psopinfo.c b/drivers/acpi/acpica/psopinfo.c
index cfd17a4..177b05b 100644
--- a/drivers/acpi/acpica/psopinfo.c
+++ b/drivers/acpi/acpica/psopinfo.c
@@ -158,7 +158,7 @@ const struct acpi_opcode_info *acpi_ps_get_opcode_info(u16 opcode)
  *
  ******************************************************************************/
 
-char *acpi_ps_get_opcode_name(u16 opcode)
+const char *acpi_ps_get_opcode_name(u16 opcode)
 {
 #if defined(ACPI_DISASSEMBLER) || defined (ACPI_DEBUG_OUTPUT)
 
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 23a17c8..5ffdb56 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -52,17 +52,17 @@ ACPI_MODULE_NAME("rsdump")
  * All functions in this module are used by the AML Debugger only
  */
 /* Local prototypes */
-static void acpi_rs_out_string(char *title, char *value);
+static void acpi_rs_out_string(const char *title, const char *value);
 
-static void acpi_rs_out_integer8(char *title, u8 value);
+static void acpi_rs_out_integer8(const char *title, u8 value);
 
-static void acpi_rs_out_integer16(char *title, u16 value);
+static void acpi_rs_out_integer16(const char *title, u16 value);
 
-static void acpi_rs_out_integer32(char *title, u32 value);
+static void acpi_rs_out_integer32(const char *title, u32 value);
 
-static void acpi_rs_out_integer64(char *title, u64 value);
+static void acpi_rs_out_integer64(const char *title, u64 value);
 
-static void acpi_rs_out_title(char *title);
+static void acpi_rs_out_title(const char *title);
 
 static void acpi_rs_dump_byte_list(u16 length, u8 *data);
 
@@ -208,7 +208,7 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table)
 {
 	u8 *target = NULL;
 	u8 *previous_target;
-	char *name;
+	const char *name;
 	u8 count;
 
 	/* First table entry must contain the table length (# of table entries) */
@@ -248,10 +248,8 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table)
 		case ACPI_RSD_UINT8:
 
 			if (table->pointer) {
-				acpi_rs_out_string(name, ACPI_CAST_PTR(char,
-								       table->
-								       pointer
-								       [*target]));
+				acpi_rs_out_string(name,
+						   table->pointer[*target]);
 			} else {
 				acpi_rs_out_integer8(name, ACPI_GET8(target));
 			}
@@ -276,26 +274,20 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table)
 
 		case ACPI_RSD_1BITFLAG:
 
-			acpi_rs_out_string(name, ACPI_CAST_PTR(char,
-							       table->
-							       pointer[*target &
-								       0x01]));
+			acpi_rs_out_string(name,
+					   table->pointer[*target & 0x01]);
 			break;
 
 		case ACPI_RSD_2BITFLAG:
 
-			acpi_rs_out_string(name, ACPI_CAST_PTR(char,
-							       table->
-							       pointer[*target &
-								       0x03]));
+			acpi_rs_out_string(name,
+					   table->pointer[*target & 0x03]);
 			break;
 
 		case ACPI_RSD_3BITFLAG:
 
-			acpi_rs_out_string(name, ACPI_CAST_PTR(char,
-							       table->
-							       pointer[*target &
-								       0x07]));
+			acpi_rs_out_string(name,
+					   table->pointer[*target & 0x07]);
 			break;
 
 		case ACPI_RSD_SHORTLIST:
@@ -481,7 +473,7 @@ static void acpi_rs_dump_address_common(union acpi_resource_data *resource)
  *
  ******************************************************************************/
 
-static void acpi_rs_out_string(char *title, char *value)
+static void acpi_rs_out_string(const char *title, const char *value)
 {
 
 	acpi_os_printf("%27s : %s", title, value);
@@ -491,30 +483,30 @@ static void acpi_rs_out_string(char *title, char *value)
 	acpi_os_printf("\n");
 }
 
-static void acpi_rs_out_integer8(char *title, u8 value)
+static void acpi_rs_out_integer8(const char *title, u8 value)
 {
 	acpi_os_printf("%27s : %2.2X\n", title, value);
 }
 
-static void acpi_rs_out_integer16(char *title, u16 value)
+static void acpi_rs_out_integer16(const char *title, u16 value)
 {
 
 	acpi_os_printf("%27s : %4.4X\n", title, value);
 }
 
-static void acpi_rs_out_integer32(char *title, u32 value)
+static void acpi_rs_out_integer32(const char *title, u32 value)
 {
 
 	acpi_os_printf("%27s : %8.8X\n", title, value);
 }
 
-static void acpi_rs_out_integer64(char *title, u64 value)
+static void acpi_rs_out_integer64(const char *title, u64 value)
 {
 
 	acpi_os_printf("%27s : %8.8X%8.8X\n", title, ACPI_FORMAT_UINT64(value));
 }
 
-static void acpi_rs_out_title(char *title)
+static void acpi_rs_out_title(const char *title)
 {
 
 	acpi_os_printf("%27s : ", title);
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index cf06e49..e0d6023 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -671,7 +671,7 @@ acpi_rs_get_aei_method_data(struct acpi_namespace_node *node,
 
 acpi_status
 acpi_rs_get_method_data(acpi_handle handle,
-			char *path, struct acpi_buffer *ret_buffer)
+			const char *path, struct acpi_buffer *ret_buffer)
 {
 	union acpi_operand_object *obj_desc;
 	acpi_status status;
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index f63f3fd..635d951 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -53,7 +53,7 @@ static void
 acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
 			     u8 space_id,
 			     u8 byte_width,
-			     u64 address, char *register_name, u8 flags);
+			     u64 address, const char *register_name, u8 flags);
 
 static void acpi_tb_convert_fadt(void);
 
@@ -65,7 +65,7 @@ acpi_tb_select_address(char *register_name, u32 address32, u64 address64);
 /* Table for conversion of FADT to common internal format and FADT validation */
 
 typedef struct acpi_fadt_info {
-	char *name;
+	const char *name;
 	u16 address64;
 	u16 address32;
 	u16 length;
@@ -192,7 +192,7 @@ static void
 acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
 			     u8 space_id,
 			     u8 byte_width,
-			     u64 address, char *register_name, u8 flags)
+			     u64 address, const char *register_name, u8 flags)
 {
 	u8 bit_width;
 
@@ -468,7 +468,7 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
 
 static void acpi_tb_convert_fadt(void)
 {
-	char *name;
+	const char *name;
 	struct acpi_generic_address *address64;
 	u32 address32;
 	u8 length;
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 1cfc5f6..5744222 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -51,13 +51,9 @@
 ACPI_MODULE_NAME("utdebug")
 
 #ifdef ACPI_DEBUG_OUTPUT
-static acpi_thread_id acpi_gbl_prev_thread_id = (acpi_thread_id) 0xFFFFFFFF;
-static char *acpi_gbl_fn_entry_str = "----Entry";
-static char *acpi_gbl_fn_exit_str = "----Exit-";
-
-/* Local prototypes */
-
-static const char *acpi_ut_trim_function_name(const char *function_name);
+static acpi_thread_id acpi_gbl_previous_thread_id = (acpi_thread_id) 0xFFFFFFFF;
+static const char *acpi_gbl_function_entry_prefix = "----Entry";
+static const char *acpi_gbl_function_exit_prefix = "----Exit-";
 
 /*******************************************************************************
  *
@@ -178,14 +174,14 @@ acpi_debug_print(u32 requested_debug_level,
 	 * Thread tracking and context switch notification
 	 */
 	thread_id = acpi_os_get_thread_id();
-	if (thread_id != acpi_gbl_prev_thread_id) {
+	if (thread_id != acpi_gbl_previous_thread_id) {
 		if (ACPI_LV_THREADS & acpi_dbg_level) {
 			acpi_os_printf
 			    ("\n**** Context Switch from TID %u to TID %u ****\n\n",
-			     (u32)acpi_gbl_prev_thread_id, (u32)thread_id);
+			     (u32)acpi_gbl_previous_thread_id, (u32)thread_id);
 		}
 
-		acpi_gbl_prev_thread_id = thread_id;
+		acpi_gbl_previous_thread_id = thread_id;
 		acpi_gbl_nesting_level = 0;
 	}
 
@@ -287,7 +283,8 @@ acpi_ut_trace(u32 line_number,
 	if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_FUNCTIONS, component_id)) {
 		acpi_debug_print(ACPI_LV_FUNCTIONS,
 				 line_number, function_name, module_name,
-				 component_id, "%s\n", acpi_gbl_fn_entry_str);
+				 component_id, "%s\n",
+				 acpi_gbl_function_entry_prefix);
 	}
 }
 
@@ -312,7 +309,8 @@ ACPI_EXPORT_SYMBOL(acpi_ut_trace)
 void
 acpi_ut_trace_ptr(u32 line_number,
 		  const char *function_name,
-		  const char *module_name, u32 component_id, void *pointer)
+		  const char *module_name,
+		  u32 component_id, const void *pointer)
 {
 
 	acpi_gbl_nesting_level++;
@@ -323,8 +321,8 @@ acpi_ut_trace_ptr(u32 line_number,
 	if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_FUNCTIONS, component_id)) {
 		acpi_debug_print(ACPI_LV_FUNCTIONS,
 				 line_number, function_name, module_name,
-				 component_id, "%s %p\n", acpi_gbl_fn_entry_str,
-				 pointer);
+				 component_id, "%s %p\n",
+				 acpi_gbl_function_entry_prefix, pointer);
 	}
 }
 
@@ -348,7 +346,7 @@ acpi_ut_trace_ptr(u32 line_number,
 void
 acpi_ut_trace_str(u32 line_number,
 		  const char *function_name,
-		  const char *module_name, u32 component_id, char *string)
+		  const char *module_name, u32 component_id, const char *string)
 {
 
 	acpi_gbl_nesting_level++;
@@ -359,8 +357,8 @@ acpi_ut_trace_str(u32 line_number,
 	if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_FUNCTIONS, component_id)) {
 		acpi_debug_print(ACPI_LV_FUNCTIONS,
 				 line_number, function_name, module_name,
-				 component_id, "%s %s\n", acpi_gbl_fn_entry_str,
-				 string);
+				 component_id, "%s %s\n",
+				 acpi_gbl_function_entry_prefix, string);
 	}
 }
 
@@ -396,7 +394,7 @@ acpi_ut_trace_u32(u32 line_number,
 		acpi_debug_print(ACPI_LV_FUNCTIONS,
 				 line_number, function_name, module_name,
 				 component_id, "%s %08X\n",
-				 acpi_gbl_fn_entry_str, integer);
+				 acpi_gbl_function_entry_prefix, integer);
 	}
 }
 
@@ -427,7 +425,8 @@ acpi_ut_exit(u32 line_number,
 	if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_FUNCTIONS, component_id)) {
 		acpi_debug_print(ACPI_LV_FUNCTIONS,
 				 line_number, function_name, module_name,
-				 component_id, "%s\n", acpi_gbl_fn_exit_str);
+				 component_id, "%s\n",
+				 acpi_gbl_function_exit_prefix);
 	}
 
 	if (acpi_gbl_nesting_level) {
@@ -467,14 +466,14 @@ acpi_ut_status_exit(u32 line_number,
 			acpi_debug_print(ACPI_LV_FUNCTIONS,
 					 line_number, function_name,
 					 module_name, component_id, "%s %s\n",
-					 acpi_gbl_fn_exit_str,
+					 acpi_gbl_function_exit_prefix,
 					 acpi_format_exception(status));
 		} else {
 			acpi_debug_print(ACPI_LV_FUNCTIONS,
 					 line_number, function_name,
 					 module_name, component_id,
 					 "%s ****Exception****: %s\n",
-					 acpi_gbl_fn_exit_str,
+					 acpi_gbl_function_exit_prefix,
 					 acpi_format_exception(status));
 		}
 	}
@@ -514,7 +513,7 @@ acpi_ut_value_exit(u32 line_number,
 		acpi_debug_print(ACPI_LV_FUNCTIONS,
 				 line_number, function_name, module_name,
 				 component_id, "%s %8.8X%8.8X\n",
-				 acpi_gbl_fn_exit_str,
+				 acpi_gbl_function_exit_prefix,
 				 ACPI_FORMAT_UINT64(value));
 	}
 
@@ -552,8 +551,8 @@ acpi_ut_ptr_exit(u32 line_number,
 	if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_FUNCTIONS, component_id)) {
 		acpi_debug_print(ACPI_LV_FUNCTIONS,
 				 line_number, function_name, module_name,
-				 component_id, "%s %p\n", acpi_gbl_fn_exit_str,
-				 ptr);
+				 component_id, "%s %p\n",
+				 acpi_gbl_function_exit_prefix, ptr);
 	}
 
 	if (acpi_gbl_nesting_level) {
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 17b9f3e..7bad13f 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -69,7 +69,7 @@ ACPI_MODULE_NAME("uteval")
 
 acpi_status
 acpi_ut_evaluate_object(struct acpi_namespace_node *prefix_node,
-			char *path,
+			const char *path,
 			u32 expected_return_btypes,
 			union acpi_operand_object **return_desc)
 {
@@ -204,7 +204,7 @@ cleanup:
  ******************************************************************************/
 
 acpi_status
-acpi_ut_evaluate_numeric_object(char *object_name,
+acpi_ut_evaluate_numeric_object(const char *object_name,
 				struct acpi_namespace_node *device_node,
 				u64 *value)
 {
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index d45899c..dd3fd7f 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -80,6 +80,11 @@ const char *acpi_gbl_highest_dstate_names[ACPI_NUM_sx_d_METHODS] = {
 	"_S4D"
 };
 
+/* Hex-to-ascii */
+
+const char acpi_gbl_lower_hex_digits[] = "0123456789abcdef";
+const char acpi_gbl_upper_hex_digits[] = "0123456789ABCDEF";
+
 /*******************************************************************************
  *
  * Namespace globals
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index d938c27..389de3b 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -361,7 +361,7 @@ acpi_ut_walk_package_tree(union acpi_operand_object *source_object,
 void
 acpi_ut_display_init_pathname(u8 type,
 			      struct acpi_namespace_node *obj_handle,
-			      char *path)
+			      const char *path)
 {
 	acpi_status status;
 	struct acpi_buffer buffer;
diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 8c218ad..208d71a 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -67,11 +67,6 @@ static char *acpi_ut_format_number(char *string,
 
 static char *acpi_ut_put_number(char *string, u64 number, u8 base, u8 upper);
 
-/* Module globals */
-
-static const char acpi_gbl_lower_hex_digits[] = "0123456789abcdef";
-static const char acpi_gbl_upper_hex_digits[] = "0123456789ABCDEF";
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_bound_string_length
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index 60c406a..0df07df 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -90,7 +90,7 @@ acpi_ut_remove_allocation(struct acpi_debug_mem_block *address,
  ******************************************************************************/
 
 acpi_status
-acpi_ut_create_list(char *list_name,
+acpi_ut_create_list(const char *list_name,
 		    u16 object_size, struct acpi_memory_list **return_cache)
 {
 	struct acpi_memory_list *cache;
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 140886e..b9a8b72 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -995,7 +995,7 @@ struct acpi_buffer {
  * Predefined Namespace items
  */
 struct acpi_predefined_names {
-	char *name;
+	const char *name;
 	u8 type;
 	char *val;
 };
@@ -1228,7 +1228,7 @@ struct acpi_mem_space_context {
  * struct acpi_memory_list is used only if the ACPICA local cache is enabled
  */
 struct acpi_memory_list {
-	char *list_name;
+	const char *list_name;
 	void *list_head;
 	u16 object_size;
 	u16 max_depth;
-- 
1.7.10
