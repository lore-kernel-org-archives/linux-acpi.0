From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 06/21] ACPI: fix acpi_os_ioremap for arm64
Date: Wed, 04 Mar 2015 23:36:11 +0100
Message-ID: <8319080.yo6LBolOJB@vostro.rjw.lan>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org> <1424853601-6675-7-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424853601-6675-7-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Mark Salter <msalter@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, February 25, 2015 04:39:46 PM Hanjun Guo wrote:
> From: Mark Salter <msalter@redhat.com>
> 
> The acpi_os_ioremap() function may be used to map normal RAM or IO
> regions. The current implementation simply uses ioremap_cache(). This
> will work for some architectures, but arm64 ioremap_cache() cannot be
> used to map IO regions which don't support caching. So for arm64, use
> ioremap() for non-RAM regions.
> 
> CC: Rafael J Wysocki <rjw@rjwysocki.net>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/arm64/include/asm/acpi.h | 13 +++++++++++++
>  include/acpi/acpi_io.h        |  4 ++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 8b837ab..40e0924 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -12,8 +12,21 @@
>  #ifndef _ASM_ACPI_H
>  #define _ASM_ACPI_H
>  
> +#include <linux/mm.h>
> +
>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
> +/* ACPI table mapping after acpi_gbl_permanent_mmap is set */
> +static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> +					    acpi_size size)
> +{
> +	if (!page_is_ram(phys >> PAGE_SHIFT))
> +		return ioremap(phys, size);
> +
> +	return ioremap_cache(phys, size);
> +}
> +#define acpi_os_ioremap acpi_os_ioremap
> +
>  #define acpi_strict 1	/* No out-of-spec workarounds on ARM64 */
>  extern int acpi_disabled;
>  extern int acpi_noirq;
> diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
> index 444671e..dd86c5f 100644
> --- a/include/acpi/acpi_io.h
> +++ b/include/acpi/acpi_io.h
> @@ -3,11 +3,15 @@
>  
>  #include <linux/io.h>
>  
> +#include <asm/acpi.h>
> +
> +#ifndef acpi_os_ioremap
>  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>  					    acpi_size size)
>  {
>         return ioremap_cache(phys, size);
>  }
> +#endif
>  
>  void __iomem *__init_refok
>  acpi_os_map_iomem(acpi_physical_address phys, acpi_size size);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
