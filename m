From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 19/25] ACPICA: acpidump: Reduce freopen() invocations to improve portability.
Date: Tue,  8 Jul 2014 10:07:52 +0800
Message-ID: <712cc4729a8d7081f0fd31909068222d8943005f.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:60313 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369AbaGHCH4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:07:56 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch reduces the requirement of invoking freopen() in acpidump in order
to reduce the porting effort of acpidump.

This patch achieves this by turning all acpi_os_printf(stdout) into
acpi_ut_file_printf(gbl_output_file). Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acutils.h             |    7 ++
 drivers/acpi/acpica/utbuffer.c            |  128 +++++++++++++++++++++++++++++
 tools/power/acpi/tools/acpidump/apdump.c  |   11 +--
 tools/power/acpi/tools/acpidump/apfiles.c |    6 +-
 tools/power/acpi/tools/acpidump/apmain.c  |    3 +-
 5 files changed, 146 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 035dc29..ed614f4 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -353,6 +353,13 @@ acpi_ut_debug_dump_buffer(u8 *buffer, u32 count, u32 display, u32 component_id);
 
 void acpi_ut_dump_buffer(u8 *buffer, u32 count, u32 display, u32 offset);
 
+#ifdef ACPI_APPLICATION
+void
+acpi_ut_dump_buffer_to_file(ACPI_FILE file,
+			    u8 *buffer,
+			    u32 count, u32 display, u32 base_offset);
+#endif
+
 void acpi_ut_report_error(char *module_name, u32 line_number);
 
 void acpi_ut_report_info(char *module_name, u32 line_number);
diff --git a/drivers/acpi/acpica/utbuffer.c b/drivers/acpi/acpica/utbuffer.c
index 3c16997..038ea88 100644
--- a/drivers/acpi/acpica/utbuffer.c
+++ b/drivers/acpi/acpica/utbuffer.c
@@ -199,3 +199,131 @@ acpi_ut_debug_dump_buffer(u8 *buffer, u32 count, u32 display, u32 component_id)
 
 	acpi_ut_dump_buffer(buffer, count, display, 0);
 }
+
+#ifdef ACPI_APPLICATION
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_dump_buffer_to_file
+ *
+ * PARAMETERS:  file                - File descriptor
+ *              buffer              - Buffer to dump
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
+ * DESCRIPTION: Generic dump buffer in both hex and ascii to a file.
+ *
+ ******************************************************************************/
+
+void
+acpi_ut_dump_buffer_to_file(ACPI_FILE file,
+			    u8 *buffer, u32 count, u32 display, u32 base_offset)
+{
+	u32 i = 0;
+	u32 j;
+	u32 temp32;
+	u8 buf_char;
+
+	if (!buffer) {
+		acpi_ut_file_printf(file,
+				    "Null Buffer Pointer in DumpBuffer!\n");
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
+		acpi_ut_file_printf(file, "%6.4X: ", (base_offset + i));
+
+		/* Print 16 hex chars */
+
+		for (j = 0; j < 16;) {
+			if (i + j >= count) {
+
+				/* Dump fill spaces */
+
+				acpi_ut_file_printf(file, "%*s",
+						    ((display * 2) + 1), " ");
+				j += display;
+				continue;
+			}
+
+			switch (display) {
+			case DB_BYTE_DISPLAY:
+			default:	/* Default is BYTE display */
+
+				acpi_ut_file_printf(file, "%02X ",
+						    buffer[(acpi_size) i + j]);
+				break;
+
+			case DB_WORD_DISPLAY:
+
+				ACPI_MOVE_16_TO_32(&temp32,
+						   &buffer[(acpi_size) i + j]);
+				acpi_ut_file_printf(file, "%04X ", temp32);
+				break;
+
+			case DB_DWORD_DISPLAY:
+
+				ACPI_MOVE_32_TO_32(&temp32,
+						   &buffer[(acpi_size) i + j]);
+				acpi_ut_file_printf(file, "%08X ", temp32);
+				break;
+
+			case DB_QWORD_DISPLAY:
+
+				ACPI_MOVE_32_TO_32(&temp32,
+						   &buffer[(acpi_size) i + j]);
+				acpi_ut_file_printf(file, "%08X", temp32);
+
+				ACPI_MOVE_32_TO_32(&temp32,
+						   &buffer[(acpi_size) i + j +
+							   4]);
+				acpi_ut_file_printf(file, "%08X ", temp32);
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
+		acpi_ut_file_printf(file, " ");
+		for (j = 0; j < 16; j++) {
+			if (i + j >= count) {
+				acpi_ut_file_printf(file, "\n");
+				return;
+			}
+
+			buf_char = buffer[(acpi_size) i + j];
+			if (ACPI_IS_PRINT(buf_char)) {
+				acpi_ut_file_printf(file, "%c", buf_char);
+			} else {
+				acpi_ut_file_printf(file, ".");
+			}
+		}
+
+		/* Done with that line. */
+
+		acpi_ut_file_printf(file, "\n");
+		i += 16;
+	}
+
+	return;
+}
+#endif
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index 34fa5f2..53cee78 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -195,12 +195,13 @@ ap_dump_table_buffer(struct acpi_table_header *table,
 	 * Note: simplest to just always emit a 64-bit address. acpi_xtract
 	 * utility can handle this.
 	 */
-	acpi_os_printf("%4.4s @ 0x%8.8X%8.8X\n", table->signature,
-		       ACPI_FORMAT_UINT64(address));
+	acpi_ut_file_printf(gbl_output_file, "%4.4s @ 0x%8.8X%8.8X\n",
+			    table->signature, ACPI_FORMAT_UINT64(address));
 
-	acpi_ut_dump_buffer(ACPI_CAST_PTR(u8, table), table_length,
-			    DB_BYTE_DISPLAY, 0);
-	acpi_os_printf("\n");
+	acpi_ut_dump_buffer_to_file(gbl_output_file,
+				    ACPI_CAST_PTR(u8, table), table_length,
+				    DB_BYTE_DISPLAY, 0);
+	acpi_ut_file_printf(gbl_output_file, "\n");
 	return (0);
 }
 
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 5699ca1..5781c13 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -60,7 +60,7 @@
 int ap_open_output_file(char *pathname)
 {
 	struct stat stat_info;
-	FILE *file;
+	ACPI_FILE file;
 
 	/* If file exists, prompt for overwrite */
 
@@ -74,9 +74,9 @@ int ap_open_output_file(char *pathname)
 
 	/* Point stdout to the file */
 
-	file = freopen(pathname, "w", stdout);
+	file = acpi_os_open_file(pathname, ACPI_FILE_WRITING);
 	if (!file) {
-		perror("Could not open output file");
+		acpi_log_error("Could not open output file: %s\n", pathname);
 		return (-1);
 	}
 
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index 63f7bc9..35bd674 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -300,6 +300,7 @@ int ACPI_SYSTEM_XFACE main(int argc, char *argv[])
 
 	ACPI_DEBUG_INITIALIZE();	/* For debug version only */
 	acpi_os_initialize();
+	gbl_output_file = ACPI_FILE_OUT;
 
 	/* Process command line options */
 
@@ -348,7 +349,7 @@ int ACPI_SYSTEM_XFACE main(int argc, char *argv[])
 		}
 	}
 
-	if (gbl_output_file) {
+	if (gbl_output_filename) {
 		if (gbl_verbose_mode) {
 
 			/* Summary for the output file */
-- 
1.7.10

