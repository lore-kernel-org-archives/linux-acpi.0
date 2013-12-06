From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] SFI: fix compilation warnings
Date: Fri, 06 Dec 2013 03:00:31 +0100
Message-ID: <1790293.cpW4sKD6m8@vostro.rjw.lan>
References: <1386264397-27319-1-git-send-email-andriy.shevchenko@linux.intel.com> <1419818.3DzaCCe02K@vostro.rjw.lan> <1AE640813FDE7649BE1B193DEA596E8802494B65@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65247 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751749Ab3LFBrb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Dec 2013 20:47:31 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802494B65@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Friday, December 06, 2013 01:26:07 AM Zheng, Lv wrote:
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: Friday, December 06, 2013 9:26 AM
> >=20
> > On Friday, December 06, 2013 01:08:45 AM Zheng, Lv wrote:
> > > > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > > > Sent: Friday, December 06, 2013 6:37 AM
> > > >
> > > > On Thursday, December 05, 2013 07:26:37 PM Andy Shevchenko wrot=
e:
> > > > > When build kernel with make W=3D1 we get the following compil=
er error.
> > > > >
> > > > > In file included from drivers/sfi/sfi_acpi.c:66:0:
> > > > > include/linux/sfi_acpi.h: In function =E2=80=98acpi_sfi_table=
_parse=E2=80=99:
> > > > > include/linux/sfi_acpi.h:72:2: error: implicit declaration of=
 function =E2=80=98acpi_table_parse=E2=80=99 [-Werror=3Dimplicit-functi=
on-declaration]
> > > > >   if (!acpi_table_parse(signature, handler))
> > > > >   ^
> > > > >   cc1: some warnings being treated as errors
> > > > >
> > > > > The patch changes acpi/acpi.h inclusion to linux/acpi.h.
> > > > >
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel=
=2Ecom>
> > > >
> > > > OK
> > > >
> > > > Lv, I'm dropping your patch cleaning up the inclusions, please =
sort that thing
> > > > out entirely for the next cycle.
> > >
> > > No, I think Andy's patch is wrong.
> >=20
> > His patch may be wrong, but the warning in his changelog surely is =
real. :-)
> >=20
> > > This warning is existing before merging my fixes.
> > >
> > > Either we fix this warning or leave it as is.
> > >
> > > To fix it, you need to add 1 line in sfi_acpi.h rather than chang=
e the line.
> > > Let me post a fix for this.
> >=20
> > Please do.  And I'm putting all ACPI header cleanups on hold until =
all warnings
> > of this kind have been fixed by them.  Otherwise doing those cleanu=
ps makes a
> > little sense in my opinion.
>=20
> OK, not only this warning, there is another warning in sfi_acpi.c.
> I doubt whether they are strictly tested before upstreamed...
> They are all existing warnings.
> You can apply my new patch before the cleanup series.

Sorry, I'm already lost in the thick of patches. :-)

Please resend them all as a single series.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
