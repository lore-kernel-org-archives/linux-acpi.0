From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: [PATCH 3/4] use acpi_subsys.rwsem in acpi/scan.c
Date: Tue, 24 Aug 2004 01:37:54 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408240137.55691.dtor_core@ameritech.net>
References: <200408240134.16962.dtor_core@ameritech.net> <200408240136.46113.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200408240136.46113.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Len Brown <len.brow-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


===================================================================


ChangeSet@1.1844, 2004-08-24 01:11:37-05:00, dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
  ACPI: Do not use list_for_each_safe as it does not protect from
        changes done by other thread, take acpi_subsys.rwsem instead.
  
  Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>


 bus.c          |    6 --
 scan.c         |  139 ++++++++++++++++++++++++++-------------------------------
 sleep/main.c   |    2 
 sleep/proc.c   |   34 ++++++-------
 sleep/wakeup.c |  126 ++++++++++++++++++++++-----------------------------
 5 files changed, 139 insertions(+), 168 deletions(-)


===================================================================



diff -Nru a/drivers/acpi/bus.c b/drivers/acpi/bus.c
--- a/drivers/acpi/bus.c	2004-08-24 01:17:20 -05:00
+++ b/drivers/acpi/bus.c	2004-08-24 01:17:20 -05:00
@@ -27,7 +27,6 @@
 #include <linux/list.h>
 #include <linux/sched.h>
 #include <linux/pm.h>
-#include <linux/device.h>
 #include <linux/proc_fs.h>
 #ifdef CONFIG_X86
 #include <asm/mpspec.h>
@@ -629,8 +628,6 @@
 	return_VALUE(-ENODEV);
 }
 
-decl_subsys(acpi,NULL,NULL);
-
 static int __init acpi_init (void)
 {
 	int			result = 0;
@@ -648,10 +645,7 @@
 		return -ENODEV;
 	}
 
-	firmware_register(&acpi_subsys);
-
 	result = acpi_bus_init();
-
 	if (!result) {
 #ifdef CONFIG_PM
 		if (!PM_IS_ACTIVE())
diff -Nru a/drivers/acpi/scan.c b/drivers/acpi/scan.c
--- a/drivers/acpi/scan.c	2004-08-24 01:17:20 -05:00
+++ b/drivers/acpi/scan.c	2004-08-24 01:17:20 -05:00
@@ -3,6 +3,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/device.h>
 #include <linux/acpi.h>
 
 #include <acpi/acpi_drivers.h>
@@ -23,7 +24,6 @@
 #define ACPI_BUS_DEVICE_NAME		"System Bus"
 
 static LIST_HEAD(acpi_device_list);
-spinlock_t acpi_device_lock = SPIN_LOCK_UNLOCKED;
 LIST_HEAD(acpi_wakeup_device_list);
 
 static void acpi_device_release(struct kobject * kobj)
@@ -34,14 +34,13 @@
 	kfree(dev);
 }
 
+decl_subsys(acpi, NULL, NULL);
+
 static struct kobj_type ktype_acpi_ns = {
 	.release	= acpi_device_release,
 };
 
 static struct kset acpi_namespace_kset = {
-	.kobj		= { 
-		.name = "namespace",
-	},
 	.subsys = &acpi_subsys,
 	.ktype	= &ktype_acpi_ns,
 };
