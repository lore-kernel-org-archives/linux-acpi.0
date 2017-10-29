From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v16 31/32] ov13858: Add support for flash and lens devices
Date: Mon, 30 Oct 2017 00:06:08 +0100
Message-ID: <20171029230608.syxyfisvvsysr352@earth>
References: <20171026075342.5760-1-sakari.ailus@linux.intel.com>
 <20171026075342.5760-32-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wdfen5xviiq3gjk3"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171026075342.5760-32-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--wdfen5xviiq3gjk3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 26, 2017 at 10:53:41AM +0300, Sakari Ailus wrote:
> Parse async sub-devices related to the sensor by switching the async
> sub-device registration function.
>=20
> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Acked-by: Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

-- Sebastian

>  drivers/media/i2c/ov13858.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/i2c/ov13858.c b/drivers/media/i2c/ov13858.c
> index fdce2befed02..bf7d06f3f21a 100644
> --- a/drivers/media/i2c/ov13858.c
> +++ b/drivers/media/i2c/ov13858.c
> @@ -1761,7 +1761,7 @@ static int ov13858_probe(struct i2c_client *client,
>  		goto error_handler_free;
>  	}
> =20
> -	ret =3D v4l2_async_register_subdev(&ov13858->sd);
> +	ret =3D v4l2_async_register_subdev_sensor_common(&ov13858->sd);
>  	if (ret < 0)
>  		goto error_media_entity;
> =20
> --=20
> 2.11.0
>=20

--wdfen5xviiq3gjk3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAln2XuAACgkQ2O7X88g7
+ppEhQ//UQCQFrJXW4nRYdj5kbqzVFlsZQsApNRY2SPi9wP4YmfBswhZ2Z6pP1RT
CO6FHsVVrKgoj1CHBegDX1zbNGuCj15E8FYIvV5gewkJ4vFU49JcJvvc1qOLUrRU
dz+bcm7DhH4uQ0WeX2BsEHL26Q5UZDpuezA5LZ5P4NNoIX/Rnkkprz5UPcLDEh4+
21vszU+uHeDo7ZNjx0L/nhq9LceI+ohCt+2ZWj+ouN/vT0fmg6lOvTt+tLGXXwKK
iUpnWh3OxYL951GZuR5R+a4EGfEzQP2oWbyIIgXaYnmOCdsgZ31cJiolExwuxMMR
TSbMtzz9rGa+fTZHU4sCLkg+r42mg7NAdzE4OwCmt1zzw6/UOfT1OXl+NX1SZUxt
5LmVurjUlKqCSD0u4MQo3LZC/Mmpa8nS4PPSDcdxsfAz88lRtKPWySRqFhzn7q//
W4dd6xLARmKCEk4hdh4SZ8SQYZ8qJxbQfOzxlK6ZUwTAPMGJsZFZELnzzZBQQsd+
OtLkSOmIFr7GV1V+1fpfh/jv806P4YIYg482GkL58yX/DW99M+QBGnBWlxgJmWKQ
/vbjZ0xK1YlkxeuRucN8f/LMYRSbLGSfafhtldENDBJoSx5reelPf+BSN9vv5034
PZTawIUScKtW+7htG81rRK009W7GmxP4f5NyNMmQ7IiBeCWOJ9o=
=y1Rx
-----END PGP SIGNATURE-----

--wdfen5xviiq3gjk3--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
