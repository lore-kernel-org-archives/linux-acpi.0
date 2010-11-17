From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH]  do not select ACPI_VIDEO in poulsbo stub driver
Date: Wed, 17 Nov 2010 11:16:50 +0800
Message-ID: <1289963810.8148.2109.camel@rui>
References: <4CE3E0DE0200002300024037@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:26651 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753188Ab0KQDPK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Nov 2010 22:15:10 -0500
In-Reply-To: <4CE3E0DE0200002300024037@novprvlin0050.provo.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: "mingo@elte.hu" <mingo@elte.hu>, "lenb@kernel.org" <lenb@kernel.org>, "airlied@redhat.com" <airlied@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, 2010-11-17 at 11:04 +0800, Joey Lee wrote:
> Hi Rui,=20
>=20
> =E6=96=BC =E4=B8=89=EF=BC=8C2010-11-17 =E6=96=BC 08:42 +0800=EF=BC=8C=
Zhang Rui =E6=8F=90=E5=88=B0=EF=BC=9A
> > On Tue, 2010-11-16 at 15:34 +0800, Joey Lee wrote:
> > > Hi Rui,=20
> > >=20
> > > Sorry about this patch will not work on my MSi poulsbo machine.
> > >=20
> > > =E6=96=BC =E4=BA=8C=EF=BC=8C2010-11-16 =E6=96=BC 14:04 +0800=EF=BC=
=8CZhang Rui =E6=8F=90=E5=88=B0=EF=BC=9A
> > > > the poulsbo stub driver should not select ACPI video driver.
> > > >=20
> > > > The reason why i915 driver selects ACPI video driver is that it=
 needs some
> > > > cooperation between these two drivers during initialization, or=
 else the
> > > > system may hang.
> > > >=20
> > > > So if users want ACPI backlight control, please set CONFIG_ACPI=
_VIDEO manually.
> > > >=20
> > > > http://marc.info/?l=3Dlinux-acpi&m=3D128952659018533&w=3D2
> > > >=20
> > > > CC: Ingo Molnar <mingo@elte.hu>
> > > > CC: Dave Airlie <airlied@redhat.com>
> > > > CC: Lee, Chun-Yi <joeyli.kernel@gmail.com>
> > > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > > ---
> > > >  drivers/gpu/stub/Kconfig   |   11 +----------
> > > >  drivers/gpu/stub/poulsbo.c |    5 +----
> > > >  2 files changed, 2 insertions(+), 14 deletions(-)
> > > >=20
> > > > Index: linux-2.6/drivers/gpu/stub/Kconfig
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > --- linux-2.6.orig/drivers/gpu/stub/Kconfig
> > > > +++ linux-2.6/drivers/gpu/stub/Kconfig
> > > > @@ -1,16 +1,7 @@
> > > >  config STUB_POULSBO
> > > >  	tristate "Intel GMA500 Stub Driver"
> > > >  	depends on PCI
> > > > -	# Poulsbo stub depends on ACPI_VIDEO when ACPI is enabled
> > > > -	# but for select to work, need to select ACPI_VIDEO's depende=
ncies, ick
> > > > -	select VIDEO_OUTPUT_CONTROL if ACPI
> > > > -	select BACKLIGHT_CLASS_DEVICE if ACPI
> > > > -	select INPUT if ACPI
> > > > -	select ACPI_VIDEO if ACPI
> > > >  	help
> > > >  	  Choose this option if you have a system that has Intel GMA5=
00
> > > >  	  (Poulsbo) integrated graphics. If M is selected, the module=
 will
> > > > -	  be called Poulsbo. This driver is a stub driver for Poulsbo=
 that
