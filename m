From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: pass correct parameter to
 acpi_processor_ffh_cstate_probe_cpu()
Date: Sun, 15 Mar 2009 22:59:19 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903152257260.30317@localhost.localdomain>
References: <20090312074524.GA15992@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754800AbZCPC7v@vger.kernel.org>
In-reply-to: <20090312074524.GA15992@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>, Zhao Yakui <yakui.zhao@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, 12 Mar 2009, Wu Fengguang wrote:

> This fixes a NULL pointer dereference bug introduced by 6e911954cac.

What tree is this patch on top of?

thanks,
-Len Brown
Intel Open Source Technology Center

> Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> ---
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index 6626e8c..b866b87 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -137,7 +137,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
>  	/* Run acpi_processor_ffh_cstate_probe_cpu() on the target CPU */
>  
>  	retval = smp_call_function_single(cpu,
> -				acpi_processor_ffh_cstate_probe_cpu, cx, 1);
> +				acpi_processor_ffh_cstate_probe_cpu, &cxcc, 1);
>  	if (retval == 0) {
>  		retval = cxcc.retval;
>  		if (retval == 0) {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
