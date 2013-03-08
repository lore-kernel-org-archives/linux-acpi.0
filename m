From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 19/21] ACPICA: Disassembler: Add warnings for unresolved control methods
Date: Fri,  8 Mar 2013 17:23:39 +0800
Message-ID: <75c67d5699b2815b6c9f79d7d726606c6e34fc41.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:36890 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933457Ab3CHJXx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:23:53 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Flags the case where external control methods are unresolved,
meaning that the disassembler had no idea how many arguments to
parse for the method invocation.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    2 ++
 drivers/acpi/acpica/aclocal.h  |    1 +
 drivers/acpi/acpica/utglobal.c |    2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index feaa5d5..833fbc5 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -417,6 +417,8 @@ ACPI_EXTERN u8 ACPI_INIT_GLOBAL(acpi_gbl_ignore_noop_operator, FALSE);
 
 ACPI_EXTERN u8 acpi_gbl_db_opt_disasm;
 ACPI_EXTERN u8 acpi_gbl_db_opt_verbose;
+ACPI_EXTERN u8 acpi_gbl_num_external_methods;
+ACPI_EXTERN u32 acpi_gbl_resolved_external_methods;
 ACPI_EXTERN struct acpi_external_list *acpi_gbl_external_list;
 ACPI_EXTERN struct acpi_external_file *acpi_gbl_external_file_list;
 #endif
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 9d45f97..636658f 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1052,6 +1052,7 @@ struct acpi_external_list {
 	u16 length;
 	u8 type;
 	u8 flags;
+	u8 resolved;
 };
 
 /* Values for Flags field above */
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index ffecf4b..f736448 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -359,6 +359,8 @@ acpi_status acpi_ut_init_globals(void)
 
 #ifdef ACPI_DISASSEMBLER
 	acpi_gbl_external_list = NULL;
+	acpi_gbl_num_external_methods = 0;
+	acpi_gbl_resolved_external_methods = 0;
 #endif
 
 #ifdef ACPI_DEBUG_OUTPUT
-- 
1.7.10

