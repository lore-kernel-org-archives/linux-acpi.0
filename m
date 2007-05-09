From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH] ACPI: dock: cleanup the uid patch
Date: Wed, 9 May 2007 15:04:24 -0700
Message-ID: <20070509150424.5511a56f.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19158 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759373AbXEIWHZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2007 18:07:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ilya@total-knowledge.com

ACPI: dock: cleanup the uid patch

Make uid sysfs file error path free memory, and cleanup sysfs file
when removing driver.  Also fix CodingStyle violations.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Illya A. Volynets-Evenbakh <ilya@total-knowledge.com>
Index: 2.6-git/drivers/acpi/dock.c
===================================================================
--- 2.6-git.orig/drivers/acpi/dock.c
+++ 2.6-git/drivers/acpi/dock.c
@@ -675,16 +675,15 @@ static ssize_t show_dock_uid(struct devi
 			     struct device_attribute *attr, char *buf)
 {
 	unsigned long lbuf;
-	acpi_status status = acpi_evaluate_integer(dock_station->handle, "_UID", NULL, &lbuf);
-	if(ACPI_FAILURE(status)) {
+	acpi_status status = acpi_evaluate_integer(dock_station->handle,
+					"_UID", NULL, &lbuf);
+	if (ACPI_FAILURE(status))
 	    return 0;
-	}
+
 	return snprintf(buf, PAGE_SIZE, "%lx\n", lbuf);
 }
 DEVICE_ATTR(uid, S_IRUGO, show_dock_uid, NULL);
 
-
-
 /**
  * dock_add - add a new dock station
  * @handle: the dock station handle
@@ -736,6 +735,8 @@ static int dock_add(acpi_handle handle)
 	ret = device_create_file(&dock_device.dev, &dev_attr_uid);
 	if (ret) {
 		printk("Error %d adding sysfs file\n", ret);
+		device_remove_file(&dock_device.dev, &dev_attr_docked);
+		device_remove_file(&dock_device.dev, &dev_attr_undock);
 		platform_device_unregister(&dock_device);
 		kfree(dock_station);
 		return ret;
@@ -775,6 +776,7 @@ dock_add_err:
 dock_add_err_unregister:
 	device_remove_file(&dock_device.dev, &dev_attr_docked);
 	device_remove_file(&dock_device.dev, &dev_attr_undock);
+	device_remove_file(&dock_device.dev, &dev_attr_uid);
 	platform_device_unregister(&dock_device);
 	kfree(dock_station);
 	return ret;
@@ -806,6 +808,7 @@ static int dock_remove(void)
 	/* cleanup sysfs */
 	device_remove_file(&dock_device.dev, &dev_attr_docked);
 	device_remove_file(&dock_device.dev, &dev_attr_undock);
+	device_remove_file(&dock_device.dev, &dev_attr_uid);
 	platform_device_unregister(&dock_device);
 
 	/* free dock station memory */
