From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0] ACPICA: Linuxize: Restore and fix intel compiler build
Date: Tue, 11 Apr 2017 15:47:29 +0800
Message-ID: <1491896851-2788-1-git-send-email-lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:56273 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752301AbdDKHrj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Apr 2017 03:47:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch restores Intel compiler settings for ACPICA components.
And fixes its inclusion in acenv.h.

Reported-by: Stepan M Mishura <stepan.m.mishura@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 acenv.h   |    2 -
 acintel.h |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 1 deletion(-)

diff -Nurp linux.before_name/include/acpi/platform/acenv.h linux.after_name/include/acpi/platform/acenv.h
--- linux.before_name/include/acpi/platform/acenv.h	2017-01-23 16:59:01.175083079 +0800
+++ linux.after_name/include/acpi/platform/acenv.h	2017-01-23 16:58:57.009993609 +0800
@@ -177,7 +177,7 @@
 #include "acmsvc.h"
 
 #elif defined(__INTEL_COMPILER)
-#include "acintel.h"
+#include <acpi/platform/acintel.h>
 
 #endif
 
diff -Nurp linux.before_name/include/acpi/platform/acintel.h linux.after_name/include/acpi/platform/acintel.h
--- linux.before_name/include/acpi/platform/acintel.h	1970-01-01 08:00:00.000000000 +0800
+++ linux.after_name/include/acpi/platform/acintel.h	2017-01-23 16:58:57.009993609 +0800
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
