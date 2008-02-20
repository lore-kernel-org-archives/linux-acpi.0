From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [2.6 patch] drivers/thermal/thermal.c: fix a check-after-use
Date: Tue, 19 Feb 2008 16:25:02 -0800
Message-ID: <1203467102.23194.2.camel@brick>
References: <20080220001404.GW31955@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.237]:27003 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755635AbYBTAYz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Feb 2008 19:24:55 -0500
Received: by qb-out-0506.google.com with SMTP id e11so2316170qbe.15
        for <linux-acpi@vger.kernel.org>; Tue, 19 Feb 2008 16:24:51 -0800 (PST)
In-Reply-To: <20080220001404.GW31955@cs181133002.pp.htv.fi>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Thomas Sujith <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2008-02-20 at 02:14 +0200, Adrian Bunk wrote:
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

How about:
	if (!tz || !cdev || trip >= tz->trips ||
	    (trip < 0 && trip != THERMAL_TRIPS_NONE))
		return -EINVAL;

Cheers,

Harvey

