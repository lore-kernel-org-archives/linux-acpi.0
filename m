From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] ACPI / LPSS: set first resuming device as a 'proxy'
Date: Thu, 15 Jan 2015 13:10:44 +0200
Message-ID: <1421320244-3490-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:6157 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbbAOLKo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Jan 2015 06:10:44 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

We can't rely on the first enumerated device since it might be not probed yet
when DMA driver wants to resume the device. This patch changes the place where
we assign the 'proxy' device. From now on the first resumed device will be
recognized as a 'proxy' because it is probed.

Reported-by: Jerome Blin <jerome.blin@intel.com>
Fixes: 6c17ee44d524 (ACPI / LPSS: introduce a 'proxy' device to power on LPSS for DMA)
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 4f3febf..d851290 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -374,8 +374,6 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 	adev->driver_data = pdata;
 	pdev = acpi_create_platform_device(adev);
 	if (!IS_ERR_OR_NULL(pdev)) {
-		if (!proxy_device && dev_desc->flags & LPSS_DEV_PROXY)
-			proxy_device = &pdev->dev;
 		return 1;
 	}
 
@@ -615,10 +613,17 @@ static int acpi_lpss_runtime_resume(struct device *dev)
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
 	int ret;
 
-	if (pdata->dev_desc->flags & LPSS_PROXY_REQ && proxy_device) {
-		ret = pm_runtime_get_sync(proxy_device);
-		if (ret)
-			return ret;
+	if (!proxy_device && pdata->dev_desc->flags & LPSS_DEV_PROXY)
+		proxy_device = dev;
+
+	if (pdata->dev_desc->flags & LPSS_PROXY_REQ) {
+		if (proxy_device) {
+			ret = pm_runtime_get_sync(proxy_device);
+			if (ret)
+				return ret;
+		} else {
+			return -EPROBE_DEFER;
+		}
 	}
 
 	ret = acpi_dev_runtime_resume(dev);
-- 
2.1.4

