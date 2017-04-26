From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/15] ACPICA: iasl: add ASL conversion tool
Date: Wed, 26 Apr 2017 16:19:02 +0800
Message-ID: <952e3354e4cbe4310e1037bc16820c70cc0fd8f6.1493194142.git.lv.zheng@intel.com>
References: <cover.1493194142.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7333 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1953137AbdDZITT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 04:19:19 -0400
In-Reply-To: <cover.1493194142.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit c04d310039d3e0ed1cb62876fe7e596fbc75ab01

The key feature of this utility is that the original comments within
the input ASL files are preserved during the conversion process, and
included within the converted ASL+ file -- thus creating a transparent
conversion of existing ASL files to ASL+ (ASL 2.0)

Link: https://github.com/acpica/acpica/commit/c04d3100
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acconvert.h | 144 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/acglobal.h  |  53 +++++++++++++++
 drivers/acpi/acpica/aclocal.h   |  99 ++++++++++++++++++++++-----
 drivers/acpi/acpica/acmacros.h  |  35 ++++++++++
 drivers/acpi/acpica/acopcode.h  |   2 +
 drivers/acpi/acpica/amlcode.h   |   4 +-
 drivers/acpi/acpica/psargs.c    |  23 +++++++
 drivers/acpi/acpica/psloop.c    |  32 +++++++++
 drivers/acpi/acpica/psobject.c  |  38 +++++++++++
 drivers/acpi/acpica/psopcode.c  |   5 +-
 drivers/acpi/acpica/psopinfo.c  |   2 +-
 drivers/acpi/acpica/pstree.c    |   7 ++
 drivers/acpi/acpica/psutils.c   |  11 +++
 drivers/acpi/acpica/utalloc.c   |  50 ++++++++++++++
 drivers/acpi/acpica/utdebug.c   |   1 +
 include/acpi/acconfig.h         |   1 +
 include/acpi/actbl2.h           |   1 +
 17 files changed, 490 insertions(+), 18 deletions(-)
 create mode 100644 drivers/acpi/acpica/acconvert.h

diff --git a/drivers/acpi/acpica/acconvert.h b/drivers/acpi/acpica/acconvert.h
new file mode 100644
index 0000000..c84223b
--- /dev/null
+++ b/drivers/acpi/acpica/acconvert.h
@@ -0,0 +1,144 @@
+/******************************************************************************
+ *
+ * Module Name: acapps - common include for ACPI applications/tools
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2017, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#ifndef _ACCONVERT
+#define _ACCONVERT
+
+/* Definitions for comment state */
+
+#define ASL_COMMENT_STANDARD    1
+#define ASLCOMMENT_INLINE       2
+#define ASL_COMMENT_OPEN_PAREN  3
+#define ASL_COMMENT_CLOSE_PAREN 4
+#define ASL_COMMENT_CLOSE_BRACE 5
+
+/* Definitions for comment print function*/
+
+#define AML_COMMENT_STANDARD    1
+#define AMLCOMMENT_INLINE       2
+#define AML_COMMENT_END_NODE    3
+#define AML_NAMECOMMENT         4
+#define AML_COMMENT_CLOSE_BRACE 5
+#define AML_COMMENT_ENDBLK      6
+#define AML_COMMENT_INCLUDE     7
+
+#ifdef ACPI_ASL_COMPILER
+/*
+ * cvcompiler
+ */
+void
+cv_process_comment(struct asl_comment_state current_state,
+		   char *string_buffer, int c1);
+
+void
+cv_process_comment_type2(struct asl_comment_state current_state,
+			 char *string_buffer);
+
+u32 cv_calculate_comment_lengths(union acpi_parse_object *op);
+
+void cv_process_comment_state(char input);
+
+char *cv_append_inline_comment(char *inline_comment, char *to_add);
+
+void cv_add_to_comment_list(char *to_add);
+
+void cv_place_comment(u8 type, char *comment_string);
+
+u32 cv_parse_op_block_type(union acpi_parse_object *op);
+
+struct acpi_comment_node *cv_comment_node_calloc(void);
+
+void cg_write_aml_def_block_comment(union acpi_parse_object *op);
+
+void
+cg_write_one_aml_comment(union acpi_parse_object *op,
+			 char *comment_to_print, u8 input_option);
+
+void cg_write_aml_comment(union acpi_parse_object *op);
+
+/*
+ * cvparser
+ */
+void
+cv_init_file_tree(struct acpi_table_header *table,
+		  u8 *aml_start, u32 aml_length);
+
+void cv_clear_op_comments(union acpi_parse_object *op);
+
+struct acpi_file_node *cv_filename_exists(char *filename,
+					  struct acpi_file_node *head);
+
+void cv_label_file_node(union acpi_parse_object *op);
+
+void
+cv_capture_list_comments(struct acpi_parse_state *parser_state,
+			 struct acpi_comment_node *list_head,
+			 struct acpi_comment_node *list_tail);
+
+void cv_capture_comments_only(struct acpi_parse_state *parser_state);
+
+void cv_capture_comments(struct acpi_walk_state *walk_state);
+
+void cv_transfer_comments(union acpi_parse_object *op);
+
+/*
+ * cvdisasm
+ */
+void cv_switch_files(u32 level, union acpi_parse_object *op);
+
+u8 cv_file_has_switched(union acpi_parse_object *op);
+
+void cv_close_paren_write_comment(union acpi_parse_object *op, u32 level);
+
+void cv_close_brace_write_comment(union acpi_parse_object *op, u32 level);
+
+void
+cv_print_one_comment_list(struct acpi_comment_node *comment_list, u32 level);
+
+void
+cv_print_one_comment_type(union acpi_parse_object *op,
+			  u8 comment_type, char *end_str, u32 level);
+
+#endif
+
+#endif				/* _ACCONVERT */
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 1d955fe..abe8c31 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -370,6 +370,59 @@ ACPI_GLOBAL(const char, *acpi_gbl_pld_shape_list[]);
 
 #endif
 
