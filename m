From: Dustin Kirkland <kirkland@canonical.com>
Subject: Re: [PATCH 1/1] switch the Asus Pundit P1-AH2 to old acpi sleep
 ordering
Date: Wed, 11 Feb 2009 12:30:14 -0600
Message-ID: <1234377014.6932.2.camel@t61p>
References: <1234375882-5193-1-git-send-email-apw@canonical.com>
Reply-To: kirkland@canonical.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-d8WbMvNGZRcpzCENuWE7"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:43287 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbZBKSaU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Feb 2009 13:30:20 -0500
In-Reply-To: <1234375882-5193-1-git-send-email-apw@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Whitcroft <apw@canonical.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org


--=-d8WbMvNGZRcpzCENuWE7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-02-11 at 18:11 +0000, Andy Whitcroft wrote:
> Switch the Asus Pundit P1-AH2 (M2N8L motherboard) to the old ACPI 1.0
> sleep ordering by default.  Without this it will not suspend/resume
> correctly.
>=20
> Signed-off-by: Andy Whitcroft <apw@canonical.com>
> Tested-by: Dustin Kirkland <kirkland@canonical.com>

Ack.  I've tested this and it solves this problem on this hardware.

Thanks, Andy.

> ---
>  drivers/acpi/sleep.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 5192666..3ca9868 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -378,6 +378,14 @@ static struct dmi_system_id __initdata acpisleep_dmi=
_table[] =3D {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "Macmini1,1"),
>  		},
>  	},
> +	{
> +	.callback =3D init_old_suspend_ordering,
> +	.ident =3D "Asus Pundit P1-AH2 (M2N8L motherboard)",
> +	.matches =3D {
> +		DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTek Computer INC."),
> +		DMI_MATCH(DMI_BOARD_NAME, "M2N8L"),
> +		},
> +	},
>  	{},
>  };
>  #endif /* CONFIG_SUSPEND */

--=-d8WbMvNGZRcpzCENuWE7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmTGTMACgkQs7pNXIOmEZTLtwCfaXwhwgmJVf/FhzflNOxK0M3R
VKEAmgI8pVZWNA3BqJ/T77qmDP8h6fbT
=CZy0
-----END PGP SIGNATURE-----

--=-d8WbMvNGZRcpzCENuWE7--

