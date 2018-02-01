From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v2 2/6] ACPI / bus: Do not traverse through non-existed
 device table
Date: Thu, 1 Feb 2018 15:32:49 -0500
Message-ID: <68fea449-6478-3d6d-addf-79925ca62931@codeaurora.org>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
 <20180201202012.36524-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:32850 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755058AbeBAUcv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Feb 2018 15:32:51 -0500
In-Reply-To: <20180201202012.36524-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On 2/1/2018 3:20 PM, Andy Shevchenko wrote:
> When __acpi_match_device() is called it would be possible to have
> ACPI ID table a MULL pointer. To avoid potential dereference,

NULL

> check for this before traverse.
> 
> While here, remove redundant 'else'.
> 
> Fixes: 80212a162329 ("ACPI / bus: Introduce acpi_get_match_data() function")
> Cc: Sinan Kaya <okaya@codeaurora.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: new patch
>  drivers/acpi/bus.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index a87a97bf75f8..f3a7c29e9190 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -745,11 +745,13 @@ static const struct acpi_device_id *__acpi_match_device(
>  
>  	list_for_each_entry(hwid, &device->pnp.ids, list) {
>  		/* First, check the ACPI/PNP IDs provided by the caller. */
> -		for (id = ids; id->id[0] || id->cls; id++) {
> -			if (id->id[0] && !strcmp((char *) id->id, hwid->id))
> -				return id;
> -			else if (id->cls && __acpi_match_device_cls(id, hwid))
> -				return id;
> +		if (ids) {
> +			for (id = ids; id->id[0] || id->cls; id++) {
> +				if (id->id[0] && !strcmp((char *)id->id, hwid->id))
> +					return id;
> +				if (id->cls && __acpi_match_device_cls(id, hwid))
> +					return id;
> +			}
>  		}
>  
>  		/*
> 

Why not bail out here immediately if ids is null?

__acpi_match_device()
{
	/*
	 * If the device is not present, it is unnecessary to load device
	 * driver for it.
	 */
	if (!device || !device->status.present)
		return NULL;
}

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
