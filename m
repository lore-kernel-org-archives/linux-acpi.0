From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] device properties: Fix return codes for __acpi_node_get_property_reference
Date: Thu, 05 Oct 2017 14:59:45 +0200
Message-ID: <14664181.1rcyu63NdN@aspire.rjw.lan>
References: <20171005060424.16780-1-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46309 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751280AbdJENJI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Oct 2017 09:09:08 -0400
In-Reply-To: <20171005060424.16780-1-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, mika.westerberg@intel.com, hyungwoo.yang@intel.com

On Thursday, October 5, 2017 8:04:24 AM CEST Sakari Ailus wrote:
> Fix more return codes for device property: Align return codes of
> __acpi_node_get_property_reference. In particular what was missed
> previously:
> 
> -EPROTO could be returned in certain cases, now -EINVAL;
> -EINVAL was returned if the property was not found, now -ENOENT;
> -EINVAL was returned also if the index was higher than the number of
> entries in a package, now -ENOENT.
> 
> Fixes: ("device property: Align return codes of __acpi_node_get_property_reference")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Tested-by: Hyungwoo Yang <hyungwoo.yang@intel.com>
> ---
> Hi Rafael,
> 
> Unfortunately the patch I posted the previous time to remedy the issue
> ("device property: Align return codes of
> _acpi_node_get_property_reference") did not fully fix the issue.

OK, thanks for letting me know, but why didn't it?

>  drivers/acpi/property.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 5a8ac5e1081b..8c28c516e7ec 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -592,8 +592,16 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>  		return -ENOENT;
>  
>  	ret = acpi_data_get_property(data, propname, ACPI_TYPE_ANY, &obj);
> -	if (ret)
> -		return ret;
> +	switch (ret) {
> +	case -EINVAL:
> +		return -ENOENT;
> +	case -EPROTO:
> +		return -EINVAL;
> +	default:
> +		if (ret)
> +			return ret;
> +		break;
> +	}

To be clear, I'm not going to apply anything like the above.

>  
>  	/*
>  	 * The simplest case is when the value is a single reference.  Just
> @@ -605,7 +613,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>  
>  		ret = acpi_bus_get_device(obj->reference.handle, &device);
>  		if (ret)
> -			return ret;
> +			return ret == -ENODEV ? -EINVAL : ret;
>  
>  		args->adev = device;
>  		args->nargs = 0;
> @@ -621,8 +629,10 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>  	 * The index argument is then used to determine which reference
>  	 * the caller wants (along with the arguments).
>  	 */
> -	if (obj->type != ACPI_TYPE_PACKAGE || index >= obj->package.count)
> -		return -EPROTO;
> +	if (obj->type != ACPI_TYPE_PACKAGE)
> +		return -EINVAL;
> +	if (index >= obj->package.count)
> +		return -ENOENT;
>  
>  	element = obj->package.elements;
>  	end = element + obj->package.count;
> 


