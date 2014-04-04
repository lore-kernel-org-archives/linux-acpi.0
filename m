From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 24/28] ACPICA: acpidump: Update new structures and add missing file.
Date: Fri,  4 Apr 2014 12:39:50 +0800
Message-ID: <be261bd5a50caae0364ec8715cd8c9c9f9c6758e.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22872 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbaDDEjx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:39:53 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch is the generation of a commit that updates release automation
with newly added structures and files that are referenced by the acpidump.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h    |    2 +-
 drivers/acpi/acpica/acutils.h     |    2 +-
 tools/power/acpi/common/cmfsize.c |  101 +++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 2 deletions(-)
 create mode 100644 tools/power/acpi/common/cmfsize.c

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 0cac564..1f60290 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -509,6 +509,6 @@ ACPI_INIT_GLOBAL(ACPI_FILE, acpi_gbl_debug_file, NULL);
  ****************************************************************************/
 
 extern const struct ah_predefined_name asl_predefined_info[];
-extern const AH_DEVICE_ID asl_device_ids[];
+extern const struct ah_device_id asl_device_ids[];
 
 #endif				/* __ACGLOBAL_H__ */
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 2cf8d2c..1e256c5 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -741,6 +741,6 @@ acpi_ut_method_error(const char *module_name,
  */
 const struct ah_predefined_name *acpi_ah_match_predefined_name(char *nameseg);
 
-const AH_DEVICE_ID *acpi_ah_match_hardware_id(char *hid);
+const struct ah_device_id *acpi_ah_match_hardware_id(char *hid);
 
 #endif				/* _ACUTILS_H */
diff --git a/tools/power/acpi/common/cmfsize.c b/tools/power/acpi/common/cmfsize.c
new file mode 100644
index 0000000..5140e5e
--- /dev/null
+++ b/tools/power/acpi/common/cmfsize.c
@@ -0,0 +1,101 @@
+/******************************************************************************
+ *
+ * Module Name: cfsize - Common get file size function
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
+#include "accommon.h"
+#include "acapps.h"
+#include <stdio.h>
+
+#define _COMPONENT          ACPI_TOOLS
+ACPI_MODULE_NAME("cmfsize")
+
+/*******************************************************************************
+ *
+ * FUNCTION:    cm_get_file_size
+ *
+ * PARAMETERS:  file                    - Open file descriptor
+ *
+ * RETURN:      File Size. On error, -1 (ACPI_UINT32_MAX)
+ *
+ * DESCRIPTION: Get the size of a file. Uses seek-to-EOF. File must be open.
+ *              Does not disturb the current file pointer. Uses perror for
+ *              error messages.
+ *
+ ******************************************************************************/
+u32 cm_get_file_size(FILE * file)
+{
+	long file_size;
+	long current_offset;
+
+	/* Save the current file pointer, seek to EOF to obtain file size */
+
+	current_offset = ftell(file);
+	if (current_offset < 0) {
+		goto offset_error;
+	}
+
+	if (fseek(file, 0, SEEK_END)) {
+		goto seek_error;
+	}
+
+	file_size = ftell(file);
+	if (file_size < 0) {
+		goto offset_error;
+	}
+
+	/* Restore original file pointer */
+
+	if (fseek(file, current_offset, SEEK_SET)) {
+		goto seek_error;
+	}
+
+	return ((u32)file_size);
+
+offset_error:
+	perror("Could not get file offset");
+	return (ACPI_UINT32_MAX);
+
+seek_error:
+	perror("Could not seek file");
+	return (ACPI_UINT32_MAX);
+}
-- 
1.7.10

