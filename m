From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 43/53] ACPICA: Changing External to a named object
Date: Mon,  5 Jun 2017 16:41:28 +0800
Message-ID: <20cccceff7d424ec9968d01ab92bb2bdfafab5c5.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26323 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbdFEIlc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:41:32 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

From: Erik Schmauss <erik.schmauss@intel.com>

ACPICA commit 0d5dd42fd7d5129835b6d92250378a962eb73cb3

This is done so that the aml parser will build the parse tree of
External Op as a named object. This is done to streamline creation
of external op parse nodes and facilitate namespace resolution of
externals.

Link: https://github.com/acpica/acpica/commit/0d5dd42f
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acopcode.h | 2 +-
 drivers/acpi/acpica/psopcode.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index a5d9af7..cbd59a3 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -112,7 +112,7 @@
 #define ARGP_DWORD_OP                   ARGP_LIST1 (ARGP_DWORDDATA)
 #define ARGP_ELSE_OP                    ARGP_LIST2 (ARGP_PKGLENGTH,  ARGP_TERMLIST)
 #define ARGP_EVENT_OP                   ARGP_LIST1 (ARGP_NAME)
-#define ARGP_EXTERNAL_OP                ARGP_LIST3 (ARGP_NAMESTRING, ARGP_BYTEDATA,      ARGP_BYTEDATA)
+#define ARGP_EXTERNAL_OP                ARGP_LIST3 (ARGP_NAME,       ARGP_BYTEDATA,      ARGP_BYTEDATA)
 #define ARGP_FATAL_OP                   ARGP_LIST3 (ARGP_BYTEDATA,   ARGP_DWORDDATA,     ARGP_TERMARG)
 #define ARGP_FIELD_OP                   ARGP_LIST4 (ARGP_PKGLENGTH,  ARGP_NAMESTRING,    ARGP_BYTEDATA,  ARGP_FIELDLIST)
 #define ARGP_FIND_SET_LEFT_BIT_OP       ARGP_LIST2 (ARGP_TERMARG,    ARGP_TARGET)
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index c343a0d..a402ad7 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -650,9 +650,11 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
 
 /* ACPI 6.0 opcodes */
 
-	/* 81 */ ACPI_OP("External", ARGP_EXTERNAL_OP, ARGI_EXTERNAL_OP,
-			 ACPI_TYPE_ANY, AML_CLASS_EXECUTE, /* ? */
-			 AML_TYPE_EXEC_3A_0T_0R, AML_FLAGS_EXEC_3A_0T_0R),
+/* 81 */ ACPI_OP("External", ARGP_EXTERNAL_OP, ARGI_EXTERNAL_OP,
+			 ACPI_TYPE_ANY, AML_CLASS_NAMED_OBJECT,
+			 AML_TYPE_NAMED_SIMPLE,
+			 AML_HAS_ARGS | AML_NSOBJECT | AML_NSOPCODE |
+			 AML_NSNODE | AML_NAMED),
 /* 82 */ ACPI_OP("Comment", ARGP_COMMENT_OP, ARGI_COMMENT_OP,
 			 ACPI_TYPE_STRING, AML_CLASS_ARGUMENT,
 			 AML_TYPE_LITERAL, AML_CONSTANT)
-- 
2.7.4

