From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [REPOST] [PATCH] acpi thermal fix result check
Date: Tue, 08 Apr 2008 09:11:34 +0800
Message-ID: <1207617094.27304.15.camel@acpi-hp-zz.sh.intel.com>
References: <20080407235530.60630d2b.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33737 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752614AbYDHBdK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Apr 2008 21:33:10 -0400
In-Reply-To: <20080407235530.60630d2b.krzysztof.h1@wp.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org


On Mon, 2008-04-07 at 23:55 +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> The  thermal_zone_device_register() uses ERR_PTR macro
> to return values. A correct check is to use the IS_ERR macro.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
> 
> This patch was done against 2.6.25-rc8.
> The 2.6.25 kernels panic on Compaq AP550 without this patch
> as it has more then 10 (THERMAL_MAX_TRIPS) trip points (there are 12).
> 
> diff -urp linux-2.6.24/drivers/acpi/thermal.c linux-2.6.25/drivers/acpi/thermal.c
> --- linux-2.6.24/drivers/acpi/thermal.c	2008-04-07 23:17:24.145477887 +0200
> +++ linux-2.6.25/drivers/acpi/thermal.c	2008-04-07 23:24:04.341336464 +0200
> @@ -1125,7 +1125,7 @@ static int acpi_thermal_register_thermal
>  			tz->trips.active[i].flags.valid; i++, trips++);
>  	tz->thermal_zone = thermal_zone_device_register("ACPI thermal zone",
>  					trips, tz, &acpi_thermal_zone_ops);
> -	if (!tz->thermal_zone)
> +	if (IS_ERR(tz->thermal_zone))
>  		return -ENODEV;
>  
>  	result = sysfs_create_link(&tz->device->dev.kobj,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

