From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH] ACPI / sleep: Drop acpi_suspend() which is not used
Date: Wed, 18 Mar 2015 09:17:26 +0800
Message-ID: <5508D226.7040409@huawei.com>
References: <1426234469-6434-1-git-send-email-hanjun.guo@linaro.org> <20150317123536.GB14984@red-moon> <CAGHbJ3DhUB688K7ooT7ai=2QjRp7S+_E_Y+a+GupeTvjR5omMg@mail.gmail.com> <1460987.2Zo06X0UeC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:47082 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350AbbCRBRm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Mar 2015 21:17:42 -0400
In-Reply-To: <1460987.2Zo06X0UeC@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 2015/3/17 22:29, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The acpi_suspend() function has no callers, so drop it.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

> ---
>  drivers/acpi/sleep.c |   15 ---------------
>  drivers/acpi/sleep.h |    2 --
>  2 files changed, 17 deletions(-)
>
> Index: linux-pm/drivers/acpi/sleep.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -806,21 +806,6 @@ static void acpi_sleep_hibernate_setup(v
>  static inline void acpi_sleep_hibernate_setup(void) {}
>  #endif /* !CONFIG_HIBERNATION */
>  
> -int acpi_suspend(u32 acpi_state)
> -{
> -	suspend_state_t states[] = {
> -		[1] = PM_SUSPEND_STANDBY,
> -		[3] = PM_SUSPEND_MEM,
> -		[5] = PM_SUSPEND_MAX
> -	};
> -
> -	if (acpi_state < 6 && states[acpi_state])
> -		return pm_suspend(states[acpi_state]);
> -	if (acpi_state == 4)
> -		return hibernate();
> -	return -EINVAL;
> -}
> -
>  static void acpi_power_off_prepare(void)
>  {
>  	/* Prepare to power off the system */
> Index: linux-pm/drivers/acpi/sleep.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sleep.h
> +++ linux-pm/drivers/acpi/sleep.h
> @@ -1,6 +1,4 @@
>  
> -extern int acpi_suspend(u32 state);
> -
>  extern void acpi_enable_wakeup_devices(u8 sleep_state);
>  extern void acpi_disable_wakeup_devices(u8 sleep_state);
>  
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> .
>


