From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC]convert ACPI driver model to Linux driver model - takes 2
Date: Thu, 13 Oct 2005 14:37:34 +0800
Message-ID: <1129185454.9074.15.camel@linux-hp.sh.intel.com>
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
Cc: Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
This is the updated patch for the topic. In this version, I completely
convert devices in ACPI bus into Linux driver model. Now the device
driver for ACPI bus device should be a 'struct acpi_phys_driver'. Old
style driver (struct acpi_driver) now can't work for ACPI bus devices.
Here I still regard devices listed in DSDT but not belonging to any
physical bus as ACPI bus devices.
For back compatibility, old style driver model still applies to non-ACPI
bus devices. In the implementation, we register an old style driver
(acpi_dummy) for each acpi bus device, whose goal is to enumerate acpi
bus devices and prevent new old style driver binding with the devices. 
I tried to convert one ACPI driver (link device driver) to the new
model. It's quite easy.
I'm looking forward to your comments/suggestions.

Thanks,
Shaohua
---

 linux-2.6.14-rc3-root/drivers/acpi/scan.c     |  231 +++++++++++++++++++++++++-
 linux-2.6.14-rc3-root/include/acpi/acpi_bus.h |   34 +++
 2 files changed, 263 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/scan.c~acpi_bus drivers/acpi/scan.c
--- linux-2.6.14-rc3/drivers/acpi/scan.c~acpi_bus	2005-10-11 14:13:26.000000000 +0800
+++ linux-2.6.14-rc3-root/drivers/acpi/scan.c	2005-10-13 13:59:08.000000000 +0800
@@ -112,6 +112,234 @@ static struct kset acpi_namespace_kset =
 	.hotplug_ops = &namespace_hotplug_ops,
 };
 
