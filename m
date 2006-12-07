From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 9/14] ACPI: add acpi_bus_removal_type in acpi_device
Date: Thu, 07 Dec 2006 20:56:46 +0800
Message-ID: <1165496206.11485.83.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39031 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032177AbWLGMwk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Dec 2006 07:52:40 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

From: Li Shaohua <shaohua.li@intel.com>

Add removal_type in structure acpi_device for hot removal.

ACPI_BUS_REMOVAL_EJECT is used for ACPI device hot removal.
Only one parameter is allowed in .remove method due to driver model.
So removal_type is added to indicate different removal type.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c     |    6 ++++--
 include/acpi/acpi_bus.h |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 2a82645..06b86fa 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -229,9 +229,9 @@ static int acpi_device_remove(struct dev
 
 	if (acpi_drv) {
 		if (acpi_drv->ops.stop)
-			acpi_drv->ops.stop(acpi_dev, ACPI_BUS_REMOVAL_NORMAL);
+			acpi_drv->ops.stop(acpi_dev, acpi_dev->removal_type);
 		if (acpi_drv->ops.remove)
-			acpi_drv->ops.remove(acpi_dev, ACPI_BUS_REMOVAL_NORMAL);
+			acpi_drv->ops.remove(acpi_dev, acpi_dev->removal_type);
 	}
 	acpi_dev->driver = NULL;
 	acpi_driver_data(dev) = NULL;
@@ -294,6 +294,7 @@ static void acpi_device_register(struct
 	device_add(&device->dev);
 
 	acpi_device_setup_files(device);
+	device->removal_type = ACPI_BUS_REMOVAL_NORMAL;
 }
 
 static void acpi_device_unregister(struct acpi_device *device, int type)
@@ -859,6 +860,7 @@ static int acpi_bus_remove(struct acpi_d
 	if (!dev)
 		return -EINVAL;
 
+	dev->removal_type = ACPI_BUS_REMOVAL_EJECT;
 	device_release_driver(&dev->dev);
 
 	if (!rmdevice)
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b7baac7..168ef22 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -301,6 +301,7 @@ struct acpi_device {
 	void *driver_data;
 	struct device dev;
 	struct acpi_bus_ops bus_ops;	/* workaround for different code path for hotplug */
+	enum acpi_bus_removal_type removal_type; /* indicate for different removal type */
 };
 
 #define acpi_driver_data(d)	((d)->driver_data)
-- 
1.4.4.g59427
