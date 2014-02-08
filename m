From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/10] ACPICA: Improve parameter validation for acpi_install_gpe_block.
Date: Sat,  8 Feb 2014 09:42:19 +0800
Message-ID: <c67dcb74e41b04854506a6884d5793b6950fb79f.1390438466.git.lv.zheng@intel.com>
References: <cover.1390438466.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61863 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbaBHBmY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Feb 2014 20:42:24 -0500
In-Reply-To: <cover.1390438466.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

Add the following checks:
1) The incoming device handle refers to type ACPI_TYPE_DEVICE.
2) There is not already a gpe block attached to the device.

Likewise, with acpi_remove_gpe_block, ensure that the incoming object
is a device.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evxfgpe.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 5713da7..b84f8e2 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -583,6 +583,18 @@ acpi_install_gpe_block(acpi_handle gpe_device,
 		goto unlock_and_exit;
 	}
 
+	/* Validate the parent device */
+
+	if (node->type != ACPI_TYPE_DEVICE) {
+		status = AE_TYPE;
+		goto unlock_and_exit;
+	}
+
+	if (node->object) {
+		status = AE_ALREADY_EXISTS;
+		goto unlock_and_exit;
+	}
+
 	/*
 	 * For user-installed GPE Block Devices, the gpe_block_base_number
 	 * is always zero
@@ -666,6 +678,13 @@ acpi_status acpi_remove_gpe_block(acpi_handle gpe_device)
 		goto unlock_and_exit;
 	}
 
+	/* Validate the parent device */
+
+	if (node->type != ACPI_TYPE_DEVICE) {
+		status = AE_TYPE;
+		goto unlock_and_exit;
+	}
+
 	/* Get the device_object attached to the node */
 
 	obj_desc = acpi_ns_get_attached_object(node);
-- 
1.7.10

