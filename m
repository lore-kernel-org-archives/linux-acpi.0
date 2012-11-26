From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: include missed header into acpi_platform.c
Date: Mon, 26 Nov 2012 11:08:19 +0100
Message-ID: <1700274.8ucQRy9VHB@vostro.rjw.lan>
References: <1353922086-19917-1-git-send-email-andriy.shevchenko@linux.intel.com> <20121126094044.GG3867@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:33571 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959Ab2KZKDg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Nov 2012 05:03:36 -0500
In-Reply-To: <20121126094044.GG3867@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On Monday, November 26, 2012 11:40:44 AM Mika Westerberg wrote:
> On Mon, Nov 26, 2012 at 11:28:05AM +0200, Andy Shevchenko wrote:
> > The internal.h declares the acpi_create_platform_device(). Without that include
> > we get a following warning:
> > drivers/acpi/acpi_platform.c:133:24: warning: symbol 'acpi_create_platform_device' was not declared. Should it be static?
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied.

Thanks,
Rafael


> > ---
> >  drivers/acpi/acpi_platform.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> > index dbb31d6..2eee101 100644
> > --- a/drivers/acpi/acpi_platform.c
> > +++ b/drivers/acpi/acpi_platform.c
> > @@ -17,6 +17,8 @@
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  
> > +#include "internal.h"
> > +
> >  ACPI_MODULE_NAME("platform");
> >  
> >  struct resource_info {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
