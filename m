From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 19/26] ACPICA: acpidump: Convert the default behavior to dump from /sys/firmware/acpi/tables.
Date: Wed,  1 Jul 2015 14:44:58 +0800
Message-ID: <d07861d1ae4665567ee8600b5e7dbb9e30c35500.1435731597.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435731597.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28321 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbbGAGpF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jul 2015 02:45:05 -0400
In-Reply-To: <cover.1435731597.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 04c3bd7e9d6aeb2b3edebe99c90dc271ae4e6353

In order to work without any additional option to dump tables when /dev/mem
doesn't exist, this patch switches the default behavior of acpidump to dump
from /sys/firmware/acpi/tables. Reported by Al Stone, Fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/04c3bd7e
Reported-by: Al Stone <ahs3@redhat.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 tools/power/acpi/tools/acpidump/acpidump.h |    2 +-
 tools/power/acpi/tools/acpidump/apmain.c   |   15 ++++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/power/acpi/tools/acpidump/acpidump.h b/tools/power/acpi/tools/acpidump/acpidump.h
index 84bdef0..eed5344 100644
--- a/tools/power/acpi/tools/acpidump/acpidump.h
+++ b/tools/power/acpi/tools/acpidump/acpidump.h
@@ -66,7 +66,7 @@
 EXTERN u8 INIT_GLOBAL(gbl_summary_mode, FALSE);
 EXTERN u8 INIT_GLOBAL(gbl_verbose_mode, FALSE);
 EXTERN u8 INIT_GLOBAL(gbl_binary_mode, FALSE);
-EXTERN u8 INIT_GLOBAL(gbl_dump_customized_tables, FALSE);
+EXTERN u8 INIT_GLOBAL(gbl_dump_customized_tables, TRUE);
 EXTERN u8 INIT_GLOBAL(gbl_do_not_dump_xsdt, FALSE);
 EXTERN ACPI_FILE INIT_GLOBAL(gbl_output_file, NULL);
 EXTERN char INIT_GLOBAL(*gbl_output_filename, NULL);
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index d0ba653..57620f6 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -80,7 +80,7 @@ struct ap_dump_action action_table[AP_MAX_ACTIONS];
 u32 current_action = 0;
 
 #define AP_UTILITY_NAME             "ACPI Binary Table Dump Utility"
-#define AP_SUPPORTED_OPTIONS        "?a:bcf:hn:o:r:svxz"
+#define AP_SUPPORTED_OPTIONS        "?a:bc:f:hn:o:r:svxz"
 
 /******************************************************************************
  *
@@ -96,7 +96,6 @@ static void ap_display_usage(void)
 	ACPI_USAGE_HEADER("acpidump [options]");
 
 	ACPI_OPTION("-b", "Dump tables to binary files");
-	ACPI_OPTION("-c", "Dump customized tables");
 	ACPI_OPTION("-h -?", "This help message");
 	ACPI_OPTION("-o <File>", "Redirect output to file");
 	ACPI_OPTION("-r <Address>", "Dump tables from specified RSDP");
@@ -107,6 +106,7 @@ static void ap_display_usage(void)
 	ACPI_USAGE_TEXT("\nTable Options:\n");
 
 	ACPI_OPTION("-a <Address>", "Get table via a physical address");
+	ACPI_OPTION("-c <on|off>", "Turning on/off customized table dumping");
 	ACPI_OPTION("-f <BinaryFile>", "Get table via a binary file");
 	ACPI_OPTION("-n <Signature>", "Get table via a name/signature");
 	ACPI_OPTION("-x", "Do not use but dump XSDT");
@@ -181,7 +181,16 @@ static int ap_do_options(int argc, char **argv)
 
 		case 'c':	/* Dump customized tables */
 
-			gbl_dump_customized_tables = TRUE;
+			if (!strcmp(acpi_gbl_optarg, "on")) {
+				gbl_dump_customized_tables = TRUE;
+			} else if (!strcmp(acpi_gbl_optarg, "off")) {
+				gbl_dump_customized_tables = FALSE;
+			} else {
+				acpi_log_error
+				    ("%s: Cannot handle this switch, please use on|off\n",
+				     acpi_gbl_optarg);
+				return (-1);
+			}
 			continue;
 
 		case 'h':
-- 
1.7.10

