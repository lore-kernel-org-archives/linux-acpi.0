From: Gary Hade <garyhade@us.ibm.com>
Subject: Re: [PATCH] ACPI, APEI: Fixup common access width firmware bug
Date: Thu, 14 Jun 2012 10:07:52 -0700
Message-ID: <20120614170752.GB1999@us.ibm.com>
References: <1339490608.21507.5.camel@amber.site>
 <20120614010931.GA7378@us.ibm.com>
 <1339662911.4378.22.camel@amber.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:58243 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756397Ab2FNRIX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Jun 2012 13:08:23 -0400
Received: from /spool/local
	by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <garyhade@us.ibm.com>;
	Thu, 14 Jun 2012 13:08:22 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 53E2C38C8052
	for <linux-acpi@vger.kernel.org>; Thu, 14 Jun 2012 13:08:06 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5EH84jU18546850
	for <linux-acpi@vger.kernel.org>; Thu, 14 Jun 2012 13:08:05 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5EMctMg010134
	for <linux-acpi@vger.kernel.org>; Thu, 14 Jun 2012 18:38:56 -0400
Content-Disposition: inline
In-Reply-To: <1339662911.4378.22.camel@amber.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Gary Hade <garyhade@us.ibm.com>, Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, hui.xiao@linux.intel.com

On Thu, Jun 14, 2012 at 10:35:11AM +0200, Jean Delvare wrote:
> Hi Gary,
>=20
> Le mercredi 13 juin 2012 =E0 18:09 -0700, Gary Hade a =E9crit :
> > On Tue, Jun 12, 2012 at 10:43:28AM +0200, Jean Delvare wrote:
> > > Many firmwares have a common register definition bug where 8-bit
> > > access width is specified for a 32-bit register. Ideally this sho=
uld
> > > be fixed in the BIOS, but earlier versions of the kernel did not
> > > complain, so fix that up silently.
> > >=20
> > > This closes kernel bug #43282:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D43282
> > >=20
> > > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > > Cc: Gary Hade <garyhade@us.ibm.com>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Cc: stable@vger.kernel.org [3.4+]
> > > ---
> > >  drivers/acpi/apei/apei-base.c |    5 +++++
> > >  1 file changed, 5 insertions(+)
> > >=20
> > > --- linux-3.4.orig/drivers/acpi/apei/apei-base.c	2012-06-08 10:02=
:06.000000000 +0200
> > > +++ linux-3.4/drivers/acpi/apei/apei-base.c	2012-06-08 10:04:16.5=
03779775 +0200
> > > @@ -586,6 +586,11 @@ static int apei_check_gar(struct acpi_ge
> > >  	}
> > >  	*access_bit_width =3D 1UL << (access_size_code + 2);
> > >=20
> > > +	/* Fixup common BIOS bug */
> > > +	if (bit_width =3D=3D 32 && bit_offset =3D=3D 0 && (*paddr & 0x0=
3) =3D=3D 0 &&
> > > +	    *access_bit_width < 32)
> > > +		*access_bit_width =3D 32;
> > > +
> > >  	if ((bit_width + bit_offset) > *access_bit_width) {
> > >  		pr_warning(FW_BUG APEI_PFX
> > >  			   "Invalid bit width + offset in GAR [0x%llx/%u/%u/%u/%u]\n"=
,
> >=20
> > This seems reasonable but since the "Access Size < Register Bit Wid=
th"
> > condition has apparently been seen on a number of systems I have be=
en
> > wondering if this might simply be a BIOS writer's way of telling us
> > not to touch some of the high bits in the register.  Reducing the
> > width of the register seems like a better way, but maybe not the
> > only way?
>=20
> I see it as a firmware bug, nothing else

That was my strong feeling but since the number of sightings
seems to be on the increase, I thought it might be good to talk
about whether our interpretation is actually correct.

> (although I am still waiting
> for Asus to reply on this.) And if it really isn't a bug, I can only
> read it as "we have a 32-bit register that can only be read 8-bit at =
a
> time so please issue 4 8-bit reads and build up a 32-bit value out of
> these." And certainly not as "don't touch the upper 24-bits."

It will definitely be interesting to see what you hear from Asus.

Multiple reads or writes to access all the bits in a register
does _not_ sound like a reasonable interpretation of the ACPI
spec to me.

>=20
> As I mentioned in another discussion thread, the 1-bit granularity of
> bit_width and bit_offset clearly means that these are the fields the
> vendor must use to tell us which part of a register we should touch -
> they are the "what". "Access Size" is there for the hardware constrai=
nts
> - it is the "how".
>=20
> > Jean, What do you (and others that are listening who know more
> > about this than I do) think about a change to sanity check only
> > the bit offset and not complain (at least for now) about cases
> > where an access using the specified access size will not address
> > every bit in the register? =20
> >=20
> > Perhaps something like:
> > --- linux-3.5-rc2/drivers/acpi/apei/apei-base.c.ORIG	2012-06-08 18:=
40:09.000000000 -0700
> > +++ linux-3.5-rc2/drivers/acpi/apei/apei-base.c	2012-06-13 16:32:49=
=2E000000000 -0700
> > @@ -586,9 +586,9 @@ static int apei_check_gar(struct acpi_ge
> >  	}
> >  	*access_bit_width =3D 1UL << (access_size_code + 2);
> > =20
> > -	if ((bit_width + bit_offset) > *access_bit_width) {
> > +	if (bit_offset >=3D *access_bit_width) {
> >  		pr_warning(FW_BUG APEI_PFX
> > -			   "Invalid bit width + offset in GAR [0x%llx/%u/%u/%u/%u]\n",
> > +			   "Invalid bit offset in GAR [0x%llx/%u/%u/%u/%u]\n",
> >  			   *paddr, bit_width, bit_offset, access_size_code,
> >  			   space_id);
> >  		return -EINVAL;
>=20
> Doesn't make much sense to me, as I don't think it will catch much.
> Also, your original patch (ACPI, APEI: Fix incorrect APEI register bi=
t
> width check and usage) was not only reporting new errors, it also
> changed the width parameter passed to ACPI read and write functions. =
It
> was the register width and it is now (correctly, I believe) the acces=
s
> width. So if the access width is wrong, and we don't fix it up (as my
> proposed patch does) we might have a regression on some systems. Even=
 if
> the firmware is at fault, regressions are always bad.

Agreed.  Your patch looks fine to me.
Acked-by: Gary Hade <garyhade@us.ibm.com>

Gary

--=20
Gary Hade
System x Enablement
IBM Linux Technology Center
503-578-4503  IBM T/L: 775-4503
garyhade@us.ibm.com
http://www.ibm.com/linux/ltc

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
