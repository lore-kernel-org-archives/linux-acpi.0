From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH V6 8/8] vfio: platform: check reset call return code
 during release
Date: Tue, 7 Jun 2016 22:28:25 +0200
Message-ID: <2ecf0796-f711-8554-9567-061f3ac5e6eb@redhat.com>
References: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
 <1464472878-27176-9-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33495 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753216AbcFGU2b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Jun 2016 16:28:31 -0400
In-Reply-To: <1464472878-27176-9-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, eric.auger@linaro.org
Cc: linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org

Hi Sinan,
Le 29/05/2016 =E0 00:01, Sinan Kaya a =E9crit :
> Release call is ignoring the return code from reset call and can
> potentially continue even though reset call failed.
>=20
> If reset_required module parameter is set, this patch is going
> to validate the return code and will cause stack dump with
> WARN_ON and warn the user of failure.
>=20
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/vfio/platform/vfio_platform_common.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/v=
fio/platform/vfio_platform_common.c
> index 962cfb1..bb05ca0 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -243,7 +243,15 @@ static void vfio_platform_release(void *device_d=
ata)
>  	mutex_lock(&driver_lock);
> =20
>  	if (!(--vdev->refcnt)) {
> -		vfio_platform_call_reset(vdev, NULL);
> +		const char *extra_dbg =3D NULL;
> +		int ret;
> +
> +		ret =3D vfio_platform_call_reset(vdev, &extra_dbg);
> +		if (ret && vdev->reset_required) {
> +			dev_warn(vdev->device, "reset driver is required and reset call f=
ailed in release (%d) %s\n",
> +				 ret, extra_dbg ? extra_dbg : "");
> +			WARN_ON(1);
> +		}
>  		vfio_platform_regions_cleanup(vdev);
>  		vfio_platform_irq_cleanup(vdev);
>  	}
>=20
Looks OK to me
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
