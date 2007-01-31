From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: 2.6.20-rc6-mm3
Date: Wed, 31 Jan 2007 19:28:26 +0100
Message-ID: <45C0DFCA.4000506@imap.cc>
References: <20070129204528.eb8d695e.akpm@osdl.org>	<45BFC442.5000903@gmail.com>	<45BFEDFB.6000500@imap.cc> <20070130172525.f32fb9ea.akpm@osdl.org> <45C07FBF.3080000@imap.cc> <45C08BA6.5000209@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA624CCD95100E2DCBF92D15A"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:38204 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030511AbXAaS1y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 31 Jan 2007 13:27:54 -0500
In-Reply-To: <45C08BA6.5000209@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Maciej Rutecki <maciej.rutecki@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA624CCD95100E2DCBF92D15A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 31.01.2007 13:29 schrieb Alexey Starikovskiy:
[...]
>>>>> Second problem, power button doesn't work.
[...]
> This patch should fix the issue...

It does. Power button works again.

Thanks,
Tilman

> -----------------------------------------------------------------------=
-
>=20
> Correct id for fixed buttons.
> ACPI_BUTTON_HID_POWERF was changed, but this change was not propogated =
to button.c,
> thus breaking detection of fixed power and sleep buttons.
> From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
>=20
>=20
> ---
>=20
>  drivers/acpi/button.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index ac86058..c726612 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -75,7 +75,7 @@ static int acpi_button_state_open_fs(str
>  static struct acpi_driver acpi_button_driver =3D {
>  	.name =3D ACPI_BUTTON_DRIVER_NAME,
>  	.class =3D ACPI_BUTTON_CLASS,
> -	.ids =3D "ACPI_FPB,ACPI_FSB,PNP0C0D,PNP0C0C,PNP0C0E",
> +	.ids =3D "button_power,button_sleep,PNP0C0D,PNP0C0C,PNP0C0E",
>  	.ops =3D {
>  		.add =3D acpi_button_add,
>  		.remove =3D acpi_button_remove,


--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigA624CCD95100E2DCBF92D15A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFwN/SMdB4Whm86/kRAiMAAKCCkkW3WBBQDcZYVMjtFYcR7q5PWwCfbDx4
pGuCNVP4WXy+jDnFT4lSbuE=
=axTH
-----END PGP SIGNATURE-----

--------------enigA624CCD95100E2DCBF92D15A--
