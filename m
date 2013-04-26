From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: Can't set policy
Date: Fri, 26 Apr 2013 08:17:12 -0700
Message-ID: <1366989432-4825-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52661 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755894Ab3DZPMK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Apr 2013 11:12:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rui.zhang@intel.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Setting policy results in invalid value error.
	>echo "step_wise" > policy
	>echo: write error: Invalid argument

Need clean up of the buffer which "echo" may add based on the
arguments, before comparing aganist list of governor names.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/thermal_core.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 4cdc3e3..ed6904f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -696,16 +696,27 @@ static ssize_t
 policy_store(struct device *dev, struct device_attribute *attr,
 		    const char *buf, size_t count)
 {
-	int ret = -EINVAL;
+	int ret;
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	struct thermal_governor *gov;
+	char str_gov[THERMAL_NAME_LENGTH];
+	char format[6]; /* enough for 3 digit format width */
+
+	ret = snprintf(format, sizeof(format), "%%%ds",
+					THERMAL_NAME_LENGTH - 1);
+	if (ret < 0)
+		return ret;
+	ret = sscanf(buf, format, str_gov);
+	if (ret <= 0)
+		return -EINVAL;
 
 	mutex_lock(&thermal_governor_lock);
 
-	gov = __find_governor(buf);
-	if (!gov)
+	gov = __find_governor(str_gov);
+	if (!gov) {
+		ret = -EINVAL;
 		goto exit;
-
+	}
 	tz->governor = gov;
 	ret = count;
 
-- 
1.7.11.7

