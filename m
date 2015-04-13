From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 22/31] ACPICA: Add infrastructure for External() opcode.
Date: Mon, 13 Apr 2015 11:50:32 +0800
Message-ID: <41f0bbc5c5e1829b9e40f688f68453e77070e899.1428893938.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit d115fe2ffdab449d6107d58580c5afd0a81d65fe

This change adds the basic low-level infrastructure for the External
AML opcode. The interpreter will simply ignore this op, as the op
is intended for use by the disassembler only.

Note that External() opcode is useful for disassembler, interpreter
can simply ignore it and still return exceptions for unknown control
methods so the kernel part only includes the grammar definition of
External() opcode in order to ignore it but doesn't interpret it.

Link: https://github.com/acpica/acpica/commit/d115fe2f
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h  |    2 +-
 drivers/acpi/acpica/acopcode.h |    2 ++
 drivers/acpi/acpica/amlcode.h  |    1 +
 drivers/acpi/acpica/dsutils.c  |   11 +++++++++++
 drivers/acpi/acpica/exoparg3.c |   13 ++++++++++++-
 drivers/acpi/acpica/psopcode.c |    8 +++++++-
 drivers/acpi/acpica/psopinfo.c |    2 +-
 7 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 7add32e..87b2752 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -53,7 +53,7 @@ typedef u32 acpi_mutex_handle;
 
 /* Total number of aml opcodes defined */
 
-#define AML_NUM_OPCODES                 0x81
+#define AML_NUM_OPCODES                 0x82
 
 /* Forward declarations */
 
diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index a5f17de..fd85ad0 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -111,6 +111,7 @@
 #define ARGP_DWORD_OP                   ARGP_LIST1 (ARGP_DWORDDATA)
 #define ARGP_ELSE_OP                    ARGP_LIST2 (ARGP_PKGLENGTH,  ARGP_TERMLIST)
 #define ARGP_EVENT_OP                   ARGP_LIST1 (ARGP_NAME)
+#define ARGP_EXTERNAL_OP                ARGP_LIST3 (ARGP_NAMESTRING, ARGP_BYTEDATA,      ARGP_BYTEDATA)
 #define ARGP_FATAL_OP                   ARGP_LIST3 (ARGP_BYTEDATA,   ARGP_DWORDDATA,     ARGP_TERMARG)
 #define ARGP_FIELD_OP                   ARGP_LIST4 (ARGP_PKGLENGTH,  ARGP_NAMESTRING,    ARGP_BYTEDATA,  ARGP_FIELDLIST)
 #define ARGP_FIND_SET_LEFT_BIT_OP       ARGP_LIST2 (ARGP_TERMARG,    ARGP_TARGET)
@@ -243,6 +244,7 @@
 #define ARGI_DWORD_OP                   ARGI_INVALID_OPCODE
 #define ARGI_ELSE_OP                    ARGI_INVALID_OPCODE
 #define ARGI_EVENT_OP                   ARGI_INVALID_OPCODE
+#define ARGI_EXTERNAL_OP                ARGI_LIST3 (ARGI_STRING,     ARGI_INTEGER,       ARGI_INTEGER)
 #define ARGI_FATAL_OP                   ARGI_LIST3 (ARGI_INTEGER,    ARGI_INTEGER,       ARGI_INTEGER)
 #define ARGI_FIELD_OP                   ARGI_INVALID_OPCODE
 #define ARGI_FIND_SET_LEFT_BIT_OP       ARGI_LIST2 (ARGI_INTEGER,    ARGI_TARGETREF)
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index 3a95068..2c47b25 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -65,6 +65,7 @@
 #define AML_PACKAGE_OP              (u16) 0x12
 #define AML_VAR_PACKAGE_OP          (u16) 0x13	/* ACPI 2.0 */
 #define AML_METHOD_OP               (u16) 0x14
