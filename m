From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH V2] ACPI, APEI: Cleanup alignment related codes for APEI
Date: Sun, 10 Nov 2013 21:07:46 -0500
Message-ID: <1384135666-1929-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:27945 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568Ab3KKCYC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Nov 2013 21:24:02 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de
Cc: linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>

We ever used *memcpy* to avoid access alignment issue between
firmware and OS. Now we can use a better and standard way
to avoid this issue. In the meanwhile, simplify some variable names
to avoid the limit of 80 characters per line and use structure
assignment instead of unnecessary memcpy. No functional changes.

v2->v1: Make description information clearer.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/apei/apei-base.c |  4 ++--
 drivers/acpi/apei/einj.c      | 19 +++++++++----------
 drivers/acpi/apei/erst.c      |  2 +-
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 46f80e2..c481adf 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -41,6 +41,7 @@
 #include <linux/rculist.h>
 #include <linux/interrupt.h>
 #include <linux/debugfs.h>
+#include <asm/unaligned.h>
 
 #include "apei-internal.h"
 
@@ -567,8 +568,7 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
 	bit_offset = reg->bit_offset;
 	access_size_code = reg->access_width;
 	space_id = reg->space_id;
-	/* Handle possible alignment issues */
-	memcpy(paddr, &reg->address, sizeof(*paddr));
+	paddr = get_unaligned(&reg->address);
 	if (!*paddr) {
 		pr_warning(FW_BUG APEI_PFX
 			   "Invalid physical address in GAR [0x%llx/%u/%u/%u/%u]\n",
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index fb57d03..361177a 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -34,6 +34,7 @@
 #include <linux/delay.h>
 #include <linux/mm.h>
 #include <acpi/acpi.h>
+#include <asm/unaligned.h>
 
 #include "apei-internal.h"
 
@@ -216,7 +217,7 @@ static void check_vendor_extension(u64 paddr,
 static void *einj_get_parameter_address(void)
 {
 	int i;
-	u64 paddrv4 = 0, paddrv5 = 0;
+	u64 pa_v4 = 0, pa_v5 = 0;
 	struct acpi_whea_header *entry;
 
 	entry = EINJ_TAB_ENTRY(einj_tab);
@@ -225,30 +226,28 @@ static void *einj_get_parameter_address(void)
 		    entry->instruction == ACPI_EINJ_WRITE_REGISTER &&
 		    entry->register_region.space_id ==
 		    ACPI_ADR_SPACE_SYSTEM_MEMORY)
-			memcpy(&paddrv4, &entry->register_region.address,
-			       sizeof(paddrv4));
+			pa_v4 = get_unaligned(&entry->register_region.address);
 		if (entry->action == ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS &&
 		    entry->instruction == ACPI_EINJ_WRITE_REGISTER &&
 		    entry->register_region.space_id ==
 		    ACPI_ADR_SPACE_SYSTEM_MEMORY)
-			memcpy(&paddrv5, &entry->register_region.address,
-			       sizeof(paddrv5));
+			pa_v5 = get_unaligned(&entry->register_region.address);
 		entry++;
 	}
-	if (paddrv5) {
+	if (pa_v5) {
 		struct set_error_type_with_address *v5param;
 
-		v5param = acpi_os_map_memory(paddrv5, sizeof(*v5param));
+		v5param = acpi_os_map_memory(pa_v5, sizeof(*v5param));
 		if (v5param) {
 			acpi5 = 1;
-			check_vendor_extension(paddrv5, v5param);
+			check_vendor_extension(pa_v5, v5param);
 			return v5param;
 		}
 	}
-	if (param_extension && paddrv4) {
+	if (param_extension && pa_v4) {
 		struct einj_parameter *v4param;
 
-		v4param = acpi_os_map_memory(paddrv4, sizeof(*v4param));
+		v4param = acpi_os_map_memory(pa_v4, sizeof(*v4param));
 		if (!v4param)
 			return NULL;
 		if (v4param->reserved1 || v4param->reserved2) {
diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 26311f2..bf30a12 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -611,7 +611,7 @@ static void __erst_record_id_cache_compact(void)
 		if (entries[i] == APEI_ERST_INVALID_RECORD_ID)
 			continue;
 		if (wpos != i)
-			memcpy(&entries[wpos], &entries[i], sizeof(entries[i]));
+			entries[wpos] = entries[i];
 		wpos++;
 	}
 	erst_record_id_cache.len = wpos;
-- 
1.8.4.rc3

