From: Lv Zheng <lv.zheng@intel.com>
Subject: [RESEND PATCH] ACPI: Add _UID support for ACPI devices.
Date: Thu, 27 Sep 2012 13:02:33 +0800
Message-ID: <6714b0d7ea3b72d7702dae911afad081e948be3b.1348722104.git.lv.zheng@intel.com>
References: <3f02ff942122d086c4d6e44a9ffa9269300675b3.1348736272.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63720 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332Ab2I0FDX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Sep 2012 01:03:23 -0400
In-Reply-To: <3f02ff942122d086c4d6e44a9ffa9269300675b3.1348736272.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Rui Zhang <rui.zhang@intel.com>

The _UID object is optional, but is required when the device has no
other way to report a persistent unique device ID.
This patch is required for ACPI 5.0 ACPI enumerated IP cores.

Signed-off-by: Rui Zhang <rui.zhang@intel.com>
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

