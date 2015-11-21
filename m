From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] dell-rbtn: Ignore ACPI notifications if device is suspended
Date: Sat, 21 Nov 2015 20:18:04 +0100
Message-ID: <201511212018.04685@pali>
References: <1448115375-7315-1-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2096723.Qf7KcyUCc1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1448115375-7315-1-git-send-email-gabriele.mzt@gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: dvhart@infradead.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--nextPart2096723.Qf7KcyUCc1
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 21 November 2015 15:16:15 Gabriele Mazzotta wrote:
> Some BIOSes unconditionally send an ACPI notification to RBTN when
> the system is resuming from suspend. This makes dell-rbtn send an
> input event to userspace as if a function key was pressed. Prevent
> this by ignoring all the notifications received while the device is
> suspended.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D106031
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>

Looks like we need to ignore ACPI events when RBTN device is suspended.=20
So for me it is OK. If ACPI people are OK with implementation, add my=20
Acked-By: Pali Roh=C3=A1r <pali.rohar@gmail.com>

> ---
>  drivers/platform/x86/dell-rbtn.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/drivers/platform/x86/dell-rbtn.c
> b/drivers/platform/x86/dell-rbtn.c index cd410e3..1d64b72 100644
> --- a/drivers/platform/x86/dell-rbtn.c
> +++ b/drivers/platform/x86/dell-rbtn.c
> @@ -28,6 +28,7 @@ struct rbtn_data {
>  	enum rbtn_type type;
>  	struct rfkill *rfkill;
>  	struct input_dev *input_dev;
> +	bool suspended;
>  };
>=20
>=20
> @@ -220,9 +221,33 @@ static const struct acpi_device_id rbtn_ids[] =3D
> { { "", 0 },
>  };
>=20
> +#ifdef CONFIG_PM_SLEEP
> +static int rbtn_suspend(struct device *dev)
> +{
> +	struct acpi_device *device =3D to_acpi_device(dev);
> +	struct rbtn_data *rbtn_data =3D acpi_driver_data(device);
> +
> +	rbtn_data->suspended =3D true;
> +
> +	return 0;
> +}
> +
> +static int rbtn_resume(struct device *dev)
> +{
> +	struct acpi_device *device =3D to_acpi_device(dev);
> +	struct rbtn_data *rbtn_data =3D acpi_driver_data(device);
> +
> +	rbtn_data->suspended =3D false;
> +
> +	return 0;
> +}
> +#endif
> +static SIMPLE_DEV_PM_OPS(rbtn_pm_ops, rbtn_suspend, rbtn_resume);
> +
>  static struct acpi_driver rbtn_driver =3D {
>  	.name =3D "dell-rbtn",
>  	.ids =3D rbtn_ids,
> +	.drv.pm =3D &rbtn_pm_ops,
>  	.ops =3D {
>  		.add =3D rbtn_add,
>  		.remove =3D rbtn_remove,
> @@ -384,6 +409,9 @@ static void rbtn_notify(struct acpi_device
> *device, u32 event) {
>  	struct rbtn_data *rbtn_data =3D device->driver_data;
>=20
> +	if (rbtn_data->suspended)
> +		return;
> +
>  	if (event !=3D 0x80) {
>  		dev_info(&device->dev, "Received unknown event (0x%x)\n",
>  			 event);

CCing Rafael & linux-acpi.

Is this correct way (via "suspended" variable and hooks in PM) how to=20
ignore ACPI events when device is suspended?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2096723.Qf7KcyUCc1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlZQw2wACgkQi/DJPQPkQ1LppQCfYB5yyxT/Xmol59xGdKMzKXnC
qkUAnRrAmPoKyPk2s8qGdKiUpD31rOgD
=W1SI
-----END PGP SIGNATURE-----

--nextPart2096723.Qf7KcyUCc1--
