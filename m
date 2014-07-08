From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/25] ACPICA: Common: Enhance acpi_getopt() to improve portability.
Date: Tue,  8 Jul 2014 10:07:26 +0800
Message-ID: <12d60ddeeb83f59fb27ca977eb0c99e6fa01b4c6.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50528 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752721AbaGHCHb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:07:31 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch enhances acpi_getopt() by converting the standard C library
invocations into portable ACPI string APIs and acpi_log_error() to improve
portability. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acutils.h            |    2 ++
 include/acpi/actypes.h                   |    4 ++++
 tools/power/acpi/common/getopt.c         |   14 ++++++--------
 tools/power/acpi/tools/acpidump/apmain.c |    3 ++-
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 85871c6..035dc29 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -210,6 +210,8 @@ void acpi_ut_subsystem_shutdown(void);
 
 acpi_size acpi_ut_strlen(const char *string);
 
+char *acpi_ut_strchr(const char *string, int ch);
+
 char *acpi_ut_strcpy(char *dst_string, const char *src_string);
 
 char *acpi_ut_strncpy(char *dst_string,
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 165abca..608a040 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1254,4 +1254,8 @@ struct acpi_memory_list {
 #define ACPI_FILE_BEGIN                 0x01
 #define ACPI_FILE_END                   0x02
 
+/* Definitions of getopt */
+
+#define ACPI_OPT_END                    -1
+
 #endif				/* __ACTYPES_H__ */
diff --git a/tools/power/acpi/common/getopt.c b/tools/power/acpi/common/getopt.c
index a302f52..2f0f34a 100644
--- a/tools/power/acpi/common/getopt.c
+++ b/tools/power/acpi/common/getopt.c
@@ -51,14 +51,12 @@
  *    "f|"      - Option has required single-char sub-options
  */
 
-#include <stdio.h>
-#include <string.h>
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acapps.h"
 
 #define ACPI_OPTION_ERROR(msg, badchar) \
-	if (acpi_gbl_opterr) {fprintf (stderr, "%s%c\n", msg, badchar);}
+	if (acpi_gbl_opterr) {acpi_log_error ("%s%c\n", msg, badchar);}
 
 int acpi_gbl_opterr = 1;
 int acpi_gbl_optind = 1;
@@ -113,7 +111,7 @@ int acpi_getopt_argument(int argc, char **argv)
  * PARAMETERS:  argc, argv          - from main
  *              opts                - options info list
  *
- * RETURN:      Option character or EOF
+ * RETURN:      Option character or ACPI_OPT_END
  *
  * DESCRIPTION: Get the next option
  *
@@ -128,10 +126,10 @@ int acpi_getopt(int argc, char **argv, char *opts)
 		if (acpi_gbl_optind >= argc ||
 		    argv[acpi_gbl_optind][0] != '-' ||
 		    argv[acpi_gbl_optind][1] == '\0') {
-			return (EOF);
-		} else if (strcmp(argv[acpi_gbl_optind], "--") == 0) {
+			return (ACPI_OPT_END);
+		} else if (ACPI_STRCMP(argv[acpi_gbl_optind], "--") == 0) {
 			acpi_gbl_optind++;
-			return (EOF);
+			return (ACPI_OPT_END);
 		}
 	}
 
@@ -142,7 +140,7 @@ int acpi_getopt(int argc, char **argv, char *opts)
 	/* Make sure that the option is legal */
 
 	if (current_char == ':' ||
-	    (opts_ptr = strchr(opts, current_char)) == NULL) {
+	    (opts_ptr = ACPI_STRCHR(opts, current_char)) == NULL) {
 		ACPI_OPTION_ERROR("Illegal option: -", current_char);
 
 		if (argv[acpi_gbl_optind][++current_char_ptr] == '\0') {
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index 2a06a86..9c3b259 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -166,7 +166,8 @@ static int ap_do_options(int argc, char **argv)
 
 	/* Command line options */
 
-	while ((j = acpi_getopt(argc, argv, AP_SUPPORTED_OPTIONS)) != EOF)
+	while ((j =
+		acpi_getopt(argc, argv, AP_SUPPORTED_OPTIONS)) != ACPI_OPT_END)
 		switch (j) {
 			/*
 			 * Global options
-- 
1.7.10

