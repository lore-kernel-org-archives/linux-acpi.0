From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v16 27/32] dt: bindings: smiapp: Document lens-focus and
 flash-leds properties
Date: Mon, 30 Oct 2017 00:03:18 +0100
Message-ID: <20171029230318.qzf4lfawjam4bqvg@earth>
References: <20171026075342.5760-1-sakari.ailus@linux.intel.com>
 <20171026075342.5760-28-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdqeuk7kqid37qbs"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171026075342.5760-28-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--sdqeuk7kqid37qbs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 26, 2017 at 10:53:37AM +0300, Sakari Ailus wrote:
> Document optional lens-focus and flash-leds properties for the smiapp
> driver.
>=20
> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Acked-by: Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
> Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

-- Sebastian

> ---
>  Documentation/devicetree/bindings/media/i2c/nokia,smia.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt b=
/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt
> index 855e1faf73e2..33f10a94c381 100644
> --- a/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt
> @@ -27,6 +27,8 @@ Optional properties
>  - nokia,nvm-size: The size of the NVM, in bytes. If the size is not give=
n,
>    the NVM contents will not be read.
>  - reset-gpios: XSHUTDOWN GPIO
> +- flash-leds: See ../video-interfaces.txt
> +- lens-focus: See ../video-interfaces.txt
> =20
> =20
>  Endpoint node mandatory properties
> --=20
> 2.11.0
>=20

--sdqeuk7kqid37qbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAln2XjYACgkQ2O7X88g7
+pr7FA/+LHZ2mwOtND9sJRCoyjQDggsOr1TzkHSmwbNNLngaeh8YCGehmfDvKWr5
R4v6GGVwXkc/39HPB42BpXjGDC2tBpXAA74vk91AR7DOQe8eJRwXMWSmlulomU3J
u1/NQaSFO2/2qZJIOxLziS0D7jgagZ0n+YcjSk+QpQbivBKBmXXzmkn/uzoezJiw
QBTWc3TY8ZxdvG9WTz42Skt5/3BnLni2NtuPflmXgn/9kO1M8wSCmVuRuUGKX86l
t1nxRPvIaJtdT2vbCQ7wcV1W1sh+CCEpMcv4KwV4S47ODDA51Ks0rAaytKkLmvrF
M7R2UHauG0tpTJRFQhgJ+ySL/MRBu2+8e3W0RN97NzyfvjlW32fh/XqjELywN/oq
iNvobmTK5z+AkUXtDzIp1+Ez5bv3jqPfnYFxxbrS8J0czL69HW07vo6FWKmKzuMD
VtmtUjg/8F0vbbSy6Kupe4dciAumIFOc9BBBV2M0cznsYlHhc99xTmFnHId5pevi
8IwG0u4OXrliVC9Bjm7SqpqhUPat2VtzHKp46FZhRz/BVkh848tSlVATDAWS836n
6EJF1rjgbwIe7sGtIQFbpE8KxNIICKF54tE8KW7eOCwO8siwvVEY9Jker6NV4yKt
nGGwa8ROyz0CgWKe/TxJjyBDRheE424pDwdwB5aoHn9/N5PQ64Q=
=goB8
-----END PGP SIGNATURE-----

--sdqeuk7kqid37qbs--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
