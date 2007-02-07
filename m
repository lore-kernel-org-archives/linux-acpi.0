From: Len Brown <lenb@kernel.org>
Subject: [PATCH 9/140] ACPI: add acpi_bus_removal_type in acpi_device
Date: Wed,  7 Feb 2007 13:50:23 -0500
Message-ID: <11708743802558-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:4664 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422713AbXBGSxJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:09 -0500
In-Reply-To: <11708743783727-git-send-email-lenb@kernel.org>
Message-Id: <96333578b023957537c3e98b50af7f3b7e08e411.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Li Shaohua <shaohua.li@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

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
@@ -229,9 +229,9 @@ static int acpi_device_remove(struct device * dev)
 
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
@@ -294,6 +294,7 @@ static void acpi_device_register(struct acpi_device *device,
 	device_add(&device->dev);
 
 	acpi_device_setup_files(device);
+	device->removal_type = ACPI_BUS_REMOVAL_NORMAL;
 }
 
 static void acpi_device_unregister(struct acpi_device *device, int type)
@@ -859,6 +860,7 @@ static int acpi_bus_remove(struct acpi_device *dev, int rmdevice)
 	if (!dev)
 		return -EINVAL;
 
+	dev->removal_type = ACPI_BUS_REMOVAL_EJECT;
 	device_release_driver(&dev->dev);
 
 	if (!rmdevice)
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 8976dbe..58dc8f6 100644
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
1.5.0.rc3.39.gec804
