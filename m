From: =?ISO-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Subject: Re: [PATCH] ACPI: Platform driver to support App Hot Startup
 (PNP0C32)
Date: Mon, 1 Sep 2008 00:38:56 +0200
Message-ID: <20080901003856.2d855880.miknix@gmail.com>
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
	<20080828134055.GA27158@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:59389 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757926AbYHaVjE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 31 Aug 2008 17:39:04 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1005667yxm.1
        for <linux-acpi@vger.kernel.org>; Sun, 31 Aug 2008 14:39:03 -0700 (PDT)
In-Reply-To: <20080828134055.GA27158@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: andi@firstfloor.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, linux-acpi@vger.kernel.org

On Thu, 28 Aug 2008 14:40:55 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Thu, Aug 28, 2008 at 02:37:08PM +0200, =C2ngelo Miguel Arrifano wr=
ote:
>=20
> > +/* There will be two events:
> > +	 * 0x02 - A hot button was pressed while device was off/sleeping.
> > +	 * 0x08 - A hot button was pressed while device was up. */
>=20
> Are you sure? The spec seems to say 0x80, not 0x08.
>=20
> > +#define QUICKSTART_EVENT_RUNTIME      0x80
>=20
> As you have here :)
>=20
> Could you add an input device for runtime button notification? Use th=
e=20
> GHID value as a scancode, then provide functions to do scancode->keyc=
ode=20
> mappings (see wistron_btns.c or hp_wmi.c for examples of this). That=20
> way, hal or whatever can be used to map them to machine-specific valu=
es.
>=20
> --=20
> Matthew Garrett | mjg59@srcf.ucam.org

Patch below includes proposed changes for runtime button notification.
I could not fully test it since my laptop doesn't report runtime key pr=
esses.

NOTE: There are some inline comments in the patch below.

-- Thanks, Angelo Arrifano

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index c52fca8..ed48a56 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -199,6 +199,14 @@ config ACPI_THERMAL
 	  recommended that this option be enabled, as your processor(s)
 	  may be damaged without it.
=20
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
@@ -62,3 +62,4 @@ obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+=3D acpi_memhotplu=
g.o
 obj-$(CONFIG_ACPI_PROCFS_POWER)	+=3D cm_sbs.o
 obj-$(CONFIG_ACPI_SBS)		+=3D sbshc.o
 obj-$(CONFIG_ACPI_SBS)		+=3D sbs.o
