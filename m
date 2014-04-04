From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/28] ACPICA: Update comments for ACPICA name - no functional change.
Date: Fri,  4 Apr 2014 12:37:11 +0800
Message-ID: <d8c2ab289c6e51ebbeb530f54b145a4540d89f71.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17087 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbaDDEhO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:37:14 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

Change all comments that contain the string "ACPI CA" to "ACPICA"
so that the name is standard across the entire source base.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    4 ++--
 drivers/acpi/acpica/evsci.c    |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 49bbc71..11ce629 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -103,8 +103,8 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_auto_serialize_methods, TRUE);
 
 /*
  * Create the predefined _OSI method in the namespace? Default is TRUE
- * because ACPI CA is fully compatible with other ACPI implementations.
- * Changing this will revert ACPI CA (and machine ASL) to pre-OSI behavior.
+ * because ACPICA is fully compatible with other ACPI implementations.
+ * Changing this will revert ACPICA (and machine ASL) to pre-OSI behavior.
  */
 ACPI_INIT_GLOBAL(u8, acpi_gbl_create_osi_method, TRUE);
 
diff --git a/drivers/acpi/acpica/evsci.c b/drivers/acpi/acpica/evsci.c
index 4d8a709..29630e3 100644
--- a/drivers/acpi/acpica/evsci.c
+++ b/drivers/acpi/acpica/evsci.c
@@ -117,7 +117,7 @@ static u32 ACPI_SYSTEM_XFACE acpi_ev_sci_xrupt_handler(void *context)
 	ACPI_FUNCTION_TRACE(ev_sci_xrupt_handler);
 
 	/*
-	 * We are guaranteed by the ACPI CA initialization/shutdown code that
+	 * We are guaranteed by the ACPICA initialization/shutdown code that
 	 * if this interrupt handler is installed, ACPI is enabled.
 	 */
 
-- 
1.7.10

