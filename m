From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 1/3] pmem: clarify a debug print in pmem_clear_poison
Date: Mon, 18 Jul 2016 18:44:58 -0600
Message-ID: <1468889100-30698-2-git-send-email-vishal.l.verma@intel.com>
References: <1468889100-30698-1-git-send-email-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:14446 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbcGSApg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Jul 2016 20:45:36 -0400
In-Reply-To: <1468889100-30698-1-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>

Prefix the sector number being cleared with a '0x' to make it clear that
this is a hex value.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/nvdimm/pmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 608fc44..29ab25b 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -57,7 +57,7 @@ static void pmem_clear_poison(struct pmem_device *pmem, phys_addr_t offset,
 	cleared = nvdimm_clear_poison(dev, pmem->phys_addr + offset, len);
 
 	if (cleared > 0 && cleared / 512) {
-		dev_dbg(dev, "%s: %llx clear %ld sector%s\n",
+		dev_dbg(dev, "%s: 0x%llx clear %ld sector%s\n",
 				__func__, (unsigned long long) sector,
 				cleared / 512, cleared / 512 > 1 ? "s" : "");
 		badblocks_clear(&pmem->bb, sector, cleared / 512);
-- 
2.7.4

