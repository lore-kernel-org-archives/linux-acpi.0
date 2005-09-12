From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC 1/2]introduce ACPI bus
Date: Mon, 12 Sep 2005 13:22:25 +0800
Message-ID: <1126502545.5153.18.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
This patch introduces acpi bus_type. We regard devices which don't belong to other buses
as physical ACPI devices. PNP devices, PCI devices & other devices in DSDT
should bind them to their specific physical buses.

Thanks,
Shaohua
---

 linux-2.6.13-root/drivers/acpi/scan.c     |  205 ++++++++++++++++++++++++++++++
 linux-2.6.13-root/include/acpi/acpi_bus.h |    8 +
 2 files changed, 212 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/scan.c~acpi_bus drivers/acpi/scan.c
--- linux-2.6.13/drivers/acpi/scan.c~acpi_bus	2005-08-31 10:35:57.000000000 +0800
+++ linux-2.6.13-root/drivers/acpi/scan.c	2005-09-06 16:22:00.000000000 +0800
@@ -119,6 +119,201 @@ static struct kset acpi_namespace_kset =
 };
 

+static int
+acpi_bus_match (
+	struct acpi_device	*device,
+	struct acpi_driver	*driver);
+static int acpi_phys_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct acpi_device *acpi_dev = to_acpi_phys_dev(dev);
+	struct acpi_driver *acpi_drv = to_acpi_phys_drv(drv);
+
+	return !acpi_bus_match(acpi_dev, acpi_drv);
+}
+
+static int acpi_phys_bus_hotplug(struct device *dev, char **envp,
+	int num_envp, char *buffer, int buffer_size)
+{
+	int i = 0;
+	struct acpi_device *acpi_dev = to_acpi_phys_dev(dev);
+	char *scratch;
+	int length = 0;
+	struct acpi_compatible_id_list *cid_list;
+
+	scratch = buffer;
+	if (acpi_dev->flags.hardware_id) {
+		envp[i++] = scratch;
+		length += scnprintf(scratch, buffer_size - length, "HWID=%s",
+			acpi_dev->pnp.hardware_id);
+		if ((buffer_size - length <=0) || (i > num_envp))
+			return -ENOMEM;
+		++length;
+		scratch += length;
+	}
+	if (acpi_dev->flags.compatible_ids) {
+		int j;
+		cid_list = acpi_dev->pnp.cid_list;
+
+		/* multiple _CID entries */
+		for (j = 0; j < cid_list->count; j++)
+		{
+			envp[i++] = scratch;
+			length += scnprintf(scratch, buffer_size - length,
+				"COMPTID=%s", cid_list->id[j].value);
+			if ((buffer_size - length <=0) || (i > num_envp))
+				return -ENOMEM;
+			++length;
+			scratch += length;
+		}
+	}
+	envp[i] = NULL;
+
+	return 0;
+}
+
+static int acpi_phys_bus_suspend(struct device * dev, pm_message_t state)
+{
+	struct acpi_device *acpi_dev = to_acpi_phys_dev(dev);
+	int acpi_state = (int __force)state;
+
+	if (!acpi_dev->driver || !acpi_dev->driver->ops.suspend)
+		return 0;
+	return acpi_dev->driver->ops.suspend(acpi_dev, acpi_state);
+}
+
+static int acpi_phys_bus_resume(struct device * dev)
+{
+	struct acpi_device *acpi_dev = to_acpi_phys_dev(dev);
+
+	if (!acpi_dev->driver || !acpi_dev->driver->ops.resume)
+		return 0;
+	/* the second parameter is meanless */
+	return acpi_dev->driver->ops.resume(acpi_dev, 0);
+}
+
+static struct bus_type acpi_phys_bus_type = {
+	.name = "acpi",
+	.match = acpi_phys_bus_match,
+	.hotplug = acpi_phys_bus_hotplug,
+	.suspend = acpi_phys_bus_suspend,
+	.resume = acpi_phys_bus_resume,
+};
+
+static int __init acpi_phys_bus_init(void)
+{
+	return bus_register(&acpi_phys_bus_type);
+}
+postcore_initcall(acpi_phys_bus_init);
+
+char *ACPI_DEVICES_LIST[] = {
+	"PNP0C09", /* EC */
+	"ACPI0003", /* AC */
+	"PNP0C0F", /* Link */
+	"PNP0C0A", /* battery */
+	"PNP0C0C", "PNP0C0E", "PNP0C0D", "ACPI_FPB" ,"ACPI_FSB", /* button */
+	"PNP0C0B", /* fan */
+	"PNP0A03", /* PCI root */
+	ACPI_POWER_HID, /* power */
+	ACPI_PROCESSOR_HID, /* CPU */
+	ACPI_THERMAL_HID, /* thermal */
+};
+static int device_belong_2_acpi_bus(struct acpi_device *dev)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(ACPI_DEVICES_LIST); i++) {
+		if (!acpi_match_ids(dev, ACPI_DEVICES_LIST[i]))
+			return 1;
+	}
+	return 0;
+}
+
+static int driver_belong_2_acpi_bus(struct acpi_driver *drv)
+{
+	int i;
+	if (!drv->ids)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(ACPI_DEVICES_LIST); i++) {
+		if (strstr(drv->ids, ACPI_DEVICES_LIST[i]))
+			return 1;
+	}
+	return 0;
+}
+
+static void acpi_phys_device_release(struct device *dev)
+{
+	/* does nothing here */
+}
+
+static int acpi_phys_device_register(struct acpi_device *acpi_dev)
+{
+	if (!device_belong_2_acpi_bus(acpi_dev))
+		return 0;
+	acpi_dev->phys_dev.parent = &acpi_root->phys_dev;
+	acpi_dev->phys_dev.bus = &acpi_phys_bus_type;
+	device_initialize(&acpi_dev->phys_dev);
+	sprintf(acpi_dev->phys_dev.bus_id, "%s", acpi_dev->pnp.bus_id);
+	acpi_dev->phys_dev.release = acpi_phys_device_release;
+	device_add(&acpi_dev->phys_dev);
+	return 0;
+}
+
+static int acpi_phys_device_unregister(struct acpi_device *acpi_dev)
+{
+	if (!device_belong_2_acpi_bus(acpi_dev))
+		return 0;
+	device_unregister(&acpi_dev->phys_dev);
+	return 0;
+}
+
+static int acpi_phys_device_probe(struct device *dev)
+{
+	get_device(dev);
+	/* idealy, acpi_ops->start should be called here */
+	return 0;
+}
+
+static int acpi_phys_device_remove(struct device * dev)
+{
+	/* doesn't call remove here */
+	put_device(dev);
+	return 0;
+}
+
+static void acpi_phys_device_shutdown(struct device *dev)
+{
+	struct acpi_device *acpi_dev = to_acpi_phys_dev(dev);
+
+	/* suppose .stop is for shutdown */
+	if (!acpi_dev->driver || !acpi_dev->driver->ops.stop)
+		return;
+	/* the second parameter is meanless*/
+	acpi_dev->driver->ops.stop(acpi_dev, 0);
+}
+
+static int acpi_phys_driver_register(struct acpi_driver *drv)
+{
+	int error;
+
+	if (!driver_belong_2_acpi_bus(drv))
+		return 0;
+	drv->phys_drv.name = drv->name;
+	drv->phys_drv.bus = &acpi_phys_bus_type;
+	drv->phys_drv.probe = acpi_phys_device_probe;
+	drv->phys_drv.remove = acpi_phys_device_remove;
+	drv->phys_drv.shutdown = acpi_phys_device_shutdown;
+	error = driver_register(&drv->phys_drv);
+	return error;
+}
+
+static void acpi_phys_driver_unregister(struct acpi_driver *drv)
+{
+	if (!driver_belong_2_acpi_bus(drv))
+		return;
+	driver_unregister(&drv->phys_drv);
+}
+/*-----------------------------------*/
+
 static void acpi_device_register(struct acpi_device * device, struct acpi_device * parent)
 {
 	/*
@@ -148,6 +343,8 @@ static void acpi_device_register(struct 
 	device->kobj.kset = &acpi_namespace_kset;
 	kobject_register(&device->kobj);
 	create_sysfs_device_files(device);
+
+	acpi_phys_device_register(device);
 }
 
 static int
@@ -169,6 +366,8 @@ acpi_device_unregister (
 	acpi_detach_data(device->handle, acpi_bus_data_handler);
 	remove_sysfs_device_files(device);
 	kobject_unregister(&device->kobj);
+
+	acpi_phys_device_unregister(device);
 	return 0;
 }
 
@@ -658,6 +857,7 @@ acpi_bus_register_driver (
 	list_add_tail(&driver->node, &acpi_bus_drivers);
 	spin_unlock(&acpi_device_lock);
 	count = acpi_driver_attach(driver);
+	acpi_phys_driver_register(driver);
 
 	return_VALUE(count);
 }
@@ -678,6 +878,8 @@ acpi_bus_unregister_driver (
 
 	ACPI_FUNCTION_TRACE("acpi_bus_unregister_driver");
 
+	acpi_phys_driver_unregister(driver);
+
 	if (driver) {
 		acpi_driver_detach(driver);
 
@@ -1435,6 +1637,9 @@ static int __init acpi_scan_init(void)
 		goto Done;
 
 	result = acpi_start_single_object(acpi_root);
+	acpi_root->phys_dev.release = acpi_phys_device_release;
+	strcpy(acpi_root->phys_dev.bus_id, "acpi");
+	device_register(&acpi_root->phys_dev);
 
 	/*
 	 * Enumerate devices in the ACPI namespace.
diff -puN include/acpi/acpi_bus.h~acpi_bus include/acpi/acpi_bus.h
--- linux-2.6.13/include/acpi/acpi_bus.h~acpi_bus	2005-08-31 10:35:57.000000000 +0800
+++ linux-2.6.13-root/include/acpi/acpi_bus.h	2005-09-05 13:17:44.000000000 +0800
@@ -28,6 +28,7 @@
 
 #include <linux/kobject.h>
 
+#include <linux/device.h>
 #include <acpi/acpi.h>
 
 #define PREFIX			"ACPI: "
@@ -144,6 +145,7 @@ struct acpi_driver {
 	atomic_t		references;
 	char			*ids;		/* Supported Hardware IDs */
 	struct acpi_device_ops	ops;
+	struct device_driver	phys_drv;
 };
 
 /*
@@ -309,10 +311,15 @@ struct acpi_device {
 	struct acpi_driver	*driver;
 	void			*driver_data;
 	struct kobject		kobj;
+	struct device		phys_dev;
 };
 
 #define acpi_driver_data(d)	((d)->driver_data)
 
+/* acpi bus type for real ACPI device */
+#define to_acpi_phys_dev(n) container_of(n, struct acpi_device, phys_dev)
+#define to_acpi_phys_drv(n) container_of(n, struct acpi_driver, phys_drv)
+
 
 /*
  * Events
@@ -355,7 +362,6 @@ void acpi_remove_dir(struct acpi_device 
 /*
  * Bind physical devices with ACPI devices
  */
-#include <linux/device.h>
 struct acpi_bus_type {
 	struct list_head	list;
 	struct bus_type		*bus;
_




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
