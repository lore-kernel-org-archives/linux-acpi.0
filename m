From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 2/3] libnvdimm, pmem: fix kmap_atomic() leak in error path
Date: Tue, 08 Mar 2016 14:47:23 -0800
Message-ID: <20160308224723.16298.74334.stgit@dwillia2-desk3.jf.intel.com>
References: <20160308224713.16298.33547.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20160308224713.16298.33547.stgit@dwillia2-desk3.jf.intel.com>
Sender: stable-owner@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, Ross Zwisler <ross.zwisler@linux.intel.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

When we enounter a bad block we need to kunmap_atomic() before
returning.

Cc: <stable@vger.kernel.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/pmem.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index efc2a5e671c6..e7b86a7fca0a 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -66,22 +66,25 @@ static int pmem_do_bvec(struct pmem_device *pmem, struct page *page,
 			unsigned int len, unsigned int off, int rw,
 			sector_t sector)
 {
+	int rc = 0;
 	void *mem = kmap_atomic(page);
 	phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
 	void __pmem *pmem_addr = pmem->virt_addr + pmem_off;
 
 	if (rw == READ) {
 		if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
-			return -EIO;
-		memcpy_from_pmem(mem + off, pmem_addr, len);
-		flush_dcache_page(page);
+			rc = -EIO;
+		else {
+			memcpy_from_pmem(mem + off, pmem_addr, len);
+			flush_dcache_page(page);
+		}
 	} else {
 		flush_dcache_page(page);
 		memcpy_to_pmem(pmem_addr, mem + off, len);
 	}
 
 	kunmap_atomic(mem);
-	return 0;
+	return rc;
 }
 
 static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
