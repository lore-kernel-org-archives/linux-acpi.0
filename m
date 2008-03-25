From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: Platform driver to support App Hot Startup
	(PNP0C32)
Date: Tue, 25 Mar 2008 14:59:33 +0800
Message-ID: <1206428373.3047.34.camel@acpi-hp-zz.sh.intel.com>
References: <20080314151712.34836918.miknix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16147 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbYCYHXY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Mar 2008 03:23:24 -0400
In-Reply-To: <20080314151712.34836918.miknix@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi, Angelo,

On Fri, 2008-03-14 at 23:17 +0800, =C3=82ngelo Miguel Arrifano wrote:
> Here is the patch made from the today linux-acpi tree.
>=20
> Thanks,
> Angelo Arrifano
we'd better add the change log here.
Some introductions about PNP0C32 device would be great.

> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f688c21..fb096ee 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -196,6 +196,14 @@ config ACPI_THERMAL
>           recommended that this option be enabled, as your
> processor(s)
>           may be damaged without it.
>=20
> +config ACPI_QUICKSTART
> +       tristate "Quickstart"
> +       default y
> +       help
> +         This driver add support for ACPI Direct Application Launch
> +         also known as Hotstart(TM). Say yes here to have a entry in
> +         sysfs telling which button was used to turn on the system.
> +
>  config ACPI_NUMA
>         bool "NUMA support"
>         depends on NUMA
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index f29812a..badb0a6 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -62,3 +62,4 @@ obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)     +=3D
> acpi_memhotplug.o
>  obj-$(CONFIG_ACPI_PROCFS_POWER)        +=3D cm_sbs.o
>  obj-$(CONFIG_ACPI_SBS)         +=3D sbs.o
>  obj-$(CONFIG_ACPI_SBS)         +=3D sbshc.o
> +obj-$(CONFIG_ACPI_QUICKSTART)  +=3D quickstart.o
> diff --git a/drivers/acpi/quickstart.c b/drivers/acpi/quickstart.c
> new file mode 100644
> index 0000000..a4726f8
> --- /dev/null
> +++ b/drivers/acpi/quickstart.c
> @@ -0,0 +1,418 @@
> +/*
> + *  quickstart.c - ACPI Direct App Launch driver
> + *
> + *
> + *  Copyright (C) 2007 Angelo Arrifano <miknix@gmail.com>
> + *
> + *  Information gathered from disassebled dsdt and from here:
> + *  "http://download.microsoft.com/download/9/c/5/
> + *  9c5b2167-8017-4bae-9fde-d599bac8184a/DirAppLaunch_Vista.doc"
> + *
> + *  This program is free software; you can redistribute it and/or
> modify
> + *  it under the terms of the GNU General Public License as publishe=
d
> by
> + *  the Free Software Foundation; either version 2 of the License, o=
r
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public Licens=
e
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
> 02111-1307  USA
> + *
> + */
> +
> +#define QUICKSTART_VERSION "1.00"
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <acpi/acpi_drivers.h>
> +#include <linux/platform_device.h>
> +
> +MODULE_AUTHOR("Angelo Arrifano");
> +MODULE_DESCRIPTION("ACPI Direct App Launch driver");
> +MODULE_LICENSE("GPL");
> +
> +static int enable_runtime_btns;
> +module_param(enable_runtime_btns, int, 0);
> +MODULE_PARM_DESC(enable_runtime_btns,
> +                       "Enable reporting of runtime button presses
> (hotkeys).\n");
"enable_runtime_btns" is useless in this patch.

> +
> +#define QUICKSTART_ACPI_DEVICE_NAME   "quickstart"
> +#define QUICKSTART_ACPI_CLASS         "quickstart"
> +#define QUICKSTART_ACPI_HID           "PNP0C32"
> +
> +#define QUICKSTART_PF_DRIVER_NAME     "quickstart"
> +#define QUICKSTART_PF_DEVICE_NAME     "quickstart"
> +#define QUICKSTART_PF_DEVATTR_NAME    "pressed_button"
> +
> +#define QUICKSTART_MAX_BTN_NAME_LEN   16
> +
> +struct quickstart_btn_list {
> +       char *name;
> +       struct quickstart_btn_list *next;
> +};
> +
> +static struct quickstart_driver_data {
> +       struct quickstart_btn_list *btn_lst;
> +       struct quickstart_btn_list *pressed;
> +} quickstart_data =3D {
> +       .btn_lst =3D NULL,
> +       .pressed =3D NULL,
> +};
> +
> +/*
> + * ACPI driver Structs
> + */
> +
> +struct quickstart_acpi {
> +       struct acpi_device *device;
> +       struct quickstart_btn_list *btn;
> +};
> +static int quickstart_acpi_add(struct acpi_device *device);
> +static int quickstart_acpi_remove(struct acpi_device *device, int
> type);
> +static const struct acpi_device_id  quickstart_device_ids[] =3D {
> +       {QUICKSTART_ACPI_HID, 0},
> +       {"", 0},
> +};
> +
> +static struct acpi_driver quickstart_acpi_driver =3D {
> +       .name =3D "quickstart",
> +       .class =3D QUICKSTART_ACPI_CLASS,
> +       .ids =3D quickstart_device_ids,
> +       .ops =3D {
> +                       .add =3D quickstart_acpi_add,
> +                       .remove =3D quickstart_acpi_remove,
> +               },
> +};
> +
> +/*
> + * Platform driver structs
> + */
> +static ssize_t buttons_show(struct device *dev,
> +                                       struct device_attribute *attr=
,
> +                                       char *buf);
> +static ssize_t pressed_button_show(struct device *dev,
> +                                       struct device_attribute *attr=
,
> +                                       char *buf);
> +static ssize_t pressed_button_store(struct device *dev,
> +                                       struct device_attribute *attr=
,
> +                                        const char *buf,
> +                                        size_t count);
> +static DEVICE_ATTR(pressed_button, 0666, pressed_button_show,
> +                                        pressed_button_store);
> +static DEVICE_ATTR(buttons, 0444, buttons_show, NULL);
> +static struct platform_device *pf_device;
> +static struct platform_driver pf_driver =3D {
> +       .driver =3D {
> +               .name =3D QUICKSTART_PF_DRIVER_NAME,
> +               .owner =3D THIS_MODULE,
> +       }
> +};
> +
> +/*
> + * Platform driver functions
> + */
> +static ssize_t buttons_show(struct device *dev,
> +                                        struct device_attribute
> *attr,
> +                                        char *buf)
> +{
> +       int count =3D 0;
> +       char tmpbuf[QUICKSTART_MAX_BTN_NAME_LEN + 2];
> +       struct quickstart_btn_list *ptr =3D quickstart_data.btn_lst;
> +     =20
> +       if(!ptr)
> +               return snprintf(buf, PAGE_SIZE, "none");
> +
> +       while(ptr && (count < PAGE_SIZE)){
> +               if(ptr->name){
> +                       strncpy(tmpbuf, ptr->name,
> QUICKSTART_MAX_BTN_NAME_LEN);
> +                       strcat(tmpbuf, "\n");
> +                       count +=3D snprintf(buf + count,
> +                                       PAGE_SIZE - count,
> +                                       tmpbuf);
> +               }
> +               ptr =3D ptr->next;
> +       }
> +     =20
> +       return count;
> +}
> +
> +static ssize_t pressed_button_show(struct device *dev,
> +                                       struct device_attribute *attr=
,
> +                                       char *buf)
> +{
> +       return snprintf(buf, PAGE_SIZE, "%s\n",
> +
> (quickstart_data.pressed?quickstart_data.pressed->name:"none"));
> +}
> +
> +
> +static ssize_t pressed_button_store(struct device *dev,
> +                                        struct device_attribute
> *attr,
> +                                        const char *buf, size_t
> count)
> +{
> +       if(count < 2)
> +               return -EINVAL;
> +
> +       if(strncasecmp(buf, "none", 4) !=3D 0)
> +               return -EINVAL;
> +
> +       quickstart_data.pressed =3D NULL;
> +       return count;
> +}
> +
> +/* Hotstart Helper functions */
> +static int quickstart_btnlst_add(struct quickstart_btn_list **data)
> +{
> +       struct quickstart_btn_list **ptr =3D &quickstart_data.btn_lst=
;
> +     =20
> +       while(*ptr)
> +               ptr =3D &((*ptr)->next);
> +             =20
> +       *ptr =3D kzalloc(sizeof(struct quickstart_btn_list),
> GFP_KERNEL);
> +       if(!*ptr){
> +               *data =3D NULL;
> +               return(-ENOMEM);
> +       }
> +       *data =3D *ptr;
> +
> +       return 0;
> +}
> +
> +static void quickstart_btnlst_free(void)
> +{
> +       struct quickstart_btn_list *ptr =3D quickstart_data.btn_lst;
> +       struct quickstart_btn_list *lptr =3D NULL;
> +     =20
> +       if(!ptr)
> +               return;
> +
> +       while(ptr){
> +               lptr =3D ptr;
> +               ptr =3D ptr->next;
> +               if(lptr->name)
> +                       kfree(lptr->name);
> +               kfree(lptr);
> +       }
> +     =20
> +       return;
> +}
> +
> +/* ACPI Driver functions */
> +static void quickstart_acpi_notify(acpi_handle handle, u32 event,
> void *data)
> +{
> +       struct quickstart_acpi *quickstart =3D data;
> +
> +       if (!quickstart)
> +               return;
> +
> +       /* There will be two events:
> +        * 0x02 - A quickstart button was pressed while device was
> off/sleeping.
> +        * 0x08 - A quickstart button was pressed while device was up=
=2E
> */
> +       if((event|0x02) =3D=3D event){
This is wrong.
If only two events are supported, it should be either 0x02 or 0x08.
Checking bit 1 doesn't make sense here.

> +               quickstart_data.pressed =3D quickstart->btn;
> +               printk("quickstart: Quickbutton %s pressed.\n",
> +
> acpi_device_bid(quickstart->device));
> +       }
> +
> +       if(enable_runtime_btns && (event|0x08) =3D=3D event){
=2E..

> +               printk("quickstart: Hotkey %s pressed.\n",
> +
> acpi_device_bid(quickstart->device));
> +       }
> +
>      =20
> +       return;
> +}
> +
at least we should export a notification to user space in the notify
handler.

> +static void quickstart_acpi_raise_notify(struct quickstart_acpi
> *quickstart)
> +{
> +       acpi_status status;
> +
> +       /* TODO:
> +        * We should receive a buffer telling the kind of button,
> +        * eg: dvd, printer, www, ...
> +        * but we dont care about it now. The important is to trigger
> +        * pending notify events (The ones before booting). */
> +       status =3D acpi_evaluate_object(quickstart->device->handle,
> +                                       "GHID", NULL, NULL);
It's wrong as GHID returns a buffer.

> +       if(ACPI_FAILURE(status))
> +               printk("quickstart: Warning: GHID method failed,
> events of pressed buttons may have been lost.\n");
> +
> +       return;
> +}
> +
> +static int quickstart_acpi_config(struct quickstart_acpi *quickstart=
,
> char *bid)
> +{
> +       int len =3D strlen(bid);
> +       int ret;
> +
> +       /* Add button to list */
> +       ret =3D quickstart_btnlst_add(&quickstart->btn);
> +       if(ret)
> +               return ret;
> +     =20
> +       quickstart->btn->name =3D kzalloc(len + 1, GFP_KERNEL);
> +       if(!quickstart->btn->name){
> +               quickstart_btnlst_free();
> +               return -ENOMEM;
> +       }
> +       strcpy(quickstart->btn->name, bid);
> +
> +       return 0;
> +}
> +
> +static int quickstart_acpi_add(struct acpi_device *device)
> +{
> +       int ret =3D 0;
> +       acpi_status status =3D AE_OK;
> +       struct quickstart_acpi *quickstart =3D NULL;    =20
> +
> +       if (!device)
> +               return -EINVAL;
> +
> +       quickstart =3D kzalloc(sizeof(struct quickstart_acpi),
> GFP_KERNEL);
> +       if (!quickstart)
> +               return -ENOMEM;
> +
> +       quickstart->device =3D device;
> +       strcpy(acpi_device_name(device), QUICKSTART_ACPI_DEVICE_NAME)=
;
> +       strcpy(acpi_device_class(device), QUICKSTART_ACPI_CLASS);
> +       acpi_driver_data(device) =3D quickstart;
> +     =20
> +       /* Add button to list and initialize some stuff */
> +       ret =3D quickstart_acpi_config(quickstart,
> acpi_device_bid(device));
> +       if(ret)
> +               goto fail_config;
> +
> +       status =3D acpi_install_notify_handler(device->handle,
> +                                                ACPI_ALL_NOTIFY,
> +
> quickstart_acpi_notify, quickstart);
> +       if(ACPI_FAILURE(status)){
> +               printk("quickstart: Error installing notify handler
> \n");
> +               ret =3D -ENODEV;
> +               goto fail_installnotify;
> +       }     =20
> +
> +       /* Call device GHID method. This is a workaround to get a
> notify
> +        * event when hot button is pressed while laptop is powered
> off.
> +        * This works, even if the method fails. */
> +       quickstart_acpi_raise_notify(quickstart);
> +
> +       return 0;
> +
> +fail_installnotify:
> +fail_config:
> +
> +       kfree(quickstart);
> +
> +       return ret;
> +}
> +
> +static int quickstart_acpi_remove(struct acpi_device *device, int
> type)
> +{
> +       acpi_status status =3D 0;
> +       struct quickstart_acpi *quickstart =3D NULL;
> +
> +       if (!device || !acpi_driver_data(device))
> +               return -EINVAL;
> +
> +       quickstart =3D acpi_driver_data(device);
> +
> +       status =3D acpi_remove_notify_handler(device->handle,
> +                                                ACPI_ALL_NOTIFY,
> +                                           quickstart_acpi_notify);
> +       if (ACPI_FAILURE(status))
> +               printk("quickstart: Error removing notify handler\n")=
;
> +
> +
> +       kfree(quickstart);
> +
> +       return 0;
> +}
> +
> +/* Module functions */
> +
> +static void quickstart_exit(void)
> +{
> +       device_remove_file(&pf_device->dev, &dev_attr_pressed_button)=
;
> +       device_remove_file(&pf_device->dev, &dev_attr_buttons);
> +
> +       platform_device_unregister(pf_device);
> +
> +       platform_driver_unregister(&pf_driver);
> +
> +       acpi_bus_unregister_driver(&quickstart_acpi_driver);
> +     =20
> +       quickstart_btnlst_free();
> +
> +       return;
> +}
> +
> +static int __init quickstart_init(void)
> +{
> +       int ret;
> +       acpi_status status =3D 0;
> +
> +       /* ACPI Check */
> +       if(acpi_disabled)
> +               return -ENODEV;
> +
> +       /* ACPI driver register */
> +       status =3D acpi_bus_register_driver(&quickstart_acpi_driver);
> +       if (!quickstart_data.btn_lst || status < 0)
> +               return -ENODEV;
> +
we should not register platform devices and sys attributes if no PNP0C3=
2
device is available.
A simple way is to set a flag in the acpi driver's .add method which
means PNP0C32 device is found.
And return -ENODEV if the flag is not set after
acpi_bus_register_driver.

> +       /* Platform driver register */
> +       ret =3D platform_driver_register(&pf_driver);
> +       if(ret)
> +               goto fail_pfdrv_reg;
> +=20
> +       /* Platform device register */
> +       pf_device =3D platform_device_alloc(QUICKSTART_PF_DEVICE_NAME=
,
> -1);
> +       if(!pf_device){
> +               ret =3D -ENOMEM;
> +               goto fail_pfdev_alloc;
> +       }
> +
> +       ret =3D platform_device_register(pf_device);
kobject (f7808880): tried to init an initialized object, something is
seriously wrong.
Pid: 1, comm: swapper Not tainted 2.6.25-rc6 #1
 [<c04dad4f>] kobject_init+0x29/0x53
 [<c05475fc>] device_initialize+0x1b/0x8b
 [<c054ab62>] platform_device_register+0xb/0x13
 [<c073dd50>] quickstart_init+0x5d/0xff
 [<c0725427>] kernel_init+0x12b/0x265
 [<c041eb8d>] schedule_tail+0x16/0x43
 [<c040481e>] ret_from_fork+0x6/0x1c
 [<c07252fc>] kernel_init+0x0/0x265
 [<c07252fc>] kernel_init+0x0/0x265
 [<c0405523>] kernel_thread_helper+0x7/0x10
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
quickstart: ACPI Direct App Launch ver 1.00

platform_device_add should be called here.
I suspect the patch is not well tested.

> +       if(ret)
> +               goto fail_pfdev_reg;
> +
> +       /* Create device sysfs file */
> +       ret =3D device_create_file(&pf_device->dev,
> &dev_attr_pressed_button);
> +       if(ret)
> +               goto fail_dev_file;
> +
> +       ret =3D device_create_file(&pf_device->dev, &dev_attr_buttons=
);
> +       if(ret)
> +               goto fail_dev_file2;
> +
> +       printk("quickstart: ACPI Direct App Launch ver %s\n",
> QUICKSTART_VERSION);
> +       if(enable_runtime_btns)
> +               printk("quickstart: Runtime button reporting is
> enabled.");
> +     =20
> +       return 0;
> +
> +fail_dev_file2:
> +       device_remove_file(&pf_device->dev, &dev_attr_pressed_button)=
;
> +
> +fail_dev_file:
> +       platform_device_del(pf_device);
> +
> +fail_pfdev_reg:
> +       platform_device_put(pf_device);
> +
> +fail_pfdev_alloc:
> +       platform_driver_unregister(&pf_driver);
> +
> +fail_pfdrv_reg:
> +       acpi_bus_unregister_driver(&quickstart_acpi_driver);
> +
> +       return ret;
> +}
> +
> +module_init(quickstart_init);
> +module_exit(quickstart_exit);
There are some coding style problems.
Please run checkpatch before submitting the patch.

thanks,
rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
