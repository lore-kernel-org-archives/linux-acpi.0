From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] watchdog: wdat_wdt: Select WATCHDOG_CORE
Date: Mon, 21 Nov 2016 07:14:08 -0800
Message-ID: <1dbc6c68-3ec7-1f4b-746d-494ffba39311@roeck-us.net>
References: <20161121133307.157776-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33358 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753566AbcKUPOL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Nov 2016 10:14:11 -0500
In-Reply-To: <20161121133307.157776-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Vegard Nossum <vegard.nossum@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/21/2016 05:33 AM, Mika Westerberg wrote:
> The WDAT watchdog driver uses functionality provided by the watchdog timer
> core but it did not select it explicitly. This results following linker
> error when only WDAT_WDT is enabled in Kconfig:
>
>   drivers/built-in.o: In function `wdat_wdt_probe':
>   drivers/watchdog/wdat_wdt.c:444: undefined reference to `devm_watchdog_register_device'
>
> Fix this by explicitly selecting WATCHDOG_CORE when WDAT watchdog driver is
> enabled.
>
> Fixes: 058dfc767008 (ACPI / watchdog: Add support for WDAT hardware watchdog)
> Reported-by: Vegard Nossum <vegard.nossum@gmail.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index fdd3228e0678..3eb58cb51e56 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -155,6 +155,7 @@ config TANGOX_WATCHDOG
>  config WDAT_WDT
>  	tristate "ACPI Watchdog Action Table (WDAT)"
>  	depends on ACPI
> +	select WATCHDOG_CORE
>  	select ACPI_WATCHDOG
>  	help
>  	  This driver adds support for systems with ACPI Watchdog Action
>

