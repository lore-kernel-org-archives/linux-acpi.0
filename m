From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: et8ek8: Document support for flash and lens devices
Date: Sun, 12 Nov 2017 15:25:47 +0100
Message-ID: <20171112142547.km6haalndqiohoq2@earth>
References: <20171026075342.5760-1-sakari.ailus@linux.intel.com>
 <20171026075342.5760-30-sakari.ailus@linux.intel.com>
 <20171112112729.GA21247@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3pw3ukvse2a7ndb5"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171112112729.GA21247@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--3pw3ukvse2a7ndb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 12, 2017 at 12:27:29PM +0100, Pavel Machek wrote:
>=20
> Document dts support of LED/focus.
>=20
> Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

-- Sebastian

> diff --git a/Documentation/devicetree/bindings/media/i2c/toshiba,et8ek8.t=
xt b/Documentation/devicetree/bindings/media/i2c/toshiba,et8ek8.txt
> index 0b7b6a4..e80d589 100644
> --- a/Documentation/devicetree/bindings/media/i2c/toshiba,et8ek8.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/toshiba,et8ek8.txt
> @@ -20,6 +20,13 @@ Mandatory properties
>    is in hardware standby mode when the signal is in the low state.
> =20
> =20
> +Optional properties
> +-------------------
> +
> +- flash-leds: See ../video-interfaces.txt
> +- lens-focus: See ../video-interfaces.txt
> +
> +
>  Endpoint node mandatory properties
>  ----------------------------------
> =20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html



--3pw3ukvse2a7ndb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloIWegACgkQ2O7X88g7
+proKQ/+KOGfLfkSFbgtSH2ZVZcJCv20jLTJLcXxCGxb8MTWUOebG2iVUskGaWiv
14SozCnsr+mizd02bbztEkJ6eYnDXPycCcQAE8UAN770XnEp8mfXkMTR/d/Ckemr
SBfLQiyh+F2Wo3gIkP6O5oIAO8aGj3v/TqTjVTPqaa5iF40xNJHMrgOEUFpsYyAj
OcbB9wQq7CQaP/RXDKLgtxWXG+HpzQme6B160m2yk93tPttQysnyWDkoJRlORC5s
5CTAbkq0jGMHKgLdWunC2+BmCZ1iaY5M7UVgDJjzd9hIKNIBH7w7PnhYG7yvtykY
FSfmEm/1qEY/EQizfVMUeXhHONJTLAdvOL2SX4H9ZySpGnw+8a4s3TE/pUWUACpj
y4xmMfZaCJ15GWuOIgy867yBeZHERu2LQzYGmdHghQiKL+n6i3ReDL38ksc5bLm5
AW72surqxMJtWmcYgPlSgDSeORy4NhvidnlDX4FO9AgkMK4ENP7wToGJWvtyaPPl
OAXXLsmRvk2qwuWKPyAVFgO3zcqIkKMMesolgTx5DQ+koXBApZ7HVym5WULrLHs4
45JwIr4GO/dYNcSDZvKjvigN7vbrg+18e9FUiRRe6bQrwQJkWRY5TX3ggB1aWbYD
xQLbQJ1HNWZcV9YWU1/j1yxv8iGYXgDiByMNT5I8lVDD9BycRlY=
=Up9e
-----END PGP SIGNATURE-----

--3pw3ukvse2a7ndb5--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
