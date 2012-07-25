From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH RESEND 04/16] Thermal: Introduce multiple cooling states support
Date: Wed, 25 Jul 2012 22:06:16 +0200
Message-ID: <201207252206.16897.rjw@sisk.pl>
References: <1343182273-32096-1-git-send-email-rui.zhang@intel.com> <1343182273-32096-5-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:57054 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828Ab2GYUAa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2012 16:00:30 -0400
In-Reply-To: <1343182273-32096-5-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Wednesday, July 25, 2012, Zhang Rui wrote:
> This is because general active cooling devices, like fans,
> may have multiple speeds, which can be mapped to different cooling states.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  drivers/thermal/thermal_sys.c |   12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 2d7a9fe..05f42cd 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -1059,6 +1059,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  	enum thermal_trip_type trip_type;
>  	struct thermal_cooling_device_instance *instance;
>  	struct thermal_cooling_device *cdev;
> +	unsigned long cur_state, max_state;
>  
>  	mutex_lock(&tz->lock);
>  
> @@ -1098,10 +1099,17 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  
>  				cdev = instance->cdev;
>  
> +				cdev->ops->get_cur_state(cdev, &cur_state);
> +				cdev->ops->get_max_state(cdev, &max_state);
> +
>  				if (temp >= trip_temp)
> -					cdev->ops->set_cur_state(cdev, 1);
> +					cur_state = cur_state < max_state ?
> +						(cur_state + 1) : max_state;
>  				else
> -					cdev->ops->set_cur_state(cdev, 0);
> +					cur_state = cur_state > 0 ?
> +						(cur_state - 1) : 0;
> +
> +				cdev->ops->set_cur_state(cdev, cur_state);
>  			}
>  			break;
>  		case THERMAL_TRIP_PASSIVE:
> 

