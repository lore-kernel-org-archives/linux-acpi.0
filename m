From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 06/18] ARM64 / ACPI: Parse MADT to map logical cpu to
 MPIDR and get cpu_possible/present_map
Date: Mon, 18 Aug 2014 15:27:28 +0100
Message-ID: <20140818142728.GS20043@localhost>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-7-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1407166105-17675-7-git-send-email-hanjun.guo@linaro.org>
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, graeme.gregory@linaro.
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 04, 2014 at 04:28:13PM +0100, Hanjun Guo wrote:
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 6e04868..e877967 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -64,6 +64,8 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>  extern int (*acpi_suspend_lowlevel)(void);
>  #define acpi_wakeup_address 0
>  
> +#define MAX_GIC_CPU_INTERFACE 65535

Does this need to be more than NR_CPUS?

> +/**
> + * acpi_register_gic_cpu_interface - register a gic cpu interface and
> + * generates a logical cpu number
> + * @mpidr: CPU's hardware id to register, MPIDR represented in MADT
> + * @enabled: this cpu is enabled or not
> + *
> + * Returns the logical cpu number which maps to the gic cpu interface
> + */
> +static int acpi_register_gic_cpu_interface(u64 mpidr, u8 enabled)
> +{
> +	int cpu;
> +
> +	if (mpidr == INVALID_HWID) {
> +		pr_info("Skip invalid cpu hardware ID\n");
> +		return -EINVAL;
> +	}
> +
> +	total_cpus++;
> +	if (!enabled)
> +		return -EINVAL;
> +
> +	if (enabled_cpus >=  NR_CPUS) {
> +		pr_warn("NR_CPUS limit of %d reached, Processor %d/0x%llx ignored.\n",
> +			NR_CPUS, total_cpus, mpidr);
> +		return -EINVAL;
> +	}
> +
> +	/* If it is the first CPU, no need to check duplicate MPIDRs */
> +	if (!enabled_cpus)
> +		goto skip_mpidr_check;
> +
> +	/*
> +	 * Duplicate MPIDRs are a recipe for disaster. Scan
> +	 * all initialized entries and check for
> +	 * duplicates. If any is found just ignore the CPU.
> +	 */
> +	for_each_present_cpu(cpu) {
> +		if (cpu_logical_map(cpu) == mpidr) {
> +			pr_err("Firmware bug, duplicate CPU MPIDR: 0x%llx in MADT\n",
> +			       mpidr);
> +			return -EINVAL;
> +		}
> +	}
> +
> +skip_mpidr_check:
> +	enabled_cpus++;
> +
> +	/* allocate a logical cpu id for the new comer */
> +	if (cpu_logical_map(0) == mpidr) {
> +		/*
> +		 * boot_cpu_init() already hold bit 0 in cpu_present_mask
> +		 * for BSP, no need to allocate again.
> +		 */
> +		cpu = 0;
> +	} else {
> +		cpu = cpumask_next_zero(-1, cpu_present_mask);
> +	}
> +
> +	/* map the logical cpu id to cpu MPIDR */
> +	cpu_logical_map(cpu) = mpidr;
> +
> +	set_cpu_possible(cpu, true);
> +	set_cpu_present(cpu, true);
> +
> +	return cpu;
> +}

Why not only set the cpu possible here (with the additional mpidr
validity checks changed to for_each_possible_cpu)...

> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 40f38f4..8f1d37c 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -36,6 +36,7 @@
>  #include <linux/completion.h>
>  #include <linux/of.h>
>  #include <linux/irq_work.h>
> +#include <linux/acpi.h>
>  
>  #include <asm/atomic.h>
>  #include <asm/cacheflush.h>
> @@ -458,7 +459,14 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  		if (err)
>  			continue;
>  
> -		set_cpu_present(cpu, true);
> +		/*
> +		 * In ACPI mode, cpu_present_map was initialised when
> +		 * MADT table was parsed which before this function
> +		 * is called.
> +		 */
> +		if (acpi_disabled)
> +			set_cpu_present(cpu, true);
> +
>  		max_cpus--;

... and don't touch this at all.

-- 
Catalin
