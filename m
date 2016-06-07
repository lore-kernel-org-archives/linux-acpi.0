From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH V6 6/8] vfio, platform: make reset driver a requirement by
 default
Date: Tue, 7 Jun 2016 21:59:56 +0200
Message-ID: <c3538f11-d206-1ffc-35e0-ff5a7672c7d9@redhat.com>
References: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
 <1464472878-27176-7-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464472878-27176-7-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, eric.auger@linaro.org
Cc: linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



Le 29/05/2016 =E0 00:01, Sinan Kaya a =E9crit :
> The code was allowing platform devices to be used without a supportin=
g
> VFIO reset driver. The hardware can be left in some inconsistent stat=
e
> after a guest machine abort.
>=20
> The reset driver will put the hardware back to safe state and disable
> interrupts before returning the control back to the host machine.
>=20
> Adding a new reset_required kernel module option to AMBA and platform
> VFIO drivers with a default value of true.
>=20
> New requirements are:
> 1. A reset function needs to be implemented by the corresponding driv=
er
> via DT/ACPI.
> 2. The reset function needs to be discovered via DT/ACPI.
>=20
> The probe of the driver will fail if any of the above conditions are
> not satisfied.
>=20
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/vfio/platform/vfio_amba.c             |  5 +++++
>  drivers/vfio/platform/vfio_platform.c         |  5 +++++
>  drivers/vfio/platform/vfio_platform_common.c  | 14 +++++++++++---
>  drivers/vfio/platform/vfio_platform_private.h |  1 +
>  4 files changed, 22 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platfor=
m/vfio_amba.c
> index a66479b..7585902 100644
> --- a/drivers/vfio/platform/vfio_amba.c
> +++ b/drivers/vfio/platform/vfio_amba.c
> @@ -23,6 +23,10 @@
>  #define DRIVER_AUTHOR   "Antonios Motakis <a.motakis@virtualopensyst=
ems.com>"
>  #define DRIVER_DESC     "VFIO for AMBA devices - User Level meta-dri=
ver"
> =20
> +static bool reset_required =3D true;
> +module_param(reset_required, bool, 0644);
> +MODULE_PARM_DESC(reset_required, "override reset requirement (defaul=
t: 1)");
> +
>  /* probing devices from the AMBA bus */
> =20
>  static struct resource *get_amba_resource(struct vfio_platform_devic=
e *vdev,
> @@ -68,6 +72,7 @@ static int vfio_amba_probe(struct amba_device *adev=
, const struct amba_id *id)
>  	vdev->get_resource =3D get_amba_resource;
>  	vdev->get_irq =3D get_amba_irq;
>  	vdev->parent_module =3D THIS_MODULE;
> +	vdev->reset_required =3D reset_required;
> =20
>  	ret =3D vfio_platform_probe_common(vdev, &adev->dev);
>  	if (ret) {
> diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/pla=
tform/vfio_platform.c
> index b1cc3a7..ef89146 100644
> --- a/drivers/vfio/platform/vfio_platform.c
> +++ b/drivers/vfio/platform/vfio_platform.c
> @@ -23,6 +23,10 @@
>  #define DRIVER_AUTHOR   "Antonios Motakis <a.motakis@virtualopensyst=
ems.com>"
>  #define DRIVER_DESC     "VFIO for platform devices - User Level meta=
-driver"
> =20
> +static bool reset_required =3D true;
> +module_param(reset_required, bool, 0644);
> +MODULE_PARM_DESC(reset_required, "override reset requirement (defaul=
t: 1)");
> +
>  /* probing devices from the linux platform bus */
> =20
>  static struct resource *get_platform_resource(struct vfio_platform_d=
evice *vdev,
> @@ -66,6 +70,7 @@ static int vfio_platform_probe(struct platform_devi=
ce *pdev)
>  	vdev->get_resource =3D get_platform_resource;
>  	vdev->get_irq =3D get_platform_irq;
>  	vdev->parent_module =3D THIS_MODULE;
> +	vdev->reset_required =3D reset_required;
> =20
>  	ret =3D vfio_platform_probe_common(vdev, &pdev->dev);
>  	if (ret)
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/v=
fio/platform/vfio_platform_common.c
> index 0ea8c26..e87ceab 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -128,10 +128,10 @@ static bool vfio_platform_has_reset(struct vfio=
_platform_device *vdev)
>  	return vdev->of_reset ? true : false;
>  }
> =20
> -static void vfio_platform_get_reset(struct vfio_platform_device *vde=
v)
> +static int vfio_platform_get_reset(struct vfio_platform_device *vdev=
)
>  {
>  	if (vdev->acpihid)
> -		return;
> +		return vfio_platform_acpi_has_reset(vdev) ? 0 : -ENOENT;
> =20
>  	vdev->of_reset =3D vfio_platform_lookup_reset(vdev->compat,
>  						    &vdev->reset_module);
> @@ -140,6 +140,8 @@ static void vfio_platform_get_reset(struct vfio_p=
latform_device *vdev)
>  		vdev->of_reset =3D vfio_platform_lookup_reset(vdev->compat,
>  							&vdev->reset_module);
>  	}
> +
> +	return vdev->of_reset ? 0 : -ENOENT;
>  }
> =20
>  static void vfio_platform_put_reset(struct vfio_platform_device *vde=
v)
> @@ -675,7 +677,13 @@ int vfio_platform_probe_common(struct vfio_platf=
orm_device *vdev,
>  		return ret;
>  	}
> =20
> -	vfio_platform_get_reset(vdev);
> +	ret =3D vfio_platform_get_reset(vdev);
> +	if (ret && vdev->reset_required) {
> +		pr_err("vfio: no reset function found for device %s\n",
> +		       vdev->name);
> +		iommu_group_put(group);
> +		return ret;
nit: in case you respin you can factorize the group put and return ret =
in a goto label
(since also used above).

Besides Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> +	}
> =20
>  	mutex_init(&vdev->igate);
> =20
> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/=
vfio/platform/vfio_platform_private.h
> index ba9e4f8..68fbc00 100644
> --- a/drivers/vfio/platform/vfio_platform_private.h
> +++ b/drivers/vfio/platform/vfio_platform_private.h
> @@ -50,6 +50,7 @@ struct vfio_platform_region {
>  };
> =20
>  struct vfio_platform_device {
> +	bool				reset_required;
>  	struct vfio_platform_region	*regions;
>  	u32				num_regions;
>  	struct vfio_platform_irq	*irqs;
>=20
