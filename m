From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 20/25] ACPICA: OSL: Update acpidump to reduce source code differences.
Date: Tue,  8 Jul 2014 10:07:59 +0800
Message-ID: <63ca7824e4ef2bee5244cdfa20d3a9c9ef1635f3.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33774 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427AbaGHCID (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:08:03 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch is a result of an ACPICA commit to enables acpidump for EFI. For
Linux kernel, this patch is a no-op. It is only required by the ACPICA
release process to reduce the source code differences between the Linux
kernel and the ACPICA upstream. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 tools/power/acpi/tools/acpidump/apfiles.c |   30 ++++++++++++++++++++++-------
 tools/power/acpi/tools/acpidump/apmain.c  |    4 ++++
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 5781c13..d470046 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -44,6 +44,27 @@
 #include "acpidump.h"
 #include "acapps.h"
 
+/* Local prototypes */
+
+static int ap_is_existing_file(char *pathname);
+
+static int ap_is_existing_file(char *pathname)
+{
+#ifndef _GNU_EFI
+	struct stat stat_info;
+
+	if (!stat(pathname, &stat_info)) {
+		acpi_log_error("Target path already exists, overwrite? [y|n] ");
+
+		if (getchar() != 'y') {
+			return (-1);
+		}
+	}
+#endif
+
+	return 0;
+}
+
 /******************************************************************************
  *
  * FUNCTION:    ap_open_output_file
@@ -59,17 +80,12 @@
 
 int ap_open_output_file(char *pathname)
 {
-	struct stat stat_info;
 	ACPI_FILE file;
 
 	/* If file exists, prompt for overwrite */
 
-	if (!stat(pathname, &stat_info)) {
-		acpi_log_error("Target path already exists, overwrite? [y|n] ");
-
-		if (getchar() != 'y') {
-			return (-1);
-		}
+	if (ap_is_existing_file(pathname) != 0) {
+		return (-1);
 	}
 
 	/* Point stdout to the file */
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index 35bd674..853b4da 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -291,7 +291,11 @@ static int ap_do_options(int argc, char **argv)
  *
  ******************************************************************************/
 
+#ifndef _GNU_EFI
 int ACPI_SYSTEM_XFACE main(int argc, char *argv[])
+#else
+int ACPI_SYSTEM_XFACE acpi_main(int argc, char *argv[])
+#endif
 {
 	int status = 0;
 	struct ap_dump_action *action;
-- 
1.7.10

