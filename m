From: Stefan Bader <stefan.bader@canonical.com>
Subject: Re: [PATCH] acpi: Use the ARB_DISABLE for the CPU which model id
 is less than 0x0f.
Date: Thu, 10 Dec 2009 14:41:54 +0100
Message-ID: <4B20FAA2.3040405@canonical.com>
References: <1260102002-18624-1-git-send-email-yakui.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:49632 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758789AbZLJNlz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2009 08:41:55 -0500
In-Reply-To: <1260102002-18624-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui.zhao@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>

I think, this should go to stable, too.

-Stefan

yakui.zhao@intel.com wrote:
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> ARB_DISABLE is a NOP on all of the recent Intel platforms. For such platforms,
> reduce contention on c3_lock by skipping the fake ARB_DISABLE.
> 
> The cpu model id on one laptop is 14. If we disable ARB_DISABLE on this box,
> the box can't be booted correctly. But if we still enable ARB_DISABLE on this
> box, the box can be booted correctly.
> 
> So we still use the ARB_DISABLE for the cpu which mode id is less than 0x0f.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=14700

CC: stable@kernel.org
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> cc: Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com>
> ---
>  arch/x86/kernel/acpi/cstate.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index 59cdfa4..2e837f5 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -48,7 +48,7 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
>  	 * P4, Core and beyond CPUs
>  	 */
>  	if (c->x86_vendor == X86_VENDOR_INTEL &&
> -	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 14)))
> +	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
>  			flags->bm_control = 0;
>  }
>  EXPORT_SYMBOL(acpi_processor_power_init_bm_check);

