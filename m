From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2/6] thermal: add  new get_crit_temp callback
Date: Wed, 16 Apr 2008 22:40:51 +0200
Message-ID: <20080416224051.49a156fb@hyperion.delvare>
References: <1207815190.27304.34.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:13339 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760823AbYDPUlC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Apr 2008 16:41:02 -0400
In-Reply-To: <1207815190.27304.34.camel@acpi-hp-zz.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi <linux-acpi@vger.kernel.org>

Hi Rui,

On Thu, 10 Apr 2008 16:13:10 +0800, Zhang, Rui wrote:
> 
> Add a new callback so that the generic thermal can get
> the critical trip point info of a thermal zone,
> which is needed for building the tempX_crit hwmon sysfs attribute.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/thermal.c  |   13 +++++++++++++
>  include/linux/thermal.h |    1 +
>  2 files changed, 14 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/thermal.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/thermal.c
> +++ linux-2.6/drivers/acpi/thermal.c
> @@ -1012,6 +1012,18 @@ static int thermal_get_trip_temp(struct 
>  	return -EINVAL;
>  }
>  
> +static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
> +				unsigned long *temperature) {
> +	struct acpi_thermal *tz = thermal->devdata;
> +
> +	if (tz->trips.critical.flags.valid) {
> +		*temperature = KELVIN_TO_MILLICELSIUS(
> +				tz->trips.critical.temperature);
> +		return 0;
> +	} else
> +		return -EINVAL;
> +}
> +
>  typedef int (*cb)(struct thermal_zone_device *, int,
>  		  struct thermal_cooling_device *);
>  static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
> @@ -1103,6 +1115,7 @@ static struct thermal_zone_device_ops ac
>  	.set_mode = thermal_set_mode,
>  	.get_trip_type = thermal_get_trip_type,
>  	.get_trip_temp = thermal_get_trip_temp,
> +	.get_crit_temp = thermal_get_crit_temp,
>  };
>  
>  static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
> Index: linux-2.6/include/linux/thermal.h
> ===================================================================
> --- linux-2.6.orig/include/linux/thermal.h
> +++ linux-2.6/include/linux/thermal.h
> @@ -41,6 +41,7 @@ struct thermal_zone_device_ops {
>  	int (*set_mode) (struct thermal_zone_device *, const char *);
>  	int (*get_trip_type) (struct thermal_zone_device *, int, char *);
>  	int (*get_trip_temp) (struct thermal_zone_device *, int, char *);
> +	int (*get_crit_temp) (struct thermal_zone_device *, unsigned long *);
>  };
>  
>  struct thermal_cooling_device_ops {
> 
> 

I like this a lot, it's much cleaner and more efficient than using
get_trip_temp + get_trip_type as the previous patchset was doing. Well
done!

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
