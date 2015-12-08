From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v4] acpi, apei, arm64: APEI initial support for aarch64.
Date: Tue, 08 Dec 2015 19:26:26 +0800
Message-ID: <5666BE62.7090409@linaro.org>
References: <1449558183-12259-1-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35688 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbbLHL0a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2015 06:26:30 -0500
Received: by wmuu63 with SMTP id u63so177081680wmu.0
        for <linux-acpi@vger.kernel.org>; Tue, 08 Dec 2015 03:26:28 -0800 (PST)
In-Reply-To: <1449558183-12259-1-git-send-email-fu.wei@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fu.wei@linaro.org, tomasz.nowicki@linaro.org, tn@semihalf.com, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, graeme.gregory@linaro.org, al.stone@linaro.org, mark.rutland@arm.com, Marc.Zyngier@arm.com, lorenzo.pieralisi@arm.com, rruigrok@codeaurora.org, harba@qti.qualcomm.com, jcm@redhat.com, msalter@redhat.com, grant.likely@linaro.org, rrichter@cavium.com, jarkko.nikula@linux.intel.com, jon.zhixiong.zhang@gmail.com

Hi Fu Wei,

On 12/08/2015 03:03 PM, fu.wei@linaro.org wrote:
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
>      Move arch_apei_flush_tlb_one into header file as a inline function
>      Add a new subfunction "hest_ia_init" for "acpi_disable_cmcff".
>
> v3: https://lkml.org/lkml/2015/12/3/521
>      Remove "acpi_disable_cmcff" from arm64 code,
>      and wrap it in hest.c by "#if defined(__i386__) || defined(__x86_64__)"
>
> v2: https://lkml.org/lkml/2015/12/2/432
>      Rebase to latest kernel version(4.4-rc3).
>      Move arch_apei_flush_tlb_one() to arch/arm64/kernel/acpi.c
>
> v1: https://lkml.org/lkml/2015/8/14/199
>      Move arch_apei_flush_tlb_one() to arch/arm64/include/asm/apci.h.
>      Delete arch/arm64/kernel/apei.c.
>      Add "#ifdef CONFIG_ACPI_APEI" for "acpi_disable_cmcff".
>
>   arch/arm64/Kconfig            |  1 +
>   arch/arm64/include/asm/acpi.h |  5 +++++
>   drivers/acpi/apei/hest.c      | 19 ++++++++++++++++---
>   3 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 871f217..58c8992 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -3,6 +3,7 @@ config ARM64
>   	select ACPI_CCA_REQUIRED if ACPI
>   	select ACPI_GENERIC_GSI if ACPI
>   	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> +	select HAVE_ACPI_APEI if ACPI
>   	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>   	select ARCH_HAS_ELF_RANDOMIZE
>   	select ARCH_HAS_GCOV_PROFILE_ALL
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index caafd63..31d3d9a 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -17,6 +17,7 @@
>
>   #include <asm/cputype.h>
>   #include <asm/smp_plat.h>
> +#include <asm/tlbflush.h>
>
>   /* Macros for consistency checks of the GICC subtable of MADT */
>   #define ACPI_MADT_GICC_LENGTH	\
> @@ -94,6 +95,10 @@ static inline const char *acpi_get_enable_method(int cpu)
>
>   #ifdef	CONFIG_ACPI_APEI
>   pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);

How bout adding a empty line here?

Except that,

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
