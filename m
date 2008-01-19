From: =?ISO-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Subject: Re: *NEW* ACPI driver to support App Hot Startup AKA PNP0C32 -
 please apply
Date: Sat, 19 Jan 2008 15:19:29 +0000
Message-ID: <20080119151929.1674103b.miknix@gmail.com>
References: <20071110014448.471e384b.miknix@gmail.com>
	<200711100321.22500.carlos@strangeworlds.co.uk>
	<20071112000534.e0489eca.miknix@gmail.com>
	<200711120002.24474.carlos@strangeworlds.co.uk>
	<20071123152446.144ac193.miknix@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__19_Jan_2008_15_19_29_+0000_6adFSu54V0zGxsjd"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:10046 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758585AbYASPPG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jan 2008 10:15:06 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1340201fga.17
        for <linux-acpi@vger.kernel.org>; Sat, 19 Jan 2008 07:15:05 -0800 (PST)
In-Reply-To: <20071123152446.144ac193.miknix@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org


--Multipart=_Sat__19_Jan_2008_15_19_29_+0000_6adFSu54V0zGxsjd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 23 Nov 2007 15:24:46 +0000
Ângelo Miguel Arrifano <miknix@gmail.com> wrote:

> Hello all,
> 
> I opened a SF.net project to support devices found under PNP0C32.
> These devices are known as Direct App Launch Buttons and are used on Vista Hotstart(TM) technology.
> I believe most of Vista "ready" laptops have this.
> 
> The project aims to provide similar functionality to Vista Hotstart(TM) in linux.
> You can read more at http://quickstart.sourceforge.net/
> 
> Greetings,
> -- 
> Angelo Arrifano AKA MiKNiX
> CSE Student at UBI, Portugal
> Gentoo Linux AMD64 Arch Tester
> miknix@gmail.com
> http://miknix.homelinux.com
> PGP Pubkey online
> 
> - -
> 
> Q: How many Chuck Norris' does it take to change a light bulb?
> A: None, Chuck Norris prefers to kill in the dark. 

The project is running for some time now. During this time there
were no reports of people getting it trouble with it.

Attached is the patch.

Thanks,
- -- 
Angelo Arrifano AKA MiKNiX
CSE Student at UBI, Portugal
Gentoo Linux AMD64 Arch Tester
Linwizard Developer
miknix@gmail.com
http://miknix.homelinux.com
PGP Pubkey 0x3D92BB0B
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFHkhUBNahyoD2SuwsRAn8gAJ4yj/kQl3RyAbBw3s9/2R04rEjFbQCfc1fC
/HlHqqB8B9my/vP67QMWrBM=
=nVRr
-----END PGP SIGNATURE-----

--Multipart=_Sat__19_Jan_2008_15_19_29_+0000_6adFSu54V0zGxsjd
Content-Type: text/x-patch;
 name="quickstart-20080119.diff"
Content-Disposition: attachment;
 filename="quickstart-20080119.diff"
Content-Transfer-Encoding: 7bit

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 95588c2..4b80085 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -195,6 +195,14 @@ config ACPI_THERMAL
 	  recommended that this option be enabled, as your processor(s)
 	  may be damaged without it.
 
+config ACPI_QUICKSTART
+	tristate "Quickstart"
+	default y
+	help
+	  This driver add support for ACPI Direct Application Launch
+	  also known as Hotstart(TM). Say yes here to have a entry in
+	  sysfs telling which button was used to turn on the system.
+
 config ACPI_NUMA
 	bool "NUMA support"
 	depends on NUMA
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 456446f..719506a 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
 obj-$(CONFIG_ACPI_PROCFS_POWER)	+= cm_sbs.o
 obj-$(CONFIG_ACPI_SBS)		+= sbs.o
 obj-$(CONFIG_ACPI_SBS)		+= sbshc.o