@@ -49,6 +48,8 @@
 
 static void acpi_device_register(struct acpi_device * device, struct acpi_device * parent)
 {
+	ACPI_FUNCTION_TRACE("acpi_device_register");
+
 	/*
 	 * Linkage
 	 * -------
@@ -57,20 +58,28 @@
 	INIT_LIST_HEAD(&device->children);
 	INIT_LIST_HEAD(&device->node);
 	INIT_LIST_HEAD(&device->g_list);
-
-	spin_lock(&acpi_device_lock);
-	if (device->parent) {
-		list_add_tail(&device->node, &device->parent->children);
-		list_add_tail(&device->g_list,&device->parent->g_list);
-	} else
-		list_add_tail(&device->g_list,&acpi_device_list);
-	spin_unlock(&acpi_device_lock);
+	INIT_LIST_HEAD(&device->wakeup_list);
 
 	kobject_set_name(&device->kobj, device->pnp.bus_id);
 	if (parent)
 		device->kobj.parent = kobject_get(&parent->kobj);
 	device->kobj.kset = &acpi_namespace_kset;
 	kobject_register(&device->kobj);
+
+	down_write(&acpi_subsys.rwsem);
+
+	if (device->parent) {
+		list_add_tail(&device->node, &device->parent->children);
+		list_add_tail(&device->g_list, &device->parent->g_list);
+	} else
+		list_add_tail(&device->g_list, &acpi_device_list);
+
+	if (device->wakeup.flags.valid)
+		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
+
+	up_write(&acpi_subsys.rwsem);
+
+	return_VOID;
 }
 
 static int
@@ -255,24 +264,17 @@
 
 	package = (union acpi_object *) buffer.pointer;
 	status = acpi_bus_extract_wakeup_device_power_package(device, package);
+	acpi_os_free(buffer.pointer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error extracting _PRW package\n"));
 		goto end;
 	}
 
-	acpi_os_free(buffer.pointer);
-
 	device->wakeup.flags.valid = 1;
 	/* Power button, Lid switch always enable wakeup*/
 	if (!acpi_match_ids(device, "PNP0C0D,PNP0C0C,PNP0C0E"))
 		device->wakeup.flags.run_wake = 1;
 
-	/* TBD: lock */
-	INIT_LIST_HEAD(&device->wakeup_list);
-	spin_lock(&acpi_device_lock);
-	list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
-	spin_unlock(&acpi_device_lock);
-
 end:
 	if (ACPI_FAILURE(status))
 		device->flags.wake_capable = 0;
@@ -296,8 +298,6 @@
    -------------------------------------------------------------------------- */
 
 static LIST_HEAD(acpi_bus_drivers);
-static DECLARE_MUTEX(acpi_bus_drivers_lock);
-
 
 /**
  * acpi_bus_match 
@@ -367,54 +367,44 @@
 
 static int acpi_driver_attach(struct acpi_driver * drv)
 {
-	struct list_head * node, * next;
+	struct acpi_device *dev;
 	int count = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_driver_attach");
 
-	spin_lock(&acpi_device_lock);
-	list_for_each_safe(node, next, &acpi_device_list) {
-		struct acpi_device * dev = container_of(node, struct acpi_device, g_list);
+	list_for_each_entry(dev, &acpi_device_list, g_list) {
 
 		if (dev->driver || !dev->status.present)
 			continue;
-		spin_unlock(&acpi_device_lock);
 
-		if (!acpi_bus_match(dev, drv)) {
-			if (!acpi_bus_driver_init(dev, drv)) {
-				atomic_inc(&drv->references);
-				count++;
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found driver [%s] for device [%s]\n",
-						  drv->name, dev->pnp.bus_id));
-			}
+		if (acpi_bus_match(dev, drv) < 0)
+			continue;
+
+		if (acpi_bus_driver_init(dev, drv) == 0) {
+			atomic_inc(&drv->references);
+			count++;
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found driver [%s] for device [%s]\n",
+					  drv->name, dev->pnp.bus_id));
 		}
-		spin_lock(&acpi_device_lock);
 	}
-	spin_unlock(&acpi_device_lock);
 	return_VALUE(count);
 }
 
 static int acpi_driver_detach(struct acpi_driver * drv)
 {
-	struct list_head * node, * next;
+	struct acpi_device *dev;
 
 	ACPI_FUNCTION_TRACE("acpi_driver_detach");
 
-	spin_lock(&acpi_device_lock);
-	list_for_each_safe(node,next,&acpi_device_list) {
-		struct acpi_device * dev = container_of(node,struct acpi_device,g_list);
-
+	list_for_each_entry(dev, &acpi_device_list, g_list) {
 		if (dev->driver == drv) {
-			spin_unlock(&acpi_device_lock);
 			if (drv->ops.remove)
 				drv->ops.remove(dev,ACPI_BUS_REMOVAL_NORMAL);
-			spin_lock(&acpi_device_lock);
 			dev->driver = NULL;
 			dev->driver_data = NULL;
 			atomic_dec(&drv->references);
 		}
 	}
-	spin_unlock(&acpi_device_lock);
 	return_VALUE(0);
 }
 
@@ -440,11 +430,13 @@
 	if (!driver)
 		return_VALUE(-EINVAL);
 
-	spin_lock(&acpi_device_lock);
+	down_write(&acpi_subsys.rwsem);
+
 	list_add_tail(&driver->node, &acpi_bus_drivers);
-	spin_unlock(&acpi_device_lock);
 	count = acpi_driver_attach(driver);
 
+	up_write(&acpi_subsys.rwsem);
+
 	return_VALUE(count);
 }
 
@@ -459,21 +451,21 @@
 acpi_bus_unregister_driver (
 	struct acpi_driver	*driver)
 {
-	int error = 0;
-
 	ACPI_FUNCTION_TRACE("acpi_bus_unregister_driver");
 
-	if (driver) {
-		acpi_driver_detach(driver);
+	if (!driver)
+		return_VALUE(-EINVAL);
+
+	down_write(&acpi_subsys.rwsem);
 
-		if (!atomic_read(&driver->references)) {
-			spin_lock(&acpi_device_lock);
-			list_del_init(&driver->node);
-			spin_unlock(&acpi_device_lock);
-		} 
-	} else 
-		error = -EINVAL;
-	return_VALUE(error);
+	acpi_driver_detach(driver);
+
+	if (!atomic_read(&driver->references))
+		list_del_init(&driver->node);
+
+	up_write(&acpi_subsys.rwsem);
+
+	return_VALUE(0);
 }
 
 /**
@@ -487,30 +479,27 @@
 	struct acpi_device	*device)
 {
 	int			result = 0;
-	struct list_head	* node, *next;
+	struct acpi_driver	*driver;
 
 	ACPI_FUNCTION_TRACE("acpi_bus_find_driver");
 
 	if (!device->flags.hardware_id && !device->flags.compatible_ids)
-		goto Done;
+		return_VALUE(0);
 
-	spin_lock(&acpi_device_lock);
-	list_for_each_safe(node,next,&acpi_bus_drivers) {
-		struct acpi_driver * driver = container_of(node,struct acpi_driver,node);
-
-		atomic_inc(&driver->references);
-		spin_unlock(&acpi_device_lock);
-		if (!acpi_bus_match(device, driver)) {
-			result = acpi_bus_driver_init(device, driver);
-			if (!result)
-				goto Done;
+	down_write(&acpi_subsys.rwsem);
+	list_for_each_entry(driver, &acpi_bus_drivers, node) {
+
+		if (acpi_bus_match(device, driver) < 0)
+			continue;
+
+		result = acpi_bus_driver_init(device, driver);
+		if (!result) {
+			atomic_inc(&driver->references);
+			break;
 		}
-		atomic_dec(&driver->references);
-		spin_lock(&acpi_device_lock);
 	}
-	spin_unlock(&acpi_device_lock);
+	up_write(&acpi_subsys.rwsem);
 
- Done:
 	return_VALUE(result);
 }
 
@@ -1044,6 +1033,8 @@
 	if (acpi_disabled)
 		return_VALUE(0);
 
+	firmware_register(&acpi_subsys);
+	kobject_set_name(&acpi_namespace_kset.kobj, "namespace");
 	kset_register(&acpi_namespace_kset);
 
 	/*
diff -Nru a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
--- a/drivers/acpi/sleep/main.c	2004-08-24 01:17:20 -05:00
+++ b/drivers/acpi/sleep/main.c	2004-08-24 01:17:20 -05:00
@@ -89,9 +89,9 @@
 			return error;
 	}
 
+	acpi_enable_wakeup_device(acpi_state);
 
 	local_irq_save(flags);
-	acpi_enable_wakeup_device(acpi_state);
 	switch (pm_state)
 	{
 	case PM_SUSPEND_STANDBY:
diff -Nru a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
--- a/drivers/acpi/sleep/proc.c	2004-08-24 01:17:20 -05:00
+++ b/drivers/acpi/sleep/proc.c	2004-08-24 01:17:20 -05:00
@@ -354,22 +354,20 @@
 }
 
 extern struct list_head	acpi_wakeup_device_list;
-extern spinlock_t acpi_device_lock;
 
 static int
 acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 {
-	struct list_head * node, * next;
+	struct acpi_device *dev;
 
 	seq_printf(seq, "Device	Sleep state	Status\n");
 
-	spin_lock(&acpi_device_lock);
-	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
-		struct acpi_device * dev = container_of(node, struct acpi_device, wakeup_list);
+	down_read(&acpi_subsys.rwsem);
+	list_for_each_entry(dev, &acpi_wakeup_device_list, wakeup_list) {
 
 		if (!dev->wakeup.flags.valid)
 			continue;
-		spin_unlock(&acpi_device_lock);
+
 		if (dev->wakeup.flags.run_wake)
 			seq_printf(seq, "%4s	%4d		%8s\n",
 				dev->pnp.bus_id, (u32) dev->wakeup.sleep_state,
@@ -378,9 +376,9 @@
 			seq_printf(seq, "%4s	%4d		%8s\n",
 				dev->pnp.bus_id, (u32) dev->wakeup.sleep_state,
 				dev->wakeup.state.enabled ? "enabled" : "disabled");
-		spin_lock(&acpi_device_lock);
 	}
-	spin_unlock(&acpi_device_lock);
+	up_read(&acpi_subsys.rwsem);
+
 	return 0;
 }
 
@@ -391,30 +389,32 @@
 	size_t			count,
 	loff_t			*ppos)
 {
-	struct list_head * node, * next;
-	char		strbuf[5];
-	char		str[5] = "";
-	int 		len = count;
+	struct acpi_device	*dev;
+	char			strbuf[5];
+	char			str[5] = "";
+	int 			len = count;
 
 	if (len > 4) len = 4;
 
 	if (copy_from_user(strbuf, buffer, len))
 		return -EFAULT;
+
 	strbuf[len] = '\0';
 	sscanf(strbuf, "%s", str);
 
-	spin_lock(&acpi_device_lock);
-	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
-		struct acpi_device * dev = container_of(node, struct acpi_device, wakeup_list);
+	down_write(&acpi_subsys.rwsem);
+	list_for_each_entry(dev, &acpi_wakeup_device_list, wakeup_list) {
+
 		if (!dev->wakeup.flags.valid)
 			continue;
 
 		if (!strncmp(dev->pnp.bus_id, str, 4)) {
-			dev->wakeup.state.enabled = dev->wakeup.state.enabled ? 0:1;
+			dev->wakeup.state.enabled = dev->wakeup.state.enabled ? 0 : 1;
 			break;
 		}
 	}
-	spin_unlock(&acpi_device_lock);
+	up_write(&acpi_subsys.rwsem);
+
 	return count;
 }
 
diff -Nru a/drivers/acpi/sleep/wakeup.c b/drivers/acpi/sleep/wakeup.c
--- a/drivers/acpi/sleep/wakeup.c	2004-08-24 01:17:20 -05:00
+++ b/drivers/acpi/sleep/wakeup.c	2004-08-24 01:17:20 -05:00
@@ -20,31 +20,29 @@
  * is higher than requested sleep level
  */
 extern struct list_head	acpi_wakeup_device_list;
-extern spinlock_t acpi_device_lock;
 
 void
 acpi_enable_wakeup_device_prep(
 	u8		sleep_state)
 {
-	struct list_head * node, * next;
+	struct acpi_device *dev;
 
 	ACPI_FUNCTION_TRACE("acpi_enable_wakeup_device_prep");
 
-	spin_lock(&acpi_device_lock);
-	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
-		struct acpi_device * dev = container_of(node, 
-			struct acpi_device, wakeup_list);
-		
-		if (!dev->wakeup.flags.valid || 
-			!dev->wakeup.state.enabled ||
-			(sleep_state > (u32) dev->wakeup.sleep_state))
+	down_write(&acpi_subsys.rwsem);
+	list_for_each_entry(dev, &acpi_wakeup_device_list, wakeup_list) {
+
+		if (!dev->wakeup.flags.valid || !dev->wakeup.state.enabled)
+			continue;
+
+		if (sleep_state > (u32) dev->wakeup.sleep_state)
 			continue;
 
-		spin_unlock(&acpi_device_lock);
 		acpi_enable_wakeup_device_power(dev);
-		spin_lock(&acpi_device_lock);
 	}
-	spin_unlock(&acpi_device_lock);
+	up_write(&acpi_subsys.rwsem);
+
+	return_VOID;
 }
 
 /**
@@ -56,46 +54,40 @@
 acpi_enable_wakeup_device(
 	u8		sleep_state)
 {
-	struct list_head * node, * next;
+	struct acpi_device *dev;
 
-	/* 
-	 * Caution: this routine must be invoked when interrupt is disabled 
-	 * Refer ACPI2.0: P212
-	 */
 	ACPI_FUNCTION_TRACE("acpi_enable_wakeup_device");
-	spin_lock(&acpi_device_lock);
-	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
-		struct acpi_device * dev = container_of(node, 
-			struct acpi_device, wakeup_list);
+
+	down_write(&acpi_subsys.rwsem);
+	list_for_each_entry(dev, &acpi_wakeup_device_list, wakeup_list) {
 
 		/* If users want to disable run-wake GPE,
 		 * we only disable it for wake and leave it for runtime
 		 */
 		if (dev->wakeup.flags.run_wake && !dev->wakeup.state.enabled) {
-			spin_unlock(&acpi_device_lock);
-			acpi_set_gpe_type(dev->wakeup.gpe_device, 
-				dev->wakeup.gpe_number, ACPI_GPE_TYPE_RUNTIME);
+			acpi_set_gpe_type(dev->wakeup.gpe_device,
+					  dev->wakeup.gpe_number, ACPI_GPE_TYPE_RUNTIME);
 			/* Re-enable it, since set_gpe_type will disable it */
-			acpi_enable_gpe(dev->wakeup.gpe_device, 
-				dev->wakeup.gpe_number, ACPI_ISR);
-			spin_lock(&acpi_device_lock);
+			acpi_enable_gpe(dev->wakeup.gpe_device,
+					dev->wakeup.gpe_number, ACPI_NOT_ISR);
 			continue;
 		}
 
-		if (!dev->wakeup.flags.valid ||
-			!dev->wakeup.state.enabled ||
-			(sleep_state > (u32) dev->wakeup.sleep_state))
+		if (!dev->wakeup.flags.valid || !dev->wakeup.state.enabled)
+			continue;
+
+		if (sleep_state > (u32) dev->wakeup.sleep_state)
 			continue;
 
-		spin_unlock(&acpi_device_lock);
 		/* run-wake GPE has been enabled */
 		if (!dev->wakeup.flags.run_wake)
-			acpi_enable_gpe(dev->wakeup.gpe_device, 
-				dev->wakeup.gpe_number, ACPI_ISR);
+			acpi_enable_gpe(dev->wakeup.gpe_device,
+					dev->wakeup.gpe_number, ACPI_NOT_ISR);
 		dev->wakeup.state.active = 1;
-		spin_lock(&acpi_device_lock);
 	}
-	spin_unlock(&acpi_device_lock);
+	up_write(&acpi_subsys.rwsem);
+
+	return_VOID;
 }
 
 /**
@@ -107,73 +99,67 @@
 acpi_disable_wakeup_device (
 	u8		sleep_state)
 {
-	struct list_head * node, * next;
+	struct acpi_device *dev;
 
 	ACPI_FUNCTION_TRACE("acpi_disable_wakeup_device");
 
-	spin_lock(&acpi_device_lock);
-	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
-		struct acpi_device * dev = container_of(node, 
-			struct acpi_device, wakeup_list);
+	down_write(&acpi_subsys.rwsem);
+	list_for_each_entry(dev, &acpi_wakeup_device_list, wakeup_list) {
 
 		if (dev->wakeup.flags.run_wake && !dev->wakeup.state.enabled) {
-			spin_unlock(&acpi_device_lock);
-			acpi_set_gpe_type(dev->wakeup.gpe_device, 
-				dev->wakeup.gpe_number, ACPI_GPE_TYPE_WAKE_RUN);
+			acpi_set_gpe_type(dev->wakeup.gpe_device,
+					  dev->wakeup.gpe_number, ACPI_GPE_TYPE_WAKE_RUN);
 			/* Re-enable it, since set_gpe_type will disable it */
