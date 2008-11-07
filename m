From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/21] ACPI: struct device - replace bus_id with dev_name(),
 dev_set_name()
Date: Thu, 06 Nov 2008 23:39:21 -0500
Message-ID: <0794469da3f7b2093575cbdfc1108308dd3641ce.1226032677.git.len.brown@intel.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:64771 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbYKGEjj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:39:39 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9Y007OW4XW9281@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:39:33 -0600 (CST)
In-reply-to: <1226032765-15330-1-git-send-email-lenb@kernel.org>
In-reply-to: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kay Sievers <kay.sievers@vrfy.org>, Len Brown <len.brown@intel.com>

From: Kay Sievers <kay.sievers@vrfy.org>

This patch is part of a larger patch series which will remove
the "char bus_id[20]" name string from struct device. The device
name is managed in the kobject anyway, and without any size
limitation, and just needlessly copied into "struct device".

To set and read the device name dev_name(dev) and dev_set_name(dev)
must be used. If your code uses static kobjects, which it shouldn't
do, "const char *init_name" can be used to statically provide the
name the registered device should have. At registration time, the
init_name field is cleared, to enforce the use of dev_name(dev) to
access the device name at a later time.

We need to get rid of all occurrences of bus_id in the entire tree
to be able to enable the new interface. Please apply this patch,
and possibly convert any remaining remaining occurrences of bus_id.

We want to submit a patch to -next, which will remove bus_id from
"struct device", to find the remaining pieces to convert, and finally
switch over to the new api, which will remove the 20 bytes array
and does no longer have a size limitation.

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-Off-By: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ac.c             |    2 +-
 drivers/acpi/battery.c        |    2 +-
 drivers/acpi/processor_core.c |    6 +++---
 drivers/acpi/scan.c           |    8 ++++----
 drivers/acpi/sleep/proc.c     |    4 ++--
 drivers/acpi/thermal.c        |    8 ++++----
 drivers/acpi/wmi.c            |    2 +-
 7 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index d72a1b6..2d46732 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -242,7 +242,7 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 		acpi_ac_get_state(ac);
 		acpi_bus_generate_proc_event(device, event, (u32) ac->state);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  device->dev.bus_id, event,
+						  dev_name(&device->dev), event,
 						  (u32) ac->state);
 #ifdef CONFIG_ACPI_SYSFS_POWER
 		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b2133e8..e68f218 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -782,7 +782,7 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 	acpi_bus_generate_proc_event(device, event,
 				     acpi_battery_present(battery));
 	acpi_bus_generate_netlink_event(device->pnp.device_class,
-					device->dev.bus_id, event,
+					dev_name(&device->dev), event,
 					acpi_battery_present(battery));
 #ifdef CONFIG_ACPI_SYSFS_POWER
 	/* acpi_batter_update could remove power_supply object */
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 24a362f..cf7e885 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -761,20 +761,20 @@ static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)
 		acpi_bus_generate_proc_event(device, event,
 					pr->performance_platform_limit);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  device->dev.bus_id, event,
+						  dev_name(&device->dev), event,
 						  pr->performance_platform_limit);
 		break;
 	case ACPI_PROCESSOR_NOTIFY_POWER:
 		acpi_processor_cst_has_changed(pr);
 		acpi_bus_generate_proc_event(device, event, 0);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  device->dev.bus_id, event, 0);
+						  dev_name(&device->dev), event, 0);
 		break;
 	case ACPI_PROCESSOR_NOTIFY_THROTTLING:
 		acpi_processor_tstate_has_changed(pr);
 		acpi_bus_generate_proc_event(device, event, 0);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  device->dev.bus_id, event, 0);
+						  dev_name(&device->dev), event, 0);
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a9dda8e..4dd1f31 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -109,8 +109,7 @@ static int acpi_bus_hot_remove_device(void *context)
 		return 0;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-		"Hot-removing device %s...\n", device->dev.bus_id));
