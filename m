From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/1] device property: Align return codes of __acpi_node_get_property_reference
Date: Wed, 04 Oct 2017 01:40:45 +0200
Message-ID: <2779235.4J9vddcLys@aspire.rjw.lan>
References: <20170926090827.31861-1-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55540 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750865AbdJCXuH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Oct 2017 19:50:07 -0400
In-Reply-To: <20170926090827.31861-1-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, frowand.list@gmail.com, mika.westerberg@linux.intel.com, rafael@kernel.org, hverkuil@xs4all.nl

On Tuesday, September 26, 2017 11:08:27 AM CEST Sakari Ailus wrote:
> acpi_fwnode_get_reference_args(), the function implementing ACPI
> support for fwnode_property_get_reference_args(), returns directly
> error codes from __acpi_node_get_property_reference(). The latter uses
> different error codes than the OF implementation. In particular, the OF
> implementation uses -ENOENT to indicate that the property is not found, a
> reference entry is empty and there are no more references.
> 
> Document and align the error codes for property for
> fwnode_property_get_reference_args() so that they match with
> of_parse_phandle_with_args().
> 
> Fixes: 3e3119d3088f ("device property: Introduce fwnode_property_get_reference_args")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Applied, thanks!

> ---
> The patch was called "device property: Align return codes of
> acpi_fwnode_get_reference_with_args", and is an alternative to the set
> "[RFC 0/5] Align and document return values of phandle and reference
> parsing for OF and ACPI".
> 
> since v2:
> 
> - Change the functionality of __acpi_node_get_property_reference rather
>   than that of acpi_fwnode_get_reference_args.
> 
>  drivers/acpi/property.c | 19 +++++++++----------
>  drivers/base/property.c |  4 ++++
>  2 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 3fb8ff513461..5a8ac5e1081b 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -571,10 +571,9 @@ static int acpi_data_get_property_array(const struct acpi_device_data *data,
>   *     }
>   * }
>   *
> - * Calling this function with index %2 return %-ENOENT and with index %3
> - * returns the last entry. If the property does not contain any more values
> - * %-ENODATA is returned. The NULL entry must be single integer and
> - * preferably contain value %0.
> + * Calling this function with index %2 or index %3 return %-ENOENT. If the
> + * property does not contain any more values %-ENOENT is returned. The NULL
> + * entry must be single integer and preferably contain value %0.
>   *
>   * Return: %0 on success, negative error code on failure.
>   */
> @@ -590,7 +589,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>  
>  	data = acpi_device_data_of_node(fwnode);
>  	if (!data)
> -		return -EINVAL;
> +		return -ENOENT;
>  
>  	ret = acpi_data_get_property(data, propname, ACPI_TYPE_ANY, &obj);
>  	if (ret)
> @@ -635,7 +634,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>  			ret = acpi_bus_get_device(element->reference.handle,
>  						  &device);
>  			if (ret)
> -				return -ENODEV;
> +				return -EINVAL;
>  
>  			nargs = 0;
>  			element++;
> @@ -649,11 +648,11 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>  				else if (type == ACPI_TYPE_LOCAL_REFERENCE)
>  					break;
>  				else
> -					return -EPROTO;
> +					return -EINVAL;
>  			}
>  
>  			if (nargs > MAX_ACPI_REFERENCE_ARGS)
> -				return -EPROTO;
> +				return -EINVAL;
>  
>  			if (idx == index) {
>  				args->adev = device;
> @@ -670,13 +669,13 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>  				return -ENOENT;
>  			element++;
>  		} else {
> -			return -EPROTO;
> +			return -EINVAL;
>  		}
>  
>  		idx++;
>  	}
>  
> -	return -ENODATA;
> +	return -ENOENT;
>  }
>  EXPORT_SYMBOL_GPL(__acpi_node_get_property_reference);
>  
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 0c8958747c8b..a9ee5efe22d9 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -682,6 +682,10 @@ EXPORT_SYMBOL_GPL(fwnode_property_match_string);
>   * Caller is responsible to call fwnode_handle_put() on the returned
>   * args->fwnode pointer.
>   *
> + * Returns: %0 on success
> + *	    %-ENOENT when the index is out of bounds, the index has an empty
> + *		     reference or the property was not found
> + *	    %-EINVAL on parse error
>   */
>  int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
>  				       const char *prop, const char *nargs_prop,
> 


