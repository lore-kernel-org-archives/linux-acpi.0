From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [linux-pm] [PATCH 3/4] x86 hibernate: Mark ACPI NVS memory
	region at startup
Date: Wed, 29 Oct 2008 17:21:31 +0800
Message-ID: <1225272091.2665.4.camel@rzhang-dt>
References: <200810222249.20629.rjw@sisk.pl>
	 <200810222253.16264.rjw@sisk.pl> <20081026121404.GC1607@ucw.cz>
	 <200810261329.16260.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36215 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbYJ2JWP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Oct 2008 05:22:15 -0400
In-Reply-To: <200810261329.16260.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

Hi, sorry for the delay,

On Sun, 2008-10-26 at 20:29 +0800, Rafael J. Wysocki wrote:
> On Sunday, 26 of October 2008, Pavel Machek wrote:
> > On Wed 2008-10-22 22:53:15, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > >=20
> > > x86 hibernate: Mark ACPI NVS memory region at startup
> > >=20
> > > Introduce new initcall for marking the ACPI NVS memory at startup=
, so
> > > that it can be saved/restore during hibernation/resume.
> > >=20
> > > Based on a patch by Zhang Rui.
> > >=20
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >  arch/x86/kernel/e820.c |   25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >=20
> > > Index: linux-2.6/arch/x86/kernel/e820.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-2.6.orig/arch/x86/kernel/e820.c
> > > +++ linux-2.6/arch/x86/kernel/e820.c
> > > @@ -20,6 +20,7 @@
> > >  #include <linux/pfn.h>
> > >  #include <linux/suspend.h>
> > >  #include <linux/firmware-map.h>
> > > +#include <linux/efi.h>
> > > =20
> > >  #include <asm/pgtable.h>
> > >  #include <asm/page.h>
> >=20
> > Unrelated chunk?
> >=20
> > > @@ -665,6 +666,30 @@ void __init e820_mark_nosave_regions(uns
> > >  }
> > >  #endif
> > > =20
> > > +#ifdef CONFIG_HIBERNATION
> > > +/**
> > > + * Mark ACPI NVS memory region, so that we can save/restore it d=
uring
> > > + * hibernation and the subsequent resume.
> > > + */
> > > +static int __init e820_mark_nvs_memory(void)
> > > +{
> > > +	int i;
> > > +
> > > +	if (efi_enabled)
> > > +		return 0;
> >=20
> > Aha, not unrelated... why is that? EFI does not use acpi?=20
>=20
> With EFI we are not supposed to do that.  Rui knows the details.  Rui=
?
>=20
well,=20
about EFI nvs memory, I only get
"EfiACPIMemoryNVS: The OS and loader must preserve this memory range in
the working and ACPI S1=E2=80=93S3 states." in the ACPI spec 3.0b.
whether we should save/restore this piece of memory is not clear.
I'd prefer not to touch it currently.

thanks,
rui

> > > +	for (i =3D 0; i < e820.nr_map; i++) {
> > > +		struct e820entry *ei =3D &e820.map[i];
> > > +
> > > +		if (ei->type =3D=3D E820_NVS)
> > > +			hibernate_nvs_register(ei->addr, ei->size);
> >=20
> > can nvs_register fail? (OOM?)
>=20
> It can, in which case it will do the cleanup.
>=20
> Thanks,
> Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
