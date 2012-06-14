From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] ACPI, APEI: Fixup common access width firmware bug
Date: Thu, 14 Jun 2012 10:35:11 +0200
Message-ID: <1339662911.4378.22.camel@amber.site>
References: <1339490608.21507.5.camel@amber.site>
	 <20120614010931.GA7378@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59974 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485Ab2FNIf3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Jun 2012 04:35:29 -0400
In-Reply-To: <20120614010931.GA7378@us.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gary Hade <garyhade@us.ibm.com>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, hui.xiao@linux.intel.com

Hi Gary,

Le mercredi 13 juin 2012 =C3=A0 18:09 -0700, Gary Hade a =C3=A9crit :
> On Tue, Jun 12, 2012 at 10:43:28AM +0200, Jean Delvare wrote:
> > Many firmwares have a common register definition bug where 8-bit
> > access width is specified for a 32-bit register. Ideally this shoul=
d
> > be fixed in the BIOS, but earlier versions of the kernel did not
> > complain, so fix that up silently.
> >=20
> > This closes kernel bug #43282:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D43282
> >=20
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: Gary Hade <garyhade@us.ibm.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: stable@vger.kernel.org [3.4+]
> > ---
> >  drivers/acpi/apei/apei-base.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > --- linux-3.4.orig/drivers/acpi/apei/apei-base.c	2012-06-08 10:02:0=
6.000000000 +0200
> > +++ linux-3.4/drivers/acpi/apei/apei-base.c	2012-06-08 10:04:16.503=
779775 +0200
> > @@ -586,6 +586,11 @@ static int apei_check_gar(struct acpi_ge
> >  	}
> >  	*access_bit_width =3D 1UL << (access_size_code + 2);
> >=20
> > +	/* Fixup common BIOS bug */
> > +	if (bit_width =3D=3D 32 && bit_offset =3D=3D 0 && (*paddr & 0x03)=
 =3D=3D 0 &&
> > +	    *access_bit_width < 32)
> > +		*access_bit_width =3D 32;
> > +
> >  	if ((bit_width + bit_offset) > *access_bit_width) {
> >  		pr_warning(FW_BUG APEI_PFX
> >  			   "Invalid bit width + offset in GAR [0x%llx/%u/%u/%u/%u]\n",
>=20
> This seems reasonable but since the "Access Size < Register Bit Width=
"
> condition has apparently been seen on a number of systems I have been
> wondering if this might simply be a BIOS writer's way of telling us
> not to touch some of the high bits in the register.  Reducing the
> width of the register seems like a better way, but maybe not the
> only way?

I see it as a firmware bug, nothing else (although I am still waiting
for Asus to reply on this.) And if it really isn't a bug, I can only
read it as "we have a 32-bit register that can only be read 8-bit at a
time so please issue 4 8-bit reads and build up a 32-bit value out of
these." And certainly not as "don't touch the upper 24-bits."

As I mentioned in another discussion thread, the 1-bit granularity of
bit_width and bit_offset clearly means that these are the fields the
vendor must use to tell us which part of a register we should touch -
they are the "what". "Access Size" is there for the hardware constraint=
s
- it is the "how".

> Jean, What do you (and others that are listening who know more
> about this than I do) think about a change to sanity check only
> the bit offset and not complain (at least for now) about cases
> where an access using the specified access size will not address
> every bit in the register? =20
>=20
> Perhaps something like:
> --- linux-3.5-rc2/drivers/acpi/apei/apei-base.c.ORIG	2012-06-08 18:40=
:09.000000000 -0700
> +++ linux-3.5-rc2/drivers/acpi/apei/apei-base.c	2012-06-13 16:32:49.0=
00000000 -0700
> @@ -586,9 +586,9 @@ static int apei_check_gar(struct acpi_ge
>  	}
>  	*access_bit_width =3D 1UL << (access_size_code + 2);
> =20
> -	if ((bit_width + bit_offset) > *access_bit_width) {
> +	if (bit_offset >=3D *access_bit_width) {
>  		pr_warning(FW_BUG APEI_PFX
> -			   "Invalid bit width + offset in GAR [0x%llx/%u/%u/%u/%u]\n",
> +			   "Invalid bit offset in GAR [0x%llx/%u/%u/%u/%u]\n",
>  			   *paddr, bit_width, bit_offset, access_size_code,
>  			   space_id);
>  		return -EINVAL;

Doesn't make much sense to me, as I don't think it will catch much.
Also, your original patch (ACPI, APEI: Fix incorrect APEI register bit
width check and usage) was not only reporting new errors, it also
changed the width parameter passed to ACPI read and write functions. It
was the register width and it is now (correctly, I believe) the access
width. So if the access width is wrong, and we don't fix it up (as my
proposed patch does) we might have a regression on some systems. Even i=
f
the firmware is at fault, regressions are always bad.

(But again I don't know much about ACPI so I might be completely
wrong...)

--=20
Jean Delvare
Suse L3

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
