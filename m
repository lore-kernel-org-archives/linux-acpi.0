From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH 1/2] video: always update the brightness when poking
	"brightness"
Date: Wed, 31 Dec 2008 14:16:00 +0000
Message-ID: <1230732960.5325.10.camel@dax.rpnet.com>
References: <1230088058.562.219.camel@rzhang-dt>
	 <1230633250.5328.8.camel@dax.rpnet.com>
	 <1230687781.562.249.camel@rzhang-dt> <20081231020146.GA24861@srcf.ucam.org>
	 <1230692328.562.289.camel@rzhang-dt> <20081231031402.GA25503@srcf.ucam.org>
	 <20081231134116.GA31733@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:54789 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755166AbYLaOQI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 31 Dec 2008 09:16:08 -0500
In-Reply-To: <20081231134116.GA31733@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wed, 2008-12-31 at 13:41 +0000, Matthew Garrett wrote:
> Richard, how about something like this? If the hardware changes the 
> state of the backlight behind us, the current code may make it 
> impossible to set it back to the previous state without resynchronising 
> the value first. Is there any currently supported hardware where this 
> would be a sufficiently expensive or disruptive operation to warrant the 
> check?

I'll accept that argument. It is an expensive operation on some hardware
but that path already has sysfs writes etc. so it doesn't really matter.
If it really bothers some hardware they can make the check in the driver
I guess.

I'll be sorting out the backlight tree in the next day or so and will
queue something like this for merging.

Cheers,

Richard


> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index fab0bc8..064b428 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -134,10 +134,8 @@ static ssize_t backlight_store_brightness(struct device *dev,
>  		else {
>  			pr_debug("backlight: set brightness to %d\n",
>  				 brightness);
> -			if (bd->props.brightness != brightness) {
> -				bd->props.brightness = brightness;
> -				backlight_update_status(bd);
> -			}
> +			bd->props.brightness = brightness;
> +			backlight_update_status(bd);
>  			rc = count;
>  		}
>  	}
> 
-- 
Richard Purdie
Intel Open Source Technology Centre

