From: Len Brown <lenb@kernel.org>
Subject: [PATCH 43/65] ACPI: battery: use .notify method instead of installing
 handler directly
Date: Fri, 29 May 2009 21:42:21 -0400
Message-ID: <1e07ae4bf518fdfb8cb0e6564c370df9b393c51d.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:61730 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796AbZE3Bm5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:57 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00B2ZORNFTT3@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:00 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

This driver apparently relies on seeing ALL notify events, not just
device-specific ones (because it used ACPI_ALL_NOTIFY).  We use the
ACPI_DRIVER_ALL_NOTIFY_EVENTS driver flag to request all events.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   22 +++++-----------------
 1 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b0de631..eb00c4e 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -796,13 +796,12 @@ static void acpi_battery_remove_fs(struct acpi_device *device)
                                  Driver Interface
    -------------------------------------------------------------------------- */
 
-static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_battery_notify(struct acpi_device *device, u32 event)
 {
-	struct acpi_battery *battery = data;
-	struct acpi_device *device;
+	struct acpi_battery *battery = acpi_driver_data(device);
+
 	if (!battery)
 		return;
-	device = battery->device;
 	acpi_battery_update(battery);
 	acpi_bus_generate_proc_event(device, event,
 				     acpi_battery_present(battery));
@@ -819,7 +818,6 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 static int acpi_battery_add(struct acpi_device *device)
 {
 	int result = 0;
-	acpi_status status = 0;
 	struct acpi_battery *battery = NULL;
 	if (!device)
 		return -EINVAL;
@@ -837,14 +835,6 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (result)
 		goto end;
 #endif
-	status = acpi_install_notify_handler(device->handle,
-					     ACPI_ALL_NOTIFY,
-					     acpi_battery_notify, battery);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Installing notify handler"));
-		result = -ENODEV;
-		goto end;
-	}
 	printk(KERN_INFO PREFIX "%s Slot [%s] (battery %s)\n",
 	       ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
 	       device->status.battery_present ? "present" : "absent");
@@ -860,15 +850,11 @@ static int acpi_battery_add(struct acpi_device *device)
 
 static int acpi_battery_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = 0;
 	struct acpi_battery *battery = NULL;
 
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 	battery = acpi_driver_data(device);
-	status = acpi_remove_notify_handler(device->handle,
-					    ACPI_ALL_NOTIFY,
-					    acpi_battery_notify);
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_battery_remove_fs(device);
 #endif
@@ -896,10 +882,12 @@ static struct acpi_driver acpi_battery_driver = {
 	.name = "battery",
 	.class = ACPI_BATTERY_CLASS,
 	.ids = battery_device_ids,
+	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = acpi_battery_add,
 		.resume = acpi_battery_resume,
 		.remove = acpi_battery_remove,
+		.notify = acpi_battery_notify,
 		},
 };
 
-- 
1.6.0.6

