From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v11 3/5] nfit: disable vendor specific commands
Date: Thu, 28 Apr 2016 19:42:38 -0700
Message-ID: <146189775877.29835.10222495726082344157.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <146189774241.29835.12947278159500915461.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36295 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbcD2Cn2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Apr 2016 22:43:28 -0400
In-Reply-To: <146189774241.29835.12947278159500915461.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com, Jerry Hoemann <jerry.hoemann@hpe.com>

Module option to limit userspace to the publicly defined command set.
For cases where private DIMM commands may be interfering with the
kernel's handling of DIMM state this option can be set to block vendor
specific commands.

Cc: Jerry Hoemann <jerry.hoemann@hpe.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index 710d3a07d178..30801fe3367b 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -45,6 +45,11 @@ module_param(scrub_overflow_abort, uint, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(scrub_overflow_abort,
 		"Number of times we overflow ARS results before abort");
 
+static bool disable_vendor_specific;
+module_param(disable_vendor_specific, bool, S_IRUGO);
+MODULE_PARM_DESC(disable_vendor_specific,
+		"Limit commands to the publicly specified set\n");
+
 static struct workqueue_struct *nfit_wq;
 
 struct nfit_table_prev {
@@ -989,13 +994,17 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 
 	/* limit the supported commands to those that are publicly documented */
 	nfit_mem->family = i;
-	if (nfit_mem->family == NVDIMM_FAMILY_INTEL)
+	if (nfit_mem->family == NVDIMM_FAMILY_INTEL) {
 		dsm_mask = 0x3fe;
-	else if (nfit_mem->family == NVDIMM_FAMILY_HPE1)
+		if (disable_vendor_specific)
+			dsm_mask &= ~(1 << ND_CMD_VENDOR);
+	} else if (nfit_mem->family == NVDIMM_FAMILY_HPE1)
 		dsm_mask = 0x1c3c76;
-	else if (nfit_mem->family == NVDIMM_FAMILY_HPE2)
+	else if (nfit_mem->family == NVDIMM_FAMILY_HPE2) {
 		dsm_mask = 0x1fe;
-	else {
+		if (disable_vendor_specific)
+			dsm_mask &= ~(1 << 8);
+	} else {
 		dev_err(dev, "unknown dimm command family\n");
 		nfit_mem->family = -1;
 		return force_enable_dimms ? 0 : -ENODEV;