+obj-$(CONFIG_ACPI_QUICKSTART)	+=3D quickstart.o
diff --git a/drivers/acpi/quickstart.c b/drivers/acpi/quickstart.c
new file mode 100644
index 0000000..1e6d928
--- /dev/null
+++ b/drivers/acpi/quickstart.c
@@ -0,0 +1,474 @@
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
+ *  This program is free software; you can redistribute it and/or modi=
fy
+ *  it under the terms of the GNU General Public License as published =
by
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
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-13=
07  USA
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
+#include <linux/input.h>
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
+	 * 0x80 - A hot button was pressed while device was up. */
+#define QUICKSTART_EVENT_WAKE         0x02
+#define QUICKSTART_EVENT_RUNTIME      0x80
+
+struct quickstart_btn {
+	char *name;
+	unsigned int id;
+	struct quickstart_btn *next;
+};
+
+static struct quickstart_driver_data {
+	struct quickstart_btn *btn_lst;
+	struct quickstart_btn *pressed;
+} quickstart_data;
+
+/* ACPI driver Structs */
+struct quickstart_acpi {
+	struct acpi_device *device;
+	struct quickstart_btn *btn;
+};
+static int quickstart_acpi_add(struct acpi_device *device);
+static int quickstart_acpi_remove(struct acpi_device *device, int type=
);
+static const struct acpi_device_id  quickstart_device_ids[] =3D {
+	{QUICKSTART_ACPI_HID, 0},
+	{"", 0},
+};
+
+static struct acpi_driver quickstart_acpi_driver =3D {
+	.name =3D "quickstart",
+	.class =3D QUICKSTART_ACPI_CLASS,
+	.ids =3D quickstart_device_ids,
+	.ops =3D {
+			.add =3D quickstart_acpi_add,
+			.remove =3D quickstart_acpi_remove,
+		},
+};
+
+/* Input device structs */
+struct input_dev *quickstart_input;
+
+/* Platform driver structs */
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
+static struct platform_driver pf_driver =3D {
+	.driver =3D {
+		.name =3D QUICKSTART_PF_DRIVER_NAME,
+		.owner =3D THIS_MODULE,
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
+	int count =3D 0;
+	struct quickstart_btn *ptr =3D quickstart_data.btn_lst;
+
+	if (!ptr)
+		return snprintf(buf, PAGE_SIZE, "none");
+
+	while (ptr && (count < PAGE_SIZE)) {
+		if (ptr->name) {
+			count +=3D snprintf(buf + count,
+					PAGE_SIZE - count,
+					"%d\t%s\n", ptr->id, ptr->name);

Added the button usage ID to the button list.
The button usage ID is returned by the GHID method.
Ex:

cat /sys/ . . . /buttons
1	QBTN
2	DBTN
3	MUBN
6	PIBN
4	WEBN
8	LVBN
7	VOBN

+		}
+		ptr =3D ptr->next;
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
+	if (strncasecmp(buf, "none", 4) !=3D 0)
+		return -EINVAL;
+
+	quickstart_data.pressed =3D NULL;
+	return count;
+}
+
+/* Hotstart Helper functions */
+static int quickstart_btnlst_add(struct quickstart_btn **data)
+{
+	struct quickstart_btn **ptr =3D &quickstart_data.btn_lst;
+
+	while (*ptr)
+		ptr =3D &((*ptr)->next);
+
+	*ptr =3D kzalloc(sizeof(struct quickstart_btn), GFP_KERNEL);
+	if (!*ptr) {
+		*data =3D NULL;
+		return -ENOMEM;
+	}
+	*data =3D *ptr;
+
+	return 0;
+}
+
+static void quickstart_btnlst_del(struct quickstart_btn *data)
+{
+	struct quickstart_btn **ptr =3D &quickstart_data.btn_lst;
+
+	if (!data)
+		return;
+
+	while (*ptr) {
+		if (*ptr =3D=3D data) {
+			*ptr =3D (*ptr)->next;
+			kfree(data);
+			return;
+		}
+		ptr =3D &((*ptr)->next);
+	}
+
+	return;
+}
+
+static void quickstart_btnlst_free(void)
+{
+	struct quickstart_btn *ptr =3D quickstart_data.btn_lst;
+	struct quickstart_btn *lptr =3D NULL;
+
+	while (ptr) {
+		lptr =3D ptr;
+		ptr =3D ptr->next;
+		kfree(lptr->name);
+		kfree(lptr);
+	}
+
+	return;
+}
+
+/* ACPI Driver functions */
+static void quickstart_acpi_notify(acpi_handle handle, u32 event, void=
 *data)
+{
+	struct quickstart_acpi *quickstart =3D data;
+
+	if (!quickstart)
+		return;
+
+	if (event =3D=3D QUICKSTART_EVENT_WAKE)
+		quickstart_data.pressed =3D quickstart->btn;
+	else if (event =3D=3D QUICKSTART_EVENT_RUNTIME) {
+		input_report_key(quickstart_input, quickstart->btn->id, 1);
+		input_sync(quickstart_input);
+		input_report_key(quickstart_input, quickstart->btn->id, 0);
+		input_sync(quickstart_input);

The button usage ID is used as key code.

+	}
+	return;
+}
+
+static void quickstart_acpi_ghid(struct quickstart_acpi *quickstart)
+{
+	acpi_status status;
+	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	unsigned int usageid =3D 0;
+
+	if (!quickstart)
+		return;
+
+	/* This returns a buffer telling the button usage ID,
+	 * and triggers pending notify events (The ones before booting). */
+	status =3D acpi_evaluate_object(quickstart->device->handle,
+					"GHID", NULL, &buffer);
+	if (ACPI_FAILURE(status) || !buffer.pointer) {
+		printk(KERN_ERR "quickstart: %s GHID method failed.\n",
+		       quickstart->btn->name);
+		return;
+	}

This _GHID method can return a BYTE, WORD or DWORD. I guess each vendor=
 chooses which they like most.
On my laptop, the returned buffer.length is 32.=20

Buffer dump:
QBTN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 00 00=
 00 00 01 00 00 00 00 00 00 00
DBTN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 00 00=
 00 00 02 00 00 00 00 00 00 00
MUBN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 00 00=
 00 00 03 00 00 00 00 00 00 00
PIBN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 00 00=
 00 00 06 00 00 00 00 00 00 00
WEBN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 00 00=
 00 00 04 00 00 00 00 00 00 00
LVBN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 00 00=
 00 00 08 00 00 00 00 00 00 00
VOBN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 00 00=
 00 00 07 00 00 00 00 00 00 00
                                                                       =
       +---------------------+
Does it return a QWORD?? Why is it at the end of the buffer?

+
+	if (buffer.length < 8)
+		return;
+
+	/* <<The GHID method can return a BYTE, WORD, or DWORD.
+	 * The value must be encoded in little-endian byte
+	 * order (least significant byte first).>> */
+	ACPI_MOVE_32_TO_32(&usageid, buffer.pointer + (buffer.length - 8));
+	quickstart->btn->id =3D usageid;

I need your help in here, I doubt this code runs for anyone but me.

+
+	kfree(buffer.pointer);
+}
+
+static int quickstart_acpi_config(struct quickstart_acpi *quickstart, =
char *bid)
+{
+	int len =3D strlen(bid);
+	int ret;
+
+	/* Add button to list */
+	ret =3D quickstart_btnlst_add(&quickstart->btn);
+	if (ret)
+		return ret;
+
+	quickstart->btn->name =3D kzalloc(len + 1, GFP_KERNEL);
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
+	int ret =3D 0;
+	acpi_status status =3D AE_OK;
+	struct quickstart_acpi *quickstart =3D NULL;
+
+	if (!device)
+		return -EINVAL;
+
+	quickstart =3D kzalloc(sizeof(struct quickstart_acpi), GFP_KERNEL);
+	if (!quickstart)
+		return -ENOMEM;
+
+	quickstart->device =3D device;
+	strcpy(acpi_device_name(device), QUICKSTART_ACPI_DEVICE_NAME);
+	strcpy(acpi_device_class(device), QUICKSTART_ACPI_CLASS);
+	acpi_driver_data(device) =3D quickstart;
+
+	/* Add button to list and initialize some stuff */
+	ret =3D quickstart_acpi_config(quickstart, acpi_device_bid(device));
+	if (ret)
+		goto fail_config;
+
+	status =3D acpi_install_notify_handler(device->handle,
+						ACPI_ALL_NOTIFY,
+						quickstart_acpi_notify,
+						quickstart);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR "quickstart: Notify handler install error\n");
+		ret =3D -ENODEV;
+		goto fail_installnotify;
+	}
+
+	quickstart_acpi_ghid(quickstart);
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
+static int quickstart_acpi_remove(struct acpi_device *device, int type=
)
+{
+	acpi_status status =3D 0;
+	struct quickstart_acpi *quickstart =3D NULL;
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
+	quickstart =3D acpi_driver_data(device);
+
+	status =3D acpi_remove_notify_handler(device->handle,
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
+	input_unregister_device(quickstart_input);
+	input_free_device(quickstart_input);
+
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
+static int __init quickstart_init_input(void)
+{
+	struct quickstart_btn **ptr =3D &quickstart_data.btn_lst;
+	int count;
+
+	quickstart_input =3D input_allocate_device();
+
+	if (!quickstart_input)
+		return -ENOMEM;
+
+	quickstart_input->name =3D "Quickstart ACPI Buttons";
+	quickstart_input->id.bustype =3D BUS_HOST;
+
+	while (*ptr) {
+		count++;
+		set_bit(EV_KEY, quickstart_input->evbit);
+		set_bit((*ptr)->id, quickstart_input->keybit);
+		ptr =3D &((*ptr)->next);
+	}
+
+	return input_register_device(quickstart_input);
+}
+
+static int __init quickstart_init(void)
+{
+	int ret;
+	acpi_status status =3D 0;
+
+	/* ACPI Check */
+	if (acpi_disabled)
+		return -ENODEV;
+
+	/* ACPI driver register */
+	status =3D acpi_bus_register_driver(&quickstart_acpi_driver);
+	if (status < 0)
+		return -ENODEV;
+
+	/* If existing bus with no devices */
+	if (!quickstart_data.btn_lst) {
+		ret =3D -ENODEV;
+		goto fail_pfdrv_reg;
+	}
+
+	/* Platform driver register */
+	ret =3D platform_driver_register(&pf_driver);
+	if (ret)
+		goto fail_pfdrv_reg;
+
+	/* Platform device register */
+	pf_device =3D platform_device_alloc(QUICKSTART_PF_DEVICE_NAME, -1);
+	if (!pf_device) {
+		ret =3D -ENOMEM;
+		goto fail_pfdev_alloc;
+	}
+	ret =3D platform_device_register(pf_device);
+	if (ret)
+		goto fail_pfdev_reg;
+
+	/* Create device sysfs file */
+	ret =3D device_create_file(&pf_device->dev, &dev_attr_pressed_button)=
;
+	if (ret)
+		goto fail_dev_file;
+
+	ret =3D device_create_file(&pf_device->dev, &dev_attr_buttons);
+	if (ret)
+		goto fail_dev_file2;
+
+
+	/* Input device */
+	ret =3D quickstart_init_input();
+	if (ret)
+		goto fail_input;
+
+	printk(KERN_INFO "quickstart: ACPI Direct App Launch ver %s\n",
+						QUICKSTART_VERSION);
+
+	return 0;
+fail_input:
+	device_remove_file(&pf_device->dev, &dev_attr_buttons);
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
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
