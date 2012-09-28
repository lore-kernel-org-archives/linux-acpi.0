From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 1/2] ACPI: Add _UID support for ACPI devices.
Date: Fri, 28 Sep 2012 08:40:28 +0800
Message-ID: <247a799571d25d5eb52532222e7ff48fb3de84b1.1348791925.git.lv.zheng@intel.com>
References: <3f02ff942122d086c4d6e44a9ffa9269300675b3.1348736272.git.lv.zheng@intel.com> <cover.1348791925.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48286 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab2I1Al3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Sep 2012 20:41:29 -0400
In-Reply-To: <cover.1348791925.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Rui Zhang <rui.zhang@intel.com>

The _UID object is optional, but is required when the device has no
other way to report a persistent unique device ID.
This patch is required for ACPI 5.0 ACPI enumerated IP cores.

Signed-off-by: Rui Zhang <rui.zhang@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/scan.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d730a93..7e8a130 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -327,6 +327,7 @@ static void acpi_device_release(struct device *dev)
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 
 	acpi_free_ids(acpi_dev);
+	kfree(acpi_dev->pnp.unique_id);
 	kfree(acpi_dev);
 }
 
@@ -1162,6 +1163,9 @@ static void acpi_device_set_id(struct acpi_device *device)
 			device->pnp.bus_address = info->address;
 			device->flags.bus_address = 1;
 		}
+		if (info->valid & ACPI_VALID_UID)
+			device->pnp.unique_id = kstrdup(info->unique_id.string,
+							GFP_KERNEL);
 
 		kfree(info);
 
-- 
1.7.10

