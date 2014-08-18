From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 05/18] ARM64 / ACPI: Parse FADT table to get PSCI
 flags for PSCI init
Date: Mon, 18 Aug 2014 15:27:21 +0100
Message-ID: <20140818142721.GR20043@localhost>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-6-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1407166105-17675-6-git-send-email-hanjun.guo@linaro.org>
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Randy
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 04, 2014 at 04:28:12PM +0100, Hanjun Guo wrote:
> There are two flags: PSCI_COMPLIANT and PSCI_USE_HVC. When set,
> the former signals to the OS that the hardware is PSCI compliant.

Actually it signals that the firmware is PSCI compliant. The hardware
doesn't care much.

> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 6400312..6e04868 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -19,6 +19,18 @@ extern int acpi_disabled;
>  extern int acpi_noirq;
>  extern int acpi_pci_disabled;
>  
> +/* 1 to indicate PSCI 0.2+ is implemented */
> +static inline bool acpi_psci_present(void)
> +{
> +	return !!(acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_COMPLIANT);
> +}
> +
> +/* 1 to indicate HVC must be used instead of SMC as the PSCI conduit */
> +static inline bool acpi_psci_use_hvc(void)
> +{
> +	return !!(acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_USE_HVC);
> +}

Do we actually need !! here? Shouldn't the compiler figure out
conversion to bool automatically?

> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 9cf9127..69a315d 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -11,6 +11,8 @@
>   *  published by the Free Software Foundation.
>   */
>  
> +#define pr_fmt(fmt) "ACPI: " fmt
> +
>  #include <linux/init.h>
>  #include <linux/acpi.h>
>  #include <linux/cpumask.h>
> @@ -47,6 +49,26 @@ void __init __acpi_unmap_table(char *map, unsigned long size)
>  	early_memunmap(map, size);
>  }
>  
> +static int __init acpi_parse_fadt(struct acpi_table_header *table)
> +{
> +	struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
> +
> +	/*
> +	 * Revision in table header is the FADT Major version,
> +	 * and there is a minor version of FADT which was introduced
> +	 * by ACPI 5.1, we only deal with ACPI 5.1 or higher version
> +	 * to get arm boot flags, or we will disable ACPI.
> +	 */
> +	if (table->revision < 5 || fadt->minor_revision < 1) {

If we ever get revision 6.0, this would trigger.

> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 85c6326..dfc4e4f3 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -395,6 +395,8 @@ void __init setup_arch(char **cmdline_p)
>  	efi_idmap_init();
>  
>  	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
> +	acpi_boot_init();
> +
>  	unflatten_device_tree();

Unless that's changed in a subsequent patch, do we still need to call
unflatten_device_tree() if ACPI was successful?

>  	psci_init();

I would also rename this to something like psci_dt_init() and move the
acpi_disabled check here rather than in the callee.

-- 
Catalin
