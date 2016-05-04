From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/15] ACPICA: Executer: Introduce a set of macros to handle bit width mask generation
Date: Wed,  4 May 2016 13:49:17 +0800
Message-ID: <14e4851152211c08d51f19709f9c1addcff41d0d.1462331121.git.lv.zheng@intel.com>
References: <cover.1462331120.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462331120.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit c23034a3a09d5ed79f1827d51f43cfbccf68ab64

A regression was reported to the shift offset >= width of type.
This patch fixes this issue. BZ 1270.
This is a part of the fix because the order of the patches are modified for
Linux upstream, containing the cleanups for the old code. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/c23034a3
Link: https://bugs.acpica.org/show_bug.cgi?id=1270
Reported-by: Sascha Wildner <swildner@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acmacros.h |   12 ++++++++++++
 drivers/acpi/acpica/exfldio.c  |   12 ++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index ecbaaba..a3b9543 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -270,9 +270,21 @@
  * Bit positions start at zero.
  * MASK_BITS_ABOVE creates a mask starting AT the position and above
  * MASK_BITS_BELOW creates a mask starting one bit BELOW the position
+ * MASK_BITS_ABOVE/BELOW accpets a bit offset to create a mask
+ * MASK_BITS_ABOVE/BELOW_32/64 accpets a bit width to create a mask
+ * Note: The ACPI_INTEGER_BIT_SIZE check is used to bypass compiler
+ * differences with the shift operator
  */
 #define ACPI_MASK_BITS_ABOVE(position)      (~((ACPI_UINT64_MAX) << ((u32) (position))))
 #define ACPI_MASK_BITS_BELOW(position)      ((ACPI_UINT64_MAX) << ((u32) (position)))
+#define ACPI_MASK_BITS_ABOVE_32(width)      ((u32) ACPI_MASK_BITS_ABOVE(width))
+#define ACPI_MASK_BITS_BELOW_32(width)      ((u32) ACPI_MASK_BITS_BELOW(width))
+#define ACPI_MASK_BITS_ABOVE_64(width)      ((width) == ACPI_INTEGER_BIT_SIZE ? \
+												ACPI_UINT64_MAX : \
+												ACPI_MASK_BITS_ABOVE(width))
+#define ACPI_MASK_BITS_BELOW_64(width)      ((width) == ACPI_INTEGER_BIT_SIZE ? \
+												(u64) 0 : \
+												ACPI_MASK_BITS_BELOW(width))
 
 /* Bitfields within ACPI registers */
 
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 72f9176..ee76d29 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -897,17 +897,9 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 
 	access_bit_width = ACPI_MUL_8(obj_desc->common_field.access_byte_width);
 
-	/*
-	 * Create the bitmasks used for bit insertion.
-	 * Note: This if/else is used to bypass compiler differences with the
-	 * shift operator
-	 */
-	if (access_bit_width == ACPI_INTEGER_BIT_SIZE) {
-		width_mask = ACPI_UINT64_MAX;
-	} else {
-		width_mask = ACPI_MASK_BITS_ABOVE(access_bit_width);
-	}
+	/* Create the bitmasks used for bit insertion */
 
+	width_mask = ACPI_MASK_BITS_ABOVE_64(access_bit_width);
 	mask = width_mask &
 	    ACPI_MASK_BITS_BELOW(obj_desc->common_field.start_field_bit_offset);
 
-- 
1.7.10
