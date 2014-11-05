From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] ACPI / LPSS: add all LPSS devices to the specific power domain
Date: Wed,  5 Nov 2014 18:34:45 +0200
Message-ID: <1415205288-3356-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1415205288-3356-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:63798 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754343AbaKEQeu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 Nov 2014 11:34:50 -0500
In-Reply-To: <1415205288-3356-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Scott Ashcroft <scott.ashcroft@talk21.com>, Mika Westerberg <mika.westerberg@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Blin, Jerome" <jerome.blin@intel.com>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Currently the LPSS devices are located in the different power domains depends
on LPSS_SAVE_CTX flag. We would like to use the specific power domain for all
LPSS devices.

The LPSS DMA controller has no knobs to control its power state. The specific
power domain implementation will handle this case. The patch does a preparation
for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 53 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 93d1606..f6b71af 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -499,14 +499,15 @@ static void acpi_lpss_set_ltr(struct device *dev, s32 val)
 /**
  * acpi_lpss_save_ctx() - Save the private registers of LPSS device
  * @dev: LPSS device
+ * @pdata: pointer to the private data of the LPSS device
  *
  * Most LPSS devices have private registers which may loose their context when
  * the device is powered down. acpi_lpss_save_ctx() saves those registers into
  * prv_reg_ctx array.
  */
-static void acpi_lpss_save_ctx(struct device *dev)
+static void acpi_lpss_save_ctx(struct device *dev,
+			       struct lpss_private_data *pdata)
 {
-	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
 	unsigned int i;
 
 	for (i = 0; i < LPSS_PRV_REG_COUNT; i++) {
@@ -521,12 +522,13 @@ static void acpi_lpss_save_ctx(struct device *dev)
 /**
  * acpi_lpss_restore_ctx() - Restore the private registers of LPSS device
  * @dev: LPSS device
+ * @pdata: pointer to the private data of the LPSS device
  *
  * Restores the registers that were previously stored with acpi_lpss_save_ctx().
  */
-static void acpi_lpss_restore_ctx(struct device *dev)
+static void acpi_lpss_restore_ctx(struct device *dev,
+				  struct lpss_private_data *pdata)
 {
-	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
 	unsigned int i;
 
 	/*
@@ -549,23 +551,31 @@ static void acpi_lpss_restore_ctx(struct device *dev)
 #ifdef CONFIG_PM_SLEEP
 static int acpi_lpss_suspend_late(struct device *dev)
 {
-	int ret = pm_generic_suspend_late(dev);
+	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
+	int ret;
 
+	ret = pm_generic_suspend_late(dev);
 	if (ret)
 		return ret;
 
-	acpi_lpss_save_ctx(dev);
+	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
+		acpi_lpss_save_ctx(dev, pdata);
+
 	return acpi_dev_suspend_late(dev);
 }
 
 static int acpi_lpss_resume_early(struct device *dev)
 {
-	int ret = acpi_dev_resume_early(dev);
+	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
+	int ret;
 
+	ret = acpi_dev_resume_early(dev);
 	if (ret)
 		return ret;
 
-	acpi_lpss_restore_ctx(dev);
+	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
+		acpi_lpss_restore_ctx(dev, pdata);
+
 	return pm_generic_resume_early(dev);
 }
 #endif /* CONFIG_PM_SLEEP */
@@ -573,23 +583,31 @@ static int acpi_lpss_resume_early(struct device *dev)
 #ifdef CONFIG_PM_RUNTIME
 static int acpi_lpss_runtime_suspend(struct device *dev)
 {
-	int ret = pm_generic_runtime_suspend(dev);
+	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
+	int ret;
 
+	ret = pm_generic_runtime_suspend(dev);
 	if (ret)
 		return ret;
 
-	acpi_lpss_save_ctx(dev);
+	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
+		acpi_lpss_save_ctx(dev, pdata);
+
 	return acpi_dev_runtime_suspend(dev);
 }
 
 static int acpi_lpss_runtime_resume(struct device *dev)
 {
-	int ret = acpi_dev_runtime_resume(dev);
+	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
+	int ret;
 
+	ret = acpi_dev_runtime_resume(dev);
 	if (ret)
 		return ret;
 
-	acpi_lpss_restore_ctx(dev);
+	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
+		acpi_lpss_restore_ctx(dev, pdata);
+
 	return pm_generic_runtime_resume(dev);
 }
 #endif /* CONFIG_PM_RUNTIME */
@@ -631,22 +649,21 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
 		return 0;
 
 	pdata = acpi_driver_data(adev);
-	if (!pdata || !pdata->mmio_base)
+	if (!pdata)
 		return 0;
 
-	if (pdata->mmio_size < pdata->dev_desc->prv_offset + LPSS_LTR_SIZE) {
+	if (pdata->mmio_base &&
+	    pdata->mmio_size < pdata->dev_desc->prv_offset + LPSS_LTR_SIZE) {
 		dev_err(&pdev->dev, "MMIO size insufficient to access LTR\n");
 		return 0;
 	}
 
 	switch (action) {
 	case BUS_NOTIFY_BOUND_DRIVER:
-		if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
-			pdev->dev.pm_domain = &acpi_lpss_pm_domain;
+		pdev->dev.pm_domain = &acpi_lpss_pm_domain;
 		break;
 	case BUS_NOTIFY_UNBOUND_DRIVER:
-		if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
-			pdev->dev.pm_domain = NULL;
+		pdev->dev.pm_domain = NULL;
 		break;
 	case BUS_NOTIFY_ADD_DEVICE:
 		if (pdata->dev_desc->flags & LPSS_LTR)
-- 
2.1.1

