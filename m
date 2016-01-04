From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH] nfit: add a module parameter to ignore ars errors
Date: Mon,  4 Jan 2016 15:34:43 -0700
Message-ID: <1451946883-28092-1-git-send-email-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33291 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752012AbcADWfF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Jan 2016 17:35:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jeff Moyer <jmoyer@redhat.com>, Linda Knippers <linda.knippers@hpe.com>

Normally, if a platform does not advertise support for Address Range
Scrub (ARS), we skip it. But if ARS is advertised, it is expected to
always succeed. If it fails, we normally fail initialization at that
point.

Add a module parameter to nfit that lets it ignore ARS failures and
continue with initialization for debugging.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---

This applies on top of both of the previous error handling series
(badblocks and libnvdimm poison list). The tree at:
https://git.kernel.org/cgit/linux/kernel/git/vishal/nvdimm.git/log/?h=err_handling_latest
has been updated with this patch.

 drivers/acpi/nfit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index ad6d8c6..0a152f1 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -34,6 +34,10 @@ static bool force_enable_dimms;
 module_param(force_enable_dimms, bool, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(force_enable_dimms, "Ignore _STA (ACPI DIMM device) status");
 
+static bool ignore_ars;
+module_param(ignore_ars, bool, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(ignore_ars, "Ignore ARS (Address Range Scrub) failures");
+
 struct nfit_table_prev {
 	struct list_head spas;
 	struct list_head memdevs;
@@ -1786,7 +1790,10 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
 			dev_err(acpi_desc->dev,
 				"error while performing ARS to find poison: %d\n",
 				rc);
-			return rc;
+			if (ignore_ars)
+				; /* continue initialization */
+			else
+				return rc;
 		}
 		if (!nvdimm_pmem_region_create(nvdimm_bus, ndr_desc))
 			return -ENOMEM;
-- 
2.5.0

