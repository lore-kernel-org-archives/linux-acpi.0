From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 1/6] ACPI: dock: clean up error handling paths in dock_add()
Date: Wed, 07 Oct 2009 16:07:32 -0600
Message-ID: <20091007220732.15597.75850.stgit@bob.kio>
References: <20091007220509.15597.65501.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0185.atlanta.hp.com ([15.193.32.62]:2167 "EHLO
	g6t0185.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754811AbZJGWIJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Oct 2009 18:08:09 -0400
In-Reply-To: <20091007220509.15597.65501.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Remove some copy/paste code in our error handling paths, which makes
the function smaller and slightly easier to read.

Signed-off-by: Alex Chiang <achiang@hp.com>
---

 drivers/acpi/dock.c |   66 +++++++++++++++++++--------------------------------
 1 files changed, 24 insertions(+), 42 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 7338b6a..a8f81c0 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -987,46 +987,24 @@ static int dock_add(acpi_handle handle)
 		dock_station->flags |= DOCK_IS_BAT;
 
 	ret = device_create_file(&dock_device->dev, &dev_attr_docked);
-	if (ret) {
-		printk(KERN_ERR "Error %d adding sysfs file\n", ret);
-		platform_device_unregister(dock_device);
-		kfree(dock_station);
-		dock_station = NULL;
-		return ret;
-	}
+	if (ret)
+		goto err_unregister;
+
 	ret = device_create_file(&dock_device->dev, &dev_attr_undock);
-	if (ret) {
-		printk(KERN_ERR "Error %d adding sysfs file\n", ret);
-		device_remove_file(&dock_device->dev, &dev_attr_docked);
-		platform_device_unregister(dock_device);
-		kfree(dock_station);
-		dock_station = NULL;
-		return ret;
-	}
+	if (ret)
+		goto err_unregister1;
+
 	ret = device_create_file(&dock_device->dev, &dev_attr_uid);
-	if (ret) {
-		printk(KERN_ERR "Error %d adding sysfs file\n", ret);
-		device_remove_file(&dock_device->dev, &dev_attr_docked);
-		device_remove_file(&dock_device->dev, &dev_attr_undock);
-		platform_device_unregister(dock_device);
-		kfree(dock_station);
-		dock_station = NULL;
-		return ret;
-	}
+	if (ret)
+		goto err_unregister2;
+
 	ret = device_create_file(&dock_device->dev, &dev_attr_flags);
-	if (ret) {
-		printk(KERN_ERR "Error %d adding sysfs file\n", ret);
-		device_remove_file(&dock_device->dev, &dev_attr_docked);
-		device_remove_file(&dock_device->dev, &dev_attr_undock);
-		device_remove_file(&dock_device->dev, &dev_attr_uid);
-		platform_device_unregister(dock_device);
-		kfree(dock_station);
-		dock_station = NULL;
-		return ret;
-	}
+	if (ret)
+		goto err_unregister3;
+
 	ret = device_create_file(&dock_device->dev, &dev_attr_type);
 	if (ret)
-		printk(KERN_ERR"Error %d adding sysfs file\n", ret);
+		goto err_unregister4;
 
 	/* Find dependent devices */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
@@ -1036,10 +1014,8 @@ static int dock_add(acpi_handle handle)
 	/* add the dock station as a device dependent on itself */
 	dd = alloc_dock_dependent_device(handle);
 	if (!dd) {
-		kfree(dock_station);
-		dock_station = NULL;
 		ret = -ENOMEM;
-		goto dock_add_err_unregister;
+		goto err_unregister5;
 	}
 	add_dock_dependent_device(dock_station, dd);
 
@@ -1047,12 +1023,18 @@ static int dock_add(acpi_handle handle)
 	list_add(&dock_station->sibling, &dock_stations);
 	return 0;
 
-dock_add_err_unregister:
+err_unregister5:
 	device_remove_file(&dock_device->dev, &dev_attr_type);
-	device_remove_file(&dock_device->dev, &dev_attr_docked);
-	device_remove_file(&dock_device->dev, &dev_attr_undock);
-	device_remove_file(&dock_device->dev, &dev_attr_uid);
+err_unregister4:
 	device_remove_file(&dock_device->dev, &dev_attr_flags);
+err_unregister3:
+	device_remove_file(&dock_device->dev, &dev_attr_uid);
+err_unregister2:
+	device_remove_file(&dock_device->dev, &dev_attr_undock);
+err_unregister1:
+	device_remove_file(&dock_device->dev, &dev_attr_docked);
+err_unregister:
+	printk(KERN_ERR "%s encountered error %d\n", __func__, ret);
 	platform_device_unregister(dock_device);
 	kfree(dock_station);
 	dock_station = NULL;

