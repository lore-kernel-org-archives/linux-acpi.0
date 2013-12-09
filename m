From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] SFI: fix compilation warnings
Date: Mon, 09 Dec 2013 10:56:23 +0200
Message-ID: <1386579383.1871.102.camel@smile>
References: <1386264397-27319-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1419818.3DzaCCe02K@vostro.rjw.lan>
	 <1AE640813FDE7649BE1B193DEA596E8802494B65@SHSMSX101.ccr.corp.intel.com>
	 <1790293.cpW4sKD6m8@vostro.rjw.lan>
	 <1AE640813FDE7649BE1B193DEA596E8802494B99@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17522 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760769Ab3LII4x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Dec 2013 03:56:53 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802494B99@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, 2013-12-06 at 01:51 +0000, Zheng, Lv wrote:
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vge=
r.kernel.org] On Behalf Of Rafael J. Wysocki
> > Sent: Friday, December 06, 2013 10:01 AM
> > To: Zheng, Lv
> > Cc: Andy Shevchenko; Wysocki, Rafael J; linux-acpi@vger.kernel.org;=
 LKML
> > Subject: Re: [PATCH] SFI: fix compilation warnings
> >=20
> > On Friday, December 06, 2013 01:26:07 AM Zheng, Lv wrote:
> > > > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > > > Sent: Friday, December 06, 2013 9:26 AM
> > > >
> > > > On Friday, December 06, 2013 01:08:45 AM Zheng, Lv wrote:
> > > > > > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > > > > > Sent: Friday, December 06, 2013 6:37 AM
> > > > > >
> > > > > > On Thursday, December 05, 2013 07:26:37 PM Andy Shevchenko =
wrote:
> > > > > > > When build kernel with make W=3D1 we get the following co=
mpiler error.
> > > > > > >
> > > > > > > In file included from drivers/sfi/sfi_acpi.c:66:0:
> > > > > > > include/linux/sfi_acpi.h: In function =E2=80=98acpi_sfi_t=
able_parse=E2=80=99:
> > > > > > > include/linux/sfi_acpi.h:72:2: error: implicit declaratio=
n of function =E2=80=98acpi_table_parse=E2=80=99 [-Werror=3Dimplicit-fu=
nction-declaration]
> > > > > > >   if (!acpi_table_parse(signature, handler))
> > > > > > >   ^
> > > > > > >   cc1: some warnings being treated as errors
> > > > > > >
> > > > > > > The patch changes acpi/acpi.h inclusion to linux/acpi.h.
> > > > > > >
> > > > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.i=
ntel.com>
> > > > > >
> > > > > > OK
> > > > > >
> > > > > > Lv, I'm dropping your patch cleaning up the inclusions, ple=
ase sort that thing
> > > > > > out entirely for the next cycle.
> > > > >
> > > > > No, I think Andy's patch is wrong.
> > > >
> > > > His patch may be wrong, but the warning in his changelog surely=
 is real. :-)
> > > >
> > > > > This warning is existing before merging my fixes.
> > > > >
> > > > > Either we fix this warning or leave it as is.
> > > > >
> > > > > To fix it, you need to add 1 line in sfi_acpi.h rather than c=
hange the line.
> > > > > Let me post a fix for this.
> > > >
> > > > Please do.  And I'm putting all ACPI header cleanups on hold un=
til all warnings
> > > > of this kind have been fixed by them.  Otherwise doing those cl=
eanups makes a
> > > > little sense in my opinion.
> > >
> > > OK, not only this warning, there is another warning in sfi_acpi.c=
=2E
> > > I doubt whether they are strictly tested before upstreamed...
> > > They are all existing warnings.
> > > You can apply my new patch before the cleanup series.
> >=20
> > Sorry, I'm already lost in the thick of patches. :-)
> >=20
> > Please resend them all as a single series.
>=20
> OK, I'll sort them again.

=46irst of all, you are right. We have to have acpi/acpi.h _and_
linux/acpi.h in sfi_acpi.h.

Please, also check this one:
http://www.mail-archive.com/linux-gpio@vger.kernel.org/msg01521.html


--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
