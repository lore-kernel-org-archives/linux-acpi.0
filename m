From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 16/25] coresight: stm: Rearrange probing the stimulus area
Date: Wed, 20 Mar 2019 18:49:33 +0000
Message-ID: <1553107783-3340-17-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: linux-acpi@vger.kernel.org

As we are about to refactor the platform specific handling
re-arrange some of the DT specific property handling.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-stm.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 6afe033..eb96bba 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -684,14 +684,15 @@ static const struct attribute_group *coresight_stm_groups[] = {
 	NULL,
 };
 
-static int stm_get_resource_byname(struct device_node *np,
-				   char *ch_base, struct resource *res)
+#ifdef CONFIG_OF
+static int of_stm_get_stimulus_area(struct device *dev, struct resource *res)
 {
 	const char *name = NULL;
 	int index = 0, found = 0;
+	struct device_node *np = dev->of_node;
 
 	while (!of_property_read_string_index(np, "reg-names", index, &name)) {
-		if (strcmp(ch_base, name)) {
+		if (strcmp("stm-stimulus-base", name)) {
 			index++;
 			continue;
 		}
@@ -706,6 +707,20 @@ static int stm_get_resource_byname(struct device_node *np,
 
 	return of_address_to_resource(np, index, res);
 }
+#else
+static inline int of_stm_get_stimulus_area(struct device *dev,
+					   struct resource *res)
+{
+	return -ENOENT;
+}
+#endif
+
+static int stm_get_stimulus_area(struct device *dev, struct resource *res)
+{
+	if (dev->of_node)
+		return of_stm_get_stimulus_area(dev, res);
+	return -ENOENT;
+}
 
 static u32 stm_fundamental_data_size(struct stm_drvdata *drvdata)
 {
@@ -819,7 +834,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(base);
 	drvdata->base = base;
 
-	ret = stm_get_resource_byname(np, "stm-stimulus-base", &ch_res);
+	ret = stm_get_stimulus_area(dev, &ch_res);
 	if (ret)
 		return ret;
 	drvdata->chs.phys = ch_res.start;
-- 
2.7.4