> > > > -	  will call poulsbo.ko to enable the acpi backlight control s=
ysfs
> > > > -	  entry file because there have no poulsbo native driver can =
support
> > > > -	  intel opregion.
> > > > +	  be called Poulsbo.
> > > > Index: linux-2.6/drivers/gpu/stub/poulsbo.c
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > --- linux-2.6.orig/drivers/gpu/stub/poulsbo.c
> > > > +++ linux-2.6/drivers/gpu/stub/poulsbo.c
> > > > @@ -11,8 +11,6 @@
> > > > =20
> > > >  #include <linux/module.h>
> > > >  #include <linux/pci.h>
> > > > -#include <linux/acpi.h>
> > > > -#include <acpi/video.h>
> > > > =20
> > > >  #define DRIVER_NAME "poulsbo"
> > > > =20
> > > > @@ -29,12 +27,11 @@ static DEFINE_PCI_DEVICE_TABLE(pciidlist
> > > > =20
> > > >  static int poulsbo_probe(struct pci_dev *pdev, const struct pc=
i_device_id *id)
> > > >  {
> > > > -	return acpi_video_register();
> > > > +	return 0;
> > > >  }
> > >=20
> > > Sorry, we cann't remove to call acpi_video_register, because the =
acpi
> > > video will not generate because there have some poulsbo machine d=
eclare
> > > Intel opregion in DSDT but the i915 driver not support poulsbo.
> > >=20
> > I'm confused.
> > It's the i915 driver that supports Intel Opregion.
> > i.e. for a poulsbo machine with Intel Opregion, loading ACPI video
> > driver won't help neither.
> >=20
>=20
> Matthew have a patch:
>=20
>       * http://git.kernel.org/?p=3Dlinux/kernel/git/lenb/linux-acpi-2=
=2E6.git;a=3Dcommitdiff;h=3D74a365b3f354fafc537efa5867deb7a9fadbfe27
>=20
> This patch do:
>=20
> - ACPI video driver will not register if it check the DSDT have opreg=
ion table declare.
> - i915_opregion will call acpi_video_register after it initialised th=
e DIDL field in opregion.
>=20
> That means acpi video driver will blocked when have opregion declare =
in
> DSDT until i915 drm driver call acpi_video_register. The patch fixed
> BKO#11259, but introduced a side effect: If there have Intel video ch=
ip
> not supported by Intel drm driver, the acpi_video_register will never
> called, then some machine have good acpi backlight interface
> implementation will never have acpi brightness sysfs interface for
> userland control. e.g. any Poulsbo netbook.
>=20
> Matthew's comment to talk about the side effect: Intel IGD opregion a=
nd
> GMA500
>=20
> There have some machines declare opregion in DSDT but they also
> implement the backlight control by EC in _BCM. Like: MSI poulsbo
> netbook.
> Before introduce the above patch to kernel, those machine's acpi
> backlight control works fine. On current kernel, those machines
> backlight control broken.
>=20
> One function workable with old kernel but broken by new kernel, now.
>=20
Oh, I see what the problem is.
You're right, this patch doesn't make sense. Sorry for the noise. :)

thanks,
rui

>=20
> > > That's why we add the poulsbo stub driver to enable the acpi vide=
o
> > > because those machine implement acpi _BCL, _BCM interace and cont=
rol
> > > brightness by ec.
> >=20
> > I got your idea.
> > I'm not sure if this is right. IMO, the graphics driver and ACPI vi=
deo
> > driver are independent. I mean, to enable the ACPI backlight contro=
l,
> > users should set CONFIG_ACPI_VIDEO explicitly.
> >=20
> > And again, the reason why i915 driver selects ACPI_VIDEO is that th=
e
> > i915 Opregion code must run *before* ACPI video driver loaded, or e=
lse
> > system hangs on some machines.
> > and the reason why DRM_NOUVEAU selects ACPI_VIDEO is that it depend=
s on
> > ACPI to get the EDID info.
> >=20
>=20
> Yes, Matthew's patch fix this issue.=20
>=20
> > So I don't see a strong reason that STUB_POULSBO should select
> > ACPI_VIDEO.
> >=20
>=20
> Does it possible we direct remove the "select ACPI_VIDEO if ACPI" fro=
m
> Kconfig but keep the acpi_video_register function call in stub poulsb=
o
> driver?
> Because acpi/video.h already handle the ACPI VIDEO config check:
>=20
> #if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
> extern int acpi_video_register(void);
> extern void acpi_video_unregister(void);
> extern int acpi_video_get_edid(struct acpi_device *device, int type,
>                                int device_id, void **edid);
> #else
> static inline int acpi_video_register(void) { return 0; }
> static inline void acpi_video_unregister(void) { return; }
>=20
>=20
> Thank's a lot!
> Joey Lee
>=20
> > thanks,
> > rui
> > >=20
> > > Here is our discussion:
> > > 	http://www.spinics.net/lists/linux-acpi/msg30027.html
> > >=20
> > > > =20
> > > >  static void poulsbo_remove(struct pci_dev *pdev)
> > > >  {
> > > > -	acpi_video_unregister();
> > > >  }
> > > > =20
> > > >  static struct pci_driver poulsbo_driver =3D {
> > > >=20
> > > >=20
> > >=20
> > > I am sorry I miss understand your last mail for poulsbo stub driv=
er
> > > cann't dependency on input, because your patch is old.
> > >=20
> > > The following is the newest patch that was send out by me:
> > >=20
> > >=20
> > > >From 340b1068b20cfa152ff9992a7d69d19501b57163 Mon Sep 17 00:00:0=
0 2001
> > > From: Lee, Chun-Yi <jlee@novell.com>
> > > Date: Wed, 15 Sep 2010 22:19:25 +0800
> > > Subject: [PATCH] Add Intel GMA500(Poulsbo) Stub Driver
> > >=20
> > > Currently, there have no GMA500(Poulsbo) native video driver to s=
upport
> > > intel opregion. So, use this stub driver to enable the acpi backl=
ight
> > > control sysfs entry files by requrest acpi_video_register.
> > >=20
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
> > > +	depends on> > +        # Poulsbo stub depends on ACPI_VIDEO whe=
n ACPI is enabled
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
> >=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
