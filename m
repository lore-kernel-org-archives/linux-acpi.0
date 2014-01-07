From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] ACPI: thermal: remove const from thermal_zone_device_ops
 declaration
Date: Tue, 7 Jan 2014 19:34:03 -0400
Message-ID: <52CC8EEB.9010604@ti.com>
References: <1389111895-23007-1-git-send-email-emilgoode@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d38TXoq0sN4NKSKSmrSA0nrfhHhs3Hefk"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37218 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754105AbaAGXeZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Jan 2014 18:34:25 -0500
In-Reply-To: <1389111895-23007-1-git-send-email-emilgoode@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Emil Goode <emilgoode@gmail.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

--d38TXoq0sN4NKSKSmrSA0nrfhHhs3Hefk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07-01-2014 12:24, Emil Goode wrote:
> The following commit introduced the requirement to not declare
> thermal_zone_device_ops structs as const in order to allow
> changing the .get_temp callback.
>=20
> commit 4e5e4705bf69ea450f58fc709ac5888f321a9299
> Author: Eduardo Valentin <eduardo.valentin@ti.com>
> Date:   Wed Jul 3 15:35:39 2013 -0400
>=20
>     thermal: introduce device tree parser
>=20
> Signed-off-by: Emil Goode <emilgoode@gmail.com>

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/acpi/thermal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 1fd21ad..8349a55 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -861,7 +861,7 @@ acpi_thermal_unbind_cooling_device(struct thermal_z=
one_device *thermal,
>  	return acpi_thermal_cooling_device_cb(thermal, cdev, false);
>  }
> =20
> -static const struct thermal_zone_device_ops acpi_thermal_zone_ops =3D =
{
> +static struct thermal_zone_device_ops acpi_thermal_zone_ops =3D {
>  	.bind =3D acpi_thermal_bind_cooling_device,
>  	.unbind	=3D acpi_thermal_unbind_cooling_device,
>  	.get_temp =3D thermal_get_temp,
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--d38TXoq0sN4NKSKSmrSA0nrfhHhs3Hefk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLMjvIACgkQCXcVR3XQvP3L6gD7B2J7f2SUQuZhpShZH/GNtjUm
66MHYjXagUB6rDRkCAQA/3/Hh35+smtAZvxKm/IX45BOmyC/z3qMulmA6Alsy52I
=Cuu1
-----END PGP SIGNATURE-----

--d38TXoq0sN4NKSKSmrSA0nrfhHhs3Hefk--
