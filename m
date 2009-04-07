From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/17] ACPI: convert acpi_device_lock spinlock to mutex
Date: Tue, 07 Apr 2009 19:04:09 -0400
Message-ID: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
References: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:26231 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbZDGXEh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:04:37 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR003UI6RGAIGE@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 18:04:30 -0500 (CDT)
In-reply-to: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

Convert acpi_device_lock to a mutex to avoid
a potential race upon access to /proc/acpi/wakeup

Delete the lock entirely in wakeup.c
since it is not necessary (and can not sleep)

Found-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/proc.c   |   13 ++++---------
 drivers/acpi/scan.c   |   14 +++++++-------
 drivers/acpi/sleep.h  |    3 +++
 drivers/acpi/wakeup.c |   30 +++++++-----------------------
 4 files changed, 21 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 05dfdc9..d0d550d 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -343,9 +343,6 @@ acpi_system_write_alarm(struct file *file,
 }
 #endif				/* HAVE_ACPI_LEGACY_ALARM */
 
-extern struct list_head acpi_wakeup_device_list;
-extern spinlock_t acpi_device_lock;
-
 static int
 acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 {
@@ -353,7 +350,7 @@ acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 
 	seq_printf(seq, "Device\tS-state\t  Status   Sysfs node\n");
 
-	spin_lock(&acpi_device_lock);
+	mutex_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =
 		    container_of(node, struct acpi_device, wakeup_list);
@@ -361,7 +358,6 @@ acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 
 		if (!dev->wakeup.flags.valid)
 			continue;
-		spin_unlock(&acpi_device_lock);
 
 		ldev = acpi_get_physical_device(dev->handle);
 		seq_printf(seq, "%s\t  S%d\t%c%-8s  ",
@@ -376,9 +372,8 @@ acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 		seq_printf(seq, "\n");
 		put_device(ldev);
 
-		spin_lock(&acpi_device_lock);
 	}
-	spin_unlock(&acpi_device_lock);
+	mutex_unlock(&acpi_device_lock);
 	return 0;
 }
 
@@ -409,7 +404,7 @@ acpi_system_write_wakeup_device(struct file *file,
 	strbuf[len] = '\0';
 	sscanf(strbuf, "%s", str);
 
-	spin_lock(&acpi_device_lock);
+	mutex_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =
 		    container_of(node, struct acpi_device, wakeup_list);
@@ -446,7 +441,7 @@ acpi_system_write_wakeup_device(struct file *file,
 			}
 		}
 	}
-	spin_unlock(&acpi_device_lock);
+	mutex_unlock(&acpi_device_lock);
 	return count;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 20c23c0..e63f2fe 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -24,7 +24,7 @@ extern struct acpi_device *acpi_root;
 
 static LIST_HEAD(acpi_device_list);
 static LIST_HEAD(acpi_bus_id_list);