+/* ACPI phys bus */
+static int acpi_phys_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct acpi_phys_device *phys_dev = to_acpi_phys_dev(dev);
+	struct acpi_phys_driver *phys_drv = to_acpi_phys_drv(drv);
+	return !acpi_match_ids(phys_dev->acpi_dev, phys_drv->ids);
+}
+
+static int acpi_phys_bus_hotplug(struct device *dev, char **envp,
+	int num_envp, char *buffer, int buffer_size)
+{
+	int i = 0;
+	struct acpi_device *acpi_dev = to_acpi_phys_dev(dev)->acpi_dev;
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
+	struct acpi_phys_device *phys_dev = to_acpi_phys_dev(dev);
+
+	if (!phys_dev->driver || !phys_dev->driver->suspend)
+		return 0;
+	return phys_dev->driver->suspend(phys_dev, state);
+}
+
+static int acpi_phys_bus_resume(struct device * dev)
+{
+	struct acpi_phys_device *phys_dev = to_acpi_phys_dev(dev);
+
+	if (!phys_dev->driver || !phys_dev->driver->resume)
+		return 0;
+	return phys_dev->driver->resume(phys_dev);
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
+static LIST_HEAD(acpi_phys_devices);
+static DEFINE_SPINLOCK(acpi_phys_bus_lock);
+static struct acpi_phys_device *phys_root;
+
+static void acpi_phys_device_release(struct device *dev)
+{
+	struct acpi_phys_device *phys_dev = to_acpi_phys_dev(dev);
+	kfree(phys_dev);
+}
+
+static int acpi_phys_bus_add(struct acpi_device *acpi_dev)
+{
+	struct acpi_phys_device *phys_dev;
+
+	phys_dev = kzalloc(sizeof(struct acpi_phys_device), GFP_KERNEL);
+	if (!phys_dev)
+		return -ENOMEM;
+
+	spin_lock(&acpi_phys_bus_lock);
+	list_add_tail(&phys_dev->node, &acpi_phys_devices);
+	spin_unlock(&acpi_phys_bus_lock);
+
+	phys_dev->acpi_dev = acpi_dev;
+	phys_dev->phys_dev.parent = &phys_root->phys_dev;
+	phys_dev->phys_dev.bus = &acpi_phys_bus_type;
+	device_initialize(&phys_dev->phys_dev);
+	sprintf(phys_dev->phys_dev.bus_id, "%s", acpi_dev->pnp.bus_id);
+	phys_dev->phys_dev.release = acpi_phys_device_release;
+	device_add(&phys_dev->phys_dev);
+	return 0;
+}
+
+static int acpi_phys_bus_remove(struct acpi_device *acpi_dev, int type)
+{
+	struct acpi_phys_device *phys_dev, *tmp, *find = NULL;
+
+	spin_lock(&acpi_phys_bus_lock);
+	list_for_each_entry_safe(phys_dev, tmp, &acpi_phys_devices, node) {
+		if (phys_dev->acpi_dev == acpi_dev) {
+			find = phys_dev;
+			list_del(&find->node);
+			break;
+		}
+	}
+	spin_unlock(&acpi_phys_bus_lock);
+	if (find)
+		device_unregister(&find->phys_dev);
+	return 0;
+}
+
+/* this driver is linking acpi device with acpi phys device */
+static struct acpi_driver dummy_driver = {
+	.name = "acpi_dummy",
+	/* List all ids of ACPI phys devices */
+	.ids =
+//		"PNP0C09," /* EC */
+//		"ACPI0003," /* AC */
+//		"PNP0C0F," /* Link */
+//		"PNP0C0A," /* battery */
+//		"PNP0C0C,PNP0C0E,PNP0C0D,ACPI_FPB,ACPI_FSB," /* button */
+//		"PNP0C0B," /* fan */
+//		"PNP0A03," /* PCI root */
+//		ACPI_POWER_HID"," /* power */
+//		ACPI_PROCESSOR_HID"," /* CPU */
+//		ACPI_THERMAL_HID"," /* thermal */
+		"",
+	.ops = {
+		.add = acpi_phys_bus_add,
+		.remove = acpi_phys_bus_remove,
+	},
+};
+
+static int __init acpi_phys_bus_init(void)
+{
+	bus_register(&acpi_phys_bus_type);
+
+	phys_root = kzalloc(sizeof(struct acpi_phys_device), GFP_KERNEL);
+	if (!phys_root)
+		return -ENOMEM;
+
+	phys_root->acpi_dev = acpi_root;
+	phys_root->phys_dev.release = acpi_phys_device_release;
+	sprintf(phys_root->phys_dev.bus_id, "%s", acpi_root->pnp.bus_id);
+	device_register(&phys_root->phys_dev);
+
+	/* enumerate devices */
+	acpi_bus_register_driver(&dummy_driver);
+	return 0;
+}
+
+
+static int acpi_phys_device_probe(struct device *dev)
+{
+	int error = -ENODEV;
+	struct acpi_phys_device *phys_dev = to_acpi_phys_dev(dev);
+	struct acpi_phys_driver *phys_drv = to_acpi_phys_drv(dev->driver);
+
+	get_device(dev);
+	if (!phys_dev->driver && phys_drv->probe) {
+		error = phys_drv->probe(phys_dev);
+		if (error >= 0)
+			phys_dev->driver = phys_drv;
+	}
+	if (error < 0)
+		put_device(dev);
+	return error;
+}
+
+static int acpi_phys_device_remove(struct device * dev)
+{
+	struct acpi_phys_device *phys_dev = to_acpi_phys_dev(dev);
+	struct acpi_phys_driver *phys_drv = phys_dev->driver;
+
+	if (phys_drv) {
+		if (phys_drv->remove)
+			phys_drv->remove(phys_dev);
+		phys_dev->driver = NULL;
+	}
+	put_device(dev);
+	return 0;
+}
+
+static void acpi_phys_device_shutdown(struct device *dev)
+{
+	struct acpi_phys_device *phys_dev = to_acpi_phys_dev(dev);
+
+	if (!phys_dev->driver || !phys_dev->driver->shutdown)
+		return;
+
+	phys_dev->driver->shutdown(phys_dev);
+}
+
+int acpi_phys_driver_register(struct acpi_phys_driver *drv)
+{
+	int error;
+	/*FIXME: add to a list */
+	drv->phys_drv.name = drv->name;
+	drv->phys_drv.bus = &acpi_phys_bus_type;
+	drv->phys_drv.probe = acpi_phys_device_probe;
+	drv->phys_drv.remove = acpi_phys_device_remove;
+	drv->phys_drv.shutdown = acpi_phys_device_shutdown;
+	drv->phys_drv.owner = drv->owner;
+	error = driver_register(&drv->phys_drv);
+	return error;
+}
+EXPORT_SYMBOL(acpi_phys_driver_register);
+
+void acpi_phys_driver_unregister(struct acpi_phys_driver *drv)
+{
+	driver_unregister(&drv->phys_drv);
+}
+EXPORT_SYMBOL(acpi_phys_driver_unregister);
+/*-----------------------------------*/
+
 static void acpi_device_register(struct acpi_device *device,
 				 struct acpi_device *parent)
 {
@@ -1400,8 +1628,9 @@ static int __init acpi_scan_init(void)
 
 	if (result)
 		acpi_device_unregister(acpi_root, ACPI_BUS_REMOVAL_NORMAL);
+	acpi_phys_bus_init();
 
-      Done:
+Done:
 	return_VALUE(result);
 }
 
diff -puN include/acpi/acpi_bus.h~acpi_bus include/acpi/acpi_bus.h
--- linux-2.6.14-rc3/include/acpi/acpi_bus.h~acpi_bus	2005-10-11 14:13:26.000000000 +0800
+++ linux-2.6.14-rc3-root/include/acpi/acpi_bus.h	2005-10-13 10:43:21.000000000 +0800
@@ -28,6 +28,7 @@
 
 #include <linux/kobject.h>
 
+#include <linux/device.h>
 #include <acpi/acpi.h>
 
 #define PREFIX			"ACPI: "
@@ -300,6 +301,38 @@ struct acpi_device {
 
 #define acpi_driver_data(d)	((d)->driver_data)
 
+/* acpi bus type for real ACPI device */
+struct acpi_phys_device {
+	struct list_head node;
+	struct acpi_device *acpi_dev;
+	struct device phys_dev;
+	struct acpi_phys_driver *driver;
+	void *driver_data;
+};
+
+#define acpi_phys_driver_data(d) ((d)->driver_data)
+
+struct acpi_phys_driver {
+//	struct list_head node;
+	char name[80];
+	char class[80];
+	struct module *owner;
+	char *ids;
+	int (*probe)(struct acpi_phys_device *dev);
+	void (*remove) (struct acpi_phys_device *dev);
+	int  (*suspend) (struct acpi_phys_device *dev, pm_message_t state);
+	int  (*resume) (struct acpi_phys_device *dev);
+	void (*shutdown) (struct acpi_phys_device *dev);
+
+	struct device_driver    phys_drv;
+};
+
+#define to_acpi_phys_dev(n) container_of(n, struct acpi_phys_device, phys_dev)
+#define to_acpi_phys_drv(n) container_of(n, struct acpi_phys_driver, phys_drv)
+int acpi_phys_driver_register(struct acpi_phys_driver *drv);
+void acpi_phys_driver_unregister(struct acpi_phys_driver *drv);
+
+
 /*
  * Events
  * ------
@@ -339,7 +372,6 @@ void acpi_remove_dir(struct acpi_device 
 /*
  * Bind physical devices with ACPI devices
  */
-#include <linux/device.h>
 struct acpi_bus_type {
 	struct list_head list;
 	struct bus_type *bus;
_




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
