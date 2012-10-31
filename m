From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/26] Cleanup of invalid ACPI name handling and repair
Date: Wed, 31 Oct 2012 10:24:51 +0800
Message-ID: <d764cba211d4db8db0a3d696b40c05224634dd85.1351649950.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52379 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753797Ab2JaCZC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:25:02 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

 Implemented a change/cleanup for the handling of invalid ACPI names.
 Names are now validated and repaired only when
 1) entering a new name into the namespace and
 2) disassembling a named AML opcode. A warning is only displayed in
    debug mode or when the interpreter is in "strict" mode, since some
    working machines do in fact contain invalid ACPI names.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h  |    2 +-
 drivers/acpi/acpica/nsdump.c   |    8 --------
 drivers/acpi/acpica/nssearch.c |   17 +----------------
 drivers/acpi/acpica/utmisc.c   |   34 ++++++++++++++++++++++++++--------
 4 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 5035327..68cb6de 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -483,7 +483,7 @@ void acpi_ut_print_string(char *string, u8 max_length);
 
 u8 acpi_ut_valid_acpi_name(u32 name);
 
-acpi_name acpi_ut_repair_name(char *name);
+void acpi_ut_repair_name(char *name);
 
 u8 acpi_ut_valid_acpi_char(char character, u32 position);
 
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 2526aaf..993b124 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -209,14 +209,6 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 				      "Invalid ACPI Object Type 0x%08X", type));
 		}
 
-		if (!acpi_ut_valid_acpi_name(this_node->name.integer)) {
-			this_node->name.integer =
-			    acpi_ut_repair_name(this_node->name.ascii);
-
-			ACPI_WARNING((AE_INFO, "Invalid ACPI Name %08X",
-				      this_node->name.integer));
-		}
-
 		acpi_os_printf("%4.4s", acpi_ut_get_node_name(this_node));
 	}
 
diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index 456cc85..1d2d8ff 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -314,22 +314,7 @@ acpi_ns_search_and_enter(u32 target_name,
 	 * this problem, and we want to be able to enable ACPI support for them,
 	 * even though there are a few bad names.
 	 */
-	if (!acpi_ut_valid_acpi_name(target_name)) {
-		target_name =
-		    acpi_ut_repair_name(ACPI_CAST_PTR(char, &target_name));
-
-		/* Report warning only if in strict mode or debug mode */
-
-		if (!acpi_gbl_enable_interpreter_slack) {
-			ACPI_WARNING((AE_INFO,
-				      "Found bad character(s) in name, repaired: [%4.4s]\n",
-				      ACPI_CAST_PTR(char, &target_name)));
-		} else {
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "Found bad character(s) in name, repaired: [%4.4s]\n",
-					  ACPI_CAST_PTR(char, &target_name)));
-		}
-	}
+	acpi_ut_repair_name(ACPI_CAST_PTR(char, &target_name));
 
 	/* Try to find the name in the namespace level specified by the caller */
 
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 33c6cf7..d179f0e 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -642,25 +642,43 @@ u8 acpi_ut_valid_acpi_name(u32 name)
  *
  ******************************************************************************/
 
-acpi_name acpi_ut_repair_name(char *name)
+void acpi_ut_repair_name(char *name)
 {
-       u32 i;
-	char new_name[ACPI_NAME_SIZE];
+	u32 i;
+	u8 found_bad_char = FALSE;
+
+	ACPI_FUNCTION_NAME(ut_repair_name);
+
+	/* Check each character in the name */
 
 	for (i = 0; i < ACPI_NAME_SIZE; i++) {
-		new_name[i] = name[i];
+		if (acpi_ut_valid_acpi_char(name[i], i)) {
+			continue;
+		}
 
 		/*
 		 * Replace a bad character with something printable, yet technically
 		 * still invalid. This prevents any collisions with existing "good"
 		 * names in the namespace.
 		 */
-		if (!acpi_ut_valid_acpi_char(name[i], i)) {
-			new_name[i] = '*';
-		}
+		name[i] = '*';
+		found_bad_char = TRUE;
 	}
 
-	return (*(u32 *) new_name);
+	if (found_bad_char) {
+
+		/* Report warning only if in strict mode or debug mode */
+
+		if (!acpi_gbl_enable_interpreter_slack) {
+			ACPI_WARNING((AE_INFO,
+				      "Found bad character(s) in name, repaired: [%4.4s]\n",
+				      name));
+		} else {
+			ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+					  "Found bad character(s) in name, repaired: [%4.4s]\n",
+					  name));
+		}
+	}
 }
 
 /*******************************************************************************
-- 
1.7.10

