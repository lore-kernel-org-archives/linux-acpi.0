From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] libnvdimm, namespace: use a safe lookup for dimm device name
Date: Sat, 07 Apr 2018 07:50:52 -0700
Message-ID: <152311265227.13507.15898106957113137141.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The following NULL dereference results from incorrectly assuming that
ndd is valid in this print:

  struct nvdimm_drvdata *ndd = to_ndd(&nd_region->mapping[i]);

  /*
   * Give up if we don't find an instance of a uuid at each
   * position (from 0 to nd_region->ndr_mappings - 1), or if we
   * find a dimm with two instances of the same uuid.
   */
  dev_err(&nd_region->dev, "%s missing label for %pUb\n",
                  dev_name(ndd->dev), nd_label->uuid);

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
 IP: nd_region_register_namespaces+0xd67/0x13c0 [libnvdimm]
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP PTI
 CPU: 43 PID: 673 Comm: kworker/u609:10 Not tainted 4.16.0-rc4+ #1
 [..]
 RIP: 0010:nd_region_register_namespaces+0xd67/0x13c0 [libnvdimm]
 [..]
 Call Trace:
  ? devres_add+0x2f/0x40
  ? devm_kmalloc+0x52/0x60
  ? nd_region_activate+0x9c/0x320 [libnvdimm]
  nd_region_probe+0x94/0x260 [libnvdimm]
  ? kernfs_add_one+0xe4/0x130
  nvdimm_bus_probe+0x63/0x100 [libnvdimm]

Switch to using the nvdimm device directly.

Fixes: 0e3b0d123c8f ("libnvdimm, namespace: allow multiple pmem...")
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Reported-by: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/nvdimm/namespace_devs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 89b40ff83025..28afdd668905 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1921,7 +1921,7 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 	}
 
 	if (i < nd_region->ndr_mappings) {
-		struct nvdimm_drvdata *ndd = to_ndd(&nd_region->mapping[i]);
+		struct nvdimm *nvdimm = nd_region->mapping[i].nvdimm;
 
 		/*
 		 * Give up if we don't find an instance of a uuid at each
@@ -1929,7 +1929,7 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 		 * find a dimm with two instances of the same uuid.
 		 */
 		dev_err(&nd_region->dev, "%s missing label for %pUb\n",
-				dev_name(ndd->dev), nd_label->uuid);
+				nvdimm_name(nvdimm), nd_label->uuid);
 		rc = -EINVAL;
 		goto err;
 	}
