From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V6 1/2] introduce ALS sysfs class
Date: Tue, 01 Sep 2009 15:25:47 +0800
Message-ID: <1251789947.3483.215.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43268 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819AbZIAH2A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Sep 2009 03:28:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>, "Zhang, Rui" <rui.zhang@intel.com>


Introduce ALS sysfs class.

ALS sysfs class provides a standard sysfs interface for
Ambient Light Sensor devices.

please read Documentation/ABI/testing/sysfs-class-als for
detailed sysfs designs.

=EF=BB=BFCC: Pavel Machek <pavel@ucw.cz>
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/ABI/testing/sysfs-class-als |   23 +++
 MAINTAINERS                               |    6=20
 drivers/Kconfig                           |    2=20
 drivers/Makefile                          |    1=20
 drivers/als/Kconfig                       |   10 +
 drivers/als/Makefile                      |    5=20
 drivers/als/als_sys.c                     |  200 +++++++++++++++++++++=
+++++++++
 include/linux/als_sys.h                   |   51 +++++++
 8 files changed, 298 insertions(+)

Index: linux-2.6/drivers/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/Kconfig
+++ linux-2.6/drivers/Kconfig
@@ -62,6 +62,8 @@ source "drivers/power/Kconfig"
=20
 source "drivers/hwmon/Kconfig"
=20
+source "drivers/als/Kconfig"
+
 source "drivers/thermal/Kconfig"
=20
 source "drivers/watchdog/Kconfig"
Index: linux-2.6/drivers/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/Makefile
+++ linux-2.6/drivers/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_PPS)		+=3D pps/
 obj-$(CONFIG_W1)		+=3D w1/
 obj-$(CONFIG_POWER_SUPPLY)	+=3D power/
 obj-$(CONFIG_HWMON)		+=3D hwmon/
+obj-$(CONFIG_ALS)		+=3D als/
 obj-$(CONFIG_THERMAL)		+=3D thermal/
 obj-$(CONFIG_WATCHDOG)		+=3D watchdog/
 obj-$(CONFIG_PHONE)		+=3D telephony/
