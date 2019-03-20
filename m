From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 02/25] coresight: dynamic-replicator: Clean up error handling
Date: Wed, 20 Mar 2019 18:49:19 +0000
Message-ID: <1553107783-3340-3-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: linux-acpi@vger.kernel.org

We fail to disable the clock in case of a failure during the
probe. Clean this up. Also, we are supposed to drop the pm reference
only when the probing is successful.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-dynamic-replicator.c       | 24 ++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index 299667b..fe176b9 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -150,7 +150,7 @@ static const struct attribute_group *replicator_groups[] = {
 
 static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 {
-	int ret;
+	int ret = 0;
 	struct device *dev = &adev->dev;
 	struct resource *res = &adev->res;
 	struct coresight_platform_data *pdata = NULL;
@@ -180,12 +180,13 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 
 	/* Validity for the resource is already checked by the AMBA core */
 	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		goto out_disable_clk;
+	}
 
 	drvdata->base = base;
 	dev_set_drvdata(dev, drvdata);
-	pm_runtime_put(&adev->dev);
 
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
@@ -195,11 +196,18 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.groups = replicator_groups;
 	drvdata->csdev = coresight_register(&desc);
 
-	if (!IS_ERR(drvdata->csdev)) {
-		replicator_reset(drvdata);
-		return 0;
+	if (IS_ERR(drvdata->csdev)) {
+		ret = PTR_ERR(drvdata->csdev);
+		goto out_disable_clk;
 	}
-	return PTR_ERR(drvdata->csdev);
+
+	replicator_reset(drvdata);
+	pm_runtime_put(&adev->dev);
+
+out_disable_clk:
+	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
+		clk_disable_unprepare(drvdata->atclk);
+	return ret;
 }
 
 #ifdef CONFIG_PM
-- 
2.7.4
