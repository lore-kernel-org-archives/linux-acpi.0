From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [RFC, PATCH] tc1100-wmi: Add driver for HP Compaq TC1100 Tablets
Date: Sun, 9 Dec 2007 00:21:23 +0000
Message-ID: <200712090021.24151.carlos@strangeworlds.co.uk>
References: <200712080158.39349.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:51879 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbXLIAXA (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Sat, 8 Dec 2007 19:23:00 -0500
In-Reply-To: <200712080158.39349.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux-acpi@vger.kernel.org
Cc: jamey.hicks@nokia.com, Matthew Garrett <mjg59@srcf.ucam.org>

Matthew - AFAICT, Ubuntu has been integrating an older version of this
work since 2.6.19 (https://launchpad.net/ubuntu/+source/linux-source-2.6.19),
so I'm CC'ing you on this.

Jamey - CC'ing you on this because your name was on the original patch I
adapted.

This patch converts the old driver from 2004 over to a platform driver,
based on ACPI-WMI (and consequently, stripping out all the PNP0C14 handling)
and replacing the /proc interface with a simpler sysfs one.

This is marked as an RFC for the rather important reason that I _don't_ have
the hardware - however, this is the only other out-of-Linus-tree WMI driver
I've found so far, and has already been integrated by some distributions
(I believe, as well as Ubuntu, that Mandriva have added this) so I felt it
was worth porting to the 'new' WMI interface (it's also easier to read than
acer-wmi, so may make a nice reference driver for WMI one day).

Obviously, as with acer-wmi, this patch depends on patch #1 of my ACPI WMI
series:
http://www.mail-archive.com/linux-acpi%40vger.kernel.org/msg10425.html

What I could do with is a victim^^^^^volunteer with the hardware to work with
me on testing this patch, and fixing the bugs that are probably in there
(some parts of the ACPI handling in the old code were a bit tricky for me to
get my head around, so I've probably reversed a few values here and there).

-Carlos
---
This is based on the 2004 out-of-tree work of Jamey Hicks, to add
support via WMI for controlling the bluetooth and wireless on these
tablets.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---
 drivers/misc/Kconfig      |    9 ++
 drivers/misc/Makefile     |    1 +
 drivers/misc/tc1100-wmi.c |  290 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 300 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/tc1100-wmi.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f014565..b6185e4 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -142,6 +142,15 @@ config FUJITSU_LAPTOP
 
 	  If you have a Fujitsu laptop, say Y or M here.
 
+config TC1100_WMI
+	tristate "HP Compaq TC1100 Tablet WMI Extras"
+	depends on X86 && !X86_64
+	depends on ACPI
+	depends on ACPI_WMI
+	---help---
+	  This is a driver for the WMI extensions (wireless and bluetooth power
+	  control) of the HP Compaq TC1100 tablet.
+
 config MSI_LAPTOP
         tristate "MSI Laptop Extras"
         depends on X86
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 3da1491..51196c0 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_MSI_LAPTOP)     += msi-laptop.o
 obj-$(CONFIG_ACER_WMI)     += acer-wmi.o
 obj-$(CONFIG_ASUS_LAPTOP)     += asus-laptop.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
+obj-$(CONFIG_TC1100_WMI)	+= tc1100-wmi.o
 obj-$(CONFIG_LKDTM)		+= lkdtm.o
 obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
 obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
diff --git a/drivers/misc/tc1100-wmi.c b/drivers/misc/tc1100-wmi.c
new file mode 100644
index 0000000..f0a8bdc
--- /dev/null
+++ b/drivers/misc/tc1100-wmi.c
@@ -0,0 +1,290 @@
+/*
+ *  HP Compaq TC1100 Tablet WMI Extras Driver
+ *
+ *  Copyright (C) 2007 Carlos Corbacho <carlos@strangeworlds.co.uk>
+ *  Copyright (C) 2004 Jamey Hicks <jamey.hicks@hp.com>
+ *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
+ *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <acpi/acpi.h>
+#include <acpi/actypes.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <linux/platform_device.h>
+
+#define GUID "C364AC71-36DB-495A-8494-B439D472A505"
+
+#define TC1100_INSTANCE_WIRELESS		1
+#define TC1100_INSTANCE_BLUETOOTH		2
+
+#define TC1100_LOGPREFIX "tc1100-wmi: "
+#define TC1100_INFO KERN_INFO TC1100_LOGPREFIX
+
+MODULE_AUTHOR("Jamey Hicks, Carlos Corbacho");
+MODULE_DESCRIPTION("HP Compaq TC1100 Tablet WMI Extras");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("wmi:C364AC71-36DB-495A-8494-B439D472A505");
+
+static int tc1100_probe(struct platform_device *device);
+static int tc1100_remove(struct platform_device *device);
+static int tc1100_suspend(struct platform_device *device, pm_message_t state);
+static int tc1100_resume(struct platform_device *device);
+
+static struct platform_driver tc1100_driver = {
+	.driver = {
+		.name = "tc1100-wmi",
+		.owner = THIS_MODULE,
+	},
+	.probe = tc1100_probe,
+	.remove = tc1100_remove,
+	.suspend = tc1100_suspend,
+	.resume = tc1100_resume,
+};
+
+static struct platform_device *tc1100_device;
+
+struct tc1100_data {
+	u32 wireless;
+	u32 bluetooth;
+};
+
+static struct tc1100_data suspend_data;
+
+/* --------------------------------------------------------------------------
+				Device Management
+   -------------------------------------------------------------------------- */
+
+static int get_state(u32 *out, u8 instance)
+{
+	u32 tmp;
+	acpi_status status;
+	struct acpi_buffer result = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+
+	if (!out)
+		return -EINVAL;
+
+	if (instance > 2)
+		return -ENODEV;
+
+	status = wmi_query_block(GUID, instance, &result);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	obj = (union acpi_object *) result.pointer;
+	if (obj && obj->type == ACPI_TYPE_BUFFER &&
+		obj->buffer.length == sizeof(u32)) {
+		tmp = *((u32 *) obj->buffer.pointer);
+	} else {
+		tmp = 0;
+	}
+
+	if (result.length > 0 && result.pointer)
+		kfree(result.pointer);
+
+	switch (instance) {
+	case TC1100_INSTANCE_WIRELESS:
+		*out = (tmp == 3) ? 1 : 0;
+		return 0;
+	case TC1100_INSTANCE_BLUETOOTH:
+		*out = (tmp == 1) ? 1 : 0;
+		return 0;
+	default:
+		return -ENODEV;
+	}
+}
+
+static int set_state(u32 *in, u8 instance)
+{
+	u32 value;
+	acpi_status status;
+	struct acpi_buffer input;
+
+	if (!in)
+		return -EINVAL;
+
+	if (instance > 2)
+		return -ENODEV;
+
+	switch (instance) {
+	case TC1100_INSTANCE_WIRELESS:
+		value = (*in) ? 1 : 2;
+		break;
+	case TC1100_INSTANCE_BLUETOOTH:
+		value = (*in) ? 0 : 1;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	input.length = sizeof(u32);
+	input.pointer = &value;
+
+	status = wmi_set_block(GUID, instance, &input);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return 0;
+}
+
+/* --------------------------------------------------------------------------
+				FS Interface (/sys)
+   -------------------------------------------------------------------------- */
+
+/*
+ * Read/ write bool sysfs macro
+ */
+#define show_set_bool(value, instance) \
+static ssize_t \
+show_bool_##value(struct device *dev, struct device_attribute *attr, \
+	char *buf) \
+{ \
+	u32 result; \
+	acpi_status status = get_state(&result, instance); \
+	if (ACPI_SUCCESS(status)) \
+		return sprintf(buf, "%d\n", result); \
+	return sprintf(buf, "Read error\n"); \
+} \
+\
+static ssize_t \
+set_bool_##value(struct device *dev, struct device_attribute *attr, \
+	const char *buf, size_t count) \
+{ \
+	u32 tmp = simple_strtoul(buf, NULL, 10); \
+	acpi_status status = set_state(&tmp, instance); \
+		if (ACPI_FAILURE(status)) \
+			return -EINVAL; \
+	return count; \
+} \
+static DEVICE_ATTR(value, S_IWUGO | S_IRUGO | S_IWUSR, \
+	show_bool_##value, set_bool_##value);
+
+show_set_bool(wireless, TC1100_INSTANCE_WIRELESS);
+show_set_bool(bluetooth, TC1100_INSTANCE_BLUETOOTH);
+
+static void remove_fs(void)
+{
+	device_remove_file(&tc1100_device->dev, &dev_attr_wireless);
+	device_remove_file(&tc1100_device->dev, &dev_attr_bluetooth);
+}
+
+static int add_fs(void)
+{
+	int ret;
+
+	ret = device_create_file(&tc1100_device->dev, &dev_attr_wireless);
+	if (ret)
+		goto add_sysfs_error;
+
+	ret = device_create_file(&tc1100_device->dev, &dev_attr_bluetooth);
+	if (ret)
+		goto add_sysfs_error;
+
+	return ret;
+
+add_sysfs_error:
+	remove_fs();
+	return ret;
+}
+
+/* --------------------------------------------------------------------------
+				Driver Model
+   -------------------------------------------------------------------------- */
+
+static int tc1100_probe(struct platform_device *device)
+{
+	int result = 0;
+
+	result = add_fs();
+	return result;
+}
+
+
+static int tc1100_remove(struct platform_device *device)
+{
+	remove_fs();
+	return 0;
+}
+
+static int tc1100_suspend(struct platform_device *dev, pm_message_t state)
+{
+	int ret;
+
+	ret = get_state(&suspend_data.wireless, TC1100_INSTANCE_WIRELESS);
+	if (ret)
+		return ret;
+
+	ret = get_state(&suspend_data.bluetooth, TC1100_INSTANCE_BLUETOOTH);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int tc1100_resume(struct platform_device *dev)
+{
+	int ret;
+
+	ret = set_state(&suspend_data.wireless, TC1100_INSTANCE_WIRELESS);
+	if (ret)
+		return ret;
+
+	ret = set_state(&suspend_data.bluetooth, TC1100_INSTANCE_BLUETOOTH);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int __init tc1100_init(void)
+{
+	int result = 0;
+
+	if (!wmi_has_guid(GUID))
+		return -ENODEV;
+
+	result = platform_driver_register(&tc1100_driver);
+	if (result)
+		return result;
+
+	tc1100_device = platform_device_alloc("tc1100-wmi", -1);
+	platform_device_add(tc1100_device);
+
+	printk(TC1100_INFO "HP Compaq TC1100 Tablet WMI Extras loaded\n");
+
+	return result;
+}
+
+static void __exit tc1100_exit(void)
+{
+	platform_device_del(tc1100_device);
+	platform_driver_unregister(&tc1100_driver);
+
+	printk(TC1100_INFO "HP Compaq TC1100 Tablet WMI Extras unloaded\n");
+}
+
+module_init(tc1100_init);
+module_exit(tc1100_exit);
-- 
1.5.3.4

