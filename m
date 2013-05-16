From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH 1/2] ACPI/APEI: Add parameter check before error injection
Date: Wed, 15 May 2013 22:29:06 -0400
Message-ID: <1368671347-22415-2-git-send-email-gong.chen@linux.intel.com>
References: <1368671347-22415-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11576 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753392Ab3EPCf2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 May 2013 22:35:28 -0400
In-Reply-To: <1368671347-22415-1-git-send-email-gong.chen@linux.intel.com>
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
from trigger table resources, but uncorrected param1/param2
combination will stop this action. Add extra check to avoid
happening this error.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/apei/einj.c |   29 +++++++++++++++++++++++++----
 kernel/resource.c        |    1 +
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 8d457b5..015546e 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -32,6 +32,7 @@
 #include <linux/seq_file.h>
 #include <linux/nmi.h>
 #include <linux/delay.h>
+#include <linux/mm.h>
 #include <acpi/acpi.h>
 
 #include "apei-internal.h"
@@ -511,11 +512,31 @@ static int __einj_error_inject(u32 type, u64 param1, u64 param2)
 /* Inject the specified hardware error */
 static int einj_error_inject(u32 type, u64 param1, u64 param2)
 {
-	int rc;
+	int rc = 0;
+	unsigned long pfn;
+	bool checkparam = false;
+	u64 param2_mask = 0xfffffffffffff000;
 
-	mutex_lock(&einj_mutex);
-	rc = __einj_error_inject(type, param1, param2);
-	mutex_unlock(&einj_mutex);
+	/* ensure param1/param2 existed & injection is memory related */
+	if (param_extension || acpi5) {
+		if (type & 0x80000000) {
+			if (vendor_flags == SETWA_FLAGS_MEM)
+				checkparam = true;
+		} else if (type & 0x38)
+			checkparam = true;
+	}
+	if (checkparam) {
+		pfn = PFN_DOWN(param1 & param2);
+		if (!page_is_ram(pfn) ||
+			((param2 & param2_mask) != param2_mask))
+			rc = -EINVAL;
+	}
+
+	if (rc == 0) {
+		mutex_lock(&einj_mutex);
+		rc = __einj_error_inject(type, param1, param2);
+		mutex_unlock(&einj_mutex);
+	}
 
 	return rc;
 }
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