+#define AML_EXTERNAL_OP             (u16) 0x15	/* ACPI 6.0 */
 #define AML_DUAL_NAME_PREFIX        (u16) 0x2e
 #define AML_MULTI_NAME_PREFIX_OP    (u16) 0x2f
 #define AML_NAME_CHAR_SUBSEQ        (u16) 0x30
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index e5ff89b..deeddd6 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -564,6 +564,17 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 								 acpi_operand_object,
 								 acpi_gbl_root_node);
 					status = AE_OK;
+				} else if (parent_op->common.aml_opcode ==
+					   AML_EXTERNAL_OP) {
+
+					/* TBD: May only be temporary */
+
+					obj_desc =
+					    acpi_ut_create_string_object((acpi_size) name_length);
+
+					ACPI_STRNCPY(obj_desc->string.pointer,
+						     name_string, name_length);
+					status = AE_OK;
 				} else {
 					/*
 					 * We just plain didn't find it -- which is a
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index b813fed..1c64a98 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -114,7 +114,18 @@ acpi_status acpi_ex_opcode_3A_0T_0R(struct acpi_walk_state *walk_state)
 		/* Might return while OS is shutting down, just continue */
 
 		ACPI_FREE(fatal);
-		break;
+		goto cleanup;
+
+	case AML_EXTERNAL_OP:
+		/*
+		 * If the interpreter sees this opcode, just ignore it. The External
+		 * op is intended for use by disassemblers in order to properly
+		 * disassemble control method invocations. The opcode or group of
+		 * opcodes should be surrounded by an "if (0)" clause to ensure that
+		 * AML interpreters never see the opcode.
+		 */
+		status = AE_OK;
+		goto cleanup;
 
 	default:
 
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index 1af4a40..ed90fdd 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -646,7 +646,13 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
 			 AML_CLASS_INTERNAL, AML_TYPE_BOGUS, AML_HAS_ARGS),
 /* 80 */ ACPI_OP("-ExtAccessField-", ARGP_CONNECTFIELD_OP,
 			 ARGI_CONNECTFIELD_OP, ACPI_TYPE_ANY,
-			 AML_CLASS_INTERNAL, AML_TYPE_BOGUS, 0)
+			 AML_CLASS_INTERNAL, AML_TYPE_BOGUS, 0),
+
+/* ACPI 6.0 opcodes */
+
+	/* 81 */ ACPI_OP("External", ARGP_EXTERNAL_OP, ARGI_EXTERNAL_OP,
+			 ACPI_TYPE_ANY, AML_CLASS_EXECUTE, /* ? */
+			 AML_TYPE_EXEC_3A_0T_0R, AML_FLAGS_EXEC_3A_0T_0R)
 
 /*! [End] no source code translation !*/
 };
diff --git a/drivers/acpi/acpica/psopinfo.c b/drivers/acpi/acpica/psopinfo.c
index e18e7c4..20e1a35 100644
--- a/drivers/acpi/acpica/psopinfo.c
+++ b/drivers/acpi/acpica/psopinfo.c
@@ -210,7 +210,7 @@ const u8 acpi_gbl_short_op_index[256] = {
 /*              8     9     A     B     C     D     E     F  */
 /* 0x00 */ 0x00, 0x01, _UNK, _UNK, _UNK, _UNK, 0x02, _UNK,
 /* 0x08 */ 0x03, _UNK, 0x04, 0x05, 0x06, 0x07, 0x6E, _UNK,
-/* 0x10 */ 0x08, 0x09, 0x0a, 0x6F, 0x0b, _UNK, _UNK, _UNK,
+/* 0x10 */ 0x08, 0x09, 0x0a, 0x6F, 0x0b, 0x81, _UNK, _UNK,
 /* 0x18 */ _UNK, _UNK, _UNK, _UNK, _UNK, _UNK, _UNK, _UNK,
 /* 0x20 */ _UNK, _UNK, _UNK, _UNK, _UNK, _UNK, _UNK, _UNK,
 /* 0x28 */ _UNK, _UNK, _UNK, _UNK, _UNK, 0x63, _PFX, _PFX,
-- 
1.7.10
