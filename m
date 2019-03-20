From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 12/25] coresight: etm: Clean up device specific data
Date: Wed, 20 Mar 2019 18:49:29 +0000
Message-ID: <1553107783-3340-13-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: linux-acpi@vger.kernel.org

Track the coresight device instead of the real device.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 6 +++---
 drivers/hwtracing/coresight/coresight-etm4x.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index be302ec..1b9ae3a 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -462,7 +462,7 @@ int etm_get_trace_id(struct etm_drvdata *drvdata)
 	if (!local_read(&drvdata->mode))
 		return drvdata->traceid;
 
-	pm_runtime_get_sync(drvdata->dev);
+	pm_runtime_get_sync(drvdata->dev->parent);
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
@@ -471,7 +471,7 @@ int etm_get_trace_id(struct etm_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-	pm_runtime_put(drvdata->dev);
+	pm_runtime_put(drvdata->dev->parent);
 
 out:
 	return trace_id;
@@ -803,7 +803,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 		drvdata->use_cp14 = of_property_read_bool(np, "arm,cp14");
 	}
 
-	drvdata->dev = &adev->dev;
 	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
@@ -864,6 +863,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_arch_supported;
 	}
 
+	drvdata->dev = &drvdata->csdev->dev;
 	ret = etm_perf_symlink(drvdata->csdev, true);
 	if (ret) {
 		coresight_unregister(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 08ce37c..8d5ee3b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -987,7 +987,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		adev->dev.platform_data = pdata;
 	}
 
-	drvdata->dev = &adev->dev;
 	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
@@ -1042,6 +1041,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_arch_supported;
 	}
 
+	drvdata->dev = &drvdata->csdev->dev;
 	ret = etm_perf_symlink(drvdata->csdev, true);
 	if (ret) {
 		coresight_unregister(drvdata->csdev);
@@ -1049,7 +1049,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	pm_runtime_put(&adev->dev);
-	dev_info(dev, "CPU%d: ETM v%d.%d initialized\n",
+	dev_info(drvdata->dev, "CPU%d: ETM v%d.%d initialized\n",
 		 drvdata->cpu, drvdata->arch >> 4, drvdata->arch & 0xf);
 
 	if (boot_enable) {
-- 
2.7.4
