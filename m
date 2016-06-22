From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/3] acpi: dptf_power: Add DPTF power participant
Date: Thu, 23 Jun 2016 01:48:10 +0200
Message-ID: <CAJZ5v0g-jZqobJQax-mxBnTnm7ZH2V5=bMLvWTcqVQbraBqxjQ@mail.gmail.com>
References: <1466653363-7311-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1466653363-7311-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34288 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbcFVXsM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jun 2016 19:48:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id 187so6096944wmz.1
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jun 2016 16:48:11 -0700 (PDT)
In-Reply-To: <1466653363-7311-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <darren.hart@intel.com>

On Thu, Jun 23, 2016 at 5:42 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> This driver adds support for Dynamic Platform and Thermal Framework
> (DPTF) Platform Power Participant device support.
> This participant is responsible for exposing platform telemetry such =
as
> platform Power, battery Information such as state of Charge, estimate=
d
> maximum sustainable power (PMax), SMART battery spec information.
>
> This driver is implemented as a platform driver for INT3407 and prese=
nted
> as power_supply device. Since this has common features with the ACPI
> battery, existing interface provide by battery_common driver are reus=
ed
> to present as a battery power supply device.
>
> Since this driver will also register a battery power supply device,th=
is
> driver will exit if CONFIG_ACPI_BATTERY is defined.
>
> There are two types of objects in INT3407:
> - Same as ACPI Battery objects: _BST and _BIX. These are exposed as
> standard power supply attributes.
> - Specific to INT3407, which are related to platform power
> There are some objects, for which it doesn't make sense to enhance
> power_supply class and add attributes there. They are represented as
> sysfs attribute under acpi device.

The below part of the changelog should really go to a doc under Documen=
tation/.

> Here the bid for INT3407 is TPWR
> in the following example.
> /sys/class/power_supply/TPWR
> =E2=94=9C=E2=94=80=E2=94=80 alarm
> =E2=94=9C=E2=94=80=E2=94=80 capacity
> =E2=94=9C=E2=94=80=E2=94=80 capacity_level
> =E2=94=9C=E2=94=80=E2=94=80 cycle_count
> =E2=94=9C=E2=94=80=E2=94=80 device -> ../../../INT3407:00
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 dptf_power
> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 adapter_rating
> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 battery_steady_po=
wer
> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 charger_type
> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 max_platform_powe=
r
> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 platform_power_so=
urce
> =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 power_sampling_pe=
riod
>
> For example representing AC/adapter properties as a power_supply
> properties will not make sense for a battery device. In some case
> when there is an existing property, the meaning is different.
> For example charger_type has a equivalent power_supply property,
> which has different symantics than INT3407.
>
> ACPI methods description used in this driver:
> PSOC: Platform Battery State Of Charge as a percentage.
> PMAX: Maximum platform power that can be supported by the battery in =
mW.
> PSRC: System charge source,
>         0x00 =3D DC
>         0x01 =3D AC
>         0x02 =3D USB
>         0x03 =3D Wireless Charger
> ARTG: Adapter rating in mW (Maximum Adapter power) Must be 0 if no AC
>         Adaptor is plugged in.
> CTYP: Charger Type,
>         Traditional : 0x01
>         Hybrid: 0x02
>         NVDC: 0x03
> PBSS: Returns max sustained power for battery in milliWatts.
> DPSP: Sets the polling interval in 10ths of seconds. A value of 0 tel=
ls
>         the driver to use event notification for PMAX and PBSS
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.c=
om>
> ---
>  drivers/acpi/Kconfig      |  17 +++++
>  drivers/acpi/Makefile     |   1 +
>  drivers/acpi/dptf_power.c | 184 ++++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 202 insertions(+)
>  create mode 100644 drivers/acpi/dptf_power.c
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 27ae351..03a34b4 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -526,4 +526,21 @@ config XPOWER_PMIC_OPREGION
>
>  endif
>
> +config DPTF_POWER
> +       tristate "DPTF Platform Power Participant"
> +       depends on X86
> +       select ACPI_BATTERY_COMMON
> +       select POWER_SUPPLY
> +       default y
> +       help
> +         This driver adds support for Dynamic Platform and Thermal F=
ramework
> +         (DPTF) Platform Power Participant device support.
> +         This participant is responsible for exposing platform telem=
etry such
> +         as platform Power, battery Information such as state of Cha=
rge,
> +         estimated maximum sustainable power (PMax), SMART battery s=
pec
> +         information.
> +
> +         To compile this driver as a module, choose M here:
> +         the module will be called dptf_power.
> +
>  endif  # ACPI
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 950bf8e..1c76715 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -75,6 +75,7 @@ obj-$(CONFIG_ACPI)            +=3D acpi_memhotplug.=
o
>  obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) +=3D ioapic.o
>  obj-$(CONFIG_ACPI_BATTERY_COMMON) +=3D battery_common.o
>  obj-$(CONFIG_ACPI_BATTERY)     +=3D battery.o
> +obj-$(CONFIG_DPTF_POWER)       +=3D dptf_power.o

