From: Zhang Rui <rui.zhang@intel.com>
Subject: [09/12] acpi: add acpi_bus_removal_type in acpi_device
Date: Fri, 22 Sep 2006 17:47:47 +0800
Message-ID: <1158918467.11985.80.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44940 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751138AbWIVJq2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Sep 2006 05:46:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com

From: Li Shaohua <shaohua.li@intel.com>

Add removal_type in structure acpi_device for hot removal.

ACPI_BUS_REMOVAL_EJECT is used for ACPI device hot removal.
Only one parameter is allowed in .remove method due to driver model.
So removal_type is added to indicate different removal type.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>

---
 drivers/acpi/scan.c     |    6 ++++--
 include/acpi/acpi_bus.h |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

Index: linux-2.6.18/drivers/acpi/scan.c
===================================================================
--- linux-2.6.18.orig/drivers/acpi/scan.c	2006-09-21 21:15:34.000000000 +0800
+++ linux-2.6.18/drivers/acpi/scan.c	2006-09-21 21:15:39.000000000 +0800
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
Index: linux-2.6.18/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.18.orig/include/acpi/acpi_bus.h	2006-09-21 21:15:34.000000000 +0800
+++ linux-2.6.18/include/acpi/acpi_bus.h	2006-09-21 21:15:39.000000000 +0800
@@ -301,6 +301,7 @@ struct acpi_device {
 	void *driver_data;
 	struct device dev;
 	struct acpi_bus_ops bus_ops;	/* workaround for different code path for hotplug */
+	enum acpi_bus_removal_type removal_type; /* indicate for different removal type */
 };
 
 #define acpi_driver_data(d)	((d)->driver_data)
