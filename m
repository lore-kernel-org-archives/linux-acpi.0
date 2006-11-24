From: Len Brown <len.brown@intel.com>
Subject: [PATCH 7/13] ACPI: convert to sysfs framework
Date: Fri, 24 Nov 2006 00:17:35 -0500
Message-ID: <11643454703489-git-send-email-len.brown@intel.com>
References: <11643454612902-git-send-email-len.brown@intel.com> <1164345463205-git-send-email-len.brown@intel.com> <11643454641312-git-send-email-len.brown@intel.com> <11643454642611-git-send-email-len.brown@intel.com> <11643454652241-git-send-email-len.brown@intel.com> <11643454662740-git-send-email-len.brown@intel.com> <1164345468324-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14415 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934280AbWKXFOD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 00:14:03 -0500
In-Reply-To: <1164345468324-git-send-email-len.brown@intel.com>
Message-Id: <d190142cedf99bb444dfa27164686904773a7051.1164343921.git.len.brown@intel.com>
In-Reply-To: <bd119392c453771fdb994728a2568c2e3f17705d.1164343921.git.len.brown@intel.com>
References: <bd119392c453771fdb994728a2568c2e3f17705d.1164343921.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>, Li Shaohua <shaohua.li@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Patrick Mochel <mochel@linux.intel.com>

Setup new sysfs framework

1.	Remove /sys/firmware/acpi
2.	Add ACPI device in device tree.

File "eject" for every device that has _EJ0 method is moved from
/sys/firmware to /sys/devices.
Operation on this file is exactly the same as before.
i.e. echo 1 to "eject" will cause hot removal of this device.
Corresponding changes should be made in userspace for hot removal.

