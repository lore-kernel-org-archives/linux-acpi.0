From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] ACPI / bus: Move duplicate code to a separate new function
Date: Mon, 03 Aug 2015 22:58:17 +0800
Message-ID: <55BF8189.2040202@linaro.org>
References: <4854608.nIfMTUvZQu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35659 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbbHCO6Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Aug 2015 10:58:24 -0400
Received: by pasy3 with SMTP id y3so16489240pas.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2015 07:58:23 -0700 (PDT)
In-Reply-To: <4854608.nIfMTUvZQu@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On 08/01/2015 08:39 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> After merging commit 712e960f0ee9 (ACPI / PM: Attach ACPI power
> domain only once) with commit 1dcc3d3362b0 (ACPI / bus: Move ACPI
> bus type registration) there is some duplicate code in
> acpi_device_is_first_physical_node() and acpi_companion_match()
> that can be moved to a separate routine and called from both
> places.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> On top of linux-pm.git/linux-next.
>
> ---
>   drivers/acpi/bus.c |   51 ++++++++++++++++++++++-----------------------------
>   1 file changed, 22 insertions(+), 29 deletions(-)
>
> Index: linux-pm/drivers/acpi/bus.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/bus.c
> +++ linux-pm/drivers/acpi/bus.c
> @@ -482,6 +482,26 @@ static void acpi_device_remove_notify_ha
>                                Device Matching
>      -------------------------------------------------------------------------- */
>
> +static struct acpi_device *acpi_primary_dev_companion(struct acpi_device *adev,
> +						      const struct device *dev)
> +{
> +	struct mutex *physical_node_lock = &adev->physical_node_lock;
> +
> +	mutex_lock(physical_node_lock);
> +	if (list_empty(&adev->physical_node_list)) {
> +		adev = NULL;
> +	} else {
> +		const struct acpi_device_physical_node *node;
> +
> +		node = list_first_entry(&adev->physical_node_list,
> +					struct acpi_device_physical_node, node);
> +		if (node->dev != dev)
> +			adev = NULL;
> +	}
> +	mutex_unlock(physical_node_lock);
> +	return adev;
> +}
> +
>   /**
>    * acpi_device_is_first_physical_node - Is given dev first physical node
>    * @adev: ACPI companion device
> @@ -496,19 +516,7 @@ static void acpi_device_remove_notify_ha
>   bool acpi_device_is_first_physical_node(struct acpi_device *adev,
>   					const struct device *dev)
>   {
> -	bool ret = false;
> -
> -	mutex_lock(&adev->physical_node_lock);
> -	if (!list_empty(&adev->physical_node_list)) {
> -		const struct acpi_device_physical_node *node;
> -
> -		node = list_first_entry(&adev->physical_node_list,
> -					struct acpi_device_physical_node, node);
> -		ret = node->dev == dev;
> -	}
> -	mutex_unlock(&adev->physical_node_lock);
> -
> -	return ret;
> +	return !!acpi_primary_dev_companion(adev, dev);
>   }
>
>   /*
> @@ -535,7 +543,6 @@ bool acpi_device_is_first_physical_node(
>   struct acpi_device *acpi_companion_match(const struct device *dev)
>   {
>   	struct acpi_device *adev;
> -	struct mutex *physical_node_lock;
>
>   	adev = ACPI_COMPANION(dev);
>   	if (!adev)
> @@ -544,21 +551,7 @@ struct acpi_device *acpi_companion_match
>   	if (list_empty(&adev->pnp.ids))
>   		return NULL;
>
> -	physical_node_lock = &adev->physical_node_lock;
> -	mutex_lock(physical_node_lock);
> -	if (list_empty(&adev->physical_node_list)) {
> -		adev = NULL;
> -	} else {
> -		const struct acpi_device_physical_node *node;
> -
> -		node = list_first_entry(&adev->physical_node_list,
> -					struct acpi_device_physical_node, node);
> -		if (node->dev != dev)
> -			adev = NULL;
> -	}
> -	mutex_unlock(physical_node_lock);
> -
> -	return adev;
> +	return acpi_primary_dev_companion(adev, dev);
>   }

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
