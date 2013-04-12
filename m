From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCHv2 5/5] ACPI / pcie: suppress compiler warning in portdrv_acpi.c
Date: Fri, 12 Apr 2013 14:54:34 -0600
Message-ID: <CAErSpo7b6CvQgo44oRi+iREq1zduHMLTvw0r_7McroLc38r97A@mail.gmail.com>
References: <1362993428-14823-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1362993428-14823-5-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:54458 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab3DLUyy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Apr 2013 16:54:54 -0400
Received: by mail-ob0-f178.google.com with SMTP id ni5so2690727obc.23
        for <linux-acpi@vger.kernel.org>; Fri, 12 Apr 2013 13:54:54 -0700 (PDT)
In-Reply-To: <1362993428-14823-5-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J . Wysocki" <rjw@sisk.pl>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>

On Mon, Mar 11, 2013 at 3:17 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> This patch fixes following compiler warning when build via make W=3D1=
:
>
> drivers/pci/pcie/portdrv_acpi.c:34:5: warning: no previous prototype =
for =91pcie_port_acpi_setup=92 [-Wmissing-prototypes]
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

I applied this and several similar patches to my pci/cleanup branch
for v3.10.  Thanks!

http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=3Dpc=
i/cleanup

Bjorn

> ---
>  drivers/pci/pcie/portdrv_acpi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portd=
rv_acpi.c
> index a86b56e..b4d2894 100644
> --- a/drivers/pci/pcie/portdrv_acpi.c
> +++ b/drivers/pci/pcie/portdrv_acpi.c
> @@ -17,6 +17,7 @@
>
>  #include "aer/aerdrv.h"
>  #include "../pci.h"
> +#include "portdrv.h"
>
>  /**
>   * pcie_port_acpi_setup - Request the BIOS to release control of PCI=
e services.
> --
> 1.8.2.rc0.22.gb3600c3
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
