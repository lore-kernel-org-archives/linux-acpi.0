From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH V5 4/6] vfio: platform: add support for ACPI probe
Date: Tue, 7 Jun 2016 18:33:24 +0200
Message-ID: <430f1c0a-c2ac-211d-8c1b-421b6f450d30@redhat.com>
References: <1463364819-477-1-git-send-email-okaya@codeaurora.org>
 <1463364819-477-5-git-send-email-okaya@codeaurora.org>
 <5743031B.5000208@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45065 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161226AbcFGQdb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Jun 2016 12:33:31 -0400
In-Reply-To: <5743031B.5000208@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Auger <eric.auger@linaro.org>, Sinan Kaya <okaya@codeaurora.org>, kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com
Cc: linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org

Hi Sinan,
Le 23/05/2016 =E0 15:18, Eric Auger a =E9crit :
> On 05/16/2016 04:13 AM, Sinan Kaya wrote:
>> The code is using the compatible DT string to associate a reset driv=
er
>> with the actual device itself. The compatible string does not exist =
on
>> ACPI based systems. HID is the unique identifier for a device driver
>> instead.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/vfio/platform/vfio_platform_common.c  | 58 ++++++++++++++++=
++++++++---
>>  drivers/vfio/platform/vfio_platform_private.h |  1 +
>>  2 files changed, 54 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/=
vfio/platform/vfio_platform_common.c
>> index 25378bd..d859d3b 100644
>> --- a/drivers/vfio/platform/vfio_platform_common.c
>> +++ b/drivers/vfio/platform/vfio_platform_common.c
>> @@ -13,6 +13,7 @@
>>   */
>> =20
>>  #include <linux/device.h>
>> +#include <linux/acpi.h>
>>  #include <linux/iommu.h>
>>  #include <linux/module.h>
>>  #include <linux/mutex.h>
>> @@ -49,6 +50,37 @@ static vfio_platform_reset_fn_t vfio_platform_loo=
kup_reset(const char *compat,
>>  	return reset_fn;
>>  }
>> =20
>> +#ifdef CONFIG_ACPI
>> +int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
>> +			     struct device *dev)
> should be static
>> +{
>> +	struct acpi_device *adev =3D ACPI_COMPANION(dev);
>> +
>> +	if (acpi_disabled)
>> +		return -ENODEV;
>> +
>> +	if (!adev) {
>> +		pr_err("VFIO: ACPI companion device not found for %s\n",
>> +			vdev->name);
>> +		return -ENODEV;
>> +	}
>> +
>> +	vdev->acpihid =3D acpi_device_hid(adev);
>> +	if (!vdev->acpihid) {
>> +		pr_err("VFIO: cannot find ACPI HID for %s\n",
>> +		       vdev->name);
>> +		return -ENODEV;
>> +	}
>> +	return 0;
>> +}
>> +#else
>> +int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
>> +			     struct device *dev)
> static inline?
>> +{
>> +	return -EINVAL;
> nit: -ENOENT ?
>> +}
>> +#endif
>> +
>>  static bool vfio_platform_has_reset(struct vfio_platform_device *vd=
ev)
>>  {
>>  	return vdev->of_reset ? true : false;
>> @@ -548,6 +580,21 @@ static const struct vfio_device_ops vfio_platfo=
rm_ops =3D {
>>  	.mmap		=3D vfio_platform_mmap,
>>  };
>> =20
>> +int vfio_platform_of_probe(struct vfio_platform_device *vdev,
>> +			   struct device *dev)
>> +{
>> +	int ret;
>> +
>> +	ret =3D device_property_read_string(dev, "compatible",
>> +					  &vdev->compat);
>> +	if (ret) {
>> +		pr_err("VFIO: cannot retrieve compat for %s\n",
>> +			vdev->name);
>> +		return ret;
>> +	}
>> +	return 0;
> nit: can be simplified by returning ret in any case.
>=20
> Best Regards
>=20
> Eric
>=20
>> +}
>> +
>>  int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>>  			       struct device *dev)
>>  {
>> @@ -557,11 +604,12 @@ int vfio_platform_probe_common(struct vfio_pla=
tform_device *vdev,
>>  	if (!vdev)
>>  		return -EINVAL;
>> =20
>> -	ret =3D device_property_read_string(dev, "compatible", &vdev->comp=
at);
>> -	if (ret) {
>> -		pr_err("VFIO: cannot retrieve compat for %s\n", vdev->name);
>> -		return -EINVAL;
>> -	}
>> +	ret =3D vfio_platform_acpi_probe(vdev, dev);
>> +	if (ret)
>> +		ret =3D vfio_platform_of_probe(vdev, dev);
>> +
>> +	if (ret)
>> +		return ret;
>> =20
>>  	vdev->device =3D dev;
>> =20
>> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers=
/vfio/platform/vfio_platform_private.h
>> index 71ed7d1..ba9e4f8 100644
>> --- a/drivers/vfio/platform/vfio_platform_private.h
>> +++ b/drivers/vfio/platform/vfio_platform_private.h
>> @@ -58,6 +58,7 @@ struct vfio_platform_device {
>>  	struct mutex			igate;
>>  	struct module			*parent_module;
>>  	const char			*compat;
>> +	const char			*acpihid;
>>  	struct module			*reset_module;
>>  	struct device			*device;
>> =20
>>
>=20
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Best Regards

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
