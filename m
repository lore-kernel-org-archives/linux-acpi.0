From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 06/25] coresight: funnel: Clean up device book keeping
Date: Wed, 20 Mar 2019 18:49:23 +0000
Message-ID: <1553107783-3340-7-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>, Mathieu Poirier <mathie.poirier@linaro.org>
List-Id: linux-acpi@vger.kernel.org

In preparation to use a consistent device naming scheme,
clean up the device link tracking in funnel driver.
Use the "coresight" device instead of the "real" parent device
for all internal purposes. All other requests (e.g, power management,
DMA operations) must use the "real" device which is the parent device.

Cc: Mathieu Poirier <mathie.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-funnel.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 9279251..1085f31 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -37,7 +37,6 @@
  */
 struct funnel_drvdata {
 	void __iomem		*base;
-	struct device		*dev;
 	struct clk		*atclk;
 	struct coresight_device	*csdev;
 	unsigned long		priority;
@@ -77,7 +76,7 @@ static int funnel_enable(struct coresight_device *csdev, int inport,
 	rc = funnel_enable_hw(drvdata, inport);
 
 	if (!rc)
-		dev_dbg(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
+		dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n", inport);
 	return rc;
 }
 
@@ -105,7 +104,7 @@ static void funnel_disable(struct coresight_device *csdev, int inport,
 
 	funnel_disable_hw(drvdata, inport);
 
-	dev_dbg(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
+	dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n", inport);
 }
 
 static const struct coresight_ops_link funnel_link_ops = {
@@ -160,11 +159,11 @@ static ssize_t funnel_ctrl_show(struct device *dev,
 	u32 val;
 	struct funnel_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	pm_runtime_get_sync(drvdata->dev);
+	pm_runtime_get_sync(dev->parent);
 
 	val = get_funnel_ctrl_hw(drvdata);
 
-	pm_runtime_put(drvdata->dev);
+	pm_runtime_put(dev->parent);
 
 	return sprintf(buf, "%#x\n", val);
 }
@@ -199,7 +198,6 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->dev = &adev->dev;
 	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
-- 
2.7.4
