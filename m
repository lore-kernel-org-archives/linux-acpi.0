From: =?ISO-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Subject: Re: [PATCH] ACPI: Platform driver to support App Hot Startup
 (PNP0C32)
Date: Thu, 27 Mar 2008 16:03:46 +0000
Message-ID: <20080327160346.424052fe.miknix@gmail.com>
References: <20080314151712.34836918.miknix@gmail.com>
	<1206428373.3047.34.camel@acpi-hp-zz.sh.intel.com>
	<20080326175139.d59ff46d.miknix@gmail.com>
	<1206585013.8282.17.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:14805 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756070AbYC0Pup convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Mar 2008 11:50:45 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1665806nfb.21
        for <linux-acpi@vger.kernel.org>; Thu, 27 Mar 2008 08:50:44 -0700 (PDT)
In-Reply-To: <1206585013.8282.17.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org

On Thu, 27 Mar 2008 10:30:13 +0800
Shaohua Li <shaohua.li@intel.com> wrote:

>=20
> On Thu, 2008-03-27 at 01:51 +0800, =C2ngelo Miguel Arrifano wrote:
> > PATCH
> > - -----------------------------------------------------------------
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index f688c21..fb096ee 100644
> > - --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -196,6 +196,14 @@ config ACPI_THERMAL
> >           recommended that this option be enabled, as your
> > processor(s)
> >           may be damaged without it.
> >=20
> > +config ACPI_QUICKSTART
> > +       tristate "Quickstart"
> > +       default y
> default m?
>=20
>=20
> > +
> > +static struct quickstart_driver_data {
> > +       struct quickstart_btn *btn_lst;
> > +       struct quickstart_btn *pressed;
> > +} quickstart_data =3D {
> > +       .btn_lst =3D NULL,
> > +       .pressed =3D NULL,
> > +};
> They are NULL, you don't need initialize them.
>=20
>=20
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
> this file can be changed by non-root?

The only thing that writing to this file does is clearing the
pressed button.
Is it a bad idea that can be changed by non-root?

>=20
>=20
> > +static ssize_t buttons_show(struct device *dev,
> > +                                        struct device_attribute
> > *attr,
> > +                                        char *buf)
> > +{
> > +       int count =3D 0;
> > +       char tmpbuf[QUICKSTART_MAX_BTN_NAME_LEN + 2];
> > +       struct quickstart_btn *ptr =3D quickstart_data.btn_lst;
> > +
> > +       if (!ptr)
> > +               return snprintf(buf, PAGE_SIZE, "none");
> > +
> > +       while (ptr && (count < PAGE_SIZE)) {
> > +               if (ptr->name) {
> > +                       strncpy(tmpbuf, ptr->name,
> > QUICKSTART_MAX_BTN_NAME_LEN);
> > +                       strcat(tmpbuf, "\n");
> > +                       count +=3D snprintf(buf + count,
> > +                                       PAGE_SIZE - count,
> > +                                       tmpbuf);
> we could simplify:
> snprintf(buf + count, PAGE_SIZE -count, "%s\n", ptr->name);

:)

> > +               }
> > +               ptr =3D ptr->next;
> > +       }
> > +
> > +       return count;
> > +}
>=20
> > +
>=20
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
> > +       if (event =3D=3D QUICKSTART_EVENT_WAKE) {
> > +               quickstart_data.pressed =3D quickstart->btn;
> > +               printk(KERN_ERR "quickstart: Quickbutton %s
> > pressed.\n",
> > +
> > acpi_device_bid(quickstart->device));
> > +       } else if (event =3D=3D QUICKSTART_EVENT_RUNTIME) {
> > +               printk(KERN_ERR "quickstart: Runtime button %s
> > pressed.\n\t"
> > +                      "please report on linux-acpi@vger.kernel.org=
",
> > +
> > acpi_device_bid(quickstart->device));
> > +       }
> Please remove above printks. they are misleading, which isn't an erro=
r.
> please send an ACPI event to userspace in the notify, we need it for
> runtime.

