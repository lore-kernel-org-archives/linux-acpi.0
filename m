From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] [PATCH 1/3] Allow to override the RTC alarm time
Date: Wed, 9 Apr 2008 00:34:41 -0700
Message-ID: <200804090034.42339.david-b@pacbell.net>
References: <1207722851.5997.16.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:35566 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751035AbYDIHv3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Apr 2008 03:51:29 -0400
In-Reply-To: <1207722851.5997.16.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com

On Tuesday 08 April 2008, Zhao Yakui wrote:
> Subject: ACPI: Allow to override the RTC alarm time 
> >From : Zhao Yakui <yakui.zhao@intel.com>
> 
> In current kernel when RTC alarm time is set and not fired,
> it is impossible to set RTC alarm again. But it is more
> reasonable that the RTC alarm time can be overrided.

I'll disagree.  The problem is that if some task is waiting
for the alarm at the specified time, you've just trashed the
alarm it was relying on.


> --- linux-2.6.orig/drivers/rtc/rtc-sysfs.c
> +++ linux-2.6/drivers/rtc/rtc-sysfs.c
> @@ -163,8 +163,6 @@ rtc_sysfs_set_wakealarm(struct device *d

The comment explains much of this ... and if this patch
were deemed to be good, you should have changed that comment
rather than making it a lie:

                /* Avoid accidentally clobbering active alarms; we can't
                 * entirely prevent that here, without even the minimal
                 * locking from the /dev/rtcN api.
                 */
                retval = rtc_read_alarm(rtc, &alm);


>  		retval = rtc_read_alarm(rtc, &alm);
>  		if (retval < 0)
>  			return retval;
> -		if (alm.enabled)
> -			return -EBUSY;
>  
>  		alm.enabled = 1;
>  	} else {
> 
> 