Signed-off-by: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Zhang Rui<rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c            |    2 +-
 drivers/acpi/container.c      |    6 +-
 drivers/acpi/processor_core.c |    8 +-
 drivers/acpi/scan.c           |  187 +++++++++--------------------------------
 include/acpi/acpi_bus.h       |    1 -
 5 files changed, 49 insertions(+), 155 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 279c4ba..da471f6 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -195,7 +195,7 @@ int acpi_bus_set_power(acpi_handle handl
 
 	if (!device->flags.power_manageable) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device `[%s]' is not power manageable\n",
-				device->kobj.name));
+				device->dev.kobj.name));
 		return -ENODEV;
 	}
 	/*
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 871aa52..914f56a 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -168,7 +168,7 @@ static void container_notify_cb(acpi_han
 			if (ACPI_FAILURE(status) || !device) {
 				result = container_device_add(&device, handle);
 				if (!result)
-					kobject_uevent(&device->kobj,
+					kobject_uevent(&device->dev.kobj,
 						       KOBJ_ONLINE);
 				else
 					printk("Failed to add container\n");
@@ -176,13 +176,13 @@ static void container_notify_cb(acpi_han
 		} else {
 			if (ACPI_SUCCESS(status)) {
 				/* device exist and this is a remove request */
-				kobject_uevent(&device->kobj, KOBJ_OFFLINE);
+				kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
 			}
 		}
 		break;
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		if (!acpi_bus_get_device(handle, &device) && device) {
-			kobject_uevent(&device->kobj, KOBJ_OFFLINE);
+			kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
 		}
 		break;
 	default:
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 1908e0d..46e72c3 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -711,7 +711,7 @@ int acpi_processor_device_add(acpi_handl
 		return -ENODEV;
 
 	if ((pr->id >= 0) && (pr->id < NR_CPUS)) {
-		kobject_uevent(&(*device)->kobj, KOBJ_ONLINE);
+		kobject_uevent(&(*device)->dev.kobj, KOBJ_ONLINE);
 	}
 	return 0;
 }
@@ -749,13 +749,13 @@ acpi_processor_hotplug_notify(acpi_handl
 		}
 
 		if (pr->id >= 0 && (pr->id < NR_CPUS)) {
-			kobject_uevent(&device->kobj, KOBJ_OFFLINE);
+			kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
 			break;
 		}
 
 		result = acpi_processor_start(device);
 		if ((!result) && ((pr->id >= 0) && (pr->id < NR_CPUS))) {
-			kobject_uevent(&device->kobj, KOBJ_ONLINE);
+			kobject_uevent(&device->dev.kobj, KOBJ_ONLINE);
 		} else {
 			printk(KERN_ERR PREFIX "Device [%s] failed to start\n",
 				    acpi_device_bid(device));
@@ -778,7 +778,7 @@ acpi_processor_hotplug_notify(acpi_handl
 		}
 
 		if ((pr->id < NR_CPUS) && (cpu_present(pr->id)))
-			kobject_uevent(&device->kobj, KOBJ_OFFLINE);
+			kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index b616e17..97f6bbd 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -24,126 +24,6 @@ static LIST_HEAD(acpi_device_list);
 DEFINE_SPINLOCK(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
 
-
-static void acpi_device_release_legacy(struct kobject *kobj)
-{
-	struct acpi_device *dev = container_of(kobj, struct acpi_device, kobj);
-	kfree(dev->pnp.cid_list);
-	kfree(dev);
-}
-
-struct acpi_device_attribute {
-	struct attribute attr;
-	 ssize_t(*show) (struct acpi_device *, char *);
-	 ssize_t(*store) (struct acpi_device *, const char *, size_t);
-};
-
-typedef void acpi_device_sysfs_files(struct kobject *,
-				     const struct attribute *);
-
-static void setup_sys_fs_device_files(struct acpi_device *dev,
-				      acpi_device_sysfs_files * func);
-
-#define create_sysfs_device_files(dev)	\
-	setup_sys_fs_device_files(dev, (acpi_device_sysfs_files *)&sysfs_create_file)
-#define remove_sysfs_device_files(dev)	\
-	setup_sys_fs_device_files(dev, (acpi_device_sysfs_files *)&sysfs_remove_file)
-
-#define to_acpi_dev(n) container_of(n, struct acpi_device, kobj)
-#define to_handle_attr(n) container_of(n, struct acpi_device_attribute, attr);
-
-static ssize_t acpi_device_attr_show(struct kobject *kobj,
-				     struct attribute *attr, char *buf)
-{
-	struct acpi_device *device = to_acpi_dev(kobj);
-	struct acpi_device_attribute *attribute = to_handle_attr(attr);
-	return attribute->show ? attribute->show(device, buf) : -EIO;
-}
-static ssize_t acpi_device_attr_store(struct kobject *kobj,
-				      struct attribute *attr, const char *buf,
-				      size_t len)
-{
-	struct acpi_device *device = to_acpi_dev(kobj);
-	struct acpi_device_attribute *attribute = to_handle_attr(attr);
-	return attribute->store ? attribute->store(device, buf, len) : -EIO;
-}
-
-static struct sysfs_ops acpi_device_sysfs_ops = {
-	.show = acpi_device_attr_show,
-	.store = acpi_device_attr_store,
-};
-
-static struct kobj_type ktype_acpi_ns = {
-	.sysfs_ops = &acpi_device_sysfs_ops,
-	.release = acpi_device_release_legacy,
-};
-
-static int namespace_uevent(struct kset *kset, struct kobject *kobj,
-			     char **envp, int num_envp, char *buffer,
-			     int buffer_size)
-{
-	struct acpi_device *dev = to_acpi_dev(kobj);
-	int i = 0;
-	int len = 0;
-
-	if (!dev->driver)
-		return 0;
-
-	if (add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &len,
-			   "PHYSDEVDRIVER=%s", dev->driver->name))
-		return -ENOMEM;
-
-	envp[i] = NULL;
-
-	return 0;
-}
-
-static struct kset_uevent_ops namespace_uevent_ops = {
-	.uevent = &namespace_uevent,
-};
-
-static struct kset acpi_namespace_kset = {
-	.kobj = {
-		 .name = "namespace",
-		 },
-	.subsys = &acpi_subsys,
-	.ktype = &ktype_acpi_ns,
-	.uevent_ops = &namespace_uevent_ops,
-};
-
-/* --------------------------------------------------------------------------
-		ACPI sysfs device file support
-   -------------------------------------------------------------------------- */
-static ssize_t acpi_eject_store(struct acpi_device *device,
-				const char *buf, size_t count);
-
-#define ACPI_DEVICE_ATTR(_name,_mode,_show,_store) \
-static struct acpi_device_attribute acpi_device_attr_##_name = \
-		__ATTR(_name, _mode, _show, _store)
-
-ACPI_DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
-
-/**
- * setup_sys_fs_device_files - sets up the device files under device namespace
- * @dev:	acpi_device object
- * @func:	function pointer to create or destroy the device file
- */
-static void
-setup_sys_fs_device_files(struct acpi_device *dev,
-			  acpi_device_sysfs_files * func)
-{
-	acpi_status status;
-	acpi_handle temp = NULL;
-
-	/*
-	 * If device has _EJ0, 'eject' file is created that is used to trigger
-	 * hot-removal function from userland.
-	 */
-	status = acpi_get_handle(dev->handle, "_EJ0", &temp);
-	if (ACPI_SUCCESS(status))
-		(*(func)) (&dev->kobj, &acpi_device_attr_eject.attr);
-}
-
 static int acpi_eject_operation(acpi_handle handle, int lockable)
 {
 	struct acpi_object_list arg_list;
@@ -180,7 +60,8 @@ static int acpi_eject_operation(acpi_han
 }
 
 static ssize_t
-acpi_eject_store(struct acpi_device *device, const char *buf, size_t count)
+acpi_eject_store(struct device *d, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
 	int result;
 	int ret = count;
@@ -188,26 +69,27 @@ acpi_eject_store(struct acpi_device *dev
 	acpi_status status;
 	acpi_handle handle;
 	acpi_object_type type = 0;
+	struct acpi_device *acpi_device = to_acpi_device(d);
 
 	if ((!count) || (buf[0] != '1')) {
 		return -EINVAL;
 	}
 #ifndef FORCE_EJECT
-	if (device->driver == NULL) {
+	if (acpi_device->driver == NULL) {
 		ret = -ENODEV;
 		goto err;
 	}
 #endif
-	status = acpi_get_type(device->handle, &type);
-	if (ACPI_FAILURE(status) || (!device->flags.ejectable)) {
+	status = acpi_get_type(acpi_device->handle, &type);
+	if (ACPI_FAILURE(status) || (!acpi_device->flags.ejectable)) {
 		ret = -ENODEV;
 		goto err;
 	}
 
-	islockable = device->flags.lockable;
-	handle = device->handle;
+	islockable = acpi_device->flags.lockable;
+	handle = acpi_device->handle;
 
-	result = acpi_bus_trim(device, 1);
+	result = acpi_bus_trim(acpi_device, 1);
 
 	if (!result)
 		result = acpi_eject_operation(handle, islockable);
@@ -219,6 +101,35 @@ acpi_eject_store(struct acpi_device *dev
 	return ret;
 }
 
+static DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
+
+static void acpi_device_setup_files(struct acpi_device *dev)
+{
+	acpi_status status;
+	acpi_handle temp;
+
+	/*
+	 * If device has _EJ0, 'eject' file is created that is used to trigger
+	 * hot-removal function from userland.
+	 */
+	status = acpi_get_handle(dev->handle, "_EJ0", &temp);
+	if (ACPI_SUCCESS(status))
+		device_create_file(&dev->dev, &dev_attr_eject);
+}
+
+static void acpi_device_remove_files(struct acpi_device *dev)
+{
+	acpi_status status;
+	acpi_handle temp;
+
+	/*
+	 * If device has _EJ0, 'eject' file is created that is used to trigger
+	 * hot-removal function from userland.
+	 */
+	status = acpi_get_handle(dev->handle, "_EJ0", &temp);
+	if (ACPI_SUCCESS(status))
+		device_remove_file(&dev->dev, &dev_attr_eject);
+}
 /* --------------------------------------------------------------------------
 			ACPI Bus operations
    -------------------------------------------------------------------------- */
@@ -353,8 +264,6 @@ static struct bus_type acpi_bus_type = {
 static void acpi_device_register(struct acpi_device *device,
 				 struct acpi_device *parent)
 {
-	int err;
-
 	/*
 	 * Linkage
 	 * -------
@@ -375,17 +284,6 @@ static void acpi_device_register(struct
 		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
 	spin_unlock(&acpi_device_lock);
 
-	strlcpy(device->kobj.name, device->pnp.bus_id, KOBJ_NAME_LEN);
-	if (parent)
-		device->kobj.parent = &parent->kobj;
-	device->kobj.ktype = &ktype_acpi_ns;
-	device->kobj.kset = &acpi_namespace_kset;
-	err = kobject_register(&device->kobj);
-	if (err < 0)
-		printk(KERN_WARNING "%s: kobject_register error: %d\n",
-			__FUNCTION__, err);
-	create_sysfs_device_files(device);
-
 	if (device->parent)
 		device->dev.parent = &parent->dev;
 	device->dev.bus = &acpi_bus_type;
@@ -393,6 +291,8 @@ static void acpi_device_register(struct
 	sprintf(device->dev.bus_id, "%s", device->pnp.bus_id);
 	device->dev.release = &acpi_device_release;
 	device_add(&device->dev);
+
+	acpi_device_setup_files(device);
 }
 
 static void acpi_device_unregister(struct acpi_device *device, int type)
@@ -409,9 +309,8 @@ static void acpi_device_unregister(struc
 	spin_unlock(&acpi_device_lock);
 
 	acpi_detach_data(device->handle, acpi_bus_data_handler);
-	remove_sysfs_device_files(device);
-	kobject_unregister(&device->kobj);
 
+	acpi_device_remove_files(device);
 	device_unregister(&device->dev);
 }
 
@@ -1353,10 +1252,6 @@ static int __init acpi_scan_init(void)
 	if (acpi_disabled)
 		return 0;
 
-	result = kset_register(&acpi_namespace_kset);
-	if (result < 0)
-		printk(KERN_ERR PREFIX "kset_register error: %d\n", result);
-
 	result = bus_register(&acpi_bus_type);
 	if (result) {
 		/* We don't want to quit even if we failed to add suspend/resume */
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 137fdee..d409d9a 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -299,7 +299,6 @@ struct acpi_device {
 	struct acpi_device_ops ops;
 	struct acpi_driver *driver;
 	void *driver_data;
-	struct kobject kobj;
 	struct device dev;
 };
 
-- 
1.4.4.g59427
