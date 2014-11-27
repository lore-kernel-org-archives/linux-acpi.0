From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/6] ACPICA: iASL: Add support for to_PLD macro.
Date: Thu, 27 Nov 2014 14:26:00 +0800
Message-ID: <f773c3768a07c39310f54ec92ebda1d319823836.1416899966.git.lv.zheng@intel.com>
References: <cover.1416899966.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1416899966.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, "David E. Box" <david.e.box@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This macro is intended to simplify the constuction of _PLD buffers.
NOTE: Prototype only, subject to change before this macro is
added to the ACPI specification. David E. Box.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utxface.c |    4 +++-
 include/acpi/acbuffer.h       |   14 +++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 502a849..49c873c 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -531,7 +531,9 @@ acpi_decode_pld_buffer(u8 *in_buffer,
 	ACPI_MOVE_32_TO_32(&dword, &buffer[0]);
 	pld_info->revision = ACPI_PLD_GET_REVISION(&dword);
 	pld_info->ignore_color = ACPI_PLD_GET_IGNORE_COLOR(&dword);
-	pld_info->color = ACPI_PLD_GET_COLOR(&dword);
+	pld_info->red = ACPI_PLD_GET_RED(&dword);
+	pld_info->green = ACPI_PLD_GET_GREEN(&dword);
+	pld_info->blue = ACPI_PLD_GET_BLUE(&dword);
 
 	/* Second 32-bit DWord */
 
diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
index 88cb477..d5ec6c8 100644
--- a/include/acpi/acbuffer.h
+++ b/include/acpi/acbuffer.h
@@ -111,7 +111,9 @@ struct acpi_gtm_info {
 struct acpi_pld_info {
 	u8 revision;
 	u8 ignore_color;
-	u32 color;
+	u8 red;
+	u8 green;
+	u8 blue;
 	u16 width;
 	u16 height;
 	u8 user_visible;
@@ -155,8 +157,14 @@ struct acpi_pld_info {
 #define ACPI_PLD_GET_IGNORE_COLOR(dword)        ACPI_GET_BITS (dword, 7, ACPI_1BIT_MASK)
 #define ACPI_PLD_SET_IGNORE_COLOR(dword,value)  ACPI_SET_BITS (dword, 7, ACPI_1BIT_MASK, value)	/* Offset 7, Len 1 */
 
-#define ACPI_PLD_GET_COLOR(dword)               ACPI_GET_BITS (dword, 8, ACPI_24BIT_MASK)
-#define ACPI_PLD_SET_COLOR(dword,value)         ACPI_SET_BITS (dword, 8, ACPI_24BIT_MASK, value)	/* Offset 8, Len 24 */
+#define ACPI_PLD_GET_RED(dword)                 ACPI_GET_BITS (dword, 8, ACPI_8BIT_MASK)
+#define ACPI_PLD_SET_RED(dword,value)           ACPI_SET_BITS (dword, 8, ACPI_8BIT_MASK, value)	/* Offset 8, Len 8 */
+
+#define ACPI_PLD_GET_GREEN(dword)               ACPI_GET_BITS (dword, 16, ACPI_8BIT_MASK)
+#define ACPI_PLD_SET_GREEN(dword,value)         ACPI_SET_BITS (dword, 16, ACPI_8BIT_MASK, value)	/* Offset 16, Len 8 */
+
+#define ACPI_PLD_GET_BLUE(dword)                ACPI_GET_BITS (dword, 24, ACPI_8BIT_MASK)
+#define ACPI_PLD_SET_BLUE(dword,value)          ACPI_SET_BITS (dword, 24, ACPI_8BIT_MASK, value)	/* Offset 24, Len 8 */
 
 /* Second 32-bit dword, bits 33:63 */
 
-- 
1.7.10
