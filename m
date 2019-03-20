From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 10/25] coresight: tpiu: Clean up device specific data
Date: Wed, 20 Mar 2019 18:49:27 +0000
Message-ID: <1553107783-3340-11-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: linux-acpi@vger.kernel.org

Switch to using the coresight device instead of the parent
amba device.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tpiu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index b2f72a1..9763721 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -48,15 +48,13 @@
 
 /**
  * @base:	memory mapped base address for this component.
- * @dev:	the device entity associated to this component.
+ * @dev:	the coresight device entity associated to this component.
  * @atclk:	optional clock for the core parts of the TPIU.
- * @csdev:	component vitals needed by the framework.
  */
 struct tpiu_drvdata {
 	void __iomem		*base;
 	struct device		*dev;
 	struct clk		*atclk;
-	struct coresight_device	*csdev;
 };
 
 static void tpiu_enable_hw(struct tpiu_drvdata *drvdata)
@@ -121,6 +119,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	struct tpiu_drvdata *drvdata;
 	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
+	struct coresight_device *csdev;
 	struct device_node *np = adev->dev.of_node;
 
 	if (np) {
@@ -134,7 +133,6 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->dev = &adev->dev;
 	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
@@ -160,9 +158,11 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.ops = &tpiu_cs_ops;
 	desc.pdata = pdata;
 	desc.dev = dev;
-	drvdata->csdev = coresight_register(&desc);
+	csdev = coresight_register(&desc);
+	if (!IS_ERR(csdev))
+		drvdata->dev = &csdev->dev;
 
-	return PTR_ERR_OR_ZERO(drvdata->csdev);
+	return PTR_ERR_OR_ZERO(csdev);
 }
 
 #ifdef CONFIG_PM
-- 
2.7.4
