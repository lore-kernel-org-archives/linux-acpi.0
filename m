From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPI: Add _UID support for ACPI devices.
Date: Thu, 27 Sep 2012 09:17:16 +0800
Message-ID: <3f02ff942122d086c4d6e44a9ffa9269300675b3.1348736272.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62679 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669Ab2I0BRp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Sep 2012 21:17:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, Ying Huang <ying.huang@intel.com>, Rui Zhang <rui.zhang@intel.com>, Lv Zheng <lv.zheng@intel.com>

The _UID object is optional, but is required when the device has no
other way to report a persistent unique device ID.
This patch is required for ACPI 5.0 ACPI enumerated IP cores.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/scan.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d730a93..bb7fe47 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -327,6 +327,8 @@ static void acpi_device_release(struct device *dev)
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 
 	acpi_free_ids(acpi_dev);
+	if (acpi_dev->pnp.unique_id)
+		kfree(acpi_dev->pnp.unique_id);
 	kfree(acpi_dev);
 }
 
@@ -1162,6 +1164,9 @@ static void acpi_device_set_id(struct acpi_device *device)
 			device->pnp.bus_address = info->address;
 			device->flags.bus_address = 1;
 		}
+		if (info->valid & ACPI_VALID_UID) {
+			device->pnp.unique_id = kstrdup(info->unique_id.string, GFP_KERNEL);
+		}
 
 		kfree(info);
 
-- 
1.7.10

