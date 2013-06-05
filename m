From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH] ACPI / APEI: fix error return code in einj_init()
Date: Tue, 4 Jun 2013 22:59:27 -0400
Message-ID: <20130605025927.GD27550@gchen.bj.intel.com>
References: <CAPgLHd-uB=hWRNCgoUhzFzsjQiPj1cuedUk0ttu1g7UXAx=3=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:22122 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971Ab3FEDGt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Jun 2013 23:06:49 -0400
Content-Disposition: inline
In-Reply-To: <CAPgLHd-uB=hWRNCgoUhzFzsjQiPj1cuedUk0ttu1g7UXAx=3=Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: lenb@kernel.org, rjw@sisk.pl, tony.luck@intel.com, yongjun_wei@trendmicro.com.cn, linux-acpi@vger.kernel.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2013 at 10:17:35AM +0800, Wei Yongjun wrote:
> Date: Wed, 5 Jun 2013 10:17:35 +0800
> From: Wei Yongjun <weiyj.lk@gmail.com>
> To: lenb@kernel.org, rjw@sisk.pl, gong.chen@linux.intel.com,
>  tony.luck@intel.com
> Cc: yongjun_wei@trendmicro.com.cn, linux-acpi@vger.kernel.org
> Subject: [PATCH] ACPI / APEI: fix error return code in einj_init()
>=20
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Fix to return -ENOMEM in the debugfs_create_xxx() error handling
> case instead of 0, as done elsewhere in this function.
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/acpi/apei/einj.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 9a47d85..9d60bdd 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -732,6 +732,7 @@ static int __init einj_init(void)
>  	if (rc)
>  		goto err_release;
> =20
> +	rc =3D -ENOMEM;
>  	einj_param =3D einj_get_parameter_address();
>  	if ((param_extension || acpi5) && einj_param) {
>  		fentry =3D debugfs_create_x64("param1", S_IRUSR | S_IWUSR,
>=20
OK to me.

Reviewed-by: Chen Gong <gong.chen@linux.intel.com>

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRrqmPAAoJEI01n1+kOSLH/ZkP/iSwP8yZTF3f0RGZMZi6Yh/V
9bX2OZwfM0gYCdtDoAveEGy1CeSmkZqpB0bTDQmEovgF1Mr7ztRO5ZyLqS7x223S
gREsntTk8F/L3prjv3NlHMQYUPifCttez3CJ3FOPaCA4l4vGyNpRNHvG4PPZQRtD
eRf6lNacC90agyC4WU2jBwFnJf4GM3Nj9ESlLWP0xhpgwGx5OUlKUc2xAj6ZTs31
Nyulck0azdW+O9JDw9kjB10khltLlHCtuPSwJSdbPwUSaGCmkLuVXG7li/399WfH
LtyQNCvmbzN6aq153DyZCJABvW4uecUJIu0RhvTNUYq0fV7C9bJrw+r426borRSJ
B9x/TweWrJUakZHfrb2H22aLTj1eaADQxMFdrNyrtdkNz4aJ9wXWpkRXJYo51JoN
AQD+xJ2NOYcsgprdNLZf7e4q0ejrXGlXIJcItJR6sTHw29WWcgwjOQ/OYKpof5gt
PaYshE3sujNBvv1GgGINFH8l32q4giOnksEy+yHeJffrYdwFagau+5Dn3MKLTbBG
RW/swpQAig/oiD2YdpgYHXK1WyoIxBu4Iap0lcrdLsE/vTOKARVBWHcDN0M4gpyJ
e9rsc2qMTFdJXO7DWkH6ZQyniuDaxL62lUgkx77fF8+AlxH6QwKRSjywKEQ9L9nm
mVq5VnnTQjE2zBnVxHkX
=AE5L
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
