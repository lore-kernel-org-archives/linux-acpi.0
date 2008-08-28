From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch 11/11]add 'type' sysfs file for dock
Date: Thu, 28 Aug 2008 10:07:45 +0800
Message-ID: <1219889265.29375.47.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3143 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754686AbYH1B6B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Aug 2008 21:58:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

add a sysfs file to present dock type. Suggested by Holger.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/dock.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

Index: linux/drivers/acpi/dock.c
===================================================================
--- linux.orig/drivers/acpi/dock.c	2008-08-28 09:49:00.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-08-28 09:53:05.000000000 +0800
@@ -911,6 +911,26 @@ static ssize_t show_dock_uid(struct devi
 }
 static DEVICE_ATTR(uid, S_IRUGO, show_dock_uid, NULL);
 
+static ssize_t show_dock_type(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dock_station *dock_station = *((struct dock_station **)
+		dev->platform_data);
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
@@ -999,6 +1019,9 @@ static int dock_add(acpi_handle handle)
 		dock_station = NULL;
 		return ret;
 	}
+	ret = device_create_file(&dock_device->dev, &dev_attr_type);
+	if (ret)
+		printk(KERN_ERR"Error %d adding sysfs file\n", ret);
 
 	/* Find dependent devices */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
@@ -1020,6 +1043,7 @@ static int dock_add(acpi_handle handle)
 	return 0;
 
 dock_add_err_unregister:
+	device_remove_file(&dock_device->dev, &dev_attr_type);
 	device_remove_file(&dock_device->dev, &dev_attr_docked);
 	device_remove_file(&dock_device->dev, &dev_attr_undock);
 	device_remove_file(&dock_device->dev, &dev_attr_uid);
@@ -1047,6 +1071,7 @@ static int dock_remove(struct dock_stati
 	    kfree(dd);
 
 	/* cleanup sysfs */
+	device_remove_file(&dock_device->dev, &dev_attr_type);
 	device_remove_file(&dock_device->dev, &dev_attr_docked);
 	device_remove_file(&dock_device->dev, &dev_attr_undock);
 	device_remove_file(&dock_device->dev, &dev_attr_uid);


