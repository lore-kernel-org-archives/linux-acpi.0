From: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v20 16/17] clocksource/drivers/arm_arch_timer: Add GTDT
 support for memory-mapped timer
Date: Thu, 19 Jan 2017 17:16:33 +0800
Message-ID: <ed4efe25-1b40-66e2-ae3f-77a4e32715b6@linaro.org>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-17-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170118132541.8989-17-fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 2017/1/18 21:25, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> The patch add memory-mapped timer register support by using the
> information provided by the new GTDT driver of ACPI.
>
> Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 79dc004..7ca2da7 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -1077,10 +1077,36 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
>  		       arch_timer_mem_of_init);
>
>  #ifdef CONFIG_ACPI_GTDT
> -/* Initialize per-processor generic timer */
> +static int __init arch_timer_mem_acpi_init(int platform_timer_count)
> +{
> +	struct arch_timer_mem *timer_mem;
> +	int timer_count, i, ret;
> +

if (!platform_timer_count)
	return 0;

Did I miss something?

Thanks
Hanjun

> +	timer_mem = kcalloc(platform_timer_count, sizeof(*timer_mem),
> +			    GFP_KERNEL);
> +	if (!timer_mem)
> +		return -ENOMEM;
> +
> +	ret = acpi_arch_timer_mem_init(timer_mem, &timer_count);
> +	if (ret || !timer_count)
> +		goto error;
> +
> +	for (i = 0; i < timer_count; i++) {
> +		ret = arch_timer_mem_init(timer_mem);
> +		if (!ret)
> +			break;
> +		timer_mem++;
> +	}
> +
> +error:
> +	kfree(timer_mem);
> +	return ret;
> +}
> +
> +/* Initialize per-processor generic timer and memory-mapped timer(if present) */
>  static int __init arch_timer_acpi_init(struct acpi_table_header *table)
>  {
> -	int ret;
> +	int ret, platform_timer_count;
>
>  	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
>  		pr_warn("already initialized, skipping\n");
> @@ -1089,7 +1115,7 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
>
>  	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
>
> -	ret = acpi_gtdt_init(table, NULL);
> +	ret = acpi_gtdt_init(table, &platform_timer_count);
>  	if (ret) {
>  		pr_err("Failed to init GTDT table.\n");
>  		return ret;
> @@ -1122,6 +1148,9 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
>  	if (ret)
>  		return ret;
>
> +	if (arch_timer_mem_acpi_init(platform_timer_count))
> +		pr_err("Failed to initialize memory-mapped timer.\n");
> +
>  	return arch_timer_common_init();
>  }
>  CLOCKSOURCE_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
>
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