+/*
+ * Meant for the -ca option.
+ */
+ACPI_INIT_GLOBAL(char *, acpi_gbl_current_inline_comment, NULL);
+ACPI_INIT_GLOBAL(char *, acpi_gbl_current_end_node_comment, NULL);
+ACPI_INIT_GLOBAL(char *, acpi_gbl_current_open_brace_comment, NULL);
+ACPI_INIT_GLOBAL(char *, acpi_gbl_current_close_brace_comment, NULL);
+
+ACPI_INIT_GLOBAL(char *, acpi_gbl_root_filename, NULL);
+ACPI_INIT_GLOBAL(char *, acpi_gbl_current_filename, NULL);
+ACPI_INIT_GLOBAL(char *, acpi_gbl_current_parent_filename, NULL);
+ACPI_INIT_GLOBAL(char *, acpi_gbl_current_include_filename, NULL);
+
+ACPI_INIT_GLOBAL(struct acpi_comment_node, *acpi_gbl_last_list_head, NULL);
+
+ACPI_INIT_GLOBAL(struct acpi_comment_node, *acpi_gbl_def_blk_comment_list_head,
+		 NULL);
+ACPI_INIT_GLOBAL(struct acpi_comment_node, *acpi_gbl_def_blk_comment_list_tail,
+		 NULL);
+
+ACPI_INIT_GLOBAL(struct acpi_comment_node, *acpi_gbl_reg_comment_list_head,
+		 NULL);
+ACPI_INIT_GLOBAL(struct acpi_comment_node, *acpi_gbl_reg_comment_list_tail,
+		 NULL);
+
+ACPI_INIT_GLOBAL(struct acpi_comment_node, *acpi_gbl_inc_comment_list_head,
+		 NULL);
+ACPI_INIT_GLOBAL(struct acpi_comment_node, *acpi_gbl_inc_comment_list_tail,
+		 NULL);
+
+ACPI_INIT_GLOBAL(struct acpi_comment_node, *acpi_gbl_end_blk_comment_list_head,
+		 NULL);
+ACPI_INIT_GLOBAL(struct acpi_comment_node, *acpi_gbl_end_blk_comment_list_tail,
+		 NULL);
+
+ACPI_INIT_GLOBAL(struct acpi_comment_addr_node,
+		 *acpi_gbl_comment_addr_list_head, NULL);
+
+ACPI_INIT_GLOBAL(union acpi_parse_object, *acpi_gbl_current_scope, NULL);
+
+ACPI_INIT_GLOBAL(struct acpi_file_node, *acpi_gbl_file_tree_root, NULL);
+
+ACPI_GLOBAL(acpi_cache_t *, acpi_gbl_reg_comment_cache);
+ACPI_GLOBAL(acpi_cache_t *, acpi_gbl_comment_addr_cache);
+ACPI_GLOBAL(acpi_cache_t *, acpi_gbl_file_cache);
+
+ACPI_INIT_GLOBAL(u8, gbl_capture_comments, FALSE);
+
+ACPI_INIT_GLOBAL(u8, acpi_gbl_debug_asl_conversion, FALSE);
+ACPI_INIT_GLOBAL(ACPI_FILE, acpi_gbl_conv_debug_file, NULL);
+
+ACPI_GLOBAL(char, acpi_gbl_table_sig[4]);
+
 /*****************************************************************************
  *
  * Application globals
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index ca98426..e822280 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -53,7 +53,7 @@ typedef u32 acpi_mutex_handle;
 
 /* Total number of aml opcodes defined */
 
