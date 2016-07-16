From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 3/3] ACPI / PM: Fix EC polling issue by implementing prepare_late/finish_early suspend_ops callbacks
Date: Sat, 16 Jul 2016 02:51:34 +0200
Message-ID: <1607219.k0v9zRxBvM@vostro.rjw.lan>
References: <cover.1467100803.git.lv.zheng@intel.com> <48245fbc4b0510a7af281986ccc1a2a583766f73.1467100803.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <48245fbc4b0510a7af281986ccc1a2a583766f73.1467100803.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, June 28, 2016 04:04:46 PM Lv Zheng wrote:
> _PTS/_WAK may contain EC transactions, it is better to have them handled
> with IRQ enabled. This patch moves the 2 suspend PM ops from noirq stage
> to late/early stage.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

There are systems that won't work with this patch applied, so I don't
see a point in applying the other two.

> ---
>  drivers/acpi/sleep.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index d30fce7f..c5c374c9 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -595,9 +595,10 @@ static int acpi_suspend_state_valid(suspend_state_t pm_state)
>  static const struct platform_suspend_ops acpi_suspend_ops = {
>  	.valid = acpi_suspend_state_valid,
>  	.begin = acpi_suspend_begin,
> -	.prepare_noirq = acpi_pm_prepare,
> +	.prepare_late = __acpi_pm_prepare,
> +	.prepare_noirq = acpi_pm_pre_suspend,
>  	.enter = acpi_suspend_enter,
> -	.finish_noirq = acpi_pm_finish,
> +	.finish_early = acpi_pm_finish,
>  	.end = acpi_pm_end,
>  };
>  
> 

Thanks,
Rafael
