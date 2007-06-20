From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 2/3] ACPI autoloading - Create acpi alias interface
Date: Thu, 21 Jun 2007 00:52:21 +0900
Message-ID: <20070620155220.GA9226@inferi.kami.home>
References: <1182111854.4204.4.camel@noname> <1182112047.4204.12.camel@noname>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:59646 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbXFTPwe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jun 2007 11:52:34 -0400
Content-Disposition: inline
In-Reply-To: <1182112047.4204.12.camel@noname>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Kay Sievers <kasievers@suse.de>

On Sun, Jun 17, 2007 at 10:27:27PM +0200, Thomas Renninger wrote:
> Create acpi alias interface
...
> Index: linux-2.6.22-rc4/drivers/pnp/pnpacpi/core.c
> ===================================================================
> --- linux-2.6.22-rc4.orig/drivers/pnp/pnpacpi/core.c
> +++ linux-2.6.22-rc4/drivers/pnp/pnpacpi/core.c
> @@ -21,7 +21,10 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/pnp.h>
> +#include <linux/mod_devicetable.h>
>  #include <acpi/acpi_bus.h>
> +#include <acpi/actypes.h>
> +
>  #include "pnpacpi.h"
>  
>  static int num = 0;
> @@ -33,15 +36,17 @@ static int num = 0;
>   * have irqs (PIC, Timer) because we call acpi_register_gsi.
>   * Finaly only devices that have a CRS method need to be in this list.
>   */
> -static char __initdata excluded_id_list[] =
> -	"PNP0C09," /* EC */
> -	"PNP0C0F," /* Link device */
> -	"PNP0000," /* PIC */
> -	"PNP0100," /* Timer */
> -	;
> +static __initdata struct acpi_device_id excluded_id_list[] ={
> +	{"PNP0C09", 0}, /* EC */
> +	{"PNP0C0F", 0}, /* Link device */
> +	{"PNP0000", 0}, /* PIC */
> +	{"PNP0100", 0}, /* Timer */
> +	{"", 0};
              ^^^
eeek!

> +};
> +
-- 
mattia
:wq!
