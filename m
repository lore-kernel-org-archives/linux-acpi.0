From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 5/7] acpi, nfit: collate health state flags
Date: Fri, 14 Apr 2017 14:57:32 -0700
Message-ID: <149220705226.36563.4111247455711201065.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <149220702552.36563.10552898152402020832.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:16981 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752559AbdDNWDR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Apr 2017 18:03:17 -0400
In-Reply-To: <149220702552.36563.10552898152402020832.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org

Be tolerant of cases where the BIOS provided NFIT does not consistently
set the flags in all NVDIMM Region Mapping structures associated with a
given dimm.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 2bd842c46fbb..1d54833ade3f 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -457,9 +457,9 @@ static bool add_memdev(struct acpi_nfit_desc *acpi_desc,
 	INIT_LIST_HEAD(&nfit_memdev->list);
 	memcpy(nfit_memdev->memdev, memdev, sizeof(*memdev));
 	list_add_tail(&nfit_memdev->list, &acpi_desc->memdevs);
-	dev_dbg(dev, "%s: memdev handle: %#x spa: %d dcr: %d\n",
+	dev_dbg(dev, "%s: memdev handle: %#x spa: %d dcr: %d flags: %#x\n",
 			__func__, memdev->device_handle, memdev->range_index,
-			memdev->region_index);
+			memdev->region_index, memdev->flags);
 	return true;
 }
 
@@ -1505,6 +1505,7 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
 	list_for_each_entry(nfit_mem, &acpi_desc->dimms, list) {
 		struct acpi_nfit_flush_address *flush;
 		unsigned long flags = 0, cmd_mask;
+		struct nfit_memdev *nfit_memdev;
 		u32 device_handle;
 		u16 mem_flags;
 
@@ -1518,6 +1519,17 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
 		if (nfit_mem->bdw && nfit_mem->memdev_pmem)
 			flags |= NDD_ALIASING;
 
+		/* collate flags across all memdevs for this dimm */
+		list_for_each_entry(nfit_memdev, &acpi_desc->memdevs, list) {
+			struct acpi_nfit_memory_map *dimm_memdev;
+
+			dimm_memdev = __to_nfit_memdev(nfit_mem);
+			if (dimm_memdev->device_handle
+					!= nfit_memdev->memdev->device_handle)
+				continue;
+			dimm_memdev->flags |= nfit_memdev->memdev->flags;
+		}
+
 		mem_flags = __to_nfit_memdev(nfit_mem)->flags;
 		if (mem_flags & ACPI_NFIT_MEM_NOT_ARMED)
 			flags |= NDD_UNARMED;

