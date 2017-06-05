From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 28/53] ACPICA: OSL: Add support to exclude stdarg.h
Date: Mon,  5 Jun 2017 16:39:56 +0800
Message-ID: <7c3d9f72e9d7a86ea04d2d0d3209f413d12bc0d5.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:47870 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751771AbdFEIj7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:39:59 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit e2df7455a9a4301b03668e4c9c02c7a564cc841c

Some hosts may choose not to include stdarg.h, implementing a
configurability in acgcc.h, allowing OSen like Solaris to exclude stdarg.h.
This patch also fixes acintel.h accordingly without providing builtin
support as Intel compiler is similar as GCC. Reported by Dana Myers, fixed
by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/e2df7455
Reported-by: Dana Myers <dana.myers@oracle.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/platform/acgcc.h   | 10 ++++++++++
 include/acpi/platform/acintel.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index e877a35..97a7e21 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -48,7 +48,17 @@
  * Use compiler specific <stdarg.h> is a good practice for even when
  * -nostdinc is specified (i.e., ACPI_USE_STANDARD_HEADERS undefined.
  */
+#ifndef va_arg
+#ifdef ACPI_USE_BUILTIN_STDARG
+typedef __builtin_va_list va_list;
+#define va_start(v, l)          __builtin_va_start(v, l)
+#define va_end(v)               __builtin_va_end(v)
+#define va_arg(v, l)            __builtin_va_arg(v, l)
+#define va_copy(d, s)           __builtin_va_copy(d, s)
+#else
 #include <stdarg.h>
+#endif
+#endif
 
 #define ACPI_INLINE             __inline__
 
diff --git a/include/acpi/platform/acintel.h b/include/acpi/platform/acintel.h
index 17bd3b7..bdb6858 100644
--- a/include/acpi/platform/acintel.h
+++ b/include/acpi/platform/acintel.h
@@ -48,7 +48,9 @@
  * Use compiler specific <stdarg.h> is a good practice for even when
  * -nostdinc is specified (i.e., ACPI_USE_STANDARD_HEADERS undefined.
  */
+#ifndef va_arg
 #include <stdarg.h>
+#endif
 
 /* Configuration specific to Intel 64-bit C compiler */
 
-- 
2.7.4

