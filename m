From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/18] ACPICA: Utilities: Add power of two rounding support
Date: Wed, 28 Dec 2016 15:28:29 +0800
Message-ID: <6b44d21f490ab2b117ab1454f74c3b970e163786.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit cbb0294649cbd7e8bd6107e4329461a6a7a0d967

This patch adds power of two rounding support up to 32 bits.

The result of the shift operations rearching to the boundary of the cpu
word is unpredicatable, so 64-bit roundings are not supported in order to
make sure no rounded shift-overs.
This support may not be performance friendly, so the APIs might be
overridden by the hosts implementations with ACPI_USE_NATIVE_BIT_FINDER
defined. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/cbb02946
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acmacros.h | 60 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index a3b9543..6537cbd 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -262,6 +262,66 @@
 
 /* Generic (power-of-two) rounding */
 
+#ifndef ACPI_USE_NATIVE_BIT_FINDER
+
+#define __ACPI_FIND_LAST_BIT_2(a, r)        ((((u8)  (a)) & 0x02) ? (r)+1 : (r))
+#define __ACPI_FIND_LAST_BIT_4(a, r)        ((((u8)  (a)) & 0x0C) ? \
+											 __ACPI_FIND_LAST_BIT_2  ((a)>>2,  (r)+2) : \
+											 __ACPI_FIND_LAST_BIT_2  ((a), (r)))
+#define __ACPI_FIND_LAST_BIT_8(a, r)        ((((u8)  (a)) & 0xF0) ? \
+											 __ACPI_FIND_LAST_BIT_4  ((a)>>4,  (r)+4) : \
+											 __ACPI_FIND_LAST_BIT_4  ((a), (r)))
+#define __ACPI_FIND_LAST_BIT_16(a, r)       ((((u16) (a)) & 0xFF00) ? \
+											 __ACPI_FIND_LAST_BIT_8  ((a)>>8,  (r)+8) : \
+											 __ACPI_FIND_LAST_BIT_8  ((a), (r)))
+#define __ACPI_FIND_LAST_BIT_32(a, r)       ((((u32) (a)) & 0xFFFF0000) ? \
+											 __ACPI_FIND_LAST_BIT_16 ((a)>>16, (r)+16) : \
+											 __ACPI_FIND_LAST_BIT_16 ((a), (r)))
+#define __ACPI_FIND_LAST_BIT_64(a, r)       ((((u64) (a)) & 0xFFFFFFFF00000000) ? \
+											 __ACPI_FIND_LAST_BIT_32 ((a)>>32, (r)+32) : \
+											 __ACPI_FIND_LAST_BIT_32 ((a), (r)))
+
+#define ACPI_FIND_LAST_BIT_8(a)             ((a) ? __ACPI_FIND_LAST_BIT_8 (a, 1) : 0)
+#define ACPI_FIND_LAST_BIT_16(a)            ((a) ? __ACPI_FIND_LAST_BIT_16 (a, 1) : 0)
+#define ACPI_FIND_LAST_BIT_32(a)            ((a) ? __ACPI_FIND_LAST_BIT_32 (a, 1) : 0)
+#define ACPI_FIND_LAST_BIT_64(a)            ((a) ? __ACPI_FIND_LAST_BIT_64 (a, 1) : 0)
+
+#define __ACPI_FIND_FIRST_BIT_2(a, r)       ((((u8) (a)) & 0x01) ? (r) : (r)+1)
+#define __ACPI_FIND_FIRST_BIT_4(a, r)       ((((u8) (a)) & 0x03) ? \
+											 __ACPI_FIND_FIRST_BIT_2  ((a), (r)) : \
+											 __ACPI_FIND_FIRST_BIT_2  ((a)>>2, (r)+2))
+#define __ACPI_FIND_FIRST_BIT_8(a, r)       ((((u8) (a)) & 0x0F) ? \
+											 __ACPI_FIND_FIRST_BIT_4  ((a), (r)) : \
+											 __ACPI_FIND_FIRST_BIT_4  ((a)>>4, (r)+4))
+#define __ACPI_FIND_FIRST_BIT_16(a, r)      ((((u16) (a)) & 0x00FF) ? \
+											 __ACPI_FIND_FIRST_BIT_8  ((a), (r)) : \
+											 __ACPI_FIND_FIRST_BIT_8  ((a)>>8, (r)+8))
+#define __ACPI_FIND_FIRST_BIT_32(a, r)      ((((u32) (a)) & 0x0000FFFF) ? \
+											 __ACPI_FIND_FIRST_BIT_16 ((a), (r)) : \
+											 __ACPI_FIND_FIRST_BIT_16 ((a)>>16, (r)+16))
+#define __ACPI_FIND_FIRST_BIT_64(a, r)      ((((u64) (a)) & 0x00000000FFFFFFFF) ? \
+											 __ACPI_FIND_FIRST_BIT_32 ((a), (r)) : \
+											 __ACPI_FIND_FIRST_BIT_32 ((a)>>32, (r)+32))
+
+#define ACPI_FIND_FIRST_BIT_8(a)            ((a) ? __ACPI_FIND_FIRST_BIT_8 (a, 1) : 0)
+#define ACPI_FIND_FIRST_BIT_16(a)           ((a) ? __ACPI_FIND_FIRST_BIT_16 (a, 1) : 0)
+#define ACPI_FIND_FIRST_BIT_32(a)           ((a) ? __ACPI_FIND_FIRST_BIT_32 (a, 1) : 0)
+#define ACPI_FIND_FIRST_BIT_64(a)           ((a) ? __ACPI_FIND_FIRST_BIT_64 (a, 1) : 0)
+
+#endif				/* ACPI_USE_NATIVE_BIT_FINDER */
+
+#define ACPI_ROUND_UP_POWER_OF_TWO_8(a)     ((u8) \
+											(((u16) 1) <<  ACPI_FIND_LAST_BIT_8  ((a)  - 1)))
+#define ACPI_ROUND_DOWN_POWER_OF_TWO_8(a)   ((u8) \
+											(((u16) 1) << (ACPI_FIND_LAST_BIT_8  ((a)) - 1)))
+#define ACPI_ROUND_UP_POWER_OF_TWO_16(a)    ((u16) \
+											(((u32) 1) <<  ACPI_FIND_LAST_BIT_16 ((a)  - 1)))
+#define ACPI_ROUND_DOWN_POWER_OF_TWO_16(a)  ((u16) \
+											(((u32) 1) << (ACPI_FIND_LAST_BIT_16 ((a)) - 1)))
+#define ACPI_ROUND_UP_POWER_OF_TWO_32(a)    ((u32) \
+											(((u64) 1) <<  ACPI_FIND_LAST_BIT_32 ((a)  - 1)))
+#define ACPI_ROUND_DOWN_POWER_OF_TWO_32(a)  ((u32) \
+											(((u64) 1) << (ACPI_FIND_LAST_BIT_32 ((a)) - 1)))
 #define ACPI_IS_ALIGNED(a, s)               (((a) & ((s) - 1)) == 0)
 #define ACPI_IS_POWER_OF_TWO(a)             ACPI_IS_ALIGNED(a, a)
 
-- 
2.7.4
