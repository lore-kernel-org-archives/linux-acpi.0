From: akpm@linux-foundation.org
Subject: [patch 4/7] acpi: fix empty macros
Date: Mon, 09 Jul 2007 11:33:14 -0700
Message-ID: <200707091833.l69IXEb7000344@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45230 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754198AbXGISde (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jul 2007 14:33:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, davej@redhat.com

From: Dave Jones <davej@redhat.com>

ACPI has a ton of macros which make a bunch of empty if's when configured
in non-debug mode.

Signed-off-by: Dave Jones <davej@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/glue.c     |    2 -
 include/acpi/acmacros.h |   40 +++++++++++++++++++-------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff -puN drivers/acpi/glue.c~fix-empty-macros-in-acpi drivers/acpi/glue.c
--- a/drivers/acpi/glue.c~fix-empty-macros-in-acpi
+++ a/drivers/acpi/glue.c
@@ -16,7 +16,7 @@
 #if ACPI_GLUE_DEBUG
 #define DBG(x...) printk(PREFIX x)
 #else
-#define DBG(x...)
+#define DBG(x...) do { } while(0)
 #endif
 static LIST_HEAD(bus_type_list);
 static DECLARE_RWSEM(bus_type_sem);
diff -puN include/acpi/acmacros.h~fix-empty-macros-in-acpi include/acpi/acmacros.h
--- a/include/acpi/acmacros.h~fix-empty-macros-in-acpi
+++ a/include/acpi/acmacros.h
@@ -622,26 +622,26 @@
 #define ACPI_DEBUG_EXEC(a)
 #define ACPI_NORMAL_EXEC(a)             a;
 
-#define ACPI_DEBUG_DEFINE(a)
-#define ACPI_DEBUG_ONLY_MEMBERS(a)
-#define ACPI_FUNCTION_NAME(a)
-#define ACPI_FUNCTION_TRACE(a)
-#define ACPI_FUNCTION_TRACE_PTR(a,b)
-#define ACPI_FUNCTION_TRACE_U32(a,b)
-#define ACPI_FUNCTION_TRACE_STR(a,b)
-#define ACPI_FUNCTION_EXIT
-#define ACPI_FUNCTION_STATUS_EXIT(s)
-#define ACPI_FUNCTION_VALUE_EXIT(s)
-#define ACPI_FUNCTION_ENTRY()
-#define ACPI_DUMP_STACK_ENTRY(a)
-#define ACPI_DUMP_OPERANDS(a,b,c,d,e)
-#define ACPI_DUMP_ENTRY(a,b)
-#define ACPI_DUMP_TABLES(a,b)
-#define ACPI_DUMP_PATHNAME(a,b,c,d)
-#define ACPI_DUMP_RESOURCE_LIST(a)
-#define ACPI_DUMP_BUFFER(a,b)
-#define ACPI_DEBUG_PRINT(pl)
-#define ACPI_DEBUG_PRINT_RAW(pl)
+#define ACPI_DEBUG_DEFINE(a)		do { } while(0)
+#define ACPI_DEBUG_ONLY_MEMBERS(a)	do { } while(0)
+#define ACPI_FUNCTION_NAME(a)		do { } while(0)
+#define ACPI_FUNCTION_TRACE(a)		do { } while(0)
+#define ACPI_FUNCTION_TRACE_PTR(a,b)	do { } while(0)
+#define ACPI_FUNCTION_TRACE_U32(a,b)	do { } while(0)
+#define ACPI_FUNCTION_TRACE_STR(a,b)	do { } while(0)
+#define ACPI_FUNCTION_EXIT		do { } while(0)
+#define ACPI_FUNCTION_STATUS_EXIT(s)	do { } while(0)
+#define ACPI_FUNCTION_VALUE_EXIT(s)	do { } while(0)
+#define ACPI_FUNCTION_ENTRY()		do { } while(0)
+#define ACPI_DUMP_STACK_ENTRY(a)	do { } while(0)
+#define ACPI_DUMP_OPERANDS(a,b,c,d,e)	do { } while(0)
+#define ACPI_DUMP_ENTRY(a,b)		do { } while(0)
+#define ACPI_DUMP_TABLES(a,b)		do { } while(0)
+#define ACPI_DUMP_PATHNAME(a,b,c,d)	do { } while(0)
+#define ACPI_DUMP_RESOURCE_LIST(a)	do { } while(0)
+#define ACPI_DUMP_BUFFER(a,b)		do { } while(0)
+#define ACPI_DEBUG_PRINT(pl)		do { } while(0)
+#define ACPI_DEBUG_PRINT_RAW(pl)	do { } while(0)
 
 #define return_VOID                     return
 #define return_ACPI_STATUS(s)           return(s)
_
