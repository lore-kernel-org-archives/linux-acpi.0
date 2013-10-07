From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] ACPICA: Silent warnings about empty body in if/else
 statement
Date: Mon, 7 Oct 2013 11:45:01 +0200
Message-ID: <20131007114501.1519f7dd@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37671 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752895Ab3JGJpI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Oct 2013 05:45:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

When ACPI debugging is disabled, I see warnings like this one:

drivers/i2c/busses/i2c-scmi.c: In function "acpi_smbus_cmi_add_cap":
drivers/i2c/busses/i2c-scmi.c:328:39: warning: suggest braces around empty body in an "else" statement [-Wempty-body]
drivers/i2c/busses/i2c-scmi.c:338:12: warning: suggest braces around empty body in an "else" statement [-Wempty-body]

It is caused by ACPI_DEBUG_PRINT (or other similar macros) to resolve
to nothing. Make them resolve to the classic "do {} while (0)" construct
instead when the compiler likes that, to silent all such warnings.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
---
 include/acpi/acoutput.h |   40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

--- linux-3.12-rc4.orig/include/acpi/acoutput.h	2013-09-24 00:41:09.000000000 +0200
+++ linux-3.12-rc4/include/acpi/acoutput.h	2013-10-07 11:23:57.928436503 +0200
@@ -427,22 +427,32 @@
 /*
  * This is the non-debug case -- make everything go away,
  * leaving no executable debug code!
+ *
+ * Note: the ACPI_DO_WHILE0 macro is used to prevent some compilers from
+ * complaining about these constructs. On other compilers the do...while
+ * adds some extra code, so this feature is optional.
  */
-#define ACPI_DEBUG_PRINT(pl)
-#define ACPI_DEBUG_PRINT_RAW(pl)
-#define ACPI_DEBUG_EXEC(a)
-#define ACPI_DEBUG_ONLY_MEMBERS(a)
-#define ACPI_FUNCTION_NAME(a)
-#define ACPI_FUNCTION_TRACE(a)
-#define ACPI_FUNCTION_TRACE_PTR(a, b)
-#define ACPI_FUNCTION_TRACE_U32(a, b)
-#define ACPI_FUNCTION_TRACE_STR(a, b)
-#define ACPI_FUNCTION_ENTRY()
-#define ACPI_DUMP_STACK_ENTRY(a)
-#define ACPI_DUMP_OPERANDS(a, b, c)
-#define ACPI_DUMP_ENTRY(a, b)
-#define ACPI_DUMP_PATHNAME(a, b, c, d)
-#define ACPI_DUMP_BUFFER(a, b)
+#ifdef ACPI_USE_DO_WHILE_0
+#define ACPI_DO_WHILE0                  do {} while (0)
+#else
+#define ACPI_DO_WHILE0
+#endif
+
+#define ACPI_DEBUG_PRINT(pl)            ACPI_DO_WHILE0
+#define ACPI_DEBUG_PRINT_RAW(pl)        ACPI_DO_WHILE0
+#define ACPI_DEBUG_EXEC(a)              ACPI_DO_WHILE0
+#define ACPI_DEBUG_ONLY_MEMBERS(a)      ACPI_DO_WHILE0
+#define ACPI_FUNCTION_NAME(a)           ACPI_DO_WHILE0
+#define ACPI_FUNCTION_TRACE(a)          ACPI_DO_WHILE0
+#define ACPI_FUNCTION_TRACE_PTR(a, b)   ACPI_DO_WHILE0
+#define ACPI_FUNCTION_TRACE_U32(a, b)   ACPI_DO_WHILE0
+#define ACPI_FUNCTION_TRACE_STR(a, b)   ACPI_DO_WHILE0
+#define ACPI_FUNCTION_ENTRY()           ACPI_DO_WHILE0
+#define ACPI_DUMP_STACK_ENTRY(a)        ACPI_DO_WHILE0
+#define ACPI_DUMP_OPERANDS(a, b, c)     ACPI_DO_WHILE0
+#define ACPI_DUMP_ENTRY(a, b)           ACPI_DO_WHILE0
+#define ACPI_DUMP_PATHNAME(a, b, c, d)  ACPI_DO_WHILE0
+#define ACPI_DUMP_BUFFER(a, b)          ACPI_DO_WHILE0
 #define ACPI_IS_DEBUG_ENABLED(level, component) 0
 
 /* Return macros must have a return statement at the minimum */


-- 
Jean Delvare
Suse L3
