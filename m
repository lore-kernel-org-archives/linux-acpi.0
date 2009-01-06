From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [patch]change a spinlock to mutex
Date: Tue, 06 Jan 2009 11:45:58 +0800
Message-ID: <1231213558.6878.2.camel@sli10-desk.sh.intel.com>
References: <1228791139.13102.3.camel@sli10-desk.sh.intel.com>
	 <alpine.LFD.2.00.0812152203120.16823@localhost.localdomain>
	 <alpine.LFD.2.00.0812190500540.1988@localhost.localdomain>
	 <20081222013549.GA21818@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17785 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836AbZAFDqB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Jan 2009 22:46:01 -0500
In-Reply-To: <20081222013549.GA21818@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>

On Mon, 2008-12-22 at 09:35 +0800, Shaohua Li wrote:
> On Fri, Dec 19, 2008 at 06:03:10PM +0800, Len Brown wrote:
> > Shaohua,
> >
> > This one failed b/c it put a mutex into the irqs_disabled
> > part of suspend:
> Maybe just delete the lock in wakeup.c. It's not correct in theory, but
> in theory it should be ok.
Convert acpi_device_lock to a mutex to avoid potential race in wakeup
device read/write. Found by Linus.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/scan.c         |   14 +++++++-------
 drivers/acpi/sleep/proc.c   |   13 ++++---------
 drivers/acpi/sleep/sleep.h  |    3 +++
 drivers/acpi/sleep/wakeup.c |   30 +++++++-----------------------
 4 files changed, 21 insertions(+), 39 deletions(-)

Index: linux/drivers/acpi/scan.c
===================================================================
--- linux.orig/drivers/acpi/scan.c	2008-12-19 11:06:56.000000000 +0800
+++ linux/drivers/acpi/scan.c	2009-01-06 11:31:23.000000000 +0800
@@ -23,7 +23,7 @@ extern struct acpi_device *acpi_root;
 
 static LIST_HEAD(acpi_device_list);
 static LIST_HEAD(acpi_bus_id_list);
