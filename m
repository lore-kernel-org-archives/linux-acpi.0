From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/25] ACPICA: Application: Enhance ACPI_USAGE_xxx/ACPI_OPTION with acpi_os_printf() to improve portability.
Date: Tue,  8 Jul 2014 10:07:13 +0800
Message-ID: <c010a2a4f5afffd4e74c1743129afc45dbcea5f8.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:20021 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752721AbaGHCHR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:07:17 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch enhances ACPI_USAGE_xxx/ACPI_OPTION macros to use portable
acpi_os_printf() so that usage functions for applications no longer rely on
the printf() API.

To use acpi_os_printf() exported by osunixxf.c as a replacement of
printf(), applications need to initialize acpi_gbl_output_file to stdout
and initialize acpi_gbl_db_output_flags to ACPI_DB_CONSOLE_OUTPUT. The
latter is automatically done by ACPI_INIT_GLOBAL(), applications need to
link utglobal.o to utilize this mechanism. For GCC, assigning stdout to
acpi_gbl_output_file using ACPI_INIT_GLOBAL() is not possible as stdout is
not a constant in GCC environment. As an alternative solution, stdout
assignment has been put into acpi_os_initialize(). Thus
acpi_os_initialize() need to be invoked very early by the applications to
initialize the default output of acpi_os_printf() to keep behavior
consistency.
acpidump has already invoked acpi_os_initialize() in this way. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acapps.h             |    7 +++++--
 tools/power/acpi/tools/acpidump/apmain.c |    8 ++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index 8698ffb..5bf41f8 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -79,10 +79,13 @@
 /* Macros for usage messages */
 
 #define ACPI_USAGE_HEADER(usage) \
-	printf ("Usage: %s\nOptions:\n", usage);
+	acpi_os_printf ("Usage: %s\nOptions:\n", usage);
+
+#define ACPI_USAGE_TEXT(description) \
+	acpi_os_printf (description);
 
 #define ACPI_OPTION(name, description) \
-	printf ("  %-18s%s\n", name, description);
+	acpi_os_printf (" %-18s%s\n", name, description);
 
 #define FILE_SUFFIX_DISASSEMBLY     "dsl"
 #define ACPI_TABLE_FILE_SUFFIX      ".dat"
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index c03e473..2a06a86 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -104,7 +104,7 @@ static void ap_display_usage(void)
 	ACPI_OPTION("-v", "Display version information");
 	ACPI_OPTION("-z", "Verbose mode");
 
-	printf("\nTable Options:\n");
+	ACPI_USAGE_TEXT("\nTable Options:\n");
 
 	ACPI_OPTION("-a <Address>", "Get table via a physical address");
 	ACPI_OPTION("-f <BinaryFile>", "Get table via a binary file");
@@ -112,9 +112,9 @@ static void ap_display_usage(void)
 	ACPI_OPTION("-x", "Do not use but dump XSDT");
 	ACPI_OPTION("-x -x", "Do not use or dump XSDT");
 
-	printf("\n"
-	       "Invocation without parameters dumps all available tables\n"
-	       "Multiple mixed instances of -a, -f, and -n are supported\n\n");
+	ACPI_USAGE_TEXT("\n"
+			"Invocation without parameters dumps all available tables\n"
+			"Multiple mixed instances of -a, -f, and -n are supported\n\n");
 }
 
 /******************************************************************************
-- 
1.7.10

