From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v5 2/6] clocksource/drivers/arm_arch_timer: Add a new enum
 for spi type
Date: Mon, 30 May 2016 17:07:16 +0200
Message-ID: <574C5724.30200@linaro.org>
References: <1464096633-9309-1-git-send-email-fu.wei@linaro.org>
 <1464096633-9309-3-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35752 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895AbcE3PHU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 May 2016 11:07:20 -0400
Received: by mail-wm0-f45.google.com with SMTP id a136so90970357wme.0
        for <linux-acpi@vger.kernel.org>; Mon, 30 May 2016 08:07:19 -0700 (PDT)
In-Reply-To: <1464096633-9309-3-git-send-email-fu.wei@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, marc.zyngier@arm.com, hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de, wim@iguana.be, catalin.marinas@arm.com, will.deacon@arm.com, Suravee.Suthikulpanit@amd.com, leo.duran@amd.com

On 05/24/2016 03:30 PM, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This patch add a new enum "spi_nr" and use it in the driver.
> Just for code's readability, no functional change.
>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>   drivers/clocksource/arm_arch_timer.c | 4 ++--
>   include/clocksource/arm_arch_timer.h | 6 ++++++
>   2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksour=
ce/arm_arch_timer.c
> index 5d7272e..966c574 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -826,9 +826,9 @@ static void __init arch_timer_mem_init(struct dev=
ice_node *np)
>   	}
>
>   	if (arch_timer_mem_use_virtual)
> -		irq =3D irq_of_parse_and_map(best_frame, 1);
> +		irq =3D irq_of_parse_and_map(best_frame, VIRT_SPI);
>   	else
> -		irq =3D irq_of_parse_and_map(best_frame, 0);
> +		irq =3D irq_of_parse_and_map(best_frame, PHYS_SPI);
>
>   	if (!irq) {
>   		pr_err("arch_timer: Frame missing %s irq",
> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksour=
ce/arm_arch_timer.h
> index 6f06481..16dcd10 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -45,6 +45,12 @@ enum ppi_nr {
>   	MAX_TIMER_PPI
>   };
>
> +enum spi_nr {
> +	PHYS_SPI,
> +	VIRT_SPI,
> +	MAX_TIMER_SPI
> +};

Wouldn't make sense to use the constant below instead of defining new o=
nes ?

>   #define ARCH_TIMER_PHYS_ACCESS		0
>   #define ARCH_TIMER_VIRT_ACCESS		1
>   #define ARCH_TIMER_MEM_PHYS_ACCESS	2
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
