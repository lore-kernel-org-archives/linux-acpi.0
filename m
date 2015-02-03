From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3] acpi:apd:add AMD ACPI2Platform device support for x86 system.
Date: Tue, 03 Feb 2015 23:07:59 +0100
Message-ID: <1856062.BZP7yNCLav@vostro.rjw.lan>
References: <1422928460.2528.16.camel@kxue-X58A-UD3R> <CAHp75Vd9fEJkFw50Ri4gzQwUHo4=Y2jKz4SOURsod1OrhH5sdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57445 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1161248AbbBCVpF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Feb 2015 16:45:05 -0500
In-Reply-To: <CAHp75Vd9fEJkFw50Ri4gzQwUHo4=Y2jKz4SOURsod1OrhH5sdw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Ken Xue <Ken.Xue@amd.com>
Cc: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tuesday, February 03, 2015 12:06:06 PM Andy Shevchenko wrote:
> On Tue, Feb 3, 2015 at 3:54 AM, Ken Xue <Ken.Xue@amd.com> wrote:
> > This new feature is to interpret AMD specific ACPI device to
> > platform device such as I2C, UART found on AMD CZ and later chipset=
s. It
> > based on example intel LPSS. Now, it can support AMD I2C & UART.
> >
>=20
> Few minor things below.
> Be free to fix in depend on what Mika and Rafael confirm.
>=20
> Anyway,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks Andy!

Ken, please address the Andy's comments given below, they all make sens=
e to me.

