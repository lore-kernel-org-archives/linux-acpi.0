From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 11/25] coresight: stm: Cleanup device specific data
Date: Wed, 20 Mar 2019 18:49:28 +0000
Message-ID: <1553107783-3340-12-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: linux-acpi@vger.kernel.org

Keep track of the STM coresight device which is a child device
of the AMBA device. Since we can get to the coresight_device
from the "device" instance, remove the explicit field.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-stm.c | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 9f8a844..6afe033 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -110,9 +110,9 @@ struct channel_space {
 /**
  * struct stm_drvdata - specifics associated to an STM component
  * @base:		memory mapped base address for this component.
- * @dev:		the device entity associated to this component.
+ * @dev:		the coresight device entity associated to this
+ *			component.
  * @atclk:		optional clock for the core parts of the STM.
- * @csdev:		component vitals needed by the framework.
  * @spinlock:		only one at a time pls.
  * @chs:		the channels accociated to this STM.
  * @stm:		structure associated to the generic STM interface.
@@ -130,7 +130,6 @@ struct stm_drvdata {
 	void __iomem		*base;
 	struct device		*dev;
 	struct clk		*atclk;
-	struct coresight_device	*csdev;
 	spinlock_t		spinlock;
 	struct channel_space	chs;
 	struct stm_data		stm;
@@ -205,7 +204,7 @@ static int stm_enable(struct coresight_device *csdev,
 	if (val)
 		return -EBUSY;
 
-	pm_runtime_get_sync(drvdata->dev);
+	pm_runtime_get_sync(drvdata->dev->parent);
 
 	spin_lock(&drvdata->spinlock);
 	stm_enable_hw(drvdata);
@@ -271,7 +270,7 @@ static void stm_disable(struct coresight_device *csdev,
 		/* Wait until the engine has completely stopped */
 		coresight_timeout(drvdata->base, STMTCSR, STMTCSR_BUSY_BIT, 0);
 
-		pm_runtime_put(drvdata->dev);
+		pm_runtime_put(drvdata->dev->parent);
 
 		local_set(&drvdata->mode, CS_MODE_DISABLED);
 		dev_dbg(drvdata->dev, "STM tracing disabled\n");
@@ -336,10 +335,10 @@ static int stm_generic_link(struct stm_data *stm_data,
 {
 	struct stm_drvdata *drvdata = container_of(stm_data,
 						   struct stm_drvdata, stm);
-	if (!drvdata || !drvdata->csdev)
+	if (!drvdata || !drvdata->dev)
 		return -EINVAL;
 
-	return coresight_enable(drvdata->csdev);
+	return coresight_enable(to_coresight_device(drvdata->dev));
 }
 
 static void stm_generic_unlink(struct stm_data *stm_data,
@@ -347,10 +346,10 @@ static void stm_generic_unlink(struct stm_data *stm_data,
 {
 	struct stm_drvdata *drvdata = container_of(stm_data,
 						   struct stm_drvdata, stm);
-	if (!drvdata || !drvdata->csdev)
+	if (!drvdata || !drvdata->dev)
 		return;
 
-	coresight_disable(drvdata->csdev);
+	coresight_disable(to_coresight_device(drvdata->dev));
 }
 
 static phys_addr_t
@@ -763,10 +762,9 @@ static void stm_init_default_data(struct stm_drvdata *drvdata)
 	bitmap_clear(drvdata->chs.guaranteed, 0, drvdata->numsp);
 }
 
-static void stm_init_generic_data(struct stm_drvdata *drvdata)
+static void stm_init_generic_data(struct stm_drvdata *drvdata, const char *name)
 {
-	drvdata->stm.name = dev_name(drvdata->dev);
-
+	drvdata->stm.name = name;
 	/*
 	 * MasterIDs are assigned at HW design phase. As such the core is
 	 * using a single master for interaction with this device.
@@ -795,6 +793,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	struct resource ch_res;
 	size_t bitmap_size;
 	struct coresight_desc desc = { 0 };
+	struct coresight_device *csdev;
 	struct device_node *np = adev->dev.of_node;
 
 	if (np) {
@@ -807,7 +806,6 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->dev = &adev->dev;
 	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
@@ -848,7 +846,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	spin_lock_init(&drvdata->spinlock);
 
 	stm_init_default_data(drvdata);
-	stm_init_generic_data(drvdata);
+	stm_init_generic_data(drvdata, pdata->name);
 
 	if (stm_register_device(dev, &drvdata->stm, THIS_MODULE)) {
 		dev_info(dev,
@@ -862,15 +860,17 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.pdata = pdata;
 	desc.dev = dev;
 	desc.groups = coresight_stm_groups;
-	drvdata->csdev = coresight_register(&desc);
-	if (IS_ERR(drvdata->csdev)) {
-		ret = PTR_ERR(drvdata->csdev);
+	csdev = coresight_register(&desc);
+	if (IS_ERR(csdev)) {
+		ret = PTR_ERR(csdev);
 		goto stm_unregister;
 	}
 
+	drvdata->dev = &csdev->dev;
 	pm_runtime_put(&adev->dev);
 
-	dev_info(dev, "%s initialized\n", (char *)coresight_get_uci_data(id));
+	dev_info(drvdata->dev, "%s initialized\n",
+			(char *)coresight_get_uci_data(id));
 	return 0;
 
 stm_unregister:
-- 
2.7.4
