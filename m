From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] x86: Enable monitor/mwait on Intel if BIOS hasn't
 already
Date: Wed, 03 Aug 2011 12:15:40 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1108031214470.22067@x980>
References: <cover.1312386029.git.luto@mit.edu>
 <5bec80947da3fb72f2f18fbe6d924a69f83fbed9.1312386029.git.luto@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:58483 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709Ab1HCQPv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Aug 2011 12:15:51 -0400
In-reply-to: <5bec80947da3fb72f2f18fbe6d924a69f83fbed9.1312386029.git.luto@mit.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@MIT.EDU>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, linux-acpi@vger.kernel.org

On Wed, 3 Aug 2011, Andy Lutomirski wrote:

> I have a Sandy Bridge machine with an Intel BIOS that enables
> monitor/mwait on all but the boot CPU.  With this patch, intel_idle
> works.

What machine has this BIOS bug, and are you running
the latest version of the BIOS?

thanks,
Len Brown, Intel Open Source Technolgy Center

> Signed-off-by: Andy Lutomirski <luto@mit.edu>
> ---
>  arch/x86/kernel/cpu/intel.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 6b20fef..a3339a1 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -487,6 +487,26 @@ static void __cpuinit init_intel(struct cpuinfo_x86 *c)
>  			wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
>  		}
>  	}
> +
> +	/* Enable monitor/mwait if BIOS didn't do it for us. */
> +	if (!cpu_has(c, X86_FEATURE_MWAIT) && cpu_has(c, X86_FEATURE_XMM3)
> +	    && c->x86 >= 6 && !(c->x86 == 6 && c->x86_model < 0x1c)
> +	    && !(c->x86 == 0xf && c->x86_model < 3)) {
> +		u64 misc_enable;
> +		rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
> +		misc_enable |= MSR_IA32_MISC_ENABLE_MWAIT;
> +
> +		/*
> +		 * Some non-SSE3 cpus will #GP.  We check for that,
> +		 * but it can't hurt to be safe.
> +		 */
> +		wrmsr_safe(MSR_IA32_MISC_ENABLE, (u32)misc_enable,
> +			   (u32)(misc_enable >> 32));
> +
> +		/* Re-read monitor capability. */
> +		if (cpuid_ecx(1) & 0x8)
> +			set_cpu_cap(c, X86_FEATURE_MWAIT);
> +	}
>  }
>  
>  #ifdef CONFIG_X86_32
> -- 
> 1.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
