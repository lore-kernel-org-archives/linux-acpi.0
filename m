From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: add powerbutton and lid platform devices
Date: Mon, 9 Jul 2007 09:05:45 -0600
Message-ID: <20070709150545.GD31533@cosmic.amd.com>
References: <20070330235759.GC4252@cosmic.amd.com>
 <200704011728.10966.david-b@pacbell.net>
 <20070619170048.GA342@dmt.media.mit.edu>
 <200706201830.52277.david-b@pacbell.net> <20070708221027.GA4964@dmt>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:44274 "EHLO
	outbound1-dub-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750929AbXGIPE7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jul 2007 11:04:59 -0400
In-Reply-To: <20070708221027.GA4964@dmt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: David Brownell <david-b@pacbell.net>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, devel@laptop.org

On 08/07/07 18:10 -0400, Marcelo Tosatti wrote:
> Jordan,
> 
> This allows configuration of powerbutton/lid events... Are the 
> gpio_gpio_{clear,set} calls correct for enabling/disabling LID
> events?
> 
> What else do we want to support?

The obvious ones would be RTC (but you already covered that), and SCI.
But this is an excellent start. 

> --- olpc-pm.c.orig	2007-07-08 17:09:07.000000000 -0400
> +++ olpc-pm.c	2007-07-08 18:07:03.000000000 -0400
> @@ -54,6 +54,18 @@
>  
>  static int gpio_wake_events = 0;
>  static int ebook_state = -1;
> +static u16 olpc_wakeup_mask = 0;
> +
> +struct platform_device olpc_powerbutton_dev = {
> +	.name = "powerbutton",
> +	.id = 0,
> +};
> +
> +struct platform_device olpc_lid_dev = {
> +	.name = "lid",
> +	.id = 0,
> +};
> +

>  static void __init init_ebook_state(void)
>  {
> @@ -250,6 +262,16 @@
>  	/* Save the MFGPT MSRs */
>  	rdmsrl(MFGPT_IRQ_MSR, mfgpt_irq_msr);
>  	rdmsrl(MFGPT_NR_MSR, mfgpt_nr_msr);
> +
> +	if (device_may_wakeup(&olpc_powerbutton_dev.dev))
> +		olpc_wakeup_mask |= CS5536_PM_PWRBTN;
> +	else
> +		olpc_wakeup_mask &= ~(CS5536_PM_PWRBTN);
> +
> +	if (device_may_wakeup(&olpc_lid_dev.dev))
> +		geode_gpio_clear(OLPC_GPIO_LID, GPIO_EVENTS_ENABLE);
> +	else
> +		geode_gpio_set(OLPC_GPIO_LID, GPIO_EVENTS_ENABLE);
>  }

As was already mentioned before, the clear and set clauses should be
reversed. 

You'll also need to get rid of

outl(1 << 31, acpi_base + PM_GPE0_EN);

in olpc_pm_enter() since that would have the undesired effect of eliminating
the LID completely from the list of wakeup sources.  We should leave the
value of GPE0_EN the same through the lifetime of the system,
and control the individual events through the event enable bit(s) as you
have done above.

>  static int olpc_pm_enter(suspend_state_t pm_state)
> @@ -275,8 +297,6 @@
>  	return 0;
>  }
>  
> -static u16 olpc_wakeup_mask = CS5536_PM_PWRBTN;
> -
>  int asmlinkage olpc_do_sleep(u8 sleep_state)
>  {
>  	void *pgd_addr = __va(read_cr3());
> @@ -596,15 +616,20 @@
>  	.resource = rtc_platform_resource,
>  };
>  
> -static int __init olpc_rtc_init(void)
> +static int __init olpc_platform_init(void)
>  {
>  	(void)platform_device_register(&olpc_rtc_device);
> -
>  	device_init_wakeup(&olpc_rtc_device.dev, 1);
>  
> +	(void)platform_device_register(&olpc_powerbutton_dev);
> +	device_init_wakeup(&olpc_powerbutton_dev.dev, 1);
> +
> +	(void)platform_device_register(&olpc_lid_dev);
> +	device_init_wakeup(&olpc_lid_dev.dev, 1);
> +
>  	return 0;
>  }

I agree that the default setting for the power button should be to 
wake up, but I don't know about the lid.  Imagine a scenario where somebody
manually puts the machine to sleep and then shuts the lid.  You wouldn't want
the machine to turn back on when you lifted it.  Lid behavior is so policy 
driven, I think we should leave it off by default, and let the power manager
decide what to do.

> -arch_initcall(olpc_rtc_init);
> +arch_initcall(olpc_platform_init);
>  #endif /* CONFIG_RTC_DRV_CMOS */
>  
>  static void olpc_pm_exit(void)
> 
> 

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.


