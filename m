From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 26/30] ACPICA: Applications: Fix a potential issue that help messages may be dumped to acpi_gbl_debug_file
Date: Thu,  4 Aug 2016 16:45:22 +0800
Message-ID: <95f57221b07c721a3ff135b5be2b65bbaa7997f5.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37123 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932351AbcHDIpc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:45:32 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit d1b7372c7eb89cdba3d3c239fb07e2fdc5abf880

This is a regression fix, restoring usage macro to its original
implementation.

There is an issue for usage macros, if an command line option changed
acpi_gbl_debug_file, then the follow up usage message may be errornously
dumped to the debug file.
This is just a bug in theory, because currently acpi_gbl_debug_file can only
be modified by acpibin and acpiexec. And this will not trigger such issue
because:
1. For acpibin, acpi_gbl_debug_file will be modified by "-t" option and the
   program exits after processing this option without dumping help message
   or other error options.
2. For acpiexec, acpi_gbl_debug_file will only be modified by the open
   command, which happens after parsing the command line options, so no
   help message will be dumped into the debug file.
But maintaining this logic is difficult, so this patch modifies
acpi_os_printf() into printf() for usage macros so that the help messages are
ensured to be dumped to the stdout. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/d1b7372c
Link: https://bugs.acpica.org/show_bug.cgi?id=1142
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acapps.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index bc38534..0bd6307 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -83,13 +83,13 @@
 /* Macros for usage messages */
 
 #define ACPI_USAGE_HEADER(usage) \
-	acpi_os_printf ("Usage: %s\nOptions:\n", usage);
+	printf ("Usage: %s\nOptions:\n", usage);
 
 #define ACPI_USAGE_TEXT(description) \
-	acpi_os_printf (description);
+	printf (description);
 
 #define ACPI_OPTION(name, description) \
-	acpi_os_printf (" %-20s%s\n", name, description);
+	printf ("  %-20s%s\n", name, description);
 
 /* Check for unexpected exceptions */
 
-- 
1.7.10

