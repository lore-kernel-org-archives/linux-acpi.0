From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/17] ACPI: delete acpi_device.g_list
Date: Tue, 07 Apr 2009 19:04:13 -0400
Message-ID: <33b571501553ceb008c0aef8b89e932d4efda2a2.1239145401.git.len.brown@intel.com>
References: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:63913 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbZDGXEe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:04:34 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR003B76RLETIZ@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 18:04:34 -0500 (CDT)
In-reply-to: <1239145465-5486-1-git-send-email-lenb@kernel.org>
In-reply-to: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
References: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

unused

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c     |   17 ++++-------------
 include/acpi/acpi_bus.h |    1 -
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e63f2fe..8ff510b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -491,7 +491,6 @@ static int acpi_device_register(struct acpi_device *device,
 	 */
 	INIT_LIST_HEAD(&device->children);
 	INIT_LIST_HEAD(&device->node);
-	INIT_LIST_HEAD(&device->g_list);
 	INIT_LIST_HEAD(&device->wakeup_list);
 
 	new_bus_id = kzalloc(sizeof(struct acpi_device_bus_id), GFP_KERNEL);
@@ -521,11 +520,9 @@ static int acpi_device_register(struct acpi_device *device,
 	}
 	dev_set_name(&device->dev, "%s:%02x", acpi_device_bus_id->bus_id, acpi_device_bus_id->instance_no);
 
-	if (device->parent) {
+	if (device->parent)
 		list_add_tail(&device->node, &device->parent->children);
-		list_add_tail(&device->g_list, &device->parent->g_list);
-	} else
-		list_add_tail(&device->g_list, &acpi_device_list);
+
 	if (device->wakeup.flags.valid)
 		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
 	mutex_unlock(&acpi_device_lock);
@@ -550,11 +547,8 @@ static int acpi_device_register(struct acpi_device *device,
 	return 0;
   end:
 	mutex_lock(&acpi_device_lock);
-	if (device->parent) {
+	if (device->parent)
 		list_del(&device->node);
-		list_del(&device->g_list);
-	} else
-		list_del(&device->g_list);
 	list_del(&device->wakeup_list);
 	mutex_unlock(&acpi_device_lock);
 	return result;
@@ -563,11 +557,8 @@ static int acpi_device_register(struct acpi_device *device,
 static void acpi_device_unregister(struct acpi_device *device, int type)
 {
 	mutex_lock(&acpi_device_lock);
-	if (device->parent) {
+	if (device->parent)
 		list_del(&device->node);
-		list_del(&device->g_list);
-	} else
-		list_del(&device->g_list);
 
 	list_del(&device->wakeup_list);
 	mutex_unlock(&acpi_device_lock);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a222851..c34b110 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -270,7 +270,6 @@ struct acpi_device {
 	struct list_head children;
 	struct list_head node;
 	struct list_head wakeup_list;
-	struct list_head g_list;
 	struct acpi_device_status status;
 	struct acpi_device_flags flags;
 	struct acpi_device_pnp pnp;
-- 
1.6.0.6

