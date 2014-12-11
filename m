From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH] ACPI, EINJ: Enhance error injection tolerance level
Date: Wed, 10 Dec 2014 21:14:58 -0500
Message-ID: <1418264098-27397-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:22813 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933176AbaLKCyg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Dec 2014 21:54:36 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de
Cc: linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>, Tony Luck <tony.luck@intel.com>

Some BIOSes utilize PCI MMCFG space read/write opertion to trigger
specific errors. EINJ will report errors as below when hitting such
cases:

APEI: Can not request [mem 0x83f990a0-0x83f990a3] for APEI EINJ Trigger registers

It is because on x86 platform ACPI based PCI MMCFG logic has
reserved all MMCFG spaces so that EINJ can't reserve it again.
We trust EINJ trigger action won't do anything bad so just skip
check on MMCFG space.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/apei/apei-base.c | 58 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 2cd7bdd6c8b3..e809d3c4904d 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -41,6 +41,9 @@
 #include <linux/interrupt.h>
 #include <linux/debugfs.h>
 #include <asm/unaligned.h>
+#ifdef CONFIG_PCI_MMCONFIG
+#include <asm/pci_x86.h>
+#endif
 
 #include "apei-internal.h"
 
@@ -449,7 +452,7 @@ int apei_resources_sub(struct apei_resources *resources1,
 }
 EXPORT_SYMBOL_GPL(apei_resources_sub);
 
-static int apei_get_nvs_callback(__u64 start, __u64 size, void *data)
+static int apei_get_res_callback(__u64 start, __u64 size, void *data)
 {
 	struct apei_resources *resources = data;
 	return apei_res_add(&resources->iomem, start, size);
@@ -457,9 +460,42 @@ static int apei_get_nvs_callback(__u64 start, __u64 size, void *data)
 
 static int apei_get_nvs_resources(struct apei_resources *resources)
 {
-	return acpi_nvs_for_each_region(apei_get_nvs_callback, resources);
+	return acpi_nvs_for_each_region(apei_get_res_callback, resources);
 }
 
+#ifdef CONFIG_PCI_MMCONFIG
+static int pci_mmcfg_for_each_region(int (*func)(__u64 start, __u64 size,
+				     void *data), void *data)
+{
+	struct pci_mmcfg_region *cfg;
+	int rc;
+
+	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
+		return 0;
+
+	if (list_empty(&pci_mmcfg_list))
+		return 0;
+
+	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
+		rc = func(cfg->res.start, resource_size(&cfg->res), data);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int apei_get_mmcfg_resources(struct apei_resources *resources)
+{
+	return pci_mmcfg_for_each_region(apei_get_res_callback, resources);
+}
+#else
+static int apei_get_mmcfg_resources(struct apei_resources *resources)
+{
+	return 0;
+}
+#endif
+
 /*
  * IO memory/port resource management mechanism is used to check
  * whether memory/port area used by GARs conflicts with normal memory
@@ -470,7 +506,7 @@ int apei_resources_request(struct apei_resources *resources,
 {
 	struct apei_res *res, *res_bak = NULL;
 	struct resource *r;
-	struct apei_resources nvs_resources;
+	struct apei_resources nvs_resources, mmcfg_res;
 	int rc;
 
 	rc = apei_resources_sub(resources, &apei_resources_all);
@@ -485,10 +521,18 @@ int apei_resources_request(struct apei_resources *resources,
 	apei_resources_init(&nvs_resources);
 	rc = apei_get_nvs_resources(&nvs_resources);
 	if (rc)
-		goto res_fini;
+		goto nvs_res_fini;
 	rc = apei_resources_sub(resources, &nvs_resources);
 	if (rc)
-		goto res_fini;
+		goto nvs_res_fini;
+
+	apei_resources_init(&mmcfg_res);
+	rc = apei_get_mmcfg_resources(&mmcfg_res);
+	if (rc)
+		goto mmcfg_res_fini;
+	rc = apei_resources_sub(resources, &mmcfg_res);
+	if (rc)
+		goto mmcfg_res_fini;
 
 	rc = -EINVAL;
 	list_for_each_entry(res, &resources->iomem, list) {
@@ -536,7 +580,9 @@ err_unmap_iomem:
 			break;
 		release_mem_region(res->start, res->end - res->start);
 	}
-res_fini:
+mmcfg_res_fini:
+	apei_resources_fini(&mmcfg_res);
+nvs_res_fini:
 	apei_resources_fini(&nvs_resources);
 	return rc;
 }
-- 
2.1.0

