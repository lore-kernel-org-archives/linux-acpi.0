From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH 1/1] ACPI: ghes: Remove redundant platform_set_drvdata()
Date: Mon, 3 Jun 2013 23:18:28 -0400
Message-ID: <20130604031828.GA20448@gchen.bj.intel.com>
References: <1369827977-29975-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15835 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754186Ab3FDDZs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Jun 2013 23:25:48 -0400
Content-Disposition: inline
In-Reply-To: <1369827977-29975-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-acpi@vger.kernel.org, rjw@sisk.pl, lenb@kernel.org, Huang Ying <ying.huang@intel.com>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 05:16:17PM +0530, Sachin Kamat wrote:
> Date:	Wed, 29 May 2013 17:16:17 +0530
> From: Sachin Kamat <sachin.kamat@linaro.org>
> To: linux-acpi@vger.kernel.org
> Cc: rjw@sisk.pl, lenb@kernel.org, sachin.kamat@linaro.org, Huang Ying
>  <ying.huang@intel.com>
> Subject: [PATCH 1/1] ACPI: ghes: Remove redundant platform_set_drvdata()
> X-Mailer: git-send-email 1.7.9.5
>=20
> Commit 0998d06310 (device-core: Ensure drvdata =3D NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
>=20
Your description doesn't give any meaningful explanation.

> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Huang Ying <ying.huang@intel.com>
> ---
>  drivers/acpi/apei/ghes.c |    2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d668a8a..e03c20e 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1011,8 +1011,6 @@ static int ghes_remove(struct platform_device *ghes=
_dev)
> =20
>  	kfree(ghes);
> =20
> -	platform_set_drvdata(ghes_dev, NULL);
> -
>  	return 0;
>  }
> =20
> --=20
> 1.7.9.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRrVyEAAoJEI01n1+kOSLH8lkP/2MHUPeW+SCK3Xa8JhbyL6Vx
fDSkGxZ1LaCqItGu4XfR0zuKFIvvEaIfdDjQzf2hOFCOpFljUM6jXCQ59usAGeyE
Gdx6f3q4NiwaF3E4SPjPYvmrBNpAMUkRloXLTBqUUxgSKJjo2SJaGMFpyeEMQPGg
H4S9BTRUwmVUv1cLuhc9oim9/RAtQjwRUbgfq+d+BzCqHa4SZpAakmOUydnlN9/1
w7SgtwnUY8poDiyewVOs0XmusqmI0f5DOmmq5sq0U7l727u+2Rp3CYa9La/hCxxo
qEE9FI72/8cnAbPbA+f/7vGPh+W3V4TKxZ8oADom8K5LLlMMdnfzt+3sW8MwhMmV
fE3u2nJSLXddzOlUJRM0OBmeyqKq47/FVe0STPdmy+umsi1qlxz9ie/oxyWuCrpN
gGzvyfRGkU8LebXfY9pP2CiMZKCnH7HqfQaEsxxBGe2vcxq3CmA3IEg4uvxsZwyE
q5bVmFhqOZhLxsoVyj+QpIv7Mb4M2XglPzJ3YK1VCYWuaD/SgoFhv7Dicl6J0FxP
CQhH8pYxkQ1vjPvSctvI+uuZfiitGsV7vDdrHk2ltjvB8KJrzk08B6bSBzfuEAe/
rhNAIwTJhRTjJLf6tYHbPHaMNxAOfJX6b2VmbamQYJFetkXavjSwMqjsOrRXWwT8
MmJCioS6dIJEIHmERoIl
=2ICO
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
