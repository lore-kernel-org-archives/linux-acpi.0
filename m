Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97DD43F0AA;
	Thu, 27 Aug 2026 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787830793; cv=none; b=Ci3XN5ngrca0nDxlU6Ff9HfVIyKfAv8cPQbyAOUsBZ42T7DhF/CuMIhCYRhSqFdng8aK/CPiEa8T9GJU5Oh3JotmuwIkN289/IY22uw4AT95G6odYG+JVflImIYgfTn1Nz/9Wia4AbMGPxqNqcOlQlfWsqanx3A/xUc0DNgtafk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787830793; c=relaxed/simple;
	bh=XULJagCawLGGMzu4v5oVG+lE3/xVT1oj3u8TI7aSukc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPWywdPAwK1sGTldDXkKaJgal6vrI+wsXI8aoCKQ2fu9ZbCuGwIrHTYDaTVZUVM3cXtDzz0NNU6PMHyp0i0Lno+GKslH1UZ3FQoEZTV0fZjYPqRldjHM2aR/s+v3FNKT/O7xdJeTThSeCgLnYOMzkOo6ck8BmD7RVbreHCVEYSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=rPCOCNsf; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rPCOCNsf"
Received: from [192.168.68.124] (unknown [149.106.186.222])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 99FAA512;
	Thu, 27 Aug 2026 13:38:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1787830702;
	bh=XULJagCawLGGMzu4v5oVG+lE3/xVT1oj3u8TI7aSukc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rPCOCNsfjuz9ZCpgYLpWlL21TlzT5IgK5QDbrbOkbWGBYi2Wf/g3gqsv+n8Csttt/
	 wVCxqLvBffb3J98fV5/q/Xuti5rhWBFhhwMHcNBqyDeZy2+LCK+LQP3q33ocSq9uCK
	 hZpTfKA1q8yIj3VIqmdb2pVCc5QePgrpVmM1JRgY=
Message-ID: <e8175f36-eeee-4c24-99ea-de25bd698fe2@ideasonboard.com>
Date: Thu, 27 Aug 2026 12:39:45 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] platform/x86: int3472: Clean up GPIO parsing
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
 Len Brown <lenb@kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
References: <20260825203553.3725132-1-sakari.ailus@linux.intel.com>
 <20260825203553.3725132-4-sakari.ailus@linux.intel.com>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <20260825203553.3725132-4-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sakari, thanks for the patch

On 25/08/2026 21:35, Sakari Ailus wrote:
> In skl_int3472_handle_gpio_resources(), only a single integer value from
> the ACPI object is used so release it early and avoid having to call
> ACPI_FREE() on it later on. This makes it possible to return an error
> where it happens, except when we're holding a reference to a GPIO. ngpios
> is also incremented earlier on but that does not introduce a functional
> change.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---

Looks good to me:

Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>

