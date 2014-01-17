From: Sudeep Holla <Sudeep.Holla@arm.com>
Subject: Re: [PATCH 04/20] ARM64 / ACPI: Introduce arm_core.c and its related
 head file
Date: Fri, 17 Jan 2014 16:56:49 +0000
Message-ID: <52D960D1.3090700@arm.com>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-5-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1389961514-13562-5-git-send-email-hanjun.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Rob Herring <robh@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Al Stone <al.stone@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Arnd Bergmann <arnd@arndb.de>, "patches@linaro.org" <patches@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "Rafael J. Wysocki" <rjw@rjw>
List-Id: linux-acpi@vger.kernel.org

On 17/01/14 12:24, Hanjun Guo wrote:
> Introduce arm_core.c and its related head file, after this patch,
> we can get ACPI tables from firmware on ARM64 now.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/include/asm/acpi.h |   57 +++++++++++
>  arch/arm64/kernel/setup.c     |    6 ++
>  drivers/acpi/Makefile         |    2 +
>  drivers/acpi/plat/Makefile    |    1 +
>  drivers/acpi/plat/arm-core.c  |  209 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 275 insertions(+)
>  create mode 100644 drivers/acpi/plat/Makefile
>  create mode 100644 drivers/acpi/plat/arm-core.c
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index cf19dc6..908d71b 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -19,6 +19,43 @@
>  #ifndef _ASM_ARM64_ACPI_H
>  #define _ASM_ARM64_ACPI_H
>  
> +#include <asm/cacheflush.h>
> +
> +#include <linux/init.h>
> +
> +#define COMPILER_DEPENDENT_INT64	s64
> +#define COMPILER_DEPENDENT_UINT64	u64
> +
> +/*
> + * Calling conventions:
> + *
> + * ACPI_SYSTEM_XFACE        - Interfaces to host OS (handlers, threads)
> + * ACPI_EXTERNAL_XFACE      - External ACPI interfaces
> + * ACPI_INTERNAL_XFACE      - Internal ACPI interfaces
> + * ACPI_INTERNAL_VAR_XFACE  - Internal variable-parameter list interfaces
> + */
> +#define ACPI_SYSTEM_XFACE
> +#define ACPI_EXTERNAL_XFACE
> +#define ACPI_INTERNAL_XFACE
> +#define ACPI_INTERNAL_VAR_XFACE
> +
> +/* Asm macros */
> +#define ACPI_FLUSH_CPU_CACHE() flush_cache_all()
> +
> +/* Basic configuration for ACPI */
> +#ifdef	CONFIG_ACPI
> +extern int acpi_disabled;
> +extern int acpi_noirq;
> +extern int acpi_pci_disabled;
> +extern int acpi_strict;
> +
> +static inline void disable_acpi(void)
> +{
> +	acpi_disabled = 1;
> +	acpi_pci_disabled = 1;
> +	acpi_noirq = 1;
> +}
> +
>  static inline bool arch_has_acpi_pdc(void)
>  {
>  	return false;	/* always false for now */
> @@ -29,4 +66,24 @@ static inline void arch_acpi_set_pdc_bits(u32 *buf)
>  	return;
>  }
>  
> +static inline void acpi_noirq_set(void) { acpi_noirq = 1; }
> +static inline void acpi_disable_pci(void)
> +{
> +	acpi_pci_disabled = 1;
> +	acpi_noirq_set();
> +}
> +
> +/* FIXME: this function should be moved to topology.h when it's ready */
> +void arch_fix_phys_package_id(int num, u32 slot);
> +
> +/* temperally define -1 to make acpi core compilerable */
> +#define cpu_physical_id(cpu) -1
> +

I assume `cpu` here is logical cpu id in which case you can define it to be same
as cpu_logical_map ?

Regards,
Sudeep
