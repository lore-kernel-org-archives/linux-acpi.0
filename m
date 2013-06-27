From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI/fan: Initialize acpi_state variable
Date: Thu, 27 Jun 2013 14:28:56 +0200
Message-ID: <6743122.cV0P3hQa28@vostro.rjw.lan>
References: <1372331314-31010-1-git-send-email-naresh.bhat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:53201 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916Ab3F0MT0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jun 2013 08:19:26 -0400
In-Reply-To: <1372331314-31010-1-git-send-email-naresh.bhat@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: naresh.bhat@linaro.org
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org

On Thursday, June 27, 2013 04:38:34 PM naresh.bhat@linaro.org wrote:
> From: Naresh Bhat <naresh.bhat@linaro.org>
>=20
>   CC      drivers/acpi/fan.o
> drivers/acpi/fan.c: In function =E2=80=98fan_get_cur_state=E2=80=99:
> drivers/acpi/fan.c:96:9: warning: =E2=80=98acpi_state=E2=80=99 may be=
 used uninitialized in this function [-Wuninitialized]
> ---
>  drivers/acpi/fan.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index f815da8..f61f7fd 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -84,7 +84,7 @@ static int fan_get_cur_state(struct thermal_cooling=
_device *cdev, unsigned long
>  {
>  	struct acpi_device *device =3D cdev->devdata;
>  	int result;
> -	int acpi_state;
> +	int acpi_state =3D 0;

Please use an appropriate symbol here.

> =20
>  	if (!device)
>  		return -EINVAL;
>=20

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
