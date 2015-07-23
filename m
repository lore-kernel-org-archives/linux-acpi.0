From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/22] ACPICA: MSVC: Fix inclusion order issue of <crtdbg.h>.
Date: Thu, 23 Jul 2015 12:53:42 +0800
Message-ID: <cc124d2fef29ea8eec3dfaa858736ba8adc34d42.1437627016.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:29565 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753630AbbGWExt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jul 2015 00:53:49 -0400
In-Reply-To: <cover.1437627016.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 49c6a6517a906900e9baa51ad5859beeb8a3089f

The following error logs can be seen for calloc/free/malloc/realloc that
defined in the stdlib.h:
...\stdlib.h(281) : error C2059: syntax error : ','
...\stdlib.h(281) : error C2143: syntax error : missing ')' before 'constant'
...\stdlib.h(281) : error C2143: syntax error : missing '{' before 'constant'
...\stdlib.h(281) : error C2059: syntax error : '<Unknown>'
...\stdlib.h(281) : error C2059: syntax error : ')'

This is caused by the wrong inclusion order of stdlib.h/crtdbg.h introduced
in acenv.h. This patch fixes this breakage. Lv Zheng.

This patch doesn't affect Linux kernel.

Link: https://github.com/acpica/acpica/commit/49c6a651
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/platform/acenvex.h  |    3 +++
 include/acpi/platform/acmsvcex.h |   54 ++++++++++++++++++++++++++++++++++++++
 include/acpi/platform/acwinex.h  |   49 ++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 include/acpi/platform/acmsvcex.h
 create mode 100644 include/acpi/platform/acwinex.h

diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
index 0a7dc8e..2f296cb 100644
--- a/include/acpi/platform/acenvex.h
+++ b/include/acpi/platform/acenvex.h
@@ -56,6 +56,9 @@
 #if defined(_LINUX) || defined(__linux__)
 #include <acpi/platform/aclinuxex.h>
 
+#elif defined(WIN32)
+#include "acwinex.h"
+
 #elif defined(_AED_EFI)
 #include "acefiex.h"
 
diff --git a/include/acpi/platform/acmsvcex.h b/include/acpi/platform/acmsvcex.h
new file mode 100644
index 0000000..b647974
--- /dev/null
+++ b/include/acpi/platform/acmsvcex.h
@@ -0,0 +1,54 @@
+/******************************************************************************
+ *
+ * Name: acmsvcex.h - Extra VC specific defines, etc.
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2015, Intel Corp.
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
+#ifndef __ACMSVCEX_H__
+#define __ACMSVCEX_H__
+
+/* Debug support. */
+
+#ifdef _DEBUG
+#define _CRTDBG_MAP_ALLOC	/* Enables specific file/lineno for leaks */
+#include <crtdbg.h>
+#endif
+
+#endif				/* __ACMSVCEX_H__ */
diff --git a/include/acpi/platform/acwinex.h b/include/acpi/platform/acwinex.h
new file mode 100644
index 0000000..6ed1d71
--- /dev/null
+++ b/include/acpi/platform/acwinex.h
@@ -0,0 +1,49 @@
+/******************************************************************************
+ *
+ * Name: acwinex.h - Extra OS specific defines, etc.
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2015, Intel Corp.
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
+#ifndef __ACWINEX_H__
+#define __ACWINEX_H__
+
+/* Windows uses VC */
+
+#endif				/* __ACWINEX_H__ */
-- 
1.7.10

