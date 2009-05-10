From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: PROBLEM: (regression) thermal zone - fan is turned on at
	higher temperature than it should
Date: Sun, 10 May 2009 03:26:09 +0100
Message-ID: <20090510022609.GB14018@srcf.ucam.org>
References: <200905052105.07316.eightgraph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38772 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755635AbZEJC0M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 May 2009 22:26:12 -0400
Content-Disposition: inline
In-Reply-To: <200905052105.07316.eightgraph@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vladimir Zajac <eightgraph@gmail.com>
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org

On Tue, May 05, 2009 at 09:05:07PM +0200, Vladimir Zajac wrote:
> --- linux-2.6.30-rc4/drivers/thermal/thermal_sys.c	2009-04-30 23:52:59.000000000 +0200
> +++ linux-2.6.30-rc4-p1/drivers/thermal/thermal_sys.c	2009-05-04 19:58:30.000000000 +0200
> @@ -961,7 +961,7 @@ void thermal_zone_device_update(struct t
>  
>  		switch (trip_type) {
>  		case THERMAL_TRIP_CRITICAL:
> -			if (temp > trip_temp) {
> +			if (temp >= trip_temp) {
>  				if (tz->ops->notify)
>  					ret = tz->ops->notify(tz, count,
>  							      trip_type);
> @@ -974,7 +974,7 @@ void thermal_zone_device_update(struct t
>  			}
>  			break;
>  		case THERMAL_TRIP_HOT:
> -			if (temp > trip_temp)
> +			if (temp >= trip_temp)
>  				if (tz->ops->notify)
>  					tz->ops->notify(tz, count, trip_type);
>  			break;
> @@ -986,14 +986,14 @@ void thermal_zone_device_update(struct t
>  
>  				cdev = instance->cdev;
>  
> -				if (temp > trip_temp)
> +				if (temp >= trip_temp)
>  					cdev->ops->set_cur_state(cdev, 1);
>  				else
>  					cdev->ops->set_cur_state(cdev, 0);
>  			}
>  			break;
>  		case THERMAL_TRIP_PASSIVE:
> -			if (temp > trip_temp || tz->passive)
> +			if (temp >= trip_temp || tz->passive)
>  				thermal_zone_device_passive(tz, temp,
>  							    trip_temp, count);
>  			break;

Looks good. You probably need to resend it with a Signed-off-by: line, 
but feel free to add

Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
