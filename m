From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH] ACPI: eliminate hardcode for ACPI0007 _HID
Date: Tue, 19 Oct 2010 16:11:20 +0800
Message-ID: <1287475880-2492-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12624 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755302Ab0JSIIy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Oct 2010 04:08:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: bjorn.helgaas@hp.com, yinghai@kernel.org, Chen Gong <gong.chen@linux.intel.com>

the original commit 9eccbc removes the macro definition of ACPI0007,
but in commit c1e0ddbf this value is used again. To avoid hard-code
in the multi-places, revert the original patch and update the usage
for it.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/processor_core.c   |    2 +-
 drivers/acpi/processor_driver.c |    2 +-
 include/acpi/acpi_drivers.h     |    1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index bec561c..d99e6ae 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -346,5 +346,5 @@ void __init acpi_early_processor_set_pdc(void)
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
 			    early_init_pdc, NULL, NULL, NULL);
-	acpi_get_devices("ACPI0007", early_init_pdc, NULL, NULL);
+	acpi_get_devices(ACPI_PROCESSOR_HID, early_init_pdc, NULL, NULL);
 }
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 347eb21..caab792 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -90,7 +90,7 @@ static int acpi_processor_handle_eject(struct acpi_processor *pr);
 
 static const struct acpi_device_id processor_device_ids[] = {
 	{ACPI_PROCESSOR_OBJECT_HID, 0},
-	{"ACPI0007", 0},
+	{ACPI_PROCESSOR_HID, 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, processor_device_ids);
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 23d78b4..46bf7bf 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -58,6 +58,7 @@
 
 #define ACPI_POWER_HID			"LNXPOWER"
 #define ACPI_PROCESSOR_OBJECT_HID	"LNXCPU"
+#define ACPI_PROCESSOR_HID		"ACPI0007"
 #define ACPI_SYSTEM_HID			"LNXSYSTM"
 #define ACPI_THERMAL_HID		"LNXTHERM"
 #define ACPI_BUTTON_HID_POWERF		"LNXPWRBN"
-- 
1.7.3.1.120.g38a18

