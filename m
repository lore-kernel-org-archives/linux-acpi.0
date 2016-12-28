From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/18] ACPICA: Macro header: Fix some typos in comments. No functional change
Date: Wed, 28 Dec 2016 15:28:43 +0800
Message-ID: <d5e7919224ec8b9b8e6613955a4a92cf088dfd46.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit efc97d1d209947d6990ec81a192c6b2589d3e368

Link: https://github.com/acpica/acpica/commit/efc97d1
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acmacros.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 6537cbd..31b61a0 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -46,7 +46,7 @@
 
 /*
  * Extract data using a pointer. Any more than a byte and we
- * get into potential aligment issues -- see the STORE macros below.
+ * get into potential alignment issues -- see the STORE macros below.
  * Use with care.
  */
 #define ACPI_CAST8(ptr)                 ACPI_CAST_PTR (u8, (ptr))
@@ -63,7 +63,7 @@
 #define ACPI_SET64(ptr, val)            (*ACPI_CAST64 (ptr) = (u64) (val))
 
 /*
- * printf() format helper. This macros is a workaround for the difficulties
+ * printf() format helper. This macro is a workaround for the difficulties
  * with emitting 64-bit integers and 64-bit pointers with the same code
  * for both 32-bit and 64-bit hosts.
  */
@@ -260,7 +260,7 @@
 
 #define ACPI_IS_MISALIGNED(value)           (((acpi_size) value) & (sizeof(acpi_size)-1))
 
-/* Generic (power-of-two) rounding */
+/* Generic bit manipulation */
 
 #ifndef ACPI_USE_NATIVE_BIT_FINDER
 
@@ -310,6 +310,8 @@
 
 #endif				/* ACPI_USE_NATIVE_BIT_FINDER */
 
+/* Generic (power-of-two) rounding */
+
 #define ACPI_ROUND_UP_POWER_OF_TWO_8(a)     ((u8) \
 											(((u16) 1) <<  ACPI_FIND_LAST_BIT_8  ((a)  - 1)))
 #define ACPI_ROUND_DOWN_POWER_OF_TWO_8(a)   ((u8) \
@@ -330,8 +332,8 @@
  * Bit positions start at zero.
  * MASK_BITS_ABOVE creates a mask starting AT the position and above
  * MASK_BITS_BELOW creates a mask starting one bit BELOW the position
- * MASK_BITS_ABOVE/BELOW accpets a bit offset to create a mask
- * MASK_BITS_ABOVE/BELOW_32/64 accpets a bit width to create a mask
+ * MASK_BITS_ABOVE/BELOW accepts a bit offset to create a mask
+ * MASK_BITS_ABOVE/BELOW_32/64 accepts a bit width to create a mask
  * Note: The ACPI_INTEGER_BIT_SIZE check is used to bypass compiler
  * differences with the shift operator
  */
@@ -449,7 +451,7 @@
  */
 #ifndef ACPI_NO_ERROR_MESSAGES
 /*
- * Error reporting. Callers module and line number are inserted by AE_INFO,
+ * Error reporting. The callers module and line number are inserted by AE_INFO,
  * the plist contains a set of parens to allow variable-length lists.
  * These macros are used for both the debug and non-debug versions of the code.
  */
-- 
2.7.4
