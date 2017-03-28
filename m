From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v22 03/11] clocksource: arm_arch_timer: refactor
 arch_timer_needs_probing
Date: Tue, 28 Mar 2017 17:02:20 +0200
Message-ID: <20170328150220.GF2123@mai>
References: <20170321163122.9183-1-fu.wei@linaro.org>
 <20170321163122.9183-4-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38867 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755082AbdC1PC4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2017 11:02:56 -0400
Received: by mail-wm0-f49.google.com with SMTP id t189so1056280wmt.1
        for <linux-acpi@vger.kernel.org>; Tue, 28 Mar 2017 08:02:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170321163122.9183-4-fu.wei@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fu.wei@linaro.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, marc.zyngier@arm.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de, catalin.marinas@arm.com, will.deacon@arm.com, Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be, linux@roeck-us.net, linux-watchdog@vger.kernel.org, tn@semihalf.com, christoffer.dall@linaro.org, julien.grall@arm.com

On Wed, Mar 22, 2017 at 12:31:14AM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> When system init with device-tree, we don't know which node will be
> initialized first. And the code in arch_timer_common_init should wait
> until per-cpu timer and MMIO timer are both initialized. So we need
> arch_timer_needs_probing to detect the init status of system.
> 
> But currently the code is dispersed in arch_timer_needs_probing and
> arch_timer_common_init. And the function name doesn't specify that
> it's only for device-tree. This is somewhat confusing.

Can the following patch help you to solve nicely the situation ?

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1360007.html
 
> This patch move all related code from arch_timer_common_init to
> arch_timer_needs_probing, refactor it, and rename it to
> arch_timer_needs_of_probing. And make sure that it will be called
> only if acpi is disabled.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 29ca7d6..d1a05d9 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -839,15 +839,28 @@ static const struct of_device_id arch_timer_mem_of_match[] __initconst = {
>  	{},
>  };
>  
> -static bool __init
> -arch_timer_needs_probing(int type, const struct of_device_id *matches)
> +static bool __init arch_timer_needs_of_probing(void)
>  {
>  	struct device_node *dn;
>  	bool needs_probing = false;
> +	unsigned int mask = ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
>  
> -	dn = of_find_matching_node(NULL, matches);
> -	if (dn && of_device_is_available(dn) && !(arch_timers_present & type))
> +	/* We have two timers, and both device-tree nodes are probed. */
> +	if ((arch_timers_present & mask) == mask)
> +		return false;
> +
> +	/*
> +	 * Only one type of timer is probed,
> +	 * check if we have another type of timer node in device-tree.
> +	 */
> +	if (arch_timers_present & ARCH_TIMER_TYPE_CP15)
> +		dn = of_find_matching_node(NULL, arch_timer_mem_of_match);
> +	else
> +		dn = of_find_matching_node(NULL, arch_timer_of_match);
> +
> +	if (dn && of_device_is_available(dn))
>  		needs_probing = true;
> +
>  	of_node_put(dn);
>  
>  	return needs_probing;
> @@ -855,17 +868,8 @@ arch_timer_needs_probing(int type, const struct of_device_id *matches)
>  
>  static int __init arch_timer_common_init(void)
>  {
> -	unsigned mask = ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
> -
> -	/* Wait until both nodes are probed if we have two timers */
> -	if ((arch_timers_present & mask) != mask) {
> -		if (arch_timer_needs_probing(ARCH_TIMER_TYPE_MEM,
> -					     arch_timer_mem_of_match))
> -			return 0;
> -		if (arch_timer_needs_probing(ARCH_TIMER_TYPE_CP15,
> -					     arch_timer_of_match))
> -			return 0;
> -	}
> +	if (acpi_disabled && arch_timer_needs_of_probing())
> +		return 0;
>  
>  	arch_timer_banner(arch_timers_present);
>  	arch_counter_register(arch_timers_present);
> -- 
> 2.9.3
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
