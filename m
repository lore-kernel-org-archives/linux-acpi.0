From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/25] ACPICA: acpidump: Add memory/string OSL usage to improve portability.
Date: Tue,  8 Jul 2014 10:07:33 +0800
Message-ID: <19f0ed5cda5a0b5ebcf31cb7af5a76f08548443b.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10871 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752721AbaGHCHi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:07:38 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch adds code to use generic OSL for acpidump to improve the
portability of this tool. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/platform/acenv.h             |    1 +
 tools/power/acpi/tools/acpidump/apdump.c  |   16 ++++++++--------
 tools/power/acpi/tools/acpidump/apfiles.c |   11 ++++++-----
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 4390ebd..5f8cc1f 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -126,6 +126,7 @@
 
 #ifdef ACPI_DUMP_APP
 #define ACPI_USE_NATIVE_MEMORY_MAPPING
+#define USE_NATIVE_ALLOCATE_ZEROED
 #endif
 
 /* acpi_names/Example configuration. Hardware disabled */
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index e8729aa..ccb6262 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -252,7 +252,7 @@ int ap_dump_all_tables(void)
 		}
 
 		table_status = ap_dump_table_buffer(table, instance, address);
-		free(table);
+		ACPI_FREE(table);
 
 		if (table_status) {
 			break;
@@ -303,7 +303,7 @@ int ap_dump_table_by_address(char *ascii_address)
 	}
 
 	table_status = ap_dump_table_buffer(table, 0, address);
-	free(table);
+	ACPI_FREE(table);
 	return (table_status);
 }
 
@@ -329,7 +329,7 @@ int ap_dump_table_by_name(char *signature)
 	acpi_status status;
 	int table_status;
 
-	if (strlen(signature) != ACPI_NAME_SIZE) {
+	if (ACPI_STRLEN(signature) != ACPI_NAME_SIZE) {
 		fprintf(stderr,
 			"Invalid table signature [%s]: must be exactly 4 characters\n",
 			signature);
@@ -338,15 +338,15 @@ int ap_dump_table_by_name(char *signature)
 
 	/* Table signatures are expected to be uppercase */
 
-	strcpy(local_signature, signature);
+	ACPI_STRCPY(local_signature, signature);
 	acpi_ut_strupr(local_signature);
 
 	/* To be friendly, handle tables whose signatures do not match the name */
 
 	if (ACPI_COMPARE_NAME(local_signature, "FADT")) {
-		strcpy(local_signature, ACPI_SIG_FADT);
+		ACPI_STRCPY(local_signature, ACPI_SIG_FADT);
 	} else if (ACPI_COMPARE_NAME(local_signature, "MADT")) {
-		strcpy(local_signature, ACPI_SIG_MADT);
+		ACPI_STRCPY(local_signature, ACPI_SIG_MADT);
 	}
 
 	/* Dump all instances of this signature (to handle multiple SSDTs) */
@@ -369,7 +369,7 @@ int ap_dump_table_by_name(char *signature)
 		}
 
 		table_status = ap_dump_table_buffer(table, instance, address);
-		free(table);
+		ACPI_FREE(table);
 
 		if (table_status) {
 			break;
@@ -424,6 +424,6 @@ int ap_dump_table_from_file(char *pathname)
 	table_status = ap_dump_table_buffer(table, 0, 0);
 
 exit:
-	free(table);
+	ACPI_FREE(table);
 	return (table_status);
 }
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 4488acc..1d12b9d 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -130,11 +130,12 @@ int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 	/* Handle multiple SSDts - create different filenames for each */
 
 	if (instance > 0) {
-		sprintf(instance_str, "%u", instance);
-		strcat(filename, instance_str);
+		acpi_ut_snprintf(instance_str, sizeof(instance_str), "%u",
+				 instance);
+		ACPI_STRCAT(filename, instance_str);
 	}
 
-	strcat(filename, ACPI_TABLE_FILE_SUFFIX);
+	ACPI_STRCAT(filename, ACPI_TABLE_FILE_SUFFIX);
 
 	if (gbl_verbose_mode) {
 		fprintf(stderr,
@@ -202,7 +203,7 @@ struct acpi_table_header *ap_get_table_from_file(char *pathname,
 
 	/* Allocate a buffer for the entire file */
 
-	buffer = calloc(1, file_size);
+	buffer = ACPI_ALLOCATE_ZEROED(file_size);
 	if (!buffer) {
 		fprintf(stderr,
 			"Could not allocate file buffer of size: %u\n",
@@ -215,7 +216,7 @@ struct acpi_table_header *ap_get_table_from_file(char *pathname,
 	actual = fread(buffer, 1, file_size, file);
 	if (actual != file_size) {
 		fprintf(stderr, "Could not read input file: %s\n", pathname);
-		free(buffer);
+		ACPI_FREE(buffer);
 		buffer = NULL;
 		goto cleanup;
 	}
-- 
1.7.10

