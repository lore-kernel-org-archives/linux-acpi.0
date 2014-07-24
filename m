From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 09/19] ARM64 / ACPI: Move the initialization of
 cpu_logical_map(0) before acpi_boot_init()
Date: Thu, 24 Jul 2014 16:21:04 +0100
Message-ID: <20140724152103.GB26190@leverpostej>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-10-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1406206825-15590-10-git-send-email-hanjun.guo@linaro.org>
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
Cc: Mark Brown <broonie@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, "linaro-acpi-private@linaro.org" <linaro-acpi-private@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradea>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 24, 2014 at 02:00:15PM +0100, Hanjun Guo wrote:
> Move the initialization of cpu_logical_map(0) before acpi_boot_init()
> to remove the duplicated initialization of cpu_logical_map(0).

It always make sense to initialise CPU0's logical map entry from the
hardware values, so you could do this earlier in the series, before you
introduce any ACPI code. Then you don't have the churn in acpi.c

> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/kernel/acpi.c  |    3 ---
>  arch/arm64/kernel/setup.c |    3 ++-
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 801e268..ff0f6a0 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -244,9 +244,6 @@ int __init acpi_boot_init(void)
>  	if (err)
>  		pr_err("Can't find FADT\n");
>  
> -	/* Get the boot CPU's MPIDR before MADT parsing */
> -	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
> -
>  	err = acpi_parse_madt_gic_cpu_interface_entries();
>  
>  	return err;
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index e00d40c..17ab98e 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -394,13 +394,14 @@ void __init setup_arch(char **cmdline_p)
>  
>  	efi_idmap_init();
>  
> +	/* Get the boot CPU's MPIDR before cpu logical map is built */

That comment's a bit useless; I think it can just be dropped.

All you need to do is move the initialisation of cpu_logical_map(0)
before unflatten_device_tree(). When you introduce acpi_boot_init(),
place it after the initialisation.

Thanks,
Mark.

> +	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
>  	acpi_boot_init();
>  
>  	unflatten_device_tree();
>  
>  	psci_init();
>  
> -	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
>  	cpu_read_bootcpu_ops();
>  #ifdef CONFIG_SMP
>  	smp_init_cpus();
> -- 
> 1.7.9.5
> 
> 
