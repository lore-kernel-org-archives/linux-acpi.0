From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 09/17] libnvdimm, pmem: fix up max_hw_sectors
Date: Thu, 25 Jun 2015 05:37:06 -0400
Message-ID: <20150625093706.40066.60886.stgit@dwillia2-desk3.jf.intel.com>
References: <20150625090554.40066.69562.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35552 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbbFYJmu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Jun 2015 05:42:50 -0400
In-Reply-To: <20150625090554.40066.69562.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: axboe@kernel.dk, boaz@plexistor.com, toshi.kani@hp.com, Vishal Verma <vishal.l.verma@linux.intel.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, linux-acpi@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de

There is no hardware limit to enforce on the size of the i/o that can be passed
to an nvdimm block device, so set it to UINT_MAX.

Reviewed-by: Vishal Verma <vishal.l.verma@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/pmem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 7346054bccbb..d29a42adb95a 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -167,7 +167,7 @@ static int pmem_attach_disk(struct nd_namespace_common *ndns,
 		return -ENOMEM;
 
 	blk_queue_make_request(pmem->pmem_queue, pmem_make_request);
-	blk_queue_max_hw_sectors(pmem->pmem_queue, 1024);
+	blk_queue_max_hw_sectors(pmem->pmem_queue, UINT_MAX);
 	blk_queue_bounce_limit(pmem->pmem_queue, BLK_BOUNCE_ANY);
 
 	disk = alloc_disk(0);

