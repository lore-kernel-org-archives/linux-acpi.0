From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI: include missed header into acpi_platform.c
Date: Mon, 26 Nov 2012 11:40:44 +0200
Message-ID: <20121126094044.GG3867@intel.com>
References: <1353922086-19917-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15948 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754598Ab2KZJhj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Nov 2012 04:37:39 -0500
Content-Disposition: inline
In-Reply-To: <1353922086-19917-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

On Mon, Nov 26, 2012 at 11:28:05AM +0200, Andy Shevchenko wrote:
> The internal.h declares the acpi_create_platform_device(). Without that include
> we get a following warning:
> drivers/acpi/acpi_platform.c:133:24: warning: symbol 'acpi_create_platform_device' was not declared. Should it be static?
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> ---
>  drivers/acpi/acpi_platform.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index dbb31d6..2eee101 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -17,6 +17,8 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  
> +#include "internal.h"
> +
>  ACPI_MODULE_NAME("platform");
>  
>  struct resource_info {
> -- 
> 1.7.10.4
