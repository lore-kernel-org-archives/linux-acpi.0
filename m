From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 1/7] Revert "libnvdimm: band aid btt vs clear poison
 locking"
Date: Fri, 14 Apr 2017 14:57:11 -0700
Message-ID: <149220703105.36563.1290518071230049126.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <149220702552.36563.10552898152402020832.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42501 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752559AbdDNWCz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Apr 2017 18:02:55 -0400
In-Reply-To: <149220702552.36563.10552898152402020832.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org

This reverts commit 4aa5615e080a "libnvdimm: band aid btt vs clear
poison locking".

Now that poison list locking has been converted to a spinlock and poison
list entry allocation during i/o has been converted to GFP_NOWAIT,
revert the band-aid that disabled error clearing from btt i/o.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/claim.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index ca6d572c48fc..b3323c0697f6 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -243,15 +243,7 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 	}
 
 	if (unlikely(is_bad_pmem(&nsio->bb, sector, sz_align))) {
-		/*
-		 * FIXME: nsio_rw_bytes() may be called from atomic
-		 * context in the btt case and nvdimm_clear_poison()
-		 * takes a sleeping lock. Until the locking can be
-		 * reworked this capability requires that the namespace
-		 * is not claimed by btt.
-		 */
-		if (IS_ALIGNED(offset, 512) && IS_ALIGNED(size, 512)
-				&& (!ndns->claim || !is_nd_btt(ndns->claim))) {
+		if (IS_ALIGNED(offset, 512) && IS_ALIGNED(size, 512)) {
 			long cleared;
 
 			cleared = nvdimm_clear_poison(&ndns->dev, offset, size);

