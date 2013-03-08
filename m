From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/21] ACPICA: Update for ACPI 5 hardware-reduced feature
Date: Fri,  8 Mar 2013 17:22:14 +0800
Message-ID: <7b09609acd22b4e91b4f2e3ba9a990951e0b5b7c.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16195 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933331Ab3CHJW1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:22:27 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Ensure that AcpiEnable and AcpiDisable work properly when the
hardware-reduced flag is set in the FADT.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evxfevnt.c |   12 ++++++++++++
 drivers/acpi/acpica/hwacpi.c   |   12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index d6e4e42..7039606 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -74,6 +74,12 @@ acpi_status acpi_enable(void)
 		return_ACPI_STATUS(AE_NO_ACPI_TABLES);
 	}
 
+	/* If the Hardware Reduced flag is set, machine is always in acpi mode */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Check current mode */
 
 	if (acpi_hw_get_mode() == ACPI_SYS_MODE_ACPI) {
@@ -126,6 +132,12 @@ acpi_status acpi_disable(void)
 
 	ACPI_FUNCTION_TRACE(acpi_disable);
 
+	/* If the Hardware Reduced flag is set, machine is always in acpi mode */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	if (acpi_hw_get_mode() == ACPI_SYS_MODE_LEGACY) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INIT,
 				  "System is already in legacy (non-ACPI) mode\n"));
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index deb3f61..9b02a9f 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -66,6 +66,12 @@ acpi_status acpi_hw_set_mode(u32 mode)
 
 	ACPI_FUNCTION_TRACE(hw_set_mode);
 
+	/* If the Hardware Reduced flag is set, machine is always in acpi mode */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/*
 	 * ACPI 2.0 clarified that if SMI_CMD in FADT is zero,
 	 * system does not support mode transition.
@@ -146,6 +152,12 @@ u32 acpi_hw_get_mode(void)
 
 	ACPI_FUNCTION_TRACE(hw_get_mode);
 
+	/* If the Hardware Reduced flag is set, machine is always in acpi mode */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_VALUE(ACPI_SYS_MODE_ACPI);
+	}
+
 	/*
 	 * ACPI 2.0 clarified that if SMI_CMD in FADT is zero,
 	 * system does not support mode transition.
-- 
1.7.10

