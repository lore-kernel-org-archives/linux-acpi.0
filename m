From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v16 16/32] v4l: async: Allow async notifier register call
 succeed with no subdevs
Date: Fri, 27 Oct 2017 16:49:35 +0200
Message-ID: <20171027144934.jhgvgehf4jblgoet@earth>
References: <20171026075342.5760-1-sakari.ailus@linux.intel.com>
 <20171026075342.5760-17-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ezsyaa45ehfhihqy"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171026075342.5760-17-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--ezsyaa45ehfhihqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 26, 2017 at 10:53:26AM +0300, Sakari Ailus wrote:
> The information on how many async sub-devices would be bindable to a
> notifier is typically dependent on information from platform firmware and
> it's not driver's business to be aware of that.
>=20
> Many V4L2 main drivers are perfectly usable (and useful) without async
> sub-devices and so if there aren't any around, just proceed call the
> notifier's complete callback immediately without registering the notifier
> itself.
>=20
> If a driver needs to check whether there are async sub-devices available,
> it can be done by inspecting the notifier's num_subdevs field which tells
> the number of async sub-devices.
>=20
> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Acked-by: Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

-- Sebastian

>  drivers/media/v4l2-core/v4l2-async.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-co=
re/v4l2-async.c
> index 46db85685894..1b536d68cedf 100644
> --- a/drivers/media/v4l2-core/v4l2-async.c
> +++ b/drivers/media/v4l2-core/v4l2-async.c
> @@ -180,14 +180,22 @@ int v4l2_async_notifier_register(struct v4l2_device=
 *v4l2_dev,
>  	int ret;
>  	int i;
> =20
> -	if (!v4l2_dev || !notifier->num_subdevs ||
> -	    notifier->num_subdevs > V4L2_MAX_SUBDEVS)
> +	if (!v4l2_dev || notifier->num_subdevs > V4L2_MAX_SUBDEVS)
>  		return -EINVAL;
> =20
>  	notifier->v4l2_dev =3D v4l2_dev;
>  	INIT_LIST_HEAD(&notifier->waiting);
>  	INIT_LIST_HEAD(&notifier->done);
> =20
> +	if (!notifier->num_subdevs) {
> +		int ret;
> +
> +		ret =3D v4l2_async_notifier_call_complete(notifier);
> +		notifier->v4l2_dev =3D NULL;
> +
> +		return ret;
> +	}
> +
>  	for (i =3D 0; i < notifier->num_subdevs; i++) {
>  		asd =3D notifier->subdevs[i];
> =20
> --=20
> 2.11.0
>=20

--ezsyaa45ehfhihqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnzR34ACgkQ2O7X88g7
+potRA/+O1su/7Aft1Bt0yrE3vsN07KMRCUTE7u/8NEM8Kqjsu9SOeZXGzi9eLpo
xgUYqzaamCLyd9jY/kiO1ohHHcXcxCpPV9iwmt576KO+uDORDLwJX8MHWwZrcY4U
0YTrKCziQYAOAkaOf53n+a3AVz5nDR5bmxXCkdWps89yjVjj3DWAMLPMd2SsLPoM
FCnnU8rGARHRsC1yzc1+rOL9aGVx7TcU5N+RzYwdvw+S98aZGbLyEi2omUqTpJr7
Ps8yUmhvnEcZLzc5F5NLoYiX984wTuwGnSi7Lnp8nvN+qspdCSHvbNHk4GBuIzqs
mu12nwv5z6rZCIvfjcW23pgQa/Rm1tk+CnTW1w3L1o4pFtCqM6HYK81Je2wapEAv
kobFRi5UYpaZ5h/cA/E17sfhkgCo9qd/R9Ac0SDjYP3JDvAzJmrjyyk98KF7Afby
GcIAyn8DrfmgMd9lNZqo0/Yo2SCyLC8tpyZ+CQVQVfDN4KYPzUnlXDxB5mXI74+4
5FIWoXKPWl0/gRJkN4nQn3WdP4Omget7Iodk7GHXj8gv0KN/OpnEcBWRaxs0pyDU
9oUm1vaUcOy61RUwJkVA/u1j4kZ+Qna5mdQDstOGhzaimulg6/w0uge05V6wysOX
cTziDKCK9sVb8IpKyMijaNJANUVWBqqH1axxMghsj6Wb8rP5vHU=
=EOWq
-----END PGP SIGNATURE-----

--ezsyaa45ehfhihqy--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
