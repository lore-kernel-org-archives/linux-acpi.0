From: =?ISO-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Subject: Re: [PATCH] ACPI: Platform driver to support App Hot Startup
 (PNP0C32)
Date: Thu, 28 Aug 2008 15:47:45 +0200
Message-ID: <20080828154745.0ccf261b.miknix@gmail.com>
References: <1206428373.3047.34.camel@acpi-hp-zz.sh.intel.com>
	<20080326175139.d59ff46d.miknix@gmail.com>
	<1206585013.8282.17.camel@sli10-desk.sh.intel.com>
	<20080327160346.424052fe.miknix@gmail.com>
	<1206668215.12574.8.camel@sli10-desk.sh.intel.com>
	<20080328193919.fb23bcc8.miknix@gmail.com>
	<20080824183924.daf28d3b.miknix@gmail.com>
	<1219627740.24775.12.camel@rzhang-dt>
	<878wujsjku.fsf@basil.nowhere.org>
	<20080828143708.25815142.miknix@gmail.com>
	<20080828130804.GO26610@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:8864 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbYH1N7Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Aug 2008 09:59:16 -0400
Received: by ey-out-2122.google.com with SMTP id 6so114452eyi.37
        for <linux-acpi@vger.kernel.org>; Thu, 28 Aug 2008 06:59:15 -0700 (PDT)
In-Reply-To: <20080828130804.GO26610@one.firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, linux-acpi@vger.kernel.org

On Thu, 28 Aug 2008 15:08:05 +0200
Andi Kleen <andi@firstfloor.org> wrote:

> > Ok thanks, here it is.
> 
> Please submit it with proper description and Signed-off-by lines.
> (see Documentation/SubmittingPatches)
> 
> -Andi

Description:
  With the introduction of Vista, Microsoft launched a new ACPI
?specification? to allow computers in sleep/off states to boot 
directly into multimedia applications by only pressing buttons.
  This driver provides support to these devices allowing userspace
scripts to launch multimedia applications based on which button
was used to turn on the system.

How it works:
  When the system boots, the driver receives an ACPI event telling
which button was used to power the system on. Then, the driver exports
this information to sysfs allowing userspace scripts to know the
button name. This also applies to memory suspend and other power
saving states.

Example:
* File buttons shows a list of supported hot buttons.
  $ cat /sys/devices/platform/quickstart/buttons
  QBTN
  DBTN
  MUBN
  PIBN
  WEBN
  LVBN
  VOBN

* File pressed_button shows the hot button name used to power/resume the system.
  You can also write "none" to it to reset.
  $ cat /sys/devices/platform/quickstart/pressed_button
  none

References:
* http://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/DirAppLaunch_Vista.doc

----------------------------------------

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index c52fca8..ed48a56 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -199,6 +199,14 @@ config ACPI_THERMAL
 	  recommended that this option be enabled, as your processor(s)
 	  may be damaged without it.
 
+config ACPI_QUICKSTART
+	tristate "Quickstart"
+	default m
+	help
+	  This driver add support for ACPI Direct Application Launch
+	  also known as Hotstart(TM). Say yes here to have a entry in
+	  sysfs telling which button was used to turn on the system.
+
 config ACPI_NUMA
 	bool "NUMA support"
 	depends on NUMA
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 40b0fca..df74d57 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -62,3 +62,4 @@ obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
 obj-$(CONFIG_ACPI_PROCFS_POWER)	+= cm_sbs.o
 obj-$(CONFIG_ACPI_SBS)		+= sbshc.o
 obj-$(CONFIG_ACPI_SBS)		+= sbs.o
