From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2, 3/7] ACPI / container: Use common hotplug code
Date: Wed, 27 Feb 2013 01:06:31 +0100
Message-ID: <1628702.MGgBQmm2Nl@vostro.rjw.lan>
References: <3260206.bhaAobGhpZ@vostro.rjw.lan> <2961608.xElddy7TSk@vostro.rjw.lan> <1361920386.12845.99.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361920386.12845.99.camel@misato.fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Jiang Liu <liuj97@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, February 26, 2013 04:13:06 PM Toshi Kani wrote:
> On Tue, 2013-02-26 at 23:46 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >=20
> > Switch the ACPI container driver to using common device hotplug cod=
e
> > introduced previously.  This reduces the driver down to a trivial
> > definition and registration of a struct acpi_scan_handler object.
> >=20
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/container.c |  146 +++-------------------------------=
-------------
> >  1 file changed, 10 insertions(+), 136 deletions(-)
> >=20
> > Index: test/drivers/acpi/container.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- test.orig/drivers/acpi/container.c
> > +++ test/drivers/acpi/container.c
> > @@ -1,12 +1,12 @@
> >  /*
> > - * acpi_container.c  - ACPI Generic Container Driver
> > - * ($Revision: )
> > + * container.c  - ACPI Generic Container Driver
> >   *
> >   * Copyright (C) 2004 Anil S Keshavamurthy (anil.s.keshavamurthy@i=
ntel.com)
> >   * Copyright (C) 2004 Keiichiro Tokunaga (tokunaga.keiich@jp.fujit=
su.com)
> >   * Copyright (C) 2004 Motoyuki Ito (motoyuki@soft.fujitsu.com)
> > - * Copyright (C) 2004 Intel Corp.
> >   * Copyright (C) 2004 FUJITSU LIMITED
> > + * Copyright (C) 2004, 2013 Intel Corp.
> > + * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >   *
> >   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
> >   *
> > @@ -26,14 +26,9 @@
> >   *
> >   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
> >   */
> > -#include <linux/kernel.h>
> > -#include <linux/module.h>
> > -#include <linux/init.h>
> > -#include <linux/slab.h>
> > -#include <linux/types.h>
> >  #include <linux/acpi.h>
> > -#include <acpi/acpi_bus.h>
> > -#include <acpi/acpi_drivers.h>
> > +
> > +#include "internal.h"
> > =20
> >  #define PREFIX "ACPI: "
> > =20
> > @@ -50,141 +45,20 @@ static const struct acpi_device_id conta
> >  static int container_device_attach(struct acpi_device *device,
> >  				   const struct acpi_device_id *not_used)
> >  {
> > -	/*
> > -	 * FIXME: This is necessary, so that acpi_eject_store() doesn't r=
eturn
> > -	 * -ENODEV for containers.
> > -	 */
> > +	/* This is necessary for container hotplug to work. */
> >  	return 1;
> >  }
> > =20
> >  static struct acpi_scan_handler container_device_handler =3D {
> >  	.ids =3D container_device_ids,
> >  	.attach =3D container_device_attach,
> > +	.hotplug =3D {
> > +		.enabled =3D true,
> > +		.user_eject =3D true,
>=20
> I am not able to compile this patch 3/7...  user_eject is not defined=
 in
> patch 2/7.
>=20
>   CC      drivers/acpi/container.o
> drivers/acpi/container.c:57:3: error: unknown field =E2=80=98user_eje=
ct=E2=80=99
> specified in initializer

I forgot the refresh the patch, sorry.  Will send an update shortly.

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