+obj-$(CONFIG_ACPI_QUICKSTART)	+= quickstart.o
diff --git a/drivers/acpi/quickstart.c b/drivers/acpi/quickstart.c
new file mode 100644
index 0000000..2f4707b
--- /dev/null
+++ b/drivers/acpi/quickstart.c
@@ -0,0 +1,418 @@
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
+#define QUICKSTART_VERSION	"0.04"
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
+static int enable_runtime_btns;
+module_param(enable_runtime_btns, int, 0);
+MODULE_PARM_DESC(enable_runtime_btns,
+			"Enable reporting of runtime button presses (hotkeys).\n");
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
+struct quickstart_btn_list {
+	char *name;
+	struct quickstart_btn_list *next;
+};
+
+static struct quickstart_driver_data {
+	struct quickstart_btn_list *btn_lst;
+	struct quickstart_btn_list *pressed;
+} quickstart_data = {
+	.btn_lst = NULL,
+	.pressed = NULL,
+};
+
+/*
+ * ACPI driver Structs
+ */
+
+struct quickstart_acpi {
+	struct acpi_device *device;
+	struct quickstart_btn_list *btn;
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
+	char tmpbuf[QUICKSTART_MAX_BTN_NAME_LEN + 2];
+	struct quickstart_btn_list *ptr = quickstart_data.btn_lst;
+	
+	if(!ptr)
+		return snprintf(buf, PAGE_SIZE, "none");
+
+	while(ptr && (count < PAGE_SIZE)){
+		if(ptr->name){
+			strncpy(tmpbuf, ptr->name, QUICKSTART_MAX_BTN_NAME_LEN);
+			strcat(tmpbuf, "\n");
+			count += snprintf(buf + count,
+					PAGE_SIZE - count,
+					tmpbuf);
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
+	if(count < 2)
+		return -EINVAL;
+
+	if(strncasecmp(buf, "none", 4) != 0)
+		return -EINVAL;
+
+	quickstart_data.pressed = NULL;
+	return count;
+}
+
+/* Hotstart Helper functions */
+static int quickstart_btnlst_add(struct quickstart_btn_list **data)
+{
+	struct quickstart_btn_list **ptr = &quickstart_data.btn_lst;
+	
+	while(*ptr)
+		ptr = &((*ptr)->next);
+		
+	*ptr = kzalloc(sizeof(struct quickstart_btn_list), GFP_KERNEL);
+	if(!*ptr){
+		*data = NULL;
+		return(-ENOMEM);
+	}
+	*data = *ptr;
+
+	return 0;
+}
+
+static void quickstart_btnlst_free(void)
+{
+	struct quickstart_btn_list *ptr = quickstart_data.btn_lst;
+	struct quickstart_btn_list *lptr = NULL;
+	
+	if(!ptr)
+		return;
+
+	while(ptr){
+		lptr = ptr;
+		ptr = ptr->next;
+		if(lptr->name)
+			kfree(lptr->name);
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
+	/* There will be two events:
+	 * 0x02 - A quickstart button was pressed while device was off/sleeping.
+	 * 0x08 - A quickstart button was pressed while device was up. */
+	if((event|0x02) == event){
+		quickstart_data.pressed = quickstart->btn;
+		printk("quickstart: Quickbutton %s pressed.\n",
+					acpi_device_bid(quickstart->device));
+	}
+
+	if(enable_runtime_btns && (event|0x08) == event){
+		printk("quickstart: Hotkey %s pressed.\n",
+					acpi_device_bid(quickstart->device));
+	}
+	
+	return;
+}
+
+static void quickstart_acpi_raise_notify(struct quickstart_acpi *quickstart)
+{
+	acpi_status status;
+
+	/* TODO:
+	 * We should receive a buffer telling the kind of button,
+	 * eg: dvd, printer, www, ... 
+	 * but we dont care about it now. The important is to trigger
+	 * pending notify events (The ones before booting). */
+	status = acpi_evaluate_object(quickstart->device->handle,
+					"GHID", NULL, NULL);
+	if(ACPI_FAILURE(status))
+		printk("quickstart: Warning: GHID method failed, events of pressed buttons may have been lost.\n");
+
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
+	if(ret)
+		return ret;
+	
+	quickstart->btn->name = kzalloc(len + 1, GFP_KERNEL);
+	if(!quickstart->btn->name){
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
+	if(ret)
+		goto fail_config;
+
+	status = acpi_install_notify_handler(device->handle,
+						 ACPI_ALL_NOTIFY,
+						 quickstart_acpi_notify, quickstart);
+	if(ACPI_FAILURE(status)){
+		printk("quickstart: Error installing notify handler\n");
+		ret = -ENODEV;
+		goto fail_installnotify;
+	}	
+
+	/* Call device GHID method. This is a workaround to get a notify
+	 * event when hot button is pressed while laptop is powered off.
+	 * This works, even if the method fails. */
+	quickstart_acpi_raise_notify(quickstart);
+
+	return 0;
+
+fail_installnotify:
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
+		printk("quickstart: Error removing notify handler\n");
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
+	if(acpi_disabled)
+		return -ENODEV;
+
+	/* ACPI driver register */
+	status = acpi_bus_register_driver(&quickstart_acpi_driver);
+	if (status < 0)
+		return -ENODEV;
+
+	/* Platform driver register */
+	ret = platform_driver_register(&pf_driver);
+	if(ret)
+		goto fail_pfdrv_reg;
+
+	/* Platform device register */
+	pf_device = platform_device_alloc(QUICKSTART_PF_DEVICE_NAME, -1);
+	if(!pf_device){
+		ret = -ENOMEM;
+		goto fail_pfdev_alloc;
+	}
+
+	ret = platform_device_register(pf_device);
+	if(ret)
+		goto fail_pfdev_reg;
+
+	/* Create device sysfs file */
+	ret = device_create_file(&pf_device->dev, &dev_attr_pressed_button);
+	if(ret)
+		goto fail_dev_file;
+
+	ret = device_create_file(&pf_device->dev, &dev_attr_buttons);
+	if(ret)
+		goto fail_dev_file2;
+
+	printk("quickstart: ACPI Hotstart button %s\n", QUICKSTART_VERSION);
+	if(enable_runtime_btns)
+		printk("quickstart: Runtime button reporting is enabled.");
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

--Multipart=_Sat__19_Jan_2008_15_19_29_+0000_6adFSu54V0zGxsjd--
