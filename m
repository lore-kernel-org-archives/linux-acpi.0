From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/4] ACPI / dock: Walk list in reverse order during removal of devices
Date: Fri, 28 Jun 2013 21:47:06 +0200
Message-ID: <2531931.mBTduI0HDx@vostro.rjw.lan>
References: <1640211.P0jyS5muX2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1640211.P0jyS5muX2@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If there are indirect dependencies between devices in a dock
station's dependent devices list, they may be broken if the devices
are removed in the same order in which they have been added.

For this reason, make the code in handle_eject_request() walk the
list of dependent devices in reverse order.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/dock.c |   45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/acpi/dock.c
===================================================================
--- linux-pm.orig/drivers/acpi/dock.c
+++ linux-pm/drivers/acpi/dock.c
@@ -396,9 +396,29 @@ static void dock_remove_acpi_device(acpi
 }
 
 /**
- * hotplug_dock_devices - insert or remove devices on the dock station
+ * hot_remove_dock_devices - Remove dock station devices.
+ * @ds: Dock station.
+ */
+static void hot_remove_dock_devices(struct dock_station *ds)
+{
+	struct dock_dependent_device *dd;
+
+	/*
+	 * Walk the list in reverse order so that devices that have been added
+	 * last are removed first (in case there are some indirect dependencies
+	 * between them).
+	 */
+	list_for_each_entry_reverse(dd, &ds->dependent_devices, list)
+		dock_hotplug_event(dd, ACPI_NOTIFY_EJECT_REQUEST, false);
+
+	list_for_each_entry_reverse(dd, &ds->dependent_devices, list)
+		dock_remove_acpi_device(dd->handle);
+}
+
+/**
+ * hotplug_dock_devices - Insert devices on a dock station.
  * @ds: the dock station
- * @event: either bus check or eject request
+ * @event: either bus check or device check request
  *
  * Some devices on the dock station need to have drivers called
  * to perform hotplug operations after a dock event has occurred.
@@ -409,24 +429,17 @@ static void hotplug_dock_devices(struct
 {
 	struct dock_dependent_device *dd;
 
-	/*
-	 * First call driver specific hotplug functions
-	 */
+	/* Call driver specific hotplug functions. */
 	list_for_each_entry(dd, &ds->dependent_devices, list)
 		dock_hotplug_event(dd, event, false);
 
 	/*
-	 * Now make sure that an acpi_device is created for each
-	 * dependent device, or removed if this is an eject request.
-	 * This will cause acpi_drivers to be stopped/started if they
-	 * exist
+	 * Now make sure that an acpi_device is created for each dependent
+	 * device.  That will cause scan handlers to be attached to device
+	 * objects or acpi_drivers to be stopped/started if they are present.
 	 */
-	list_for_each_entry(dd, &ds->dependent_devices, list) {
-		if (event == ACPI_NOTIFY_EJECT_REQUEST)
-			dock_remove_acpi_device(dd->handle);
-		else
-			dock_create_acpi_device(dd->handle);
-	}
+	list_for_each_entry(dd, &ds->dependent_devices, list)
+		dock_create_acpi_device(dd->handle);
 }
 
 static void dock_event(struct dock_station *ds, u32 event, int num)
@@ -699,7 +712,7 @@ static int handle_eject_request(struct d
 	 */
 	dock_event(ds, event, UNDOCK_EVENT);
 
-	hotplug_dock_devices(ds, ACPI_NOTIFY_EJECT_REQUEST);
+	hot_remove_dock_devices(ds);
 	undock(ds);
 	dock_lock(ds, 0);
 	eject_dock(ds);
