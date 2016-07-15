From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 1/2] nfit: fix _FIT evaluation memory leak
Date: Thu, 14 Jul 2016 20:28:57 -0700
Message-ID: <146855333714.573.13934675433503265133.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40657 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbcGODbI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Jul 2016 23:31:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org, Xiao Guangrong <guangrong.xiao@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

acpi_evaluate_object() allocates memory. Free the buffer allocated
during acpi_nfit_add().

Cc: <stable@vger.kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Reported-by: Xiao Guangrong <guangrong.xiao@intel.com>
Reported-by: Haozhong Zhang <haozhong.zhang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index 0497175ee6cb..008dbaaa2b75 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -2414,12 +2414,15 @@ static int acpi_nfit_add(struct acpi_device *adev)
 			acpi_desc->nfit =
 				(struct acpi_nfit_header *)obj->buffer.pointer;
 			sz = obj->buffer.length;
+			rc = acpi_nfit_init(acpi_desc, sz);
 		} else
 			dev_dbg(dev, "%s invalid type %d, ignoring _FIT\n",
 				 __func__, (int) obj->type);
-	}
+		kfree(buf.pointer);
+		acpi_desc->nfit = NULL;
+	} else
+		rc = acpi_nfit_init(acpi_desc, sz);
 
-	rc = acpi_nfit_init(acpi_desc, sz);
 	if (rc) {
 		nvdimm_bus_unregister(acpi_desc->nvdimm_bus);
 		return rc;

