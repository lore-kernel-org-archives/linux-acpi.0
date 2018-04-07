From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] libnvdimm,
 dimm: fix dpa reservation vs uninitialized label area
Date: Sat, 07 Apr 2018 07:50:46 -0700
Message-ID: <152311264681.13507.15332881622190583231.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Krzysztof Rusocki <krzysztof.rusocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

At initialization time the 'dimm' driver caches a copy of the memory
device's label area and reserves address space for each of the
namespaces defined.

However, as can be seen below, the reservation occurs even when the
index blocks are invalid:

 nvdimm nmem0: nvdimm_init_config_data: len: 131072 rc: 0
 nvdimm nmem0: config data size: 131072
 nvdimm nmem0: __nd_label_validate: nsindex0 labelsize 1 invalid
 nvdimm nmem0: __nd_label_validate: nsindex1 labelsize 1 invalid
 nvdimm nmem0: : pmem-6025e505: 0x1000000000 @ 0xf50000000 reserve <-- bad

Gate dpa reservation on the presence of valid index blocks.

Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Fixes: 4a826c83db4e ("libnvdimm: namespace indices: read and validate")
Reported-by: Krzysztof Rusocki <krzysztof.rusocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/nvdimm/dimm.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/dimm.c b/drivers/nvdimm/dimm.c
index f8913b8124b6..233907889f96 100644
--- a/drivers/nvdimm/dimm.c
+++ b/drivers/nvdimm/dimm.c
@@ -67,9 +67,11 @@ static int nvdimm_probe(struct device *dev)
 	ndd->ns_next = nd_label_next_nsindex(ndd->ns_current);
 	nd_label_copy(ndd, to_next_namespace_index(ndd),
 			to_current_namespace_index(ndd));
-	rc = nd_label_reserve_dpa(ndd);
-	if (ndd->ns_current >= 0)
-		nvdimm_set_aliasing(dev);
+	if (ndd->ns_current >= 0) {
+		rc = nd_label_reserve_dpa(ndd);
+		if (rc == 0)
+			nvdimm_set_aliasing(dev);
+	}
 	nvdimm_clear_locked(dev);
 	nvdimm_bus_unlock(dev);
