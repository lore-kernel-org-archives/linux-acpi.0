From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RFC PATCH 5/9] mfd: Add ACPI support
Date: Wed, 20 Aug 2014 16:54:59 +0100
Message-ID: <20140820155459.GM4266@lee--X1>
References: <1408172039-32513-1-git-send-email-mika.westerberg@linux.intel.com>
 <1408172039-32513-6-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:59505 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbaHTPzN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Aug 2014 11:55:13 -0400
Received: by mail-qa0-f44.google.com with SMTP id f12so7035904qad.17
        for <linux-acpi@vger.kernel.org>; Wed, 20 Aug 2014 08:55:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408172039-32513-6-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Darren Hart <dvhart@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Al Stone <al.stone@linaro.org>, Olof Johansson <olof@lixom.net>, Matthew Garrett <matthew.garrett@nebula.com>, Matt Fleming <matt.fleming@intel.com>, David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Josh Triplett <josh@joshtriplett.org>, Aaron Lu <aaron.lu@intel.com>, Max Eliaser <max.eliaser@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mark Brown <broonie@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Grant Likely <grant.likely@linaro.org>R

On Sat, 16 Aug 2014, Mika Westerberg wrote:
> If an MFD device is backed by ACPI namespace, we should allow subdevi=
ce
> drivers to access their corresponding ACPI companion devices through =
normal
> means (e.g using ACPI_COMPANION()).
>=20
> This patch adds such support to the MFD core. If the MFD parent devic=
e
> doesn't specify any ACPI _HID/_CID for the child device, the child de=
vice
> will share the parent ACPI companion device. Otherwise the child devi=
ce
> will be assigned with the corresponding ACPI companion, if found in t=
he
> namespace below the parent.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Darren Hart <dvhart@linux.intel.com>
> ---
>  Documentation/acpi/enumeration.txt | 27 +++++++++++++++++++++++++
>  drivers/mfd/mfd-core.c             | 41 ++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/core.h           |  3 +++
>  3 files changed, 71 insertions(+)
>=20
> diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/=
enumeration.txt
> index e182be5e3c83..74e35c54febf 100644
> --- a/Documentation/acpi/enumeration.txt
> +++ b/Documentation/acpi/enumeration.txt
> @@ -312,3 +312,30 @@ a code like this:
> =20
>  There are also devm_* versions of these functions which release the
>  descriptors once the device is released.
> +
> +MFD devices
> +~~~~~~~~~~~
> +The MFD devices create platform devices from their children. For the

What does this mean?  MFD drivers register their children _as_
platform devices.

> +child devices there needs to be an ACPI handle that they can use to
> +reference parts of the ACPI namespace that relate to them. In the Li=
nux
> +MFD subsystem we provide two ways:
> +
> +	o The children share the parent ACPI handle.
> +	o The MFD cell can specify the ACPI id of the device.
> +
> +For the first case, the MFD drivers do not need to do anything. The
> +resulting child platform device will have its ACPI_COMPANION() set t=
o point
> +to the parent device.
> +
> +If the ACPI namespace has a device that we can match using an ACPI i=
d,
> +the id should be set like:
> +
> +	static struct mfd_cell my_subdevice_cell =3D {
> +		.name =3D "my_subdevice",
> +		/* set the resources relative to the parent */
> +		.acpi_pnpid =3D "XYZ0001",
> +	};
> +
> +The ACPI id "XYZ0001" is then used to lookup an ACPI device directly=
 under
> +the MFD device and if found, that ACPI companion device is bound to =
the
> +resulting child platform device.
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 892d343193ad..bb466b28b3b6 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -78,6 +78,45 @@ static int mfd_platform_add_cell(struct platform_d=
evice *pdev,
>  	return 0;
>  }
> =20
> +#if IS_ENABLED(CONFIG_ACPI)
> +static void mfd_acpi_add_device(const struct mfd_cell *cell,
> +				struct platform_device *pdev)
> +{
> +	struct acpi_device *parent_adev;
> +	struct acpi_device *adev =3D NULL;
> +
> +	parent_adev =3D ACPI_COMPANION(pdev->dev.parent);
> +	if (!parent_adev)
> +		return;
> +
> +	/*
> +	 * MFD child device gets its ACPI handle either from the ACPI
> +	 * device directly under the parent that matches the acpi_pnpid or
> +	 * it will use the parent handle if is no acpi_pnpid is given.
> +	 */
> +	if (cell->acpi_pnpid) {
> +		struct acpi_device_id ids[2] =3D {};
> +		struct acpi_device *child_adev;
> +
> +		strlcpy(ids[0].id, cell->acpi_pnpid, sizeof(ids[0].id));
> +		list_for_each_entry(child_adev, &parent_adev->children, node)
> +			if (acpi_match_device_ids(child_adev, ids)) {
> +				adev =3D child_adev;
> +				break;
> +			}
> +	} else {
> +		adev =3D parent_adev;
> +	}
> +
> +	ACPI_COMPANION_SET(&pdev->dev, adev);
> +}
> +#else
> +static inline void mfd_acpi_add_device(const struct mfd_cell *cell,
> +				       struct platform_device *pdev)
> +{
> +}
> +#endif
> +

I'm not keen on polluting the MFD core driver with #differy.  Can't you
think of another way to do it?

>  static int mfd_add_device(struct device *parent, int id,
>  			  const struct mfd_cell *cell, atomic_t *usage_count,
>  			  struct resource *mem_base,
> @@ -118,6 +157,8 @@ static int mfd_add_device(struct device *parent, =
int id,
>  		}
>  	}
> =20
> +	mfd_acpi_add_device(cell, pdev);
> +
>  	if (cell->pdata_size) {
>  		ret =3D platform_device_add_data(pdev,
>  					cell->platform_data, cell->pdata_size);
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index f543de91ce19..73e1709d4c09 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -44,6 +44,9 @@ struct mfd_cell {
>  	 */
>  	const char		*of_compatible;
> =20
> +	/* Matches ACPI PNP id, either _HID or _CID */
> +	const char		*acpi_pnpid;
> +
>  	/*
>  	 * These resources can be specified relative to the parent device.
>  	 * For accessing hardware you should use resources from the platfor=
m dev

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
