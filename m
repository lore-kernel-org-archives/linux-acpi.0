From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 29/30] ACPICA: OSL: Fix a regression that old GCC requires a workaround for strchr()
Date: Thu,  4 Aug 2016 16:45:47 +0800
Message-ID: <17dc52dc23f994d66268f11fd8b7b59c4229abc0.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:45070 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932351AbcHDIp7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:45:59 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit be836c36454a624a4fb1d17234080ef8c07993fc

There is a GCC false-warning issue on specific GCC versions that
"strchr" will be preprocessed and extracted to contain
!__buildin_constant_p() checker and it surely is a constant logical
value "1" for strchr() arguments. Then -Wlogical-op errorneously reports a
warning.

The regression is triggered after the standard headers are re-ordered in
the EFI porting task. This patch fixes this regression by moving the
workaround to a new position after including all other standard headers.

Link: https://github.com/acpica/acpica/commit/be836c36
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/platform/acenvex.h |    5 +++-
 include/acpi/platform/acgcc.h   |   11 --------
 include/acpi/platform/acgccex.h |   58 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 12 deletions(-)
 create mode 100644 include/acpi/platform/acgccex.h

diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
index 060fb08..b3171b9 100644
--- a/include/acpi/platform/acenvex.h
+++ b/include/acpi/platform/acenvex.h
@@ -69,7 +69,10 @@
 
 #endif
 
-#if defined(_MSC_VER)
+#if defined(__GNUC__) && !defined(__INTEL_COMPILER)
+#include "acgccex.h"
+
+#elif defined(_MSC_VER)
 #include "acmsvcex.h"
 
 #endif
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 9f79e98..8f66aaa 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -70,17 +70,6 @@
  */
 #define ACPI_UNUSED_VAR __attribute__ ((unused))
 
-/*
- * Some versions of gcc implement strchr() with a buggy macro. So,
- * undef it here. Prevents error messages of this form (usually from the
- * file getopt.c):
- *
- * error: logical '&&' with non-zero constant will always evaluate as true
- */
-#ifdef strchr
-#undef strchr
-#endif
-
 /* GCC supports __VA_ARGS__ in macros */
 
 #define COMPILER_VA_MACRO               1
diff --git a/include/acpi/platform/acgccex.h b/include/acpi/platform/acgccex.h
new file mode 100644
index 0000000..46ead2c
--- /dev/null
+++ b/include/acpi/platform/acgccex.h
@@ -0,0 +1,58 @@
+/******************************************************************************
+ *
+ * Name: acgccex.h - Extra GCC specific defines, etc.
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2016, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#ifndef __ACGCCEX_H__
+#define __ACGCCEX_H__
+
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
+#endif				/* __ACGCCEX_H__ */
-- 
1.7.10

