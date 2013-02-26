From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH v2, 3/7] ACPI / container: Use common hotplug code
Date: Tue, 26 Feb 2013 16:13:06 -0700
Message-ID: <1361920386.12845.99.camel@misato.fc.hp.com>
References: <3260206.bhaAobGhpZ@vostro.rjw.lan>
	 <3171747.TOMjvVkWL1@vostro.rjw.lan> <2961608.xElddy7TSk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:42601 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909Ab3BZXYC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Feb 2013 18:24:02 -0500
In-Reply-To: <2961608.xElddy7TSk@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Jiang Liu <liuj97@gmail.com>

On Tue, 2013-02-26 at 23:46 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Switch the ACPI container driver to using common device hotplug code
> introduced previously.  This reduces the driver down to a trivial
> definition and registration of a struct acpi_scan_handler object.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/container.c |  146 +++---------------------------------=
-----------
>  1 file changed, 10 insertions(+), 136 deletions(-)
>=20
> Index: test/drivers/acpi/container.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- test.orig/drivers/acpi/container.c
> +++ test/drivers/acpi/container.c
> @@ -1,12 +1,12 @@
>  /*
> - * acpi_container.c  - ACPI Generic Container Driver
> - * ($Revision: )
> + * container.c  - ACPI Generic Container Driver
>   *
>   * Copyright (C) 2004 Anil S Keshavamurthy (anil.s.keshavamurthy@int=
el.com)
>   * Copyright (C) 2004 Keiichiro Tokunaga (tokunaga.keiich@jp.fujitsu=
=2Ecom)
>   * Copyright (C) 2004 Motoyuki Ito (motoyuki@soft.fujitsu.com)
> - * Copyright (C) 2004 Intel Corp.
>   * Copyright (C) 2004 FUJITSU LIMITED
> + * Copyright (C) 2004, 2013 Intel Corp.
> + * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>   *
>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
>   *
> @@ -26,14 +26,9 @@
>   *
>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
>   */
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/slab.h>
> -#include <linux/types.h>
>  #include <linux/acpi.h>
> -#include <acpi/acpi_bus.h>
> -#include <acpi/acpi_drivers.h>
> +
> +#include "internal.h"
> =20
>  #define PREFIX "ACPI: "
> =20
> @@ -50,141 +45,20 @@ static const struct acpi_device_id conta
>  static int container_device_attach(struct acpi_device *device,
>  				   const struct acpi_device_id *not_used)
>  {
> -	/*
> -	 * FIXME: This is necessary, so that acpi_eject_store() doesn't ret=
urn
> -	 * -ENODEV for containers.
> -	 */
> +	/* This is necessary for container hotplug to work. */
>  	return 1;
>  }
> =20
>  static struct acpi_scan_handler container_device_handler =3D {
>  	.ids =3D container_device_ids,
>  	.attach =3D container_device_attach,
> +	.hotplug =3D {
> +		.enabled =3D true,
> +		.user_eject =3D true,

I am not able to compile this patch 3/7...  user_eject is not defined i=
n
patch 2/7.

  CC      drivers/acpi/container.o
drivers/acpi/container.c:57:3: error: unknown field =E2=80=98user_eject=
=E2=80=99
specified in initializer

-Toshi

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
