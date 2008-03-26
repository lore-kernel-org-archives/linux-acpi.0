From: =?ISO-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Subject: Re: [PATCH] ACPI: Platform driver to support App Hot Startup
 (PNP0C32)
Date: Wed, 26 Mar 2008 17:51:39 +0000
Message-ID: <20080326175139.d59ff46d.miknix@gmail.com>
References: <20080314151712.34836918.miknix@gmail.com>
	<1206428373.3047.34.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:47658 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595AbYCZRim (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 13:38:42 -0400
Received: by ug-out-1314.google.com with SMTP id z38so136579ugc.16
        for <linux-acpi@vger.kernel.org>; Wed, 26 Mar 2008 10:38:40 -0700 (PDT)
In-Reply-To: <1206428373.3047.34.camel@acpi-hp-zz.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 25 Mar 2008 14:59:33 +0800
"Zhang, Rui" <rui.zhang@intel.com> wrote:

> Hi, Angelo,
>=20
> On Fri, 2008-03-14 at 23:17 +0800, =C2ngelo Miguel Arrifano wrote:
> > Here is the patch made from the today linux-acpi tree.
> >=20
> > Thanks,
> > Angelo Arrifano
> we'd better add the change log here.
> Some introductions about PNP0C32 device would be great.

Documentation (from README)
- -----------------------------------------------------------------
**********************************************************
* quickstart.c - ACPI Direct App Launch Driver for Linux *
*            Vista(TM) calls this Hotstart(TM)           *
*            http://quickstart.sourceforge.net           *
**********************************************************

WHAT IS IT?
  <<The Windows Vista(TM) operating system provides built-in support
  for a fast system startup experience that boots or resumes directly
  into media or other applications.
  This support, called direct application launch, is possible on PCs
  that are running Windows Vista by making simple changes to platform
  firmware and underlying platform wake circuitry.>>

* With the introduction of Vista Microsoft launched a new ACPI
  ?specification? to allow computers in sleep/off states to boot=20
  directly into multimedia applications by only pressing buttons.
* This driver provides support to these devices allowing userspace
  scripts to launch multimedia applications based on which button
  was pressed.

HOW IT WORKS:
* When the system boots, the driver receives an ACPI event telling
  which button was used to power the system on. Then, the driver export=
s
  this information to sysfs allowing userspace scripts to know the
  button name. This also applies to memory suspend and other power
  saving states.

EXAMPLE:
* File buttons shows a list of supported hot buttons.
  $ cat /sys/devices/platform/quickstart/buttons
  QBTN
  DBTN
  MUBN
  PIBN
  WEBN
  LVBN
  VOBN

* File pressed_button shows the hot button name used to power/resume th=
e system.
  You can also write "none" to it to reset.
  $ cat /sys/devices/platform/quickstart/pressed_button
  none

WHAT FOR?
* Mobile and Media Center Linux distributors could use this to enrich
  their linux experience.
* It's easy to make an alternate init script that checks if some button
  was pressed and launch the appropriate application without having to
  load the entire system.

REFERENCES
* http://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-=
d599bac8184a/DirAppLaunch_Vista.doc


CHANGELOG
- -----------------------------------------------------------------
* version 1.00-r1 2008/03/06
  - Fixed Makefile for linux-2.6.24

* version 1.00 2008/03/03
  - Little changes to support linux-2.6.23 and newer.
  - Added example autostart scripts.
  - Going stable, version bump.

* version 0.04 2007/11/17
  - Added reporting of runtime key presses (hotkeys) for testing.

* version 0.03 2007/11/13
  - Method GHID is now called under its device scope.
  - Code cleanup.

* version 0.02 2007/11/12
  - Project renamed to quickstart to prevent conflict with Microsoft
    trademark Hotstart(TM).
  - Removed procfs support since /proc/acpi will be removed from kernel=
 soon.
  - Added sysfs support.
  - Button states are now unified into a single attribute file which di=
splays
    the button name used to power the system on.
  - Added attribute file to show all suported buttons.
  - Code cleanups.

* version 0.01 2007/11/10
  - Detects button devices and creates proc entries to each device.
  - Proc entries can be written.
  - Workaround to raise device=20

PATCH
- -----------------------------------------------------------------
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f688c21..fb096ee 100644
- --- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -196,6 +196,14 @@ config ACPI_THERMAL
 	  recommended that this option be enabled, as your processor(s)
 	  may be damaged without it.
=20
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
index f29812a..badb0a6 100644
- --- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -62,3 +62,4 @@ obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+=3D acpi_memhotplu=
g.o
 obj-$(CONFIG_ACPI_PROCFS_POWER)	+=3D cm_sbs.o
 obj-$(CONFIG_ACPI_SBS)		+=3D sbs.o
 obj-$(CONFIG_ACPI_SBS)		+=3D sbshc.o
+obj-$(CONFIG_ACPI_QUICKSTART)	+=3D quickstart.o
diff --git a/drivers/acpi/quickstart.c b/drivers/acpi/quickstart.c
new file mode 100644
index 0000000..05c98f2
- --- /dev/null
+++ b/drivers/acpi/quickstart.c
@@ -0,0 +1,416 @@
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
+} quickstart_data =3D {
+	.btn_lst =3D NULL,
+	.pressed =3D NULL,
+};
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
+	char tmpbuf[QUICKSTART_MAX_BTN_NAME_LEN + 2];
+	struct quickstart_btn *ptr =3D quickstart_data.btn_lst;
+
+	if (!ptr)
+		return snprintf(buf, PAGE_SIZE, "none");
+
+	while (ptr && (count < PAGE_SIZE)) {
+		if (ptr->name) {
+			strncpy(tmpbuf, ptr->name, QUICKSTART_MAX_BTN_NAME_LEN);
+			strcat(tmpbuf, "\n");
+			count +=3D snprintf(buf + count,
+					PAGE_SIZE - count,
+					tmpbuf);
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
+		return(-ENOMEM);
+	}
+	*data =3D *ptr;
+
+	return 0;
+}
+
+static void quickstart_btnlst_free(void)
+{
+	struct quickstart_btn *ptr =3D quickstart_data.btn_lst;
+	struct quickstart_btn *lptr =3D NULL;
+
+	if (!ptr)
+		return;
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
+	if (event =3D=3D QUICKSTART_EVENT_WAKE) {
+		quickstart_data.pressed =3D quickstart->btn;
+		printk(KERN_ERR "quickstart: Quickbutton %s pressed.\n",
+					acpi_device_bid(quickstart->device));
+	} else if (event =3D=3D QUICKSTART_EVENT_RUNTIME) {
+		printk(KERN_ERR "quickstart: Runtime button %s pressed.\n\t"
+		       "please report on linux-acpi@vger.kernel.org",
+					acpi_device_bid(quickstart->device));
+	}
+
+	return;
+}
+
+static void quickstart_acpi_raise_notify(struct quickstart_acpi *quick=
start)
+{
+	acpi_status status;
+	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
+
+	if (!quickstart)
+		return;
+
+	/* This returns a buffer telling the  button usage ID (useless),
+	 * we dont care about it now. The important is to trigger
+	 * pending notify events (The ones before booting). */
+	status =3D acpi_evaluate_object(quickstart->device->handle,
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
+	acpi_status status =3D 0;
+
+	/* ACPI Check */
+	if (acpi_disabled)
+		return -ENODEV;
+
+	/* ACPI driver register */
+	status =3D acpi_bus_register_driver(&quickstart_acpi_driver);
+	if (!quickstart_data.btn_lst || status < 0)
+		return -ENODEV;
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
+	printk(KERN_ERR "quickstart: ACPI Direct App Launch ver %s\n",
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


>=20
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index f688c21..fb096ee 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -196,6 +196,14 @@ config ACPI_THERMAL
> >           recommended that this option be enabled, as your
> > processor(s)
> >           may be damaged without it.
> >=20
> > +config ACPI_QUICKSTART
> > +       tristate "Quickstart"
> > +       default y
> > +       help
> > +         This driver add support for ACPI Direct Application Launc=
h
> > +         also known as Hotstart(TM). Say yes here to have a entry =
in
> > +         sysfs telling which button was used to turn on the system=
=2E
> > +
> >  config ACPI_NUMA
> >         bool "NUMA support"
> >         depends on NUMA
> > diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> > index f29812a..badb0a6 100644
> > --- a/drivers/acpi/Makefile
> > +++ b/drivers/acpi/Makefile
> > @@ -62,3 +62,4 @@ obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)     +=3D
> > acpi_memhotplug.o
> >  obj-$(CONFIG_ACPI_PROCFS_POWER)        +=3D cm_sbs.o
> >  obj-$(CONFIG_ACPI_SBS)         +=3D sbs.o
> >  obj-$(CONFIG_ACPI_SBS)         +=3D sbshc.o
> > +obj-$(CONFIG_ACPI_QUICKSTART)  +=3D quickstart.o
> > diff --git a/drivers/acpi/quickstart.c b/drivers/acpi/quickstart.c
> > new file mode 100644
> > index 0000000..a4726f8
> > --- /dev/null
> > +++ b/drivers/acpi/quickstart.c
> > @@ -0,0 +1,418 @@
> > +/*
> > + *  quickstart.c - ACPI Direct App Launch driver
> > + *
> > + *
> > + *  Copyright (C) 2007 Angelo Arrifano <miknix@gmail.com>
> > + *
> > + *  Information gathered from disassebled dsdt and from here:
> > + *  "http://download.microsoft.com/download/9/c/5/
> > + *  9c5b2167-8017-4bae-9fde-d599bac8184a/DirAppLaunch_Vista.doc"
> > + *
> > + *  This program is free software; you can redistribute it and/or
> > modify
> > + *  it under the terms of the GNU General Public License as publis=
hed
> > by
> > + *  the Free Software Foundation; either version 2 of the License,=
 or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful=
,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public Lice=
nse
> > + *  along with this program; if not, write to the Free Software
> > + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
> > 02111-1307  USA
> > + *
> > + */
> > +
> > +#define QUICKSTART_VERSION "1.00"
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/types.h>
> > +#include <acpi/acpi_drivers.h>
> > +#include <linux/platform_device.h>
> > +
> > +MODULE_AUTHOR("Angelo Arrifano");
> > +MODULE_DESCRIPTION("ACPI Direct App Launch driver");
> > +MODULE_LICENSE("GPL");
> > +
> > +static int enable_runtime_btns;
> > +module_param(enable_runtime_btns, int, 0);
> > +MODULE_PARM_DESC(enable_runtime_btns,
> > +                       "Enable reporting of runtime button presses
> > (hotkeys).\n");
> "enable_runtime_btns" is useless in this patch.
=46IXED on the patch above
>=20
> > +
> > +#define QUICKSTART_ACPI_DEVICE_NAME   "quickstart"
> > +#define QUICKSTART_ACPI_CLASS         "quickstart"
> > +#define QUICKSTART_ACPI_HID           "PNP0C32"
> > +
> > +#define QUICKSTART_PF_DRIVER_NAME     "quickstart"
> > +#define QUICKSTART_PF_DEVICE_NAME     "quickstart"
> > +#define QUICKSTART_PF_DEVATTR_NAME    "pressed_button"
> > +
> > +#define QUICKSTART_MAX_BTN_NAME_LEN   16
> > +
> > +struct quickstart_btn_list {
> > +       char *name;
> > +       struct quickstart_btn_list *next;
> > +};
> > +
> > +static struct quickstart_driver_data {
> > +       struct quickstart_btn_list *btn_lst;
> > +       struct quickstart_btn_list *pressed;
> > +} quickstart_data =3D {
> > +       .btn_lst =3D NULL,
> > +       .pressed =3D NULL,
> > +};
> > +
> > +/*
> > + * ACPI driver Structs
> > + */
> > +
> > +struct quickstart_acpi {
> > +       struct acpi_device *device;
> > +       struct quickstart_btn_list *btn;
> > +};
> > +static int quickstart_acpi_add(struct acpi_device *device);
> > +static int quickstart_acpi_remove(struct acpi_device *device, int
> > type);
> > +static const struct acpi_device_id  quickstart_device_ids[] =3D {
> > +       {QUICKSTART_ACPI_HID, 0},
> > +       {"", 0},
> > +};
> > +
> > +static struct acpi_driver quickstart_acpi_driver =3D {
> > +       .name =3D "quickstart",
> > +       .class =3D QUICKSTART_ACPI_CLASS,
> > +       .ids =3D quickstart_device_ids,
> > +       .ops =3D {
> > +                       .add =3D quickstart_acpi_add,
> > +                       .remove =3D quickstart_acpi_remove,
> > +               },
> > +};
> > +
> > +/*
> > + * Platform driver structs
> > + */
> > +static ssize_t buttons_show(struct device *dev,
> > +                                       struct device_attribute *at=
tr,
> > +                                       char *buf);
> > +static ssize_t pressed_button_show(struct device *dev,
> > +                                       struct device_attribute *at=
tr,
> > +                                       char *buf);
> > +static ssize_t pressed_button_store(struct device *dev,
> > +                                       struct device_attribute *at=
tr,
> > +                                        const char *buf,
> > +                                        size_t count);
> > +static DEVICE_ATTR(pressed_button, 0666, pressed_button_show,
> > +                                        pressed_button_store);
> > +static DEVICE_ATTR(buttons, 0444, buttons_show, NULL);
> > +static struct platform_device *pf_device;
> > +static struct platform_driver pf_driver =3D {
> > +       .driver =3D {
> > +               .name =3D QUICKSTART_PF_DRIVER_NAME,
> > +               .owner =3D THIS_MODULE,
> > +       }
> > +};
> > +
> > +/*
> > + * Platform driver functions
> > + */
> > +static ssize_t buttons_show(struct device *dev,
> > +                                        struct device_attribute
> > *attr,
> > +                                        char *buf)
> > +{
> > +       int count =3D 0;
> > +       char tmpbuf[QUICKSTART_MAX_BTN_NAME_LEN + 2];
> > +       struct quickstart_btn_list *ptr =3D quickstart_data.btn_lst=
;
> > +     =20
> > +       if(!ptr)
> > +               return snprintf(buf, PAGE_SIZE, "none");
> > +
> > +       while(ptr && (count < PAGE_SIZE)){
> > +               if(ptr->name){
> > +                       strncpy(tmpbuf, ptr->name,
> > QUICKSTART_MAX_BTN_NAME_LEN);
> > +                       strcat(tmpbuf, "\n");
> > +                       count +=3D snprintf(buf + count,
> > +                                       PAGE_SIZE - count,
> > +                                       tmpbuf);
> > +               }
> > +               ptr =3D ptr->next;
> > +       }
> > +     =20
> > +       return count;
> > +}
> > +
> > +static ssize_t pressed_button_show(struct device *dev,
> > +                                       struct device_attribute *at=
tr,
> > +                                       char *buf)
> > +{
> > +       return snprintf(buf, PAGE_SIZE, "%s\n",
> > +
> > (quickstart_data.pressed?quickstart_data.pressed->name:"none"));
> > +}
> > +
> > +
> > +static ssize_t pressed_button_store(struct device *dev,
> > +                                        struct device_attribute
> > *attr,
> > +                                        const char *buf, size_t
> > count)
> > +{
> > +       if(count < 2)
> > +               return -EINVAL;
> > +
> > +       if(strncasecmp(buf, "none", 4) !=3D 0)
> > +               return -EINVAL;
> > +
> > +       quickstart_data.pressed =3D NULL;
> > +       return count;
> > +}
> > +
> > +/* Hotstart Helper functions */
> > +static int quickstart_btnlst_add(struct quickstart_btn_list **data=
)
> > +{
> > +       struct quickstart_btn_list **ptr =3D &quickstart_data.btn_l=
st;
> > +     =20
> > +       while(*ptr)
> > +               ptr =3D &((*ptr)->next);
> > +             =20
> > +       *ptr =3D kzalloc(sizeof(struct quickstart_btn_list),
> > GFP_KERNEL);
> > +       if(!*ptr){
> > +               *data =3D NULL;
> > +               return(-ENOMEM);
> > +       }
> > +       *data =3D *ptr;
> > +
> > +       return 0;
> > +}
> > +
> > +static void quickstart_btnlst_free(void)
> > +{
> > +       struct quickstart_btn_list *ptr =3D quickstart_data.btn_lst=
;
> > +       struct quickstart_btn_list *lptr =3D NULL;
> > +     =20
> > +       if(!ptr)
> > +               return;
> > +
> > +       while(ptr){
> > +               lptr =3D ptr;
> > +               ptr =3D ptr->next;
> > +               if(lptr->name)
> > +                       kfree(lptr->name);
> > +               kfree(lptr);
> > +       }
> > +     =20
> > +       return;
> > +}
> > +
> > +/* ACPI Driver functions */
> > +static void quickstart_acpi_notify(acpi_handle handle, u32 event,
> > void *data)
> > +{
> > +       struct quickstart_acpi *quickstart =3D data;
> > +
> > +       if (!quickstart)
> > +               return;
> > +
> > +       /* There will be two events:
> > +        * 0x02 - A quickstart button was pressed while device was
> > off/sleeping.
> > +        * 0x08 - A quickstart button was pressed while device was =
up.
> > */
> > +       if((event|0x02) =3D=3D event){
> This is wrong.
> If only two events are supported, it should be either 0x02 or 0x08.
> Checking bit 1 doesn't make sense here.
=46IXED on the patch above
>=20
> > +               quickstart_data.pressed =3D quickstart->btn;
> > +               printk("quickstart: Quickbutton %s pressed.\n",
> > +
> > acpi_device_bid(quickstart->device));
> > +       }
> > +
> > +       if(enable_runtime_btns && (event|0x08) =3D=3D event){
> ...
>=20
> > +               printk("quickstart: Hotkey %s pressed.\n",
> > +
> > acpi_device_bid(quickstart->device));
> > +       }
> > +
> >      =20
> > +       return;
> > +}
> > +
> at least we should export a notification to user space in the notify
> handler.

According to the Microsoft paper, runtime hot button reporting is optio=
nal. And
my laptop doesn't report them, so I don't have a way to test this..

>=20
> > +static void quickstart_acpi_raise_notify(struct quickstart_acpi
> > *quickstart)
> > +{
> > +       acpi_status status;
> > +
> > +       /* TODO:
> > +        * We should receive a buffer telling the kind of button,
> > +        * eg: dvd, printer, www, ...
> > +        * but we dont care about it now. The important is to trigg=
er
> > +        * pending notify events (The ones before booting). */
> > +       status =3D acpi_evaluate_object(quickstart->device->handle,
> > +                                       "GHID", NULL, NULL);
> It's wrong as GHID returns a buffer.

=46IXED on the patch above
The returned buffer is a BYTE/WORD/DWORD with a decimal number telling =
the button
usage ID.
IMHO, the button usage ID is useless.

>=20
> > +       if(ACPI_FAILURE(status))
> > +               printk("quickstart: Warning: GHID method failed,
> > events of pressed buttons may have been lost.\n");
> > +
> > +       return;
> > +}
> > +
> > +static int quickstart_acpi_config(struct quickstart_acpi *quicksta=
rt,
> > char *bid)
> > +{
> > +       int len =3D strlen(bid);
> > +       int ret;
> > +
> > +       /* Add button to list */
> > +       ret =3D quickstart_btnlst_add(&quickstart->btn);
> > +       if(ret)
> > +               return ret;
> > +     =20
> > +       quickstart->btn->name =3D kzalloc(len + 1, GFP_KERNEL);
> > +       if(!quickstart->btn->name){
> > +               quickstart_btnlst_free();
> > +               return -ENOMEM;
> > +       }
> > +       strcpy(quickstart->btn->name, bid);
> > +
> > +       return 0;
> > +}
> > +
> > +static int quickstart_acpi_add(struct acpi_device *device)
> > +{
> > +       int ret =3D 0;
> > +       acpi_status status =3D AE_OK;
> > +       struct quickstart_acpi *quickstart =3D NULL;    =20
> > +
> > +       if (!device)
> > +               return -EINVAL;
> > +
> > +       quickstart =3D kzalloc(sizeof(struct quickstart_acpi),
> > GFP_KERNEL);
> > +       if (!quickstart)
> > +               return -ENOMEM;
> > +
> > +       quickstart->device =3D device;
> > +       strcpy(acpi_device_name(device), QUICKSTART_ACPI_DEVICE_NAM=
E);
> > +       strcpy(acpi_device_class(device), QUICKSTART_ACPI_CLASS);
> > +       acpi_driver_data(device) =3D quickstart;
> > +     =20
> > +       /* Add button to list and initialize some stuff */
> > +       ret =3D quickstart_acpi_config(quickstart,
> > acpi_device_bid(device));
> > +       if(ret)
> > +               goto fail_config;
> > +
> > +       status =3D acpi_install_notify_handler(device->handle,
> > +                                                ACPI_ALL_NOTIFY,
> > +
> > quickstart_acpi_notify, quickstart);
> > +       if(ACPI_FAILURE(status)){
> > +               printk("quickstart: Error installing notify handler
> > \n");
> > +               ret =3D -ENODEV;
> > +               goto fail_installnotify;
> > +       }     =20
> > +
> > +       /* Call device GHID method. This is a workaround to get a
> > notify
> > +        * event when hot button is pressed while laptop is powered
> > off.
> > +        * This works, even if the method fails. */
> > +       quickstart_acpi_raise_notify(quickstart);
> > +
> > +       return 0;
> > +
> > +fail_installnotify:
> > +fail_config:
> > +
> > +       kfree(quickstart);
> > +
> > +       return ret;
> > +}
> > +
> > +static int quickstart_acpi_remove(struct acpi_device *device, int
> > type)
> > +{
> > +       acpi_status status =3D 0;
> > +       struct quickstart_acpi *quickstart =3D NULL;
> > +
> > +       if (!device || !acpi_driver_data(device))
> > +               return -EINVAL;
> > +
> > +       quickstart =3D acpi_driver_data(device);
> > +
> > +       status =3D acpi_remove_notify_handler(device->handle,
> > +                                                ACPI_ALL_NOTIFY,
> > +                                           quickstart_acpi_notify)=
;
> > +       if (ACPI_FAILURE(status))
> > +               printk("quickstart: Error removing notify handler\n=
");
> > +
> > +
> > +       kfree(quickstart);
> > +
> > +       return 0;
> > +}
> > +
> > +/* Module functions */
> > +
> > +static void quickstart_exit(void)
> > +{
> > +       device_remove_file(&pf_device->dev, &dev_attr_pressed_butto=
n);
> > +       device_remove_file(&pf_device->dev, &dev_attr_buttons);
> > +
> > +       platform_device_unregister(pf_device);
> > +
> > +       platform_driver_unregister(&pf_driver);
> > +
> > +       acpi_bus_unregister_driver(&quickstart_acpi_driver);
> > +     =20
> > +       quickstart_btnlst_free();
> > +
> > +       return;
> > +}
> > +
> > +static int __init quickstart_init(void)
> > +{
> > +       int ret;
> > +       acpi_status status =3D 0;
> > +
> > +       /* ACPI Check */
> > +       if(acpi_disabled)
> > +               return -ENODEV;
> > +
> > +       /* ACPI driver register */
> > +       status =3D acpi_bus_register_driver(&quickstart_acpi_driver=
);
> > +       if (!quickstart_data.btn_lst || status < 0)
> > +               return -ENODEV;
> > +
> we should not register platform devices and sys attributes if no PNP0=
C32
> device is available.
> A simple way is to set a flag in the acpi driver's .add method which
> means PNP0C32 device is found.
> And return -ENODEV if the flag is not set after
> acpi_bus_register_driver.

That is exactly whats going on here.
acpi_bus_register_driver() is called with quickstart_data.btn_lst=3DNUL=
L . If no
devices are detected, the quickstart_data.btn_lst is not touched and co=
ntinues
to be null.
So we can consider quickstart_data.btn_lst as the flag you were talking=
=2E
>=20
> > +       /* Platform driver register */
> > +       ret =3D platform_driver_register(&pf_driver);
> > +       if(ret)
> > +               goto fail_pfdrv_reg;
> > +=20
> > +       /* Platform device register */
> > +       pf_device =3D platform_device_alloc(QUICKSTART_PF_DEVICE_NA=
ME,
> > -1);
> > +       if(!pf_device){
> > +               ret =3D -ENOMEM;
> > +               goto fail_pfdev_alloc;
> > +       }
> > +
> > +       ret =3D platform_device_register(pf_device);
> kobject (f7808880): tried to init an initialized object, something is
> seriously wrong.
> Pid: 1, comm: swapper Not tainted 2.6.25-rc6 #1
>  [<c04dad4f>] kobject_init+0x29/0x53
>  [<c05475fc>] device_initialize+0x1b/0x8b
>  [<c054ab62>] platform_device_register+0xb/0x13
>  [<c073dd50>] quickstart_init+0x5d/0xff
>  [<c0725427>] kernel_init+0x12b/0x265
>  [<c041eb8d>] schedule_tail+0x16/0x43
>  [<c040481e>] ret_from_fork+0x6/0x1c
>  [<c07252fc>] kernel_init+0x0/0x265
>  [<c07252fc>] kernel_init+0x0/0x265
>  [<c0405523>] kernel_thread_helper+0x7/0x10
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> quickstart: ACPI Direct App Launch ver 1.00
>=20
> platform_device_add should be called here.
> I suspect the patch is not well tested.

I don't understand this one.
pf_device is initialized twice? How?

>=20
> > +       if(ret)
> > +               goto fail_pfdev_reg;
> > +
> > +       /* Create device sysfs file */
> > +       ret =3D device_create_file(&pf_device->dev,
> > &dev_attr_pressed_button);
> > +       if(ret)
> > +               goto fail_dev_file;
> > +
> > +       ret =3D device_create_file(&pf_device->dev, &dev_attr_butto=
ns);
> > +       if(ret)
> > +               goto fail_dev_file2;
> > +
> > +       printk("quickstart: ACPI Direct App Launch ver %s\n",
> > QUICKSTART_VERSION);
> > +       if(enable_runtime_btns)
> > +               printk("quickstart: Runtime button reporting is
> > enabled.");
> > +     =20
> > +       return 0;
> > +
> > +fail_dev_file2:
> > +       device_remove_file(&pf_device->dev, &dev_attr_pressed_butto=
n);
> > +
> > +fail_dev_file:
> > +       platform_device_del(pf_device);
> > +
> > +fail_pfdev_reg:
> > +       platform_device_put(pf_device);
> > +
> > +fail_pfdev_alloc:
> > +       platform_driver_unregister(&pf_driver);
> > +
> > +fail_pfdrv_reg:
> > +       acpi_bus_unregister_driver(&quickstart_acpi_driver);
> > +
> > +       return ret;
> > +}
> > +
> > +module_init(quickstart_init);
> > +module_exit(quickstart_exit);
> There are some coding style problems.
> Please run checkpatch before submitting the patch.

=46IXED on the patch above

>=20
> thanks,
> rui
>=20
>=20

Thanks,
- --=20
Angelo Arrifano AKA MiKNiX
CSE Student at UBI, Portugal
Gentoo Linux AMD64 Arch Tester
Linwizard Developer
http://miknix.homelinux.com
PGP Pubkey 0x3D92BB0B
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFH6o0rNahyoD2SuwsRAvhDAJ9NJoi5c5tEOHaj+wlRi9S4lEhHrwCfdyhr
IAShcu6win9qeoSrhi6lYc8=3D
=3D7Uap
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
