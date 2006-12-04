From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 1/3] Make the dock station driver a platform device driver.
Date: Mon, 4 Dec 2006 14:49:43 -0800
Message-ID: <20061204144943.30120719.kristen.c.accardi@intel.com>
References: <20061204224037.713257809@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21763 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967711AbWLDWvw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Dec 2006 17:51:52 -0500
In-Reply-To: <20061204224037.713257809@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Make the dock station driver a platform device driver so that
we can create sysfs entries under /sys/device/platform.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/acpi/dock.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- kristen-2.6.orig/drivers/acpi/dock.c
+++ kristen-2.6/drivers/acpi/dock.c
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/notifier.h>
+#include <linux/platform_device.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -38,6 +39,8 @@ MODULE_DESCRIPTION(ACPI_DOCK_DRIVER_NAME
 MODULE_LICENSE("GPL");
 
 static struct atomic_notifier_head dock_notifier_list;
+static struct platform_device dock_device;
+static char dock_device_name[] = "dock";
 
 struct dock_station {
 	acpi_handle handle;
@@ -628,6 +631,15 @@ static int dock_add(acpi_handle handle)
 	spin_lock_init(&dock_station->hp_lock);
 	ATOMIC_INIT_NOTIFIER_HEAD(&dock_notifier_list);
 
+	/* initialize platform device stuff */
+	dock_device.name = dock_device_name;
+	ret = platform_device_register(&dock_device);
+	if (ret) {
+		printk(KERN_ERR PREFIX "Error registering dock device\n", ret);
+		kfree(dock_station);
+		return ret;
+	}
+
 	/* Find dependent devices */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX, find_dock_devices, dock_station,
@@ -637,7 +649,8 @@ static int dock_add(acpi_handle handle)
 	dd = alloc_dock_dependent_device(handle);
 	if (!dd) {
 		kfree(dock_station);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto dock_add_err_unregister;
 	}
 	add_dock_dependent_device(dock_station, dd);
 
@@ -657,8 +670,10 @@ static int dock_add(acpi_handle handle)
 	return 0;
 
 dock_add_err:
-	kfree(dock_station);
 	kfree(dd);
+dock_add_err_unregister:
+	platform_device_unregister(&dock_device);
+	kfree(dock_station);
 	return ret;
 }
 
@@ -685,6 +700,9 @@ static int dock_remove(void)
 	if (ACPI_FAILURE(status))
 		printk(KERN_ERR "Error removing notify handler\n");
 
+	/* cleanup sysfs */
+	platform_device_unregister(&dock_device);
+
 	/* free dock station memory */
 	kfree(dock_station);
 	return 0;

--