Now that I think about it, maybe it would be better to put that into
drivers/platform/x86?

>  obj-$(CONFIG_ACPI_SBS)         +=3D sbshc.o
>  obj-$(CONFIG_ACPI_SBS)         +=3D sbs.o
>  obj-$(CONFIG_ACPI_HED)         +=3D hed.o
> diff --git a/drivers/acpi/dptf_power.c b/drivers/acpi/dptf_power.c
> new file mode 100644
> index 0000000..013b7f3
> --- /dev/null
> +++ b/drivers/acpi/dptf_power.c
> @@ -0,0 +1,184 @@
> +/*
> + * dptf_power:  DPTF platform power driver
> + * Copyright (c) 2016, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WI=
THOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lic=
ense for
> + * more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>
> +#include "battery.h"
> +
> +#define DPTF_POWER_SHOW(name, object) \
> +static ssize_t name##_show(struct device *dev,\
> +                          struct device_attribute *attr,\
> +                          char *buf)\
> +{\
> +       struct acpi_device *acpi_dev =3D to_acpi_device(dev);\
> +       unsigned long long val;\
> +       acpi_status status;\
> +\
> +       status =3D acpi_evaluate_integer(acpi_dev->handle, #object,\
> +                                      NULL, &val);\
> +       if (ACPI_SUCCESS(status))\
> +               return sprintf(buf, "%llu\n", val);\
> +       else\
> +               return -EINVAL;\
> +}
> +
> +DPTF_POWER_SHOW(max_platform_power, PMAX)
> +DPTF_POWER_SHOW(platform_power_source, PSRC)
> +DPTF_POWER_SHOW(adapter_rating, ARTG)
> +DPTF_POWER_SHOW(charger_type, CTYP)
> +DPTF_POWER_SHOW(battery_steady_power, PBSS)
> +DPTF_POWER_SHOW(power_sampling_period, DPSP)
> +
> +
> +static DEVICE_ATTR_RO(max_platform_power);
> +static DEVICE_ATTR_RO(platform_power_source);
> +static DEVICE_ATTR_RO(adapter_rating);
> +static DEVICE_ATTR_RO(battery_steady_power);
> +static DEVICE_ATTR_RO(power_sampling_period);
> +static DEVICE_ATTR_RO(charger_type);
> +
> +static struct attribute *dptf_power_attrs[] =3D {
> +       &dev_attr_max_platform_power.attr,
> +       &dev_attr_platform_power_source.attr,
> +       &dev_attr_adapter_rating.attr,
> +       &dev_attr_charger_type.attr,
> +       &dev_attr_battery_steady_power.attr,
> +       &dev_attr_power_sampling_period.attr,
> +       NULL
> +};
> +
> +static struct attribute_group dptf_power_attribute_group =3D {
> +       .attrs =3D dptf_power_attrs,
> +       .name =3D "dptf_power"
> +};
> +
> +struct platform_device *dptf_power_pdev;
> +
> +static void dptf_power_notify(acpi_handle handle, u32 event, void *d=
ata)
> +{
> +       struct acpi_device *device =3D data;
> +
> +       acpi_battery_common_notify(device, event);
> +}
> +
> +static int dptf_power_init(struct platform_device *pdev)
> +{
> +       struct acpi_device *acpi_dev;
> +       acpi_status status;
> +       unsigned long long ptype;
> +       int result;
> +
> +       acpi_dev =3D ACPI_COMPANION(&(pdev->dev));
> +       if (!acpi_dev)
> +               return -ENODEV;

Since acpi_battery is an ACPI driver, it will bind to acpi_dev
directly, so I guess this should check if there's a driver bound to
acpi_dev and bail out if so, shouldn't it?

> +
> +       status =3D acpi_evaluate_integer(acpi_dev->handle, "PTYP", NU=
LL, &ptype);
> +       if (ACPI_FAILURE(status))
> +               return -ENODEV;
> +
> +       if (ptype !=3D 0x11)
> +               return -ENODEV;
> +
> +
> +       result =3D acpi_battery_common_add(acpi_dev);
> +       if (result)
> +               return result;
> +
> +       result =3D sysfs_create_group(&acpi_dev->dev.kobj,
> +                                   &dptf_power_attribute_group);
> +       if (result)
> +               goto error_remove_battery;
> +
> +       result =3D acpi_install_notify_handler(acpi_dev->handle,
> +                                            ACPI_DEVICE_NOTIFY,
> +                                            dptf_power_notify,
> +                                            (void *)acpi_dev);
> +       if (result)
> +               goto error_remove_sysfs;
> +
> +       platform_set_drvdata(pdev, acpi_dev);
> +
> +       return 0;
> +
> +error_remove_sysfs:
> +       sysfs_remove_group(&acpi_dev->dev.kobj, &dptf_power_attribute=
_group);
> +error_remove_battery:
> +       acpi_battery_common_remove(acpi_dev);
> +
> +       return result;
> +}
> +
> +static void dptf_power_init_work_fn(struct work_struct *work)
> +{
> +       if (!battery_registered)
> +               dptf_power_init(dptf_power_pdev);
> +}
> +
> +static DECLARE_DELAYED_WORK(dptf_power_init_work, dptf_power_init_wo=
rk_fn);
> +
> +static int dptf_power_add(struct platform_device *pdev)
> +{
> +       int ret =3D 0;
> +
> +#if IS_ENABLED(CONFIG_ACPI_BATTERY)
> +       /* Wait for battery driver to initialize and register for 100=
ms */

