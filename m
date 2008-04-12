From: Len Brown <lenb@kernel.org>
Subject: [PATCH 58/73] ACPICA: Fix for ACPI_HIDWORD macro
Date: Sat, 12 Apr 2008 00:25:41 -0400
Message-ID: <402603ed1c6cf81e8eeb960111214df5669f49e8.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:47253 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757401AbYDLE2Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:16 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a regression introduced in version 20071114. The ACPI_HIDWORD
macro was inadvertently changed to return a 16-bit value instead of
a 32-bit value, truncating the upper Dword of a 64-bit value. This
macro is only used to display debug output, so no incorrect
calculations were made.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acmacros.h |   69 ++++++++++++++++++++++++-----------------------
 1 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/include/acpi/acmacros.h b/include/acpi/acmacros.h
index dc6a037..1f0fdbf 100644
--- a/include/acpi/acmacros.h
+++ b/include/acpi/acmacros.h
@@ -62,30 +62,6 @@
 #define ACPI_ARRAY_LENGTH(x)            (sizeof(x) / sizeof((x)[0]))
 
 /*
- * Full 64-bit integer must be available on both 32-bit and 64-bit platforms
- */
-#define ACPI_LODWORD(l)                 ((u32)(u64)(l))
-#define ACPI_HIDWORD(l)                 ((u16)((((u64)(l)) >> 32) & 0xFFFFFFFF))
-
-#if 0
-#define ACPI_HIDWORD(l)                 ((u32)(((*(struct uint64_struct *)(void *)(&l))).hi))
-#endif
-
-/*
- * printf() format helpers
- */
-
-/* Split 64-bit integer into two 32-bit values. Use with %8.8_x%8.8_x */
-
-#define ACPI_FORMAT_UINT64(i)           ACPI_HIDWORD(i),ACPI_LODWORD(i)
-
-#if ACPI_MACHINE_WIDTH == 64
-#define ACPI_FORMAT_NATIVE_UINT(i)      ACPI_FORMAT_UINT64(i)
-#else
-#define ACPI_FORMAT_NATIVE_UINT(i)      0, (i)
-#endif
-
-/*
  * Extract data using a pointer.  Any more than a byte and we
  * get into potential aligment issues -- see the STORE macros below.
  * Use with care.
@@ -122,6 +98,31 @@
 #endif
 
 /*
+ * Full 64-bit integer must be available on both 32-bit and 64-bit platforms
+ */
+struct acpi_integer_overlay {
+	u32 lo_dword;
+	u32 hi_dword;
+};
+
+#define ACPI_LODWORD(integer)           (ACPI_CAST_PTR (struct acpi_integer_overlay, &integer)->lo_dword)
+#define ACPI_HIDWORD(integer)           (ACPI_CAST_PTR (struct acpi_integer_overlay, &integer)->hi_dword)
+
+/*
+ * printf() format helpers
+ */
+
+/* Split 64-bit integer into two 32-bit values. Use with %8.8_x%8.8_x */
+
+#define ACPI_FORMAT_UINT64(i)           ACPI_HIDWORD(i),ACPI_LODWORD(i)
+
+#if ACPI_MACHINE_WIDTH == 64
+#define ACPI_FORMAT_NATIVE_UINT(i)      ACPI_FORMAT_UINT64(i)
+#else
+#define ACPI_FORMAT_NATIVE_UINT(i)      0, (i)
+#endif
+
+/*
  * Macros for moving data around to/from buffers that are possibly unaligned.
  * If the hardware supports the transfer of unaligned data, just do the store.
  * Otherwise, we have to move one byte at a time.
@@ -137,29 +138,29 @@
 
 /* These macros reverse the bytes during the move, converting little-endian to big endian */
 
-	 /* Big Endian      <==        Little Endian */
-	 /*  Hi...Lo                     Lo...Hi     */
+			  /* Big Endian      <==        Little Endian */
+			  /*  Hi...Lo                     Lo...Hi     */
 /* 16-bit source, 16/32/64 destination */
 
 #define ACPI_MOVE_16_TO_16(d,s)         {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[1];\
-			  ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[0];}
+					   ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[0];}
 
 #define ACPI_MOVE_16_TO_32(d,s)         {(*(u32 *)(void *)(d))=0;\
-					  ((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
-					  ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0];}
+							   ((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
+							   ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0];}
 
 #define ACPI_MOVE_16_TO_64(d,s)         {(*(u64 *)(void *)(d))=0;\
-							   ((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1];\
-							   ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0];}
+									 ((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1];\
+									 ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0];}
 
 /* 32-bit source, 16/32/64 destination */
 
 #define ACPI_MOVE_32_TO_16(d,s)         ACPI_MOVE_16_TO_16(d,s)	/* Truncate to 16 */
 
 #define ACPI_MOVE_32_TO_32(d,s)         {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[3];\
-									  ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[2];\
-									  ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
-									  ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0];}
+										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[2];\
+										 ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
+										 ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0];}
 
 #define ACPI_MOVE_32_TO_64(d,s)         {(*(u64 *)(void *)(d))=0;\
 										   ((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[3];\
-- 
1.5.5.29.g7134

