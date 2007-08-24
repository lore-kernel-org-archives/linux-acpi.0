From: Len Brown <len.brown@intel.com>
Subject: [PATCH 08/25] ACPI: Schedule /proc/acpi/event for removal
Date: Fri, 24 Aug 2007 03:20:55 -0400
Message-ID: <11879400841550-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
 <11879400794174-git-send-email-len.brown@intel.com>
 <11879400802531-git-send-email-len.brown@intel.com>
 <11879400812208-git-send-email-len.brown@intel.com>
 <11879400823500-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12497 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759989AbXHXHV0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:26 -0400
In-Reply-To: <11879400823500-git-send-email-len.brown@intel.com>
Message-Id: <14e04fb34ffa82ee61ae69f98d8fca12d2e8e31c.1187939442.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

Schedule /proc/acpi/event for removal in 6 months.

Re-name acpi_bus_generate_event() to acpi_bus_generate_proc_event()
to make sure there is no confusion that it is for /proc/acpi/event only.

Add CONFIG_ACPI_PROC_EVENT to allow removal of /proc/acpi/event.
There is no functional change if CONFIG_ACPI_PROC_EVENT=y

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/feature-removal-schedule.txt |    8 ++++++++
 drivers/acpi/Kconfig                       |   14 ++++++++++++++
 drivers/acpi/ac.c                          |    2 +-
 drivers/acpi/asus_acpi.c                   |    2 +-
 drivers/acpi/battery.c                     |    2 +-
 drivers/acpi/bus.c                         |    6 ++++--
 drivers/acpi/button.c                      |    2 +-
 drivers/acpi/event.c                       |    6 ++++++
 drivers/acpi/processor_core.c              |    6 +++---
 drivers/acpi/sbs.c                         |    2 +-
 drivers/acpi/thermal.c                     |    8 ++++----
 drivers/acpi/video.c                       |   10 +++++-----
 drivers/char/sonypi.c                      |    2 +-
 drivers/misc/asus-laptop.c                 |    2 +-
 drivers/misc/sony-laptop.c                 |    4 ++--
 drivers/misc/thinkpad_acpi.c               |    8 ++++----
 drivers/pci/hotplug/acpiphp_ibm.c          |    2 +-
 include/acpi/acpi_bus.h                    |    7 ++++++-
 18 files changed, 64 insertions(+), 29 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index a43d287..b9a3fdc 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -197,6 +197,14 @@ Who:	Len Brown <len.brown@intel.com>
 
 ---------------------------
 
+What:	/proc/acpi/event
+When:	February 2008
+Why:	/proc/acpi/event has been replaced by events via the input layer
+	and netlink since 2.6.23.
+Who:	Len Brown <len.brown@intel.com>
+
+---------------------------
+
 What:	Compaq touchscreen device emulation
 When:	Oct 2007
 Files:	drivers/input/tsdev.c
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f1372de..5742594 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -68,6 +68,20 @@ config ACPI_PROCFS
 
 	  Say N to delete /proc/acpi/ files that have moved to /sys/
 
+config ACPI_PROC_EVENT
+	bool "Deprecated /proc/acpi/event support"
+	depends on PROC_FS
+	---help---
+	  A user-space daemon, acpi, typically read /proc/acpi/event
+	  and handled all ACPI sub-system generated events.
+
+	  These events are now delivered to user-space via
+	  either the input layer, or as netlink events.
+
+	  This build option enables the old code for for legacy
+	  user-space implementation.  After some time, this will
+	  be moved under CONFIG_ACPI_PROCFS, and then deleted.
+
 config ACPI_AC
 	tristate "AC Adapter"
 	depends on X86
diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index b53c2cf..26d7070 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -204,7 +204,7 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		acpi_ac_get_state(ac);
-		acpi_bus_generate_event(device, event, (u32) ac->state);
+		acpi_bus_generate_proc_event(device, event, (u32) ac->state);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						  device->dev.bus_id, event,
 						  (u32) ac->state);
diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index 86fd142..d915fec 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -1069,7 +1069,7 @@ static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 		hotk->brightness = (event & ~((u32) BR_DOWN));
 	}
 