+obj-$(CONFIG_ACPI_QUICKSTART)	+= quickstart.o
diff --git a/drivers/acpi/quickstart.c b/drivers/acpi/quickstart.c
new file mode 100644
index 0000000..b8ebb93
--- /dev/null
+++ b/drivers/acpi/quickstart.c
@@ -0,0 +1,427 @@
+/*
+ *  quickstart.c - ACPI Direct App Launch driver
+ *
+ *
+ *  Copyright (C) 2007 Angelo Arrifano <miknix@gmail.com>
+ *
+ *  Information gathered from disassebled dsdt and from here:
+ *  "http://download.microsoft.com/download/9/c/5/
+ *  9c5b2167-8017-4bae-9fde-d599bac8184a/DirAppLaunch_Vista.doc"
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#define QUICKSTART_VERSION "1.01"
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <acpi/acpi_drivers.h>
+#include <linux/platform_device.h>
+
+MODULE_AUTHOR("Angelo Arrifano");
+MODULE_DESCRIPTION("ACPI Direct App Launch driver");
+MODULE_LICENSE("GPL");
+
+#define QUICKSTART_ACPI_DEVICE_NAME   "quickstart"
+#define QUICKSTART_ACPI_CLASS         "quickstart"
+#define QUICKSTART_ACPI_HID           "PNP0C32"
+
+#define QUICKSTART_PF_DRIVER_NAME     "quickstart"
+#define QUICKSTART_PF_DEVICE_NAME     "quickstart"
+#define QUICKSTART_PF_DEVATTR_NAME    "pressed_button"
+
+#define QUICKSTART_MAX_BTN_NAME_LEN   16
+
+/* There will be two events:
+	 * 0x02 - A hot button was pressed while device was off/sleeping.
+	 * 0x08 - A hot button was pressed while device was up. */
+#define QUICKSTART_EVENT_WAKE         0x02
+#define QUICKSTART_EVENT_RUNTIME      0x80
+
+struct quickstart_btn {
+	char *name;
+	struct quickstart_btn *next;
+};
+
+static struct quickstart_driver_data {
+	struct quickstart_btn *btn_lst;
+	struct quickstart_btn *pressed;
+} quickstart_data;
+
+/*
+ * ACPI driver Structs
+ */
+
+struct quickstart_acpi {
+	struct acpi_device *device;
+	struct quickstart_btn *btn;
+};
+static int quickstart_acpi_add(struct acpi_device *device);
+static int quickstart_acpi_remove(struct acpi_device *device, int type);
+static const struct acpi_device_id  quickstart_device_ids[] = {
+	{QUICKSTART_ACPI_HID, 0},
+	{"", 0},
+};
+
+static struct acpi_driver quickstart_acpi_driver = {
+	.name = "quickstart",
+	.class = QUICKSTART_ACPI_CLASS,
+	.ids = quickstart_device_ids,
+	.ops = {
+			.add = quickstart_acpi_add,
+			.remove = quickstart_acpi_remove,
+		},
+};
+
+/*
+ * Platform driver structs
+ */
+static ssize_t buttons_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf);
+static ssize_t pressed_button_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf);
+static ssize_t pressed_button_store(struct device *dev,
+					struct device_attribute *attr,
+					 const char *buf,
+					 size_t count);
+static DEVICE_ATTR(pressed_button, 0666, pressed_button_show,
+					 pressed_button_store);
+static DEVICE_ATTR(buttons, 0444, buttons_show, NULL);
+static struct platform_device *pf_device;
+static struct platform_driver pf_driver = {
+	.driver = {
+		.name = QUICKSTART_PF_DRIVER_NAME,
+		.owner = THIS_MODULE,
+	}
+};
+
+/*
+ * Platform driver functions
+ */
+static ssize_t buttons_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	int count = 0;
+	struct quickstart_btn *ptr = quickstart_data.btn_lst;
+
+	if (!ptr)
+		return snprintf(buf, PAGE_SIZE, "none");
+
+	while (ptr && (count < PAGE_SIZE)) {
+		if (ptr->name) {
+			count += snprintf(buf + count,
+					PAGE_SIZE - count,
+					"%s\n", ptr->name);
+		}
+		ptr = ptr->next;
+	}
+
+	return count;
+}
+
+static ssize_t pressed_button_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+		(quickstart_data.pressed?quickstart_data.pressed->name:"none"));
+}
+
+
+static ssize_t pressed_button_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	if (count < 2)
+		return -EINVAL;
+
+	if (strncasecmp(buf, "none", 4) != 0)
+		return -EINVAL;
+
+	quickstart_data.pressed = NULL;
+	return count;
+}
+
+/* Hotstart Helper functions */
+static int quickstart_btnlst_add(struct quickstart_btn **data)
+{
+	struct quickstart_btn **ptr = &quickstart_data.btn_lst;
+
+	while (*ptr)
+		ptr = &((*ptr)->next);
+
+	*ptr = kzalloc(sizeof(struct quickstart_btn), GFP_KERNEL);
+	if (!*ptr) {
+		*data = NULL;
+		return(-ENOMEM);
+	}
+	*data = *ptr;
+
+	return 0;
+}
+
+static void quickstart_btnlst_del(struct quickstart_btn *data)
+{
+	struct quickstart_btn **ptr = &quickstart_data.btn_lst;
+
+	if (!data)
+		return;
+
+	while (*ptr) {
+		if (*ptr == data) {
+			*ptr = (*ptr)->next;
+			kfree(data);
+			return;
+		}
+		ptr = &((*ptr)->next);
+	}
+
+	return;
+}
+
+static void quickstart_btnlst_free(void)
+{
+	struct quickstart_btn *ptr = quickstart_data.btn_lst;
+	struct quickstart_btn *lptr = NULL;
+
+	while (ptr) {
+		lptr = ptr;
+		ptr = ptr->next;
+		kfree(lptr->name);
+		kfree(lptr);
+	}
+
+	return;
+}
+
+/* ACPI Driver functions */
+static void quickstart_acpi_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct quickstart_acpi *quickstart = data;
+
+	if (!quickstart)
+		return;
+
+	if (event == QUICKSTART_EVENT_WAKE)
+		quickstart_data.pressed = quickstart->btn;
+
+	return;
+}
+
+static void quickstart_acpi_raise_notify(struct quickstart_acpi *quickstart)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+
+	if (!quickstart)
+		return;
+
+	/* This returns a buffer telling the  button usage ID (useless),
+	 * we dont care about it now. The important is to trigger
+	 * pending notify events (The ones before booting). */
+	status = acpi_evaluate_object(quickstart->device->handle,
+					"GHID", NULL, &buffer);
+	if (ACPI_FAILURE(status) || !buffer.pointer) {
+		printk(KERN_ERR "quickstart: %s GHID method failed.\n",
+		       quickstart->btn->name);
+		return;
+	}
+
+	kfree(buffer.pointer);
+	return;
+}
+
+static int quickstart_acpi_config(struct quickstart_acpi *quickstart, char *bid)
+{
+	int len = strlen(bid);
+	int ret;
+
+	/* Add button to list */
+	ret = quickstart_btnlst_add(&quickstart->btn);
+	if (ret)
+		return ret;
+
+	quickstart->btn->name = kzalloc(len + 1, GFP_KERNEL);
+	if (!quickstart->btn->name) {
+		quickstart_btnlst_free();
+		return -ENOMEM;
+	}
+	strcpy(quickstart->btn->name, bid);
+
+	return 0;
+}
+
+static int quickstart_acpi_add(struct acpi_device *device)
+{
+	int ret = 0;
+	acpi_status status = AE_OK;
+	struct quickstart_acpi *quickstart = NULL;
+
+	if (!device)
+		return -EINVAL;
+
+	quickstart = kzalloc(sizeof(struct quickstart_acpi), GFP_KERNEL);
+	if (!quickstart)
+		return -ENOMEM;
+
+	quickstart->device = device;
+	strcpy(acpi_device_name(device), QUICKSTART_ACPI_DEVICE_NAME);
+	strcpy(acpi_device_class(device), QUICKSTART_ACPI_CLASS);
+	acpi_driver_data(device) = quickstart;
+
+	/* Add button to list and initialize some stuff */
+	ret = quickstart_acpi_config(quickstart, acpi_device_bid(device));
+	if (ret)
+		goto fail_config;
+
+	status = acpi_install_notify_handler(device->handle,
+						ACPI_ALL_NOTIFY,
+						quickstart_acpi_notify,
+						quickstart);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR "quickstart: Notify handler install error\n");
+		ret = -ENODEV;
+		goto fail_installnotify;
+	}
+
+	quickstart_acpi_raise_notify(quickstart);
+
+	return 0;
+
+fail_installnotify:
+	quickstart_btnlst_del(quickstart->btn);
+
+fail_config:
+
+	kfree(quickstart);
+
+	return ret;
+}
+
+static int quickstart_acpi_remove(struct acpi_device *device, int type)
+{
+	acpi_status status = 0;
+	struct quickstart_acpi *quickstart = NULL;
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
+	quickstart = acpi_driver_data(device);
+
+	status = acpi_remove_notify_handler(device->handle,
+						 ACPI_ALL_NOTIFY,
+					    quickstart_acpi_notify);
+	if (ACPI_FAILURE(status))
+		printk(KERN_ERR "quickstart: Error removing notify handler\n");
+
+
+	kfree(quickstart);
+
+	return 0;
+}
+
+/* Module functions */
+
+static void quickstart_exit(void)
+{
+	device_remove_file(&pf_device->dev, &dev_attr_pressed_button);
+	device_remove_file(&pf_device->dev, &dev_attr_buttons);
+
+	platform_device_unregister(pf_device);
+
+	platform_driver_unregister(&pf_driver);
+
+	acpi_bus_unregister_driver(&quickstart_acpi_driver);
+
+	quickstart_btnlst_free();
+
+	return;
+}
+
+static int __init quickstart_init(void)
+{
+	int ret;
+	acpi_status status = 0;
+
+	/* ACPI Check */
+	if (acpi_disabled)
+		return -ENODEV;
+
+	/* ACPI driver register */
+	status = acpi_bus_register_driver(&quickstart_acpi_driver);
+	if (status < 0)
+		return -ENODEV;
+
+	/* If existing bus with no devices */
+	if (!quickstart_data.btn_lst) {
+		ret = -ENODEV;
+		goto fail_pfdrv_reg;
+	}
+
+	/* Platform driver register */
+	ret = platform_driver_register(&pf_driver);
+	if (ret)
+		goto fail_pfdrv_reg;
+
+	/* Platform device register */
+	pf_device = platform_device_alloc(QUICKSTART_PF_DEVICE_NAME, -1);
+	if (!pf_device) {
+		ret = -ENOMEM;
+		goto fail_pfdev_alloc;
+	}
+	ret = platform_device_register(pf_device);
+	if (ret)
+		goto fail_pfdev_reg;
+
+	/* Create device sysfs file */
+	ret = device_create_file(&pf_device->dev, &dev_attr_pressed_button);
+	if (ret)
+		goto fail_dev_file;
+
+	ret = device_create_file(&pf_device->dev, &dev_attr_buttons);
+	if (ret)
+		goto fail_dev_file2;
+
+	printk(KERN_INFO "quickstart: ACPI Direct App Launch ver %s\n",
+						QUICKSTART_VERSION);
+
+	return 0;
+
+fail_dev_file2:
+	device_remove_file(&pf_device->dev, &dev_attr_pressed_button);
+
+fail_dev_file:
+	platform_device_del(pf_device);
+
+fail_pfdev_reg:
+	platform_device_put(pf_device);
+
+fail_pfdev_alloc:
+	platform_driver_unregister(&pf_driver);
+
+fail_pfdrv_reg:
+	acpi_bus_unregister_driver(&quickstart_acpi_driver);
+
+	return ret;
+}
+
+module_init(quickstart_init);
+module_exit(quickstart_exit);

Signed-off-by: Angelo Miguel Arrifano <miknix@gmail.com>
