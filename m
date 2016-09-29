From: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] pmem: reduce kmap_atomic sections to the memcpys only
Date: Wed, 28 Sep 2016 18:10:10 -0600
Message-ID: <1475107811-8880-3-git-send-email-vishal.l.verma@intel.com>
References: <1475107811-8880-1-git-send-email-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <1475107811-8880-1-git-send-email-vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

pmem_do_bvec used to kmap_atomic at the begin, and only unmap at the
end. Things like nvdimm_clear_poison may want to do nvdimm subsystem
bookkeeping operations that may involve taking locks or doing memory
allocations, and we can't do that from the atomic context. Reduce the
atomic context to just what needs it - the memcpy to/from pmem.

Cc: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/nvdimm/pmem.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 571a6c7..ca038d8 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -66,13 +66,32 @@ static void pmem_clear_poison(struct pmem_device *pmem, phys_addr_t offset,
 	invalidate_pmem(pmem->virt_addr + offset, len);
 }
 
+static void map_and_copy_to_pmem(void *pmem_addr, struct page *page,
+		unsigned int off, unsigned int len)
+{
+	void *mem = kmap_atomic(page);
+
+	memcpy_to_pmem(pmem_addr, mem + off, len);
+	kunmap_atomic(mem);
+}
+
+static int map_and_copy_from_pmem(struct page *page, unsigned int off,
+		void *pmem_addr, unsigned int len)
+{
+	int rc;
+	void *mem = kmap_atomic(page);
+
+	rc = memcpy_from_pmem(mem + off, pmem_addr, len);
+	kunmap_atomic(mem);
+	return rc;
+}
+
 static int pmem_do_bvec(struct pmem_device *pmem, struct page *page,
 			unsigned int len, unsigned int off, bool is_write,
 			sector_t sector)
 {
 	int rc = 0;
 	bool bad_pmem = false;
-	void *mem = kmap_atomic(page);
 	phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
 	void *pmem_addr = pmem->virt_addr + pmem_off;
 
@@ -83,7 +102,7 @@ static int pmem_do_bvec(struct pmem_device *pmem, struct page *page,
 		if (unlikely(bad_pmem))
 			rc = -EIO;
 		else {
-			rc = memcpy_from_pmem(mem + off, pmem_addr, len);
+			rc = map_and_copy_from_pmem(page, off, pmem_addr, len);
 			flush_dcache_page(page);
 		}
 	} else {
@@ -102,14 +121,13 @@ static int pmem_do_bvec(struct pmem_device *pmem, struct page *page,
 		 * after clear poison.
 		 */
 		flush_dcache_page(page);
-		memcpy_to_pmem(pmem_addr, mem + off, len);
+		map_and_copy_to_pmem(pmem_addr, page, off, len);
 		if (unlikely(bad_pmem)) {
 			pmem_clear_poison(pmem, pmem_off, len);
-			memcpy_to_pmem(pmem_addr, mem + off, len);
+			map_and_copy_to_pmem(pmem_addr, page, off, len);
 		}
 	}
 
-	kunmap_atomic(mem);
 	return rc;
 }
 
-- 
2.7.4
