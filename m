From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 07/28] ACPICA: Tables: Fix an issue that FACS initialization is performed twice.
Date: Wed, 24 Jun 2015 11:03:14 +0800
Message-ID: <a273ac8a9267ff410e00044ee765118abbf1165e.1435114811.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435114811.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34193 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934011AbbFXDDW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jun 2015 23:03:22 -0400
In-Reply-To: <cover.1435114811.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 90f5332a15e9d9ba83831ca700b2b9f708274658

This patch adds a new FACS initialization flag for acpi_tb_initialize().
acpi_enable_subsystem() might be invoked several times in OS bootup process,
and we don't want FACS initialization to be invoked twice. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/90f5332a
Cc: All applicable <stable@vger.kernel.org> # All applicable
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/utxfinit.c |   10 ++++++----
 include/acpi/actypes.h         |    1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 083a768..42a32a6 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -179,10 +179,12 @@ acpi_status __init acpi_enable_subsystem(u32 flags)
 	 * Obtain a permanent mapping for the FACS. This is required for the
 	 * Global Lock and the Firmware Waking Vector
 	 */
-	status = acpi_tb_initialize_facs();
-	if (ACPI_FAILURE(status)) {
-		ACPI_WARNING((AE_INFO, "Could not map the FACS table"));
-		return_ACPI_STATUS(status);
+	if (!(flags & ACPI_NO_FACS_INIT)) {
+		status = acpi_tb_initialize_facs();
+		if (ACPI_FAILURE(status)) {
+			ACPI_WARNING((AE_INFO, "Could not map the FACS table"));
+			return_ACPI_STATUS(status);
+		}
 	}
 #endif				/* !ACPI_REDUCED_HARDWARE */
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 63fd7f5..ff0b53e 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -568,6 +568,7 @@ typedef u64 acpi_integer;
 #define ACPI_NO_ACPI_ENABLE             0x10
 #define ACPI_NO_DEVICE_INIT             0x20
 #define ACPI_NO_OBJECT_INIT             0x40
+#define ACPI_NO_FACS_INIT               0x80
 
 /*
  * Initialization state
-- 
1.7.10

