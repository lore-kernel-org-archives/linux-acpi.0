From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 12/17] fs/dax: remove wmb_pmem()
Date: Sat, 09 Jul 2016 20:25:33 -0700
Message-ID: <146812113311.32932.15565626805360250237.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <146812106839.32932.2870621200867047059.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <146812106839.32932.2870621200867047059.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Cc: linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Flushing posted-write queues is now deferred to REQ_FLUSH context, or
otherwise handled by an ADR event at the platform level.

Cc: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 fs/dax.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 761495bf5eb9..434f421da660 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -147,7 +147,7 @@ static ssize_t dax_io(struct inode *inode, struct iov_iter *iter,
 		      struct buffer_head *bh)
 {
 	loff_t pos = start, max = start, bh_max = start;
-	bool hole = false, need_wmb = false;
+	bool hole = false;
 	struct block_device *bdev = NULL;
 	int rw = iov_iter_rw(iter), rc;
 	long map_len = 0;
@@ -213,7 +213,6 @@ static ssize_t dax_io(struct inode *inode, struct iov_iter *iter,
 
 		if (iov_iter_rw(iter) == WRITE) {
 			len = copy_from_iter_pmem(dax.addr, max - pos, iter);
-			need_wmb = true;
 		} else if (!hole)
 			len = copy_to_iter((void __force *) dax.addr, max - pos,
 					iter);
@@ -230,8 +229,6 @@ static ssize_t dax_io(struct inode *inode, struct iov_iter *iter,
 			dax.addr += len;
 	}
 
-	if (need_wmb)
-		wmb_pmem();
 	dax_unmap_atomic(bdev, &dax);
 
 	return (pos == start) ? rc : pos - start;
@@ -783,7 +780,6 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 				return ret;
 		}
 	}
-	wmb_pmem();
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
@@ -1227,7 +1223,6 @@ int __dax_zero_page_range(struct block_device *bdev, sector_t sector,
 		if (dax_map_atomic(bdev, &dax) < 0)
 			return PTR_ERR(dax.addr);
 		clear_pmem(dax.addr + offset, length);
-		wmb_pmem();
 		dax_unmap_atomic(bdev, &dax);
 	}
 	return 0;
