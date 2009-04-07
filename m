From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/17] ACPI: thermal: use .notify method instead of installing
 handler directly
Date: Tue, 07 Apr 2009 19:04:15 -0400
Message-ID: <342d550db1bc0b879007a8cdb38645558e839680.1239145401.git.len.brown@intel.com>
References: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:49203 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008AbZDGXEu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:04:50 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR007PM6RMUXSJ@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 18:04:43 -0500 (CDT)
In-reply-to: <1239145465-5486-1-git-send-email-lenb@kernel.org>
In-reply-to: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
References: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |   27 ++++-----------------------
 1 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index e8c143c..0914eaa 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -98,6 +98,7 @@ MODULE_PARM_DESC(psv, "Disable or override all passive trip points.");
 static int acpi_thermal_add(struct acpi_device *device);
 static int acpi_thermal_remove(struct acpi_device *device, int type);
 static int acpi_thermal_resume(struct acpi_device *device);
+static void acpi_thermal_notify(struct acpi_device *device, u32 event);
 static int acpi_thermal_state_open_fs(struct inode *inode, struct file *file);
 static int acpi_thermal_temp_open_fs(struct inode *inode, struct file *file);
 static int acpi_thermal_trip_open_fs(struct inode *inode, struct file *file);
@@ -123,6 +124,7 @@ static struct acpi_driver acpi_thermal_driver = {
 		.add = acpi_thermal_add,
 		.remove = acpi_thermal_remove,
 		.resume = acpi_thermal_resume,
+		.notify = acpi_thermal_notify,
 		},
 };
 
@@ -1264,17 +1266,14 @@ static int acpi_thermal_remove_fs(struct acpi_device *device)
                                  Driver Interface
    -------------------------------------------------------------------------- */
 
-static void acpi_thermal_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_thermal_notify(struct acpi_device *device, u32 event)
 {
-	struct acpi_thermal *tz = data;
-	struct acpi_device *device = NULL;
+	struct acpi_thermal *tz = acpi_driver_data(device);
 
 
 	if (!tz)
 		return;
 
-	device = tz->device;
-
 	switch (event) {
 	case ACPI_THERMAL_NOTIFY_TEMPERATURE:
 		acpi_thermal_check(tz);
@@ -1298,8 +1297,6 @@ static void acpi_thermal_notify(acpi_handle handle, u32 event, void *data)
 				  "Unsupported event [0x%x]\n", event));
 		break;
 	}
-
-	return;
 }
 
 static int acpi_thermal_get_info(struct acpi_thermal *tz)
@@ -1337,7 +1334,6 @@ static int acpi_thermal_get_info(struct acpi_thermal *tz)
 static int acpi_thermal_add(struct acpi_device *device)
 {
 	int result = 0;
-	acpi_status status = AE_OK;
 	struct acpi_thermal *tz = NULL;
 
 
@@ -1368,21 +1364,11 @@ static int acpi_thermal_add(struct acpi_device *device)
 	if (result)
 		goto unregister_thermal_zone;
 
-	status = acpi_install_notify_handler(device->handle,
-					     ACPI_DEVICE_NOTIFY,
-					     acpi_thermal_notify, tz);
-	if (ACPI_FAILURE(status)) {
-		result = -ENODEV;
-		goto remove_fs;
-	}
-
 	printk(KERN_INFO PREFIX "%s [%s] (%ld C)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
 	       KELVIN_TO_CELSIUS(tz->temperature));
 	goto end;
 
-remove_fs:
-	acpi_thermal_remove_fs(device);
 unregister_thermal_zone:
 	thermal_zone_device_unregister(tz->thermal_zone);
 free_memory:
@@ -1393,7 +1379,6 @@ end:
 
 static int acpi_thermal_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = AE_OK;
 	struct acpi_thermal *tz = NULL;
 
 	if (!device || !acpi_driver_data(device))
@@ -1401,10 +1386,6 @@ static int acpi_thermal_remove(struct acpi_device *device, int type)
 
 	tz = acpi_driver_data(device);
 
-	status = acpi_remove_notify_handler(device->handle,
-					    ACPI_DEVICE_NOTIFY,
-					    acpi_thermal_notify);
-
 	acpi_thermal_remove_fs(device);
 	acpi_thermal_unregister_thermal_zone(tz);
 	mutex_destroy(&tz->lock);
-- 
1.6.0.6

