From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v2 2/5] ACPICA: Tables: Do not validate signature for dynamic table load
Date: Tue, 16 May 2017 15:13:26 +0800
Message-ID: <f07bb8cfeda364698adad9bc15d54c9b2ac8b366.1494916766.git.lv.zheng@intel.com>
References: <20170227093432.3308-1-hdegoede@redhat.com> <cover.1494916766.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53622 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbdEPHNf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 May 2017 03:13:35 -0400
In-Reply-To: <cover.1494916766.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, devel@acpica.org, Hans de Goede <hdegoede@redhat.com>

Windows seems to allow arbitrary table signatures for Load/load_table
opcodes:
  ACPI BIOS Error (bug): Table has invalid signature [PRAD] (0x44415250)
So this patch removes dynamic load signature checks. However we need to
find a way to avoid table loading against tables like MADT. This is not
covered by this commit.

This Windows behavior has been validated on link #1. An end user bug
report can also be found on link #2.

This patch also includes simple cleanup for static load signature check
code. Reported by Ye Xiaolong, Fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/pull/121 [#1]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=118601 [#2]
Reported-by: Ye Xiaolong <xiaolong.ye@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbinstal.c | 28 ----------------------------
 drivers/acpi/acpica/tbxfload.c |  2 +-
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index ee74515..9d21296 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -222,34 +222,6 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
 	if (reload) {
-		/*
-		 * Validate the incoming table signature.
-		 *
-		 * 1) Originally, we checked the table signature for "SSDT" or "PSDT".
-		 * 2) We added support for OEMx tables, signature "OEM".
-		 * 3) Valid tables were encountered with a null signature, so we just
-		 *    gave up on validating the signature, (05/2008).
-		 * 4) We encountered non-AML tables such as the MADT, which caused
-		 *    interpreter errors and kernel faults. So now, we once again allow
-		 *    only "SSDT", "OEMx", and now, also a null signature. (05/2011).
-		 */
-		if ((new_table_desc.signature.ascii[0] != 0x00) &&
-		    (!ACPI_COMPARE_NAME
-		     (&new_table_desc.signature, ACPI_SIG_SSDT))
-		    && (strncmp(new_table_desc.signature.ascii, "OEM", 3))) {
-			ACPI_BIOS_ERROR((AE_INFO,
-					 "Table has invalid signature [%4.4s] (0x%8.8X), "
-					 "must be SSDT or OEMx",
-					 acpi_ut_valid_nameseg(new_table_desc.
-							       signature.
-							       ascii) ?
-					 new_table_desc.signature.
-					 ascii : "????",
-					 new_table_desc.signature.integer));
-
-			status = AE_BAD_SIGNATURE;
-			goto unlock_and_exit;
-		}
 
 		/* Check if table is already registered */
 
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index b71ce3b..d81f442 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -206,7 +206,7 @@ acpi_status acpi_tb_load_namespace(void)
 	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
 		table = &acpi_gbl_root_table_list.tables[i];
 
-		if (!acpi_gbl_root_table_list.tables[i].address ||
+		if (!table->address ||
 		    (!ACPI_COMPARE_NAME(table->signature.ascii, ACPI_SIG_SSDT)
 		     && !ACPI_COMPARE_NAME(table->signature.ascii,
 					   ACPI_SIG_PSDT)
-- 
2.7.4

