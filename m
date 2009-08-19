From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC] [PATCH v3 1/2] introduce ALS sysfs class
Date: Wed, 19 Aug 2009 16:57:09 +0800
Message-ID: <1250672229.17853.69.camel@rzhang-dt>
References: <1250671229.17853.51.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20536 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbZHSI6t (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Aug 2009 04:58:49 -0400
In-Reply-To: <1250671229.17853.51.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>

Hi, Pavel,

the current illuminance is not equal to the specified values in the
mappings in most case.
the ALS driver don't have enough knowledge to get a proper display
adjustment, especially that a proper display adjustment would be easy t=
o
select a proper brightness level.
So I think we'd better leave this to user space, which is more flexible=
=2E
that's why I still export the mapping info to userspace in this patch.

what do you think?

thanks,
rui

On Wed, 2009-08-19 at 16:40 +0800, Zhang, Rui wrote:
> Introduce ALS sysfs class device.
>=20
> ALS sysfs class device provides a standard sysfs interface
> for Ambient Light Sensor devices.
>=20
> please read Documentation/ABI/testing/sysfs-class-als for detailed sy=
sfs
> designs.
>=20
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-class-als |  137 ++++++++++++++++
>  drivers/Kconfig                           |    2
>  drivers/Makefile                          |    1
>  drivers/als/Kconfig                       |   10 +
>  drivers/als/Makefile                      |    5
>  drivers/als/als_sys.c                     |  256 +++++++++++++++++++=
+++++++++++
>  include/linux/als_sys.h                   |   57 ++++++
>  7 files changed, 468 insertions(+)
>=20
> Index: linux-2.6/drivers/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/Kconfig
> +++ linux-2.6/drivers/Kconfig
> @@ -62,6 +62,8 @@ source "drivers/power/Kconfig"
>=20
>  source "drivers/hwmon/Kconfig"
>=20
> +source "drivers/als/Kconfig"
> +
>  source "drivers/thermal/Kconfig"
>=20
>  source "drivers/watchdog/Kconfig"
> Index: linux-2.6/drivers/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/Makefile
> +++ linux-2.6/drivers/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_PPS)             +=3D pps/
>  obj-$(CONFIG_W1)               +=3D w1/
>  obj-$(CONFIG_POWER_SUPPLY)     +=3D power/
>  obj-$(CONFIG_HWMON)            +=3D hwmon/
> +obj-$(CONFIG_ALS)              +=3D als/
>  obj-$(CONFIG_THERMAL)          +=3D thermal/
>  obj-$(CONFIG_WATCHDOG)         +=3D watchdog/
>  obj-$(CONFIG_PHONE)            +=3D telephony/
> Index: linux-2.6/drivers/als/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ linux-2.6/drivers/als/Kconfig
> @@ -0,0 +1,10 @@
> +#
> +# Ambient Light Sensor sysfs device configuration
> +#
> +
> +menuconfig ALS
> +       tristate "Ambient Light Sensor sysfs device"
> +       help
> +         This framework provides a generic sysfs interface for
> +         Ambient Light Sensor devices.
> +         If you want this support, you should say Y or M here.
> Index: linux-2.6/drivers/als/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ linux-2.6/drivers/als/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for sensor chip drivers.
> +#
> +
> +obj-$(CONFIG_ALS)              +=3D als_sys.o
> Index: linux-2.6/drivers/als/als_sys.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ linux-2.6/drivers/als/als_sys.c
> @@ -0,0 +1,256 @@
> +/*
> + *  als_sys.c - Ambient Light Sensor Sysfs support.
> + *
> + *  Copyright (C) 2009 Intel Corp
> + *  Copyright (C) 2009 Zhang Rui <rui.zhang@intel.com>
> + *
> + *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
> + *
> + *  This program is free software; you can redistribute it and/or mo=
dify
> + *  it under the terms of the GNU General Public License as publishe=
d by
> + *  the Free Software Foundation; version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful, =
but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GN=
U
> + *  General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public Licens=
e along
> + *  with this program; if not, write to the Free Software Foundation=
, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
> + */
> +
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/als_sys.h>
> +
> +MODULE_AUTHOR("Zhang Rui");
> +MODULE_DESCRIPTION("Ambient Light Sensor sysfs support");
> +MODULE_LICENSE("GPL");
> +
> +struct als_mapping_item {
> +       struct kobject kobj;
> +       int index;
> +       struct list_head node;
> +};
> +
> +/* sys I/F for Ambient Light Sensor */
> +
> +#define to_als_device(dev) container_of(dev, struct als_device, devi=
ce)
> +
> +static ssize_t
> +desc_show(struct device *dev, struct device_attribute *attr, char *b=
uf)
> +{
> +       struct als_device *als =3D to_als_device(dev);
> +
> +       return sprintf(buf, "%s\n", als->desc ? als->desc : "N/A");
> +}
> +
> +static ssize_t
> +illuminance_show(struct device *dev, struct device_attribute *attr, =
char *buf)
> +{
> +       struct als_device *als =3D to_als_device(dev);
> +       int illuminance;
> +       int result;
> +
> +       result =3D als->ops->get_illuminance(als, &illuminance);
> +       if (result)
> +               return result;
> +
> +       if (!illuminance)
> +               return sprintf(buf, "Illuminance below the supported =
range\n");
> +       else if (illuminance =3D=3D -1)
> +               return sprintf(buf, "Illuminance above the supported =
range\n");
> +       else if (illuminance < -1)
> +               return -ERANGE;
> +       else
> +               return sprintf(buf, "%d\n", illuminance);
> +}
> +
> +static struct device_attribute als_attrs[] =3D {
> +       __ATTR(desc, 0444, desc_show, NULL),
> +       __ATTR(illuminance, 0444, illuminance_show, NULL),
> +       __ATTR_NULL,
> +};
> +
> +static void als_release(struct device *dev)
> +{
> +       struct als_device *als =3D to_als_device(dev);
> +       struct als_mapping_item *pos, *n;
> +
> +       if (als->desc)
> +               kfree(als->desc);
> +       list_for_each_entry_safe(pos, n, &als->mappings, node){
> +               list_del(&pos->node);
> +               kfree(pos);
> +       }
> +       kfree(als);
> +}
> +
> +static struct class als_class =3D {
> +       .name =3D "als",
> +       .dev_release =3D als_release,
> +       .dev_attrs =3D als_attrs,
> +};
> +
> +#define ATTR(_name, _mode)      \
> +       struct attribute als_##_name##_attr =3D {               \
> +       .name =3D __stringify(_name), .mode =3D _mode, \
> +       };
> +
> +static ATTR(illuminance, 0444);
> +static ATTR(adjustment, 0444);
> +
> +static struct attribute * als_mapping_attrs[] =3D {
> +       &als_illuminance_attr,
> +       &als_adjustment_attr,
> +       NULL,
> +};
> +
> +static ssize_t show_mapping_info(struct kobject *kobj,
> +                                      struct attribute *attr, char *=
buf)
> +{
> +       struct device *dev =3D container_of(kobj->parent, struct devi=
ce, kobj);
> +       struct als_device *als =3D to_als_device(dev);
> +       int index, illuminance, adjustment;
> +       int result;
> +
> +       if (!sscanf(kobj->name, "mapping%d", &index))
> +               return -EINVAL;
> +
> +       result =3D als->ops->get_mapping_info(als, index, &illuminanc=
e, &adjustment);
> +       if (result)
> +               return result;
> +
> +       return sprintf(buf, "%u\n", (attr =3D=3D &als_illuminance_att=
r) ? illuminance : adjustment);
> +}
> +
> +static struct sysfs_ops als_mapping_info_ops =3D {
> +       .show =3D show_mapping_info,
> +       .store =3D NULL,
> +};
> +
> +static struct kobj_type als_mapping_ktype =3D {
> +       .sysfs_ops =3D &als_mapping_info_ops,
> +       .default_attrs =3D als_mapping_attrs,
> +};
> +
> +/**
> + * als_device_update_mappings - update the ambient light illuminance=
 to
> + *                             display luminance adjustment mappings
> + */
> +int als_device_update_mappings(struct als_device *als, int count)
> +{
> +       int old_count =3D als->count;
> +       int i;
> +       struct als_mapping_item *pos, *next;
> +       int result;
> +
> +       als->count =3D count;
> +       if (old_count =3D=3D als->count)
> +               return 0;
> +
> +       mutex_lock(&als->lock);
> +       if (als->count > old_count)
> +               for (i =3D old_count; i < als->count; i++) {
> +                       pos =3D kzalloc(sizeof(struct als_mapping_ite=
m), GFP_KERNEL);
> +                       if (!pos)
> +                               return -ENOMEM;
> +
> +                       pos->index =3D i;
> +                       result =3D kobject_init_and_add(&pos->kobj, &=
als_mapping_ktype,
> +                                       &als->device.kobj, "mapping%d=
", pos->index);
> +                       if (result)
> +                               break;
> +                       list_add_tail(&pos->node, &als->mappings);
> +               }
> +       else
> +               list_for_each_entry_safe(pos, next, &als->mappings, n=
ode) {
> +                       if (pos->index < als->count)
> +                               continue;
> +                       list_del(&pos->node);
> +                       kobject_put(&pos->kobj);
> +                       kfree(pos);
> +               }
> +
> +       if (result)
> +               als->count =3D i;
> +       mutex_unlock(&als->lock);
> +       return 0;
> +}
> +
> +EXPORT_SYMBOL(als_device_update_mappings);
> +
> +/**
> + * als_device_register - register a new Ambient Light Sensor class d=
evice
> + * @ops:       standard ALS devices callbacks.
> + * @devdata:   device private data.
> + */
> +struct als_device *als_device_register(struct als_device_ops *ops,
> +                                      char *desc, void *devdata)
> +{
> +       struct als_device *als;
> +       static int als_id;
> +       int result;
> +
> +       if (!ops || !ops->get_illuminance)
> +               return ERR_PTR(-EINVAL);
> +
> +       als =3D kzalloc(sizeof(struct als_device), GFP_KERNEL);
> +       if (!als)
> +               return ERR_PTR(-ENOMEM);
> +
> +       als->ops =3D ops;
> +       als->device.class =3D &als_class;
> +       als->devdata =3D devdata;
> +       als->id =3D als_id++;
> +       INIT_LIST_HEAD(&als->mappings);
> +       mutex_init(&als->lock);
> +       if (desc) {
> +               als->desc =3D kzalloc(strlen(desc), GFP_KERNEL);
> +               if (!als->desc) {
> +                       kfree(als);
> +                       return ERR_PTR(-ENOMEM);
> +               }
> +               strcpy(als->desc, desc);
> +       }
> +       dev_set_name(&als->device, "als%d", als->id);
> +       result =3D device_register(&als->device);
> +       if (result) {
> +               if (als->desc)
> +                       kfree(als->desc);
> +               kfree(als);
> +               return ERR_PTR(result);
> +       }
> +
> +       return als;
> +}
> +
> +EXPORT_SYMBOL(als_device_register);
> +
> +/**
> + * als_device_unregister - removes the registered ALS device
> + * @als:       the ALS device to remove.
> + */
> +void als_device_unregister(struct als_device *als)
> +{
> +       device_unregister(&als->device);
> +}
> +
> +EXPORT_SYMBOL(als_device_unregister);
> +
> +static int __init als_init(void)
> +{
> +       return class_register(&als_class);
> +}
> +
> +static void __exit als_exit(void)
> +{
> +       class_unregister(&als_class);
> +}
> +
> +subsys_initcall(als_init);
> +module_exit(als_exit);
> Index: linux-2.6/include/linux/als_sys.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ linux-2.6/include/linux/als_sys.h
> @@ -0,0 +1,57 @@
> +/*
> + *  als.h  ($Revision: 0 $)
> + *
> + *  Copyright (C) 2009  Intel Corp
> + *  Copyright (C) 2009  Zhang Rui <rui.zhang@intel.com>
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
> + *  This program is free software; you can redistribute it and/or mo=
dify
> + *  it under the terms of the GNU General Public License as publishe=
d by
> + *  the Free Software Foundation; version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful, =
but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GN=
U
> + *  General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public Licens=
e along
> + *  with this program; if not, write to the Free Software Foundation=
, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
> + */
> +
> +#ifndef __ALS_SYS_H__
> +#define __ALS_SYS_H__
> +
> +#include <linux/device.h>
> +
> +struct als_device;
> +
> +struct als_device_ops {
> +       int (*get_illuminance) (struct als_device *, int *);
> +       int (*get_mapping_info) (struct als_device *, int, int *, int=
 *);
> +};
> +
> +struct als_mapping {
> +       int illuminance;
> +       int adjustment;
> +};
> +
> +struct als_device {
> +       int id;
> +       int illuminance;
> +       struct device device;
> +       struct als_device_ops *ops;
> +       void *devdata;
> +       char *desc;
> +       int count;
> +       struct list_head mappings;
> +       struct mutex lock;
> +};
> +
> +int als_device_update_mappings(struct als_device *, int);
> +struct als_device *als_device_register(struct als_device_ops *, char=
 *, void *);
> +void als_device_unregister(struct als_device *);
> +
> +#endif /* __ALS_SYS_H__ */
> Index: linux-2.6/Documentation/ABI/testing/sysfs-class-als
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ linux-2.6/Documentation/ABI/testing/sysfs-class-als
> @@ -0,0 +1,137 @@
> +Ambient Light Sensor Sysfs driver How To
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +Written by Zhang Rui <rui.zhang@intel.com>
> +
> +Updated: 6 August 2009
> +
> +Copyright (c)  2009 Intel Corporation
> +
> +0. Introduction
> +
> +The generic Ambient Light Sensor sysfs provides a standard interface=
 for ALS devices.
> +
> +User space can use this interface to get the status of the ambient l=
ight environment
> +the system is currently in, and get the ambient light illuminance to=
 display luminance
> +mappings to calibrate its ambient light policy for a given sensor co=
nfiguration.
> +
> +An intelligent ALS application can make ambient light decisions base=
d on inputs
> +from these ALS attributes and adjust the LVDS brightness levels.
> +
> +[0-N]  denotes any positive number starting from 0 to N
> +
> +Two acronyms that used in this HOW TO only:
> +ALI    ambient light illuminace
> +DLA    display luminance adjustment (or display brightness adjustmen=
t)
> +
> +1. Ambient Light Sensor sysfs driver interface functions
> +
> +1.1 struct als_device *als_device_register(struct als_device_ops *op=
s, char *desc, void *devdata)
> +
> +       This interface function adds a new ALS device to
> +       /sys/class/als folder as als[0-*].
> +
> +       ops:    thermal zone device call-backs.
> +               .get_illuminance: get the current ALI.
> +               .get_mappings_count: get the number of ALI to DLA map=
pings.
> +               .get_mapping_info: get the info of a specified ALI to=
 DLA mapping.
> +       desc:   a description of the ALS device.
> +       devdata:device private data
> +
> +1.2 void als_device_unregister(struct als_device *als)
> +
> +       This interface function removes the ALS device.
> +       It deletes the corresponding entry form /sys/class/als folder=
=2E
> +
> +1.3 int als_device_update_mappings(struct als_device *als)
> +
> +       This interface updates the ALI to DLA mappings.
> +       This is usually invoked by the native ALS driver when it dete=
cts a mapping change.
> +
> +2. sysfs attributes structure
> +
> +RO     read only value
> +RW     read/write value
> +
> +ALS sysfs attributes will be represented under /sys/class/als.
> +
> +/sys/class/als/als[0-*]:
> +       |-----desc:                     Strings which describes the A=
LS device
> +       |-----illuminance:              Current ALI
> +       |-----mapping[0-*]:
> +               |-----illuminance:      ALI threshold when an DLA is =
needed
> +               |-----adjustment:       how to do the DLA when the th=
reshold is hit
> +
> +***********************************
> +* Ambient Light Sendor attributes *
> +***********************************
> +
> +desc                           Strings which descibes the current AL=
S.
> +                               This is given by native ALS driver as=
 part of registration.
> +                               e.g: "acpi_als" for ACPI ALS devices.
> +                               RO
> +                               Required
> +
> +illuminance                    Current ALI reported by native ALS dr=
iver
> +                               Unit: lux (lumens per square meter)
> +                               RO
> +                               Required
> +
> +mapping[0-*]                   represent one item of the ALI to DLA =
mappings.
> +
> +mapping[0-*]/illuminance       ALI threshold when an DLA is needed
> +                               RO
> +
> +mapping[0-*]/adjustment                a relative percentages in ord=
er simplify the means
> +                               by which these adjustments are applie=
d in lieu of
> +                               changes to the user=E2=80=99s display=
 brightness preference.
> +                               A value of 100 is used to indicate no=
 (0%) display
> +                               brightness adjustment.
> +                               Values less than 100 indicate a negat=
ive adjustment
> +                               (dimming); values greater than 100 in=
dicate a positive
> +                               adjustment (brightening).
> +                               RO
> +
> +3. How to implement ALS control in user space
> +
> +To implement the ALS control, including both ALI detection and Backl=
ight
> +adjustment, interactions between backlight driver and als driver are=
 needed.
> +It's ugly to implement such a driver in Linux kernel.
> +A user space application is preferred in this case.
> +
> +Below is a simple example of how to do ALS management in user space.
> +
> +This is the ACPI backlight sysfs I/F
> +/sys/class/backlight/acpi_video0:
> +       |-----brightness        6
> +       |-----actual_brightness 6
> +       |-----max_brightness    10
> +
> +And this is the ACPI ALS sysfs I/F
> +/sys/class/als/als0:
> +       |-----illuminance               500
> +       |-----mapping[0]
> +               |-----illuminance       0
> +               |-----adjustment        50
> +       |-----mapping[1]
> +               |-----illuminance       200
> +               |-----adjustment        70
> +       |-----mapping[2]
> +               |-----illuminance       600
> +               |-----adjustment        100
> +       |-----mapping[3]
> +               |-----illuminance       900
> +               |-----adjustment        125
> +       |-----mapping[4]
> +               |-----illuminance       1200
> +               |-----adjustment        150
> +
> +If user thinks that brightness level 6 is good enough for him when A=
LI is 600,
> +he can set brightness 6 as the user=E2=80=99s display brightness pre=
ference.
> +When user goes to the basement with the laptop and the ALI changes t=
o 200,
> +the ALS application knows that it should do a -25% display brightnes=
s
> +adjustment, i.e. changes the backlight to 4.
> +And when the laptop is used outdoors, where the ALI reaches 1200,
> +the ALS application should do a +50% adjustment,
> +i.e. run "echo 9 > /sys/class/backlight/acpi_video0/brightness".
> +
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
