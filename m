From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/25] ACPICA: OSL: Add portable file IO to improve portability.
Date: Tue,  8 Jul 2014 10:06:53 +0800
Message-ID: <77a84c00ab68d39da6f3b32ba55d934c17464834.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10820 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670AbaGHCHH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:07:07 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch adds portable file IO to generic OSL to improve the portability
of the applications.

A portable application may use different file IO interfaces than the
standard C library ones. This patch thus introduces an abstract file IO
layer into the generic OSL.

Note that this patch does not introduce users of such interfaces, further
patches should introduce users one by one carefully with build tests
performed. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/acpiosxf.h                            |   31 +++
 include/acpi/actypes.h                             |    9 +
 .../acpi/os_specific/service_layers/oslibcfs.c     |  214 ++++++++++++++++++++
 3 files changed, 254 insertions(+)
 create mode 100644 tools/power/acpi/os_specific/service_layers/oslibcfs.c

diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index f6f5f8a..03b3e6d 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -399,4 +399,35 @@ char *acpi_os_get_next_filename(void *dir_handle);
 void acpi_os_close_directory(void *dir_handle);
 #endif
 
+/*
+ * File I/O and related support
+ */
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_open_file
+ACPI_FILE acpi_os_open_file(const char *path, u8 modes);
+#endif
+
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_close_file
+void acpi_os_close_file(ACPI_FILE file);
+#endif
+
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_read_file
+int
+acpi_os_read_file(ACPI_FILE file,
+		  void *buffer, acpi_size size, acpi_size count);
+#endif
+
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_write_file
+int
+acpi_os_write_file(ACPI_FILE file,
+		   void *buffer, acpi_size size, acpi_size count);
+#endif
+
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_file_offset
+long acpi_os_get_file_offset(ACPI_FILE file);
+#endif
+
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_set_file_offset
+acpi_status acpi_os_set_file_offset(ACPI_FILE file, long offset, u8 from);
+#endif
+
 #endif				/* __ACPIOSXF_H__ */
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 19b26bb..5480209 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1244,4 +1244,13 @@ struct acpi_memory_list {
 #define ACPI_OSI_WIN_7                  0x0B
 #define ACPI_OSI_WIN_8                  0x0C
 
+/* Definitions of file IO */
+
+#define ACPI_FILE_READING               0x01
+#define ACPI_FILE_WRITING               0x02
+#define ACPI_FILE_BINARY                0x04
+
+#define ACPI_FILE_BEGIN                 0x01
+#define ACPI_FILE_END                   0x02
+
 #endif				/* __ACTYPES_H__ */
diff --git a/tools/power/acpi/os_specific/service_layers/oslibcfs.c b/tools/power/acpi/os_specific/service_layers/oslibcfs.c
new file mode 100644
index 0000000..2da0ce8
--- /dev/null
+++ b/tools/power/acpi/os_specific/service_layers/oslibcfs.c
@@ -0,0 +1,214 @@
+/******************************************************************************
+ *
+ * Module Name: oslibcfs - C library OSL for file IO
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2014, Intel Corp.
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
+#include <stdio.h>
+#include <stdarg.h>
+
+#define _COMPONENT          ACPI_OS_SERVICES
+ACPI_MODULE_NAME("oslibcfs")
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_os_open_file
+ *
+ * PARAMETERS:  path                - File path
+ *              modes               - File operation type
+ *
+ * RETURN:      File descriptor.
+ *
+ * DESCRIPTION: Open a file for reading (ACPI_FILE_READING) or/and writing
+ *              (ACPI_FILE_WRITING).
+ *
+ ******************************************************************************/
+ACPI_FILE acpi_os_open_file(const char *path, u8 modes)
+{
+	ACPI_FILE file;
+	char modes_str[4];
+	u32 i = 0;
+
+	if (modes & ACPI_FILE_READING) {
+		modes_str[i++] = 'r';
+	}
+	if (modes & ACPI_FILE_WRITING) {
+		modes_str[i++] = 'w';
+	}
+	if (modes & ACPI_FILE_BINARY) {
+		modes_str[i++] = 'b';
+	}
+	modes_str[i++] = '\0';
+
+	file = fopen(path, modes_str);
+	if (!file) {
+		perror("Could not open file");
+	}
+
+	return (file);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_os_close_file
+ *
+ * PARAMETERS:  file                - File descriptor
+ *
+ * RETURN:      None.
+ *
+ * DESCRIPTION: Close a file.
+ *
+ ******************************************************************************/
+
+void acpi_os_close_file(ACPI_FILE file)
+{
+	fclose(file);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_os_read_file
+ *
+ * PARAMETERS:  file                - File descriptor
+ *              buffer              - Data buffer
+ *              size                - Data block size
+ *              count               - Number of data blocks
+ *
+ * RETURN:      Size of successfully read buffer.
+ *
+ * DESCRIPTION: Read a file.
+ *
+ ******************************************************************************/
+
+int
+acpi_os_read_file(ACPI_FILE file, void *buffer, acpi_size size, acpi_size count)
+{
+	int length;
+
+	length = fread(buffer, size, count, file);
+	if (length < 0) {
+		perror("Error reading file");
+	}
+
+	return (length);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_os_write_file
+ *
+ * PARAMETERS:  file                - File descriptor
+ *              buffer              - Data buffer
+ *              size                - Data block size
+ *              count               - Number of data blocks
+ *
+ * RETURN:      Size of successfully written buffer.
+ *
+ * DESCRIPTION: Write a file.
+ *
+ ******************************************************************************/
+
+int
+acpi_os_write_file(ACPI_FILE file,
+		   void *buffer, acpi_size size, acpi_size count)
+{
+	int length;
+
+	length = fwrite(buffer, size, count, file);
+	if (length < 0) {
+		perror("Error writing file");
+	}
+
+	return (length);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_os_get_file_offset
+ *
+ * PARAMETERS:  file                - File descriptor
+ *
+ * RETURN:      Size of current position.
+ *
+ * DESCRIPTION: Get current file offset.
+ *
+ ******************************************************************************/
+
+long acpi_os_get_file_offset(ACPI_FILE file)
+{
+	long offset;
+
+	offset = ftell(file);
+
+	return (offset);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_os_set_file_offset
+ *
+ * PARAMETERS:  file                - File descriptor
+ *              offset              - File offset
+ *              from                - From begin/end of file
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Set current file offset.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_os_set_file_offset(ACPI_FILE file, long offset, u8 from)
+{
+	int ret = 0;
+
+	if (from == ACPI_FILE_BEGIN) {
+		ret = fseek(file, offset, SEEK_SET);
+	}
+	if (from == ACPI_FILE_END) {
+		ret = fseek(file, offset, SEEK_END);
+	}
+
+	if (ret < 0) {
+		return (AE_ERROR);
+	} else {
+		return (AE_OK);
+	}
+}
-- 
1.7.10

