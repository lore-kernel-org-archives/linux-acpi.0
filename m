From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/10] ACPICA: Improve support for 32/64 bit physical addresses in printf().
Date: Sat,  8 Feb 2014 09:42:01 +0800
Message-ID: <6dfcd39dc46448a6a5fd1ebbe87bcc7d5dca5c59.1390438466.git.lv.zheng@intel.com>
References: <cover.1390438466.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26500 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbaBHBmH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Feb 2014 20:42:07 -0500
In-Reply-To: <cover.1390438466.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

This change improves the support for physical addresses in printf
debug statements and other output on both 32-bit and 64-bit hosts.
It consistently outputs the appropriate number of bytes for each
host. The %p specifier is unsatisfactory since it does not emit
uniform output on all hosts/clib implementations (on some, leading
zeros are not supported, leading to difficult-to-read output).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acmacros.h |   14 +++++++++-----
 drivers/acpi/acpica/tbprint.c  |   20 ++++++++++++--------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 2a86c65..2546782 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -63,17 +63,21 @@
 #define ACPI_SET64(ptr, val)            (*ACPI_CAST64 (ptr) = (u64) (val))
 
 /*
- * printf() format helpers
+ * printf() format helpers. These macros are workarounds for the difficulties
+ * with emitting 64-bit integers and 64-bit pointers with the same code
+ * for both 32-bit and 64-bit hosts.
  */
-
-/* Split 64-bit integer into two 32-bit values. Use with %8.8X%8.8X */
-
 #define ACPI_FORMAT_UINT64(i)           ACPI_HIDWORD(i), ACPI_LODWORD(i)
 
 #if ACPI_MACHINE_WIDTH == 64
 #define ACPI_FORMAT_NATIVE_UINT(i)      ACPI_FORMAT_UINT64(i)
+#define ACPI_FORMAT_TO_UINT(i)          ACPI_FORMAT_UINT64(i)
+#define ACPI_PRINTF_UINT                 "0x%8.8X%8.8X"
+
 #else
-#define ACPI_FORMAT_NATIVE_UINT(i)      0, (i)
+#define ACPI_FORMAT_NATIVE_UINT(i)      0, (u32) (i)
+#define ACPI_FORMAT_TO_UINT(i)          (u32) (i)
+#define ACPI_PRINTF_UINT                 "0x%8.8X"
 #endif
 
 /*
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index 6866e76..05ded33 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -128,15 +128,17 @@ acpi_tb_print_table_header(acpi_physical_address address,
 	struct acpi_table_header local_header;
 
 	/*
-	 * The reason that the Address is cast to a void pointer is so that we
-	 * can use %p which will work properly on both 32-bit and 64-bit hosts.
+	 * The reason that we use ACPI_PRINTF_UINT and ACPI_FORMAT_TO_UINT is to
+	 * support both 32-bit and 64-bit hosts/addresses in a consistent manner.
+	 * The %p specifier does not emit uniform output on all hosts. On some,
+	 * leading zeros are not supported.
 	 */
 	if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_FACS)) {
 
 		/* FACS only has signature and length fields */
 
-		ACPI_INFO((AE_INFO, "%4.4s %p %06X",
-			   header->signature, ACPI_CAST_PTR(void, address),
+		ACPI_INFO((AE_INFO, "%-4.4s " ACPI_PRINTF_UINT " %06X",
+			   header->signature, ACPI_FORMAT_TO_UINT(address),
 			   header->length));
 	} else if (ACPI_VALIDATE_RSDP_SIG(header->signature)) {
 
@@ -147,8 +149,9 @@ acpi_tb_print_table_header(acpi_physical_address address,
 					  header)->oem_id, ACPI_OEM_ID_SIZE);
 		acpi_tb_fix_string(local_header.oem_id, ACPI_OEM_ID_SIZE);
 
-		ACPI_INFO((AE_INFO, "RSDP %p %06X (v%.2d %6.6s)",
-			   ACPI_CAST_PTR(void, address),
+		ACPI_INFO((AE_INFO,
+			   "RSDP " ACPI_PRINTF_UINT " %06X (v%.2d %-6.6s)",
+			   ACPI_FORMAT_TO_UINT(address),
 			   (ACPI_CAST_PTR(struct acpi_table_rsdp, header)->
 			    revision >
 			    0) ? ACPI_CAST_PTR(struct acpi_table_rsdp,
@@ -162,8 +165,9 @@ acpi_tb_print_table_header(acpi_physical_address address,
 		acpi_tb_cleanup_table_header(&local_header, header);
 
 		ACPI_INFO((AE_INFO,
-			   "%4.4s %p %06X (v%.2d %6.6s %8.8s %08X %4.4s %08X)",
-			   local_header.signature, ACPI_CAST_PTR(void, address),
+			   "%-4.4s " ACPI_PRINTF_UINT
+			   " %06X (v%.2d %-6.6s %-8.8s %08X %-4.4s %08X)",
+			   local_header.signature, ACPI_FORMAT_TO_UINT(address),
 			   local_header.length, local_header.revision,
 			   local_header.oem_id, local_header.oem_table_id,
 			   local_header.oem_revision,
-- 
1.7.10

