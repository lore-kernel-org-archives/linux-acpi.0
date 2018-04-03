From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/6] nfit,
 address-range-scrub: add module option to skip initial ars
Date: Mon, 02 Apr 2018 21:46:33 -0700
Message-ID: <152273079304.38372.3756477895030033611.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152273076087.38372.4803377088477706610.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <152273076087.38372.4803377088477706610.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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

After attempting to quickly retrieve known errors the kernel proceeds to
kick off a long running ARS. Add a module option to disable this
behavior at initialization time, or at new region discovery time.
Otherwise, ARS can be started manually regardless of the state of this
setting.

Co-developed-by: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/acpi/nfit/core.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 29a033f3455d..848e05b25d7d 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -49,6 +49,10 @@ module_param(default_dsm_family, int, S_IRUGO);
 MODULE_PARM_DESC(default_dsm_family,
 		"Try this DSM type first when identifying NVDIMM family");
 
+static int no_init_ars;
+module_param(no_init_ars, int, 0644);
+MODULE_PARM_DESC(no_init_ars, "Skip ARS run at nfit init time");
+
 LIST_HEAD(acpi_descs);
 DEFINE_MUTEX(acpi_desc_lock);
 
@@ -2868,8 +2872,11 @@ static int init_ars(struct acpi_nfit_desc *acpi_desc, struct nfit_spa *nfit_spa,
 
 	WARN_ON_ONCE(!test_bit(ARS_SHORT, &nfit_spa->ars_state));
 	rc = ars_start(acpi_desc, nfit_spa);
-	if (rc == 0)
+	if (rc == 0) {
 		rc = acpi_nfit_query_poison(acpi_desc, nfit_spa);
+		if (!no_init_ars)
+			set_bit(ARS_REQ, &nfit_spa->ars_state);
+	}
 out:
 	if (acpi_nfit_register_region(acpi_desc, nfit_spa))
 		set_bit(ARS_FAILED, &nfit_spa->ars_state);
