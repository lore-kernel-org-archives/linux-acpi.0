From: Len Brown <len.brown@intel.com>
Subject: [PATCH 078/105] ACPI: Remove duplicate definitions for _STA bits
Date: Sun, 29 Apr 2007 00:51:18 -0400
Message-ID: <1177822376123-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
 <11778223401417-git-send-email-len.brown@intel.com>
 <11778223411658-git-send-email-len.brown@intel.com>
 <11778223412672-git-send-email-len.brown@intel.com>
 <11778223423-git-send-email-len.brown@intel.com>
 <1177822343712-git-send-email-len.brown@intel.com>
 <11778223442065-git-send-email-len.brown@intel.com>
 <11778223452843-git-send-email-len.brown@intel.com>
 <11778223461282-git-send-email-len.brown@intel.com>
 <11778223472316-git-send-email-len.brown@intel.com>
 <1177822347845-git-send-email-len.brown@intel.com>
 <1177822348546-git-send-email-len.brown@intel.com>
 <11778223493327-git-send-email-len.brown@intel.com>
 <11778223502745-git-send-email-len.brown@intel.com>
 <11778223512990-git-send-email-len.brown@intel.com>
 <1177822352591-git-send-email-len.brown@intel.com>
 <11778223532461-git-send-email-len.brown@intel.com>
 <11778223544100-git-send-email-len.brown@intel.com>
 <11778223553521-git-send-email-len.brown@intel.com>
 <11778223551720-git-send-email-len.brown@intel.com>
 <11778223562656-git-send-email-len.brown@intel.com>
 <11778223571390-git-send-email-len.brown@intel.com>
 <11778223581484-git-send-email-len.brown@intel.com>
 <11778223593048-git-send-email-len.brown@intel.com>
 <11778223602019-git-send-email-len.brown@intel.com>
 <11778223612093-git-send-email-len.brown@intel.com>
 <117782236226-git-send-email-len.brown@intel.com>
 <11778223624095-git-send-email-len.brown@intel.com>
 <11778223633408-git-send-email-len.brown@intel.com>
 <1177822364262-git-send-email-len.brown@intel.com>
 <11778223653391-git-send-email-len.brown@intel.com>
 <11778223663850-git-send-email-len.brown@intel.com>
 <11778223673988-git-send-email-len.brown@intel.com>
 <1177822368767-git-send-email-len.brown@intel.com>
 <1177822368793-git-send-email-len.brown@intel.com>
 <11778223692377-git-send-email-len.brown@intel.com>
 <1177822370442-git-send-email-len.brown@intel.com>
 <1177822371935-git-send-email-len.brown@intel.com>
 <11778223721984-git-send-email-len.brown@intel.com>
 <11778223732286-git-send-email-len.brown@intel.com>
 <11778223733679-git-send-email-len.brown@intel.com>
 <11778223741-git-send-email-len.brown@intel.com>
 <11778223752175-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42357 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756177AbXD2Ew7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:59 -0400
In-Reply-To: <11778223752175-git-send-email-len.brown@intel.com>
Message-Id: <a0bd4ac498acfe60f7533d15ba60d5efdd4e9ca5.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

No need to duplicate the existing definitions in include/acpi/actypes.h.

syntax only -- no functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpi_memhotplug.c |   13 ++++---------
 drivers/acpi/container.c       |    6 ++----
 drivers/acpi/processor_core.c  |    4 +---
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index c261726..e65628a 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -44,11 +44,6 @@ MODULE_AUTHOR("Naveen B S <naveen.b.s@intel.com>");
 MODULE_DESCRIPTION("Hotplug Mem Driver");
 MODULE_LICENSE("GPL");
 
-/* ACPI _STA method values */
-#define ACPI_MEMORY_STA_PRESENT		(0x00000001UL)
-#define ACPI_MEMORY_STA_ENABLED		(0x00000002UL)
-#define ACPI_MEMORY_STA_FUNCTIONAL	(0x00000008UL)
-
 /* Memory Device States */
 #define MEMORY_INVALID_STATE	0
 #define MEMORY_POWER_ON_STATE	1
@@ -204,9 +199,9 @@ static int acpi_memory_check_device(struct acpi_memory_device *mem_device)
 	 * Check for device status. Device should be
 	 * present/enabled/functioning.
 	 */
-	if (!((current_status & ACPI_MEMORY_STA_PRESENT)
-	      && (current_status & ACPI_MEMORY_STA_ENABLED)
-	      && (current_status & ACPI_MEMORY_STA_FUNCTIONAL)))
+	if (!((current_status & ACPI_STA_DEVICE_PRESENT)
+	      && (current_status & ACPI_STA_DEVICE_ENABLED)
+	      && (current_status & ACPI_STA_DEVICE_FUNCTIONING)))
 		return -ENODEV;
 
 	return 0;
@@ -286,7 +281,7 @@ static int acpi_memory_powerdown_device(struct acpi_memory_device *mem_device)
 		return -ENODEV;
 
 	/* Check for device status.  Device should be disabled */
-	if (current_status & ACPI_MEMORY_STA_ENABLED)
+	if (current_status & ACPI_STA_DEVICE_ENABLED)
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 0930d94..0dd3bf7 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -49,8 +49,6 @@ MODULE_AUTHOR("Anil S Keshavamurthy");
 MODULE_DESCRIPTION("ACPI container driver");
 MODULE_LICENSE("GPL");
 
-#define ACPI_STA_PRESENT		(0x00000001)
-
 static int acpi_container_add(struct acpi_device *device);
 static int acpi_container_remove(struct acpi_device *device, int type);
 
@@ -75,13 +73,13 @@ static int is_device_present(acpi_handle handle)
 
 	status = acpi_get_handle(handle, "_STA", &temp);
 	if (ACPI_FAILURE(status))
-		return 1;	/* _STA not found, assmue device present */
+		return 1;	/* _STA not found, assume device present */
 
 	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
 	if (ACPI_FAILURE(status))
 		return 0;	/* Firmware error */
 
-	return ((sta & ACPI_STA_PRESENT) == ACPI_STA_PRESENT);
+	return ((sta & ACPI_STA_DEVICE_PRESENT) == ACPI_STA_DEVICE_PRESENT);
 }
 
 /*******************************************************************/
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 99d1516..f7de02a 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -70,8 +70,6 @@
 #define ACPI_PROCESSOR_LIMIT_USER	0
 #define ACPI_PROCESSOR_LIMIT_THERMAL	1
 
-#define ACPI_STA_PRESENT 0x00000001
-
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_core");
 
@@ -779,7 +777,7 @@ static int is_processor_present(acpi_handle handle)
 
 
 	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
-	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_PRESENT)) {
+	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Processor Device is not present"));
 		return 0;
 	}
-- 
1.5.2.rc0.34.gda94
