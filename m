From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 1/9] ACPI: Add acpi_bus_generate_event4() function
Date: Sat, 01 Sep 2007 00:10:51 +0400
Message-ID: <20070831201051.27033.74238.stgit@z61m>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:47846 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753136AbXHaULW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Aug 2007 16:11:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

acpi_bus_generate_event() takes two strings out of passed device object.
SBS needs to supply these strings directly.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/bus.c      |   23 +++++++++++++++--------
 drivers/acpi/sbs.c      |   46 ++++++++++++++--------------------------------
 include/acpi/acpi_bus.h |    1 +
 3 files changed, 30 insertions(+), 40 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 9ba778a..a54234d 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -284,15 +284,11 @@ DECLARE_WAIT_QUEUE_HEAD(acpi_bus_event_queue);
 
 extern int event_is_open;
 
-int acpi_bus_generate_proc_event(struct acpi_device *device, u8 type, int data)
+int acpi_bus_generate_proc_event4(const char *device_class, const char *bus_id, u8 type, int data)
 {
-	struct acpi_bus_event *event = NULL;
+	struct acpi_bus_event *event;
 	unsigned long flags = 0;
 
-
-	if (!device)
-		return -EINVAL;
-
 	/* drop event on the floor if no one's listening */
 	if (!event_is_open)
 		return 0;
@@ -301,8 +297,8 @@ int acpi_bus_generate_proc_event(struct acpi_device *device, u8 type, int data)
 	if (!event)
 		return -ENOMEM;
 
-	strcpy(event->device_class, device->pnp.device_class);
-	strcpy(event->bus_id, device->pnp.bus_id);
+	strcpy(event->device_class, device_class);
+	strcpy(event->bus_id, bus_id);
 	event->type = type;
 	event->data = data;
 
@@ -313,6 +309,17 @@ int acpi_bus_generate_proc_event(struct acpi_device *device, u8 type, int data)
 	wake_up_interruptible(&acpi_bus_event_queue);
 
 	return 0;
+
+}
+
+EXPORT_SYMBOL_GPL(acpi_bus_generate_proc_event4);
+
+int acpi_bus_generate_proc_event(struct acpi_device *device, u8 type, int data)
+{
+	if (!device)
+		return -EINVAL;
+	return acpi_bus_generate_proc_event4(device->pnp.device_class,
+					     device->pnp.bus_id, type, data);
 }
 
 EXPORT_SYMBOL(acpi_bus_generate_proc_event);
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index a578986..33ba4bf 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -427,28 +427,6 @@ static int acpi_check_update_proc(struct acpi_sbs *sbs)
 	return 0;
 }
 
-static int acpi_sbs_generate_event(struct acpi_device *device,
-				   int event, int state, char *bid, char *class)
-{
-	char bid_saved[5];
-	char class_saved[20];
-	int result = 0;
-
-	strcpy(bid_saved, acpi_device_bid(device));
-	strcpy(class_saved, acpi_device_class(device));
-
-	strcpy(acpi_device_bid(device), bid);
-	strcpy(acpi_device_class(device), class);
-
-	result = acpi_bus_generate_proc_event(device, event, state);
-
-	strcpy(acpi_device_bid(device), bid_saved);
-	strcpy(acpi_device_class(device), class_saved);
-
-	acpi_bus_generate_netlink_event(class, bid, event, state);
-	return result;
-}
-
 static int acpi_battery_get_present(struct acpi_battery *battery)
 {
 	s16 state;
@@ -1452,15 +1430,17 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int id, int data_type)
 	}
 
 	if (do_ac_init) {
-		result = acpi_sbs_generate_event(sbs->device,
-						 ACPI_SBS_AC_NOTIFY_STATUS,
-						 new_ac_present,
+		result = acpi_bus_generate_proc_event4(ACPI_AC_CLASS,
 						 ACPI_AC_DIR_NAME,
-						 ACPI_AC_CLASS);
+						 ACPI_SBS_AC_NOTIFY_STATUS,
+						 new_ac_present);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-					"acpi_sbs_generate_event() failed"));
+					"acpi_bus_generate_event4() failed"));
 		}
+		acpi_bus_generate_netlink_event(ACPI_AC_CLASS, ACPI_AC_DIR_NAME,
+						ACPI_SBS_AC_NOTIFY_STATUS,
+						new_ac_present);
 	}
 
 	if (data_type == DATA_TYPE_COMMON) {
@@ -1568,14 +1548,16 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int id, int data_type)
 		    old_remaining_capacity !=
 		    battery->state.remaining_capacity) {
 			sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
-			result = acpi_sbs_generate_event(sbs->device,
-							 ACPI_SBS_BATTERY_NOTIFY_STATUS,
-							 new_battery_present,
+			result = acpi_bus_generate_proc_event4(ACPI_BATTERY_CLASS,
 							 dir_name,
-							 ACPI_BATTERY_CLASS);
+							 ACPI_SBS_BATTERY_NOTIFY_STATUS,
+							 new_battery_present);
+			acpi_bus_generate_netlink_event(ACPI_BATTERY_CLASS, dir_name,
+							ACPI_SBS_BATTERY_NOTIFY_STATUS,
+							new_battery_present);
 			if (result) {
 				ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-						"acpi_sbs_generate_event() "
+						"acpi_bus_generate_proc_event4() "
 						"failed"));
 			}
 		}
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 86aea44..8a388e7 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -333,6 +333,7 @@ int acpi_bus_get_power(acpi_handle handle, int *state);
 int acpi_bus_set_power(acpi_handle handle, int state);
 #ifdef CONFIG_ACPI_PROC_EVENT
 int acpi_bus_generate_proc_event(struct acpi_device *device, u8 type, int data);
+int acpi_bus_generate_proc_event4(const char *class, const char *bid, u8 type, int data);
 int acpi_bus_receive_event(struct acpi_bus_event *event);
 #else
 static inline int acpi_bus_generate_proc_event(struct acpi_device *device, u8 type, int data)

