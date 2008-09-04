From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH]: ACPI : Set 32bit and 64bit waking vector in FCAS table
Date: Thu, 04 Sep 2008 17:18:30 +0800
Message-ID: <1220519910.24775.260.camel@rzhang-dt>
References: <1220507476.4007.117.camel@yakui_zhao.sh.intel.com>
	 <200809041010.07058.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46819 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323AbYIDJTd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Sep 2008 05:19:33 -0400
In-Reply-To: <200809041010.07058.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhao Yakui <yakui.zhao@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, andi@firstfloor.org

On Thu, 2008-09-04 at 10:10 +0200, Rafael J. Wysocki wrote:
> On Thursday, 4 of September 2008, Zhao Yakui wrote:
> > Subject: ACPI : Set 32bit and 64bit waking vector in FCAS table
> > From: Zhao Yakui <yakui.zhao@intel.com>
> >=20
> >     On some laptops only the 64bit waking vecotr is set for ACPI 2.=
0 FACS.
> > But when the system is resumed, BIOS will transfer control directly=
 to=20
> > 32bit waking vector. In such case the system can't be resumed corre=
ctly.
> >     Maybe it will be more appropriate that both the 32bit and 64bit=
 waking=20
> > vector will be set for the ACPI 2.0 FACS when the system enters the=
 S3=20
> > sleeping state.
> >=20
> >  http://bugzilla.kernel.org/show_bug.cgi?id=3D11368
>=20
> Well, the spec (2.0c) says we should use facs->firmware_waking_vector=
 only
> if facs->xfirmware_waking_vector is zero, so I'm afraid this change m=
ay cause
> regressions to happen.
>=20
> Moreover, both 1.0b and 2.0c say that facs->length should be at least=
 64 bytes,
> so the (facs->length >=3D 32) check is actually redundant (unless the=
re is a
> quirk setting this value below 32 for some broken systems I'm not awa=
re of).
>=20
> So, the question is what happens if we ignore the facs->length check =
on systems
> this patch is supposed to fix.
this should have no impact.
facs->length is also 64 bytes.
without the patch, xfirmware_waking_vector is set.
with this patch applied, both xfirmware and firmware_waking_vector are
set.
so it seems that the BIOS sets =EF=BB=BFfacs->xfirmware_waking_vector d=
uring
POST, but uses =EF=BB=BF=EF=BB=BFfacs->firmware_waking_vector to get ba=
ck during resume.

thanks,
rui

>   If they _still_ require
> facs->firmware_waking_vector to be set even if
> facs->xfirmware_waking_vector is non-zero, I'd prefer to add quirks f=
or them
> instead of affecting everybody else.
>=20
> > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/hardware/hwsleep.c |   14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >=20
> > Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c
> > +++ linux-2.6/drivers/acpi/hardware/hwsleep.c
> > @@ -80,14 +80,14 @@ acpi_set_firmware_waking_vector(acpi_phy
> > =20
> >  	/* Set the vector */
> > =20
> > -	if ((facs->length < 32) || (!(facs->xfirmware_waking_vector))) {
> > -		/*
> > -		 * ACPI 1.0 FACS or short table or optional X_ field is zero
> > -		 */
> > -		facs->firmware_waking_vector =3D (u32) physical_address;
> > -	} else {
> > +	/* 32 Bit wakeing vector is always set */
> > +	facs->firmware_waking_vector =3D (u32) physical_address;
> > +
> > +	if (facs->length >=3D 32) {
> >  		/*
> > -		 * ACPI 2.0 FACS with valid X_ field
> > +		 * ACPI 2.0 FACS with the valid X_filed. Its length
> > +		 * will be more than 32 bytes. In such case the 64 bit
> > +		 * waking vector is also set.
> >  		 */
> >  		facs->xfirmware_waking_vector =3D physical_address;
> >  	}
> >=20
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
> >=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