>   drivers/platform/x86/intel/int3472/discrete.c | 42 ++++++++-----------
>   1 file changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
> index 9cd4f78875ab..1f8751a7db0c 100644
> --- a/drivers/platform/x86/intel/int3472/discrete.c
> +++ b/drivers/platform/x86/intel/int3472/discrete.c
> @@ -328,6 +328,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>   	u8 active_value, pin, type;
>   	unsigned long gpio_flags;
>   	union acpi_object *obj;
> +	unsigned int obj_value;
>   	struct gpio_desc *gpio;
>   	const char *con_id;
>   	int ret;
> @@ -343,24 +344,27 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>   				      &int3472_gpio_guid, 0x00,
>   				      int3472->ngpios + 2,
>   				      NULL, ACPI_TYPE_INTEGER);
> -
>   	if (!obj) {
>   		dev_warn(int3472->dev, "No _DSM entry for GPIO pin %u\n",
>   			 agpio->pin_table[0]);
>   		return 1;
>   	}
>   
> -	type = FIELD_GET(INT3472_GPIO_DSM_TYPE, obj->integer.value);
> +	obj_value = obj->integer.value;
> +
> +	ACPI_FREE(obj);
> +
> +	type = FIELD_GET(INT3472_GPIO_DSM_TYPE, obj_value);
>   
>   	int3472_get_con_id_and_polarity(int3472, &type, &con_id, &gpio_flags, &enable_time_us);
>   
> -	pin = FIELD_GET(INT3472_GPIO_DSM_PIN, obj->integer.value);
> +	pin = FIELD_GET(INT3472_GPIO_DSM_PIN, obj_value);
>   	/* Pin field is not really used under Windows and wraps around at 8 bits */
>   	if (pin != (agpio->pin_table[0] & 0xff))
>   		dev_dbg(int3472->dev, FW_BUG "%s %s pin number mismatch _DSM %d resource %d\n",
>   			con_id, agpio->resource_source.string_ptr, pin, agpio->pin_table[0]);
>   
> -	active_value = FIELD_GET(INT3472_GPIO_DSM_SENSOR_ON_VAL, obj->integer.value);
> +	active_value = FIELD_GET(INT3472_GPIO_DSM_SENSOR_ON_VAL, obj_value);
>   	if (!active_value)
>   		gpio_flags ^= GPIO_ACTIVE_LOW;
>   
> @@ -368,16 +372,18 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>   		agpio->resource_source.string_ptr, agpio->pin_table[0],
>   		str_high_low(gpio_flags == GPIO_ACTIVE_HIGH));
>   
> +	int3472->ngpios++;
> +
>   	switch (type) {
>   	case INT3472_GPIO_TYPE_RESET:
>   	case INT3472_GPIO_TYPE_POWERDOWN:
>   	case INT3472_GPIO_TYPE_HOTPLUG_DETECT:
>   		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, con_id, gpio_flags);
>   		if (ret)
> -			dev_err_probe(int3472->dev, ret,
> -				      "Failed to map GPIO pin to sensor\n");
> +			return dev_err_probe(int3472->dev, ret,
> +					     "Failed to map GPIO pin to sensor\n");
>   
> -		break;
> +		return 1;
>   	case INT3472_GPIO_TYPE_CLK_ENABLE:
>   	case INT3472_GPIO_TYPE_PRIVACY_LED:
>   	case INT3472_GPIO_TYPE_STROBE:
> @@ -385,11 +391,9 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>   	case INT3472_GPIO_TYPE_DOVDD:
>   	case INT3472_GPIO_TYPE_HANDSHAKE:
>   		gpio = skl_int3472_gpiod_get_from_temp_lookup(int3472, agpio, con_id, gpio_flags);
> -		if (IS_ERR(gpio)) {
> -			ret = PTR_ERR(gpio);
> -			dev_err_probe(int3472->dev, ret, "Failed to get GPIO\n");
> -			break;
> -		}
> +		if (IS_ERR(gpio))
> +			return dev_err_probe(int3472->dev, PTR_ERR(gpio),
> +					     "Failed to get GPIO\n");
>   
>   		switch (type) {
>   		case INT3472_GPIO_TYPE_CLK_ENABLE:
> @@ -427,23 +431,13 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>   		if (ret)
>   			gpiod_put(gpio);
>   
> -		break;
> +		return ret < 0 ? ret : 1;
>   	default:
>   		dev_warn(int3472->dev,
>   			 "GPIO type 0x%02x unknown; the sensor may not work\n",
>   			 type);
> -		ret = 1;
> -		break;
> +		return 1;
>   	}
> -
> -	int3472->ngpios++;
> -	ACPI_FREE(obj);
> -
> -	/*
> -	 * Either return an error or tell acpi_dev_get_resources() to not make a
> -	 * copy of the resource.
> -	 */
> -	return ret < 0 ? ret : 1;
>   }
>   
>   int int3472_discrete_parse_crs(struct int3472_discrete_device *int3472)

