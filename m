From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 1/4] ACPI: Remember to clear acpi_dev->driver after calling ops.remove()
Date: Mon, 14 Sep 2009 17:09:26 +0100
Message-ID: <1252944569-29799-2-git-send-email-alan-jenkins@tuffmail.co.uk>
References: <1252944569-29799-1-git-send-email-alan-jenkins@tuffmail.co.uk>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mxout-08.mxes.net ([216.86.168.183]:63743 "EHLO
	mxout-08.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071AbZINQJe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2009 12:09:34 -0400
In-Reply-To: <1252944569-29799-1-git-send-email-alan-jenkins@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: bjorn.helgaas@hp.com, linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

If an error occurs while binding a driver to a device and we call
remove(), we should also clear acpi->driver and acpi_dev->driverdata.
Otherwise bad things will happen e.g. we will invoke the suspend()
driver callback when the system is suspended, even though the driver
thinks it has been unbound from the device.

Also check the return value of acpi_start_single_object().  I'm not
sure what will happen if we claim success despite seeing ops.start()
fail and then calling ops.remove(), but it can't be good.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Reviewed-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |   45 +++++++++++++++++++++++++++------------------
 1 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 957620b..cde179e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -423,26 +423,33 @@ static int acpi_device_probe(struct device * dev)
 	int ret;
 
 	ret = acpi_bus_driver_init(acpi_dev, acpi_drv);
-	if (!ret) {
-		if (acpi_dev->bus_ops.acpi_op_start)
-			acpi_start_single_object(acpi_dev);
-
-		if (acpi_drv->ops.notify) {
-			ret = acpi_device_install_notify_handler(acpi_dev);
-			if (ret) {
-				if (acpi_drv->ops.remove)
-					acpi_drv->ops.remove(acpi_dev,
-						     acpi_dev->removal_type);
-				return ret;
-			}
-		}
+	if (ret)
+		return ret;
 
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			"Found driver [%s] for device [%s]\n",
-			acpi_drv->name, acpi_dev->pnp.bus_id));
-		get_device(dev);
+	if (acpi_dev->bus_ops.acpi_op_start) {
+		ret = acpi_start_single_object(acpi_dev);
+		if (ret)
+			return ret;
 	}
-	return ret;
+
+	if (acpi_drv->ops.notify) {
+		ret = acpi_device_install_notify_handler(acpi_dev);
+		if (ret) {
+			if (acpi_drv->ops.remove)
+				acpi_drv->ops.remove(acpi_dev,
+						acpi_dev->removal_type);
+			acpi_dev->driver = NULL;
+			acpi_dev->driver_data = NULL;
+			return ret;
+		}
+	}
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+		"Found driver [%s] for device [%s]\n",
+		acpi_drv->name, acpi_dev->pnp.bus_id));
+	get_device(dev);
+
+	return 0;
 }
 
 static int acpi_device_remove(struct device * dev)
@@ -617,6 +624,8 @@ static int acpi_start_single_object(struct acpi_device *device)
 		result = driver->ops.start(device);
 		if (result && driver->ops.remove)
 			driver->ops.remove(device, ACPI_BUS_REMOVAL_NORMAL);
+		device->driver = NULL;
+		device->driver_data = NULL;
 	}
 
 	return result;
-- 
1.6.3.2

