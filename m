From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v9 04/21] ARM64: allow late use of early_ioremap
Date: Fri, 06 Mar 2015 20:24:00 +0000
Message-ID: <20150306202400.7EF9BC40AA9@trevor.secretlab.ca>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
	<1424853601-6675-5-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424853601-6675-5-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Mark Salter <msalter@redhat.com>, Leif Lindholm <leif.lindholm@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 25 Feb 2015 16:39:44 +0800
, Hanjun Guo <hanjun.guo@linaro.org>
 wrote:
> From: Mark Salter <msalter@redhat.com>
> 
> Commit 0e63ea48b4d8 (arm64/efi: add missing call to early_ioremap_reset())
> added a missing call to early_ioremap_reset(). This triggers a BUG if code
> tries using early_ioremap() after the early_ioremap_reset(). This is a
> problem for some ACPI code which needs short-lived temporary mappings
> after paging_init() but before acpi_early_init() in start_kernel(). This
> patch adds definitions for the __late_set_fixmap() and __late_clear_fixmap()
> which avoids the BUG by allowing later use of early_ioremap().
> 
> CC: Leif Lindholm <leif.lindholm@linaro.org>
> CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Reviewed-by: Grant Likely <grant.likely@linaro.org>

> ---
>  arch/arm64/include/asm/fixmap.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index defa0ff9..f196e40 100644
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -62,6 +62,9 @@ void __init early_fixmap_init(void);
>  
>  #define __early_set_fixmap __set_fixmap
>  
> +#define __late_set_fixmap __set_fixmap
> +#define __late_clear_fixmap(idx) __set_fixmap((idx), 0, FIXMAP_PAGE_CLEAR)
> +
>  extern void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
>  
>  #include <asm-generic/fixmap.h>
> -- 
> 1.9.1
> 
