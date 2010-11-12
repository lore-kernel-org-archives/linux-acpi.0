From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH] Add Intel GMA500(Poulsbo) Stub Driver
Date: Thu, 11 Nov 2010 18:49:40 -0700
Message-ID: <4CDD37E40200002300023BFA@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rui.zhang@intel.com
Cc: eric@anholt.net, chris@chris-wilson.co.uk, alexdeucher@gmail.com, lenb@kernel.org, airlied@linux.ie, dri-devel@lists.freedesktop.org, randy.dunlap@oracle.com, airlied@redhat.com, bskeggs@redhat.com, mjg59@srcf.ucam.org, gregkh@suse.de, trenn@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu, Dennis.Jansen@web.de

Hi Rui,=20

=46irst, thank's for your review and take care.

=E6=96=BC =E4=BA=94=EF=BC=8C2010-11-12 =E6=96=BC 09:31 +0800=EF=BC=8CZh=
ang Rui =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi, Lee,
>=20
> there are several regressions caused by this patch,
> http://marc.info/?l=3Dlinux-acpi&m=3D128872402020412&w=3D2
> http://marc.info/?l=3Dlinux-acpi&m=3D128858111022621&w=3D2
>=20
> Yes, We can fix it by "select INPUT if ACPI"/"select
> VIDEO_OUTPUT_CONTROL if ACPI".
> But IMO,  STUB_POULSBO should not select ACPI_VIDEO at all,
> what do you think?
>=20

Yes, I agreed.

We can just remove the _select ACPI_VIDEO if ACPI_ because user should
select it when they want to use.
If CONFIG_ACPI_VIDEO doesn't select, the stub poulsbo just do _not_
thing but will have no any bad thing.

So, let's direct remove it from Kconfig. Should I submit patch again?


Thank's
Joey Lee

