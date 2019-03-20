From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 09/25] coresight: catu: Cleanup device specific data
Date: Wed, 20 Mar 2019 18:49:26 +0000
Message-ID: <1553107783-3340-10-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: linux-acpi@vger.kernel.org

Switch to using the CoreSight device instead of the real
amba device.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c | 13 +++++++------
 drivers/hwtracing/coresight/coresight-catu.h |  1 -
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 11c6f2f..671a05a 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -408,13 +408,14 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
 	int rc;
 	u32 control, mode;
 	struct etr_buf *etr_buf = data;
+	struct device *dev = &drvdata->csdev->dev;
 
 	if (catu_wait_for_ready(drvdata))
-		dev_warn(drvdata->dev, "Timeout while waiting for READY\n");
+		dev_warn(dev, "Timeout while waiting for READY\n");
 
 	control = catu_read_control(drvdata);
 	if (control & BIT(CATU_CONTROL_ENABLE)) {
-		dev_warn(drvdata->dev, "CATU is already enabled\n");
+		dev_warn(dev, "CATU is already enabled\n");
 		return -EBUSY;
 	}
 
@@ -440,7 +441,7 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
 	catu_write_irqen(drvdata, 0);
 	catu_write_mode(drvdata, mode);
 	catu_write_control(drvdata, control);
-	dev_dbg(drvdata->dev, "Enabled in %s mode\n",
+	dev_dbg(dev, "Enabled in %s mode\n",
 		(mode == CATU_MODE_PASS_THROUGH) ?
 		"Pass through" :
 		"Translate");
@@ -461,15 +462,16 @@ static int catu_enable(struct coresight_device *csdev, void *data)
 static int catu_disable_hw(struct catu_drvdata *drvdata)
 {
 	int rc = 0;
+	struct device *dev = &drvdata->csdev->dev;
 
 	catu_write_control(drvdata, 0);
 	coresight_disclaim_device_unlocked(drvdata->base);
 	if (catu_wait_for_ready(drvdata)) {
-		dev_info(drvdata->dev, "Timeout while waiting for READY\n");
+		dev_info(dev, "Timeout while waiting for READY\n");
 		rc = -EAGAIN;
 	}
 
-	dev_dbg(drvdata->dev, "Disabled\n");
+	dev_dbg(dev, "Disabled\n");
 	return rc;
 }
 
@@ -519,7 +521,6 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out;
 	}
 
-	drvdata->dev = dev;
 	dev_set_drvdata(dev, drvdata);
 	base = devm_ioremap_resource(dev, &adev->res);
 	if (IS_ERR(base)) {
diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
index 1b281f0..96ea8c4 100644
--- a/drivers/hwtracing/coresight/coresight-catu.h
+++ b/drivers/hwtracing/coresight/coresight-catu.h
@@ -61,7 +61,6 @@
 #define CATU_IRQEN_OFF		0x0
 
 struct catu_drvdata {
-	struct device *dev;
 	void __iomem *base;
 	struct coresight_device *csdev;
 	int irq;
-- 
2.7.4
