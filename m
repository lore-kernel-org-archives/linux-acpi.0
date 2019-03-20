From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 01/25] coresight: tmc: Report DMA setup failures
Date: Wed, 20 Mar 2019 18:49:18 +0000
Message-ID: <1553107783-3340-2-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: linux-acpi@vger.kernel.org

If we failed to setup the DMA mask for TMC-ETR, report the
error before failing the probe.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 2a02da3..647b6aa 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -340,6 +340,8 @@ static inline bool tmc_etr_can_use_sg(struct tmc_drvdata *drvdata)
 static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
 			     u32 devid, void *dev_caps)
 {
+	int rc;
+
 	u32 dma_mask = 0;
 
 	/* Set the unadvertised capabilities */
@@ -369,7 +371,10 @@ static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
 		dma_mask = 40;
 	}
 
-	return dma_set_mask_and_coherent(drvdata->dev, DMA_BIT_MASK(dma_mask));
+	rc = dma_set_mask_and_coherent(drvdata->dev, DMA_BIT_MASK(dma_mask));
+	if (rc)
+		dev_err(drvdata->dev, "Failed to setup DMA mask: %d\n", rc);
+	return rc;
 }
 
 static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
-- 
2.7.4
