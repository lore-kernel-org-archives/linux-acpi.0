From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] libnvdimm, region: quiet region probe
Date: Sat, 07 Apr 2018 07:50:57 -0700
Message-ID: <152311265738.13507.13982862389654638905.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The message about constraining number of online cpus to be less than or
equal to ND_MAX_LANES (256) is only useful for block-aperture
configurations and BTT. Make it debug since its only relevant when
debugging performance.

Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/nvdimm/region.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/region.c b/drivers/nvdimm/region.c
index 034f0a07d627..b9ca0033cc99 100644
--- a/drivers/nvdimm/region.c
+++ b/drivers/nvdimm/region.c
@@ -27,10 +27,10 @@ static int nd_region_probe(struct device *dev)
 	if (nd_region->num_lanes > num_online_cpus()
 			&& nd_region->num_lanes < num_possible_cpus()
 			&& !test_and_set_bit(0, &once)) {
-		dev_info(dev, "online cpus (%d) < concurrent i/o lanes (%d) < possible cpus (%d)\n",
+		dev_dbg(dev, "online cpus (%d) < concurrent i/o lanes (%d) < possible cpus (%d)\n",
 				num_online_cpus(), nd_region->num_lanes,
 				num_possible_cpus());
-		dev_info(dev, "setting nr_cpus=%d may yield better libnvdimm device performance\n",
+		dev_dbg(dev, "setting nr_cpus=%d may yield better libnvdimm device performance\n",
 				nd_region->num_lanes);
 	}
