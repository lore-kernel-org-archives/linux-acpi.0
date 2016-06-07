From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH V6 5/8] vfio: platform: call _RST method when using ACPI
Date: Tue, 7 Jun 2016 22:14:56 +0200
Message-ID: <d2640403-776d-9af2-9014-638453403446@redhat.com>
References: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
 <1464472878-27176-6-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46387 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162054AbcFGUPG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Jun 2016 16:15:06 -0400
In-Reply-To: <1464472878-27176-6-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, eric.auger@linaro.org
Cc: linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org

Hi Sinan,
Le 29/05/2016 =E0 00:01, Sinan Kaya a =E9crit :
> The device tree code checks for the presence of a reset driver and ca=
lls
> the of_reset function pointer by looking up the reset driver as a mod=
ule.
>=20
> ACPI defines _RST method to perform device level reset. After the _RS=
T
> method is executed, the OS can resume using the device. _RST method i=
s
> expected to stop DMA transfers and IRQs.
>=20
> This patch checks the presence of _RST method and calls the _RST
> method when reset is requested.
>=20
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Reviewed-by: Eric Auger <eric.auger@linaro.org>
code has changed compared to previous version and the R-b. In the futur=
e, please add change logs.
Besides it looks ok to me.

Best Regards

Eric

> ---
>  drivers/vfio/platform/vfio_platform_common.c | 51 ++++++++++++++++++=
++++++++++
>  1 file changed, 51 insertions(+)
>=20
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/v=
fio/platform/vfio_platform_common.c
> index e7ce2c2..0ea8c26 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -73,21 +73,66 @@ static int vfio_platform_acpi_probe(struct vfio_p=
latform_device *vdev,
>  	}
>  	return 0;
>  }
> +
> +static int vfio_platform_acpi_call_reset(struct vfio_platform_device=
 *vdev,
> +					 const char **extra_dbg)
> +{
> +	struct device *dev =3D vdev->device;
> +	acpi_handle handle =3D ACPI_HANDLE(dev);
> +	acpi_status acpi_ret;
> +	unsigned long long val;
> +
> +	acpi_ret =3D acpi_evaluate_integer(handle, "_RST", NULL, &val);
> +	if (ACPI_FAILURE(acpi_ret)) {
> +		if (extra_dbg)
> +			*extra_dbg =3D acpi_format_exception(acpi_ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool vfio_platform_acpi_has_reset(struct vfio_platform_device=
 *vdev)
> +{
> +	struct device *dev =3D vdev->device;
> +	acpi_handle handle =3D ACPI_HANDLE(dev);
> +
> +	return acpi_has_method(handle, "_RST");
> +}
>  #else
>  static inline int vfio_platform_acpi_probe(struct vfio_platform_devi=
ce *vdev,
>  					   struct device *dev)
>  {
>  	return -ENOENT;
>  }
> +
> +static inline
> +int vfio_platform_acpi_call_reset(struct vfio_platform_device *vdev,
> +				  const char **extra_dbg)
> +{
> +	return -ENOENT;
> +}
> +
> +static inline
> +bool vfio_platform_acpi_has_reset(struct vfio_platform_device *vdev)
> +{
> +	return false;
> +}
>  #endif
> =20
>  static bool vfio_platform_has_reset(struct vfio_platform_device *vde=
v)
>  {
> +	if (vdev->acpihid)
> +		return vfio_platform_acpi_has_reset(vdev);
> +
>  	return vdev->of_reset ? true : false;
>  }
> =20
>  static void vfio_platform_get_reset(struct vfio_platform_device *vde=
v)
>  {
> +	if (vdev->acpihid)
> +		return;
> +
>  	vdev->of_reset =3D vfio_platform_lookup_reset(vdev->compat,
>  						    &vdev->reset_module);
>  	if (!vdev->of_reset) {
> @@ -99,6 +144,9 @@ static void vfio_platform_get_reset(struct vfio_pl=
atform_device *vdev)
> =20
>  static void vfio_platform_put_reset(struct vfio_platform_device *vde=
v)
>  {
> +	if (vdev->acpihid)
> +		return;
> +
>  	if (vdev->of_reset)
>  		module_put(vdev->reset_module);
>  }
> @@ -177,6 +225,9 @@ static int vfio_platform_call_reset(struct vfio_p=
latform_device *vdev,
>  	if (vdev->of_reset) {
>  		dev_info(vdev->device, "reset\n");
>  		return vdev->of_reset(vdev);
> +	} else if (vdev->acpihid) {
> +		dev_info(vdev->device, "reset\n");
> +		return vfio_platform_acpi_call_reset(vdev, extra_dbg);
>  	}
> =20
>  	dev_warn(vdev->device, "no reset function found!\n");
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
