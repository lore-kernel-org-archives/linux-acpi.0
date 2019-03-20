From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 03/25] coresight: replicator: Prepare for merging with
 dynamic-replicator
Date: Wed, 20 Mar 2019 18:49:20 +0000
Message-ID: <1553107783-3340-4-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, robert.walker@arm.com, mike.leach@linaro.org
List-Id: linux-acpi@vger.kernel.org

As a preparatory step to merge the separate drivers for static and
dynamic replicators, annotate the static replicator specific details.
Also refactor the probe routine to make it generic in order to merge
the drivers easily.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-replicator.c | 62 +++++++++++++---------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index feac983..43cbcf1 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -56,58 +56,68 @@ static const struct coresight_ops replicator_cs_ops = {
 	.link_ops	= &replicator_link_ops,
 };
 
-static int replicator_probe(struct platform_device *pdev)
+static int replicator_probe(struct device *dev)
 {
-	int ret;
-	struct device *dev = &pdev->dev;
+	int ret = 0;
 	struct coresight_platform_data *pdata = NULL;
 	struct replicator_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 
 	if (np) {
 		pdata = of_get_coresight_platform_data(dev, np);
 		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
-		pdev->dev.platform_data = pdata;
+		dev->platform_data = pdata;
 	}
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->dev = &pdev->dev;
-	drvdata->atclk = devm_clk_get(&pdev->dev, "atclk"); /* optional */
+	drvdata->dev = dev;
+	drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
 		if (ret)
 			return ret;
 	}
-	pm_runtime_get_noresume(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-	platform_set_drvdata(pdev, drvdata);
+
+	dev_set_drvdata(dev, drvdata);
 
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
 	desc.ops = &replicator_cs_ops;
-	desc.pdata = pdev->dev.platform_data;
-	desc.dev = &pdev->dev;
+	desc.pdata = dev->platform_data;
+	desc.dev = dev;
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);
-		goto out_disable_pm;
+		goto out_disable_clk;
 	}
 
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put(dev);
 
-	return 0;
-
-out_disable_pm:
-	if (!IS_ERR(drvdata->atclk))
+out_disable_clk:
+	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
-	pm_runtime_put_noidle(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
+	return ret;
+}
+
+static int static_replicator_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = replicator_probe(&pdev->dev);
+
+	if (ret) {
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
 
 	return ret;
 }
@@ -139,18 +149,18 @@ static const struct dev_pm_ops replicator_dev_pm_ops = {
 			   replicator_runtime_resume, NULL)
 };
 
-static const struct of_device_id replicator_match[] = {
+static const struct of_device_id static_replicator_match[] = {
 	{.compatible = "arm,coresight-replicator"},
 	{}
 };
 
-static struct platform_driver replicator_driver = {
-	.probe          = replicator_probe,
+static struct platform_driver static_replicator_driver = {
+	.probe          = static_replicator_probe,
 	.driver         = {
 		.name   = "coresight-replicator",
-		.of_match_table = replicator_match,
+		.of_match_table = static_replicator_match,
 		.pm	= &replicator_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver(replicator_driver);
+builtin_platform_driver(static_replicator_driver);
-- 
2.7.4