-
+		"Hot-removing device %s...\n", dev_name(&device->dev)));
 
 	if (acpi_bus_trim(device, 1)) {
 		printk(KERN_ERR PREFIX
@@ -460,7 +459,7 @@ static int acpi_device_register(struct acpi_device *device,
 		acpi_device_bus_id->instance_no = 0;
 		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
 	}
-	sprintf(device->dev.bus_id, "%s:%02x", acpi_device_bus_id->bus_id, acpi_device_bus_id->instance_no);
+	dev_set_name(&device->dev, "%s:%02x", acpi_device_bus_id->bus_id, acpi_device_bus_id->instance_no);
 
 	if (device->parent) {
 		list_add_tail(&device->node, &device->parent->children);
@@ -484,7 +483,8 @@ static int acpi_device_register(struct acpi_device *device,
 
 	result = acpi_device_setup_files(device);
 	if(result)
-		printk(KERN_ERR PREFIX "Error creating sysfs interface for device %s\n", device->dev.bus_id);
+		printk(KERN_ERR PREFIX "Error creating sysfs interface for device %s\n",
+		       dev_name(&device->dev));
 
 	device->removal_type = ACPI_BUS_REMOVAL_NORMAL;
 	return 0;
diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index 631ee2e..64e591b 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -366,8 +366,8 @@ acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 			   dev->wakeup.state.enabled ? "enabled" : "disabled");
 		if (ldev)
 			seq_printf(seq, "%s:%s",
-				   ldev->bus ? ldev->bus->name : "no-bus",
-				   ldev->bus_id);
+				   dev_name(ldev) ? ldev->bus->name : "no-bus",
+				   dev_name(ldev));
 		seq_printf(seq, "\n");
 		put_device(ldev);
 
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index ad6cae9..462b168 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -576,7 +576,7 @@ static int acpi_thermal_critical(struct acpi_thermal *tz)
 	acpi_bus_generate_proc_event(tz->device, ACPI_THERMAL_NOTIFY_CRITICAL,
 				tz->trips.critical.flags.enabled);
 	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
-					  tz->device->dev.bus_id,
+					  dev_name(&tz->device->dev),
 					  ACPI_THERMAL_NOTIFY_CRITICAL,
 					  tz->trips.critical.flags.enabled);
 
@@ -605,7 +605,7 @@ static int acpi_thermal_hot(struct acpi_thermal *tz)
 	acpi_bus_generate_proc_event(tz->device, ACPI_THERMAL_NOTIFY_HOT,
 				tz->trips.hot.flags.enabled);
 	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
-					  tz->device->dev.bus_id,
+					  dev_name(&tz->device->dev),
 					  ACPI_THERMAL_NOTIFY_HOT,
 					  tz->trips.hot.flags.enabled);
 
@@ -1592,14 +1592,14 @@ static void acpi_thermal_notify(acpi_handle handle, u32 event, void *data)
 		acpi_thermal_check(tz);
 		acpi_bus_generate_proc_event(device, event, 0);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  device->dev.bus_id, event, 0);
+						  dev_name(&device->dev), event, 0);
 		break;
 	case ACPI_THERMAL_NOTIFY_DEVICES:
 		acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_DEVICES);
 		acpi_thermal_check(tz);
 		acpi_bus_generate_proc_event(device, event, 0);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  device->dev.bus_id, event, 0);
+						  dev_name(&device->dev), event, 0);
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index 47cd7ba..8a8b377 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -660,7 +660,7 @@ static void acpi_wmi_notify(acpi_handle handle, u32 event, void *data)
 				wblock->handler(event, wblock->handler_data);
 
 			acpi_bus_generate_netlink_event(
-				device->pnp.device_class, device->dev.bus_id,
+				device->pnp.device_class, dev_name(&device->dev),
 				event, 0);
 			break;
 		}
-- 
1.5.6.5

