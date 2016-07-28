From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2] acpi: move int340x_thermal.c to dptf folder
Date: Thu, 28 Jul 2016 16:01:42 +0800
Message-ID: <1469692902.2367.91.camel@intel.com>
References: <1468965469-5744-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:24305 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbcG1IBw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Jul 2016 04:01:52 -0400
In-Reply-To: <1468965469-5744-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org

On =E4=BA=8C, 2016-07-19 at 14:57 -0700, Srinivas Pandruvada wrote:
> Since dptf has its own folder under ACPI, move this file also
> there.
>=20
> Signed-off-by: Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui
> ---
> v2:
> Resent after dptf_power patch was updated with include file path
>=20
>=20
> =C2=A0drivers/acpi/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A01 -
> =C2=A0drivers/acpi/dptf/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A03 +++
> =C2=A0drivers/acpi/dptf/int340x_thermal.c | 53
> +++++++++++++++++++++++++++++++++++++
> =C2=A0drivers/acpi/int340x_thermal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0| 53 -------------------------
> ------------
> =C2=A04 files changed, 56 insertions(+), 54 deletions(-)
> =C2=A0create mode 100644 drivers/acpi/dptf/int340x_thermal.c
> =C2=A0delete mode 100644 drivers/acpi/int340x_thermal.c
>=20
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index f6d0cc0..0325a53 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -44,7 +44,6 @@ acpi-y				+=3D
> acpi_lpss.o acpi_apd.o
> =C2=A0acpi-y				+=3D acpi_platform.o
> =C2=A0acpi-y				+=3D acpi_pnp.o
> =C2=A0acpi-$(CONFIG_ARM_AMBA)	+=3D acpi_amba.o
> -acpi-y				+=3D int340x_thermal.o
> =C2=A0acpi-y				+=3D power.o
> =C2=A0acpi-y				+=3D event.o
> =C2=A0acpi-$(CONFIG_ACPI_REDUCED_HARDWARE_ONLY) +=3D evged.o
> diff --git a/drivers/acpi/dptf/Makefile b/drivers/acpi/dptf/Makefile
> index 62cbe87..06ea880 100644
> --- a/drivers/acpi/dptf/Makefile
> +++ b/drivers/acpi/dptf/Makefile
> @@ -1 +1,4 @@
> +obj-$(CONFIG_ACPI)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D int340x_thermal.o
> =C2=A0obj-$(CONFIG_DPTF_POWER)	+=3D dptf_power.o
> +
> +ccflags-y +=3D -Idrivers/acpi
> diff --git a/drivers/acpi/dptf/int340x_thermal.c
> b/drivers/acpi/dptf/int340x_thermal.c
> new file mode 100644
> index 0000000..33505c6
> --- /dev/null
> +++ b/drivers/acpi/dptf/int340x_thermal.c
> @@ -0,0 +1,53 @@
> +/*
> + * ACPI support for int340x thermal drivers
> + *
> + * Copyright (C) 2014, Intel Corporation
> + * Authors: Zhang Rui <rui.zhang@intel.com>
> + *
> + * This program is free software; you can redistribute it and/or
> modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/module.h>
> +
> +#include "internal.h"
> +
> +#define INT3401_DEVICE 0X01
> +static const struct acpi_device_id int340x_thermal_device_ids[] =3D =
{
> +	{"INT3400"},
> +	{"INT3401", INT3401_DEVICE},
> +	{"INT3402"},
> +	{"INT3403"},
> +	{"INT3404"},
> +	{"INT3406"},
> +	{"INT3407"},
> +	{"INT3408"},
> +	{"INT3409"},
> +	{"INT340A"},
> +	{"INT340B"},
> +	{""},
> +};
> +
> +static int int340x_thermal_handler_attach(struct acpi_device *adev,
> +					const struct acpi_device_id
> *id)
> +{
> +	if (IS_ENABLED(CONFIG_INT340X_THERMAL))
> +		acpi_create_platform_device(adev);
> +	/* Intel SoC DTS thermal driver needs INT3401 to set IRQ
> descriptor */
> +	else if (IS_ENABLED(CONFIG_INTEL_SOC_DTS_THERMAL) &&
> +		=C2=A0id->driver_data =3D=3D INT3401_DEVICE)
> +		acpi_create_platform_device(adev);
> +	return 1;
> +}
> +
> +static struct acpi_scan_handler int340x_thermal_handler =3D {
> +	.ids =3D int340x_thermal_device_ids,
> +	.attach =3D int340x_thermal_handler_attach,
> +};
> +
> +void __init acpi_int340x_thermal_init(void)
> +{
> +	acpi_scan_add_handler(&int340x_thermal_handler);
> +}
> diff --git a/drivers/acpi/int340x_thermal.c
> b/drivers/acpi/int340x_thermal.c
> deleted file mode 100644
> index 33505c6..0000000
> --- a/drivers/acpi/int340x_thermal.c
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -/*
> - * ACPI support for int340x thermal drivers
> - *
> - * Copyright (C) 2014, Intel Corporation
> - * Authors: Zhang Rui <rui.zhang@intel.com>
> - *
> - * This program is free software; you can redistribute it and/or
> modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/acpi.h>
> -#include <linux/module.h>
> -
> -#include "internal.h"
> -
> -#define INT3401_DEVICE 0X01
> -static const struct acpi_device_id int340x_thermal_device_ids[] =3D =
{
> -	{"INT3400"},
> -	{"INT3401", INT3401_DEVICE},
> -	{"INT3402"},
> -	{"INT3403"},
> -	{"INT3404"},
> -	{"INT3406"},
> -	{"INT3407"},
> -	{"INT3408"},
> -	{"INT3409"},
> -	{"INT340A"},
> -	{"INT340B"},
> -	{""},
> -};
> -
> -static int int340x_thermal_handler_attach(struct acpi_device *adev,
> -					const struct acpi_device_id
> *id)
> -{
> -	if (IS_ENABLED(CONFIG_INT340X_THERMAL))
> -		acpi_create_platform_device(adev);
> -	/* Intel SoC DTS thermal driver needs INT3401 to set IRQ
> descriptor */
> -	else if (IS_ENABLED(CONFIG_INTEL_SOC_DTS_THERMAL) &&
> -		=C2=A0id->driver_data =3D=3D INT3401_DEVICE)
> -		acpi_create_platform_device(adev);
> -	return 1;
> -}
> -
> -static struct acpi_scan_handler int340x_thermal_handler =3D {
> -	.ids =3D int340x_thermal_device_ids,
> -	.attach =3D int340x_thermal_handler_attach,
> -};
> -
> -void __init acpi_int340x_thermal_init(void)
> -{
> -	acpi_scan_add_handler(&int340x_thermal_handler);
> -}
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
