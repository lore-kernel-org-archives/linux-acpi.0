From: Alex Chiang <achiang@hp.com>
Subject: [PATCH, trivial] ACPI: dock: fix "sibiling" typo
Date: Thu, 1 Oct 2009 11:59:23 -0600
Message-ID: <20091001175923.GD31915@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:48763 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673AbZJAR7T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Oct 2009 13:59:19 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Crossword clues as haikus:

	Snakes from the same brood
	fighting Jackson on a plane?
	sibilant siblings

I guess Will Shortz's job is still secure.

Signed-off-by: Alex Chiang <achiang@hp.com>
---
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 3a2cfef..7338b6a 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -67,7 +67,7 @@ struct dock_station {
 	struct list_head dependent_devices;
 	struct list_head hotplug_devices;
 
-	struct list_head sibiling;
+	struct list_head sibling;
 	struct platform_device *dock_device;
 };
 static LIST_HEAD(dock_stations);
@@ -275,7 +275,7 @@ int is_dock_device(acpi_handle handle)
 
 	if (is_dock(handle))
 		return 1;
-	list_for_each_entry(dock_station, &dock_stations, sibiling) {
+	list_for_each_entry(dock_station, &dock_stations, sibling) {
 		if (find_dock_dependent_device(dock_station, handle))
 			return 1;
 	}
@@ -619,7 +619,7 @@ register_hotplug_dock_device(acpi_handle handle, struct acpi_dock_ops *ops,
 	 * make sure this handle is for a device dependent on the dock,
 	 * this would include the dock station itself
 	 */
-	list_for_each_entry(dock_station, &dock_stations, sibiling) {
+	list_for_each_entry(dock_station, &dock_stations, sibling) {
 		/*
 		 * An ATA bay can be in a dock and itself can be ejected
 		 * seperately, so there are two 'dock stations' which need the
@@ -651,7 +651,7 @@ void unregister_hotplug_dock_device(acpi_handle handle)
 	if (!dock_station_count)
 		return;
 
-	list_for_each_entry(dock_station, &dock_stations, sibiling) {
+	list_for_each_entry(dock_station, &dock_stations, sibling) {
 		dd = find_dock_dependent_device(dock_station, handle);
 		if (dd)
 			dock_del_hotplug_device(dock_station, dd);
@@ -787,7 +787,7 @@ static int acpi_dock_notifier_call(struct notifier_block *this,
 	if (event != ACPI_NOTIFY_BUS_CHECK && event != ACPI_NOTIFY_DEVICE_CHECK
 	   && event != ACPI_NOTIFY_EJECT_REQUEST)
 		return 0;
-	list_for_each_entry(dock_station, &dock_stations, sibiling) {
+	list_for_each_entry(dock_station, &dock_stations, sibling) {
 		if (dock_station->handle == handle) {
 			struct dock_data *dock_data;
 
@@ -958,7 +958,7 @@ static int dock_add(acpi_handle handle)
 	dock_station->last_dock_time = jiffies - HZ;
 	INIT_LIST_HEAD(&dock_station->dependent_devices);
 	INIT_LIST_HEAD(&dock_station->hotplug_devices);
-	INIT_LIST_HEAD(&dock_station->sibiling);
+	INIT_LIST_HEAD(&dock_station->sibling);
 	spin_lock_init(&dock_station->dd_lock);
 	mutex_init(&dock_station->hp_lock);
 	ATOMIC_INIT_NOTIFIER_HEAD(&dock_notifier_list);
@@ -1044,7 +1044,7 @@ static int dock_add(acpi_handle handle)
 	add_dock_dependent_device(dock_station, dd);
 
 	dock_station_count++;
-	list_add(&dock_station->sibiling, &dock_stations);
+	list_add(&dock_station->sibling, &dock_stations);
 	return 0;
 
 dock_add_err_unregister:
@@ -1149,7 +1149,7 @@ static void __exit dock_exit(void)
 	struct dock_station *tmp;
 
 	unregister_acpi_bus_notifier(&dock_acpi_notifier);
-	list_for_each_entry_safe(dock_station, tmp, &dock_stations, sibiling)
+	list_for_each_entry_safe(dock_station, tmp, &dock_stations, sibling)
 		dock_remove(dock_station);
 }
 
