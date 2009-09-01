From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V6 2/2] introduce ACPI ALS device driver
Date: Tue, 01 Sep 2009 15:25:56 +0800
Message-ID: <1251789956.3483.216.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753133AbZIAH2S@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org


ACPI spec defines ACPI Ambient Light Sensor device (hid ACPI0008),
which provides a standard interface by which the OS may query propertie=
s
of the ambient light environment the system is currently operating in,
as well as the ability to detect meaningful changes in these values whe=
n
the environment changes.

This patch introduces the ACPI ALS device driver.

CC: Pavel Machek <pavel@ucw.cz>
CC: =EF=BB=BFDmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/acpi/debug.txt |    1=20
 MAINTAINERS                  |    7=20
 drivers/acpi/Kconfig         |    9=20
 drivers/acpi/Makefile        |    1=20
 drivers/acpi/als.c           |  393 ++++++++++++++++++++++++++++++++++=
+++++++++
 drivers/acpi/debug.c         |    1=20
 include/acpi/acpi_drivers.h  |    1=20
 7 files changed, 413 insertions(+)

Index: linux-2.6/drivers/acpi/als.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6/drivers/acpi/als.c
@@ -0,0 +1,393 @@
+/*
+ *  als.c - ACPI Ambient Light Sensor Driver
+ *
+ *  Copyright (C) 2009 Intel Corp
+ *  Copyright (C) 2009 Zhang Rui <rui.zhang@intel.com>
+ *
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modi=
fy
+ *  it under the terms of the GNU General Public License as published =
by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, bu=
t
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License =
along
+ *  with this program; if not, write to the Free Software Foundation, =
Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/als_sys.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+
+#define PREFIX "ACPI: "
+
+#define ACPI_ALS_CLASS			"als"
+#define ACPI_ALS_DEVICE_NAME		"Ambient Light Sensor"
+#define ACPI_ALS_NOTIFY_ILLUMINANCE	0x80
+#define ACPI_ALS_NOTIFY_COLOR_TEMP	0x81
+#define ACPI_ALS_NOTIFY_RESPONSE	0x82
+
+#define _COMPONENT		ACPI_ALS_COMPONENT
+ACPI_MODULE_NAME("als");
+
+MODULE_AUTHOR("Zhang Rui");
+MODULE_DESCRIPTION("ACPI Ambient Light Sensor Driver");
+MODULE_LICENSE("GPL");
+
+static int acpi_als_add(struct acpi_device *device);
+static int acpi_als_remove(struct acpi_device *device, int type);
+static void acpi_als_notify(struct acpi_device *device, u32 event);
+
+static const struct acpi_device_id als_device_ids[] =3D {
+	{"ACPI0008", 0},
+	{"", 0},
+};
+
+MODULE_DEVICE_TABLE(acpi, als_device_ids);
+
+static struct acpi_driver acpi_als_driver =3D {
+	.name =3D "als",
+	.class =3D ACPI_ALS_CLASS,
+	.ids =3D als_device_ids,
+	.ops =3D {
+		.add =3D acpi_als_add,
+		.remove =3D acpi_als_remove,
+		.notify =3D acpi_als_notify,
+		},
+};
+
+struct acpi_als {
+	struct acpi_device *device;
+	struct als_device *als_sys;
+	int illuminance;
+	int chromaticity;
+	int temperature;
+	int polling;
+	int count;
+	struct als_mapping *mappings;
+};
+
+#define ALS_INVALID_VALUE_LOW		0
+#define ALS_INVALID_VALUE_HIGH		-1
+
+/* -------------------------------------------------------------------=
-------
+		Ambient Light Sensor device Management
+   -------------------------------------------------------------------=
------- */
+
+/*
+ * acpi_als_get_illuminance - get the current ambient light illuminanc=
e
+ */
+static int acpi_als_get_illuminance(struct acpi_als *als)
+{
+	acpi_status status;
+	unsigned long long illuminance;
+
+	status =3D
+	    acpi_evaluate_integer(als->device->handle, "_ALI", NULL,
+				  &illuminance);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Error reading ALS illuminance"));
+		als->illuminance =3D ALS_INVALID_VALUE_LOW;
+		return -ENODEV;
+	}
+	als->illuminance =3D illuminance;
+	return 0;
+}
+
+/*
+ * acpi_als_get_color_chromaticity - get the ambient light color chrom=
aticity
+ */
+static int acpi_als_get_color_chromaticity(struct acpi_als *als)
+{
+	acpi_status status;
+	unsigned long long chromaticity;
+
+	status =3D
+	    acpi_evaluate_integer(als->device->handle, "_ALC", NULL,
+				  &chromaticity);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_ALC not available\n"));
+		return -ENODEV;
+	}
+	als->chromaticity =3D chromaticity;
+	return 0;
+}
+
+/*
+ * acpi_als_get_color_temperature - get the ambient light color temper=
ature
+ */
+static int acpi_als_get_color_temperature(struct acpi_als *als)
+{
+	acpi_status status;
+	unsigned long long temperature;
+
+	status =3D
+	    acpi_evaluate_integer(als->device->handle, "_ALT", NULL,
+				  &temperature);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_ALT not available\n"));
+		return -ENODEV;
+	}
+	als->temperature =3D temperature;
+	return 0;
+}
+
+/*
+ * acpi_als_get_mappings - get the ALS illuminance mappings
+ *
+ * Return a package of ALS illuminance to display adjustment mappings
+ * that can be used by OS to calibrate its ambient light policy
+ * for a given sensor configuration.
+ */
+static int acpi_als_get_mappings(struct acpi_als *als)
+{
+	int result =3D 0;
+	acpi_status status;
+	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *alr;
+	int i, j;
+
+	/* Free the old mappings */
+	kfree(als->mappings);
+	als->mappings =3D NULL;
+
+	status =3D
+	    acpi_evaluate_object(als->device->handle, "_ALR", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status, "Error reading ALS mappings"));
+		return -ENODEV;
+	}
+
+	alr =3D buffer.pointer;
+	if (!alr || (alr->type !=3D ACPI_TYPE_PACKAGE)) {
+		printk(KERN_ERR PREFIX "Invalid _ALR data\n");
+		result =3D -EFAULT;
+		goto end;
+	}
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d illuminance mappings\n",
+			  alr->package.count));
+
+	als->count =3D alr->package.count;
+
+	if (!als->count)
+		return 0;
+
+	als->mappings =3D
+	    kmalloc(sizeof(struct als_mapping) * als->count, GFP_KERNEL);
+	if (!als->mappings) {
+		result =3D -ENOMEM;
+		goto end;
+	}
+
+	for (i =3D 0, j =3D 0; i < als->count; i++) {
+		struct als_mapping *mapping =3D &(als->mappings[j]);
+		union acpi_object *element =3D &(alr->package.elements[i]);
+
+		if (element->type !=3D ACPI_TYPE_PACKAGE)
+			continue;
+
+		if (element->package.count !=3D 2)
+			continue;
+
+		if (element->package.elements[0].type !=3D ACPI_TYPE_INTEGER ||
+		    element->package.elements[1].type !=3D ACPI_TYPE_INTEGER)
+			continue;
+
+		mapping->adjustment =3D
+		    element->package.elements[0].integer.value;
+		mapping->illuminance =3D
+		    element->package.elements[1].integer.value;
+		j++;
+
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Mapping [%d]: "
+				  "adjuestment [%d] illuminance[%d]\n",
+				  i, mapping->adjustment,
+				  mapping->illuminance));
+	}
+
+end:
+	kfree(buffer.pointer);
+	return result;
+}
+
+/*
+ * acpi_als_get_polling - get a recommended polling frequency
+ * 			  for the Ambient Light Sensor device
+ */
+static int acpi_als_get_polling(struct acpi_als *als)
+{
+	acpi_status status;
+	unsigned long long polling;
+
+	status =3D
+	    acpi_evaluate_integer(als->device->handle, "_ALP", NULL, &polling=
);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_ALP not available\n"));
+		return -ENODEV;
+	}
+
+	als->polling =3D polling;
+	return 0;
+}
+
+/*--------------------------------------------------------------------=
----
+ *                                ALS sysfs I/F
+ *--------------------------------------------------------------------=
---- */
+
+static int get_illuminance(struct als_device *als_sys, int *illuminanc=
e)
+{
+	struct acpi_als *als =3D dev_get_drvdata(&als_sys->device);
+	int result;
+
+	result =3D acpi_als_get_illuminance(als);
+	if (!result)
+		*illuminance =3D als->illuminance;
+	return result;
+}
+
+static int update_mappings(struct als_device *als_sys)
+{
+	struct acpi_als *als =3D dev_get_drvdata(&als_sys->device);
+	int result;
+
+	result =3D acpi_als_get_mappings(als);
+	if (result)
+		return result;
+
+	als_sys->mappings =3D als->mappings;
+	als_sys->count =3D als->count;
+
+	return 0;
+}
+
+struct als_device_ops acpi_als_ops =3D {
+	.get_illuminance =3D get_illuminance,
+	.update_mappings =3D update_mappings,
+};
+
+/* -------------------------------------------------------------------=
-------
+				 Driver Model
+   -------------------------------------------------------------------=
------- */
+
+static void acpi_als_notify(struct acpi_device *device, u32 event)
+{
+	struct acpi_als *als =3D acpi_driver_data(device);
+
+	if (!als)
+		return;
+
+	switch (event) {
+	case ACPI_ALS_NOTIFY_ILLUMINANCE:
+		acpi_als_get_illuminance(als);
+		break;
+	case ACPI_ALS_NOTIFY_COLOR_TEMP:
+		acpi_als_get_color_temperature(als);
+		acpi_als_get_color_chromaticity(als);
+		break;
+	case ACPI_ALS_NOTIFY_RESPONSE:
+		update_mappings(als->als_sys);
+		break;
+	default:
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "Unsupported event [0x%x]\n", event));
+	}
+	acpi_bus_generate_proc_event(device, event, (u32) als->illuminance);
+	acpi_bus_generate_netlink_event(device->pnp.device_class,
+					dev_name(&device->dev), event,
+					(u32) als->illuminance);
+}
+
+static int acpi_als_add(struct acpi_device *device)
+{
+	int result;
+	static int als_id;
+	char name[10];
+	struct acpi_als *als;
+
+	if (unlikely(als_id >=3D 10)) {
+		printk(KERN_WARNING PREFIX "Too many ALS device found\n");
+		return -ENODEV;
+	}
+
+	als =3D kzalloc(sizeof(struct acpi_als), GFP_KERNEL);
+	if (!als)
+		return -ENOMEM;
+
+	als->device =3D device;
+	strcpy(acpi_device_name(device), ACPI_ALS_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_ALS_CLASS);
+	device->driver_data =3D als;
+
+	result =3D acpi_als_get_illuminance(als);
+	if (result)
+		goto err;
+
+	result =3D acpi_als_get_mappings(als);
+	if (result)
+		goto err;
+
+	acpi_als_get_color_temperature(als);
+	acpi_als_get_color_chromaticity(als);
+	acpi_als_get_polling(als);
+
+	sprintf(name, "acpi_als%d", als_id++);
+	als->als_sys =3D als_device_register(&acpi_als_ops, name, als);
+	if (IS_ERR(als->als_sys)) {
+		result =3D PTR_ERR(als->als_sys);
+		als->als_sys =3D NULL;
+		goto err;
+	}
+
+	result =3D sysfs_create_link(&als->als_sys->device.kobj,
+				&device->dev.kobj, "device");
+	if (result) {
+		printk(KERN_ERR PREFIX "Create sysfs link\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	if (als->als_sys)
+		als_device_unregister(als->als_sys);
+	kfree(als->mappings);
+	kfree(als);
+	return result;
+}
+
+static int acpi_als_remove(struct acpi_device *device, int type)
+{
+	struct acpi_als *als =3D acpi_driver_data(device);
+
+	sysfs_remove_link(&als->als_sys->device.kobj, "device");
+	als_device_unregister(als->als_sys);
+	kfree(als->mappings);
+	kfree(als);
+	return 0;
+}
+
+static int __init acpi_als_init(void)
+{
+	return acpi_bus_register_driver(&acpi_als_driver);
+}
+
+static void __exit acpi_als_exit(void)
+{
+	acpi_bus_unregister_driver(&acpi_als_driver);
+}
+
+module_init(acpi_als_init);
+module_exit(acpi_als_exit);
Index: linux-2.6/drivers/acpi/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/Kconfig
+++ linux-2.6/drivers/acpi/Kconfig
@@ -333,4 +333,13 @@ config ACPI_SBS
 	  To compile this driver as a module, choose M here:
 	  the modules will be called sbs and sbshc.
=20
+config ACPI_ALS
+	tristate "Ambient Light Sensor driver"
+	select ALS
+	help
+	  This driver supports the ACPI Ambient Light Sensor.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called als.
+
 endif	# ACPI
Index: linux-2.6/drivers/acpi/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/Makefile
+++ linux-2.6/drivers/acpi/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_ACPI_HOTPLUG_MEMORY) +=3D acp
 obj-$(CONFIG_ACPI_BATTERY)	+=3D battery.o
 obj-$(CONFIG_ACPI_SBS)		+=3D sbshc.o
 obj-$(CONFIG_ACPI_SBS)		+=3D sbs.o
+obj-$(CONFIG_ACPI_ALS)		+=3D als.o
=20
 # processor has its own "processor." module_param namespace
 processor-y			:=3D processor_core.o processor_throttling.o
Index: linux-2.6/Documentation/acpi/debug.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/Documentation/acpi/debug.txt
+++ linux-2.6/Documentation/acpi/debug.txt
@@ -63,6 +63,7 @@ shows the supported mask values, current
     ACPI_MEMORY_DEVICE_COMPONENT    0x08000000
     ACPI_VIDEO_COMPONENT            0x10000000
     ACPI_PROCESSOR_COMPONENT        0x20000000
+    ACPI_ALS_COMPONENT              0x40000000
=20
 debug_level
 -----------
Index: linux-2.6/drivers/acpi/debug.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/debug.c
+++ linux-2.6/drivers/acpi/debug.c
@@ -53,6 +53,7 @@ static const struct acpi_dlayer acpi_deb
 	ACPI_DEBUG_INIT(ACPI_MEMORY_DEVICE_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_VIDEO_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_PROCESSOR_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_ALS_COMPONENT),
 };
