From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/21] ACPICA: Add an error message if the Debugger fails initialization.
Date: Wed,  8 Jan 2014 13:44:38 +0800
Message-ID: <4ac9169f9faaccf0699e2cf72e435868e67d0e1e.1387505703.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27529 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbaAHFos (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:44:48 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Linux kernel behaviour is not affected as the changes only applies to the
debugger which is currently not shipped in the kernel.

Previously, only status was returned.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utxfinit.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 75efea0..246ef68 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -122,8 +122,16 @@ acpi_status __init acpi_initialize_subsystem(void)
 
 	/* If configured, initialize the AML debugger */
 
-	ACPI_DEBUGGER_EXEC(status = acpi_db_initialize());
-	return_ACPI_STATUS(status);
+#ifdef ACPI_DEBUGGER
+	status = acpi_db_initialize();
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+				"During Debugger initialization"));
+		return_ACPI_STATUS(status);
+	}
+#endif
+
+	return_ACPI_STATUS(AE_OK);
 }
 
 ACPI_EXPORT_SYMBOL_INIT(acpi_initialize_subsystem)
-- 
1.7.10

