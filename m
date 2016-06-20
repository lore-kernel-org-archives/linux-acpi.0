From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 4/8] arm: arm64: Add routine to determine cpuid of other cpus
Date: Mon, 20 Jun 2016 17:49:41 +0100
Message-ID: <87d1nb6c0q.fsf@e105922-lin.cambridge.arm.com>
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
	<1465511013-10742-5-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:53572 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932148AbcFTQuh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Jun 2016 12:50:37 -0400
In-Reply-To: <1465511013-10742-5-git-send-email-jeremy.linton@arm.com> (Jeremy
	Linton's message of "Thu, 9 Jun 2016 17:23:29 -0500")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, mlangsdorf@redhat.com, peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, acme@kernel.org, linux-acpi@vger.kernel.org, alexander.shishkin@linux.intel.com, mingo@redhat.com

Jeremy Linton <jeremy.linton@arm.com> writes:

> It is helpful if we can read the cpuid/midr of other CPUs
> in the system independent of arm/arm64.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm/include/asm/cputype.h   | 6 +++++-
>  arch/arm64/include/asm/cputype.h | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index 1ee94c7..e391b67 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -81,6 +81,8 @@
>  #define ARM_CPU_XSCALE_ARCH_V2		0x4000
>  #define ARM_CPU_XSCALE_ARCH_V3		0x6000
>  
> +#define ARM_PARTNUM(cpuid_id) (cpuid_id & ARM_CPU_PART_MASK)
> +
>  extern unsigned int processor_id;
>  
>  #ifdef CONFIG_CPU_CP15
> @@ -180,7 +182,7 @@ static inline unsigned int __attribute_const__ read_cpuid_implementor(void)
>   */
>  static inline unsigned int __attribute_const__ read_cpuid_part(void)
>  {
> -	return read_cpuid_id() & ARM_CPU_PART_MASK;
> +	return ARM_PARTNUM(read_cpuid_id());
>  }
>  
>  static inline unsigned int __attribute_const__ __deprecated read_cpuid_part_number(void)
> @@ -208,6 +210,8 @@ static inline unsigned int __attribute_const__ read_cpuid_mpidr(void)
>  	return read_cpuid(CPUID_MPIDR);
>  }
>  
> +#define read_specific_cpuid(cpu_num) per_cpu_ptr(&cpu_data, cpu_num)->cpuid

IMO, something like read_cpuid_of might be better name.

> +
>  /*
>   * Intel's XScale3 core supports some v6 features (supersections, L2)
>   * but advertises itself as v5 as it does not support the v6 ISA.  For
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 87e1985..56fd8c1 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -38,6 +38,7 @@
>  #define MIDR_PARTNUM_MASK	(0xfff << MIDR_PARTNUM_SHIFT)
>  #define MIDR_PARTNUM(midr)	\
>  	(((midr) & MIDR_PARTNUM_MASK) >> MIDR_PARTNUM_SHIFT)
> +#define ARM_PARTNUM MIDR_PARTNUM
>  #define MIDR_ARCHITECTURE_SHIFT	16
>  #define MIDR_ARCHITECTURE_MASK	(0xf << MIDR_ARCHITECTURE_SHIFT)
>  #define MIDR_ARCHITECTURE(midr)	\
> @@ -126,6 +127,9 @@ static inline u32 __attribute_const__ read_cpuid_cachetype(void)
>  {
>  	return read_cpuid(CTR_EL0);
>  }
> +
> +#define read_specific_cpuid(cpu_num) per_cpu_ptr(&cpu_data, cpu_num)->reg_midr
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif
