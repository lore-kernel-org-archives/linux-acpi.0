From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch 11/11]add 'type' sysfs file for dock
Date: Wed, 27 Aug 2008 11:15:02 +0800
Message-ID: <1219806902.32665.67.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61674 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbYH0DFV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Aug 2008 23:05:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

add a sysfs file to present dock type. Suggested by Holger.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/dock.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

Index: linux/drivers/acpi/dock.c
===================================================================
--- linux.orig/drivers/acpi/dock.c	2008-08-27 10:22:28.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-08-27 10:22:32.000000000 +0800
@@ -902,6 +902,25 @@ static ssize_t show_dock_uid(struct devi
 }
 static DEVICE_ATTR(uid, S_IRUGO, show_dock_uid, NULL);
 
+static ssize_t show_dock_type(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dock_station *dock_station = *((struct dock_station **)dev->platform_data);
+	char *type;
+
+	if (dock_station->flags & DOCK_IS_DOCK)
+		type = "dock_station";
+	else if (dock_station->flags & DOCK_IS_ATA)
+		type = "ata_bay";
+	else if (dock_station->flags & DOCK_IS_BAT)
+		type = "battery_bay";
+	else
+		type = "unknown";
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", type);
+}
+static DEVICE_ATTR(type, S_IRUGO, show_dock_type, NULL);
+
 /**
  * dock_add - add a new dock station
  * @handle: the dock station handle
@@ -989,6 +1008,18 @@ static int dock_add(acpi_handle handle)
 		dock_station = NULL;
 		return ret;
 	}
+	ret = device_create_file(&dock_device->dev, &dev_attr_type);
+	if (ret) {
+		printk("Error %d adding sysfs file\n", ret);
+		device_remove_file(&dock_device->dev, &dev_attr_docked);
+		device_remove_file(&dock_device->dev, &dev_attr_undock);
+		device_remove_file(&dock_device->dev, &dev_attr_uid);
+		device_remove_file(&dock_device->dev, &dev_attr_flags);
+		platform_device_unregister(dock_device);
+		kfree(dock_station);
+		dock_station = NULL;
+		return ret;
+	}
 
 	/* Find dependent devices */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
@@ -1010,6 +1041,7 @@ static int dock_add(acpi_handle handle)
 	return 0;
 
 dock_add_err_unregister:
+	device_remove_file(&dock_device->dev, &dev_attr_type);
 	device_remove_file(&dock_device->dev, &dev_attr_docked);
 	device_remove_file(&dock_device->dev, &dev_attr_undock);
 	device_remove_file(&dock_device->dev, &dev_attr_uid);


