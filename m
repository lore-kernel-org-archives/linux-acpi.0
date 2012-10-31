From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 18/26] ACPICA: Add ACPI_MOVE_NAME macro to optimize 4-byte ACPI_NAME copies
Date: Wed, 31 Oct 2012 10:27:40 +0800
Message-ID: <3215df2a2a7e0d1af082bf36af6cf6f9565a1420.1351649951.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30583 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324Ab2JaC1q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:27:46 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Resolves to a 32-bit move for the normal case, strncpy on machines
that do not support misaligned transfers.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actypes.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 1fa6ba1..d1fb674 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -453,10 +453,14 @@ typedef u64 acpi_integer;
 #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
 #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
 
+/* Optimizations for 4-character (32-bit) acpi_name manipulation */
+
 #ifndef ACPI_MISALIGNMENT_NOT_SUPPORTED
 #define ACPI_COMPARE_NAME(a,b)          (*ACPI_CAST_PTR (u32, (a)) == *ACPI_CAST_PTR (u32, (b)))
+#define ACPI_MOVE_NAME(dest,src)        (*ACPI_CAST_PTR (u32, (dest)) = *ACPI_CAST_PTR (u32, (src)))
 #else
 #define ACPI_COMPARE_NAME(a,b)          (!ACPI_STRNCMP (ACPI_CAST_PTR (char, (a)), ACPI_CAST_PTR (char, (b)), ACPI_NAME_SIZE))
+#define ACPI_MOVE_NAME(dest,src)        (ACPI_STRNCPY (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAME_SIZE))
 #endif
 
 /*******************************************************************************
-- 
1.7.10

