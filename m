From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 2/8] ACPICA: acpiexec: Add testability of deferred table verification
Date: Fri, 17 Nov 2017 10:03:30 -0800
Message-ID: <20171117180336.15558-2-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117180336.15558-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55627 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161241AbdKQSIb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 13:08:31 -0500
In-Reply-To: <20171117180336.15558-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Lv Zheng <lv.zheng@intel.com>

ACPICA commit 04c28c7549e694ea85f40bcc816039e5fbb4169c

This patch adds testability of deferred table verification mechanism. As
acpiexec uses dynamically allocated root table list from its very early
stage, a change to acpi_reallocate_root_table() is required to allow deferred
table verification mechanism to be triggered in such an environment. Note
that acpi_gbl_enable_table_validation is still TRUE by default, thus:
1. Developers need to manually set acpi_gbl_enable_table_validation to FALSE
   for acpiexec to enable this test.
2. For all other OSPMs (Linux, BSDs, etc.), this commit is a no-op.

Link: https://github.com/acpica/acpica/commit/04c28c75
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/tbxface.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 26ad596c973e..5ecb8d2e6834 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -173,10 +173,13 @@ acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_table(void)
 	ACPI_FUNCTION_TRACE(acpi_reallocate_root_table);
 
 	/*
-	 * Only reallocate the root table if the host provided a static buffer
-	 * for the table array in the call to acpi_initialize_tables.
+	 * If there are tables unverified, it is required to reallocate the
+	 * root table list to clean up invalid table entries. Otherwise only
+	 * reallocate the root table list if the host provided a static buffer
+	 * for the table array in the call to acpi_initialize_tables().
 	 */
-	if (acpi_gbl_root_table_list.flags & ACPI_ROOT_ORIGIN_ALLOCATED) {
+	if ((acpi_gbl_root_table_list.flags & ACPI_ROOT_ORIGIN_ALLOCATED) &&
+	    acpi_gbl_enable_table_validation) {
 		return_ACPI_STATUS(AE_SUPPORT);
 	}
 
-- 
2.13.6

