From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/16] ACPICA: Split buffer dump routines into separate file
Date: Sat,  8 Jun 2013 08:57:47 +0800
Message-ID: <cf0a4a2644066d05799e6fb76b0fa08037e21066.1369274559.git.lv.zheng@intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18587 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755647Ab3FHA6M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jun 2013 20:58:12 -0400
In-Reply-To: <cover.1369274558.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

To enhance configurability of ACPICA.  New file is
utilities/utbuffer.c

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/Makefile   |    1 +
 drivers/acpi/acpica/utbuffer.c |  201 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/utdebug.c  |  148 +----------------------------
 3 files changed, 203 insertions(+), 147 deletions(-)
 create mode 100644 drivers/acpi/acpica/utbuffer.c

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 29b3dab..474901e 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -146,6 +146,7 @@ acpi-y +=		\
 acpi-y +=		\
 	utaddress.o	\
 	utalloc.o	\
+	utbuffer.o	\
 	utcopy.o	\
 	utexcep.o	\
 	utdebug.o	\
diff --git a/drivers/acpi/acpica/utbuffer.c b/drivers/acpi/acpica/utbuffer.c
new file mode 100644
index 0000000..11fde93
--- /dev/null
+++ b/drivers/acpi/acpica/utbuffer.c
@@ -0,0 +1,201 @@
+/******************************************************************************
+ *
+ * Module Name: utbuffer - Buffer dump routines
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2013, Intel Corp.
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
+#include <acpi/acpi.h>
+#include "accommon.h"
+
+#define _COMPONENT          ACPI_UTILITIES
+ACPI_MODULE_NAME("utbuffer")
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_dump_buffer
+ *
+ * PARAMETERS:  buffer              - Buffer to dump
+ *              count               - Amount to dump, in bytes
+ *              display             - BYTE, WORD, DWORD, or QWORD display:
+ *                                      DB_BYTE_DISPLAY
+ *                                      DB_WORD_DISPLAY
+ *                                      DB_DWORD_DISPLAY
+ *                                      DB_QWORD_DISPLAY
+ *              base_offset         - Beginning buffer offset (display only)
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Generic dump buffer in both hex and ascii.
+ *
+ ******************************************************************************/
+void acpi_ut_dump_buffer(u8 *buffer, u32 count, u32 display, u32 base_offset)
+{
+	u32 i = 0;
+	u32 j;
+	u32 temp32;
+	u8 buf_char;
+
+	if (!buffer) {
+		acpi_os_printf("Null Buffer Pointer in DumpBuffer!\n");
+		return;
+	}
+
+	if ((count < 4) || (count & 0x01)) {
+		display = DB_BYTE_DISPLAY;
+	}
+
+	/* Nasty little dump buffer routine! */
+
+	while (i < count) {
+
+		/* Print current offset */
+
+		acpi_os_printf("%6.4X: ", (base_offset + i));
+
+		/* Print 16 hex chars */
+
+		for (j = 0; j < 16;) {
+			if (i + j >= count) {
+
+				/* Dump fill spaces */
+
+				acpi_os_printf("%*s", ((display * 2) + 1), " ");
+				j += display;
+				continue;
+			}
+
+			switch (display) {
+			case DB_BYTE_DISPLAY:
+			default:	/* Default is BYTE display */
+
+				acpi_os_printf("%02X ",
+					       buffer[(acpi_size) i + j]);
+				break;
+
+			case DB_WORD_DISPLAY:
+
+				ACPI_MOVE_16_TO_32(&temp32,
+						   &buffer[(acpi_size) i + j]);
+				acpi_os_printf("%04X ", temp32);
+				break;
+
+			case DB_DWORD_DISPLAY:
+
+				ACPI_MOVE_32_TO_32(&temp32,
+						   &buffer[(acpi_size) i + j]);
+				acpi_os_printf("%08X ", temp32);
+				break;
+
+			case DB_QWORD_DISPLAY:
+
+				ACPI_MOVE_32_TO_32(&temp32,
+						   &buffer[(acpi_size) i + j]);
+				acpi_os_printf("%08X", temp32);
+
+				ACPI_MOVE_32_TO_32(&temp32,
+						   &buffer[(acpi_size) i + j +
+							   4]);
+				acpi_os_printf("%08X ", temp32);
+				break;
+			}
+
+			j += display;
+		}
+
+		/*
+		 * Print the ASCII equivalent characters but watch out for the bad
+		 * unprintable ones (printable chars are 0x20 through 0x7E)
+		 */
+		acpi_os_printf(" ");
+		for (j = 0; j < 16; j++) {
+			if (i + j >= count) {
+				acpi_os_printf("\n");
+				return;
+			}
+
+			buf_char = buffer[(acpi_size) i + j];
+			if (ACPI_IS_PRINT(buf_char)) {
+				acpi_os_printf("%c", buf_char);
+			} else {
+				acpi_os_printf(".");
+			}
+		}
+
+		/* Done with that line. */
+
+		acpi_os_printf("\n");
+		i += 16;
+	}
+
+	return;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_debug_dump_buffer
+ *
+ * PARAMETERS:  buffer              - Buffer to dump
+ *              count               - Amount to dump, in bytes
+ *              display             - BYTE, WORD, DWORD, or QWORD display:
+ *                                      DB_BYTE_DISPLAY
+ *                                      DB_WORD_DISPLAY
+ *                                      DB_DWORD_DISPLAY
+ *                                      DB_QWORD_DISPLAY
+ *              component_ID        - Caller's component ID
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Generic dump buffer in both hex and ascii.
+ *
+ ******************************************************************************/
+
+void
+acpi_ut_debug_dump_buffer(u8 *buffer, u32 count, u32 display, u32 component_id)
+{
+
+	/* Only dump the buffer if tracing is enabled */
+
+	if (!((ACPI_LV_TABLES & acpi_dbg_level) &&
+	      (component_id & acpi_dbg_layer))) {
+		return;
+	}
+
+	acpi_ut_dump_buffer(buffer, count, display, 0);
+}
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index c57d9cc..5796e11 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -1,6 +1,6 @@
 /******************************************************************************
  *
- * Module Name: utdebug - Debug print routines
+ * Module Name: utdebug - Debug print/trace routines
  *
  *****************************************************************************/
 
@@ -543,149 +543,3 @@ acpi_ut_ptr_exit(u32 line_number,
 }
 
 #endif
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_dump_buffer
- *
- * PARAMETERS:  buffer              - Buffer to dump
- *              count               - Amount to dump, in bytes
- *              display             - BYTE, WORD, DWORD, or QWORD display
- *              offset              - Beginning buffer offset (display only)
- *
- * RETURN:      None
- *
- * DESCRIPTION: Generic dump buffer in both hex and ascii.
- *
- ******************************************************************************/
-
-void acpi_ut_dump_buffer(u8 *buffer, u32 count, u32 display, u32 base_offset)
-{
-	u32 i = 0;
-	u32 j;
-	u32 temp32;
-	u8 buf_char;
-
-	if (!buffer) {
-		acpi_os_printf("Null Buffer Pointer in DumpBuffer!\n");
-		return;
-	}
-
-	if ((count < 4) || (count & 0x01)) {
-		display = DB_BYTE_DISPLAY;
-	}
-
-	/* Nasty little dump buffer routine! */
-
-	while (i < count) {
-
-		/* Print current offset */
-
-		acpi_os_printf("%6.4X: ", (base_offset + i));
-
-		/* Print 16 hex chars */
-
-		for (j = 0; j < 16;) {
-			if (i + j >= count) {
-
-				/* Dump fill spaces */
-
-				acpi_os_printf("%*s", ((display * 2) + 1), " ");
-				j += display;
-				continue;
-			}
-
-			switch (display) {
-			case DB_BYTE_DISPLAY:
-			default:	/* Default is BYTE display */
-
-				acpi_os_printf("%02X ",
-					       buffer[(acpi_size) i + j]);
-				break;
-
-			case DB_WORD_DISPLAY:
-
-				ACPI_MOVE_16_TO_32(&temp32,
-						   &buffer[(acpi_size) i + j]);
-				acpi_os_printf("%04X ", temp32);
-				break;
-
-			case DB_DWORD_DISPLAY:
-
-				ACPI_MOVE_32_TO_32(&temp32,
-						   &buffer[(acpi_size) i + j]);
-				acpi_os_printf("%08X ", temp32);
-				break;
-
-			case DB_QWORD_DISPLAY:
-
-				ACPI_MOVE_32_TO_32(&temp32,
-						   &buffer[(acpi_size) i + j]);
-				acpi_os_printf("%08X", temp32);
-
-				ACPI_MOVE_32_TO_32(&temp32,
-						   &buffer[(acpi_size) i + j +
-							   4]);
-				acpi_os_printf("%08X ", temp32);
-				break;
-			}
-
-			j += display;
-		}
-
-		/*
-		 * Print the ASCII equivalent characters but watch out for the bad
-		 * unprintable ones (printable chars are 0x20 through 0x7E)
-		 */
-		acpi_os_printf(" ");
-		for (j = 0; j < 16; j++) {
-			if (i + j >= count) {
-				acpi_os_printf("\n");
-				return;
-			}
-
-			buf_char = buffer[(acpi_size) i + j];
-			if (ACPI_IS_PRINT(buf_char)) {
-				acpi_os_printf("%c", buf_char);
-			} else {
-				acpi_os_printf(".");
-			}
-		}
-
-		/* Done with that line. */
-
-		acpi_os_printf("\n");
-		i += 16;
-	}
-
-	return;
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_debug_dump_buffer
- *
- * PARAMETERS:  buffer              - Buffer to dump
- *              count               - Amount to dump, in bytes
- *              display             - BYTE, WORD, DWORD, or QWORD display
- *              component_ID        - Caller's component ID
- *
- * RETURN:      None
- *
- * DESCRIPTION: Generic dump buffer in both hex and ascii.
- *
- ******************************************************************************/
-
-void
-acpi_ut_debug_dump_buffer(u8 *buffer, u32 count, u32 display, u32 component_id)
-{
-
-	/* Only dump the buffer if tracing is enabled */
-
-	if (!((ACPI_LV_TABLES & acpi_dbg_level) &&
-	      (component_id & acpi_dbg_layer))) {
-		return;
-	}
-
-	acpi_ut_dump_buffer(buffer, count, display, 0);
-}
-- 
1.7.10

