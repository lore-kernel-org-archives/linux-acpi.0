From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/30] ACPICA: Linuxize: Remove useless platform headers
Date: Thu, 24 Mar 2016 09:38:35 +0800
Message-ID: <7f537c5c2e33034974adcfaf96a86957c092528a.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Some platform headers are leaked to Linux during release cycle.
This patch removes them. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/acmsvcex.h |   54 --------------------------------------
 include/acpi/platform/acwinex.h  |   49 ----------------------------------
 2 files changed, 103 deletions(-)
 delete mode 100644 include/acpi/platform/acmsvcex.h
 delete mode 100644 include/acpi/platform/acwinex.h

diff --git a/include/acpi/platform/acmsvcex.h b/include/acpi/platform/acmsvcex.h
deleted file mode 100644
index 28084a1..0000000
--- a/include/acpi/platform/acmsvcex.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/******************************************************************************
- *
- * Name: acmsvcex.h - Extra VC specific defines, etc.
- *
- *****************************************************************************/
-
-/*
- * Copyright (C) 2000 - 2016, Intel Corp.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce at minimum a disclaimer
- *    substantially similar to the "NO WARRANTY" disclaimer below
- *    ("Disclaimer") and any redistribution must be conditioned upon
- *    including a substantially similar Disclaimer requirement for further
- *    binary redistribution.
- * 3. Neither the names of the above-listed copyright holders nor the names
- *    of any contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * Alternatively, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") version 2 as published by the Free
- * Software Foundation.
- *
- * NO WARRANTY
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
- * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
- * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGES.
- */
-
-#ifndef __ACMSVCEX_H__
-#define __ACMSVCEX_H__
-
-/* Debug support. */
-
-#ifdef _DEBUG
-#define _CRTDBG_MAP_ALLOC	/* Enables specific file/lineno for leaks */
-#include <crtdbg.h>
-#endif
-
-#endif				/* __ACMSVCEX_H__ */
diff --git a/include/acpi/platform/acwinex.h b/include/acpi/platform/acwinex.h
deleted file mode 100644
index a00b3e4..0000000
--- a/include/acpi/platform/acwinex.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/******************************************************************************
- *
- * Name: acwinex.h - Extra OS specific defines, etc.
- *
- *****************************************************************************/
-
-/*
- * Copyright (C) 2000 - 2016, Intel Corp.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce at minimum a disclaimer
- *    substantially similar to the "NO WARRANTY" disclaimer below
- *    ("Disclaimer") and any redistribution must be conditioned upon
- *    including a substantially similar Disclaimer requirement for further
- *    binary redistribution.
- * 3. Neither the names of the above-listed copyright holders nor the names
- *    of any contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * Alternatively, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") version 2 as published by the Free
- * Software Foundation.
- *
- * NO WARRANTY
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
- * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
- * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGES.
- */
-
-#ifndef __ACWINEX_H__
-#define __ACWINEX_H__
-
-/* Windows uses VC */
-
-#endif				/* __ACWINEX_H__ */
-- 
1.7.10
