From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 3/6] ACPI: battery: use .notify method instead of installing
	handler directly
Date: Thu, 30 Apr 2009 09:35:47 -0600
Message-ID: <20090430153547.12628.3749.stgit@bob.kio>
References: <20090430153419.12628.91088.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:13280 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763943AbZD3Pfs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Apr 2009 11:35:48 -0400
In-Reply-To: <20090430153419.12628.91088.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Karol Kozimor <sziwan@users.sourceforge.net>, Corentin Chary <corentincj@iksaif.net>, acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Matthew Garrett <mjg@redhat.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

This driver apparently relies on seeing ALL notify events, not just
device-specific ones (because it used ACPI_ALL_NOTIFY).  We use the
ACPI_DRIVER_ALL_NOTIFY_EVENTS driver flag to request all events.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
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
 

