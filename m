From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v6 03/10] clocksource/drivers/arm_arch_timer: Improve
 printk relevant code
Date: Thu, 30 Jun 2016 10:54:32 +0800
Message-ID: <c347a9d9-82b4-b469-4e64-6446e6282a19@linaro.org>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <1467224153-22873-4-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35590 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbcF3Cyn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jun 2016 22:54:43 -0400
Received: by mail-pf0-f171.google.com with SMTP id c2so24339736pfa.2
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jun 2016 19:54:43 -0700 (PDT)
In-Reply-To: <1467224153-22873-4-git-send-email-fu.wei@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, marc.zyngier@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de, wim@iguana.be, catalin.marinas@arm.com, will.deacon@arm.com, Suravee.Suthikulpanit@amd.com, leo.duran@amd.com

On 2016/6/30 2:15, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This patch defines pr_fmt(fmt) for all pr_* functions,
> then the pr_* don't need to add "arch_timer:" everytime.
>
> Also delete some Blank Spaces in arch_timer_banner,
> according to the suggestion from checkpatch.pl.
>
> No functional change.
>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 52 +++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 966c574..9540e9d 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -29,6 +29,9 @@
>
>  #include <clocksource/arm_arch_timer.h>
>
> +#undef pr_fmt
> +#define pr_fmt(fmt) "arch_timer: " fmt
> +
>  #define CNTTIDR		0x08
>  #define CNTTIDR_VIRT(n)	(BIT(1) << ((n) * 4))
>
> @@ -388,24 +391,24 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
>
>  	/* Check the timer frequency. */
>  	if (arch_timer_rate == 0)
> -		pr_warn("Architected timer frequency not available\n");
> +		pr_warn("frequency not available\n");
>  }
>
>  static void arch_timer_banner(unsigned type)
>  {
> -	pr_info("Architected %s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
> -		     type & ARCH_CP15_TIMER ? "cp15" : "",
> -		     type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " : "",
> -		     type & ARCH_MEM_TIMER ? "mmio" : "",
> -		     (unsigned long)arch_timer_rate / 1000000,
> -		     (unsigned long)(arch_timer_rate / 10000) % 100,
> -		     type & ARCH_CP15_TIMER ?
> -		     (arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
> -			"",
> -		     type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  "/" : "",
> -		     type & ARCH_MEM_TIMER ?
> -			arch_timer_mem_use_virtual ? "virt" : "phys" :
> -			"");
> +	pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
> +		type & ARCH_CP15_TIMER ? "cp15" : "",
> +		type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " : "",
> +		type & ARCH_MEM_TIMER ? "mmio" : "",
> +		(unsigned long)arch_timer_rate / 1000000,
> +		(unsigned long)(arch_timer_rate / 10000) % 100,
> +		type & ARCH_CP15_TIMER ?
> +		(arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
> +		"",
> +		type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  "/" : "",
> +		type & ARCH_MEM_TIMER ?
> +		arch_timer_mem_use_virtual ? "virt" : "phys" :
> +		"");
>  }
>
>  u32 arch_timer_get_rate(void)
> @@ -498,7 +501,7 @@ static void __init arch_counter_register(unsigned type)
>
>  static void arch_timer_stop(struct clock_event_device *clk)
>  {
> -	pr_debug("arch_timer_teardown disable IRQ%d cpu #%d\n",
> +	pr_debug("teardown, disable IRQ%d cpu #%d\n",

Not a problem of this patch, but arch_timer_teardown is a function
name? I can't find where it's defined...

I think we can leave arch_timer as it but update it to:

pr_debug("arch_timer_stop disable IRQ%d cpu #%d\n",

Others are look good to me.

Thanks
Hanjun
