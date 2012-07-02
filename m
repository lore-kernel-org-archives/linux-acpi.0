From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Fix not loading acpi-cpufreq driver regression - V2
Date: Mon, 2 Jul 2012 11:46:00 +0200
Message-ID: <201207021146.01179.trenn@suse.de>
References: <201206251300.10957.trenn@suse.de> <201206251739.58356.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53983 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932717Ab2GBJqG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Jul 2012 05:46:06 -0400
In-Reply-To: <201206251739.58356.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, len.brown@intel.com
Cc: Lin Ming <ming.m.lin@intel.com>, stable@vger.kernel.org, wallak@free.fr, Jiri Slaby <jslaby@suse.cz>, ben@decadent.org.uk

Hi,

On Monday, June 25, 2012 05:39:58 PM Thomas Renninger wrote:
> ACPI processor: Only blindly return apic id 0 for real UP systems

what is the state here?
I expect it needs to go mainline (3.5-rc6?) via Len first before
showing up in stable?
Len: Can you push this one please, it fixes a regression which got
spread through stable kernels.

Thanks,

   Thomas
> 
> Commit d640113fe80e45ebd4a5b420b introduced a regression on SMP
> systems where the processor core with ACPI id zero is disabled
> (typically should be the case because of hyperthreading).
> The regression got spread through stable kernels.
> On 3.0.X it got introduced via 3.0.18.
> 
> Such platforms may be rare, but do exist.
> Look out for a disabled processor with acpi_id 0 in dmesg:
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x10] disabled)
> 
> This problem has been observed on a:
> HP Proliant BL280c G6 blade
> 
> This patch restricts the introduced workaround to platforms
> with nr_cpu_ids <= 1.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: stable@vger.kernel.org
> 
> ---
>  drivers/acpi/processor_core.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/processor_core.c 
b/drivers/acpi/processor_core.c
> index c850de4..eff7222 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -189,10 +189,12 @@ int acpi_get_cpuid(acpi_handle handle, int type, 
u32 acpi_id)
>  		 *     Processor (CPU3, 0x03, 0x00000410, 0x06) {}
>  		 * }
>  		 *
> -		 * Ignores apic_id and always return 0 for CPU0's handle.
> +		 * Ignores apic_id and always returns 0 for the processor
> +		 * handle with acpi id 0 if nr_cpu_ids is 1.
> +		 * This should be the case if SMP tables are not found.
>  		 * Return -1 for other CPU's handle.
>  		 */
> -		if (acpi_id == 0)
> +		if (nr_cpu_ids <= 1 && acpi_id == 0)
>  			return acpi_id;
>  		else
>  			return apic_id;
> 

