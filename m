From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] acpi: handle the acpi hotplug schedule error
Date: Fri, 07 Jul 2017 15:16:40 +0200
Message-ID: <1704918.scVG4c48Sb@aspire.rjw.lan>
References: <20170707062242.29588-1-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65398 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750941AbdGGNYS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Jul 2017 09:24:18 -0400
In-Reply-To: <20170707062242.29588-1-jlee@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>, Michal Hocko <mhocko@suse.cz>

On Friday, July 07, 2017 02:22:42 PM Lee, Chun-Yi wrote:
> Kernel should decrements the reference count of acpi device
> when the scheduling of acpi hotplug work failed, and evaluates
> _OST to notify BIOS the failure.
> 
> v3:
> More simplify the code. (Rafael J. Wysocki)
> 
> v2:
> To simplify the code. (Andy Shevchenko)
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Michal Hocko <mhocko@suse.cz>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>

This has been applied too AFAICS.

> ---
>  drivers/acpi/bus.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 784bda6..9d4fea6 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -432,11 +432,15 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
>  	    (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
>  		driver->ops.notify(adev, type);
>  
> -	if (hotplug_event && ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
> +	if (!hotplug_event) {
> +		acpi_bus_put_acpi_device(adev);
> +		return;
> +	}
> +
> +	if (ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
>  		return;
>  
>  	acpi_bus_put_acpi_device(adev);
> -	return;
>  
>   err:
>  	acpi_evaluate_ost(handle, type, ost_code, NULL);
> 

