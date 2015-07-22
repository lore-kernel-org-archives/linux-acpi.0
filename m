From: Linda Knippers <linda.knippers@hp.com>
Subject: [PATCH] nfit: Don't check _STA on NVDIMM devices
Date: Wed, 22 Jul 2015 16:17:22 -0400
Message-ID: <20150722201721.GB7401@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:53295 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbbGVURw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jul 2015 16:17:52 -0400
Received: from g1t5425.austin.hp.com (g1t5425.austin.hp.com [15.216.225.55])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hp.com (Postfix) with ESMTPS id 6230C66EC3
	for <linux-acpi@vger.kernel.org>; Wed, 22 Jul 2015 20:17:52 +0000 (UTC)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dan.j.williams@intel.com, rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-nvdimm@ml01.01.org, linux-acpi@vger.kernel.org


The _STA only applies to the root device, not the individual NVDIMMS,
so don't check here. NVDIMM device state flags are checked elsewhere.

Signed-off-by: Linda Knippers <linda.knippers@hp.com>
---
 drivers/acpi/nfit.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index 628a42c..eec3e8f 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -764,9 +764,7 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 	struct acpi_device *adev, *adev_dimm;
 	struct device *dev = acpi_desc->dev;
 	const u8 *uuid = to_nfit_uuid(NFIT_DEV_DIMM);
-	unsigned long long sta;
-	int i, rc = -ENODEV;
-	acpi_status status;
+	int i;
 
 	nfit_mem->dsm_mask = acpi_desc->dimm_dsm_force_en;
 	adev = to_acpi_dev(acpi_desc);
@@ -781,25 +779,11 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 		return force_enable_dimms ? 0 : -ENODEV;
 	}
 
-	status = acpi_evaluate_integer(adev_dimm->handle, "_STA", NULL, &sta);
-	if (status == AE_NOT_FOUND) {
-		dev_dbg(dev, "%s missing _STA, assuming enabled...\n",
-				dev_name(&adev_dimm->dev));
-		rc = 0;
-	} else if (ACPI_FAILURE(status))
-		dev_err(dev, "%s failed to retrieve_STA, disabling...\n",
-				dev_name(&adev_dimm->dev));
-	else if ((sta & ACPI_STA_DEVICE_ENABLED) == 0)
-		dev_info(dev, "%s disabled by firmware\n",
-				dev_name(&adev_dimm->dev));
-	else
-		rc = 0;
-
 	for (i = ND_CMD_SMART; i <= ND_CMD_VENDOR; i++)
 		if (acpi_check_dsm(adev_dimm->handle, uuid, 1, 1ULL << i))
 			set_bit(i, &nfit_mem->dsm_mask);
 
-	return force_enable_dimms ? 0 : rc;
+	return 0;
 }
 
 static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
-- 
1.8.3.1