-DEFINE_SPINLOCK(acpi_device_lock);
+DEFINE_MUTEX(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
 
 struct acpi_device_bus_id{
@@ -500,7 +500,7 @@ static int acpi_device_register(struct acpi_device *device,
 		return -ENOMEM;
 	}
 
-	spin_lock(&acpi_device_lock);
+	mutex_lock(&acpi_device_lock);
 	/*
 	 * Find suitable bus_id and instance number in acpi_bus_id_list
 	 * If failed, create one and link it into acpi_bus_id_list
@@ -528,7 +528,7 @@ static int acpi_device_register(struct acpi_device *device,
 		list_add_tail(&device->g_list, &acpi_device_list);
 	if (device->wakeup.flags.valid)
 		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
-	spin_unlock(&acpi_device_lock);
+	mutex_unlock(&acpi_device_lock);
 
 	if (device->parent)
 		device->dev.parent = &parent->dev;
@@ -549,20 +549,20 @@ static int acpi_device_register(struct acpi_device *device,
 	device->removal_type = ACPI_BUS_REMOVAL_NORMAL;
 	return 0;
   end:
-	spin_lock(&acpi_device_lock);
+	mutex_lock(&acpi_device_lock);
 	if (device->parent) {
 		list_del(&device->node);
 		list_del(&device->g_list);
 	} else
 		list_del(&device->g_list);
 	list_del(&device->wakeup_list);
-	spin_unlock(&acpi_device_lock);
+	mutex_unlock(&acpi_device_lock);
 	return result;
 }
 
 static void acpi_device_unregister(struct acpi_device *device, int type)
 {
-	spin_lock(&acpi_device_lock);
+	mutex_lock(&acpi_device_lock);
 	if (device->parent) {
 		list_del(&device->node);
 		list_del(&device->g_list);
@@ -570,7 +570,7 @@ static void acpi_device_unregister(struct acpi_device *device, int type)
 		list_del(&device->g_list);
 
 	list_del(&device->wakeup_list);
-	spin_unlock(&acpi_device_lock);
+	mutex_unlock(&acpi_device_lock);
 
 	acpi_detach_data(device->handle, acpi_bus_data_handler);
 
diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
index cfaf8f5..8a8f3b3 100644
--- a/drivers/acpi/sleep.h
+++ b/drivers/acpi/sleep.h
@@ -5,3 +5,6 @@ extern int acpi_suspend (u32 state);
 extern void acpi_enable_wakeup_device_prep(u8 sleep_state);
 extern void acpi_enable_wakeup_device(u8 sleep_state);
 extern void acpi_disable_wakeup_device(u8 sleep_state);
+
+extern struct list_head acpi_wakeup_device_list;
+extern struct mutex acpi_device_lock;
diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
index 5aee8c2..88725dc 100644
--- a/drivers/acpi/wakeup.c
+++ b/drivers/acpi/wakeup.c
@@ -12,12 +12,14 @@
 #include "internal.h"
 #include "sleep.h"
 
+/*
+ * We didn't lock acpi_device_lock in the file, because it invokes oops in
+ * suspend/resume and isn't really required as this is called in S-state. At
+ * that time, there is no device hotplug
+ **/
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("wakeup_devices")
 
-extern struct list_head acpi_wakeup_device_list;
-extern spinlock_t acpi_device_lock;
-
 /**
  * acpi_enable_wakeup_device_prep - prepare wakeup devices
  *	@sleep_state:	ACPI state
@@ -29,7 +31,6 @@ void acpi_enable_wakeup_device_prep(u8 sleep_state)
 {
 	struct list_head *node, *next;
 
-	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev = container_of(node,
 						       struct acpi_device,
@@ -40,11 +41,8 @@ void acpi_enable_wakeup_device_prep(u8 sleep_state)
 		    (sleep_state > (u32) dev->wakeup.sleep_state))
 			continue;
 
-		spin_unlock(&acpi_device_lock);
 		acpi_enable_wakeup_device_power(dev, sleep_state);
-		spin_lock(&acpi_device_lock);
 	}
-	spin_unlock(&acpi_device_lock);
 }
 
 /**
@@ -60,7 +58,6 @@ void acpi_enable_wakeup_device(u8 sleep_state)
 	 * Caution: this routine must be invoked when interrupt is disabled 
 	 * Refer ACPI2.0: P212
 	 */
-	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =
 			container_of(node, struct acpi_device, wakeup_list);
@@ -74,22 +71,17 @@ void acpi_enable_wakeup_device(u8 sleep_state)
 		if ((!dev->wakeup.state.enabled && !dev->wakeup.flags.prepared)
 		    || sleep_state > (u32) dev->wakeup.sleep_state) {
 			if (dev->wakeup.flags.run_wake) {
-				spin_unlock(&acpi_device_lock);
 				/* set_gpe_type will disable GPE, leave it like that */
 				acpi_set_gpe_type(dev->wakeup.gpe_device,
 						  dev->wakeup.gpe_number,
 						  ACPI_GPE_TYPE_RUNTIME);
-				spin_lock(&acpi_device_lock);
 			}
 			continue;
 		}
-		spin_unlock(&acpi_device_lock);
 		if (!dev->wakeup.flags.run_wake)
 			acpi_enable_gpe(dev->wakeup.gpe_device,
 					dev->wakeup.gpe_number);
-		spin_lock(&acpi_device_lock);
 	}
-	spin_unlock(&acpi_device_lock);
 }
 
 /**
@@ -101,7 +93,6 @@ void acpi_disable_wakeup_device(u8 sleep_state)
 {
 	struct list_head *node, *next;
 
-	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =
 			container_of(node, struct acpi_device, wakeup_list);
@@ -112,19 +103,16 @@ void acpi_disable_wakeup_device(u8 sleep_state)
 		if ((!dev->wakeup.state.enabled && !dev->wakeup.flags.prepared)
 		    || sleep_state > (u32) dev->wakeup.sleep_state) {
 			if (dev->wakeup.flags.run_wake) {
-				spin_unlock(&acpi_device_lock);
 				acpi_set_gpe_type(dev->wakeup.gpe_device,
 						  dev->wakeup.gpe_number,
 						  ACPI_GPE_TYPE_WAKE_RUN);
 				/* Re-enable it, since set_gpe_type will disable it */
 				acpi_enable_gpe(dev->wakeup.gpe_device,
 						dev->wakeup.gpe_number);
-				spin_lock(&acpi_device_lock);
 			}
 			continue;
 		}
 
-		spin_unlock(&acpi_device_lock);
 		acpi_disable_wakeup_device_power(dev);
 		/* Never disable run-wake GPE */
 		if (!dev->wakeup.flags.run_wake) {
@@ -133,16 +121,14 @@ void acpi_disable_wakeup_device(u8 sleep_state)
 			acpi_clear_gpe(dev->wakeup.gpe_device,
 				       dev->wakeup.gpe_number, ACPI_NOT_ISR);
 		}
-		spin_lock(&acpi_device_lock);
 	}
-	spin_unlock(&acpi_device_lock);
 }
 
 int __init acpi_wakeup_device_init(void)
 {
 	struct list_head *node, *next;
 
-	spin_lock(&acpi_device_lock);
+	mutex_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev = container_of(node,
 						       struct acpi_device,
@@ -150,15 +136,13 @@ int __init acpi_wakeup_device_init(void)
 		/* In case user doesn't load button driver */
 		if (!dev->wakeup.flags.run_wake || dev->wakeup.state.enabled)
 			continue;
-		spin_unlock(&acpi_device_lock);
 		acpi_set_gpe_type(dev->wakeup.gpe_device,
 				  dev->wakeup.gpe_number,
 				  ACPI_GPE_TYPE_WAKE_RUN);
 		acpi_enable_gpe(dev->wakeup.gpe_device,
 				dev->wakeup.gpe_number);
 		dev->wakeup.state.enabled = 1;
-		spin_lock(&acpi_device_lock);
 	}
-	spin_unlock(&acpi_device_lock);
+	mutex_unlock(&acpi_device_lock);
 	return 0;
 }
-- 
1.6.0.6

