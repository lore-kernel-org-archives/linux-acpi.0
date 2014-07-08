From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/25] ACPICA: acpidump: Remove exit() from generic layer to improve portability.
Date: Tue,  8 Jul 2014 10:07:39 +0800
Message-ID: <4019a93c21f661d80387eec0b1dfa4bdd664b9e1.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:60256 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087AbaGHCHo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:07:44 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch removes exit() from generic acpidump code to improve the
portability of this tool. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 tools/power/acpi/tools/acpidump/apmain.c |   50 +++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index 9c3b259..55fd44d 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -72,7 +72,7 @@ static void ap_display_usage(void);
 
 static int ap_do_options(int argc, char **argv);
 
-static void ap_insert_action(char *argument, u32 to_be_done);
+static int ap_insert_action(char *argument, u32 to_be_done);
 
 /* Table for deferred actions from command line options */
 
@@ -124,13 +124,13 @@ static void ap_display_usage(void)
  * PARAMETERS:  argument            - Pointer to the argument for this action
  *              to_be_done          - What to do to process this action
  *
- * RETURN:      None. Exits program if action table becomes full.
+ * RETURN:      Status
  *
  * DESCRIPTION: Add an action item to the action table
  *
  ******************************************************************************/
 
-static void ap_insert_action(char *argument, u32 to_be_done)
+static int ap_insert_action(char *argument, u32 to_be_done)
 {
 
 	/* Insert action and check for table overflow */
@@ -142,8 +142,10 @@ static void ap_insert_action(char *argument, u32 to_be_done)
 	if (current_action > AP_MAX_ACTIONS) {
 		fprintf(stderr, "Too many table options (max %u)\n",
 			AP_MAX_ACTIONS);
-		exit(-1);
+		return (-1);
 	}
+
+	return (0);
 }
 
 /******************************************************************************
@@ -186,12 +188,12 @@ static int ap_do_options(int argc, char **argv)
 		case '?':
 
 			ap_display_usage();
-			exit(0);
+			return (1);
 
 		case 'o':	/* Redirect output to a single file */
 
 			if (ap_open_output_file(acpi_gbl_optarg)) {
-				exit(-1);
+				return (-1);
 			}
 			continue;
 
@@ -204,7 +206,7 @@ static int ap_do_options(int argc, char **argv)
 				fprintf(stderr,
 					"%s: Could not convert to a physical address\n",
 					acpi_gbl_optarg);
-				exit(-1);
+				return (-1);
 			}
 			continue;
 
@@ -225,7 +227,7 @@ static int ap_do_options(int argc, char **argv)
 		case 'v':	/* Revision/version */
 
 			printf(ACPI_COMMON_SIGNON(AP_UTILITY_NAME));
-			exit(0);
+			return (1);
 
 		case 'z':	/* Verbose mode */
 
@@ -238,32 +240,40 @@ static int ap_do_options(int argc, char **argv)
 			 */
 		case 'a':	/* Get table by physical address */
 
-			ap_insert_action(acpi_gbl_optarg,
-					 AP_DUMP_TABLE_BY_ADDRESS);
+			if (ap_insert_action
+			    (acpi_gbl_optarg, AP_DUMP_TABLE_BY_ADDRESS)) {
+				return (-1);
+			}
 			break;
 
 		case 'f':	/* Get table from a file */
 
-			ap_insert_action(acpi_gbl_optarg,
-					 AP_DUMP_TABLE_BY_FILE);
+			if (ap_insert_action
+			    (acpi_gbl_optarg, AP_DUMP_TABLE_BY_FILE)) {
+				return (-1);
+			}
 			break;
 
 		case 'n':	/* Get table by input name (signature) */
 
-			ap_insert_action(acpi_gbl_optarg,
-					 AP_DUMP_TABLE_BY_NAME);
+			if (ap_insert_action
+			    (acpi_gbl_optarg, AP_DUMP_TABLE_BY_NAME)) {
+				return (-1);
+			}
 			break;
 
 		default:
 
 			ap_display_usage();
-			exit(-1);
+			return (-1);
 		}
 
 	/* If there are no actions, this means "get/dump all tables" */
 
 	if (current_action == 0) {
-		ap_insert_action(NULL, AP_DUMP_ALL_TABLES);
+		if (ap_insert_action(NULL, AP_DUMP_ALL_TABLES)) {
+			return (-1);
+		}
 	}
 
 	return (0);
@@ -293,8 +303,12 @@ int ACPI_SYSTEM_XFACE main(int argc, char *argv[])
 
 	/* Process command line options */
 
-	if (ap_do_options(argc, argv)) {
-		return (-1);
+	status = ap_do_options(argc, argv);
+	if (status > 0) {
+		return (0);
+	}
+	if (status < 0) {
+		return (status);
 	}
 
 	/* Get/dump ACPI table(s) as requested */
-- 
1.7.10

