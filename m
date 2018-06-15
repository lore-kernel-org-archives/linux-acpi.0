From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] acpi,
 nfit: Prefer _DSM over _LSR for namespace label reads
Date: Thu, 14 Jun 2018 17:37:25 -0700
Message-ID: <152902304504.10541.15111766266820956936.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152902303439.10541.13027910074116606464.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <152902303439.10541.13027910074116606464.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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

The _LSR method indicates locked status via error-code-3 returned in the
_LSR payload. When any error is returned the payload of _LSR is
truncated to a zero-length buffer.

The _DSM path in comparison allows system software to retrieve the
locked status *and* namespace label area contents.

Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/acpi/nfit/core.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index e2235ed3e4be..5ce3b0221073 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1694,7 +1694,7 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 {
 	struct acpi_device *adev, *adev_dimm;
 	struct device *dev = acpi_desc->dev;
-	unsigned long dsm_mask;
+	unsigned long dsm_mask, label_mask;
 	const guid_t *guid;
 	int i;
 	int family = -1;
@@ -1766,6 +1766,16 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 					1ULL << i))
 			set_bit(i, &nfit_mem->dsm_mask);
 
+	/*
+	 * Prefer the NVDIMM_FAMILY_INTEL label read commands if present
+	 * due to their better semantics handling locked capacity.
+	 */
+	label_mask = 1 << ND_CMD_GET_CONFIG_SIZE | 1 << ND_CMD_GET_CONFIG_DATA
+		| 1 << ND_CMD_SET_CONFIG_DATA;
+	if (family == NVDIMM_FAMILY_INTEL
+			&& (dsm_mask & label_mask) == label_mask)
+		return 0;
+
 	if (acpi_nvdimm_has_method(adev_dimm, "_LSI")
 			&& acpi_nvdimm_has_method(adev_dimm, "_LSR")) {
 		dev_dbg(dev, "%s: has _LSR\n", dev_name(&adev_dimm->dev));