> > Signed-off-by: Ken Xue <Ken.Xue@amd.com>
> > ---
> >  arch/x86/Kconfig        |  11 +++
> >  drivers/acpi/Makefile   |   2 +-
> >  drivers/acpi/acpi_apd.c | 201 ++++++++++++++++++++++++++++++++++++=
++++++++++++
> >  drivers/acpi/internal.h |   2 +
> >  drivers/acpi/scan.c     |   1 +
> >  5 files changed, 216 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/acpi/acpi_apd.c
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 0dc9d01..ddf8d42 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -496,6 +496,17 @@ config X86_INTEL_LPSS
> >           things like clock tree (common clock framework) and pinco=
ntrol
> >           which are needed by the LPSS peripheral drivers.
> >
> > +config X86_AMD_PLATFORM_DEVICE
> > +       bool "AMD ACPI2Platform devices support"
> > +       depends on ACPI
> > +       select COMMON_CLK
> > +       select PINCTRL
> > +       ---help---
> > +         Select to interpret AMD specific ACPI device to platform =
device
> > +         such as I2C, UART found on AMD Carrizo and later chipsets=
=2E Selecting
> > +         this option enables things like clock tree (common clock =
framework)
> > +         and pinctrl.
>=20
> Sounds 'like' is redundant here. It explicitly enables common clock
> and pin control frameworks.
>=20
> > +
> >  config IOSF_MBI
> >         tristate "Intel SoC IOSF Sideband support for SoC platforms=
"
> >         depends on PCI
> > diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> > index f74317c..0071141 100644
> > --- a/drivers/acpi/Makefile
> > +++ b/drivers/acpi/Makefile
> > @@ -40,7 +40,7 @@ acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) +=3D proc=
essor_pdc.o
> >  acpi-y                         +=3D ec.o
> >  acpi-$(CONFIG_ACPI_DOCK)       +=3D dock.o
> >  acpi-y                         +=3D pci_root.o pci_link.o pci_irq.=
o
> > -acpi-y                         +=3D acpi_lpss.o
> > +acpi-y                         +=3D acpi_lpss.o acpi_apd.o
> >  acpi-y                         +=3D acpi_platform.o
> >  acpi-y                         +=3D acpi_pnp.o
> >  acpi-y                         +=3D int340x_thermal.o
> > diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> > new file mode 100644
> > index 0000000..b27bc1c
> > --- /dev/null
> > +++ b/drivers/acpi/acpi_apd.c
> > @@ -0,0 +1,201 @@
> > +/*
> > + * AMD ACPI support for ACPI2platform device.
> > + *
> > + * Copyright (c) 2014,2015 AMD Corporation.
> > + * Authors: Ken Xue <Ken.Xue@amd.com>
> > + *     Wu, Jeff <Jeff.Wu@amd.com>
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License version 2 =
as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/clkdev.h>
> > +#include <linux/acpi.h>
> > +#include <linux/err.h>
> > +#include <linux/clk.h>
> > +#include <linux/pm.h>
> > +
> > +#include "internal.h"
> > +
> > +ACPI_MODULE_NAME("acpi_apd");
> > +struct apd_private_data;
> > +
> > +/**
>=20
> /*, or use description on per flag basis.
>=20
> > + * device flags of acpi_apd_dev_desc.
> > + * ACPI_APD_SYSFS : add device attributes in sysfs
> > + * ACPI_APD_PM : attach power domain to device
> > + * ACPI_APD_PM_ON : power on device when attach power domain
> > + */
> > +#define ACPI_APD_SYSFS BIT(0)
> > +#define ACPI_APD_PM    BIT(1)
> > +#define ACPI_APD_PM_ON BIT(2)
> > +
> > +/**
> > + * struct apd_device_desc - a descriptor for apd device
> > + * @flags: device flags like ACPI_APD_SYSFS ACPI_APD_PM ACPI_APD_P=
M_ON
>=20
> %ACPI_APD_SYSFS, %ACPI_APD_PM, %ACPI_APD_APM_ON.
>=20
> Could it be combination? State this explicitly.
>=20
> > + * @fixed_clk_rate: fixed rate input clock source for acpi device;
> > + *                     0 means no fixed rate input clock source
> > + * @setup: a hook routine to set device resource during create pla=
tform device
> > + *
> > + * device description defined as acpi_device_id.driver_data
>=20
> d -> D
>=20
> > + */
> > +struct apd_device_desc {
> > +       unsigned int flags;
> > +       unsigned int fixed_clk_rate;
> > +       int (*setup)(struct apd_private_data *pdata);
> > +};
> > +
> > +struct apd_private_data {
> > +       struct clk *clk;
> > +       struct acpi_device *adev;
> > +       const struct apd_device_desc *dev_desc;
> > +};
> > +
> > +#ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
> > +#define APD_ADDR(desc) ((unsigned long)&desc)
> > +
> > +static int acpi_apd_setup(struct apd_private_data *pdata)
> > +{
> > +       const struct apd_device_desc *dev_desc =3D pdata->dev_desc;
> > +       struct clk *clk =3D ERR_PTR(-ENODEV);
> > +
> > +       if (dev_desc->fixed_clk_rate) {
> > +               clk =3D clk_register_fixed_rate(&pdata->adev->dev,
> > +                                       dev_name(&pdata->adev->dev)=
,
> > +                                       NULL, CLK_IS_ROOT,
> > +                                       dev_desc->fixed_clk_rate);
> > +               clk_register_clkdev(clk, NULL, dev_name(&pdata->ade=
v->dev));
> > +               pdata->clk =3D clk;
> > +       }
>=20
> What about
> if (!=E2=80=A6clk_rate)
>  return 0;
> =E2=80=A6
> return 0; ?
>=20
> And question why we need int to be returned at all?
>=20
> > +
> > +       return 0;
> > +}
> > +
> > +static struct apd_device_desc cz_i2c_desc =3D {
> > +       .setup =3D acpi_apd_setup,
> > +       .fixed_clk_rate =3D 133000000,
> > +};
> > +
> > +static struct apd_device_desc cz_uart_desc =3D {
> > +       .setup =3D acpi_apd_setup,
> > +       .fixed_clk_rate =3D 48000000,
> > +};
> > +
> > +#else
> > +
> > +#define APD_ADDR(desc) (0UL)
> > +
> > +#endif /* CONFIG_X86_AMD_PLATFORM_DEVICE */
> > +
> > +static int acpi_apd_create_device(struct acpi_device *adev,
> > +                                  const struct acpi_device_id *id)
> > +{
> > +       const struct apd_device_desc *dev_desc;
> > +       struct apd_private_data *pdata;
> > +       struct platform_device *pdev;
> > +       int ret;
> > +
> > +       dev_desc =3D (struct apd_device_desc *)id->driver_data;
>=20
> You may move this assignment to the definition block. And if it
> doesn't fit one line you may cast to (void *), though I don't know if
> Rafael likes such trick.
>=20
> > +       if (!dev_desc) {
> > +               pdev =3D acpi_create_platform_device(adev);
> > +               return IS_ERR_OR_NULL(pdev) ? PTR_ERR(pdev) : 1;
>=20
> I guess it worth to add a comment what means return code here.
>=20
> > +       }
> > +       pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);
> > +       if (!pdata)
> > +               return -ENOMEM;
> > +
> > +       pdata->adev =3D adev;
> > +       pdata->dev_desc =3D dev_desc;
> > +
> > +       if (dev_desc->setup) {
> > +               ret =3D dev_desc->setup(pdata);
> > +               if (ret)
> > +                       goto err_out;
> > +       }
> > +
> > +       adev->driver_data =3D pdata;
> > +       pdev =3D acpi_create_platform_device(adev);
> > +       if (!IS_ERR_OR_NULL(pdev))
> > +               return 1;
> > +
> > +       ret =3D PTR_ERR(pdev);
> > +       adev->driver_data =3D NULL;
> > +
> > + err_out:
> > +       kfree(pdata);
> > +       return ret;
> > +}
> > +
> > +static const struct acpi_device_id acpi_apd_device_ids[] =3D {
> > +       /* Generic apd devices */
> > +       { "AMD0010", APD_ADDR(cz_i2c_desc) },
> > +       { "AMD0020", APD_ADDR(cz_uart_desc) },
> > +       { }
> > +};
> > +
> > +#ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
> > +static int acpi_apd_platform_notify(struct notifier_block *nb,
> > +                                    unsigned long action, void *da=
ta)
> > +{
> > +       struct platform_device *pdev =3D to_platform_device(data);
> > +       const struct acpi_device_id *id =3D NULL;
>=20
> Redundant assignment.
>=20
> > +       struct apd_private_data *pdata;
> > +       struct acpi_device *adev;
> > +       bool power_on;
> > +       int ret;
> > +
> > +       id =3D acpi_match_device(acpi_apd_device_ids, &pdev->dev);
> > +       if (!id || !id->driver_data)
> > +               return 0;
> > +
> > +       if (acpi_bus_get_device(ACPI_HANDLE(&pdev->dev), &adev))
>=20
> Better of course to do like
> status =3D =E2=80=A6
> if (status) [don't remember how to check status with ACPI API]
>  return 0;
>=20
> > +               return 0;
> > +
> > +       pdata =3D acpi_driver_data(adev);
> > +       if (!pdata || !pdata->dev_desc)
> > +               return 0;
> > +
> > +       switch (action) {
> > +       case BUS_NOTIFY_ADD_DEVICE:
> > +               if (pdata->dev_desc->flags & ACPI_APD_PM) {
> > +                       power_on =3D !!(pdata->dev_desc->flags & AC=
PI_APD_PM_ON);
> > +                       ret =3D dev_pm_domain_attach(&pdev->dev, po=
wer_on);
> > +
> > +                       if (ret)
> > +                               dev_dbg(&pdev->dev,
> > +                               "failed to attached pm domain (%d)\=
n", ret);
> > +               }
> > +               break;
> > +       case BUS_NOTIFY_DEL_DEVICE:
> > +               if (pdata->dev_desc->flags & ACPI_APD_PM) {
> > +                       power_on =3D !!(pdata->dev_desc->flags & AC=
PI_APD_PM_ON);
> > +                       dev_pm_domain_detach(&pdev->dev, power_on);
> > +               }
> > +               break;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static struct notifier_block acpi_apd_nb =3D {
> > +       .notifier_call =3D acpi_apd_platform_notify,
> > +};
> > +#endif
> > +
> > +static struct acpi_scan_handler apd_handler =3D {
> > +       .ids =3D acpi_apd_device_ids,
> > +       .attach =3D acpi_apd_create_device,
> > +};
> > +
> > +void __init acpi_apd_init(void)
> > +{
> > +#ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
> > +       bus_register_notifier(&platform_bus_type, &acpi_apd_nb);
> > +#endif
> > +
> > +       acpi_scan_add_handler(&apd_handler);
> > +}
> > diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> > index 163e82f..c24ae9d 100644
> > --- a/drivers/acpi/internal.h
> > +++ b/drivers/acpi/internal.h
> > @@ -68,6 +68,8 @@ static inline void acpi_debugfs_init(void) { retu=
rn; }
> >  #endif
> >  void acpi_lpss_init(void);
> >
> > +void acpi_apd_init(void);
> > +
> >  acpi_status acpi_hotplug_schedule(struct acpi_device *adev, u32 sr=
c);
> >  bool acpi_queue_hotplug_work(struct work_struct *work);
> >  void acpi_device_hotplug(struct acpi_device *adev, u32 src);
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index dc4d896..bbca783 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -2544,6 +2544,7 @@ int __init acpi_scan_init(void)
> >         acpi_pci_link_init();
> >         acpi_processor_init();
> >         acpi_lpss_init();
> > +       acpi_apd_init();
> >         acpi_cmos_rtc_init();
> >         acpi_container_init();
> >         acpi_memory_hotplug_init();
> > --
> > 1.9.1
> >
> >
> >
>=20
>=20
>=20
>=20

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
