From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] tools/testing/nvdimm: Fix support for emulating controller
 temperature
Date: Thu, 14 Jun 2018 17:30:23 -0700
Message-ID: <152902262388.10279.6032527372904228835.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In addition to populating the value the payload also needs to set the
"controller temperature valid" flag.

Fixes: cdd77d3e1930 ("nfit, libnvdimm: deprecate the generic SMART ioctl")
Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 tools/testing/nvdimm/test/nfit.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 6f19d6e28f5f..15dc280eb3ae 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1321,7 +1321,8 @@ static void smart_init(struct nfit_test *t)
 			| ND_INTEL_SMART_ALARM_VALID
 			| ND_INTEL_SMART_USED_VALID
 			| ND_INTEL_SMART_SHUTDOWN_VALID
-			| ND_INTEL_SMART_MTEMP_VALID,
+			| ND_INTEL_SMART_MTEMP_VALID
+			| ND_INTEL_SMART_CTEMP_VALID,
 		.health = ND_INTEL_SMART_NON_CRITICAL_HEALTH,
 		.media_temperature = 23 * 16,
 		.ctrl_temperature = 25 * 16,
