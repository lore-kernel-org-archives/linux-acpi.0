From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/73] ACPICA: Removed obsolete ACPI_NO_INTEGER64_SUPPORT define
Date: Sat, 12 Apr 2008 00:24:52 -0400
Message-ID: <8218fa3a279fcaf7802d17ff1f16d6c0a8f74746.1207973799.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:36418 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752688AbYDLE2E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:04 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acmacros.h |   12 +-----------
 include/acpi/actypes.h  |   23 +++--------------------
 2 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/include/acpi/acmacros.h b/include/acpi/acmacros.h
index 99d171c..401228d 100644
--- a/include/acpi/acmacros.h
+++ b/include/acpi/acmacros.h
@@ -61,21 +61,11 @@
 
 #define ACPI_ARRAY_LENGTH(x)            (sizeof(x) / sizeof((x)[0]))
 
-#ifdef ACPI_NO_INTEGER64_SUPPORT
 /*
- * acpi_integer is 32-bits, no 64-bit support on this platform
- */
-#define ACPI_LODWORD(l)                 ((u32)(l))
-#define ACPI_HIDWORD(l)                 ((u32)(0))
-
-#else
-
-/*
- * Full 64-bit address/integer on both 32-bit and 64-bit platforms
+ * Full 64-bit integer must be available on both 32-bit and 64-bit platforms
  */
 #define ACPI_LODWORD(l)                 ((u32)(u64)(l))
 #define ACPI_HIDWORD(l)                 ((u32)(((*(struct uint64_struct *)(void *)(&l))).hi))
-#endif
 
 /*
  * printf() format helpers
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index e73a389..6182b57 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -323,27 +323,11 @@ struct uint32_struct {
 #define acpi_semaphore                  void *
 
 /*
- * Acpi integer width. In ACPI version 1, integers are
- * 32 bits.  In ACPI version 2, integers are 64 bits.
- * Note that this pertains to the ACPI integer type only, not
- * other integers used in the implementation of the ACPI CA
+ * Acpi integer width. In ACPI version 1, integers are 32 bits.  In ACPI
+ * version 2, integers are 64 bits. Note that this pertains to the ACPI integer
+ * type only, not other integers used in the implementation of the ACPI CA
  * subsystem.
  */
-#ifdef ACPI_NO_INTEGER64_SUPPORT
-
-/* 32-bit integers only, no 64-bit support */
-
-typedef u32 acpi_integer;
-#define ACPI_INTEGER_MAX                ACPI_UINT32_MAX
-#define ACPI_INTEGER_BIT_SIZE           32
-#define ACPI_MAX_DECIMAL_DIGITS         10	/* 2^32 = 4,294,967,296 */
-
-#define ACPI_USE_NATIVE_DIVIDE	/* Use compiler native 32-bit divide */
-
-#else
-
-/* 64-bit integers */
-
 typedef unsigned long long acpi_integer;
 #define ACPI_INTEGER_MAX                ACPI_UINT64_MAX
 #define ACPI_INTEGER_BIT_SIZE           64
@@ -352,7 +336,6 @@ typedef unsigned long long acpi_integer;
 #if ACPI_MACHINE_WIDTH == 64
 #define ACPI_USE_NATIVE_DIVIDE	/* Use compiler native 64-bit divide */
 #endif
-#endif
 
 #define ACPI_MAX64_DECIMAL_DIGITS       20
 #define ACPI_MAX32_DECIMAL_DIGITS       10
-- 
1.5.5.29.g7134

