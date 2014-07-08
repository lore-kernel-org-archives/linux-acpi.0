From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/25] ACPICA: Common: Enhance cm_get_file_size() to improve portability.
Date: Tue,  8 Jul 2014 10:07:19 +0800
Message-ID: <fe7fba54a6d27178700b48bd4f652d4db15b26a4.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50515 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752721AbaGHCHX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:07:23 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch uses abstract file IO and acpi_log_error() APIs to enhance
cm_get_file_size() so that applications that invoke this API could have
portability improved.

With actual references added to abstract file IO and acpi_log_error(), the
applications need to link oslibcfs.o, utdebug.o, utexcep.o, utmath.o,
utprint.o and utxferror.o.
It is also required to add acpi_os_initialize() invocations if an
application starts to use acpi_log_error().
acpidump has already invoked acpi_os_initialize() in this way.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acapps.h      |    2 +-
 tools/power/acpi/Makefile         |    3 +++
 tools/power/acpi/common/cmfsize.c |   20 +++++++++++---------
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index 5bf41f8..3d2c882 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -105,7 +105,7 @@ extern char *acpi_gbl_optarg;
 /*
  * cmfsize - Common get file size function
  */
-u32 cm_get_file_size(FILE * file);
+u32 cm_get_file_size(ACPI_FILE file);
 
 #ifndef ACPI_DUMP_APP
 /*
diff --git a/tools/power/acpi/Makefile b/tools/power/acpi/Makefile
index f88a251..3d1537b 100644
--- a/tools/power/acpi/Makefile
+++ b/tools/power/acpi/Makefile
@@ -112,11 +112,14 @@ DUMP_OBJS = \
 	tbprint.o\
 	tbxfroot.o\
 	utbuffer.o\
+	utdebug.o\
 	utexcep.o\
 	utglobal.o\
 	utmath.o\
+	utprint.o\
 	utstring.o\
 	utxferror.o\
+	oslibcfs.o\
 	oslinuxtbl.o\
 	cmfsize.o\
 	getopt.o
diff --git a/tools/power/acpi/common/cmfsize.c b/tools/power/acpi/common/cmfsize.c
index 5140e5e..f4b9533 100644
--- a/tools/power/acpi/common/cmfsize.c
+++ b/tools/power/acpi/common/cmfsize.c
@@ -58,44 +58,46 @@ ACPI_MODULE_NAME("cmfsize")
  * RETURN:      File Size. On error, -1 (ACPI_UINT32_MAX)
  *
  * DESCRIPTION: Get the size of a file. Uses seek-to-EOF. File must be open.
- *              Does not disturb the current file pointer. Uses perror for
- *              error messages.
+ *              Does not disturb the current file pointer.
  *
  ******************************************************************************/
-u32 cm_get_file_size(FILE * file)
+u32 cm_get_file_size(ACPI_FILE file)
 {
 	long file_size;
 	long current_offset;
+	acpi_status status;
 
 	/* Save the current file pointer, seek to EOF to obtain file size */
 
-	current_offset = ftell(file);
+	current_offset = acpi_os_get_file_offset(file);
 	if (current_offset < 0) {
 		goto offset_error;
 	}
 
-	if (fseek(file, 0, SEEK_END)) {
+	status = acpi_os_set_file_offset(file, 0, ACPI_FILE_END);
+	if (ACPI_FAILURE(status)) {
 		goto seek_error;
 	}
 
-	file_size = ftell(file);
+	file_size = acpi_os_get_file_offset(file);
 	if (file_size < 0) {
 		goto offset_error;
 	}
 
 	/* Restore original file pointer */
 
-	if (fseek(file, current_offset, SEEK_SET)) {
+	status = acpi_os_set_file_offset(file, current_offset, ACPI_FILE_BEGIN);
+	if (ACPI_FAILURE(status)) {
 		goto seek_error;
 	}
 
 	return ((u32)file_size);
 
 offset_error:
-	perror("Could not get file offset");
+	acpi_log_error("Could not get file offset");
 	return (ACPI_UINT32_MAX);
 
 seek_error:
-	perror("Could not seek file");
+	acpi_log_error("Could not set file offset");
 	return (ACPI_UINT32_MAX);
 }
-- 
1.7.10

