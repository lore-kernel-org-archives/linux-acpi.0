From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH V2] ACPI, APEI: Cleanup alignment related codes for APEI
Date: Fri, 15 Nov 2013 00:38:44 -0500
Message-ID: <20131115053843.GA29273@gchen.bj.intel.com>
References: <1384135666-1929-1-git-send-email-gong.chen@linux.intel.com>
 <20131114014924.GA17790@gchen.bj.intel.com>
 <20131114122956.GE13376@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9704 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053Ab3KOFzL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Nov 2013 00:55:11 -0500
Content-Disposition: inline
In-Reply-To: <20131114122956.GE13376@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2013 at 01:29:56PM +0100, Borislav Petkov wrote:
> Date: Thu, 14 Nov 2013 13:29:56 +0100
> From: Borislav Petkov <bp@alien8.de>
> To: "Chen, Gong" <gong.chen@linux.intel.com>
> Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org
> Subject: Re: [PATCH V2] ACPI, APEI: Cleanup alignment related codes for A=
PEI
> User-Agent: Mutt/1.5.21 (2010-09-15)
>=20
> On Wed, Nov 13, 2013 at 08:49:24PM -0500, Chen, Gong wrote:
> > On Sun, Nov 10, 2013 at 09:07:46PM -0500, Chen, Gong wrote:
> > > Date: Sun, 10 Nov 2013 21:07:46 -0500
> > > From: "Chen, Gong" <gong.chen@linux.intel.com>
> > > To: tony.luck@intel.com, bp@alien8.de
> > > Cc: linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.c=
om>
> > > Subject: [PATCH V2] ACPI, APEI: Cleanup alignment related codes for A=
PEI
> > > X-Mailer: git-send-email 1.8.4.rc3
> > >=20
> > > We ever used *memcpy* to avoid access alignment issue between
> > > firmware and OS. Now we can use a better and standard way
> > > to avoid this issue. In the meanwhile, simplify some variable names
> > > to avoid the limit of 80 characters per line and use structure
> > > assignment instead of unnecessary memcpy. No functional changes.
> > >=20
> > > v2->v1: Make description information clearer.
> > >=20
> > Any comments? Boris/Tony?
>=20
> I get this when building here:
>=20
> drivers/acpi/apei/apei-base.c: In function =E2=80=98apei_check_gar=E2=80=
=99:
> drivers/acpi/apei/apei-base.c:571:8: warning: assignment makes pointer fr=
om integer without a cast [enabled by default]
>   paddr =3D get_unaligned(&reg->address);
>         ^

Gee, it is really really a stupid error. I thought I checked
the patch throughly but I'm wrong :-(.

It should be
    *paddr =3D get_unaligned(&reg->address);

> drivers/acpi/apei/apei-base.c: In function =E2=80=98collect_res_callback=
=E2=80=99:
> drivers/acpi/apei/apei-base.c:716:3: warning: =E2=80=98paddr=E2=80=99 may=
 be used uninitialized in this function [-Wmaybe-uninitialized]
>    return apei_res_add(&resources->iomem, paddr,
>    ^
> drivers/acpi/apei/apei-base.c: In function =E2=80=98apei_read=E2=80=99:
> drivers/acpi/apei/apei-base.c:645:10: warning: =E2=80=98address=E2=80=99 =
may be used uninitialized in this function [-Wmaybe-uninitialized]
>    status =3D acpi_os_read_memory((acpi_physical_address) address,
>           ^
> drivers/acpi/apei/apei-base.c: In function =E2=80=98apei_write=E2=80=99:
> drivers/acpi/apei/apei-base.c:678:10: warning: =E2=80=98address=E2=80=99 =
may be used uninitialized in this function [-Wmaybe-uninitialized]
>    status =3D acpi_os_write_memory((acpi_physical_address) address,
>=20
> --=20
> Regards/Gruss,
>     Boris.
>=20
> Sent from a fat crate under my desk. Formatting is fine.
> --

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJShbNjAAoJEI01n1+kOSLHLYgQAIbh1dYgs9jsMb1f6V6Jwez+
vxUJ9TMEDU1Wxhyalt/rnvt3vfFkev9SRwTs6FD6NivC7CYiATXv7i1xY66FWAB3
glFwKtVz9vlapPnchc4mstEQcUavu7BqNCMb4OOrpX7XuJiJyIi3ytnSfzdx0tXm
hF0aIvd+cZnfoj8Jr3TTmTiGxwZmf7hwAjiRH4obyOWTEQga7w4lhxTmsdWLr5KF
1ufaFeQNf2bgUqWcnrxZ1xuQkCo1ZQ6ioPrPi70llieHI0GOIi1X6gMd1N8ecWwE
jEK4wSiRha/nvPlsm/5mfJ6Zkar22z2Bwy7hpfx1a4K5zSH+s/BIWdIJSCKH40TD
NQ2KDMTICBWHPQHRigOnRw3BGRf4WrmXjN/X0mN4pQu/wp+yuSMAIeRSAahF1uWW
9sLFpSEYP32lB8pn5yvtRN7UoSxr+SsTX2n4q7M8r089iIW0xSYKACn5hsVKCYux
GaUyACHtuEQWnHfTrXDElF5ZwzABOu9f5TDkZzmiRj2OS0kgHLVpOl2PVzepvO5c
ZeQikwbFhaPjKQl0aCGl/rCjQfFmsj2acKTW1h0SKnuhhCEExOLVu1ns3kdUKp6b
nBa6xynLb7d/stjtazNT9zVjZzfaC2Qlv09M+R3Zknyy61BIvNtzWDISnsta94Wk
9Z4uytKXuVnb/r3KmaYU
=+IDH
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
