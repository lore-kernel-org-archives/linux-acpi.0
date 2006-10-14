From: Len Brown <len.brown@intel.com>
Subject: Re: [patch 01/12] acpi: fix section for CPU init functions
Date: Sat, 14 Oct 2006 04:07:28 -0400
Message-ID: <200610140407.28793.len.brown@intel.com>
References: <200610102120.k9ALKVwM024266@shell0.pdx.osdl.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59079 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1161002AbWJNIFR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:05:17 -0400
In-Reply-To: <200610102120.k9ALKVwM024266@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, drzeus@drzeus.cx

Applied.

thanks,
-Len

On Tuesday 10 October 2006 17:20, akpm@osdl.org wrote:
> From: Pierre Ossman <drzeus@drzeus.cx>
> 
> The ACPI processor init functions should be marked as __cpuinit as they use
> structures marked with __cpuinitdata.
> 
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/processor_core.c |    2 +-
>  drivers/acpi/processor_idle.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/acpi/processor_core.c~acpi-fix-section-for-cpu-init-functions drivers/acpi/processor_core.c
> --- a/drivers/acpi/processor_core.c~acpi-fix-section-for-cpu-init-functions
> +++ a/drivers/acpi/processor_core.c
> @@ -519,7 +519,7 @@ static int acpi_processor_get_info(struc
>  
>  static void *processor_device_array[NR_CPUS];
>  
> -static int acpi_processor_start(struct acpi_device *device)
> +static int __cpuinit acpi_processor_start(struct acpi_device *device)
>  {
>  	int result = 0;
>  	acpi_status status = AE_OK;
> diff -puN drivers/acpi/processor_idle.c~acpi-fix-section-for-cpu-init-functions drivers/acpi/processor_idle.c
> --- a/drivers/acpi/processor_idle.c~acpi-fix-section-for-cpu-init-functions
> +++ a/drivers/acpi/processor_idle.c
> @@ -1130,7 +1130,7 @@ static struct notifier_block acpi_proces
>  	.notifier_call = acpi_processor_latency_notify,
>  };
>  
> -int acpi_processor_power_init(struct acpi_processor *pr,
> +int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
>  			      struct acpi_device *device)
>  {
>  	acpi_status status = 0;
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