According to the Microsoft paper, runtime hot button reporting is optio=
nal.
My laptop doesn't report them and on the SF.net project page there was =
no
reports of people with hardware supporting this.
Sorry, I don't have a way to test this..

>=20
> > +       return;
> > +}
> > +
> > +static void quickstart_acpi_raise_notify(struct quickstart_acpi
> > *quickstart)
> > +{
> > +       acpi_status status;
> > +       struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL =
};
> > +
> > +       if (!quickstart)
> > +               return;
> > +
> > +       /* This returns a buffer telling the  button usage ID
> > (useless),
> > +        * we dont care about it now. The important is to trigger
> > +        * pending notify events (The ones before booting). */
> > +       status =3D acpi_evaluate_object(quickstart->device->handle,
> > +                                       "GHID", NULL, &buffer);
> > +       if (ACPI_FAILURE(status) || !buffer.pointer) {
> > +               printk(KERN_ERR "quickstart: %s GHID method
> > failed.\n",
> > +                      quickstart->btn->name);
> > +               return;
> > +       }
> I'd suggest the GHID info should be exported to sysfs too. It's hard =
to
> judge what a button is just per its name. You know it but an
> inexperienced user doesn't.

I also would like to have a more descriptive information about the butt=
on but
the returned buffer is a BYTE/WORD/DWORD with a decimal number telling =
the button
usage ID.

Looking at my DSDT piece of code:

Method (GHID, 0, NotSerialized)
{
   If (LEqual (HOTB, 0x05))
   {
      Notify (DBTN, 0x02)
      Store (0x00, HOTB)
   }

   Return (Buffer (0x01)
   {
      /* 0000 */    0x04
   })
}

IMHO, a value like 0x04 for button usageID is totally useless..

>=20
> > +       kfree(buffer.pointer);
> > +       return;
> > +}
> > +
>=20
> > +
> > +static int quickstart_acpi_add(struct acpi_device *device)
> > +{
> > +       int ret =3D 0;
> > +       acpi_status status =3D AE_OK;
> > +       struct quickstart_acpi *quickstart =3D NULL;
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
> > +
> > +       /* Add button to list and initialize some stuff */
> > +       ret =3D quickstart_acpi_config(quickstart,
> > acpi_device_bid(device));
> > +       if (ret)
> > +               goto fail_config;
> > +
> > +       status =3D acpi_install_notify_handler(device->handle,
> > +                                               ACPI_ALL_NOTIFY,
> > +
> > quickstart_acpi_notify,
> > +                                               quickstart);
> > +       if (ACPI_FAILURE(status)) {
> > +               printk(KERN_ERR "quickstart: Notify handler install
> > error\n");
> > +               ret =3D -ENODEV;
> > +               goto fail_installnotify;
> memory is freed but it's still in the list.

I got it now, big mistake here.
I hope to have this fixed on the patch below

>=20
> Thanks,
> Shaohua
>



diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f688c21..fd65e36 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -196,6 +196,14 @@ config ACPI_THERMAL
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
index f29812a..badb0a6 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -62,3 +62,4 @@ obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+=3D acpi_memhotplu=
g.o
 obj-$(CONFIG_ACPI_PROCFS_POWER)	+=3D cm_sbs.o
 obj-$(CONFIG_ACPI_SBS)		+=3D sbs.o
 obj-$(CONFIG_ACPI_SBS)		+=3D sbshc.o
+obj-$(CONFIG_ACPI_QUICKSTART)	+=3D quickstart.o
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
+	struct quickstart_btn *ptr =3D quickstart_data.btn_lst;
+
+	if (!ptr)
+		return snprintf(buf, PAGE_SIZE, "none");
+
+	while (ptr && (count < PAGE_SIZE)) {
+		if (ptr->name) {
+			count +=3D snprintf(buf + count,
+					PAGE_SIZE - count,
+					"%s\n", ptr->name);
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



Thanks all,
--=20
Angelo Arrifano AKA MiKNiX
CSE Student at UBI, Portugal
Gentoo Linux AMD64 Arch Tester
Linwizard Developer
http://miknix.homelinux.com
PGP Pubkey 0x3D92BB0B
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
