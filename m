From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH 1/2 V3] ACPI/APEI: Add parameter check before error injection
Date: Wed, 22 May 2013 22:32:02 -0400
Message-ID: <1369276323-31436-2-git-send-email-gong.chen@linux.intel.com>
References: <1369276323-31436-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58050 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756806Ab3EWCiq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 May 2013 22:38:46 -0400
In-Reply-To: <1369276323-31436-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de
Cc: linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

When param1 is enabled in EINJ but not assigned with a valid
value, sometimes it will cause the error like below:

APEI: Can not request [mem 0x7aaa7000-0x7aaa7007] for APEI EINJ Trigger
registers

It is because some firmware will access target address specified in
param1 to trigger the error when injecting memory error. This will
cause resource conflict with regular memory. So It must be removed
from trigger table resources, but incorrect param1/param2
combination will stop this action. Add extra check to avoid
this kind of error.

v3 -> v2: update comments suggested by Tony Luck
v2 -> v1: update redundant logic following the suggestion from Boris

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/apei/einj.c |   44 +++++++++++++++++++++++++++++++++++++++++---
 kernel/resource.c        |    1 +
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 8d457b5..9a47d85 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -32,6 +32,7 @@
 #include <linux/seq_file.h>
 #include <linux/nmi.h>
 #include <linux/delay.h>
+#include <linux/mm.h>
 #include <acpi/acpi.h>
 
 #include "apei-internal.h"
@@ -41,6 +42,10 @@
 #define SPIN_UNIT		100			/* 100ns */
 /* Firmware should respond within 1 milliseconds */
 #define FIRMWARE_TIMEOUT	(1 * NSEC_PER_MSEC)
+#define ACPI5_VENDOR_BIT	BIT(31)
+#define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
+				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
+				ACPI_EINJ_MEMORY_FATAL)
 
 /*
  * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
@@ -367,7 +372,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	 * This will cause resource conflict with regular memory.  So
 	 * remove it from trigger table resources.
 	 */
-	if ((param_extension || acpi5) && (type & 0x0038) && param2) {
+	if ((param_extension || acpi5) && (type & MEM_ERROR_MASK) && param2) {
 		struct apei_resources addr_resources;
 		apei_resources_init(&addr_resources);
 		trigger_param_region = einj_get_trigger_parameter_region(
@@ -427,7 +432,7 @@ static int __einj_error_inject(u32 type, u64 param1, u64 param2)
 		struct set_error_type_with_address *v5param = einj_param;
 
 		v5param->type = type;
-		if (type & 0x80000000) {
+		if (type & ACPI5_VENDOR_BIT) {
 			switch (vendor_flags) {
 			case SETWA_FLAGS_APICID:
 				v5param->apicid = param1;
@@ -509,10 +514,43 @@ static int __einj_error_inject(u32 type, u64 param1, u64 param2)
 }
 
 /* Inject the specified hardware error */
+
+/*
+ * When injection type is memory related, the param1/param2 should
+ * be check carefully. Especially if param2 is non-page-aligned
+ * like 0xf0f0f0f0f0f0f0f0, that must be strictly forbidden.
+ */
 static int einj_error_inject(u32 type, u64 param1, u64 param2)
 {
 	int rc;
+	unsigned long pfn;
+
+	/*
+	 * We need extra sanity checks for memory errors.
+	 * Other types leap directly to injection.
+	 */
+
+	/* ensure param1/param2 existed */
+	if (!(param_extension || acpi5))
+		goto inject;
+
+	/* ensure injection is memory related */
+	if (type & ACPI5_VENDOR_BIT) {
+		if (vendor_flags != SETWA_FLAGS_MEM)
+			goto inject;
+	} else if (!(type & MEM_ERROR_MASK))
+		goto inject;
+
+	/*
+	 * Disallow crazy address masks that give BIOS leeway to pick
+	 * injection address almost anywhere. Insist on page or
+	 * better granularity.
+	 */
+	pfn = PFN_DOWN(param1 & param2);
+	if (!page_is_ram(pfn) || ((param2 & PAGE_MASK) != PAGE_MASK))
+		return -EINVAL;
 
+inject:
 	mutex_lock(&einj_mutex);
 	rc = __einj_error_inject(type, param1, param2);
 	mutex_unlock(&einj_mutex);
@@ -590,7 +628,7 @@ static int error_type_set(void *data, u64 val)
 	 * Vendor defined types have 0x80000000 bit set, and
 	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
 	 */
-	vendor = val & 0x80000000;
+	vendor = val & ACPI5_VENDOR_BIT;
 	tval = val & 0x7fffffff;
 
 	/* Only one error type can be specified */
diff --git a/kernel/resource.c b/kernel/resource.c
index d738698..77bf11a 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -409,6 +409,7 @@ int __weak page_is_ram(unsigned long pfn)
 {
 	return walk_system_ram_range(pfn, 1, NULL, __is_ram) == 1;
 }
+EXPORT_SYMBOL_GPL(page_is_ram);
 
 void __weak arch_remove_reservations(struct resource *avail)
 {
-- 
1.7.10.4

