From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0048/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:36:58 +0800
Message-ID: <20160802103658.16967-1-baolex.ni@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:16854 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754706AbcHBLPZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Aug 2016 07:15:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, x86@kernel.org, hpa@zytor.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, travis@sgi.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/acpi/power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index fcd4ce6..7a6cd36 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -752,7 +752,7 @@ static ssize_t acpi_power_in_use_show(struct device *dev,
 	resource = to_power_resource(to_acpi_device(dev));
 	return sprintf(buf, "%u\n", !!resource->ref_count);
 }
-static DEVICE_ATTR(resource_in_use, 0444, acpi_power_in_use_show, NULL);
+static DEVICE_ATTR(resource_in_use, S_IRUSR | S_IRGRP | S_IROTH, acpi_power_in_use_show, NULL);
 
 static void acpi_power_sysfs_remove(struct acpi_device *device)
 {
-- 
2.9.2

