From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] acpi, nfit: fix health event notification
Date: Thu, 30 Nov 2017 17:55:03 -0800
Message-ID: <151209330313.2584.7295902868393348172.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64745 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751500AbdLACDS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Nov 2017 21:03:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, Daniel Osawa <daniel.k.osawa@intel.com>, stable@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>, linux-acpi@vger.kernel.org

Integration testing with a BIOS that generates injected health event
notifications fails to communicate those events to userspace. The nfit
driver neglects to link the ACPI DIMM device with the necessary driver
data so acpi_nvdimm_notify() fails this lookup:

        nfit_mem = dev_get_drvdata(dev);
        if (nfit_mem && nfit_mem->flags_attr)
                sysfs_notify_dirent(nfit_mem->flags_attr);

Add the necessary linkage when installing the notification handler and
clean it up when the nfit driver instance is torn down.

Cc: <stable@vger.kernel.org>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Fixes: ba9c8dd3c222 ("acpi, nfit: add dimm device notification support")
Reported-by: Daniel Osawa <daniel.k.osawa@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index ff2580e7611d..947ea8a92761 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1670,6 +1670,11 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 				dev_name(&adev_dimm->dev));
 		return -ENXIO;
 	}
+	/*
+	 * Record nfit_mem for the notification path to track back to
+	 * the nfit sysfs attributes for this dimm device object.
+	 */
+	dev_set_drvdata(&adev_dimm->dev, nfit_mem);
 
 	/*
 	 * Until standardization materializes we need to consider 4
@@ -1755,6 +1760,7 @@ static void shutdown_dimm_notify(void *data)
 		if (adev_dimm)
 			acpi_remove_notify_handler(adev_dimm->handle,
 					ACPI_DEVICE_NOTIFY, acpi_nvdimm_notify);
+		dev_set_drvdata(&adev_dimm->dev, NULL);
 	}
 	mutex_unlock(&acpi_desc->init_mutex);
 }

