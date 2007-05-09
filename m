From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH] ACPI: dock: fix opps after dock driver fails to initialize
Date: Wed, 9 May 2007 15:05:48 -0700
Message-ID: <20070509150548.4b675641.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38454 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756135AbXEIWIq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2007 18:08:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, cebbert@redhat.com

ACPI: dock: fix oops after dock driver fails to initialize

From: Chuck Ebbert <cebbert@redhat.com>

The driver tests the dock_station pointer for nonnull
to check whether it has initialized properly. But in
some cases dock_station will be non-null after being
freed when driver init fails. Fix by zeroing the
pointer after freeing.

Signed-off-by: Chuck Ebbert <cebbert@redhat.com>
Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 drivers/acpi/dock.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: 2.6-git/drivers/acpi/dock.c
===================================================================
--- 2.6-git.orig/drivers/acpi/dock.c
+++ 2.6-git/drivers/acpi/dock.c
@@ -715,6 +715,7 @@ static int dock_add(acpi_handle handle)
 	if (ret) {
 		printk(KERN_ERR PREFIX "Error %d registering dock device\n", ret);
 		kfree(dock_station);
+		dock_station = NULL;
 		return ret;
 	}
 	ret = device_create_file(&dock_device.dev, &dev_attr_docked);
@@ -722,6 +723,7 @@ static int dock_add(acpi_handle handle)
 		printk("Error %d adding sysfs file\n", ret);
 		platform_device_unregister(&dock_device);
 		kfree(dock_station);
+		dock_station = NULL;
 		return ret;
 	}
 	ret = device_create_file(&dock_device.dev, &dev_attr_undock);
@@ -730,6 +732,7 @@ static int dock_add(acpi_handle handle)
 		device_remove_file(&dock_device.dev, &dev_attr_docked);
 		platform_device_unregister(&dock_device);
 		kfree(dock_station);
+		dock_station = NULL;
 		return ret;
 	}
 	ret = device_create_file(&dock_device.dev, &dev_attr_uid);
@@ -739,6 +742,7 @@ static int dock_add(acpi_handle handle)
 		device_remove_file(&dock_device.dev, &dev_attr_undock);
 		platform_device_unregister(&dock_device);
 		kfree(dock_station);
+		dock_station = NULL;
 		return ret;
 	}
 
@@ -751,6 +755,7 @@ static int dock_add(acpi_handle handle)
 	dd = alloc_dock_dependent_device(handle);
 	if (!dd) {
 		kfree(dock_station);
+		dock_station = NULL;
 		ret = -ENOMEM;
 		goto dock_add_err_unregister;
 	}
@@ -779,6 +784,7 @@ dock_add_err_unregister:
 	device_remove_file(&dock_device.dev, &dev_attr_uid);
 	platform_device_unregister(&dock_device);
 	kfree(dock_station);
+	dock_station = NULL;
 	return ret;
 }
 
@@ -813,6 +819,7 @@ static int dock_remove(void)
 
 	/* free dock station memory */
 	kfree(dock_station);
+	dock_station = NULL;
 	return 0;
 }
 
