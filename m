From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] acpi-dma: Use ACPI_COMPANION() instead of acpi_bus_get_device()
Date: Fri,  4 Sep 2015 16:12:30 +0300
Message-ID: <1441372350-11630-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17690 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759530AbbIDNMh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Sep 2015 09:12:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmaengine@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-acpi@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Get pointer to the struct acpi_device by using ACPI_COMPANION() macro. This
is more efficient than using ACPI_HANDLE() and acpi_bus_get_device().

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/dma/acpi-dma.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index 5a635646e05c..04257432c482 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -160,10 +160,8 @@ int acpi_dma_controller_register(struct device *dev,
 		return -EINVAL;
 
 	/* Check if the device was enumerated by ACPI */
-	if (!ACPI_HANDLE(dev))
-		return -EINVAL;
-
-	if (acpi_bus_get_device(ACPI_HANDLE(dev), &adev))
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
 		return -EINVAL;
 
 	adma = kzalloc(sizeof(*adma), GFP_KERNEL);
@@ -358,10 +356,11 @@ struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
 	int found;
 
 	/* Check if the device was enumerated by ACPI */
-	if (!dev || !ACPI_HANDLE(dev))
+	if (!dev)
 		return ERR_PTR(-ENODEV);
 
-	if (acpi_bus_get_device(ACPI_HANDLE(dev), &adev))
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
 		return ERR_PTR(-ENODEV);
 
 	memset(&pdata, 0, sizeof(pdata));
-- 
2.5.1

