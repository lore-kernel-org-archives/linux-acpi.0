From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/15] ACPICA: Resources: Allow _DMA method in walk resources
Date: Thu,  3 Aug 2017 14:27:35 +0800
Message-ID: <f7bb382e437d1f57711401fd041d8854aed06d5b.1501730699.git.lv.zheng@intel.com>
References: <cover.1501730699.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:9998 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751247AbdHCG1j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 02:27:39 -0400
In-Reply-To: <cover.1501730699.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit af661c00afac7aa481a961fa48c6540a99ad64a6

The _DMA object contains a resource template, this change
adds support for the walk resources function so that ACPI
devices containing a _DMA object can actually parse it to
detect DMA ranges for the respective bus.

Link: https://github.com/acpica/acpica/commit/af661c00
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/rsxface.c | 7 ++++---
 include/acpi/acnames.h        | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index 59a4f9e..be65e65 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -615,7 +615,7 @@ ACPI_EXPORT_SYMBOL(acpi_walk_resource_buffer)
  *                                device we are querying
  *              name            - Method name of the resources we want.
  *                                (METHOD_NAME__CRS, METHOD_NAME__PRS, or
- *                                METHOD_NAME__AEI)
+ *                                METHOD_NAME__AEI or METHOD_NAME__DMA)
  *              user_function   - Called for each resource
  *              context         - Passed to user_function
  *
@@ -641,11 +641,12 @@ acpi_walk_resources(acpi_handle device_handle,
 	if (!device_handle || !user_function || !name ||
 	    (!ACPI_COMPARE_NAME(name, METHOD_NAME__CRS) &&
 	     !ACPI_COMPARE_NAME(name, METHOD_NAME__PRS) &&
-	     !ACPI_COMPARE_NAME(name, METHOD_NAME__AEI))) {
+	     !ACPI_COMPARE_NAME(name, METHOD_NAME__AEI) &&
+	     !ACPI_COMPARE_NAME(name, METHOD_NAME__DMA))) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Get the _CRS/_PRS/_AEI resource list */
+	/* Get the _CRS/_PRS/_AEI/_DMA resource list */
 
 	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
 	status = acpi_rs_get_method_data(device_handle, name, &buffer);
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index b421584..d8dd3bf 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -54,6 +54,7 @@
 #define METHOD_NAME__CLS        "_CLS"
 #define METHOD_NAME__CRS        "_CRS"
 #define METHOD_NAME__DDN        "_DDN"
+#define METHOD_NAME__DMA        "_DMA"
 #define METHOD_NAME__HID        "_HID"
 #define METHOD_NAME__INI        "_INI"
 #define METHOD_NAME__PLD        "_PLD"
-- 
2.7.4

