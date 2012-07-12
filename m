From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Fix not loading acpi-cpufreq driver regression
Date: Thu, 12 Jul 2012 22:55:56 +0200
Message-ID: <201207122255.56952.rjw@sisk.pl>
References: <201207111943.19405.rjw@sisk.pl> <201207121057.31791.trenn@suse.de> <201207121103.07832.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:38221 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932094Ab2GLUuY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jul 2012 16:50:24 -0400
In-Reply-To: <201207121103.07832.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Thursday, July 12, 2012, Thomas Renninger wrote:
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

Applied to the pm-cpufreq branch of the linux-pm.git tree.

Thanks,
Rafael


> ---
>  drivers/acpi/processor_core.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index c850de4..eff7222 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -189,10 +189,12 @@ int acpi_get_cpuid(acpi_handle handle, int type, u32 acpi_id)
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
> 

