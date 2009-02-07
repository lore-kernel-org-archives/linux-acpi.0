From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/30] ACPI: add missing KERN_* constants to printks
Date: Sat, 07 Feb 2009 01:41:33 -0500
Message-ID: <4d9391557b68475b118ec7626607c37b14ae8c16.1233988827.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:22518 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbZBGGmF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:42:05 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KEO00EHDNY2GDY2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:42:04 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Frank Seidel <frank@f-seidel.de>, Len Brown <len.brown@intel.com>

From: Frank Seidel <frank@f-seidel.de>

According to kerneljanitors todo list all printk calls (beginning
a new line) should have an according KERN_* constant.
Those are the missing peaces here for the acpi subsystem.

Signed-off-by: Frank Seidel <frank@f-seidel.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/container.c |    5 +++--
 drivers/acpi/dock.c      |    8 ++++----
 drivers/acpi/osl.c       |    4 ++--
 drivers/acpi/pci_link.c  |    2 +-
 drivers/acpi/sleep.c     |    2 +-
 drivers/acpi/video.c     |    2 +-
 6 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 17020c1..fe0cdf8 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -163,7 +163,7 @@ static void container_notify_cb(acpi_handle handle, u32 type, void *context)
 	case ACPI_NOTIFY_BUS_CHECK:
 		/* Fall through */
 	case ACPI_NOTIFY_DEVICE_CHECK:
-		printk("Container driver received %s event\n",
+		printk(KERN_WARNING "Container driver received %s event\n",
 		       (type == ACPI_NOTIFY_BUS_CHECK) ?
 		       "ACPI_NOTIFY_BUS_CHECK" : "ACPI_NOTIFY_DEVICE_CHECK");
 		status = acpi_bus_get_device(handle, &device);
@@ -174,7 +174,8 @@ static void container_notify_cb(acpi_handle handle, u32 type, void *context)
 					kobject_uevent(&device->dev.kobj,
 						       KOBJ_ONLINE);
 				else
-					printk("Failed to add container\n");
+					printk(KERN_WARNING
+					       "Failed to add container\n");
 			}
 		} else {
 			if (ACPI_SUCCESS(status)) {
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 5b30b8d..4083591 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -984,7 +984,7 @@ static int dock_add(acpi_handle handle)
 
 	ret = device_create_file(&dock_device->dev, &dev_attr_docked);
 	if (ret) {
-		printk("Error %d adding sysfs file\n", ret);
+		printk(KERN_ERR "Error %d adding sysfs file\n", ret);
 		platform_device_unregister(dock_device);
 		kfree(dock_station);
 		dock_station = NULL;
@@ -992,7 +992,7 @@ static int dock_add(acpi_handle handle)
 	}
 	ret = device_create_file(&dock_device->dev, &dev_attr_undock);
 	if (ret) {
-		printk("Error %d adding sysfs file\n", ret);
+		printk(KERN_ERR "Error %d adding sysfs file\n", ret);
 		device_remove_file(&dock_device->dev, &dev_attr_docked);
 		platform_device_unregister(dock_device);
 		kfree(dock_station);
@@ -1001,7 +1001,7 @@ static int dock_add(acpi_handle handle)
 	}
 	ret = device_create_file(&dock_device->dev, &dev_attr_uid);
 	if (ret) {
-		printk("Error %d adding sysfs file\n", ret);
+		printk(KERN_ERR "Error %d adding sysfs file\n", ret);
 		device_remove_file(&dock_device->dev, &dev_attr_docked);
 		device_remove_file(&dock_device->dev, &dev_attr_undock);
 		platform_device_unregister(dock_device);
@@ -1011,7 +1011,7 @@ static int dock_add(acpi_handle handle)
 	}
 	ret = device_create_file(&dock_device->dev, &dev_attr_flags);
 	if (ret) {
-		printk("Error %d adding sysfs file\n", ret);
+		printk(KERN_ERR "Error %d adding sysfs file\n", ret);
 		device_remove_file(&dock_device->dev, &dev_attr_docked);
 		device_remove_file(&dock_device->dev, &dev_attr_undock);
 		device_remove_file(&dock_device->dev, &dev_attr_uid);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 6729a49..1e35f34 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -228,10 +228,10 @@ void acpi_os_vprintf(const char *fmt, va_list args)
 	if (acpi_in_debugger) {
 		kdb_printf("%s", buffer);
 	} else {
-		printk("%s", buffer);
+		printk(KERN_CONT "%s", buffer);
 	}
 #else
-	printk("%s", buffer);
+	printk(KERN_CONT "%s", buffer);
 #endif
 }
 
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 1c6e73c..6c772ca 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -593,7 +593,7 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 		return -ENODEV;
 	} else {
 		acpi_irq_penalty[link->irq.active] += PIRQ_PENALTY_PCI_USING;
-		printk(PREFIX "%s [%s] enabled at IRQ %d\n",
+		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
 		       acpi_device_name(link->device),
 		       acpi_device_bid(link->device), link->irq.active);
 	}
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 7e3c609..dfc09c4 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -679,7 +679,7 @@ static void acpi_power_off_prepare(void)
 static void acpi_power_off(void)
 {
 	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
-	printk("%s called\n", __func__);
+	printk(KERN_DEBUG "%s called\n", __func__);
 	local_irq_disable();
 	acpi_enable_wakeup_device(ACPI_STATE_S5);
 	acpi_enter_sleep_state(ACPI_STATE_S5);
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index f261737..c6c99ea 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1260,7 +1260,7 @@ static int acpi_video_bus_POST_info_seq_show(struct seq_file *seq, void *offset)
 			printk(KERN_WARNING PREFIX
 			       "This indicates a BIOS bug. Please contact the manufacturer.\n");
 		}
-		printk("%llx\n", options);
+		printk(KERN_WARNING "%llx\n", options);
 		seq_printf(seq, "can POST: <integrated video>");
 		if (options & 2)
 			seq_printf(seq, " <PCI video>");
-- 
1.5.6.6

