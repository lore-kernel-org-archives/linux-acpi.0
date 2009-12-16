From: Len Brown <lenb@kernel.org>
Subject: [PATCH 098/103] ACPI: dock: combine add|alloc_dock_dependent_device
 (v2)
Date: Wed, 16 Dec 2009 03:36:49 -0500
Message-ID: <f69cfdd24ac40ab7bbd00d6ad85e003da755e3a0.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41516 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760814AbZLPKGL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:06:11 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:59 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@hp.com>

There's no real need to have a separate allocation step when adding
a dock dependent device.

Combining the two functions is both logical and helps with legibility.

Signed-off-by: Alex Chiang <achiang@hp.com>
Acked-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |   55 +++++++++++++++++---------------------------------
 1 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 4f2aa98..ee9829b 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -93,40 +93,30 @@ struct dock_dependent_device {
  *                         Dock Dependent device functions                   *
  *****************************************************************************/
 /**
- *  alloc_dock_dependent_device - allocate and init a dependent device
- *  @handle: the acpi_handle of the dependent device
+ * add_dock_dependent_device - associate a device with the dock station
+ * @ds: The dock station
+ * @handle: handle of the dependent device
  *
- *  Allocate memory for a dependent device structure for a device referenced
- *  by the acpi handle
+ * Add the dependent device to the dock's dependent device list.
  */
-static struct dock_dependent_device *
-alloc_dock_dependent_device(acpi_handle handle)
+static int
+add_dock_dependent_device(struct dock_station *ds, acpi_handle handle)
 {
 	struct dock_dependent_device *dd;
 
 	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
-	if (dd) {
-		dd->handle = handle;
-		INIT_LIST_HEAD(&dd->list);
-		INIT_LIST_HEAD(&dd->hotplug_list);
-	}
-	return dd;
-}
+	if (!dd)
+		return -ENOMEM;
+
+	dd->handle = handle;
+	INIT_LIST_HEAD(&dd->list);
+	INIT_LIST_HEAD(&dd->hotplug_list);
 
-/**
- * add_dock_dependent_device - associate a device with the dock station
- * @ds: The dock station
- * @dd: The dependent device
- *
- * Add the dependent device to the dock's dependent device list.
- */
-static void
-add_dock_dependent_device(struct dock_station *ds,
-			  struct dock_dependent_device *dd)
-{
 	spin_lock(&ds->dd_lock);
 	list_add_tail(&dd->list, &ds->dependent_devices);
 	spin_unlock(&ds->dd_lock);
+
+	return 0;
 }
 
 /**
@@ -826,7 +816,6 @@ find_dock_devices(acpi_handle handle, u32 lvl, void *context, void **rv)
 	acpi_status status;
 	acpi_handle tmp, parent;
 	struct dock_station *ds = context;
-	struct dock_dependent_device *dd;
 
 	status = acpi_bus_get_ejd(handle, &tmp);
 	if (ACPI_FAILURE(status)) {
@@ -840,11 +829,9 @@ find_dock_devices(acpi_handle handle, u32 lvl, void *context, void **rv)
 			goto fdd_out;
 	}
 
-	if (tmp == ds->handle) {
-		dd = alloc_dock_dependent_device(handle);
-		if (dd)
-			add_dock_dependent_device(ds, dd);
-	}
+	if (tmp == ds->handle)
+		add_dock_dependent_device(ds, handle);
+
 fdd_out:
 	return AE_OK;
 }
@@ -959,7 +946,6 @@ static struct attribute_group dock_attribute_group = {
 static int dock_add(acpi_handle handle)
 {
 	int ret;
-	struct dock_dependent_device *dd;
 	struct dock_station *dock_station;
 	struct platform_device *dock_device;
 
@@ -1008,12 +994,9 @@ static int dock_add(acpi_handle handle)
 			    NULL);
 
 	/* add the dock station as a device dependent on itself */
-	dd = alloc_dock_dependent_device(handle);
-	if (!dd) {
-		ret = -ENOMEM;
+	ret = add_dock_dependent_device(dock_station, handle);
+	if (ret)
 		goto err_rmgroup;
-	}
-	add_dock_dependent_device(dock_station, dd);
 
 	dock_station_count++;
 	list_add(&dock_station->sibling, &dock_stations);
-- 
1.6.0.6

