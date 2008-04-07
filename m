From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi thermal trip points increased to 12
Date: Tue, 8 Apr 2008 00:03:50 +0200
Message-ID: <200804080003.51567.rjw@sisk.pl>
References: <20080407235857.2486f460.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58036 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586AbYDGWDn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Apr 2008 18:03:43 -0400
In-Reply-To: <20080407235857.2486f460.krzysztof.h1@wp.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Andrew Morton <akpm@linux-foundation.org>

On Monday, 7 of April 2008, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> The THERMAL_MAX_TRIPS value is set to 10. It is too few
> for the Compaq AP550 machine which has 12 trip points.

Looks sane to me, but it's better to CC the maintainers.

> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
> 
> This patch was done against 2.6.25-rc8.
> 
> diff -urp linux-2.6.24/drivers/thermal/thermal.c linux-2.6.25/drivers/thermal/thermal.c
> --- linux-2.6.24/drivers/thermal/thermal.c	2008-04-07 23:18:14.712300799 +0200
> +++ linux-2.6.25/drivers/thermal/thermal.c	2008-04-07 23:47:23.531550750 +0200
> @@ -196,6 +196,10 @@ static struct device_attribute trip_poin
>  	__ATTR(trip_point_8_temp, 0444, trip_point_temp_show, NULL),
>  	__ATTR(trip_point_9_type, 0444, trip_point_type_show, NULL),
>  	__ATTR(trip_point_9_temp, 0444, trip_point_temp_show, NULL),
> +	__ATTR(trip_point_10_type, 0444, trip_point_type_show, NULL),
> +	__ATTR(trip_point_10_temp, 0444, trip_point_temp_show, NULL),
> +	__ATTR(trip_point_11_type, 0444, trip_point_type_show, NULL),
> +	__ATTR(trip_point_11_temp, 0444, trip_point_temp_show, NULL),
>  };
>  
>  #define TRIP_POINT_ATTR_ADD(_dev, _index, result)     \
> diff -urp linux-2.6.24/include/linux/thermal.h linux-2.6.25/include/linux/thermal.h
> --- linux-2.6.24/include/linux/thermal.h	2008-04-07 23:18:41.681807171 +0200
> +++ linux-2.6.25/include/linux/thermal.h	2008-04-07 23:26:24.201330930 +0200
> @@ -50,7 +50,7 @@ struct thermal_cooling_device_ops {
>  };
>  
>  #define THERMAL_TRIPS_NONE -1
> -#define THERMAL_MAX_TRIPS 10
> +#define THERMAL_MAX_TRIPS 12
>  #define THERMAL_NAME_LENGTH 20
>  struct thermal_cooling_device {
>  	int id;
> --

Thanks,
Rafael