-	acpi_bus_generate_event(hotk->device, event,
+	acpi_bus_generate_proc_event(hotk->device, event,
 				hotk->event_count[event % 128]++);
 
 	return;
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 9f0bf90..91dc4b3 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -867,7 +867,7 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		device = battery->device;
 		acpi_battery_notify_update(battery);
-		acpi_bus_generate_event(device, event,
+		acpi_bus_generate_proc_event(device, event,
 					acpi_battery_present(battery));
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						  device->dev.bus_id, event,
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index e5084ec..9ba778a 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -276,6 +276,7 @@ EXPORT_SYMBOL(acpi_bus_set_power);
                                 Event Management
    -------------------------------------------------------------------------- */
 
+#ifdef CONFIG_ACPI_PROC_EVENT
 static DEFINE_SPINLOCK(acpi_bus_event_lock);
 
 LIST_HEAD(acpi_bus_event_list);
@@ -283,7 +284,7 @@ DECLARE_WAIT_QUEUE_HEAD(acpi_bus_event_queue);
 
 extern int event_is_open;
 
-int acpi_bus_generate_event(struct acpi_device *device, u8 type, int data)
+int acpi_bus_generate_proc_event(struct acpi_device *device, u8 type, int data)
 {
 	struct acpi_bus_event *event = NULL;
 	unsigned long flags = 0;
@@ -314,7 +315,7 @@ int acpi_bus_generate_event(struct acpi_device *device, u8 type, int data)
 	return 0;
 }
 
-EXPORT_SYMBOL(acpi_bus_generate_event);
+EXPORT_SYMBOL(acpi_bus_generate_proc_event);
 
 int acpi_bus_receive_event(struct acpi_bus_event *event)
 {
@@ -360,6 +361,7 @@ int acpi_bus_receive_event(struct acpi_bus_event *event)
 }
 
 EXPORT_SYMBOL(acpi_bus_receive_event);
+#endif	/* CONFIG_ACPI_PROC_EVENT */
 
 /* --------------------------------------------------------------------------
                              Notification Handling
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 5405813..2e79a33 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -284,7 +284,7 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 		}
 		input_sync(input);
 
-		acpi_bus_generate_event(button->device, event,
+		acpi_bus_generate_proc_event(button->device, event,
 					++button->pushed);
 		break;
 	default:
diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index b7b1432..cf6d516 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -17,6 +17,7 @@
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("event");
 
+#ifdef CONFIG_ACPI_PROC_EVENT
 /* Global vars for handling event proc entry */
 static DEFINE_SPINLOCK(acpi_system_event_lock);
 int event_is_open = 0;
@@ -106,6 +107,7 @@ static const struct file_operations acpi_system_event_ops = {
 	.release = acpi_system_close_event,
 	.poll = acpi_system_poll_event,
 };
+#endif	/* CONFIG_ACPI_PROC_EVENT */
 
 #ifdef CONFIG_NET
 static unsigned int acpi_event_seqnum;
@@ -247,7 +249,9 @@ static int acpi_event_genetlink_init(void)
 
 static int __init acpi_event_init(void)
 {
+#ifdef CONFIG_ACPI_PROC_EVENT
 	struct proc_dir_entry *entry;
+#endif
 	int error = 0;
 
 	if (acpi_disabled)
@@ -259,12 +263,14 @@ static int __init acpi_event_init(void)
 		printk(KERN_WARNING PREFIX
 		       "Failed to create genetlink family for ACPI event\n");
 
+#ifdef CONFIG_ACPI_PROC_EVENT
 	/* 'event' [R] */
 	entry = create_proc_entry("event", S_IRUSR, acpi_root_dir);
 	if (entry)
 		entry->proc_fops = &acpi_system_event_ops;
 	else
 		return -ENODEV;
+#endif
 
 	return 0;
 }
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index dbc2e5d..e944aae 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -698,7 +698,7 @@ static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)
 	switch (event) {
 	case ACPI_PROCESSOR_NOTIFY_PERFORMANCE:
 		acpi_processor_ppc_has_changed(pr);
-		acpi_bus_generate_event(device, event,
+		acpi_bus_generate_proc_event(device, event,
 					pr->performance_platform_limit);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						  device->dev.bus_id, event,
@@ -706,13 +706,13 @@ static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)
 		break;
 	case ACPI_PROCESSOR_NOTIFY_POWER:
 		acpi_processor_cst_has_changed(pr);
-		acpi_bus_generate_event(device, event, 0);
+		acpi_bus_generate_proc_event(device, event, 0);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						  device->dev.bus_id, event, 0);
 		break;
 	case ACPI_PROCESSOR_NOTIFY_THROTTLING:
 		acpi_processor_tstate_has_changed(pr);
-		acpi_bus_generate_event(device, event, 0);
+		acpi_bus_generate_proc_event(device, event, 0);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						  device->dev.bus_id, event, 0);
 	default:
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 2d67e92..a578986 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -440,7 +440,7 @@ static int acpi_sbs_generate_event(struct acpi_device *device,
 	strcpy(acpi_device_bid(device), bid);
 	strcpy(acpi_device_class(device), class);
 
-	result = acpi_bus_generate_event(device, event, state);
+	result = acpi_bus_generate_proc_event(device, event, state);
 
 	strcpy(acpi_device_bid(device), bid_saved);
 	strcpy(acpi_device_class(device), class_saved);
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 291758c..2c9cfe2 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -485,7 +485,7 @@ static int acpi_thermal_critical(struct acpi_thermal *tz)
 	printk(KERN_EMERG
 	       "Critical temperature reached (%ld C), shutting down.\n",
 	       KELVIN_TO_CELSIUS(tz->temperature));
-	acpi_bus_generate_event(tz->device, ACPI_THERMAL_NOTIFY_CRITICAL,
+	acpi_bus_generate_proc_event(tz->device, ACPI_THERMAL_NOTIFY_CRITICAL,
 				tz->trips.critical.flags.enabled);
 	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
 					  tz->device->dev.bus_id,
@@ -508,7 +508,7 @@ static int acpi_thermal_hot(struct acpi_thermal *tz)
 	} else if (tz->trips.hot.flags.enabled)
 		tz->trips.hot.flags.enabled = 0;
 
-	acpi_bus_generate_event(tz->device, ACPI_THERMAL_NOTIFY_HOT,
+	acpi_bus_generate_proc_event(tz->device, ACPI_THERMAL_NOTIFY_HOT,
 				tz->trips.hot.flags.enabled);
 	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
 					  tz->device->dev.bus_id,
@@ -1157,14 +1157,14 @@ static void acpi_thermal_notify(acpi_handle handle, u32 event, void *data)
 	case ACPI_THERMAL_NOTIFY_THRESHOLDS:
 		acpi_thermal_get_trip_points(tz);
 		acpi_thermal_check(tz);
-		acpi_bus_generate_event(device, event, 0);
+		acpi_bus_generate_proc_event(device, event, 0);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						  device->dev.bus_id, event, 0);
 		break;
 	case ACPI_THERMAL_NOTIFY_DEVICES:
 		if (tz->flags.devices)
 			acpi_thermal_get_devices(tz);
-		acpi_bus_generate_event(device, event, 0);
+		acpi_bus_generate_proc_event(device, event, 0);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						  device->dev.bus_id, event, 0);
 		break;
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index d987019..9a5cfcf 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1775,7 +1775,7 @@ static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 	switch (event) {
 	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User requested a switch,
 					 * most likely via hotkey. */
-		acpi_bus_generate_event(device, event, 0);
+		acpi_bus_generate_proc_event(device, event, 0);
 		break;
 
 	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plugged in or removed a video
@@ -1783,14 +1783,14 @@ static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 		acpi_video_device_enumerate(video);
 		acpi_video_device_rebind(video);
 		acpi_video_switch_output(video, event);
-		acpi_bus_generate_event(device, event, 0);
+		acpi_bus_generate_proc_event(device, event, 0);
 		break;
 
 	case ACPI_VIDEO_NOTIFY_CYCLE:	/* Cycle Display output hotkey pressed. */
 	case ACPI_VIDEO_NOTIFY_NEXT_OUTPUT:	/* Next Display output hotkey pressed. */
 	case ACPI_VIDEO_NOTIFY_PREV_OUTPUT:	/* previous Display output hotkey pressed. */
 		acpi_video_switch_output(video, event);
-		acpi_bus_generate_event(device, event, 0);
+		acpi_bus_generate_proc_event(device, event, 0);
 		break;
 
 	default:
@@ -1815,7 +1815,7 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 	switch (event) {
 	case ACPI_VIDEO_NOTIFY_SWITCH:	/* change in status (cycle output device) */
 	case ACPI_VIDEO_NOTIFY_PROBE:	/* change in status (output device status) */
-		acpi_bus_generate_event(device, event, 0);
+		acpi_bus_generate_proc_event(device, event, 0);
 		break;
 	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:	/* Cycle brightness */
 	case ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS:	/* Increase brightness */
@@ -1823,7 +1823,7 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 	case ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS:	/* zero brightnesss */
 	case ACPI_VIDEO_NOTIFY_DISPLAY_OFF:	/* display device off */
 		acpi_video_switch_brightness(video_device, event);
-		acpi_bus_generate_event(device, event, 0);
+		acpi_bus_generate_proc_event(device, event, 0);
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index aeec67e..8598585 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -875,7 +875,7 @@ found:
 
 #ifdef CONFIG_ACPI
 	if (sonypi_acpi_device)
-		acpi_bus_generate_event(sonypi_acpi_device, 1, event);
+		acpi_bus_generate_proc_event(sonypi_acpi_device, 1, event);
 #endif
 
 	kfifo_put(sonypi_device.fifo, (unsigned char *)&event, sizeof(event));
diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index d0fc4fd..f8ae58f 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -732,7 +732,7 @@ static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 		lcd_blank(FB_BLANK_POWERDOWN);
 	}
 
-	acpi_bus_generate_event(hotk->device, event,
+	acpi_bus_generate_proc_event(hotk->device, event,
 				hotk->event_count[event % 128]++);
 
 	return;
diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 91da688..743bd49 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -904,7 +904,7 @@ static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 
 	dprintk("sony_acpi_notify, event: 0x%.2x\n", ev);
 	sony_laptop_report_input_event(ev);
-	acpi_bus_generate_event(sony_nc_acpi_device, 1, ev);
+	acpi_bus_generate_proc_event(sony_nc_acpi_device, 1, ev);
 }
 
 static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
@@ -2292,7 +2292,7 @@ static irqreturn_t sony_pic_irq(int irq, void *dev_id)
 
 found:
 	sony_laptop_report_input_event(device_event);
-	acpi_bus_generate_event(spic_dev.acpi_dev, 1, device_event);
+	acpi_bus_generate_proc_event(spic_dev.acpi_dev, 1, device_event);
 	sonypi_compat_report_event(device_event);
 
 	return IRQ_HANDLED;
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index d0825a3..bb8956d 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1190,10 +1190,10 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 		}
 
 		if (sendacpi)
