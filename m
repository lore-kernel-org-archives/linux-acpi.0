From: Len Brown <lenb@kernel.org>
Subject: Re: [2.6 patch] drivers/thermal/thermal.c: fix a check-after-use
Date: Sat, 23 Feb 2008 02:19:49 -0500
Message-ID: <200802230219.50120.lenb@kernel.org>
References: <20080220001404.GW31955@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60242 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbYBWHUE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 23 Feb 2008 02:20:04 -0500
In-Reply-To: <20080220001404.GW31955@cs181133002.pp.htv.fi>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Thomas Sujith <sujith.thomas@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 19 February 2008 19:14, Adrian Bunk wrote:
> This patch fixes a check-after-use spotted by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> 570462ca4441d8d63dfd46efe6e5b2b1c251a611 diff --git a/drivers/thermal/thermal.c b/drivers/thermal/thermal.c
> index e782b3e..958654b 100644
> --- a/drivers/thermal/thermal.c
> +++ b/drivers/thermal/thermal.c
> @@ -308,10 +308,10 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  	struct thermal_cooling_device_instance *pos;
>  	int result;
>  
> -	if (trip >= tz->trips || (trip < 0 && trip != THERMAL_TRIPS_NONE))
> +	if (!tz || !cdev)
>  		return -EINVAL;
>  
> -	if (!tz || !cdev)
> +	if (trip >= tz->trips || (trip < 0 && trip != THERMAL_TRIPS_NONE))
>  		return -EINVAL;
>  
>  	dev =
> 
> --

this patch no longer applies because the bogus check for a programming error
was already replaced by a better check of run-time params.

thanks,
-len