=20
 static const struct acpi_dlevel acpi_debug_levels[] =3D {
Index: linux-2.6/include/acpi/acpi_drivers.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/include/acpi/acpi_drivers.h
+++ linux-2.6/include/acpi/acpi_drivers.h
@@ -49,6 +49,7 @@
 #define ACPI_MEMORY_DEVICE_COMPONENT	0x08000000
 #define ACPI_VIDEO_COMPONENT		0x10000000
 #define ACPI_PROCESSOR_COMPONENT	0x20000000
+#define ACPI_ALS_COMPONENT		0x40000000
=20
 /*
  * _HID definitions
Index: linux-2.6/MAINTAINERS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/MAINTAINERS
+++ linux-2.6/MAINTAINERS
@@ -234,6 +234,13 @@ F:	drivers/acpi/
 F:	drivers/pnp/pnpacpi/
 F:	include/linux/acpi.h
=20
+ACPI AMBIENT LIGHT SENSOR DRIVER
+M:	Zhang Rui <rui.zhang@intel.com>
+L:	linux-acpi@vger.kernel.org
+W:	http://www.lesswatts.org/projects/acpi/
+S:	Supported
+F:	drivers/acpi/als.c
+
 ACPI BATTERY DRIVERS
 M:	Alexey Starikovskiy <astarikovskiy@suse.de>
 L:	linux-acpi@vger.kernel.org
