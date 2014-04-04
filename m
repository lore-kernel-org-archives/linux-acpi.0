From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/28] ACPICA: gcc-specific: Fix possible issue with the strchr function.
Date: Fri,  4 Apr 2014 12:37:19 +0800
Message-ID: <992acb48929fb24748d95de20808ff15e4c18fcc.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18383 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbaDDEhX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:37:23 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

Some versions of gcc implement strchr via a macro, which either
contains bugs or can provoke a bug in the compiler. This change
fixes a possible compile-time error when using this function.
The problem is usually seen when compiling the getopt.c module.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/acgcc.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index a476b91..384875d 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -64,4 +64,15 @@
  */
 #define ACPI_UNUSED_VAR __attribute__ ((unused))
 
+/*
+ * Some versions of gcc implement strchr() with a buggy macro. So,
+ * undef it here. Prevents error messages of this form (usually from the
+ * file getopt.c):
+ *
+ * error: logical '&&' with non-zero constant will always evaluate as true
+ */
+#ifdef strchr
+#undef strchr
+#endif
+
 #endif				/* __ACGCC_H__ */
-- 
1.7.10

