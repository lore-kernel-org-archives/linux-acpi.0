From: Len Brown <lenb@kernel.org>
Subject: [PATCH 105/112] ACPI: add missing prink prefix strings
Date: Thu,  7 Feb 2008 04:35:07 -0500
Message-ID: <87ecd5cddaa37f057d8d8c2813e1b748b1804423.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:9414 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754825AbYBGJg5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:57 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d9d531c..78a82b3 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -59,7 +59,7 @@ static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
 			count = snprintf(&modalias[len], size, "%s:",
 					 cid_list->id[i].value);
 			if (count < 0 || count >= size) {
-				printk(KERN_ERR "acpi: %s cid[%i] exceeds event buffer size",
+				printk(KERN_ERR PREFIX "%s cid[%i] exceeds event buffer size",
 				       acpi_dev->pnp.device_name, i);
 				break;
 			}
@@ -453,7 +453,7 @@ static int acpi_device_register(struct acpi_device *device,
 	device->dev.release = &acpi_device_release;
 	result = device_add(&device->dev);
 	if(result) {
-		printk("Error adding device %s", device->dev.bus_id);
+		printk(KERN_ERR PREFIX "Error adding device %s", device->dev.bus_id);
 		goto end;
 	}
 
@@ -956,7 +956,7 @@ static void acpi_device_set_id(struct acpi_device *device,
 	case ACPI_BUS_TYPE_DEVICE:
 		status = acpi_get_object_info(handle, &buffer);
 		if (ACPI_FAILURE(status)) {
-			printk("%s: Error reading device info\n", __FUNCTION__);
+			printk(KERN_ERR PREFIX "%s: Error reading device info\n", __FUNCTION__);
 			return;
 		}
 
@@ -1026,7 +1026,7 @@ static void acpi_device_set_id(struct acpi_device *device,
 		if (device->pnp.cid_list)
 			memcpy(device->pnp.cid_list, cid_list, cid_list->size);
 		else
-			printk(KERN_ERR "Memory allocation error\n");
+			printk(KERN_ERR PREFIX "Memory allocation error\n");
 	}
 
 	kfree(buffer.pointer);
@@ -1050,7 +1050,7 @@ static int acpi_device_set_context(struct acpi_device *device, int type)
 					  acpi_bus_data_handler, device);
 
 		if (ACPI_FAILURE(status)) {
-			printk("Error attaching device data\n");
+			printk(KERN_ERR PREFIX "Error attaching device data\n");
 			result = -ENODEV;
 		}
 	}
-- 
1.5.4.23.gef5b9

