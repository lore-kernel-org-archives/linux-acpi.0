From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH v3] acpi: indicate to platform when hot remove returns busy
Date: Thu, 29 Jun 2017 00:13:18 +0200
Message-ID: <136250372.B1LmTaN194@aspire.rjw.lan>
References: <20170621074544.18436-1-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47360 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751559AbdF1WUp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Jun 2017 18:20:45 -0400
In-Reply-To: <20170621074544.18436-1-jlee@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Michal Hocko <mhocko@suse.cz>

On Wednesday, June 21, 2017 03:45:44 PM Lee, Chun-Yi wrote:
> In hotplug logic, it always indicates non-specific failure to
> platform through _OST when handing acpi hot-remove event failed. Then
> platform terminates the hot-remove process but it can not identify
> the reason.
> 
> Base on current hot-remove code, there have two situations that it
> returns busy:
>  - OSPM try to offline an individual device, but the device offline
>    function returns busy.
>  - When the ejection event is applied to an "not offlined yet" container.
>    OSPM send kobject change event to userspace and returns busy.
> 
> Both of them will returns -EBUSY to acpi device hotplug function then
> hotplug function indicates non-specific failure to platform just like
> any other error, e.g. -ENODEV or -EIO.
> 
> The benefit to platform for identifying the OS busy state is that
> platform can be applied different approach to handle the busy but
> not just terminate the hot-remove process by unknown reason. For
> example, platform can wait for a while then triggers hot-remove
> again.
> 
> This RFC patch adds one more parameter to the handler function of
> acpi generic hotplug event to give the function a chance to propose
> the return code of _OST. In this case, it sets ost return code to
> ACPI_OST_SC_DEVICE_BUSY when the acpi hot remove function returns
> -EBUSY.
> 
> v3:
> Removed redundant 'else' in acpi_ost_status_code(). (Andy Shevchenko)
> 
> v2:
> Do not overwrite ost code in acpi_generic_hotplug_event(). Move
> the "error code to ost code" logic to a help function. (Andy Shevchenko)
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Michal Hocko <mhocko@suse.cz>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---
>  drivers/acpi/scan.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 3a10d7573477..41f5065190c7 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -384,6 +384,20 @@ static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type)
>  	return -EINVAL;
>  }
>  
> +static int acpi_ost_status_code(u32 src, int error)
> +{
> +	switch (src) {
> +	case ACPI_NOTIFY_EJECT_REQUEST:
> +	case ACPI_OST_EC_OSPM_EJECT:
> +		if (error == -EPERM)
> +			return ACPI_OST_SC_EJECT_NOT_SUPPORTED;
> +		if (error == -EBUSY)
> +			return ACPI_OST_SC_DEVICE_BUSY;
> +		break;
> +	}
> +	return error ? ACPI_OST_SC_NON_SPECIFIC_FAILURE : ACPI_OST_SC_SUCCESS;
> +}

I'm not sure why you need the function above?

It only has one user anyway.

> +
>  void acpi_device_hotplug(struct acpi_device *adev, u32 src)
>  {
>  	u32 ost_code = ACPI_OST_SC_NON_SPECIFIC_FAILURE;
> @@ -404,10 +418,6 @@ void acpi_device_hotplug(struct acpi_device *adev, u32 src)
>  		error = dock_notify(adev, src);
>  	} else if (adev->flags.hotplug_notify) {
>  		error = acpi_generic_hotplug_event(adev, src);
> -		if (error == -EPERM) {
> -			ost_code = ACPI_OST_SC_EJECT_NOT_SUPPORTED;
> -			goto err_out;
> -		}
>  	} else {
>  		int (*notify)(struct acpi_device *, u32);
>  
> @@ -423,9 +433,8 @@ void acpi_device_hotplug(struct acpi_device *adev, u32 src)
>  		else
>  			goto out;
>  	}
> -	if (!error)
> -		ost_code = ACPI_OST_SC_SUCCESS;

I just would do:

    switch (error) {
    case 0:
        ost_code = ACPI_OST_SC_SUCCESS;
        break;
    case -EBUSY:
        ost_code = ACPI_OST_SC_DEVICE_BUSY;
        break;
    default:
        ost_code = ACPI_OST_SC_NON_SPECIFIC_FAILURE;
        break;
    }

>  
> +	ost_code = acpi_ost_status_code(src, error);
>   err_out:
>  	acpi_evaluate_ost(adev->handle, src, ost_code, NULL);
>  
> 

Thanks,
Rafael

