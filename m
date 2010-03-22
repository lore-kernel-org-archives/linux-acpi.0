From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] Fix key f70f4b50 not in .data in thermal_sys
Date: Mon, 22 Mar 2010 14:31:38 +0100
Message-ID: <20100322133138.GA1076@pengutronix.de>
References: <20100309102754.GA3316@swordfish.minsk.epam.com> <20100309141826.GC28606@suse.de> <20100322131508.GB3596@swordfish.minsk.epam.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46266 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab0CVNbm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Mar 2010 09:31:42 -0400
Content-Disposition: inline
In-Reply-To: <20100322131508.GB3596@swordfish.minsk.epam.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Greg KH <gregkh@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2010 at 03:15:08PM +0200, Sergey Senozhatsky wrote:
> Initialize sysfs attributes before device_create_file call.
>=20
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>=20
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 5066de5..a76a6ff 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -492,6 +492,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *t=
z)
>  		goto free_mem;
>  	}
>  	dev_set_drvdata(hwmon->device, hwmon);
> +	sysfs_attr_init(&dev_attr_name.attr);
>  	result =3D device_create_file(hwmon->device, &dev_attr_name);

This one should not be needed? Is declared static in line 426.

>  	if (result)
>  		goto unregister_hwmon_device;
> @@ -505,6 +506,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *t=
z)
>  	tz->temp_input.attr.attr.name =3D tz->temp_input.name;
>  	tz->temp_input.attr.attr.mode =3D 0444;
>  	tz->temp_input.attr.show =3D temp_input_show;
> +	sysfs_attr_init(&tz->temp_input.attr.attr);
>  	result =3D device_create_file(hwmon->device, &tz->temp_input.attr);
>  	if (result)
>  		goto unregister_hwmon_device;
> @@ -517,6 +519,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *t=
z)
>  			tz->temp_crit.attr.attr.name =3D tz->temp_crit.name;
>  			tz->temp_crit.attr.attr.mode =3D 0444;
>  			tz->temp_crit.attr.show =3D temp_crit_show;
> +			sysfs_attr_init(&tz->temp_crit.attr.attr);

Those encapsuled attributes are trickier to find, sigh...

Regards,

   Wolfram


--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuncToACgkQD27XaX1/VRuQ3wCePHjOiy48XWDAVnNk5+7AxFo0
QhoAoMNAdb9n8eolxYeMz0MyFj+DO0Az
=kAze
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
