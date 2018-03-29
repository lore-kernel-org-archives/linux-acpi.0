From: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] acpi/nfit: allow knob to disable ARS being issued at
 kernel boot
Date: Thu, 29 Mar 2018 15:37:25 -0700
Message-ID: <152236304498.35558.9795379174339167399.stgit@djiang5-desk3.ch.intel.com>
References: <152236282506.35558.2067249639136170490.stgit@djiang5-desk3.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <152236282506.35558.2067249639136170490.stgit-Cxk7aZI4ujnJARH06PadV2t3HXsI98Cx0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Adding a kernel module parameter no_start_ars in order to bypass kernel
initiating scrubbing ARS.

Signed-off-by: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/acpi/nfit/core.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 668d040bf108..21b73ff444f4 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -55,6 +55,10 @@ module_param(default_dsm_family, int, S_IRUGO);
 MODULE_PARM_DESC(default_dsm_family,
 		"Try this DSM type first when identifying NVDIMM family");
 
+static int no_start_ars = 0;
+module_param(no_start_ars, int, S_IRUGO);
+MODULE_PARM_DESC(no_start_ars, "Disable kernel from initiate ARS at boot");
+
 LIST_HEAD(acpi_descs);
 DEFINE_MUTEX(acpi_desc_lock);
 
@@ -2959,10 +2963,13 @@ static void acpi_nfit_scrub(struct work_struct *work)
 
 	list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
 		if (nfit_spa->ars_state == NFIT_ARS_STATE_IDLE) {
-			dev_dbg(dev, "range %d set for ARS\n",
-				nfit_spa->spa->range_index);
-			nfit_spa->ars_state = NFIT_ARS_STATE_REQUESTED;
-			ars_needed++;
+			if (!no_start_ars) {
+				dev_dbg(dev, "range %d set for ARS\n",
+					nfit_spa->spa->range_index);
+				nfit_spa->ars_state =
+					NFIT_ARS_STATE_REQUESTED;
+				ars_needed++;
+			}
 		}
 	}
