From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V10 2/6] arm: arm64: Add routine to determine cpuid of
 other cpus
Date: Tue, 29 Nov 2016 10:31:12 +0000
Message-ID: <20161129103112.GC30283@arm.com>
References: <1478734793-6341-1-git-send-email-jeremy.linton@arm.com>
 <1478734793-6341-3-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754000AbcK2KbN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Nov 2016 05:31:13 -0500
Content-Disposition: inline
In-Reply-To: <1478734793-6341-3-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, steve.capper@arm.com, mlangsdorf@redhat.com, punit.agrawal@arm.com, linux-acpi@vger.kernel.org, msalter@redhat.com

[adding Russell]

On Wed, Nov 09, 2016 at 05:39:49PM -0600, Jeremy Linton wrote:
> It is helpful if we can read the cpuid/midr of other CPUs
> in the system independent of arm/arm64.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm/include/asm/cputype.h   | 2 ++
>  arch/arm64/include/asm/cputype.h | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index 522b5fe..31fb273 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -235,6 +235,8 @@ static inline unsigned int __attribute_const__ read_cpuid_mpidr(void)
>  #define cpu_is_sa1100() (read_cpuid_part() == ARM_CPU_PART_SA1100)
>  #define cpu_is_sa1110() (read_cpuid_part() == ARM_CPU_PART_SA1110)
>  
> +#define read_specific_cpuid(cpu_num) per_cpu_ptr(&cpu_data, cpu_num)->cpuid
> +
>  /*
>   * Intel's XScale3 core supports some v6 features (supersections, L2)
>   * but advertises itself as v5 as it does not support the v6 ISA.  For

Russell -- are you ok with adding this macro to arch/arm/? It will get used
by the CPU PMU driver, which needs a portable (i.e. between arm and arm64)
way to convert a logical CPU ID into the MIDR register for that CPU.

Thanks,

Will
