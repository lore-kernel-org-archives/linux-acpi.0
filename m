From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] [PATCH 3/3] Add the support for alarm time relative to current time in sysfs
Date: Wed, 9 Apr 2008 00:51:23 -0700
Message-ID: <200804090051.23829.david-b@pacbell.net>
References: <1207723076.5997.22.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:35571 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752419AbYDIHvb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Apr 2008 03:51:31 -0400
In-Reply-To: <1207723076.5997.22.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, Alessandro Zummo <alessandro.zummo@towertech.it>

On Tuesday 08 April 2008, Zhao Yakui wrote:
> Subject: ACPI: Add the support for alarm time relative to current time in sysfs
> >From : Zhao Yakui <yakui.zhao@intel.com>
> 
> In current kernel if we want to set the alarm time, the absolute time
> the seconds relative to 1970-01-01 00:00:00) should be written into 
> /sys/class/rtc/rtc0/wakealarm. It is not convenient.
> 
> It is more reasonable to add the support for the alarm time 
> relative to current RTC time.(the unit is second)
> For example: 
> If the RTC is required to generate alarm after 2 minutes, the following will
> be OK.
> 	echo +120 > /sys/class/rtc/rtc0/wakealarm
> or      echo +0x78 > /sys/class/rtc/rtc0/wakealarm
> 
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Signed-off-by: Zhang Rui  <rui.zhang@intel.com>

Makes sense.

Acked-by: David Brownell <dbrownell@users.sourceforge.net>

> 
> ---
>  drivers/rtc/rtc-sysfs.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/rtc/rtc-sysfs.c
> ===================================================================
> --- linux-2.6.orig/drivers/rtc/rtc-sysfs.c
> +++ linux-2.6/drivers/rtc/rtc-sysfs.c
> @@ -145,6 +145,8 @@ rtc_sysfs_set_wakealarm(struct device *d
>  	unsigned long now, alarm;
>  	struct rtc_wkalrm alm;
>  	struct rtc_device *rtc = to_rtc_device(dev);
> +	char *buf_ptr;
> +	int adjust = 0;
>  
>  	/* Only request alarms that trigger in the future.  Disable them
>  	 * by writing another time, e.g. 0 meaning Jan 1 1970 UTC.
> @@ -154,7 +156,15 @@ rtc_sysfs_set_wakealarm(struct device *d
>  		return retval;
>  	rtc_tm_to_time(&alm.time, &now);
>  
> -	alarm = simple_strtoul(buf, NULL, 0);
> +	buf_ptr = (char *)buf;
> +	if (*buf_ptr == '+') {
> +		buf_ptr++;
> +		adjust = 1;
> +	}
> +	alarm = simple_strtoul(buf_ptr, NULL, 0);
> +	if (adjust) {
> +		alarm += now;
> +	}
>  	if (alarm > now) {
>  		/* Avoid accidentally clobbering active alarms; we can't
>  		 * entirely prevent that here, without even the minimal
> 
> 


