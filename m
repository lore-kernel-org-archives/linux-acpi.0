From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] SFI: fix compilation warnings
Date: Thu, 05 Dec 2013 23:40:57 +0100
Message-ID: <2894493.n5DTvIrPJs@vostro.rjw.lan>
References: <1386264397-27319-1-git-send-email-andriy.shevchenko@linux.intel.com> <4771886.zcelg2hCiB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56408 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751252Ab3LEW15 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Dec 2013 17:27:57 -0500
In-Reply-To: <4771886.zcelg2hCiB@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Thursday, December 05, 2013 11:36:37 PM Rafael J. Wysocki wrote:
> On Thursday, December 05, 2013 07:26:37 PM Andy Shevchenko wrote:
> > When build kernel with make W=3D1 we get the following compiler err=
or.
> >=20
> > In file included from drivers/sfi/sfi_acpi.c:66:0:
> > include/linux/sfi_acpi.h: In function =E2=80=98acpi_sfi_table_parse=
=E2=80=99:
> > include/linux/sfi_acpi.h:72:2: error: implicit declaration of funct=
ion =E2=80=98acpi_table_parse=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]
> >   if (!acpi_table_parse(signature, handler))
> >   ^
> >   cc1: some warnings being treated as errors
> >=20
> > The patch changes acpi/acpi.h inclusion to linux/acpi.h.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> OK
>=20
> Lv, I'm dropping your patch cleaning up the inclusions, please sort t=
hat thing
> out entirely for the next cycle.

Or rather I'll keep it in bleeding-edge and wait for follow-up patches =
to
fix build problems like this one (then we can merge it into 3.14 hopefu=
lly).

Thanks!

> > ---
> >  drivers/sfi/sfi_acpi.c   | 2 +-
> >  include/linux/sfi_acpi.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/sfi/sfi_acpi.c b/drivers/sfi/sfi_acpi.c
> > index 0c9f419..d4dfcbe 100644
> > --- a/drivers/sfi/sfi_acpi.c
> > +++ b/drivers/sfi/sfi_acpi.c
> > @@ -60,7 +60,7 @@
> >  #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> > =20
> >  #include <linux/kernel.h>
> > -#include <acpi/acpi.h>	/* FIXME: inclusion should be removed */
> > +#include <linux/acpi.h>
> > =20
> >  #include <linux/sfi.h>
> >  #include <linux/sfi_acpi.h>
> > diff --git a/include/linux/sfi_acpi.h b/include/linux/sfi_acpi.h
> > index 2cfcb79..c9cab82 100644
> > --- a/include/linux/sfi_acpi.h
> > +++ b/include/linux/sfi_acpi.h
> > @@ -60,7 +60,7 @@
> >  #define _LINUX_SFI_ACPI_H
> > =20
> >  #ifdef CONFIG_SFI
> > -#include <acpi/acpi.h>	/* FIXME: inclusion should be removed */
> > +#include <linux/acpi.h>
> > =20
> >  extern int sfi_acpi_table_parse(char *signature, char *oem_id,
> >  				char *oem_table_id,
> >=20
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
