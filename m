From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] acpi: handle the acpi hotplug schedule error
Date: Thu, 29 Jun 2017 00:06:20 +0200
Message-ID: <2576656.sje5KLSpq7@aspire.rjw.lan>
References: <20170621070434.16570-1-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41512 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751537AbdF1WNr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Jun 2017 18:13:47 -0400
In-Reply-To: <20170621070434.16570-1-jlee@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>, Michal Hocko <mhocko@suse.cz>

On Wednesday, June 21, 2017 03:04:34 PM Lee, Chun-Yi wrote:
> Kernel should decrements the reference count of acpi device
> when the scheduling of acpi hotplug work is failed, and
> evaluates _OST to notify BIOS the failure.
> 
> v2:
> To simplify the code. (Andy Shevchenko)
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Michal Hocko <mhocko@suse.cz>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>

Well, what about:

    if (!hotplug_event) {
        acpi_bus_put_acpi_device(adev);
        return;
    }

    if (ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
        return;

    acpi_bus_put_acpi_device(adev);

err:
    acpi_evaluate_ost(handle, type, ost_code, NULL);

This achieves the same as the patch below to my eyes, but looks
less convoluted IMO.


> ---
>  drivers/acpi/bus.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 34fbe02..91adb71 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -427,12 +427,17 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
>  	    (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
>  		driver->ops.notify(adev, type);
>  
> -	if (hotplug_event && ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
> -		return;
> +	if (hotplug_event) {
> +		if (ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
> +			return;
> +		goto err_put_device;
> +	}
>  
>  	acpi_bus_put_acpi_device(adev);
>  	return;
>  
> + err_put_device:
> +	acpi_bus_put_acpi_device(adev);
>   err:
>  	acpi_evaluate_ost(handle, type, ost_code, NULL);
>  }
> 

