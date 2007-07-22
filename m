From: Len Brown <len.brown@intel.com>
Subject: [PATCH 09/77] ACPI: dock: add immediate_undock option
Date: Sun, 22 Jul 2007 05:13:54 -0400
Message-ID: <11850957111797-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38395 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762169AbXGVJPN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:13 -0400
In-Reply-To: <11850957102641-git-send-email-len.brown@intel.com>
Message-Id: <a0cd35fdca0bb711854edeaf016cec6cdf82eeca.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <len.brown@intel.com>

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Allow the driver to be loaded with an option that will allow userspace to
control whether the laptop is ejected immediately when the user presses the
button, or only when the syfs undock file is written.

if immediate_undock == 1, then when the user presses the undock button, the
laptop will send an event to userspace to notify userspace of the undock, but
then immediately undock without waiting for userspace.  This is the current
behavior, and I set this to be the default.

if immediate_undock == 0, then when the user presses the undock button, the
laptop will send an event to userspace and do nothing.  User space can query
the "flags" sysfs entry to determine if an undock request has been made by
the user (if bit 1 is set).  User space will then need to write the undock
sysfs entry to complete the undocking process.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index b5addd4..98ec717 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -40,6 +40,13 @@ MODULE_AUTHOR("Kristen Carlson Accardi");
 MODULE_DESCRIPTION(ACPI_DOCK_DRIVER_DESCRIPTION);
 MODULE_LICENSE("GPL");
 
+static int immediate_undock = 1;
+module_param(immediate_undock, bool, 0644);
+MODULE_PARM_DESC(immediate_undock, "1 (default) will cause the driver to "
+	"undock immediately when the undock button is pressed, 0 will cause"
+	" the driver to wait for userspace to write the undock sysfs file "
+	" before undocking");
+
 static struct atomic_notifier_head dock_notifier_list;
 static struct platform_device *dock_device;
 static char dock_device_name[] = "dock";
@@ -63,6 +70,7 @@ struct dock_dependent_device {
 };
 
 #define DOCK_DOCKING	0x00000001
+#define DOCK_UNDOCKING  0x00000002
 #define DOCK_EVENT	3
 #define UNDOCK_EVENT	2
 
@@ -420,6 +428,16 @@ static inline void complete_dock(struct dock_station *ds)
 	ds->last_dock_time = jiffies;
 }
 
+static inline void begin_undock(struct dock_station *ds)
+{
+	ds->flags |= DOCK_UNDOCKING;
+}
+
+static inline void complete_undock(struct dock_station *ds)
+{
+	ds->flags &= ~(DOCK_UNDOCKING);
+}
+
 /**
  * dock_in_progress - see if we are in the middle of handling a dock event
  * @ds: the dock station
@@ -550,7 +568,7 @@ static int handle_eject_request(struct dock_station *ds, u32 event)
 		printk(KERN_ERR PREFIX "Unable to undock!\n");
 		return -EBUSY;
 	}
-
+	complete_undock(ds);
 	return 0;
 }
 
@@ -594,7 +612,11 @@ static void dock_notify(acpi_handle handle, u32 event, void *data)
 	 * to the driver who wish to hotplug.
          */
 	case ACPI_NOTIFY_EJECT_REQUEST:
-		handle_eject_request(ds, event);
+		begin_undock(ds);
+		if (immediate_undock)
+			handle_eject_request(ds, event);
+		else
+			dock_event(ds, event, UNDOCK_EVENT);
 		break;
 	default:
 		printk(KERN_ERR PREFIX "Unknown dock event %d\n", event);
@@ -653,6 +675,17 @@ static ssize_t show_docked(struct device *dev,
 DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
 
 /*
+ * show_flags - read method for flags file in sysfs
+ */
+static ssize_t show_flags(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", dock_station->flags);
+
+}
+DEVICE_ATTR(flags, S_IRUGO, show_flags, NULL);
+
+/*
  * write_undock - write method for "undock" file in sysfs
  */
 static ssize_t write_undock(struct device *dev, struct device_attribute *attr,
@@ -717,6 +750,7 @@ static int dock_add(acpi_handle handle)
 		dock_station = NULL;
 		return PTR_ERR(dock_device);
 	}
+
 	ret = device_create_file(&dock_device->dev, &dev_attr_docked);
 	if (ret) {
 		printk("Error %d adding sysfs file\n", ret);
@@ -744,6 +778,17 @@ static int dock_add(acpi_handle handle)
 		dock_station = NULL;
 		return ret;
 	}
+	ret = device_create_file(&dock_device->dev, &dev_attr_flags);
+	if (ret) {
+		printk("Error %d adding sysfs file\n", ret);
+		device_remove_file(&dock_device->dev, &dev_attr_docked);
+		device_remove_file(&dock_device->dev, &dev_attr_undock);
+		device_remove_file(&dock_device->dev, &dev_attr_uid);
+		platform_device_unregister(dock_device);
+		kfree(dock_station);
+		dock_station = NULL;
+		return ret;
+	}
 
 	/* Find dependent devices */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
@@ -781,6 +826,7 @@ dock_add_err_unregister:
 	device_remove_file(&dock_device->dev, &dev_attr_docked);
 	device_remove_file(&dock_device->dev, &dev_attr_undock);
 	device_remove_file(&dock_device->dev, &dev_attr_uid);
+	device_remove_file(&dock_device->dev, &dev_attr_flags);
 	platform_device_unregister(dock_device);
 	kfree(dock_station);
 	dock_station = NULL;
@@ -814,6 +860,7 @@ static int dock_remove(void)
 	device_remove_file(&dock_device->dev, &dev_attr_docked);
 	device_remove_file(&dock_device->dev, &dev_attr_undock);
 	device_remove_file(&dock_device->dev, &dev_attr_uid);
+	device_remove_file(&dock_device->dev, &dev_attr_flags);
 	platform_device_unregister(dock_device);
 
 	/* free dock station memory */
-- 
1.5.3.rc2.22.g69a9b
