From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/4] ACPICA: Linuxize: Restore and fix intel compiler build
Date: Wed,  8 Feb 2017 11:00:01 +0800
Message-ID: <66c136ec5ccd718abe72f693b7d937b0f7912c64.1486522441.git.lv.zheng@intel.com>
References: <cover.1486522441.git.lv.zheng@intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <cover.1486522441.git.lv.zheng@intel.com>
Sender: stable-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org, #@vger.kernel.org, 4.9+@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

ACPICA commit b59347d0b8b676cb555fe8da5cad08fcd4eeb0d3

The following commit cleans up compiler specific inclusions:
  Commit: 9fa1cebdbfff3db8953cebca8ee327d75edefc40
  Subject: ACPICA: OSL: Cleanup the inclusion order of the
           compiler-specific headers
But breaks one thing due to the following old issue:
 Buidling Linux kernel with Intel compiler originally depends on acgcc.h
 not acintel.h.
So after making Intel compiler build working in ACPICA upstream by
correctly using acintel.h, it becomes unable to build Linux kernel using
Intel compiler as there is no acintel.h in the kernel source tree.

This patch releases acintel.h to Linux kernel and fixes its inclusion in
acenv.h.

Fixes: 9fa1cebdbfff ("ACPICA: OSL: Cleanup the inclusion order of the compiler-specific headers")
Cc: stable@vger.kernel.org # 4.9+
Link: https://github.com/acpica/acpica/commit/b59347d0
Tested-by: Stepan M Mishura <stepan.m.mishura@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/acenv.h   |  2 +-
 include/acpi/platform/acintel.h | 87 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 include/acpi/platform/acintel.h

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 926efe9..6fa9c52 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -178,7 +178,7 @@
 #include "acmsvc.h"
 
 #elif defined(__INTEL_COMPILER)
-#include "acintel.h"
+#include <acpi/platform/acintel.h>
 
 #endif
 
diff --git a/include/acpi/platform/acintel.h b/include/acpi/platform/acintel.h
new file mode 100644
index 0000000..17bd3b7
--- /dev/null
+++ b/include/acpi/platform/acintel.h
@@ -0,0 +1,87 @@
+/******************************************************************************
+ *
+ * Name: acintel.h - VC specific defines, etc.
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2017, Intel Corp.
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
+#ifndef __ACINTEL_H__
+#define __ACINTEL_H__
+
+/*
+ * Use compiler specific <stdarg.h> is a good practice for even when
+ * -nostdinc is specified (i.e., ACPI_USE_STANDARD_HEADERS undefined.
+ */
+#include <stdarg.h>
+
+/* Configuration specific to Intel 64-bit C compiler */
+
+#define COMPILER_DEPENDENT_INT64    __int64
+#define COMPILER_DEPENDENT_UINT64   unsigned __int64
+#define ACPI_INLINE                 __inline
+
+/*
+ * Calling conventions:
+ *
+ * ACPI_SYSTEM_XFACE        - Interfaces to host OS (handlers, threads)
+ * ACPI_EXTERNAL_XFACE      - External ACPI interfaces
+ * ACPI_INTERNAL_XFACE      - Internal ACPI interfaces
+ * ACPI_INTERNAL_VAR_XFACE  - Internal variable-parameter list interfaces
+ */
+#define ACPI_SYSTEM_XFACE
+#define ACPI_EXTERNAL_XFACE
+#define ACPI_INTERNAL_XFACE
+#define ACPI_INTERNAL_VAR_XFACE
+
+/* remark 981 - operands evaluated in no particular order */
+#pragma warning(disable:981)
+
+/* warn C4100: unreferenced formal parameter */
+#pragma warning(disable:4100)
+
+/* warn C4127: conditional expression is constant */
+#pragma warning(disable:4127)
+
+/* warn C4706: assignment within conditional expression */
+#pragma warning(disable:4706)
+
+/* warn C4214: bit field types other than int */
+#pragma warning(disable:4214)
+
+#endif				/* __ACINTEL_H__ */
-- 
2.7.4
