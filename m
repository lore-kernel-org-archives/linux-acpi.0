From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 19/25] coresight: Make device to CPU mapping generic
Date: Wed, 20 Mar 2019 18:49:36 +0000
Message-ID: <1553107783-3340-20-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: linux-acpi@vger.kernel.org

The CoreSight components ETM and CPU-Debug are always associated
with CPUs. Replace the of_coresight_get_cpu() with a platform
agnostic helper, in preparation to add ACPI support.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-cpu-debug.c |  3 +--
 drivers/hwtracing/coresight/coresight-platform.c  | 18 +++++++++++++-----
 include/linux/coresight.h                         |  7 +------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index e8819d7..07a1367 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -572,14 +572,13 @@ static int debug_probe(struct amba_device *adev, const struct amba_id *id)
 	struct device *dev = &adev->dev;
 	struct debug_drvdata *drvdata;
 	struct resource *res = &adev->res;
-	struct device_node *np = adev->dev.of_node;
 	int ret;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->cpu = np ? of_coresight_get_cpu(np) : 0;
+	drvdata->cpu = coresight_get_cpu(dev);
 	if (per_cpu(debug_drvdata, drvdata->cpu)) {
 		dev_err(dev, "CPU%d drvdata has already been initialized\n",
 			drvdata->cpu);
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 693e3f5..93b6c87 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -147,12 +147,14 @@ static void of_coresight_get_ports(const struct device_node *node,
 	}
 }
 
-int of_coresight_get_cpu(const struct device_node *node)
+static int of_coresight_get_cpu(struct device *dev)
 {
 	int cpu;
 	struct device_node *dn;
 
-	dn = of_parse_phandle(node, "cpu", 0);
+	if (!dev->of_node)
+		return 0;
+	dn = of_parse_phandle(dev->of_node, "cpu", 0);
 	/* Affinity defaults to CPU0 */
 	if (!dn)
 		return 0;
@@ -162,7 +164,6 @@ int of_coresight_get_cpu(const struct device_node *node)
 	/* Affinity to CPU0 if no cpu nodes are found */
 	return (cpu < 0) ? 0 : cpu;
 }
-EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
 
 /*
  * of_coresight_parse_endpoint : Parse the given output endpoint @ep
@@ -237,8 +238,6 @@ of_get_coresight_platform_data(struct device *dev,
 	bool legacy_binding = false;
 	struct device_node *node = dev->of_node;
 
-	pdata->cpu = of_coresight_get_cpu(node);
-
 	/* Get the number of input and output port for this component */
 	of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
 
@@ -290,6 +289,14 @@ of_get_coresight_platform_data(struct device *dev,
 }
 #endif
 
+int coresight_get_cpu(struct device *dev)
+{
+	if (is_of_node(dev->fwnode))
+		return of_coresight_get_cpu(dev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(coresight_get_cpu);
+
 struct coresight_platform_data *
 coresight_get_platform_data(struct device *dev)
 {
@@ -304,6 +311,7 @@ coresight_get_platform_data(struct device *dev)
 
 	/* Use device name as sysfs handle */
 	pdata->name = dev_name(dev);
+	pdata->cpu = coresight_get_cpu(dev);
 
 	if (is_of_node(dev->fwnode))
 		return of_get_coresight_platform_data(dev, pdata);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 5b29255..a48cd9b 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -291,12 +291,7 @@ static inline void coresight_disclaim_device_unlocked(void __iomem *base) {}
 
 #endif
 
-#ifdef CONFIG_OF
-extern int of_coresight_get_cpu(const struct device_node *node);
-#else
-static inline int of_coresight_get_cpu(const struct device_node *node)
-{ return 0; }
-#endif
+extern int coresight_get_cpu(struct device *dev);
 
 struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
 
-- 
2.7.4
