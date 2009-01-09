From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] : ACPI : Add the MWAIT C-state mask to avoid overflow
Date: Fri, 09 Jan 2009 01:28:12 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901090128070.4091@localhost.localdomain>
References: <20081031184233.8588.42241.stgit@thinkpad>
 <1231041861.3967.3.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:33343 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749AbZAIG2P (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 01:28:15 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD600BXCXZ2OOO6@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 00:28:15 -0600 (CST)
In-reply-to: <1231041861.3967.3.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, venkatesh.pallipadi@intel.com

applied.


--
Len Brown, Intel Open Source Technology Center

On Sun, 4 Jan 2009, Zhao Yakui wrote:

> Subject: ACPI: Add the MWAIT C-state mask to avoid overflow
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> The Cx Register address obtained from the _CST object is used as the mait
> hints if the register type is FFixedHW. And it is used to check whether
> the Cx type is supported or not.
> 
> On some boxes the following Cx state package is obtained from _CST object:
>     >{
>                 ResourceTemplate ()
>                 {
>                     Register (FFixedHW,
>                         0x01,               // Bit Width
>                         0x02,               // Bit Offset
>                         0x0000000000889759, // Address
>                         0x03,               // Access Size
>                         )
>                 },
> 
>                 0x03,
>                 0xF5,
>                 0x015E }
>    In such case we should use the bit[7:4] of Cx address to check whether
> the Cx type is supported or not.
> 
> Add the MWAIT C-state mask to avoid overflow 
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Acked-by:Venki Pallipadi <venkatesh.pallipadi@intel.com>
> ---
>  arch/x86/kernel/acpi/cstate.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/arch/x86/kernel/acpi/cstate.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/kernel/acpi/cstate.c
> +++ linux-2.6/arch/x86/kernel/acpi/cstate.c
> @@ -56,6 +56,7 @@ static struct cstate_entry *cpu_cstate_e
>  static short mwait_supported[ACPI_PROCESSOR_MAX_POWER];
>  
>  #define MWAIT_SUBSTATE_MASK	(0xf)
> +#define MWAIT_CSTATE_MASK	(0xf)
>  #define MWAIT_SUBSTATE_SIZE	(4)
>  
>  #define CPUID_MWAIT_LEAF (5)
> @@ -98,7 +99,8 @@ int acpi_processor_ffh_cstate_probe(unsi
>  	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
>  
>  	/* Check whether this particular cx_type (in CST) is supported or not */
> -	cstate_type = (cx->address >> MWAIT_SUBSTATE_SIZE) + 1;
> +	cstate_type = ((cx->address >> MWAIT_SUBSTATE_SIZE) &
> +			MWAIT_CSTATE_MASK) + 1;
>  	edx_part = edx >> (cstate_type * MWAIT_SUBSTATE_SIZE);
>  	num_cstate_subtype = edx_part & MWAIT_SUBSTATE_MASK;
>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Subject: ACPI: Add the MWAIT C-state mask to avoid overflow
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> The Cx Register address obtained from the _CST object is used as the mait
> hints if the register type is FFixedHW. And it is used to check whether
> the Cx type is supported or not.
> 
> On some boxes the following Cx state package is obtained from _CST object:
>     >{
>                 ResourceTemplate ()
>                 {
>                     Register (FFixedHW,
>                         0x01,               // Bit Width
>                         0x02,               // Bit Offset
>                         0x0000000000889759, // Address
>                         0x03,               // Access Size
>                         )
>                 },
> 
>                 0x03,
>                 0xF5,
>                 0x015E }
>    In such case we should use the bit[7:4] of Cx address to check whether
> the Cx type is supported or not.
> 
> Add the MWAIT C-state mask to avoid overflow 
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Acked-by:Venki Pallipadi <venkatesh.pallipadi@intel.com>
> ---
>  arch/x86/kernel/acpi/cstate.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/arch/x86/kernel/acpi/cstate.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/kernel/acpi/cstate.c
> +++ linux-2.6/arch/x86/kernel/acpi/cstate.c
> @@ -56,6 +56,7 @@ static struct cstate_entry *cpu_cstate_e
>  static short mwait_supported[ACPI_PROCESSOR_MAX_POWER];
>  
>  #define MWAIT_SUBSTATE_MASK	(0xf)
> +#define MWAIT_CSTATE_MASK	(0xf)
>  #define MWAIT_SUBSTATE_SIZE	(4)
>  
>  #define CPUID_MWAIT_LEAF (5)
> @@ -98,7 +99,8 @@ int acpi_processor_ffh_cstate_probe(unsi
>  	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
>  
>  	/* Check whether this particular cx_type (in CST) is supported or not */
> -	cstate_type = (cx->address >> MWAIT_SUBSTATE_SIZE) + 1;
> +	cstate_type = ((cx->address >> MWAIT_SUBSTATE_SIZE) &
> +			MWAIT_CSTATE_MASK) + 1;
>  	edx_part = edx >> (cstate_type * MWAIT_SUBSTATE_SIZE);
>  	num_cstate_subtype = edx_part & MWAIT_SUBSTATE_MASK;
>  
> 
> 
