From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH]  do not select ACPI_VIDEO in poulsbo stub driver
Date: Wed, 17 Nov 2010 08:42:09 +0800
Message-ID: <1289954529.8148.2089.camel@rui>
References: <4CE2CE980200002300023F13@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34340 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757319Ab0KQAk1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Nov 2010 19:40:27 -0500
In-Reply-To: <4CE2CE980200002300023F13@novprvlin0050.provo.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: "mingo@elte.hu" <mingo@elte.hu>, "lenb@kernel.org" <lenb@kernel.org>, "airlied@redhat.com" <airlied@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 2010-11-16 at 15:34 +0800, Joey Lee wrote:
> Hi Rui,=20
>=20
> Sorry about this patch will not work on my MSi poulsbo machine.
>=20
> =E6=96=BC =E4=BA=8C=EF=BC=8C2010-11-16 =E6=96=BC 14:04 +0800=EF=BC=8C=
Zhang Rui =E6=8F=90=E5=88=B0=EF=BC=9A
> > the poulsbo stub driver should not select ACPI video driver.
> >=20
> > The reason why i915 driver selects ACPI video driver is that it nee=
ds some
> > cooperation between these two drivers during initialization, or els=
e the
> > system may hang.
> >=20
> > So if users want ACPI backlight control, please set CONFIG_ACPI_VID=
EO manually.
> >=20
> > http://marc.info/?l=3Dlinux-acpi&m=3D128952659018533&w=3D2
> >=20
> > CC: Ingo Molnar <mingo@elte.hu>
> > CC: Dave Airlie <airlied@redhat.com>
> > CC: Lee, Chun-Yi <joeyli.kernel@gmail.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/gpu/stub/Kconfig   |   11 +----------
> >  drivers/gpu/stub/poulsbo.c |    5 +----
> >  2 files changed, 2 insertions(+), 14 deletions(-)
> >=20
> > Index: linux-2.6/drivers/gpu/stub/Kconfig
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/gpu/stub/Kconfig
> > +++ linux-2.6/drivers/gpu/stub/Kconfig
> > @@ -1,16 +1,7 @@
> >  config STUB_POULSBO
> >  	tristate "Intel GMA500 Stub Driver"
> >  	depends on PCI
> > -	# Poulsbo stub depends on ACPI_VIDEO when ACPI is enabled
> > -	# but for select to work, need to select ACPI_VIDEO's dependencie=
s, ick
> > -	select VIDEO_OUTPUT_CONTROL if ACPI
> > -	select BACKLIGHT_CLASS_DEVICE if ACPI
> > -	select INPUT if ACPI
> > -	select ACPI_VIDEO if ACPI
> >  	help
> >  	  Choose this option if you have a system that has Intel GMA500
> >  	  (Poulsbo) integrated graphics. If M is selected, the module wil=
l
> > -	  be called Poulsbo. This driver is a stub driver for Poulsbo tha=
t
> > -	  will call poulsbo.ko to enable the acpi backlight control sysfs
> > -	  entry file because there have no poulsbo native driver can supp=
ort
> > -	  intel opregion.
> > +	  be called Poulsbo.
> > Index: linux-2.6/drivers/gpu/stub/poulsbo.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/gpu/stub/poulsbo.c
> > +++ linux-2.6/drivers/gpu/stub/poulsbo.c
> > @@ -11,8 +11,6 @@
> > =20
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> > -#include <linux/acpi.h>
> > -#include <acpi/video.h>
> > =20
> >  #define DRIVER_NAME "poulsbo"
> > =20
> > @@ -29,12 +27,11 @@ static DEFINE_PCI_DEVICE_TABLE(pciidlist
> > =20
> >  static int poulsbo_probe(struct pci_dev *pdev, const struct pci_de=
vice_id *id)
> >  {
> > -	return acpi_video_register();
> > +	return 0;
> >  }
>=20
> Sorry, we cann't remove to call acpi_video_register, because the acpi
> video will not generate because there have some poulsbo machine decla=
re
> Intel opregion in DSDT but the i915 driver not support poulsbo.
>=20
I'm confused.
It's the i915 driver that supports Intel Opregion.
i.e. for a poulsbo machine with Intel Opregion, loading ACPI video
driver won't help neither.

> That's why we add the poulsbo stub driver to enable the acpi video
> because those machine implement acpi _BCL, _BCM interace and control
> brightness by ec.

I got your idea.
I'm not sure if this is right. IMO, the graphics driver and ACPI video
driver are independent. I mean, to enable the ACPI backlight control,
users should set CONFIG_ACPI_VIDEO explicitly.

And again, the reason why i915 driver selects ACPI_VIDEO is that the
i915 Opregion code must run *before* ACPI video driver loaded, or else
system hangs on some machines.
and the reason why DRM_NOUVEAU selects ACPI_VIDEO is that it depends on
ACPI to get the EDID info.

So I don't see a strong reason that STUB_POULSBO should select
ACPI_VIDEO.

thanks,
rui
>=20
> Here is our discussion:
> 	http://www.spinics.net/lists/linux-acpi/msg30027.html
>=20
> > =20
> >  static void poulsbo_remove(struct pci_dev *pdev)
> >  {
> > -	acpi_video_unregister();
> >  }
> > =20
> >  static struct pci_driver poulsbo_driver =3D {
> >=20
> >=20
>=20
> I am sorry I miss understand your last mail for poulsbo stub driver
> cann't dependency on input, because your patch is old.
>=20
> The following is the newest patch that was send out by me:
>=20
>=20
> >From 340b1068b20cfa152ff9992a7d69d19501b57163 Mon Sep 17 00:00:00 20=
01
> From: Lee, Chun-Yi <jlee@novell.com>
> Date: Wed, 15 Sep 2010 22:19:25 +0800
> Subject: [PATCH] Add Intel GMA500(Poulsbo) Stub Driver
>=20
> Currently, there have no GMA500(Poulsbo) native video driver to suppo=
rt
> intel opregion. So, use this stub driver to enable the acpi backlight
> control sysfs entry files by requrest acpi_video_register.
>=20
> Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
> ---
>  drivers/gpu/Makefile       |    2 +-
>  drivers/gpu/stub/Kconfig   |   13 +++++++++
>  drivers/gpu/stub/Makefile  |    1 +
>  drivers/gpu/stub/poulsbo.c |   63 ++++++++++++++++++++++++++++++++++=
++++++++++
>  drivers/video/Kconfig      |    2 +
>  5 files changed, 80 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/gpu/stub/Kconfig
>  create mode 100644 drivers/gpu/stub/Makefile
>  create mode 100644 drivers/gpu/stub/poulsbo.c
>=20
> diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
> index 30879df..cc92778 100644
> --- a/drivers/gpu/Makefile
> +++ b/drivers/gpu/Makefile
> @@ -1 +1 @@
> -obj-y			+=3D drm/ vga/
> +obj-y			+=3D drm/ vga/ stub/
> diff --git a/drivers/gpu/stub/Kconfig b/drivers/gpu/stub/Kconfig
> new file mode 100644
> index 0000000..8f5a540
> --- /dev/null
> +++ b/drivers/gpu/stub/Kconfig
> @@ -0,0 +1,13 @@
> +config STUB_POULSBO
> +	tristate "Intel GMA500 Stub Driver"
> +	depends on PCI
> +        # Poulsbo stub depends on ACPI_VIDEO when ACPI is enabled
> +        # but for select to work, need to select ACPI_VIDEO's depend=
encies, ick
> +        select ACPI_VIDEO if ACPI
> +	help
> +	  Choose this option if you have a system that has Intel GMA500
> +	  (Poulsbo) integrated graphics. If M is selected, the module will
> +	  be called Poulsbo. This driver is a stub driver for Poulsbo that
> +	  will call poulsbo.ko to enable the acpi backlight control sysfs
> +	  entry file because there have no poulsbo native driver can suppor=
t
> +	  intel opregion.
> diff --git a/drivers/gpu/stub/Makefile b/drivers/gpu/stub/Makefile
> new file mode 100644
> index 0000000..cd940cc
> --- /dev/null
> +++ b/drivers/gpu/stub/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_STUB_POULSBO) +=3D poulsbo.o
> diff --git a/drivers/gpu/stub/poulsbo.c b/drivers/gpu/stub/poulsbo.c
> new file mode 100644
> index 0000000..d8aa636
> --- /dev/null
> +++ b/drivers/gpu/stub/poulsbo.c
> @@ -0,0 +1,63 @@
> +/*
> + * Intel Poulsbo Stub driver
> + *
> + * Copyright (C) 2010 Novell <jlee@novell.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License version 2 as pu=
blished by
> + * the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <acpi/video.h>
> +
> +#define DRIVER_NAME "poulsbo"
> +
> +enum {
> +	CHIP_PSB_8108 =3D 0,
> +	CHIP_PSB_8109 =3D 1,
> +};
> +
> +static struct pci_device_id pciidlist[] =3D {
> +	{0x8086, 0x8108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_PSB_8108}, \
> +	{0x8086, 0x8109, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_PSB_8109}, \
> +	{0, 0, 0}
> +};
> +
> +static int poulsbo_probe(struct pci_dev *pdev, const struct pci_devi=
ce_id *id)
> +{
> +	return acpi_video_register();
> +}
> +
> +static void poulsbo_remove(struct pci_dev *pdev)
> +{
> +	acpi_video_unregister();
> +}
> +
> +static struct pci_driver poulsbo_driver =3D {
> +	.name =3D DRIVER_NAME,
> +	.id_table =3D pciidlist,
> +	.probe =3D poulsbo_probe,
> +	.remove =3D poulsbo_remove,
> +};
> +
> +static int __init poulsbo_init(void)
> +{
> +	return pci_register_driver(&poulsbo_driver);
> +}
> +
> +static void __exit poulsbo_exit(void)
> +{
> +	pci_unregister_driver(&poulsbo_driver);
> +}
> +
> +module_init(poulsbo_init);
> +module_exit(poulsbo_exit);
> +
> +MODULE_AUTHOR("Lee, Chun-Yi <jlee@novell.com>");
> +MODULE_DESCRIPTION("Poulsbo Stub Driver");
> +MODULE_LICENSE("GPL");
> +
> +MODULE_DEVICE_TABLE(pci, pciidlist);
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 8b31fdf..8807ae5 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -17,6 +17,8 @@ source "drivers/gpu/vga/Kconfig"
> =20
>  source "drivers/gpu/drm/Kconfig"
> =20
> +source "drivers/gpu/stub/Kconfig"
> +
>  config VGASTATE
>         tristate
>         default n


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
