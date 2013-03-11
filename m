From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: suppress compiler warnings
Date: Mon, 11 Mar 2013 04:31:46 +0100
Message-ID: <2201683.kMNYfgVRi1@vostro.rjw.lan>
References: <1362748991-17863-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:49755 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554Ab3CKDYp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Mar 2013 23:24:45 -0400
In-Reply-To: <1362748991-17863-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

On Friday, March 08, 2013 03:23:11 PM Andy Shevchenko wrote:
> This patch fixes following compiler warnings:
>=20
> drivers/acpi/csrt.c:135:116: warning: no previous prototype for =E2=80=
=98acpi_csrt_init=E2=80=99 [-Wmissing-prototypes]
>=20
> drivers/acpi/container.c:183:116: warning: no previous prototype for =
=E2=80=98acpi_container_init=E2=80=99 [-Wmissing-prototypes]
>=20
> drivers/pci/pcie/portdrv_acpi.c:34:5: warning: no previous prototype =
for =E2=80=98pcie_port_acpi_setup=E2=80=99 [-Wmissing-prototypes]
>=20
> drivers/acpi/battery.c:149:52: warning: no previous prototype for =E2=
=80=98acpi_battery_present=E2=80=99 [-Wmissing-prototypes]
>=20
> drivers/acpi/button.c:220:5: warning: no previous prototype for =E2=80=
=98acpi_lid_notifier_register=E2=80=99 [-Wmissing-prototypes]
> drivers/acpi/button.c:226:5: warning: no previous prototype for =E2=80=
=98acpi_lid_notifier_unregister=E2=80=99 [-Wmissing-prototypes]
> drivers/acpi/button.c:232:5: warning: no previous prototype for =E2=80=
=98acpi_lid_open=E2=80=99 [-Wmissing-prototypes]
>=20
> drivers/acpi/processor_throttling.c: In function =E2=80=98acpi_proces=
sor_throttling_init=E2=80=99:
> drivers/acpi/processor_throttling.c:216:40: warning: suggest braces a=
round empty body in an =E2=80=98if=E2=80=99 statement [-Wempty-body]
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Please split this into separate per-file patches.

Also it would be good to know what config options are triggering the wa=
rnings
in each case.

Thanks,
Rafael


> ---
>  drivers/acpi/battery.c              | 2 +-
>  drivers/acpi/button.c               | 1 +
>  drivers/acpi/container.c            | 2 ++
>  drivers/acpi/csrt.c                 | 2 ++
>  drivers/acpi/processor_throttling.c | 3 ++-
>  drivers/pci/pcie/portdrv_acpi.c     | 1 +
>  6 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index c5cd5b5..0cc384b 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -146,7 +146,7 @@ struct acpi_battery {
> =20
>  #define to_acpi_battery(x) container_of(x, struct acpi_battery, bat)
> =20
> -inline int acpi_battery_present(struct acpi_battery *battery)
> +static inline int acpi_battery_present(struct acpi_battery *battery)
>  {
>  	return battery->device->status.battery_present;
>  }
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 86c7d54..92a659a 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -33,6 +33,7 @@
>  #include <linux/slab.h>
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
> +#include <acpi/button.h>
> =20
>  #define PREFIX "ACPI: "
> =20
> diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
> index 5523ba7..6624c01 100644
> --- a/drivers/acpi/container.c
> +++ b/drivers/acpi/container.c
> @@ -35,6 +35,8 @@
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
> =20
> +#include "internal.h"
> +
>  #define PREFIX "ACPI: "
> =20
>  #define _COMPONENT			ACPI_CONTAINER_COMPONENT
> diff --git a/drivers/acpi/csrt.c b/drivers/acpi/csrt.c
> index 5c15a91..8392052 100644
> --- a/drivers/acpi/csrt.c
> +++ b/drivers/acpi/csrt.c
> @@ -19,6 +19,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/sizes.h>
> =20
> +#include "internal.h"
> +
>  ACPI_MODULE_NAME("CSRT");
> =20
>  static int __init acpi_csrt_parse_shared_info(struct platform_device=
 *pdev,
> diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/proce=
ssor_throttling.c
> index 1d02b7b..e7dd2c1 100644
> --- a/drivers/acpi/processor_throttling.c
> +++ b/drivers/acpi/processor_throttling.c
> @@ -211,9 +211,10 @@ err_ret:
>   */
>  void acpi_processor_throttling_init(void)
>  {
> -	if (acpi_processor_update_tsd_coord())
> +	if (acpi_processor_update_tsd_coord()) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  			"Assume no T-state coordination\n"));
> +	}
> =20
>  	return;
>  }
> diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portd=
rv_acpi.c
> index a86b56e..b4d2894 100644
> --- a/drivers/pci/pcie/portdrv_acpi.c
> +++ b/drivers/pci/pcie/portdrv_acpi.c
> @@ -17,6 +17,7 @@
> =20
>  #include "aer/aerdrv.h"
>  #include "../pci.h"
> +#include "portdrv.h"
> =20
>  /**
>   * pcie_port_acpi_setup - Request the BIOS to release control of PCI=
e services.
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
