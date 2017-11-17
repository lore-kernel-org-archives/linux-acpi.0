From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 07/11] ACPICA: Tools: Deploy -vd option (build date/time) across all tools
Date: Fri, 17 Nov 2017 15:40:20 -0800
Message-ID: <20171117234024.833-8-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234024.833-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:29666 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759270AbdKQXpZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:45:25 -0500
In-Reply-To: <20171117234024.833-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 336131640a1574b86240b32eca3150195f9270d6

Common option for all tools.

Link: https://github.com/acpica/acpica/commit/33613164
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/acapps.h             |  3 +++
 tools/power/acpi/tools/acpidump/apmain.c | 28 ++++++++++++++++++++++++----
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index 7a1a68b5ac5c..2243c8164b34 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -80,6 +80,9 @@
 	prefix, ACPICA_COPYRIGHT, \
 	prefix
 
+#define ACPI_COMMON_BUILD_TIME \
+	"Build date/time: %s %s\n", __DATE__, __TIME__
+
 /* Macros for usage messages */
 
 #define ACPI_USAGE_HEADER(usage) \
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index 22c3b4ee1617..be418fba9441 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -79,7 +79,7 @@ struct ap_dump_action action_table[AP_MAX_ACTIONS];
 u32 current_action = 0;
 
 #define AP_UTILITY_NAME             "ACPI Binary Table Dump Utility"
-#define AP_SUPPORTED_OPTIONS        "?a:bc:f:hn:o:r:svxz"
+#define AP_SUPPORTED_OPTIONS        "?a:bc:f:hn:o:r:sv^xz"
 
 /******************************************************************************
  *
@@ -100,6 +100,7 @@ static void ap_display_usage(void)
 	ACPI_OPTION("-r <Address>", "Dump tables from specified RSDP");
 	ACPI_OPTION("-s", "Print table summaries only");
 	ACPI_OPTION("-v", "Display version information");
+	ACPI_OPTION("-vd", "Display build date and time");
 	ACPI_OPTION("-z", "Verbose mode");
 
 	ACPI_USAGE_TEXT("\nTable Options:\n");
@@ -231,10 +232,29 @@ static int ap_do_options(int argc, char **argv)
 			}
 			continue;
 
-		case 'v':	/* Revision/version */
+		case 'v':	/* -v: (Version): signon already emitted, just exit */
 
-			acpi_os_printf(ACPI_COMMON_SIGNON(AP_UTILITY_NAME));
-			return (1);
+			switch (acpi_gbl_optarg[0]) {
+			case '^':	/* -v: (Version) */
+
+				fprintf(stderr,
+					ACPI_COMMON_SIGNON(AP_UTILITY_NAME));
+				return (1);
+
+			case 'd':
+
+				fprintf(stderr,
+					ACPI_COMMON_SIGNON(AP_UTILITY_NAME));
+				printf(ACPI_COMMON_BUILD_TIME);
+				return (1);
+
+			default:
+
+				printf("Unknown option: -v%s\n",
+				       acpi_gbl_optarg);
+				return (-1);
+			}
+			break;
 
 		case 'z':	/* Verbose mode */
 
-- 
2.13.6

