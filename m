From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 1/3] ACPI/NFIT: Update Control Region Structure to
 comply ACPI 6.1
Date: Tue, 01 Mar 2016 10:36:59 -0700
Message-ID: <1456853819.15454.45.camel@hpe.com>
References: <1456178130-26468-1-git-send-email-toshi.kani@hpe.com>
	 <1456178130-26468-2-git-send-email-toshi.kani@hpe.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37E44D64B@ORSMSX110.amr.corp.intel.com>
	 <1456850284.15454.23.camel@hpe.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37E44D6E1@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55]:51994 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbcCARCS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2016 12:02:18 -0500
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E44D6E1@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Williams, Dan J" <dan.j.williams@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "elliott@hpe.com" <elliott@hpe.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Tue, 2016-03-01 at 16:03 +0000, Moore, Robert wrote:
> We have a bunch of macros in include/acmacros.h -- like this:
>=20
> ACPI_MOVE_16_TO_16(d, s)

There is a problem in using the ACPICA byte-swap macros. =C2=A0ACPI is =
little-
endian arch, so the macros are set to perform byte-swappings when the C=
PU
arch is big-endian. =C2=A0This case, however, is the other way around. =
=C2=A0The
fields in question are defined & stored as arrays of bytes. =C2=A0If yo=
u treat
them as multi-bytes numeric values, then you need to byte-swap them whe=
n
the CPU arch is little-endian because arrays of bytes have the same
addressing as big-endian.

Another issue is that it is not clear who needs to perform the byte-
swapping among ACPICA and drivers. =C2=A0If ACPICA, drivers must agree =
that
these fields are always treated as multi-bytes numeric values despite o=
f
the spec. =C2=A0If drivers, we need to make sure that only a single dri=
ver
performs this byte-swapping one time as ACPI tables are global structur=
es.

I think it is much clearer to define the structure according to the ACP=
I
spec.

Thanks,
-Toshi

> > -----Original Message-----
> > From: Toshi Kani [mailto:toshi.kani@hpe.com]
> > Sent: Tuesday, March 01, 2016 8:38 AM
> > To: Moore, Robert; rjw@rjwysocki.net; Williams, Dan J
> > Cc: Zheng, Lv; elliott@hpe.com; linux-nvdimm@lists.01.org; linux-
> > acpi@vger.kernel.org; linux-kernel@vger.kernel.org; devel@acpica.or=
g
> > Subject: Re: [PATCH v2 1/3] ACPI/NFIT: Update Control Region Struct=
ure
> > to
> > comply ACPI 6.1
> >=20
> > On Tue, 2016-03-01 at 15:13 +0000, Moore, Robert wrote:
> > >=20
> > > > -----Original Message-----
> > > > From: Toshi Kani [mailto:toshi.kani@hpe.com]
> > > > Sent: Monday, February 22, 2016 1:55 PM
> > > > To: rjw@rjwysocki.net; Williams, Dan J
> > > > Cc: Moore, Robert; Zheng, Lv; elliott@hpe.com;
> > > > linux-nvdimm@lists.01.or g; linux-acpi@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; devel@acpica.org; Toshi Kani
> > > > Subject: [PATCH v2 1/3] ACPI/NFIT: Update Control Region Struct=
ure
> > > > to comply ACPI 6.1
> > > >=20
> > > > ACPI 6.1, Table 5-133, updates NVDIMM Control Region Structure =
as
> > > > follows.
> > > > =C2=A0- Valid Fields, Manufacturing Location, and Manufacturing=
 Date
> > > > =C2=A0=C2=A0=C2=A0are added from reserved range.=C2=A0=C2=A0No =
change in the structure size.
> > > > =C2=A0- IDs defined as SPD values are arrays of bytes.=C2=A0=C2=
=A0The spec
> > > > =C2=A0=C2=A0=C2=A0clarified that they need to be represented as=
 arrays of bytes
> > > > =C2=A0=C2=A0=C2=A0as well.
> > > >=20
> > > > This patch makes the following changes to support this update.
> > > > =C2=A0- Change 'struct acpi_nfit_control_region' to reflect the=
 update.
> > > > =C2=A0=C2=A0=C2=A0SPD IDs are defined as arrays of bytes, so th=
at they can be
> > > > =C2=A0=C2=A0=C2=A0treated in the same way regardless of CPU end=
ianness and are
> > > > =C2=A0=C2=A0=C2=A0not miss-treated as little-endian numeric val=
ues.
> > >=20
> > >=20
> > > I don't think we are going to start changing the ACPI tables defi=
ned
> > > in the ACPICA headers because of this. We do in fact have macros =
for
> > > this purpose.
> >=20
> > Can you elaborate what macros you suggest to use for this purpose?
> >=20
> > Thanks,
> > -Toshi
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD{=EF=BF=BD=
i=EF=BF=BDb=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=EF=
=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=
=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD
> =0C=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BD=
j=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=
=EF=BF=BD=EF=BF=BD!=EF=BF=BDi
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
