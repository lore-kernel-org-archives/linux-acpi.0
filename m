From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/2] libnvdimm, region: fix flush hint detection crash
Date: Mon, 24 Apr 2017 16:49:56 -0700
Message-ID: <149307779612.7155.12969380677038292861.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <149307779085.7155.436029631521340565.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <149307779085.7155.436029631521340565.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In the case where a dimm does not have any associated flush hints the
ndrd->flush_wpq array may be uninitialized leading to crashes with the
following signature:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
 IP: region_visible+0x10f/0x160 [libnvdimm]

 Call Trace:
  internal_create_group+0xbe/0x2f0
  sysfs_create_groups+0x40/0x80
  device_add+0x2d8/0x650
  nd_async_device_register+0x12/0x40 [libnvdimm]
  async_run_entry_fn+0x39/0x170
  process_one_work+0x212/0x6c0
  ? process_one_work+0x197/0x6c0
  worker_thread+0x4e/0x4a0
  kthread+0x10c/0x140
  ? process_one_work+0x6c0/0x6c0
  ? kthread_create_on_node+0x60/0x60
  ret_from_fork+0x31/0x40

Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Fixes: f284a4f23752 ("libnvdimm: introduce nvdimm_flush() and nvdimm_has_flush()")
Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/nvdimm/region_devs.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 8de5a04644a1..24abceda986a 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1000,17 +1000,20 @@ EXPORT_SYMBOL_GPL(nvdimm_flush);
  */
 int nvdimm_has_flush(struct nd_region *nd_region)
 {
-	struct nd_region_data *ndrd = dev_get_drvdata(&nd_region->dev);
 	int i;
 
 	/* no nvdimm == flushing capability unknown */
 	if (nd_region->ndr_mappings == 0)
 		return -ENXIO;
 
-	for (i = 0; i < nd_region->ndr_mappings; i++)
-		/* flush hints present, flushing required */
-		if (ndrd_get_flush_wpq(ndrd, i, 0))
+	for (i = 0; i < nd_region->ndr_mappings; i++) {
+		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
+		struct nvdimm *nvdimm = nd_mapping->nvdimm;
+
+		/* flush hints present / available */
+		if (nvdimm->num_flush)
 			return 1;
+	}
 
 	/*
 	 * The platform defines dimm devices without hints, assume
