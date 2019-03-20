From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 07/25] coresight: replicator: Cleanup device tracking
Date: Wed, 20 Mar 2019 18:49:24 +0000
Message-ID: <1553107783-3340-8-git-send-email-suzuki.poulose@arm.com>
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
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org, linux-kernel@vger.kernel.org, Mathieu Poirier <mathie.poirier@linaro.org>, linux-acpi@vger.kernel.org, robert.walker@arm.com, mike.leach@linaro.org
List-Id: linux-acpi@vger.kernel.org

In preparation to use a consistent device naming scheme,
clean up the device link tracking in replicator driver.
Use the "coresight" device instead of the "real" parent device
for all internal purposes. All other requests (e.g, power management,
DMA operations) must use the "real" device which is the parent device.

Cc: Mathieu Poirier <mathie.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-replicator.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 4e0da85..8bbb008 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -26,13 +26,11 @@
  * struct replicator_drvdata - specifics associated to a replicator component
  * @base:	memory mapped base address for this component. Also indicates
  *		whether this one is programmable or not.
- * @dev:	the device entity associated with this component
  * @atclk:	optional clock for the core parts of the replicator.
  * @csdev:	component vitals needed by the framework
  */
 struct replicator_drvdata {
 	void __iomem		*base;
-	struct device		*dev;
 	struct clk		*atclk;
 	struct coresight_device	*csdev;
 };
@@ -100,7 +98,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 	if (drvdata->base)
 		rc = dynamic_replicator_enable(drvdata, inport, outport);
 	if (!rc)
-		dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
+		dev_dbg(&csdev->dev, "REPLICATOR enabled\n");
 	return rc;
 }
 
@@ -139,7 +137,7 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 
 	if (drvdata->base)
 		dynamic_replicator_disable(drvdata, inport, outport);
-	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
+	dev_dbg(&csdev->dev, "REPLICATOR disabled\n");
 }
 
 static const struct coresight_ops_link replicator_link_ops = {
@@ -193,7 +191,6 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->dev = dev;
 	drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
-- 
2.7.4
