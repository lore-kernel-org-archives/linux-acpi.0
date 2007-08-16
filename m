From: Alexey Starikovskiy <astarikivskiy@suse.de>
Subject: [PATCH 06/12] ACPI: Add acpi_bus_generate_event4() function
Date: Thu, 16 Aug 2007 18:26:28 +0400
Message-ID: <20070816142628.20279.83295.stgit@z61m>
References: <20070816142558.20279.46194.stgit@z61m>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:38526 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755732AbXHPO0h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Aug 2007 10:26:37 -0400
In-Reply-To: <20070816142558.20279.46194.stgit@z61m>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: astarikovskiy@suse.de

From: Alexey Starikovskiy <astarikovskiy@suse.de>

acpi_bus_generate_event() takes two strings out of passed device object.
SBS needs to supply these strings directly.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/bus.c      |   25 ++++++++++++++++---------
 drivers/acpi/event.c    |    7 ++++---
 drivers/acpi/sbs.c      |   39 ++++++++-------------------------------
 include/acpi/acpi_bus.h |    6 ++++--
 4 files changed, 32 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 6b2658c..992bb30 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -283,16 +283,12 @@ DECLARE_WAIT_QUEUE_HEAD(acpi_bus_event_queue);
 
 extern int event_is_open;
 
-int acpi_bus_generate_event(struct acpi_device *device, u8 type, int data)
+int acpi_bus_generate_event4(const char *device_class, const char *bus_id, u8 type, int data)
 {
-	struct acpi_bus_event *event = NULL;
+	struct acpi_bus_event *event;
 	unsigned long flags = 0;
 
-
-	if (!device)
-		return -EINVAL;
-
-	if (acpi_bus_generate_genetlink_event(device, type, data))
+	if (acpi_bus_generate_genetlink_event(device_class, bus_id, type, data))
 		printk(KERN_WARNING PREFIX
 			"Failed to generate an ACPI event via genetlink!\n");
 
@@ -304,8 +300,8 @@ int acpi_bus_generate_event(struct acpi_device *device, u8 type, int data)
 	if (!event)
 		return -ENOMEM;
 
-	strcpy(event->device_class, device->pnp.device_class);
-	strcpy(event->bus_id, device->pnp.bus_id);
+	strcpy(event->device_class, device_class);
+	strcpy(event->bus_id, bus_id);
 	event->type = type;
 	event->data = data;
 
@@ -316,6 +312,17 @@ int acpi_bus_generate_event(struct acpi_device *device, u8 type, int data)
 	wake_up_interruptible(&acpi_bus_event_queue);
 
 	return 0;
+
+}
+
+EXPORT_SYMBOL_GPL(acpi_bus_generate_event4);
+
+int acpi_bus_generate_event(struct acpi_device *device, u8 type, int data)
+{
+	if (!device)
+		return -EINVAL;
+	return acpi_bus_generate_event4(device->pnp.device_class,
+					device->pnp.bus_id, type, data);
 }
 
 EXPORT_SYMBOL(acpi_bus_generate_event);
diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index 95637a4..6529280 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -147,7 +147,8 @@ static struct genl_multicast_group acpi_event_mcgrp = {
 	.name = ACPI_GENL_MCAST_GROUP_NAME,
 };
 
-int acpi_bus_generate_genetlink_event(struct acpi_device *device,
+int acpi_bus_generate_genetlink_event(const char *device_class,
+				      const char *bus_id,
 				      u8 type, int data)
 {
 	struct sk_buff *skb;
@@ -191,8 +192,8 @@ int acpi_bus_generate_genetlink_event(struct acpi_device *device,
 
 	memset(event, 0, sizeof(struct acpi_genl_event));
 
-	strcpy(event->device_class, device->pnp.device_class);
-	strcpy(event->bus_id, device->dev.bus_id);
+	strcpy(event->device_class, device_class);
+	strcpy(event->bus_id, bus_id);
 	event->type = type;
 	event->data = data;
 
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 82c3a55..88af657 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -427,27 +427,6 @@ static int acpi_check_update_proc(struct acpi_sbs *sbs)
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
-	result = acpi_bus_generate_event(device, event, state);
-
-	strcpy(acpi_device_bid(device), bid_saved);
-	strcpy(acpi_device_class(device), class_saved);
-
-	return result;
-}
-
 static int acpi_battery_get_present(struct acpi_battery *battery)
 {
 	s16 state;
@@ -1451,14 +1430,13 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int id, int data_type)
 	}
 
 	if (do_ac_init) {
-		result = acpi_sbs_generate_event(sbs->device,
-						 ACPI_SBS_AC_NOTIFY_STATUS,
-						 new_ac_present,
+		result = acpi_bus_generate_event4(ACPI_AC_CLASS,
 						 ACPI_AC_DIR_NAME,
-						 ACPI_AC_CLASS);
+						 ACPI_SBS_AC_NOTIFY_STATUS,
+						 new_ac_present);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-					"acpi_sbs_generate_event() failed"));
+					"acpi_bus_generate_event4() failed"));
 		}
 	}
 
@@ -1567,14 +1545,13 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int id, int data_type)
 		    old_remaining_capacity !=
 		    battery->state.remaining_capacity) {
 			sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
-			result = acpi_sbs_generate_event(sbs->device,
-							 ACPI_SBS_BATTERY_NOTIFY_STATUS,
-							 new_battery_present,
+			result = acpi_bus_generate_event4(ACPI_BATTERY_CLASS,
 							 dir_name,
-							 ACPI_BATTERY_CLASS);
+							 ACPI_SBS_BATTERY_NOTIFY_STATUS,
+							 new_battery_present);
 			if (result) {
 				ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-						"acpi_sbs_generate_event() "
+						"acpi_bus_generate_event4() "
 						"failed"));
 			}
 		}
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 3d0fea2..0878928 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -321,8 +321,9 @@ struct acpi_bus_event {
 };
 
 extern struct kset acpi_subsys;
-extern int acpi_bus_generate_genetlink_event(struct acpi_device *device,
-						u8 type, int data);
+extern int acpi_bus_generate_genetlink_event(const char *device_class,
+					     const char *bus_id,
+					     u8 type, int data);
 /*
  * External Functions
  */
@@ -333,6 +334,7 @@ int acpi_bus_get_status(struct acpi_device *device);
 int acpi_bus_get_power(acpi_handle handle, int *state);
 int acpi_bus_set_power(acpi_handle handle, int state);
 int acpi_bus_generate_event(struct acpi_device *device, u8 type, int data);
+int acpi_bus_generate_event4(const char *class, const char *bid, u8 type, int data);
 int acpi_bus_receive_event(struct acpi_bus_event *event);
 int acpi_bus_register_driver(struct acpi_driver *driver);
 void acpi_bus_unregister_driver(struct acpi_driver *driver);

