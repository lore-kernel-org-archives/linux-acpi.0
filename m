From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCHv2 1/5] ACPI: suppress compiler warnings in button.c
Date: Tue, 26 Mar 2013 14:26:32 +0100
Message-ID: <30325044.ggCSRcSXmt@vostro.rjw.lan>
References: <1362993428-14823-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43015 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933294Ab3CZNTH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Mar 2013 09:19:07 -0400
In-Reply-To: <1362993428-14823-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>

On Monday, March 11, 2013 11:17:04 AM Andy Shevchenko wrote:
> This patch fixes following compiler warnings when build via make W=3D=
1:
>=20
> drivers/acpi/button.c:220:5: warning: no previous prototype for =E2=80=
=98acpi_lid_notifier_register=E2=80=99 [-Wmissing-prototypes]
> drivers/acpi/button.c:226:5: warning: no previous prototype for =E2=80=
=98acpi_lid_notifier_unregister=E2=80=99 [-Wmissing-prototypes]
> drivers/acpi/button.c:232:5: warning: no previous prototype for =E2=80=
=98acpi_lid_open=E2=80=99 [-Wmissing-prototypes]
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patches [1-4/5] applied to linux-pm.git/linux-next.  I'm leaving patch =
[5/5]
to Bjorn.

Thanks,
Rafael


> ---
>  drivers/acpi/button.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
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
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
