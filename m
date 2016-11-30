From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/11] ACPICA: Utilities: Add new decode function for parser values
Date: Wed, 30 Nov 2016 15:21:57 +0800
Message-ID: <248be85c58ad646f6196c034835d75ded69178d5.1480490191.git.lv.zheng@intel.com>
References: <cover.1480490191.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1991 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756991AbcK3HWB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Nov 2016 02:22:01 -0500
In-Reply-To: <cover.1480490191.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 198fde8a061ac77357bcf1752e3c988fbe59f128

Implements a decode function for the ARGP_* parser info values
for all AML opcodes.

Link: https://github.com/acpica/acpica/commit/198fde8a
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h  |    2 ++
 drivers/acpi/acpica/amlcode.h  |    1 +
 drivers/acpi/acpica/utdecode.c |   49 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 0a1b53c..845afb1 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -232,6 +232,8 @@ struct acpi_pkg_info {
 
 const char *acpi_ut_get_event_name(u32 event_id);
 
+const char *acpi_ut_get_argument_type_name(u32 arg_type);
+
 char acpi_ut_hex_to_ascii_char(u64 integer, u32 position);
 
 acpi_status acpi_ut_ascii_to_hex_byte(char *two_ascii_chars, u8 *return_byte);
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index 04fbd88..8a0f959 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -240,6 +240,7 @@
 #define ARGP_QWORDDATA              0x11
 #define ARGP_SIMPLENAME             0x12	/* name_string | local_term | arg_term */
 #define ARGP_NAME_OR_REF            0x13	/* For object_type only */
+#define ARGP_MAX                    0x13
 
 /*
  * Resolved argument types for the AML Interpreter
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 15728ad..b3d8421 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -44,6 +44,7 @@
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acnamesp.h"
+#include "amlcode.h"
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utdecode")
@@ -532,6 +533,54 @@ const char *acpi_ut_get_notify_name(u32 notify_value, acpi_object_type type)
 
 	return ("Hardware-Specific");
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_get_argument_type_name
+ *
+ * PARAMETERS:  arg_type            - an ARGP_* parser argument type
+ *
+ * RETURN:      Decoded ARGP_* type
+ *
+ * DESCRIPTION: Decode an ARGP_* parser type, as defined in the amlcode.h file,
+ *              and used in the acopcode.h file. For example, ARGP_TERMARG.
+ *              Used for debug only.
+ *
+ ******************************************************************************/
+
+static const char *acpi_gbl_argument_type[20] = {
+	/* 00 */ "Unknown ARGP",
+	/* 01 */ "ByteData",
+	/* 02 */ "ByteList",
+	/* 03 */ "CharList",
+	/* 04 */ "DataObject",
+	/* 05 */ "DataObjectList",
+	/* 06 */ "DWordData",
+	/* 07 */ "FieldList",
+	/* 08 */ "Name",
+	/* 09 */ "NameString",
+	/* 0A */ "ObjectList",
+	/* 0B */ "PackageLength",
+	/* 0C */ "SuperName",
+	/* 0D */ "Target",
+	/* 0E */ "TermArg",
+	/* 0F */ "TermList",
+	/* 10 */ "WordData",
+	/* 11 */ "QWordData",
+	/* 12 */ "SimpleName",
+	/* 13 */ "NameOrRef"
+};
+
+const char *acpi_ut_get_argument_type_name(u32 arg_type)
+{
+
+	if (arg_type > ARGP_MAX) {
+		return ("Unknown ARGP");
+	}
+
+	return (acpi_gbl_argument_type[arg_type]);
+}
+
 #endif
 
 /*******************************************************************************
-- 
1.7.10

