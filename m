From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4] acpi, apei, arm64: APEI initial support for aarch64.
Date: Mon, 14 Dec 2015 11:46:26 +0100
Message-ID: <20151214104626.GB11638@pd.tnic>
References: <1449558183-12259-1-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:33923 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932200AbbLNKqc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Dec 2015 05:46:32 -0500
Content-Disposition: inline
In-Reply-To: <1449558183-12259-1-git-send-email-fu.wei@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fu.wei@linaro.org
Cc: tomasz.nowicki@linaro.org, tn@semihalf.com, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, graeme.gregory@linaro.org, al.stone@linaro.org, hanjun.guo@linaro.org, mark.rutland@arm.com, Marc.Zyngier@arm.com, lorenzo.pieralisi@arm.com, rruigrok@codeaurora.org, harba@qti.qualcomm.com, jcm@redhat.com, msalter@redhat.com, grant.likely@linaro.org, rrichter@cavium.com, jarkko.nikula@linux.intel.com, jon.zhixiong.zhang@gmail.com

On Tue, Dec 08, 2015 at 03:03:03PM +0800, fu.wei@linaro.org wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> 
> This commit provides APEI arch-specific bits for aarch64
> 
> Meanwhile, add a new subfunction "hest_ia_init" for
> "acpi_disable_cmcff" which is used by IA-32 Architecture
> Corrected Machine Check (CMC).
> 
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
> Changelog:
> v4: Rebase to latest kernel version(4.4-rc4).
>     Move arch_apei_flush_tlb_one into header file as a inline function
>     Add a new subfunction "hest_ia_init" for "acpi_disable_cmcff".
> 
> v3: https://lkml.org/lkml/2015/12/3/521
>     Remove "acpi_disable_cmcff" from arm64 code,
>     and wrap it in hest.c by "#if defined(__i386__) || defined(__x86_64__)"
> 
> v2: https://lkml.org/lkml/2015/12/2/432
>     Rebase to latest kernel version(4.4-rc3).
>     Move arch_apei_flush_tlb_one() to arch/arm64/kernel/acpi.c
> 
> v1: https://lkml.org/lkml/2015/8/14/199
>     Move arch_apei_flush_tlb_one() to arch/arm64/include/asm/apci.h.
>     Delete arch/arm64/kernel/apei.c.
>     Add "#ifdef CONFIG_ACPI_APEI" for "acpi_disable_cmcff".
> 
>  arch/arm64/Kconfig            |  1 +
>  arch/arm64/include/asm/acpi.h |  5 +++++
>  drivers/acpi/apei/hest.c      | 19 ++++++++++++++++---
>  3 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 871f217..58c8992 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -3,6 +3,7 @@ config ARM64
>  	select ACPI_CCA_REQUIRED if ACPI
>  	select ACPI_GENERIC_GSI if ACPI
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> +	select HAVE_ACPI_APEI if ACPI
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index caafd63..31d3d9a 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -17,6 +17,7 @@
>  
>  #include <asm/cputype.h>
>  #include <asm/smp_plat.h>
> +#include <asm/tlbflush.h>
>  
>  /* Macros for consistency checks of the GICC subtable of MADT */
>  #define ACPI_MADT_GICC_LENGTH	\
> @@ -94,6 +95,10 @@ static inline const char *acpi_get_enable_method(int cpu)
>  
>  #ifdef	CONFIG_ACPI_APEI
>  pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
> +static inline void arch_apei_flush_tlb_one(unsigned long addr)
> +{
> +	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +}
>  #endif
>  
>  #endif /*_ASM_ACPI_H*/
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 20b3fcf..715c58b 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -117,15 +117,27 @@ int apei_hest_parse(apei_hest_func_t func, void *data)
>  }
>  EXPORT_SYMBOL_GPL(apei_hest_parse);
>  
> +#if defined(__i386__) || defined(__x86_64__)
>  /*
>   * Check if firmware advertises firmware first mode. We need FF bit to be set
>   * along with a set of MC banks which work in FF mode.
>   */
>  static int __init hest_parse_cmc(struct acpi_hest_header *hest_hdr, void *data)
>  {
> -	return arch_apei_enable_cmcff(hest_hdr, data);
> +	if (!acpi_disable_cmcff)
> +		return !arch_apei_enable_cmcff(hest_hdr, data);
> +
> +	return 0;

So the proper way to do this is to leave the code still do this check
(in arch/x86/kernel/acpi/apei.c:arch_apei_enable_cmcff()):

	if (hest_hdr->type != ACPI_HEST_TYPE_IA32_CORRECTED_CHECK)
		return 0;

which should JustWork(tm) on ARM too because if ARM doesn't support IA32
CMCI, then that header type should be different and the function will
return 0.

For that to work, though, the check should be moved to a generic place,
like drivers/acpi/apei/hest.c:hest_parse_cmc() for example.

No crazy ifdeffery and no redundant Kconfig symbols please.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
