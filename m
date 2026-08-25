Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED6E33A70A;
	Tue, 25 Aug 2026 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654434; cv=none; b=eOLC34VQ/kuMA7ur4RTRcbD5GQYgegCudecBsQmooAZOywwYK+/rx+47s3DW53GGu1fMM1/F80VVENbOgqHsmGBCb4AN8bfyF5FxJg9UsTROBT97oTi99mdsRlaMZOjwpeU8XTNgTDt2jqpBbNy5wXwuWDCnfo/OzDen0kQp2EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654434; c=relaxed/simple;
	bh=2UlGPhvf1IelelSqNZWrSHBBORdUH//fV9XtF1YIr3M=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QjI/dZ0hv6m25/I7NqHJOve2/vfxJDwbZU0e3YJOdOOp3MWIwvFGHLgdEyhhqkn54MIhxisvRv4C8wO/TKAjSw8tgQdVz2cJszp6Nr52ymATIGP/E83uEvS7z3Y7+lr1O4+wrMOW3QgU9MnLkR7kTps4n/SDbjN7ieVtU2k2+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISXg2O4N; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISXg2O4N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787654432; x=1819190432;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2UlGPhvf1IelelSqNZWrSHBBORdUH//fV9XtF1YIr3M=;
  b=ISXg2O4NwPSSlCTTNmz8WWCM05HT6bKDNFiJnIH2zMxax5ale7SyIC4E
   98R+VmL2fxNJpGijcAtGpWuKbXhLZfATMWSPhD4hC2d3KGoreb68L0YTr
   2uMebyUzkIdcs6lh/yGQQ0fRzGyy7/JiiVm0+RaddF7CX7t0bfGByhUS4
   JyNAmUul5lJtj2uL6QMvakQ9/PhV5fMZqddsYu59rf/ft+VL8gPIM6Gl5
   MDY1WnEcZZ6zZaUlMXIDkLrzRSdxRnQ+tqijPWJ/cJFfbGrrY1mrFpEih
   u2xCZyzdL0RBMqqUkNI1uaaVcz6H5bYdKNjTYcnN+57oTXdUzwr3efowv
   A==;
X-CSE-ConnectionGUID: nQEew+T4TSezH7JSqI1/Ow==
X-CSE-MsgGUID: CqMUzCSLTQePWvw6Gw8bHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="75652411"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="75652411"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 03:40:31 -0700
X-CSE-ConnectionGUID: OLEmgLAYQQOR6IwxK00jzw==
X-CSE-MsgGUID: c2paStVUT+exClcTDAVSSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="272475724"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 03:40:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 25 Aug 2026 13:40:25 +0300 (EEST)
To: Sakari Ailus <sakari.ailus@linux.intel.com>
cc: linux-media@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
    linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, 
    Daniel Scally <dan.scally@ideasonboard.com>, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 5/5] platform/x86: int3472: Clean up GPIO parsing
In-Reply-To: <20260824211338.3583976-6-sakari.ailus@linux.intel.com>
Message-ID: <dbf333db-28ca-78ab-db76-f1773db844c7@linux.intel.com>
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com> <20260824211338.3583976-6-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 25 Aug 2026, Sakari Ailus wrote:

> In skl_int3472_handle_gpio_resources(), return an error where it happens,
> except when we're holding a reference to a GPIO. This involves
> incrementing ngpios earlier on but that does not introduce a functional
> change.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/platform/x86/intel/int3472/discrete.c | 42 +++++++++----------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
> index 2024eaa09033..400bee9e4cb8 100644
> --- a/drivers/platform/x86/intel/int3472/discrete.c
> +++ b/drivers/platform/x86/intel/int3472/discrete.c
> @@ -369,15 +369,23 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>  		agpio->resource_source.string_ptr, agpio->pin_table[0],
>  		str_high_low(gpio_flags == GPIO_ACTIVE_HIGH));
>  
> +	/*
> +	 * int3472->ngpios can be incremented here as it is an argument to the
> +	 * _DSM, not e.g. an index to an array in C. Additionally, in case of an
> +	 * error the value won't be used.
> +	 */

