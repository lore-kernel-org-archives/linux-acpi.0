Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565BB440A33;
	Thu, 27 Aug 2026 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829416; cv=none; b=spfIDRhirGyk4GUflMDFxCBcBmZg2EWexlGPSZd5tIQ4UfqL3de979WlOQ0QXHBjp0rIv11Ae6B+KFxmZPcUiJzIaOWOuNVrHAnG76Aniw8IfYaYY51hpkl0rmtSGaG1cmogcAuI7Hy47Pmg6QSsnuuF+fZ22+DGFC8OuIy4Wr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829416; c=relaxed/simple;
	bh=koBFJDRMtLELxZlpfcbEOgFAl7hgy7btV+UmTKv+iAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpobQgDBNW2p9ak09ePDwWUGPBipiVLAOogc8XB7o1VF5CDniBut2O3YfQUdjLuhMUpwxLLRORQBwfCvHouBRoyxyUm/3V6IRz7EM7jfYiGPttWf1tFCL8lhYoyyCb2Pguw+wxheRfeVaG2MTBFl/4q+8aqz0q5FYQwi3uarn9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=nZBzC+XY; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nZBzC+XY"
Received: from [192.168.68.124] (unknown [149.106.186.222])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4E557512;
	Thu, 27 Aug 2026 13:15:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1787829318;
	bh=koBFJDRMtLELxZlpfcbEOgFAl7hgy7btV+UmTKv+iAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nZBzC+XYpCv8Th8foygZXsnouTQTtx3+8VD5YLkFCHXw1Bn2jPhh5FPckfhppU9x2
	 gjmrrSV5ECqCIhEUoY93oqDr/wBvFRHoZ5KU5KyPI3DikwRUtAWp6oZnPYijf4I7j+
	 GWzoskNKV2vV2Wyqy3yWNfihH8EDj7YZY1OgdRkk=
Message-ID: <6c171d7f-d2e2-440c-9beb-97be894d63f0@ideasonboard.com>
Date: Thu, 27 Aug 2026 12:16:41 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] platform/x86: int3472: Fix uninitialised variable
 warning
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
 Len Brown <lenb@kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
References: <20260825203553.3725132-1-sakari.ailus@linux.intel.com>
 <20260825203553.3725132-3-sakari.ailus@linux.intel.com>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <20260825203553.3725132-3-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sakari - thanks for the patch

On 25/08/2026 21:35, Sakari Ailus wrote:
> Fix a smatch warning about uninitialised err_msg variable, by printing the
> error where it is handled.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---

Oops, wonder why I didn't spot the compiler warning.

Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>

>   drivers/platform/x86/intel/int3472/discrete.c | 25 +++++++++++--------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
> index 6c729fcfce5d..9cd4f78875ab 100644
> --- a/drivers/platform/x86/intel/int3472/discrete.c
> +++ b/drivers/platform/x86/intel/int3472/discrete.c
> @@ -329,7 +329,6 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>   	unsigned long gpio_flags;
>   	union acpi_object *obj;
>   	struct gpio_desc *gpio;
> -	const char *err_msg;
>   	const char *con_id;
>   	int ret;
>   
> @@ -375,7 +374,8 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>   	case INT3472_GPIO_TYPE_HOTPLUG_DETECT:
>   		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, con_id, gpio_flags);
>   		if (ret)
> -			err_msg = "Failed to map GPIO pin to sensor\n";
> +			dev_err_probe(int3472->dev, ret,
> +				      "Failed to map GPIO pin to sensor\n");
>   
>   		break;
>   	case INT3472_GPIO_TYPE_CLK_ENABLE:
> @@ -387,7 +387,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>   		gpio = skl_int3472_gpiod_get_from_temp_lookup(int3472, agpio, con_id, gpio_flags);
>   		if (IS_ERR(gpio)) {
>   			ret = PTR_ERR(gpio);
> -			err_msg = "Failed to get GPIO\n";
> +			dev_err_probe(int3472->dev, ret, "Failed to get GPIO\n");
>   			break;
>   		}
>   
> @@ -395,14 +395,16 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>   		case INT3472_GPIO_TYPE_CLK_ENABLE:
>   			ret = skl_int3472_register_gpio_clock(int3472, gpio);
>   			if (ret)
> -				err_msg = "Failed to register clock\n";
> +				dev_err_probe(int3472->dev, ret,
> +					      "Failed to register clock\n");
>   
>   			break;
>   		case INT3472_GPIO_TYPE_PRIVACY_LED:
>   		case INT3472_GPIO_TYPE_STROBE:
>   			ret = skl_int3472_register_led(int3472, gpio, con_id);
>   			if (ret)
> -				err_msg = "Failed to register LED\n";
> +				dev_err_probe(int3472->dev, ret,
> +					      "Failed to register LED\n");
>   
>   			break;
>   		case INT3472_GPIO_TYPE_POWER_ENABLE:
> @@ -413,7 +415,8 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>   			ret = skl_int3472_register_regulator(int3472, gpio, enable_time_us,
>   							     con_id, second_sensor);
>   			if (ret)
> -				err_msg = "Failed to register regulator\n";
> +				dev_err_probe(int3472->dev, ret,
> +					      "Failed to register regulator\n");
>   
>   			break;
>   		default: /* Never reached */
> @@ -436,11 +439,11 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>   	int3472->ngpios++;
>   	ACPI_FREE(obj);
>   
> -	if (ret < 0)
> -		return dev_err_probe(int3472->dev, ret, err_msg);
> -
> -	/* Tell acpi_dev_get_resources() to not make a copy of the resource */
> -	return 1;
> +	/*
> +	 * Either return an error or tell acpi_dev_get_resources() to not make a
> +	 * copy of the resource.
> +	 */
> +	return ret < 0 ? ret : 1;
>   }
>   
>   int int3472_discrete_parse_crs(struct int3472_discrete_device *int3472)