> thanks,
> rui
>=20
> On Wed, 2010-11-03 at 09:19 +0800, Zhang Rui wrote:
> > Hi, Lee,
> >=20
> > Sorry I missed this thread.
> >=20
> > On Wed, 2010-10-20 at 13:51 +0800, Lee, Chun-Yi wrote:
> > > Currently, there have no GMA500(Poulsbo) native video driver to s=
upport
> > > intel opregion. So, use this stub driver to enable the acpi backl=
ight
> > > control sysfs entry files by requrest acpi_video_register.
> > >=20
> > If you want the acpi backlight control, why not set CONFIG_ACPI_VID=
EO
> > driver directly?
> > The reason why i915 driver selects ACPI_VIDEO is that it needs some
> > cooperation between these two drivers during initialization, or els=
e the
> > system may hang.
> >=20
> > thanks,
> > rui
> >=20
> > > Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
> > > ---
> > >  drivers/gpu/Makefile       |    2 +-
> > >  drivers/gpu/stub/Kconfig   |   13 +++++++++
> > >  drivers/gpu/stub/Makefile  |    1 +
> > >  drivers/gpu/stub/poulsbo.c |   63 ++++++++++++++++++++++++++++++=
++++++++++++++
> > >  drivers/video/Kconfig      |    2 +
> > >  5 files changed, 80 insertions(+), 1 deletions(-)
> > >  create mode 100644 drivers/gpu/stub/Kconfig
> > >  create mode 100644 drivers/gpu/stub/Makefile
> > >  create mode 100644 drivers/gpu/stub/poulsbo.c
> > >=20
> > > diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
> > > index 30879df..cc92778 100644
> > > --- a/drivers/gpu/Makefile
> > > +++ b/drivers/gpu/Makefile
> > > @@ -1 +1 @@
> > > -obj-y			+=3D drm/ vga/
> > > +obj-y			+=3D drm/ vga/ stub/
> > > diff --git a/drivers/gpu/stub/Kconfig b/drivers/gpu/stub/Kconfig
> > > new file mode 100644
> > > index 0000000..8f5a540
> > > --- /dev/null
> > > +++ b/drivers/gpu/stub/Kconfig
> > > @@ -0,0 +1,13 @@
> > > +config STUB_POULSBO
> > > +	tristate "Intel GMA500 Stub Driver"
> > > +	depends on PCI
> > > +        # Poulsbo stub depends on ACPI_VIDEO when ACPI is enable=
d
> > > +        # but for select to work, need to select ACPI_VIDEO's de=
pendencies, ick
> > > +        select ACPI_VIDEO if ACPI
> > > +	help
> > > +	  Choose this option if you have a system that has Intel GMA500
> > > +	  (Poulsbo) integrated graphics. If M is selected, the module w=
ill
> > > +	  be called Poulsbo. This driver is a stub driver for Poulsbo t=
hat
> > > +	  will call poulsbo.ko to enable the acpi backlight control sys=
fs
> > > +	  entry file because there have no poulsbo native driver can su=
pport
> > > +	  intel opregion.
> > > diff --git a/drivers/gpu/stub/Makefile b/drivers/gpu/stub/Makefil=
e
> > > new file mode 100644
> > > index 0000000..cd940cc
> > > --- /dev/null
> > > +++ b/drivers/gpu/stub/Makefile
> > > @@ -0,0 +1 @@
> > > +obj-$(CONFIG_STUB_POULSBO) +=3D poulsbo.o
> > > diff --git a/drivers/gpu/stub/poulsbo.c b/drivers/gpu/stub/poulsb=
o.c
> > > new file mode 100644
> > > index 0000000..d8aa636
> > > --- /dev/null
> > > +++ b/drivers/gpu/stub/poulsbo.c
> > > @@ -0,0 +1,63 @@
> > > +/*
> > > + * Intel Poulsbo Stub driver
> > > + *
> > > + * Copyright (C) 2010 Novell <jlee@novell.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or=
 modify it
> > > + * under the terms of the GNU General Public License version 2 a=
s published by
> > > + * the Free Software Foundation.
> > > + *
> > > + */
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/pci.h>
> > > +#include <acpi/video.h>
> > > +
> > > +#define DRIVER_NAME "poulsbo"
> > > +
> > > +enum {
> > > +	CHIP_PSB_8108 =3D 0,
> > > +	CHIP_PSB_8109 =3D 1,
> > > +};
> > > +
> > > +static struct pci_device_id pciidlist[] =3D {
> > > +	{0x8086, 0x8108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_PSB_8108}, =
\
> > > +	{0x8086, 0x8109, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_PSB_8109}, =
\
> > > +	{0, 0, 0}
> > > +};
> > > +
> > > +static int poulsbo_probe(struct pci_dev *pdev, const struct pci_=
device_id *id)
> > > +{
> > > +	return acpi_video_register();
> > > +}
> > > +
> > > +static void poulsbo_remove(struct pci_dev *pdev)
> > > +{
> > > +	acpi_video_unregister();
> > > +}
> > > +
> > > +static struct pci_driver poulsbo_driver =3D {
> > > +	.name =3D DRIVER_NAME,
> > > +	.id_table =3D pciidlist,
> > > +	.probe =3D poulsbo_probe,
> > > +	.remove =3D poulsbo_remove,
> > > +};
> > > +
> > > +static int __init poulsbo_init(void)
> > > +{
> > > +	return pci_register_driver(&poulsbo_driver);
> > > +}
> > > +
> > > +static void __exit poulsbo_exit(void)
> > > +{
> > > +	pci_unregister_driver(&poulsbo_driver);
> > > +}
> > > +
> > > +module_init(poulsbo_init);
> > > +module_exit(poulsbo_exit);
> > > +
> > > +MODULE_AUTHOR("Lee, Chun-Yi <jlee@novell.com>");
> > > +MODULE_DESCRIPTION("Poulsbo Stub Driver");
> > > +MODULE_LICENSE("GPL");
> > > +
> > > +MODULE_DEVICE_TABLE(pci, pciidlist);
> > > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > > index 8b31fdf..8807ae5 100644
> > > --- a/drivers/video/Kconfig
> > > +++ b/drivers/video/Kconfig
> > > @@ -17,6 +17,8 @@ source "drivers/gpu/vga/Kconfig"
> > > =20
> > >  source "drivers/gpu/drm/Kconfig"
> > > =20
> > > +source "drivers/gpu/stub/Kconfig"
> > > +
> > >  config VGASTATE
> > >         tristate
> > >         default n
> >=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