Index: linux-2.6/drivers/als/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6/drivers/als/Kconfig
@@ -0,0 +1,10 @@
+#
+# Ambient Light Sensor sysfs device configuration
+#
+
+menuconfig ALS
+	tristate "Ambient Light Sensor sysfs device"
+	help
+	  This framework provides a generic sysfs interface for
+	  Ambient Light Sensor devices.
+	  If you want this support, you should say Y or M here.
Index: linux-2.6/drivers/als/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6/drivers/als/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for Ambient Light Sensor device drivers.
+#
+
+obj-$(CONFIG_ALS)		+=3D als_sys.o
Index: linux-2.6/drivers/als/als_sys.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6/drivers/als/als_sys.c
@@ -0,0 +1,200 @@
+/*
+ *  als_sys.c - Ambient Light Sensor Sysfs support.
+ *
+ *  Copyright (C) 2009 Intel Corp
+ *  Copyright (C) 2009 Zhang Rui <rui.zhang@intel.com>
+ *
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
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
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/als_sys.h>
+
+MODULE_AUTHOR("Zhang Rui");
+MODULE_DESCRIPTION("Ambient Light Sensor sysfs support");
+MODULE_LICENSE("GPL");
+
+static int als_get_adjustment(struct als_device *, int, int *);
+
+/* sys I/F for Ambient Light Sensor */
+
+#define to_als_device(dev) container_of(dev, struct als_device, device=
)
+
+static ssize_t
+illuminance_show(struct device *dev, struct device_attribute *attr, ch=
ar *buf)
+{
+	struct als_device *als =3D to_als_device(dev);
+	int illuminance;
+	int result;
+
+	result =3D als->ops->get_illuminance(als, &illuminance);
+	if (result)
+		return result;
+
+	if (!illuminance)
+		return sprintf(buf, "Illuminance below the supported range\n");
+	else if (illuminance =3D=3D -1)
+		return sprintf(buf, "Illuminance above the supported range\n");
+	else if (illuminance < -1)
+		return -ERANGE;
+	else
+		return sprintf(buf, "%d\n", illuminance);
+}
+
+static ssize_t
+adjustment_show(struct device *dev, struct device_attribute *attr, cha=
r *buf)
+{
+	struct als_device *als =3D to_als_device(dev);
+	int illuminance, adjustment;
+	int result;
+
+	result =3D als->ops->get_illuminance(als, &illuminance);
+	if (result)
+		return result;
+
+	if (illuminance < 0 && illuminance !=3D -1)
+		return sprintf(buf, "Current illuminance invalid\n");
+
+	result =3D als_get_adjustment(als, illuminance, &adjustment);
+	if (result)
+		return result;
+
+	return sprintf(buf, "%d%%\n", adjustment);
+}
+
+static struct device_attribute als_attrs[] =3D {
+	__ATTR(illuminance, 0444, illuminance_show, NULL),
+	__ATTR(display_adjustment, 0444, adjustment_show, NULL),
+	__ATTR_NULL,
+};
+
+static void als_release(struct device *dev)
+{
+	struct als_device *als =3D to_als_device(dev);
+
+	kfree(als);
+}
+
+static struct class als_class =3D {
+	.name =3D "als",
+	.dev_release =3D als_release,
+	.dev_attrs =3D als_attrs,
+};
+
+static int als_get_adjustment(struct als_device *als, int illuminance,
+			      int *adjustment)
+{
+	int lux_high, lux_low, adj_high, adj_low;
+	int i;
+
+	if (!als->mappings)
+		return -EINVAL;
+
+	if (illuminance =3D=3D -1
+	    || illuminance > als->mappings[als->count - 1].illuminance)
+		illuminance =3D als->mappings[als->count - 1].illuminance;
+	else if (illuminance < als->mappings[0].illuminance)
+		illuminance =3D als->mappings[0].illuminance;
+
+	for (i =3D 0; i < als->count; i++) {
+		if (illuminance =3D=3D als->mappings[i].illuminance) {
+			*adjustment =3D als->mappings[i].adjustment;
+			return 0;
+		}
+
+		if (illuminance > als->mappings[i].illuminance)
+			continue;
+
+		lux_high =3D als->mappings[i].illuminance;
+		lux_low =3D als->mappings[i - 1].illuminance;
+		adj_high =3D als->mappings[i].adjustment;
+		adj_low =3D als->mappings[i - 1].adjustment;
+
+		*adjustment =3D
+		    ((adj_high - adj_low) * (illuminance - lux_low)) /
+			(lux_high - lux_low) + adj_low;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+/**
+ * als_device_register - register a new Ambient Light Sensor class dev=
ice
+ * @ops:	standard ALS devices callbacks.
+ * @devdata:	device private data.
+ */
+struct als_device *als_device_register(struct als_device_ops *ops,
+				       char *name, void *devdata)
+{
+	struct als_device *als;
+	int result =3D -ENOMEM;
+
+	if (!ops || !ops->get_illuminance || !name)
+		return ERR_PTR(-EINVAL);
+
+	als =3D kzalloc(sizeof(struct als_device), GFP_KERNEL);
+	if (!als)
+		return ERR_PTR(-ENOMEM);
+
+	als->ops =3D ops;
+	als->device.class =3D &als_class;
+	dev_set_name(&als->device, name);
+	dev_set_drvdata(&als->device, devdata);
+	result =3D device_register(&als->device);
+	if (result)
+		goto err;
+
+	if (ops->update_mappings) {
+		result =3D ops->update_mappings(als);
+		if (result) {
+			device_unregister(&als->device);
+			goto err;
+		}
+	}
+	return als;
+
+err:
+	kfree(als);
+	return ERR_PTR(result);
+}
+EXPORT_SYMBOL(als_device_register);
+
+/**
+ * als_device_unregister - removes the registered ALS device
+ * @als:	the ALS device to remove.
+ */
+void als_device_unregister(struct als_device *als)
+{
+	device_unregister(&als->device);
+}
+EXPORT_SYMBOL(als_device_unregister);
+
+static int __init als_init(void)
+{
+	return class_register(&als_class);
+}
+
+static void __exit als_exit(void)
+{
+	class_unregister(&als_class);
+}
+
+subsys_initcall(als_init);
+module_exit(als_exit);
Index: linux-2.6/include/linux/als_sys.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6/include/linux/als_sys.h
@@ -0,0 +1,51 @@
+/*
+ *  als.h
+ *
+ *  Copyright (C) 2009  Intel Corp
+ *  Copyright (C) 2009  Zhang Rui <rui.zhang@intel.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
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
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
+ */
+
+#ifndef __ALS_SYS_H__
+#define __ALS_SYS_H__
+
+#include <linux/device.h>
+
+struct als_device;
+
+struct als_device_ops {
+	int (*get_illuminance) (struct als_device *, int *);
+	int (*update_mappings) (struct als_device *);
+};
+
+struct als_mapping {
+	int illuminance;
+	int adjustment;
+};
+
+struct als_device {
+	struct device device;
+	struct als_device_ops *ops;
+	int count;
+	struct als_mapping *mappings;
+};
+
+struct als_device *als_device_register(struct als_device_ops *, char *=
, void *);
+void als_device_unregister(struct als_device *);
+
+#endif /* __ALS_SYS_H__ */
Index: linux-2.6/Documentation/ABI/testing/sysfs-class-als
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6/Documentation/ABI/testing/sysfs-class-als
@@ -0,0 +1,23 @@
+What:		/sys/class/als/.../illuminance
+Date:		Aug. 2009
+KernelVersion:	2.6.32
+Contact:	Zhang Rui <rui.zhang@intel.com>
+Description:	Current Ambient Light Illuminance reported by
+		native ALS driver
+		Unit: lux (lumens per square meter)
+		RO
+
+What:		/sys/class/als/.../display_adjustment
+Date:		Aug. 2009
+KernelVersion:	2.6.32
+Contact:	Zhang Rui <rui.zhang@intel.com>
+Description:	a relative percentages in order to simplify the means
+		by which these adjustments are applied in lieu of
+		changes to the user=E2=80=99s display brightness preference.
+		A value of 100% is used to indicate no display
+		brightness adjustment.
+		Values less than 100% indicate a negative adjustment
+		(dimming); values greater than 100% indicate a positive
+		adjustment (brightening).
+		RO
+
Index: linux-2.6/MAINTAINERS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/MAINTAINERS
+++ linux-2.6/MAINTAINERS
@@ -399,6 +399,12 @@ S:	Maintained for 2.4; PCI support for 2
 L:	linux-alpha@vger.kernel.org
 F:	arch/alpha/
=20
+AMBIENT LIGHT SENSOR
+M:	Zhang Rui <rui.zhang@intel.com>
+S:	Supported
+F:	include/linux/als_sys.h
+F:	drivers/als/
+
 AMD GEODE CS5536 USB DEVICE CONTROLLER DRIVER
 M:	Thomas Dahlmann <dahlmann.thomas@arcor.de>
 L:	linux-geode@lists.infradead.org (moderated for non-subscribers)


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