-DEFINE_SPINLOCK(acpi_device_lock);
+DEFINE_MUTEX(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
 
 struct acpi_device_bus_id{
@@ -440,7 +440,7 @@ static int acpi_device_register(struct a
 		return -ENOMEM;
 	}
 
-	spin_lock(&acpi_device_lock);
+	mutex_lock(&acpi_device_lock);
 	/*
 	 * Find suitable bus_id and instance number in acpi_bus_id_list
 	 * If failed, create one and link it into acpi_bus_id_list
@@ -468,7 +468,7 @@ static int acpi_device_register(struct a
 		list_add_tail(&device->g_list, &acpi_device_list);
 	if (device->wakeup.flags.valid)
 		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
-	spin_unlock(&acpi_device_lock);
+	mutex_unlock(&acpi_device_lock);
 
 	if (device->parent)
 		device->dev.parent = &parent->dev;
@@ -489,20 +489,20 @@ static int acpi_device_register(struct a
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
@@ -510,7 +510,7 @@ static void acpi_device_unregister(struc
 		list_del(&device->g_list);
 
 	list_del(&device->wakeup_list);
-	spin_unlock(&acpi_device_lock);
+	mutex_unlock(&acpi_device_lock);
 
 	acpi_detach_data(device->handle, acpi_bus_data_handler);
 
Index: linux/drivers/acpi/sleep/proc.c
===================================================================
--- linux.orig/drivers/acpi/sleep/proc.c	2008-12-19 11:06:56.000000000 +0800
+++ linux/drivers/acpi/sleep/proc.c	2009-01-06 11:31:23.000000000 +0800
@@ -338,9 +338,6 @@ acpi_system_write_alarm(struct file *fil
 }
 #endif				/* HAVE_ACPI_LEGACY_ALARM */
 
-extern struct list_head acpi_wakeup_device_list;
-extern spinlock_t acpi_device_lock;
-
 static int
 acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 {
@@ -348,7 +345,7 @@ acpi_system_wakeup_device_seq_show(struc
 
 	seq_printf(seq, "Device\tS-state\t  Status   Sysfs node\n");
 
-	spin_lock(&acpi_device_lock);
+	mutex_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =
 		    container_of(node, struct acpi_device, wakeup_list);
@@ -356,7 +353,6 @@ acpi_system_wakeup_device_seq_show(struc
 
 		if (!dev->wakeup.flags.valid)
 			continue;
-		spin_unlock(&acpi_device_lock);
 
 		ldev = acpi_get_physical_device(dev->handle);
 		seq_printf(seq, "%s\t  S%d\t%c%-8s  ",
@@ -371,9 +367,8 @@ acpi_system_wakeup_device_seq_show(struc
 		seq_printf(seq, "\n");
 		put_device(ldev);
 
-		spin_lock(&acpi_device_lock);
 	}
-	spin_unlock(&acpi_device_lock);
+	mutex_unlock(&acpi_device_lock);
 	return 0;
 }
 
@@ -404,7 +399,7 @@ acpi_system_write_wakeup_device(struct f
 	strbuf[len] = '\0';
 	sscanf(strbuf, "%s", str);
 
-	spin_lock(&acpi_device_lock);
+	mutex_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =
 		    container_of(node, struct acpi_device, wakeup_list);
@@ -441,7 +436,7 @@ acpi_system_write_wakeup_device(struct f
 			}
 		}
 	}
-	spin_unlock(&acpi_device_lock);
+	mutex_unlock(&acpi_device_lock);
 	return count;
 }
 
Index: linux/drivers/acpi/sleep/sleep.h
===================================================================
--- linux.orig/drivers/acpi/sleep/sleep.h	2008-12-09 16:13:38.000000000 +0800
+++ linux/drivers/acpi/sleep/sleep.h	2009-01-06 11:31:23.000000000 +0800
@@ -5,3 +5,6 @@ extern int acpi_suspend (u32 state);
 extern void acpi_enable_wakeup_device_prep(u8 sleep_state);
 extern void acpi_enable_wakeup_device(u8 sleep_state);
 extern void acpi_disable_wakeup_device(u8 sleep_state);
+
+extern struct list_head acpi_wakeup_device_list;
+extern struct mutex acpi_device_lock;
Index: linux/drivers/acpi/sleep/wakeup.c
===================================================================
--- linux.orig/drivers/acpi/sleep/wakeup.c	2008-12-19 11:06:56.000000000 +0800
+++ linux/drivers/acpi/sleep/wakeup.c	2009-01-06 11:43:25.000000000 +0800
@@ -11,12 +11,14 @@
 #include <acpi/acevents.h>
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
@@ -30,7 +32,6 @@ void acpi_enable_wakeup_device_prep(u8 s
 
 	ACPI_FUNCTION_TRACE("acpi_enable_wakeup_device_prep");
 
-	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev = container_of(node,
 						       struct acpi_device,
@@ -41,11 +42,8 @@ void acpi_enable_wakeup_device_prep(u8 s
 		    (sleep_state > (u32) dev->wakeup.sleep_state))
 			continue;
 
-		spin_unlock(&acpi_device_lock);
 		acpi_enable_wakeup_device_power(dev, sleep_state);
-		spin_lock(&acpi_device_lock);
 	}
-	spin_unlock(&acpi_device_lock);
 }
 
 /**
@@ -62,7 +60,6 @@ void acpi_enable_wakeup_device(u8 sleep_
 	 * Refer ACPI2.0: P212
 	 */
 	ACPI_FUNCTION_TRACE("acpi_enable_wakeup_device");
-	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =
 			container_of(node, struct acpi_device, wakeup_list);
@@ -76,22 +73,17 @@ void acpi_enable_wakeup_device(u8 sleep_
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
@@ -105,7 +97,6 @@ void acpi_disable_wakeup_device(u8 sleep
 
 	ACPI_FUNCTION_TRACE("acpi_disable_wakeup_device");
 
-	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =
 			container_of(node, struct acpi_device, wakeup_list);
@@ -116,19 +107,16 @@ void acpi_disable_wakeup_device(u8 sleep
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
@@ -137,9 +125,7 @@ void acpi_disable_wakeup_device(u8 sleep
 			acpi_clear_gpe(dev->wakeup.gpe_device,
 				       dev->wakeup.gpe_number, ACPI_NOT_ISR);
 		}
-		spin_lock(&acpi_device_lock);
 	}
-	spin_unlock(&acpi_device_lock);
 }
 
 static int __init acpi_wakeup_device_init(void)
@@ -149,7 +135,7 @@ static int __init acpi_wakeup_device_ini
 	if (acpi_disabled)
 		return 0;
 
-	spin_lock(&acpi_device_lock);
+	mutex_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev = container_of(node,
 						       struct acpi_device,
@@ -157,16 +143,14 @@ static int __init acpi_wakeup_device_ini
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
 


