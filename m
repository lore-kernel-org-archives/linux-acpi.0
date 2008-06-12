From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/17] ACPICA: Update tracking macros to reduce code/data size
Date: Thu, 12 Jun 2008 00:35:02 -0400
Message-ID: <37a7c9836daaab14001ec349e93e861d38019484.1213245200.git.len.brown@intel.com>
References: <1213245316-20835-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:60376 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbYFLEfU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2008 00:35:20 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2C00KV11RR2614@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 23:28:40 -0500 (CDT)
In-reply-to: <1213245316-20835-1-git-send-email-lenb@kernel.org>
In-reply-to: <e3f06dd844c1cbaa5b7ef6a971c182db73b8d4e9.1213245200.git.len.brown@intel.com>
References: <e3f06dd844c1cbaa5b7ef6a971c182db73b8d4e9.1213245200.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jan Beulich <jbeulich@novell.com>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Jan Beulich <jbeulich@novell.com>

Changed ACPI_MODULE_NAME and ACPI_FUNCTION_NAME to use arrays of
strings instead of pointers to static strings. Jan Beulich and
Bob Moore.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acmacros.h |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/acpi/acmacros.h b/include/acpi/acmacros.h
index fb41a3b..4e42f67 100644
--- a/include/acpi/acmacros.h
+++ b/include/acpi/acmacros.h
@@ -414,7 +414,7 @@ struct acpi_integer_overlay {
  * error messages. The __FILE__ macro is not very useful for this, because it
  * often includes the entire pathname to the module
  */
-#define ACPI_MODULE_NAME(name)          static char ACPI_UNUSED_VAR *_acpi_module_name = name;
+#define ACPI_MODULE_NAME(name)          static char ACPI_UNUSED_VAR _acpi_module_name[] = name;
 #else
 #define ACPI_MODULE_NAME(name)
 #endif
@@ -467,19 +467,17 @@ struct acpi_integer_overlay {
 /*
  * If ACPI_GET_FUNCTION_NAME was not defined in the compiler-dependent header,
  * define it now. This is the case where there the compiler does not support
- * a __FUNCTION__ macro or equivalent. We save the function name on the
- * local stack.
+ * a __FUNCTION__ macro or equivalent.
  */
 #ifndef ACPI_GET_FUNCTION_NAME
 #define ACPI_GET_FUNCTION_NAME          _acpi_function_name
 /*
  * The Name parameter should be the procedure name as a quoted string.
- * This is declared as a local string ("MyFunctionName") so that it can
- * be also used by the function exit macros below.
+ * The function name is also used by the function exit macros below.
  * Note: (const char) is used to be compatible with the debug interfaces
  * and macros such as __FUNCTION__.
  */
-#define ACPI_FUNCTION_NAME(name)        const char *_acpi_function_name = #name;
+#define ACPI_FUNCTION_NAME(name)        static const char _acpi_function_name[] = #name;
 
 #else
 /* Compiler supports __FUNCTION__ (or equivalent) -- Ignore this macro */
-- 
1.5.6.rc2.26.g8c37

