From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: Add _UID support for ACPI devices.
Date: Thu, 27 Sep 2012 09:33:28 +0800
Message-ID: <1348709608.10877.271.camel@rui.sh.intel.com>
References: <3f02ff942122d086c4d6e44a9ffa9269300675b3.1348736272.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14642 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753594Ab2I0Bcr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Sep 2012 21:32:47 -0400
In-Reply-To: <3f02ff942122d086c4d6e44a9ffa9269300675b3.1348736272.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, Ying Huang <ying.huang@intel.com>

On =E5=9B=9B, 2012-09-27 at 09:17 +0800, Lv Zheng wrote:
> The _UID object is optional, but is required when the device has no
> other way to report a persistent unique device ID.
> This patch is required for ACPI 5.0 ACPI enumerated IP cores.
>=20

> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>

> ---
>  drivers/acpi/scan.c |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index d730a93..bb7fe47 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -327,6 +327,8 @@ static void acpi_device_release(struct device *de=
v)
>  	struct acpi_device *acpi_dev =3D to_acpi_device(dev);
> =20
>  	acpi_free_ids(acpi_dev);
> +	if (acpi_dev->pnp.unique_id)
> +		kfree(acpi_dev->pnp.unique_id);
>  	kfree(acpi_dev);
>  }
> =20
> @@ -1162,6 +1164,9 @@ static void acpi_device_set_id(struct acpi_devi=
ce *device)
>  			device->pnp.bus_address =3D info->address;
>  			device->flags.bus_address =3D 1;
>  		}
> +		if (info->valid & ACPI_VALID_UID) {
> +			device->pnp.unique_id =3D kstrdup(info->unique_id.string, GFP_KER=
NEL);
> +		}
> =20
>  		kfree(info);
> =20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
