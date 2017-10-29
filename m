From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v16 20/32] dt: bindings: Add a binding for flash LED
 devices associated to a sensor
Date: Sun, 29 Oct 2017 23:26:43 +0100
Message-ID: <20171029222643.hncpyrvlkbrg2k57@earth>
References: <20171026075342.5760-1-sakari.ailus@linux.intel.com>
 <20171026075342.5760-21-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y2d6l53w2cbhvhga"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171026075342.5760-21-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--y2d6l53w2cbhvhga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 26, 2017 at 10:53:30AM +0300, Sakari Ailus wrote:
> Camera flash drivers (and LEDs) are separate from the sensor devices in
> DT. In order to make an association between the two, provide the
> association information to the software.
>=20
> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Acked-by: Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
> Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

-- Sebastian

>  Documentation/devicetree/bindings/media/video-interfaces.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/media/video-interfaces.txt=
 b/Documentation/devicetree/bindings/media/video-interfaces.txt
> index bd6474920510..dc66e3224692 100644
> --- a/Documentation/devicetree/bindings/media/video-interfaces.txt
> +++ b/Documentation/devicetree/bindings/media/video-interfaces.txt
> @@ -76,6 +76,14 @@ are required in a relevant parent node:
>  		    identifier, should be 1.
>   - #size-cells    : should be zero.
> =20
> +
> +Optional properties
> +-------------------
> +
> +- flash-leds: An array of phandles, each referring to a flash LED, a sub=
-node
> +  of the LED driver device node.
> +
> +
>  Optional endpoint properties
>  ----------------------------
> =20
> --=20
> 2.11.0
>=20

--y2d6l53w2cbhvhga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAln2VaMACgkQ2O7X88g7
+pqpyA//ZAshtDhYm9LJqNOpXhw0XSjSWGgNwpayFfoLZ/G7TcpTROB7tYE9atjZ
6Cbbl7bYdBDr07d4r4QI5/AgzsjZnjUDhvkCW8vT+6em7vY37nHPkcoTv2VOcqgJ
IVrSzPybs94CKrhc8u1x4qJWRaLzcPi9Gi8T/wgC8ayOG0RybwvenwNY+xqJ1UD7
65Hlqa5c3JNjaTNEfRLGMJxVbeO/eS4M946YJDzoCjCZwX1vJBBvBpqgnO10paaa
WVx90XCDbY3t/asMH6ld8q8jmszzauSXy0jTmt5U8kS+giqY5IorcRSLRctOd0kp
OJqEMszDEKYkAHagztnBvcc27UD+l77GMnQZm6syo0jhiC3GwkXm0+NnChPL+ZGz
NErLudA2Y6uHJO0IfaH4Dk80rPFTnoFJrPY7T+71B6Nla8Cakm6OTsMGp5OcySBo
QugHMHbLzFLTAasB3nnXPykBLHqQNIB1zTk79fKFutUmXH03DoQGUr8o0iBnCodU
8z3wIyJaCk2M0wRNu9/BuHbzUyYqNqF6bULl6AC2k0ApCIBl2efONq44Yy+3KF0i
X1uLwVN1ZX1dIwcOpR1BwMNnSALK5C8GT/SLrxK4p9Nzy83+PZzHKoWA4sW/1BhO
SCXZLAiJSNDCyZ9+w8tD0x0DwQFd5n70hObQJ4BTB7lgVGJXAFo=
=/v65
-----END PGP SIGNATURE-----

--y2d6l53w2cbhvhga--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