-			acpi_enable_gpe(dev->wakeup.gpe_device, 
-				dev->wakeup.gpe_number, ACPI_NOT_ISR);
-			spin_lock(&acpi_device_lock);
+			acpi_enable_gpe(dev->wakeup.gpe_device,
+					dev->wakeup.gpe_number, ACPI_NOT_ISR);
 			continue;
 		}
 
-		if (!dev->wakeup.flags.valid || 
-			!dev->wakeup.state.active ||
-			(sleep_state > (u32) dev->wakeup.sleep_state))
+		if (!dev->wakeup.flags.valid || !dev->wakeup.state.active)
+			continue;
+
+		if (sleep_state > (u32) dev->wakeup.sleep_state)
 			continue;
 
-		spin_unlock(&acpi_device_lock);
 		acpi_disable_wakeup_device_power(dev);
 		/* Never disable run-wake GPE */
 		if (!dev->wakeup.flags.run_wake) {
-			acpi_disable_gpe(dev->wakeup.gpe_device, 
-				dev->wakeup.gpe_number, ACPI_NOT_ISR);
-			acpi_clear_gpe(dev->wakeup.gpe_device, 
-				dev->wakeup.gpe_number, ACPI_NOT_ISR);
+			acpi_disable_gpe(dev->wakeup.gpe_device,
+					 dev->wakeup.gpe_number, ACPI_NOT_ISR);
+			acpi_clear_gpe(dev->wakeup.gpe_device,
+				       dev->wakeup.gpe_number, ACPI_NOT_ISR);
 		}
 		dev->wakeup.state.active = 0;
