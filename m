From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] acpi, nfit: quiet invalid block-aperture-region warnings
Date: Thu, 29 Jun 2017 13:50:10 -0700
Message-ID: <149876941080.10690.5544516251617645982.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1530 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751626AbdF2U4i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Jun 2017 16:56:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org

This state is already visible by userspace since the BLK region will not
be enabled, and it is otherwise benign as it usually indicates that the
DIMM is not configured.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/region_devs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 282b8991ea83..ab141f8b5140 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -833,7 +833,7 @@ int nd_blk_region_init(struct nd_region *nd_region)
 		return 0;
 
 	if (nd_region->ndr_mappings < 1) {
-		dev_err(dev, "invalid BLK region\n");
+		dev_dbg(dev, "invalid BLK region\n");
 		return -ENXIO;
 	}
 