-			acpi_bus_generate_event(ibm->acpi->device, event, hkey);
+			acpi_bus_generate_proc_event(ibm->acpi->device, event, hkey);
 	} else {
 		printk(IBM_ERR "unknown hotkey notification event %d\n", event);
-		acpi_bus_generate_event(ibm->acpi->device, event, 0);
+		acpi_bus_generate_proc_event(ibm->acpi->device, event, 0);
 	}
 }
 
@@ -2179,7 +2179,7 @@ static void dock_notify(struct ibm_struct *ibm, u32 event)
 		       event, _sta(dock_handle));
 		data = 0;	/* unknown */
 	}
-	acpi_bus_generate_event(ibm->acpi->device, event, data);
+	acpi_bus_generate_proc_event(ibm->acpi->device, event, data);
 	acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
 					  ibm->acpi->device->dev.bus_id,
 					  event, data);
@@ -2280,7 +2280,7 @@ static int __init bay_init(struct ibm_init_struct *iibm)
 
 static void bay_notify(struct ibm_struct *ibm, u32 event)
 {
-	acpi_bus_generate_event(ibm->acpi->device, event, 0);
+	acpi_bus_generate_proc_event(ibm->acpi->device, event, 0);
 	acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
 					  ibm->acpi->device->dev.bus_id,
 					  event, 0);
diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index 3609024..d2c410c 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -267,7 +267,7 @@ static void ibm_handle_events(acpi_handle handle, u32 event, void *context)
 
 	if (subevent == 0x80) {
 		dbg("%s: generationg bus event\n", __FUNCTION__);
-		acpi_bus_generate_event(note->device, note->event, detail);
+		acpi_bus_generate_proc_event(note->device, note->event, detail);
 		acpi_bus_generate_netlink_event(note->device->pnp.device_class,
 						  note->device->dev.bus_id,
 						  note->event, detail);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 8203cdd..86aea44 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -331,8 +331,13 @@ void acpi_bus_data_handler(acpi_handle handle, u32 function, void *context);
 int acpi_bus_get_status(struct acpi_device *device);
 int acpi_bus_get_power(acpi_handle handle, int *state);
 int acpi_bus_set_power(acpi_handle handle, int state);
-int acpi_bus_generate_event(struct acpi_device *device, u8 type, int data);
+#ifdef CONFIG_ACPI_PROC_EVENT
+int acpi_bus_generate_proc_event(struct acpi_device *device, u8 type, int data);
 int acpi_bus_receive_event(struct acpi_bus_event *event);
+#else
+static inline int acpi_bus_generate_proc_event(struct acpi_device *device, u8 type, int data)
+	{ return 0; }
+#endif
 int acpi_bus_register_driver(struct acpi_driver *driver);
 void acpi_bus_unregister_driver(struct acpi_driver *driver);
 int acpi_bus_add(struct acpi_device **child, struct acpi_device *parent,
-- 
1.5.3.rc6.17.g1911
