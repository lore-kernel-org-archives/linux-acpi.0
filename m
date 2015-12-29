From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 30/42] ACPICA: Update internal #defines for ObjectType operator. No functional change
Date: Tue, 29 Dec 2015 14:00:28 +0800
Message-ID: <f325fe635a1a0388784c7132ac649b57ec154395.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55866 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753644AbbL2GAe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Dec 2015 01:00:34 -0500
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 5923a9be36b8cb1b62afa89fe217783c04c92ad3

To improve readability. Rename all *_TYPE_* defines related to
ObjectType to *_OBJECT_TYPE_*

Link: https://github.com/acpica/acpica/commit/5923a9be
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acopcode.h |    4 ++--
 drivers/acpi/acpica/amlcode.h  |    2 +-
 drivers/acpi/acpica/exoparg1.c |    2 +-
 drivers/acpi/acpica/psopcode.c |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index 05f80de..c6b2f42 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -152,6 +152,7 @@
 #define ARGP_NAMEPATH_OP                ARGP_LIST1 (ARGP_NAMESTRING)
 #define ARGP_NOOP_OP                    ARG_NONE
 #define ARGP_NOTIFY_OP                  ARGP_LIST2 (ARGP_SUPERNAME,  ARGP_TERMARG)
+#define ARGP_OBJECT_TYPE_OP             ARGP_LIST1 (ARGP_NAME_OR_REF)
 #define ARGP_ONE_OP                     ARG_NONE
 #define ARGP_ONES_OP                    ARG_NONE
 #define ARGP_PACKAGE_OP                 ARGP_LIST3 (ARGP_PKGLENGTH,  ARGP_BYTEDATA,      ARGP_DATAOBJLIST)
@@ -185,7 +186,6 @@
 #define ARGP_TO_HEX_STR_OP              ARGP_LIST2 (ARGP_TERMARG,    ARGP_TARGET)
 #define ARGP_TO_INTEGER_OP              ARGP_LIST2 (ARGP_TERMARG,    ARGP_TARGET)
 #define ARGP_TO_STRING_OP               ARGP_LIST3 (ARGP_TERMARG,    ARGP_TERMARG,       ARGP_TARGET)
-#define ARGP_TYPE_OP                    ARGP_LIST1 (ARGP_NAME_OR_REF)
 #define ARGP_UNLOAD_OP                  ARGP_LIST1 (ARGP_SUPERNAME)
 #define ARGP_VAR_PACKAGE_OP             ARGP_LIST3 (ARGP_PKGLENGTH,  ARGP_TERMARG,       ARGP_DATAOBJLIST)
 #define ARGP_WAIT_OP                    ARGP_LIST2 (ARGP_SUPERNAME,  ARGP_TERMARG)
@@ -285,6 +285,7 @@
 #define ARGI_NAMEPATH_OP                ARGI_INVALID_OPCODE
 #define ARGI_NOOP_OP                    ARG_NONE
 #define ARGI_NOTIFY_OP                  ARGI_LIST2 (ARGI_DEVICE_REF, ARGI_INTEGER)
+#define ARGI_OBJECT_TYPE_OP             ARGI_LIST1 (ARGI_ANYTYPE)
 #define ARGI_ONE_OP                     ARG_NONE
 #define ARGI_ONES_OP                    ARG_NONE
 #define ARGI_PACKAGE_OP                 ARGI_LIST1 (ARGI_INTEGER)
@@ -318,7 +319,6 @@
 #define ARGI_TO_HEX_STR_OP              ARGI_LIST2 (ARGI_COMPUTEDATA,ARGI_FIXED_TARGET)
 #define ARGI_TO_INTEGER_OP              ARGI_LIST2 (ARGI_COMPUTEDATA,ARGI_FIXED_TARGET)
 #define ARGI_TO_STRING_OP               ARGI_LIST3 (ARGI_BUFFER,     ARGI_INTEGER,       ARGI_FIXED_TARGET)
-#define ARGI_TYPE_OP                    ARGI_LIST1 (ARGI_ANYTYPE)
 #define ARGI_UNLOAD_OP                  ARGI_LIST1 (ARGI_DDBHANDLE)
 #define ARGI_VAR_PACKAGE_OP             ARGI_LIST1 (ARGI_INTEGER)
 #define ARGI_WAIT_OP                    ARGI_LIST2 (ARGI_EVENT,      ARGI_INTEGER)
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index 2eedfa2..ab9f3f1 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -120,7 +120,7 @@
 #define AML_CREATE_WORD_FIELD_OP    (u16) 0x8b
 #define AML_CREATE_BYTE_FIELD_OP    (u16) 0x8c
 #define AML_CREATE_BIT_FIELD_OP     (u16) 0x8d
-#define AML_TYPE_OP                 (u16) 0x8e
+#define AML_OBJECT_TYPE_OP          (u16) 0x8e
 #define AML_CREATE_QWORD_FIELD_OP   (u16) 0x8f	/* ACPI 2.0 */
 #define AML_LAND_OP                 (u16) 0x90
 #define AML_LOR_OP                  (u16) 0x91
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index bcdf43c..efe7ac3 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -686,7 +686,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 		status = acpi_ex_store(return_desc, operand[0], walk_state);
 		break;
 
-	case AML_TYPE_OP:	/* object_type (source_object) */
+	case AML_OBJECT_TYPE_OP:	/* object_type (source_object) */
 		/*
 		 * Note: The operand is not resolved at this point because we want to
 		 * get the associated object, not its value. For example, we don't
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index c3005bd..40909dd 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -380,7 +380,7 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
 			 AML_TYPE_CREATE_FIELD,
 			 AML_HAS_ARGS | AML_NSOBJECT | AML_NSNODE |
 			 AML_DEFER | AML_CREATE),
-/* 37 */ ACPI_OP("ObjectType", ARGP_TYPE_OP, ARGI_TYPE_OP,
+/* 37 */ ACPI_OP("ObjectType", ARGP_OBJECT_TYPE_OP, ARGI_OBJECT_TYPE_OP,
 			 ACPI_TYPE_ANY, AML_CLASS_EXECUTE,
 			 AML_TYPE_EXEC_1A_0T_1R,
 			 AML_FLAGS_EXEC_1A_0T_1R | AML_NO_OPERAND_RESOLVE),
-- 
1.7.10

