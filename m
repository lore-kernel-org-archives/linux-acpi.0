From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] ACPI, APEI: Fixup incorrect 64-bit access width
 firmware bug
Date: Fri, 18 Jan 2013 09:50:19 +0100
Message-ID: <1358499019.4763.49.camel@amber.site>
References: <1358327009-14625-1-git-send-email-jia.zhang@windriver.com>
	 <2313122.XO7091fHrU@vostro.rjw.lan>  <20130117222754.GA32229@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55979 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111Ab3ARIuD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2013 03:50:03 -0500
In-Reply-To: <20130117222754.GA32229@us.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gary Hade <garyhade@us.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lans Zhang <jia.zhang@windriver.com>, len.brown@intel.com, linux-acpi@vger.kernel.org, Myron Stowe <mstowe@redhat.com>, Huang Ying <ying.huang@intel.com>

Le jeudi 17 janvier 2013 =C3=A0 14:27 -0800, Gary Hade a =C3=A9crit :
> On Wed, Jan 16, 2013 at 11:54:54PM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, January 16, 2013 05:03:29 PM Lans Zhang wrote:
> > > The bit width check was introduced by 15afae60 (ACPI, APEI: Fix
> > > incorrect APEI register bit width check and usage), and a fixup
> > > for incorrect 32-bit width memory address was given by f712c71
> > > (ACPI, APEI: Fixup common access width firmware bug). Now there
> > > is a similar symptom:
> > >=20
> > > [Firmware Bug]: APEI: Invalid bit width + offset in GAR [0x123450=
00/64/0/3/0]
> > >=20
> > > Another bogus BIOS reports an incorrect 64-bit width in trigger t=
able.
> > > Thus, apply to a similar workaround for 64-bit width memory addre=
ss.
> >=20
> > This makes sense to me, but I'd like more people to have a look at =
it (Myron,
> > Ying, Gary CCed).
> >=20
> > Thanks,
> > Rafael
> >=20
> >=20
> > > Signed-off-by: Lans Zhang <jia.zhang@windriver.com>
> > > ---
> > >  drivers/acpi/apei/apei-base.c |    3 +++
> > >  1 files changed, 3 insertions(+), 0 deletions(-)
> > >=20
> > > diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/ap=
ei-base.c
> > > index 00a7836..46f80e2 100644
> > > --- a/drivers/acpi/apei/apei-base.c
> > > +++ b/drivers/acpi/apei/apei-base.c
> > > @@ -590,6 +590,9 @@ static int apei_check_gar(struct acpi_generic=
_address *reg, u64 *paddr,
> > >  	if (bit_width =3D=3D 32 && bit_offset =3D=3D 0 && (*paddr & 0x0=
3) =3D=3D 0 &&
> > >  	    *access_bit_width < 32)
> > >  		*access_bit_width =3D 32;
> > > +	else if (bit_width =3D=3D 64 && bit_offset =3D=3D 0 && (*paddr =
& 0x07) =3D=3D 0 &&
> > > +	    *access_bit_width < 64)
> > > +		*access_bit_width =3D 64;
> > > =20
> > >  	if ((bit_width + bit_offset) > *access_bit_width) {
> > >  		pr_warning(FW_BUG APEI_PFX
> > >=20
> > --=20
> > I speak only for myself.
> > Rafael J. Wysocki, Intel Open Source Technology Center.
> >=20
>=20
> This looks reasonable to me.
> Acked-by: Gary Hade <garyhade@us.ibm.com>
>=20
> Copying Jean Delvare who authored the 32-bit fixup.

I've not seen this specific case yet but yes, the fixup seems perfectly
reasonable.

Acked-by: Jean Delvare <jdelvare@suse.de>


--=20
Jean Delvare
Suse L3

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
