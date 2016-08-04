From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/30] ACPICA: Debugger: Fix wrong inclusions in dbfileio.c
Date: Thu,  4 Aug 2016 16:44:04 +0800
Message-ID: <fa2e127b5f5e24978766ddc240eb931334d39072.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:61718 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757194AbcHDIom (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:44:42 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 649eb441fbef21965d10a1aca6ff41dcf23f8e05

dbfileio.c implements debugger functionalities that can only be used by the
application layer debugger (acpiexec), thus it should always include
<acapps.h> and thus shouldn't include <stdio.h> separately. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/649eb441
Link: https://bugs.acpica.org/show_bug.cgi?id=1292
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dbfileio.c |   20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/dbfileio.c b/drivers/acpi/acpica/dbfileio.c
index 4832879..6f05b8c 100644
--- a/drivers/acpi/acpica/dbfileio.c
+++ b/drivers/acpi/acpica/dbfileio.c
@@ -46,14 +46,12 @@
 #include "accommon.h"
 #include "acdebug.h"
 #include "actables.h"
-#include <stdio.h>
-#ifdef ACPI_APPLICATION
-#include "acapps.h"
-#endif
 
 #define _COMPONENT          ACPI_CA_DEBUGGER
 ACPI_MODULE_NAME("dbfileio")
 
+#ifdef ACPI_APPLICATION
+#include "acapps.h"
 #ifdef ACPI_DEBUGGER
 /*******************************************************************************
  *
@@ -69,8 +67,6 @@ ACPI_MODULE_NAME("dbfileio")
 void acpi_db_close_debug_file(void)
 {
 
-#ifdef ACPI_APPLICATION
-
 	if (acpi_gbl_debug_file) {
 		fclose(acpi_gbl_debug_file);
 		acpi_gbl_debug_file = NULL;
@@ -78,7 +74,6 @@ void acpi_db_close_debug_file(void)
 		acpi_os_printf("Debug output file %s closed\n",
 			       acpi_gbl_db_debug_filename);
 	}
-#endif
 }
 
 /*******************************************************************************
@@ -96,8 +91,6 @@ void acpi_db_close_debug_file(void)
 void acpi_db_open_debug_file(char *name)
 {
 
-#ifdef ACPI_APPLICATION
-
 	acpi_db_close_debug_file();
 	acpi_gbl_debug_file = fopen(name, "w+");
 	if (!acpi_gbl_debug_file) {
@@ -109,8 +102,6 @@ void acpi_db_open_debug_file(char *name)
 	strncpy(acpi_gbl_db_debug_filename, name,
 		sizeof(acpi_gbl_db_debug_filename));
 	acpi_gbl_db_output_to_file = TRUE;
-
-#endif
 }
 #endif
 
@@ -152,12 +143,13 @@ acpi_status acpi_db_load_tables(struct acpi_new_table_desc *list_head)
 			return (status);
 		}
 
-		fprintf(stderr,
-			"Acpi table [%4.4s] successfully installed and loaded\n",
-			table->signature);
+		acpi_os_printf
+		    ("Acpi table [%4.4s] successfully installed and loaded\n",
+		     table->signature);
 
 		table_list_head = table_list_head->next;
 	}
 
 	return (AE_OK);
 }
+#endif
-- 
1.7.10