-		spin_lock(&acpi_device_lock);
 	}
-	spin_unlock(&acpi_device_lock);
+	up_write(&acpi_subsys.rwsem);
+
+	return_VOID;
 }
 
 static int __init acpi_wakeup_device_init(void)
 {
-	struct list_head * node, * next;
+	struct acpi_device *dev;
 
 	if (acpi_disabled)
 		return 0;
+
 	printk("ACPI wakeup devices: \n");
 
-	spin_lock(&acpi_device_lock);
-	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
-		struct acpi_device * dev = container_of(node, 
-			struct acpi_device, wakeup_list);
-		
+	down_write(&acpi_subsys.rwsem);
+	list_for_each_entry(dev, &acpi_wakeup_device_list, wakeup_list) {
+
 		/* In case user doesn't load button driver */
 		if (dev->wakeup.flags.run_wake && !dev->wakeup.state.enabled) {
-			spin_unlock(&acpi_device_lock);
-			acpi_set_gpe_type(dev->wakeup.gpe_device, 
-				dev->wakeup.gpe_number, ACPI_GPE_TYPE_WAKE_RUN);
-			acpi_enable_gpe(dev->wakeup.gpe_device, 
-				dev->wakeup.gpe_number, ACPI_NOT_ISR);
+			acpi_set_gpe_type(dev->wakeup.gpe_device,
+					  dev->wakeup.gpe_number, ACPI_GPE_TYPE_WAKE_RUN);
+			acpi_enable_gpe(dev->wakeup.gpe_device,
+					dev->wakeup.gpe_number, ACPI_NOT_ISR);
 			dev->wakeup.state.enabled = 1;
-			spin_lock(&acpi_device_lock);
 		}
 		printk("%4s ", dev->pnp.bus_id);
 	}
-	spin_unlock(&acpi_device_lock);
 	printk("\n");
+	up_write(&acpi_subsys.rwsem);
 
 	return 0;
 }


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
