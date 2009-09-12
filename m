From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH] ACPI: Remember to clear acpi_dev->driver after calling ops.remove()
Date: Sat, 12 Sep 2009 16:35:49 +0100
Message-ID: <4AABBFD5.1000009@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:54626 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbZILPft (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Sep 2009 11:35:49 -0400
Received: by ey-out-2122.google.com with SMTP id 4so220345eyf.5
        for <linux-acpi@vger.kernel.org>; Sat, 12 Sep 2009 08:35:51 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux acpi <linux-acpi@vger.kernel.org>

If an error occurs while binding a driver to a device and we call
remove(), we should also clear acpi->driver and acpi_dev->driverdata.
Otherwise bad things will happen e.g. we will invoke the suspend()
driver callback when the system is suspended, even though the driver
thinks it has been unbound from the device.

Also check the return value of acpi_start_single_object().  I'm not
sure what will happen if we claim success despite seeing ops.start()
fail and then calling ops.remove(), but it's not a good idea.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>
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



