From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 10/17] pmem: make_request cleanups
Date: Thu, 25 Jun 2015 05:37:11 -0400
Message-ID: <20150625093711.40066.20740.stgit@dwillia2-desk3.jf.intel.com>
References: <20150625090554.40066.69562.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26332 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbbFYJm4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Jun 2015 05:42:56 -0400
In-Reply-To: <20150625090554.40066.69562.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: axboe@kernel.dk, boaz@plexistor.com, toshi.kani@hp.com, Vishal Verma <vishal.l.verma@linux.intel.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, linux-acpi@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de

Various cleanups:

1/ Kill the BUG_ON since we've already told the block layer we don't
   support DISCARD on all these drivers.

2/ Kill the 'rw' variable, no need to cache it.

3/ Kill the local 'sector' variable.  bio_for_each_segment() is already
   advancing the iterator's sector number by the bio_vec length.

4/ Kill the check for accessing past the end of device
   generic_make_request_checks() already does that.

Suggested-by: Christoph Hellwig <hch@lst.de>
[hch: kill access past end of the device check]
Reviewed-by: Vishal Verma <vishal.l.verma@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/pmem.c |   26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index d29a42adb95a..e846a627ebdf 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -58,31 +58,15 @@ static void pmem_do_bvec(struct pmem_device *pmem, struct page *page,
 
 static void pmem_make_request(struct request_queue *q, struct bio *bio)
 {
-	struct block_device *bdev = bio->bi_bdev;
-	struct pmem_device *pmem = bdev->bd_disk->private_data;
-	int rw;
 	struct bio_vec bvec;
-	sector_t sector;
 	struct bvec_iter iter;
-	int err = 0;
-
-	if (bio_end_sector(bio) > get_capacity(bdev->bd_disk)) {
-		err = -EIO;
-		goto out;
-	}
-
-	BUG_ON(bio->bi_rw & REQ_DISCARD);
+	struct block_device *bdev = bio->bi_bdev;
+	struct pmem_device *pmem = bdev->bd_disk->private_data;
 
-	rw = bio_data_dir(bio);
-	sector = bio->bi_iter.bi_sector;
-	bio_for_each_segment(bvec, bio, iter) {
+	bio_for_each_segment(bvec, bio, iter)
 		pmem_do_bvec(pmem, bvec.bv_page, bvec.bv_len, bvec.bv_offset,
-			     rw, sector);
-		sector += bvec.bv_len >> 9;
-	}
-
-out:
-	bio_endio(bio, err);
+				bio_data_dir(bio), iter.bi_sector);
+	bio_endio(bio, 0);
 }
 
 static int pmem_rw_page(struct block_device *bdev, sector_t sector,

