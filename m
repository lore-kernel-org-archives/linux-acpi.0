From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] rtc-cmos: use cmos_rtc_board_info to determine wake_on callback
Date: Sat, 7 Jul 2007 22:06:03 -0700
Message-ID: <200707072206.03895.david-b@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com> <20070402165511.GD5024@cosmic.amd.com> <20070708034953.GB19633@dmt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:37730 "HELO
	smtp110.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751243AbXGHF0x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Jul 2007 01:26:53 -0400
In-Reply-To: <20070708034953.GB19633@dmt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: Jordan Crouse <jordan.crouse@amd.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, devel@laptop.org

On Saturday 07 July 2007, Marcelo Tosatti wrote:
> 
> From my understand ACPI fills a cmos_rtc_board_info with pointers for
> wake_on/wake_off callbacks and registers that at dev->platform_data.
> 
> So use that to retrieve the callback pointers.
> 
> Am I missing something?

This is retrieved already in the probe() routine, which
does other board-specific setup that may be needed.

So this patch isn't needed.  Or, in fact, correct ... both
the wake_on() and wake_off() methods are required.


> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index e24ea82..5bfab23 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -549,6 +549,7 @@ #ifdef	CONFIG_PM
>  static int cmos_suspend(struct device *dev, pm_message_t mesg)
>  {
>  	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
> +	struct cmos_rtc_board_info *board_info = dev->platform_data;
>  	int		do_wake = device_may_wakeup(dev);
>  	unsigned char	tmp;
>  
> @@ -572,8 +573,8 @@ static int cmos_suspend(struct device *d
>  
>  	if (tmp & RTC_AIE) {
>  		cmos->enabled_wake = 1;
> -		if (cmos->wake_on)
> -			cmos->wake_on(dev);
> +		if (board_info->wake_on)
> +			board_info->wake_on(dev);
>  		else
>  			enable_irq_wake(cmos->irq);
>  	}
> 