-#define AML_NUM_OPCODES                 0x82
+#define AML_NUM_OPCODES                 0x83
 
 /* Forward declarations */
 
@@ -754,21 +754,52 @@ union acpi_parse_value {
 #define ACPI_DISASM_ONLY_MEMBERS(a)
 #endif
 
+#if defined(ACPI_ASL_COMPILER)
+#define ACPI_CONVERTER_ONLY_MEMBERS(a)  a;
+#else
+#define ACPI_CONVERTER_ONLY_MEMBERS(a)
+#endif
+
 #define ACPI_PARSE_COMMON \
-	union acpi_parse_object         *parent;        /* Parent op */\
-	u8                              descriptor_type; /* To differentiate various internal objs */\
-	u8                              flags;          /* Type of Op */\
-	u16                             aml_opcode;     /* AML opcode */\
-	u8                              *aml;           /* Address of declaration in AML */\
-	union acpi_parse_object         *next;          /* Next op */\
-	struct acpi_namespace_node      *node;          /* For use by interpreter */\
-	union acpi_parse_value          value;          /* Value or args associated with the opcode */\
-	u8                              arg_list_length; /* Number of elements in the arg list */\
-	ACPI_DISASM_ONLY_MEMBERS (\
-	u16                             disasm_flags;   /* Used during AML disassembly */\
-	u8                              disasm_opcode;  /* Subtype used for disassembly */\
-	char                            *operator_symbol;/* Used for C-style operator name strings */\
-	char                            aml_op_name[16])	/* Op name (debug only) */
+	union acpi_parse_object         *parent;            /* Parent op */\
+	u8                              descriptor_type;    /* To differentiate various internal objs */\
+	u8                              flags;              /* Type of Op */\
+	u16                             aml_opcode;         /* AML opcode */\
+	u8                              *aml;               /* Address of declaration in AML */\
+	union acpi_parse_object         *next;              /* Next op */\
+	struct acpi_namespace_node      *node;              /* For use by interpreter */\
+	union acpi_parse_value          value;              /* Value or args associated with the opcode */\
+	u8                              arg_list_length;    /* Number of elements in the arg list */\
+	 ACPI_DISASM_ONLY_MEMBERS (\
+	u16                             disasm_flags;       /* Used during AML disassembly */\
+	u8                              disasm_opcode;      /* Subtype used for disassembly */\
+	char                            *operator_symbol;   /* Used for C-style operator name strings */\
+	char                            aml_op_name[16])    /* Op name (debug only) */\
+	 ACPI_CONVERTER_ONLY_MEMBERS (\
+	char                            *inline_comment;    /* Inline comment */\
+	char                            *end_node_comment;  /* End of node comment */\
+	char                            *name_comment;      /* Comment associated with the first parameter of the name node */\
+	char                            *close_brace_comment; /* Comments that come after } on the same as } */\
+	struct acpi_comment_node        *comment_list;      /* comments that appears before this node */\
+	struct acpi_comment_node        *end_blk_comment;   /* comments that at the end of a block but before ) or } */\
+	char                            *cv_filename;       /* Filename associated with this node. Used for ASL/ASL+ converter */\
+	char                            *cv_parent_filename)	/* Parent filename associated with this node. Used for ASL/ASL+ converter */
+
+/* categories of comments */
+
+typedef enum {
+	STANDARD_COMMENT = 1,
+	INLINE_COMMENT,
+	ENDNODE_COMMENT,
+	OPENBRACE_COMMENT,
+	CLOSE_BRACE_COMMENT,
+	STD_DEFBLK_COMMENT,
+	END_DEFBLK_COMMENT,
+	FILENAME_COMMENT,
+	PARENTFILENAME_COMMENT,
+	ENDBLK_COMMENT,
+	INCLUDE_COMMENT
+} ASL_COMMENT_TYPES;
 
 /* Internal opcodes for disasm_opcode field above */
 
@@ -790,6 +821,34 @@ union acpi_parse_value {
 #define ACPI_DASM_DEFAULT               0x0F	/* Else is a Default in a Switch/Case block */
 
 /*
+ * List struct used in the -ca option
+ */
+struct acpi_comment_node {
+	char *comment;
+	struct acpi_comment_node *next;
+};
+
+struct acpi_comment_addr_node {
+	u8 *addr;
+	struct acpi_comment_addr_node *next;
+};
+
+/*
+ * File node - used for "Include" operator file stack and
+ * depdendency tree for the -ca option
+ */
+struct acpi_file_node {
+	FILE *file;
+	char *filename;
+	char *file_start;	/* Points to AML and indicates when the AML for this particular file starts. */
+	char *file_end;		/* Points to AML and indicates when the AML for this particular file ends. */
+	struct acpi_file_node *next;
+	struct acpi_file_node *parent;
+	u8 include_written;
+	struct acpi_comment_node *include_comment;
+};
+
+/*
  * Generic operation (for example:  If, While, Store)
  */
 struct acpi_parse_obj_common {
@@ -814,6 +873,8 @@ struct acpi_parse_obj_asl {
 	ACPI_PARSE_COMMON union acpi_parse_object *child;
 	union acpi_parse_object *parent_method;
 	char *filename;
+	u8 file_changed;
+	char *parent_filename;
 	char *external_name;
 	char *namepath;
 	char name_seg[4];
@@ -843,6 +904,14 @@ union acpi_parse_object {
 	struct acpi_parse_obj_asl asl;
 };
 
+struct asl_comment_state {
+	u8 comment_type;
+	u32 spaces_before;
+	union acpi_parse_object *latest_parse_node;
+	union acpi_parse_object *parsing_paren_brace_node;
+	u8 capture_comments;
+};
+
 /*
  * Parse state - one state per parser invocation and each control
  * method.
diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index c333751..c7f0c96 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -493,4 +493,39 @@
 
 #define ACPI_IS_OCTAL_DIGIT(d)              (((char)(d) >= '0') && ((char)(d) <= '7'))
 
+/*
+ * Macors used for the ASL-/ASL+ converter utility
+ */
+#ifdef ACPI_ASL_COMPILER
+
+#define ASL_CV_LABEL_FILENODE(a)         cv_label_file_node(a);
+#define ASL_CV_CAPTURE_COMMENTS_ONLY(a)   cv_capture_comments_only (a);
+#define ASL_CV_CAPTURE_COMMENTS(a)       cv_capture_comments (a);
+#define ASL_CV_TRANSFER_COMMENTS(a)      cv_transfer_comments (a);
+#define ASL_CV_CLOSE_PAREN(a,b)          cv_close_paren_write_comment(a,b);
+#define ASL_CV_CLOSE_BRACE(a,b)          cv_close_brace_write_comment(a,b);
+#define ASL_CV_SWITCH_FILES(a,b)         cv_switch_files(a,b);
+#define ASL_CV_CLEAR_OP_COMMENTS(a)       cv_clear_op_comments(a);
+#define ASL_CV_PRINT_ONE_COMMENT(a,b,c,d) cv_print_one_comment_type (a,b,c,d);
+#define ASL_CV_PRINT_ONE_COMMENT_LIST(a,b) cv_print_one_comment_list (a,b);
+#define ASL_CV_FILE_HAS_SWITCHED(a)       cv_file_has_switched(a)
+#define ASL_CV_INIT_FILETREE(a,b,c)      cv_init_file_tree(a,b,c);
+
+#else
+
+#define ASL_CV_LABEL_FILENODE(a)
+#define ASL_CV_CAPTURE_COMMENTS_ONLY(a)
+#define ASL_CV_CAPTURE_COMMENTS(a)
+#define ASL_CV_TRANSFER_COMMENTS(a)
+#define ASL_CV_CLOSE_PAREN(a,b)          acpi_os_printf (")");
+#define ASL_CV_CLOSE_BRACE(a,b)          acpi_os_printf ("}");
+#define ASL_CV_SWITCH_FILES(a,b)
+#define ASL_CV_CLEAR_OP_COMMENTS(a)
+#define ASL_CV_PRINT_ONE_COMMENT(a,b,c,d)
+#define ASL_CV_PRINT_ONE_COMMENT_LIST(a,b)
+#define ASL_CV_FILE_HAS_SWITCHED(a)       0
+#define ASL_CV_INIT_FILETREE(a,b,c)
+
+#endif
+
 #endif				/* ACMACROS_H */
diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index e758f09..a5d9af7 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -90,6 +90,7 @@
 #define ARGP_BUFFER_OP                  ARGP_LIST3 (ARGP_PKGLENGTH,  ARGP_TERMARG,       ARGP_BYTELIST)
 #define ARGP_BYTE_OP                    ARGP_LIST1 (ARGP_BYTEDATA)
 #define ARGP_BYTELIST_OP                ARGP_LIST1 (ARGP_NAMESTRING)
+#define ARGP_COMMENT_OP                 ARGP_LIST2 (ARGP_BYTEDATA,   ARGP_COMMENT)
 #define ARGP_CONCAT_OP                  ARGP_LIST3 (ARGP_TERMARG,    ARGP_TERMARG,       ARGP_TARGET)
 #define ARGP_CONCAT_RES_OP              ARGP_LIST3 (ARGP_TERMARG,    ARGP_TERMARG,       ARGP_TARGET)
 #define ARGP_COND_REF_OF_OP             ARGP_LIST2 (ARGP_SIMPLENAME, ARGP_TARGET)
@@ -223,6 +224,7 @@
 #define ARGI_BUFFER_OP                  ARGI_LIST1 (ARGI_INTEGER)
 #define ARGI_BYTE_OP                    ARGI_INVALID_OPCODE
 #define ARGI_BYTELIST_OP                ARGI_INVALID_OPCODE
+#define ARGI_COMMENT_OP                 ARGI_INVALID_OPCODE
 #define ARGI_CONCAT_OP                  ARGI_LIST3 (ARGI_ANYTYPE,    ARGI_ANYTYPE,       ARGI_TARGETREF)
 #define ARGI_CONCAT_RES_OP              ARGI_LIST3 (ARGI_BUFFER,     ARGI_BUFFER,        ARGI_TARGETREF)
 #define ARGI_COND_REF_OF_OP             ARGI_LIST2 (ARGI_OBJECT_REF, ARGI_TARGETREF)
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index 7e2b369..176f7e9 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -137,7 +137,8 @@
 #define AML_NOOP_OP                 (u16) 0xa3
 #define AML_RETURN_OP               (u16) 0xa4
 #define AML_BREAK_OP                (u16) 0xa5
-#define AML_BREAKPOINT_OP           (u16) 0xcc
+#define AML_COMMENT_OP              (u16) 0xa9
+#define AML_BREAKPOINT_OP          (u16) 0xcc
 #define AML_ONES_OP                 (u16) 0xff
 
 /*
@@ -236,6 +237,7 @@
 #define ARGP_SIMPLENAME             0x12	/* name_string | local_term | arg_term */
 #define ARGP_NAME_OR_REF            0x13	/* For object_type only */
 #define ARGP_MAX                    0x13
+#define ARGP_COMMENT                0x14
 
 /*
  * Resolved argument types for the AML Interpreter
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index cda1e15..eb9dfac 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -47,6 +47,7 @@
 #include "amlcode.h"
 #include "acnamesp.h"
 #include "acdispat.h"
+#include "acconvert.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psargs")
@@ -502,6 +503,7 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 
 	ACPI_FUNCTION_TRACE(ps_get_next_field);
 
+	ASL_CV_CAPTURE_COMMENTS_ONLY(parser_state);
 	aml = parser_state->aml;
 
 	/* Determine field type */
@@ -546,6 +548,7 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 
 	/* Decode the field type */
 
+	ASL_CV_CAPTURE_COMMENTS_ONLY(parser_state);
 	switch (opcode) {
 	case AML_INT_NAMEDFIELD_OP:
 
@@ -555,6 +558,22 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 		acpi_ps_set_name(field, name);
 		parser_state->aml += ACPI_NAME_SIZE;
 
+		ASL_CV_CAPTURE_COMMENTS_ONLY(parser_state);
+
+#ifdef ACPI_ASL_COMPILER
+		/*
+		 * Because the package length isn't represented as a parse tree object,
+		 * take comments surrounding this and add to the previously created
+		 * parse node.
+		 */
+		if (field->common.inline_comment) {
+			field->common.name_comment =
+			    field->common.inline_comment;
+		}
+		field->common.inline_comment = acpi_gbl_current_inline_comment;
+		acpi_gbl_current_inline_comment = NULL;
+#endif
+
 		/* Get the length which is encoded as a package length */
 
 		field->common.value.size =
@@ -609,11 +628,13 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 		if (ACPI_GET8(parser_state->aml) == AML_BUFFER_OP) {
 			parser_state->aml++;
 
+			ASL_CV_CAPTURE_COMMENTS_ONLY(parser_state);
 			pkg_end = parser_state->aml;
 			pkg_length =
 			    acpi_ps_get_next_package_length(parser_state);
 			pkg_end += pkg_length;
 
+			ASL_CV_CAPTURE_COMMENTS_ONLY(parser_state);
 			if (parser_state->aml < pkg_end) {
 
 				/* Non-empty list */
@@ -630,6 +651,7 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 				opcode = ACPI_GET8(parser_state->aml);
 				parser_state->aml++;
 
+				ASL_CV_CAPTURE_COMMENTS_ONLY(parser_state);
 				switch (opcode) {
 				case AML_BYTE_OP:	/* AML_BYTEDATA_ARG */
 
@@ -660,6 +682,7 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 
 				/* Fill in bytelist data */
 
+				ASL_CV_CAPTURE_COMMENTS_ONLY(parser_state);
 				arg->named.value.size = buffer_length;
 				arg->named.data = parser_state->aml;
 			}
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index b7da881..b422400 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -55,6 +55,7 @@
 #include "acparser.h"
 #include "acdispat.h"
 #include "amlcode.h"
+#include "acconvert.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psloop")
@@ -132,6 +133,21 @@ acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
 		       !walk_state->arg_count) {
 			walk_state->aml = walk_state->parser_state.aml;
 
+			switch (op->common.aml_opcode) {
+			case AML_METHOD_OP:
+			case AML_BUFFER_OP:
+			case AML_PACKAGE_OP:
+			case AML_VARIABLE_PACKAGE_OP:
+			case AML_WHILE_OP:
+
+				break;
+
+			default:
+
+				ASL_CV_CAPTURE_COMMENTS(walk_state);
+				break;
+			}
+
 			status =
 			    acpi_ps_get_next_arg(walk_state,
 						 &(walk_state->parser_state),
@@ -480,6 +496,8 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 	/* Iterative parsing loop, while there is more AML to process: */
 
 	while ((parser_state->aml < parser_state->aml_end) || (op)) {
+		ASL_CV_CAPTURE_COMMENTS(walk_state);
+
 		aml_op_start = parser_state->aml;
 		if (!op) {
 			status =
@@ -516,6 +534,20 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 		 */
 		walk_state->arg_count = 0;
 
+		switch (op->common.aml_opcode) {
+		case AML_BYTE_OP:
+		case AML_WORD_OP:
+		case AML_DWORD_OP:
+		case AML_QWORD_OP:
+
+			break;
+
+		default:
+
+			ASL_CV_CAPTURE_COMMENTS(walk_state);
+			break;
+		}
+
 		/* Are there any arguments that must be processed? */
 
 		if (walk_state->arg_types) {
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 5c4aff0..5bcb618 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -45,6 +45,7 @@
 #include "accommon.h"
 #include "acparser.h"
 #include "amlcode.h"
+#include "acconvert.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psobject")
@@ -190,6 +191,7 @@ acpi_ps_build_named_op(struct acpi_walk_state *walk_state,
 	 */
 	while (GET_CURRENT_ARG_TYPE(walk_state->arg_types) &&
 	       (GET_CURRENT_ARG_TYPE(walk_state->arg_types) != ARGP_NAME)) {
+		ASL_CV_CAPTURE_COMMENTS(walk_state);
 		status =
 		    acpi_ps_get_next_arg(walk_state,
 					 &(walk_state->parser_state),
@@ -203,6 +205,18 @@ acpi_ps_build_named_op(struct acpi_walk_state *walk_state,
 		INCREMENT_ARG_LIST(walk_state->arg_types);
 	}
 
+	/* are there any inline comments associated with the name_seg?? If so, save this. */
+
+	ASL_CV_CAPTURE_COMMENTS(walk_state);
+
+#ifdef ACPI_ASL_COMPILER
+	if (acpi_gbl_current_inline_comment != NULL) {
+		unnamed_op->common.name_comment =
+		    acpi_gbl_current_inline_comment;
+		acpi_gbl_current_inline_comment = NULL;
+	}
+#endif
+
 	/*
 	 * Make sure that we found a NAME and didn't run out of arguments
 	 */
@@ -243,6 +257,30 @@ acpi_ps_build_named_op(struct acpi_walk_state *walk_state,
 
 	acpi_ps_append_arg(*op, unnamed_op->common.value.arg);
 
+#ifdef ACPI_ASL_COMPILER
+
+	/* save any comments that might be associated with unnamed_op. */
+
+	(*op)->common.inline_comment = unnamed_op->common.inline_comment;
+	(*op)->common.end_node_comment = unnamed_op->common.end_node_comment;
+	(*op)->common.close_brace_comment =
+	    unnamed_op->common.close_brace_comment;
+	(*op)->common.name_comment = unnamed_op->common.name_comment;
+	(*op)->common.comment_list = unnamed_op->common.comment_list;
+	(*op)->common.end_blk_comment = unnamed_op->common.end_blk_comment;
+	(*op)->common.cv_filename = unnamed_op->common.cv_filename;
+	(*op)->common.cv_parent_filename =
+	    unnamed_op->common.cv_parent_filename;
+	(*op)->named.aml = unnamed_op->common.aml;
+
+	unnamed_op->common.inline_comment = NULL;
+	unnamed_op->common.end_node_comment = NULL;
+	unnamed_op->common.close_brace_comment = NULL;
+	unnamed_op->common.name_comment = NULL;
+	unnamed_op->common.comment_list = NULL;
+	unnamed_op->common.end_blk_comment = NULL;
+#endif
+
 	if ((*op)->common.aml_opcode == AML_REGION_OP ||
 	    (*op)->common.aml_opcode == AML_DATA_REGION_OP) {
 		/*
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index b8f0617..c343a0d 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -652,7 +652,10 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
 
 	/* 81 */ ACPI_OP("External", ARGP_EXTERNAL_OP, ARGI_EXTERNAL_OP,
 			 ACPI_TYPE_ANY, AML_CLASS_EXECUTE, /* ? */
-			 AML_TYPE_EXEC_3A_0T_0R, AML_FLAGS_EXEC_3A_0T_0R)
+			 AML_TYPE_EXEC_3A_0T_0R, AML_FLAGS_EXEC_3A_0T_0R),
+/* 82 */ ACPI_OP("Comment", ARGP_COMMENT_OP, ARGI_COMMENT_OP,
+			 ACPI_TYPE_STRING, AML_CLASS_ARGUMENT,
+			 AML_TYPE_LITERAL, AML_CONSTANT)
 
 /*! [End] no source code translation !*/
 };
diff --git a/drivers/acpi/acpica/psopinfo.c b/drivers/acpi/acpica/psopinfo.c
index 89f95b7..eff2295 100644
--- a/drivers/acpi/acpica/psopinfo.c
+++ b/drivers/acpi/acpica/psopinfo.c
@@ -226,7 +226,7 @@ const u8 acpi_gbl_short_op_index[256] = {
 /* 0x90 */ 0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x73, 0x74,
 /* 0x98 */ 0x75, 0x76, _UNK, _UNK, 0x77, 0x78, 0x79, 0x7A,
 /* 0xA0 */ 0x3e, 0x3f, 0x40, 0x41, 0x42, 0x43, 0x60, 0x61,
-/* 0xA8 */ 0x62, _UNK, _UNK, _UNK, _UNK, _UNK, _UNK, _UNK,
+/* 0xA8 */ 0x62, 0x82, _UNK, _UNK, _UNK, _UNK, _UNK, _UNK,
 /* 0xB0 */ _UNK, _UNK, _UNK, _UNK, _UNK, _UNK, _UNK, _UNK,
 /* 0xB8 */ _UNK, _UNK, _UNK, _UNK, _UNK, _UNK, _UNK, _UNK,
 /* 0xC0 */ _UNK, _UNK, _UNK, _UNK, _UNK, _UNK, _UNK, _UNK,
diff --git a/drivers/acpi/acpica/pstree.c b/drivers/acpi/acpica/pstree.c
index a11d475..c06d6e2 100644
--- a/drivers/acpi/acpica/pstree.c
+++ b/drivers/acpi/acpica/pstree.c
@@ -45,6 +45,7 @@
 #include "accommon.h"
 #include "acparser.h"
 #include "amlcode.h"
+#include "acconvert.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("pstree")
@@ -216,6 +217,7 @@ union acpi_parse_object *acpi_ps_get_depth_next(union acpi_parse_object *origin,
 
 	next = acpi_ps_get_arg(op, 0);
 	if (next) {
+		ASL_CV_LABEL_FILENODE(next);
 		return (next);
 	}
 
@@ -223,6 +225,7 @@ union acpi_parse_object *acpi_ps_get_depth_next(union acpi_parse_object *origin,
 
 	next = op->common.next;
 	if (next) {
+		ASL_CV_LABEL_FILENODE(next);
 		return (next);
 	}
 
@@ -233,6 +236,8 @@ union acpi_parse_object *acpi_ps_get_depth_next(union acpi_parse_object *origin,
 	while (parent) {
 		arg = acpi_ps_get_arg(parent, 0);
 		while (arg && (arg != origin) && (arg != op)) {
+
+			ASL_CV_LABEL_FILENODE(arg);
 			arg = arg->common.next;
 		}
 
@@ -247,6 +252,7 @@ union acpi_parse_object *acpi_ps_get_depth_next(union acpi_parse_object *origin,
 
 			/* Found sibling of parent */
 
+			ASL_CV_LABEL_FILENODE(parent->common.next);
 			return (parent->common.next);
 		}
 
@@ -254,6 +260,7 @@ union acpi_parse_object *acpi_ps_get_depth_next(union acpi_parse_object *origin,
 		parent = parent->common.parent;
 	}
 
+	ASL_CV_LABEL_FILENODE(next);
 	return (next);
 }
 
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index 2fa38bb..0264276 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -45,6 +45,7 @@
 #include "accommon.h"
 #include "acparser.h"
 #include "amlcode.h"
+#include "acconvert.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psutils")
@@ -152,6 +153,15 @@ union acpi_parse_object *acpi_ps_alloc_op(u16 opcode, u8 *aml)
 		acpi_ps_init_op(op, opcode);
 		op->common.aml = aml;
 		op->common.flags = flags;
+		ASL_CV_CLEAR_OP_COMMENTS(op);
+
+		if (opcode == AML_SCOPE_OP) {
+			acpi_gbl_current_scope = op;
+		}
+	}
+
+	if (gbl_capture_comments) {
+		ASL_CV_TRANSFER_COMMENTS(op);
 	}
 
 	return (op);
@@ -174,6 +184,7 @@ void acpi_ps_free_op(union acpi_parse_object *op)
 {
 	ACPI_FUNCTION_NAME(ps_free_op);
 
+	ASL_CV_CLEAR_OP_COMMENTS(op);
 	if (op->common.aml_opcode == AML_INT_RETURN_VALUE_OP) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
 				  "Free retval op: %p\n", op));
diff --git a/drivers/acpi/acpica/utalloc.c b/drivers/acpi/acpica/utalloc.c
index a3401bd..5594a35 100644
--- a/drivers/acpi/acpica/utalloc.c
+++ b/drivers/acpi/acpica/utalloc.c
@@ -142,6 +142,45 @@ acpi_status acpi_ut_create_caches(void)
 	if (ACPI_FAILURE(status)) {
 		return (status);
 	}
+#ifdef ACPI_ASL_COMPILER
+	/*
+	 * For use with the ASL-/ASL+ option. This cache keeps track of regular
+	 * 0xA9 0x01 comments.
+	 */
+	status =
+	    acpi_os_create_cache("Acpi-Comment",
+				 sizeof(struct acpi_comment_node),
+				 ACPI_MAX_COMMENT_CACHE_DEPTH,
+				 &acpi_gbl_reg_comment_cache);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/*
+	 * This cache keeps track of the starting addresses of where the comments
+	 * lie. This helps prevent duplication of comments.
+	 */
+	status =
+	    acpi_os_create_cache("Acpi-Comment-Addr",
+				 sizeof(struct acpi_comment_addr_node),
+				 ACPI_MAX_COMMENT_CACHE_DEPTH,
+				 &acpi_gbl_comment_addr_cache);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/*
+	 * This cache will be used for nodes that represent files.
+	 */
+	status =
+	    acpi_os_create_cache("Acpi-File", sizeof(struct acpi_file_node),
+				 ACPI_MAX_COMMENT_CACHE_DEPTH,
+				 &acpi_gbl_file_cache);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+#endif
+
 #ifdef ACPI_DBG_TRACK_ALLOCATIONS
 
 	/* Memory allocation lists */
@@ -201,6 +240,17 @@ acpi_status acpi_ut_delete_caches(void)
 	(void)acpi_os_delete_cache(acpi_gbl_ps_node_ext_cache);
 	acpi_gbl_ps_node_ext_cache = NULL;
 
+#ifdef ACPI_ASL_COMPILER
+	(void)acpi_os_delete_cache(acpi_gbl_reg_comment_cache);
+	acpi_gbl_reg_comment_cache = NULL;
+
+	(void)acpi_os_delete_cache(acpi_gbl_comment_addr_cache);
+	acpi_gbl_comment_addr_cache = NULL;
+
+	(void)acpi_os_delete_cache(acpi_gbl_file_cache);
+	acpi_gbl_file_cache = NULL;
+#endif
+
 #ifdef ACPI_DBG_TRACK_ALLOCATIONS
 
 	/* Debug only - display leftover memory allocation, if any */
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index bd5ea31..615a885 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -627,4 +627,5 @@ acpi_trace_point(acpi_trace_event_type type, u8 begin, u8 *aml, char *pathname)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_trace_point)
+
 #endif
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 0774007..6db3b46 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -78,6 +78,7 @@
 #define ACPI_MAX_EXTPARSE_CACHE_DEPTH   96	/* Parse tree objects */
 #define ACPI_MAX_OBJECT_CACHE_DEPTH     96	/* Interpreter operand objects */
 #define ACPI_MAX_NAMESPACE_CACHE_DEPTH  96	/* Namespace objects */
+#define ACPI_MAX_COMMENT_CACHE_DEPTH    96	/* Comments for the -ca option */
 
 /*
  * Should the subsystem abort the loading of an ACPI table if the
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 83666cb..eb0eadc 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -87,6 +87,7 @@
 #define ACPI_SIG_WDAT           "WDAT"	/* Watchdog Action Table */
 #define ACPI_SIG_WDDT           "WDDT"	/* Watchdog Timer Description Table */
 #define ACPI_SIG_WDRT           "WDRT"	/* Watchdog Resource Table */
+#define ACPI_SIG_XXXX           "XXXX"	/* Intermediate AML header for ASL/ASL+ converter */
 
 #ifdef ACPI_UNDEFINED_TABLES
 /*
-- 
2.7.4