Do we really need to wait?  It looks like acpi_battery would be a
fallback driver for this one, so why wait?

> +       dptf_power_pdev =3D pdev;
> +       schedule_delayed_work(&dptf_power_init_work, msecs_to_jiffies=
(100));
> +#else
> +       ret =3D dptf_power_init(pdev);
> +#endif
> +       return ret;
> +}
> +
> +static int dptf_power_remove(struct platform_device *pdev)
> +{
> +       struct acpi_device *acpi_dev =3D platform_get_drvdata(pdev);
> +
> +#if defined(CONFIG_ACPI_BATTERY)
> +       cancel_delayed_work_sync(&dptf_power_init_work);
> +#endif
> +       if (!acpi_dev)
> +               return 0;
> +
> +       acpi_remove_notify_handler(acpi_dev->handle, ACPI_DEVICE_NOTI=
=46Y,
> +                                  dptf_power_notify);
> +       sysfs_remove_group(&acpi_dev->dev.kobj, &dptf_power_attribute=
_group);
> +       acpi_battery_common_remove(acpi_dev);
> +
> +       return 0;
> +}
> +
> +static const struct acpi_device_id int3407_device_ids[] =3D {
> +       {"INT3407", 0},
> +       {"", 0},
> +};
> +MODULE_DEVICE_TABLE(acpi, int3407_device_ids);
> +
> +static struct platform_driver dptf_power_driver =3D {
> +       .probe =3D dptf_power_add,
> +       .remove =3D dptf_power_remove,
> +       .driver =3D {
> +               .name =3D "DPTF Platform Power",
> +               .acpi_match_table =3D int3407_device_ids,
> +       },
> +};
> +
> +module_platform_driver(dptf_power_driver);
> +
> +MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.=
com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ACPI DPTF platform power driver");
> --
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
