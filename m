From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH v9 23/24] dt: bindings: smiapp: Document lens-focus and
 flash properties
Date: Fri, 8 Sep 2017 15:36:52 +0200
Message-ID: <20170908133652.GR18365@amd>
References: <20170908131235.30294-1-sakari.ailus@linux.intel.com>
 <20170908131822.31020-19-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PY8tzLeNxmyMVNR3"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170908131822.31020-19-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--PY8tzLeNxmyMVNR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Document optional lens-focus and flash properties for the smiapp driver.
>=20
> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/media/i2c/nokia,smia.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt b=
/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt
> index 855e1faf73e2..a052969365d9 100644
> --- a/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt
> @@ -27,6 +27,8 @@ Optional properties
>  - nokia,nvm-size: The size of the NVM, in bytes. If the size is not give=
n,
>    the NVM contents will not be read.
>  - reset-gpios: XSHUTDOWN GPIO
> +- flash-leds: One or more phandles to refer to flash LEDs
> +- lens-focus: Phandle for lens focus

Should we simply reference the generic documentation here? If it needs
changing, it will be easier changing single place.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PY8tzLeNxmyMVNR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmynPQACgkQMOfwapXb+vJcswCfWf09m/YpAtrvjLAB+fF8kE9j
33YAn32cQxtad8C8WHyoxtX1oEhymdtg
=TstK
-----END PGP SIGNATURE-----

--PY8tzLeNxmyMVNR3--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
