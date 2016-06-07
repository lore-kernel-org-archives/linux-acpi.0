From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH V6 7/8] vfio: platform: check reset call return code
 during open
Date: Tue, 7 Jun 2016 22:21:13 +0200
Message-ID: <5ae51f93-d141-00bf-f58f-40fbf7b1307d@redhat.com>
References: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
 <1464472878-27176-8-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464472878-27176-8-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, eric.auger@linaro.org
Cc: linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Sinan,
Le 29/05/2016 =E0 00:01, Sinan Kaya a =E9crit :
> Open call is ignoring the return code from reset call and can
> potentially continue even though reset call failed.
>=20
> If reset_required module parameter is set, this patch is going
> to validate the return code and will abort open if reset fails.
>=20
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/vfio/platform/vfio_platform_common.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/v=
fio/platform/vfio_platform_common.c
> index e87ceab..962cfb1 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -264,6 +264,8 @@ static int vfio_platform_open(void *device_data)
>  	mutex_lock(&driver_lock);
> =20
>  	if (!vdev->refcnt) {
> +		const char *extra_dbg =3D NULL;
> +
>  		ret =3D vfio_platform_regions_init(vdev);
>  		if (ret)
>  			goto err_reg;
> @@ -272,7 +274,12 @@ static int vfio_platform_open(void *device_data)
>  		if (ret)
>  			goto err_irq;
> =20
> -		vfio_platform_call_reset(vdev, NULL);
> +		ret =3D vfio_platform_call_reset(vdev, &extra_dbg);
> +		if (ret && vdev->reset_required) {
> +			dev_warn(vdev->device, "reset driver is required and reset call f=
ailed in open (%d) %s\n",
> +				 ret, extra_dbg ? extra_dbg : "");
> +			goto err_irq;
I am afraid you need to tear down the resources allocated by vfio_platf=
orm_irq_init.=20

Best Regards

Eric
> +		}
>  	}
> =20
>  	vdev->refcnt++;
>=20
