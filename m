From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/21] ACPICA: Parser: Updates/fixes for debug output.
Date: Wed,  8 Jan 2014 13:44:26 +0800
Message-ID: <af7ce8857153f4409af6644b4486d67975a7c661.1387505703.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50025 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754788AbaAHFof (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:44:35 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Linux kernel behaviour is not affected as the change only applies to
the compiler which is not shipped in the Linux kernel.

Major changes in this patch are made to improve the debug output mode of
the compiler.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/psopinfo.c |   49 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/psopinfo.c b/drivers/acpi/acpica/psopinfo.c
index 9ba5301..d7bba3c 100644
--- a/drivers/acpi/acpica/psopinfo.c
+++ b/drivers/acpi/acpica/psopinfo.c
@@ -71,6 +71,8 @@ static const u8 acpi_gbl_argument_count[] =
 
 const struct acpi_opcode_info *acpi_ps_get_opcode_info(u16 opcode)
 {
+	const char *opcode_name = "Unknown AML opcode";
+
 	ACPI_FUNCTION_NAME(ps_get_opcode_info);
 
 	/*
@@ -92,11 +94,54 @@ const struct acpi_opcode_info *acpi_ps_get_opcode_info(u16 opcode)
 		return (&acpi_gbl_aml_op_info
 			[acpi_gbl_long_op_index[(u8)opcode]]);
 	}
+#ifdef ACPI_ASL_COMPILER
+#include "asldefine.h"
+
+	switch (opcode) {
+	case AML_RAW_DATA_BYTE:
+		opcode_name = "-Raw Data Byte-";
+		break;
+
+	case AML_RAW_DATA_WORD:
+		opcode_name = "-Raw Data Word-";
+		break;
+
+	case AML_RAW_DATA_DWORD:
+		opcode_name = "-Raw Data Dword-";
+		break;
+
+	case AML_RAW_DATA_QWORD:
+		opcode_name = "-Raw Data Qword-";
+		break;
+
+	case AML_RAW_DATA_BUFFER:
+		opcode_name = "-Raw Data Buffer-";
+		break;
+
+	case AML_RAW_DATA_CHAIN:
+		opcode_name = "-Raw Data Buffer Chain-";
+		break;
+
+	case AML_PACKAGE_LENGTH:
+		opcode_name = "-Package Length-";
+		break;
+
+	case AML_UNASSIGNED_OPCODE:
+		opcode_name = "-Unassigned Opcode-";
+		break;
+
+	case AML_DEFAULT_ARG_OP:
+		opcode_name = "-Default Arg-";
+		break;
+
+	default:
+		break;
+	}
+#endif
 
 	/* Unknown AML opcode */
 
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-			  "Unknown AML opcode [%4.4X]\n", opcode));
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%s [%4.4X]\n", opcode_name, opcode));
 
 	return (&acpi_gbl_aml_op_info[_UNK]);
 }
-- 
1.7.10

