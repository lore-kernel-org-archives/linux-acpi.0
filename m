From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH resend] rtc-cmos: report wakeup event on ACPI RTC alarm
Date: Thu, 10 May 2012 22:06:42 +0200
Message-ID: <201205102206.42891.rjw@sisk.pl>
References: <20120509231845.0301C9D401E@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:36799 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755813Ab2EJUBv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 May 2012 16:01:51 -0400
In-Reply-To: <20120509231845.0301C9D401E@zog.reactivated.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>, Len Brown <lenb@kernel.org>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, pgf@laptop.org, John Stultz <john.stultz@linaro.org>

On Thursday, May 10, 2012, Daniel Drake wrote:
> When the ACPI-driven RTC alarm wakes the system, report it as a wakeup
> event. This allows userspace to determine that the reason for system
> wakeup was RTC alarm.
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>

Len, John, any objections to this or may I take it for v3.5?

Rafael


> ---
>  drivers/rtc/rtc-cmos.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> Resending after 3 weeks with no response.
> 
> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index 7d5f56e..4267789 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -910,14 +910,17 @@ static inline int cmos_poweroff(struct device *dev)
>  
>  static u32 rtc_handler(void *context)
>  {
> +	struct device *dev = context;
> +
> +	pm_wakeup_event(dev, 0);
>  	acpi_clear_event(ACPI_EVENT_RTC);
>  	acpi_disable_event(ACPI_EVENT_RTC, 0);
>  	return ACPI_INTERRUPT_HANDLED;
>  }
>  
> -static inline void rtc_wake_setup(void)
> +static inline void rtc_wake_setup(struct device *dev)
>  {
> -	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, NULL);
> +	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, dev);
>  	/*
>  	 * After the RTC handler is installed, the Fixed_RTC event should
>  	 * be disabled. Only when the RTC alarm is set will it be enabled.
> @@ -950,7 +953,7 @@ cmos_wake_setup(struct device *dev)
>  	if (acpi_disabled)
>  		return;
>  
> -	rtc_wake_setup();
> +	rtc_wake_setup(dev);
>  	acpi_rtc_info.wake_on = rtc_wake_on;
>  	acpi_rtc_info.wake_off = rtc_wake_off;
>  
> 

