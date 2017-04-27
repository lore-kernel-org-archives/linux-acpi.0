From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] libnvdimm, pmem: fix badblocks notification crash
Date: Thu, 27 Apr 2017 15:10:11 -0700
Message-ID: <149333101097.4714.1923436715100717938.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The nd_pmem_notify() routine is called whenever an ARS
(address-range-scrub) completes to communicate results to the
per-namespace badblocks instances.

When the namespace is in btt mode we crash because we do not allocate a
struct pmem_device instance in that case. Resulting in the following
crash signature:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000030
 IP: nd_pmem_notify+0x30/0xf0 [nd_pmem]
 Call Trace:
  nd_device_notify+0x40/0x50
  child_notify+0x10/0x20
  device_for_each_child+0x50/0x90
  nd_region_notify+0x20/0x30
  nd_device_notify+0x40/0x50
  nvdimm_region_notify+0x27/0x30
  acpi_nfit_scrub+0x341/0x590 [nfit]
  process_one_work+0x197/0x450
  worker_thread+0x4e/0x4a0
  kthread+0x109/0x140

Given that we don't even populate the btt badblocks instance, just
return early and skip the device to region lookup.

This is a simpler version of the original fix by Toshi [1].

[1]: https://patchwork.kernel.org/patch/9700055/

Cc: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reported-by: Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/nvdimm/pmem.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 5b536be5a12e..ee6cd31dafcf 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -388,21 +388,21 @@ static void nd_pmem_shutdown(struct device *dev)
 
 static void nd_pmem_notify(struct device *dev, enum nvdimm_event event)
 {
-	struct pmem_device *pmem = dev_get_drvdata(dev);
-	struct nd_region *nd_region = to_region(pmem);
 	resource_size_t offset = 0, end_trunc = 0;
 	struct nd_namespace_common *ndns;
 	struct nd_namespace_io *nsio;
+	struct nd_region *nd_region;
+	struct pmem_device *pmem;
 	struct resource res;
 
 	if (event != NVDIMM_REVALIDATE_POISON)
 		return;
 
-	if (is_nd_btt(dev)) {
-		struct nd_btt *nd_btt = to_nd_btt(dev);
+	/* no badblocks instance to update in the btt case */
+	if (is_nd_btt(dev))
+		return;
 
-		ndns = nd_btt->ndns;
-	} else if (is_nd_pfn(dev)) {
+	if (is_nd_pfn(dev)) {
 		struct nd_pfn *nd_pfn = to_nd_pfn(dev);
 		struct nd_pfn_sb *pfn_sb = nd_pfn->pfn_sb;
 
@@ -415,6 +415,8 @@ static void nd_pmem_notify(struct device *dev, enum nvdimm_event event)
 	nsio = to_nd_namespace_io(&ndns->dev);
 	res.start = nsio->res.start + offset;
 	res.end = nsio->res.end - end_trunc;
+	pmem = dev_get_drvdata(dev);
+	nd_region = to_region(pmem);
 	nvdimm_badblocks_populate(nd_region, &pmem->bb, &res);
 }
