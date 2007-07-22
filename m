From: Len Brown <len.brown@intel.com>
Subject: [PATCH 06/77] ACPI: dock: cleanup the uid patch
Date: Sun, 22 Jul 2007 05:13:51 -0400
Message-ID: <1185095708928-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54665 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761013AbXGVJPJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:09 -0400
In-Reply-To: <11850957073494-git-send-email-len.brown@intel.com>
Message-Id: <38ff4ffc039ba5a5878f2dcbb03d87c3a1f02f1b.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, "Illya A. Volynets-Evenbakh" <ilya@total-knowledge.com>, Len Brown <len.brown@intel.com>

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Make uid sysfs file error path free memory, and cleanup sysfs file
when removing driver.  Also fix CodingStyle violations.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Illya A. Volynets-Evenbakh <ilya@total-knowledge.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 4546bf8..9ddc3f1 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -675,16 +675,15 @@ static ssize_t show_dock_uid(struct device *dev,
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
-- 
1.5.3.rc2.22.g69a9b