I wasn't expecting comment for this. You might have added it because of 
my questions but IMO it's not needed.

I think just the old way/place was confusing, especially given how 
some/part of the error cases did increment it. But after moving it here, 
it makes much more sense even without that comment.

And one can determine it's not being used for C arrays by using grep so 
that too seems just unnecessary detail.

> +	int3472->ngpios++;
> +
>  	switch (type) {
>  	case INT3472_GPIO_TYPE_RESET:
>  	case INT3472_GPIO_TYPE_POWERDOWN:
>  	case INT3472_GPIO_TYPE_HOTPLUG_DETECT:
>  		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, con_id, gpio_flags);
>  		if (ret)
> -			dev_err_probe(int3472->dev, ret, "Failed to map GPIO pin to sensor\n");
> +			return dev_err_probe(int3472->dev, ret,
> +					     "Failed to map GPIO pin to sensor\n");
>  
> -		break;
> +		return 0;
>  	case INT3472_GPIO_TYPE_CLK_ENABLE:
>  	case INT3472_GPIO_TYPE_PRIVACY_LED:
>  	case INT3472_GPIO_TYPE_STROBE:
> @@ -385,24 +393,24 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>  	case INT3472_GPIO_TYPE_DOVDD:
>  	case INT3472_GPIO_TYPE_HANDSHAKE:
>  		gpio = skl_int3472_gpiod_get_from_temp_lookup(int3472, agpio, con_id, gpio_flags);
> -		if (IS_ERR(gpio)) {
> -			ret = PTR_ERR(gpio);
> -			dev_err_probe(int3472->dev, ret, "Failed to get GPIO\n");
> -			break;
> -		}
> +		if (IS_ERR(gpio))
> +			return dev_err_probe(int3472->dev, PTR_ERR(gpio),
> +					     "Failed to get GPIO\n");
>  
>  		switch (type) {
>  		case INT3472_GPIO_TYPE_CLK_ENABLE:
>  			ret = skl_int3472_register_gpio_clock(int3472, gpio);
>  			if (ret)
> -				dev_err_probe(int3472->dev, ret, "Failed to register clock\n");
> +				dev_err_probe(int3472->dev, ret,
> +					      "Failed to register clock\n");

Don't know why changed linesplits in this instead doing them directly in 
the 2nd patch.

>  
>  			break;
>  		case INT3472_GPIO_TYPE_PRIVACY_LED:
>  		case INT3472_GPIO_TYPE_STROBE:
>  			ret = skl_int3472_register_led(int3472, gpio, con_id);
>  			if (ret)
> -				dev_err_probe(int3472->dev, ret, "Failed to register LED\n");
> +				dev_err_probe(int3472->dev, ret,
> +					      "Failed to register LED\n");
>  
>  			break;
>  		case INT3472_GPIO_TYPE_POWER_ENABLE:
> @@ -413,7 +421,8 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>  			ret = skl_int3472_register_regulator(int3472, gpio, enable_time_us,
>  							     con_id, second_sensor);
>  			if (ret)
> -				dev_err_probe(int3472->dev, ret, "Failed to register regulator\n");
> +				dev_err_probe(int3472->dev, ret,
> +					      "Failed to register regulator\n");
>  
>  			break;
>  		default: /* Never reached */
> @@ -424,22 +433,13 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>  		if (ret)
>  			gpiod_put(gpio);
>  
> -		break;
> +		return ret;
>  	default:
>  		dev_warn(int3472->dev,
>  			 "GPIO type 0x%02x unknown; the sensor may not work\n",
>  			 type);
> -		ret = 1;
> -		break;
> +		return 1;
>  	}
> -
> -	int3472->ngpios++;
> -
> -	/*
> -	 * Either return an error or tell acpi_dev_get_resources() to not make a
> -	 * copy of the resource.
> -	 */
> -	return ret < 0 ? ret : 1;
>  }
>  
>  int int3472_discrete_parse_crs(struct int3472_discrete_device *int3472)
> 

-- 
 i.
