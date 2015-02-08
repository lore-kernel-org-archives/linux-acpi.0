From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: Remove unneeded nested #ifdef
Date: Mon, 09 Feb 2015 00:22:04 +0100
Message-ID: <2549038.i39BShhfcj@vostro.rjw.lan>
References: <1423401179-12545-1-git-send-email-rupran@einserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423401179-12545-1-git-send-email-rupran@einserver.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Ruprecht <rupran@einserver.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sunday, February 08, 2015 02:12:59 PM Andreas Ruprecht wrote:
> In commit 5de21bb998b8 ("ACPI / PM: Drop CONFIG_PM_RUNTIME from the
> ACPI core"), all occurrences of CONFIG_PM_RUNTIME were replaced with
> CONFIG_PM. This created the following structure of #ifdef blocks in
> the code:
> 
>  [...]
>  #ifdef CONFIG_PM
>  #ifdef CONFIG_PM
>  /* always on / undead */
>  #ifdef CONFIG_PM_SLEEP
>  [...]
>  #endif
>  #endif
>  [...]
>  #endif
> 
> This patch removes the inner "#ifdef CONFIG_PM" block as it will
> always be enabled when the outer block is enabled. This inconsistency
> was found using the undertaker-checkpatch tool.
> 
> Signed-off-by: Andreas Ruprecht <rupran@einserver.de>

Applied, thanks!

> ---
>  drivers/acpi/device_pm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index c0d44d3..735db11 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1027,7 +1027,6 @@ EXPORT_SYMBOL_GPL(acpi_subsys_freeze);
>  
>  static struct dev_pm_domain acpi_general_pm_domain = {
>  	.ops = {
> -#ifdef CONFIG_PM
>  		.runtime_suspend = acpi_subsys_runtime_suspend,
>  		.runtime_resume = acpi_subsys_runtime_resume,
>  #ifdef CONFIG_PM_SLEEP
> @@ -1041,7 +1040,6 @@ static struct dev_pm_domain acpi_general_pm_domain = {
>  		.poweroff_late = acpi_subsys_suspend_late,
>  		.restore_early = acpi_subsys_resume_early,
>  #endif
> -#endif
>  	},
>  };
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
