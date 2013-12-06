From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] SFI: fix compilation warnings
Date: Fri, 06 Dec 2013 02:25:33 +0100
Message-ID: <1419818.3DzaCCe02K@vostro.rjw.lan>
References: <1386264397-27319-1-git-send-email-andriy.shevchenko@linux.intel.com> <4771886.zcelg2hCiB@vostro.rjw.lan> <1AE640813FDE7649BE1B193DEA596E8802494B32@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59958 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751601Ab3LFBMd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Dec 2013 20:12:33 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802494B32@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Friday, December 06, 2013 01:08:45 AM Zheng, Lv wrote:
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: Friday, December 06, 2013 6:37 AM
> >=20
> > On Thursday, December 05, 2013 07:26:37 PM Andy Shevchenko wrote:
> > > When build kernel with make W=3D1 we get the following compiler e=
rror.
> > >
> > > In file included from drivers/sfi/sfi_acpi.c:66:0:
> > > include/linux/sfi_acpi.h: In function =E2=80=98acpi_sfi_table_par=
se=E2=80=99:
> > > include/linux/sfi_acpi.h:72:2: error: implicit declaration of fun=
ction =E2=80=98acpi_table_parse=E2=80=99 [-Werror=3Dimplicit-function-d=
eclaration]
> > >   if (!acpi_table_parse(signature, handler))
> > >   ^
> > >   cc1: some warnings being treated as errors
> > >
> > > The patch changes acpi/acpi.h inclusion to linux/acpi.h.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com=
>
> >=20
> > OK
> >=20
> > Lv, I'm dropping your patch cleaning up the inclusions, please sort=
 that thing
> > out entirely for the next cycle.
>=20
> No, I think Andy's patch is wrong.

His patch may be wrong, but the warning in his changelog surely is real=
=2E :-)

> This warning is existing before merging my fixes.
>=20
> Either we fix this warning or leave it as is.
>=20
> To fix it, you need to add 1 line in sfi_acpi.h rather than change th=
e line.
> Let me post a fix for this.

Please do.  And I'm putting all ACPI header cleanups on hold until all =
warnings
of this kind have been fixed by them.  Otherwise doing those cleanups m=
akes a
little sense in my opinion.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
