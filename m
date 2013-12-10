From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] SFI: fix compilation warnings
Date: Tue, 10 Dec 2013 14:07:32 +0200
Message-ID: <1386677252.1871.142.camel@smile>
References: <1386580161-27718-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1AE640813FDE7649BE1B193DEA596E88024969FB@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4224 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765Ab3LJMIa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Dec 2013 07:08:30 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88024969FB@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi @ vger . kernel . org" <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, 2013-12-10 at 01:30 +0000, Zheng, Lv wrote:
> Hi, Andy
>=20
> IMO:
> 1. sfi_acpi.h should include both <linux/acpi.h> and <linux/sfi.h> an=
d it should include <acpi/acpi.h> for !CONFIG_ACPI builds.
> 2. then we should include sfi_acpi.h instead of <linux/acpi.h>, <linu=
x/sfi.h> and <acpi/acpi.h> for all of its users.
>=20
> I think the patch in the linux-pm/bleeding-edge queue can fix the iss=
ue you've reported:
> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/comm=
it/?h=3Dbleeding-edge&id=3Dc099eacbcaec4475936fbf73e499507728ce47e1

I think so, I'll test this later.

Only one thing I don't like is the FIXME stuff in the sfi_acpi.h.
Could it be fixed as well?


>=20
> I made it a part of my header cleanup series.
> The story can be found in this mailing list thread:
> http://www.spinics.net/lists/linux-acpi/msg47510.html
>=20
> Thanks and best regards
> -Lv
>=20
>=20
> > -----Original Message-----
> > From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
> > Sent: Monday, December 09, 2013 5:09 PM
> > To: Wysocki, Rafael J; linux-acpi @ vger . kernel . org; LKML; Zhen=
g, Lv
> > Cc: Andy Shevchenko
> > Subject: [PATCH v2] SFI: fix compilation warnings
> >=20
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
> > The patch add linux/acpi.h to the top of file.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > Changes to v2:
> > - fix for build when ACPI=3Dn, SFI=3Dy
> >  drivers/sfi/sfi_acpi.c   | 2 +-
> >  include/linux/sfi_acpi.h | 4 +++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/sfi/sfi_acpi.c b/drivers/sfi/sfi_acpi.c
> > index 5e753d7..5589ec5 100644
> > --- a/drivers/sfi/sfi_acpi.c
> > +++ b/drivers/sfi/sfi_acpi.c
> > @@ -60,7 +60,7 @@
> >  #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> >=20
> >  #include <linux/kernel.h>
> > -#include <acpi/acpi.h>	/* FIXME: inclusion should be removed */
> > +#include <linux/acpi.h>
> >=20
> >  #include <linux/sfi.h>
> >  #include "sfi_core.h"
> > diff --git a/include/linux/sfi_acpi.h b/include/linux/sfi_acpi.h
> > index 2cfcb79..ecc2344 100644
> > --- a/include/linux/sfi_acpi.h
> > +++ b/include/linux/sfi_acpi.h
> > @@ -60,7 +60,9 @@
> >  #define _LINUX_SFI_ACPI_H
> >=20
> >  #ifdef CONFIG_SFI
> > -#include <acpi/acpi.h>	/* FIXME: inclusion should be removed */
> > +
> > +#include <acpi/acpi.h>
> > +#include <linux/acpi.h>
> >=20
> >  extern int sfi_acpi_table_parse(char *signature, char *oem_id,
> >  				char *oem_table_id,
> > --
> > 1.8.4.4
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
