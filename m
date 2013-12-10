From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [Linaro-acpi] [PATCH v3 2/5] ACPI: bus master reload not supported in reduced HW mode
Date: Tue, 10 Dec 2013 12:38:31 +0000
Message-ID: <20131210123831.AEFACC40A27@trevor.secretlab.ca>
References: <1386192127-28564-1-git-send-email-al.stone@linaro.org> < 1386192127-28564-3-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:36244 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112Ab3LJMih (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Dec 2013 07:38:37 -0500
Received: by mail-we0-f182.google.com with SMTP id q59so4834284wes.41
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2013 04:38:35 -0800 (PST)
In-Reply-To: <1386192127-28564-3-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org

On Wed,  4 Dec 2013 14:22:04 -0700, al.stone@linaro.org wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> Remove the saving and restoring of bus master reload registers in
> suspend/resume when in reduced HW mode; according to the spec, no
> such registers should exist
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/processor_idle.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 597cdab..8b48c08 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -202,7 +202,7 @@ static void lapic_timer_state_broadcast(struct acpi_processor *pr,
>  
>  #endif
>  
> -#ifdef CONFIG_PM_SLEEP
> +#if (IS_ENABLED(CONFIG_PM_SLEEP) && !IS_ENABLED(CONFIG_ACPI_REDUCED_HARDWARE))
>  static u32 saved_bm_rld;
>  
>  static int acpi_processor_suspend(void)
> @@ -236,7 +236,10 @@ void acpi_processor_syscore_exit(void)
>  {
>  	unregister_syscore_ops(&acpi_processor_syscore_ops);
>  }
> -#endif /* CONFIG_PM_SLEEP */
> +#else
> +void acpi_processor_syscore_init(void) { return; }
> +void acpi_processor_syscore_exit(void) { return; }
> +#endif

Ditto comment on this patch. This breaks normal ACPI on x86 if hardware
reduced is enabled. That is bad form. It is fine to compile it out if
normal ACPI is explicitly /disabled/, but it must be possible for normal
and hardware reduced to co-exist.

g.

