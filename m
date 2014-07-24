From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 10/19] ARM64 / ACPI: Get the enable method for SMP
 initialization in ACPI way
Date: Thu, 24 Jul 2014 16:47:45 +0100
Message-ID: <20140724154745.GD26190@leverpostej>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-11-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1406206825-15590-11-git-send-email-hanjun.guo@linaro.org>
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
Cc: Mark Brown <broonie@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "linaro-acpi-private@linaro.org" <linaro-acpi-private@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "graeme.gregory@linaro.org" <graeme.gregory@>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 24, 2014 at 02:00:16PM +0100, Hanjun Guo wrote:
> ACPI 5.1 only has two explicit methods to boot up SMP,
> PSCI and Parking protocol, but the Parking protocol is
> only suitable for ARMv7 now, so make PSCI as the only way
> for the SMP boot protocol before some updates for the
> ACPI spec or the Parking protocol spec.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> ---
>  arch/arm64/include/asm/acpi.h    |   21 +++++++++++++++
>  arch/arm64/include/asm/cpu_ops.h |    9 ++++++-
>  arch/arm64/include/asm/smp.h     |    2 +-
>  arch/arm64/kernel/acpi.c         |    9 +++++++
>  arch/arm64/kernel/cpu_ops.c      |   52 ++++++++++++++++++++++++++++++++++----
>  arch/arm64/kernel/smp.c          |   29 +++++++++++++++++++--
>  6 files changed, 113 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 5ce85f8..6240327 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -14,6 +14,27 @@
> 
>  /* Basic configuration for ACPI */
>  #ifdef CONFIG_ACPI
> +/*
> + * ACPI 5.1 only has two explicit methods to
> + * boot up SMP, PSCI and Parking protocol,
> + * but the Parking protocol is only defined
> + * for ARMv7 now, so make PSCI as the only
> + * way for the SMP boot protocol before some
> + * updates for the ACPI spec or the Parking
> + * protocol spec.
> + *
> + * This enum is intend to make the boot method
> + * scalable when above updates are happended,
> + * which NOT means to support all of them.
> + */
> +enum acpi_smp_boot_protocol {
> +       ACPI_SMP_BOOT_PSCI,
> +       ACPI_SMP_BOOT_PARKING_PROTOCOL,
> +       ACPI_SMP_BOOT_PROTOCOL_MAX
> +};
> +
> +enum acpi_smp_boot_protocol smp_boot_protocol(void);
> +
>  extern int acpi_disabled;
>  extern int acpi_noirq;
>  extern int acpi_pci_disabled;
> diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
> index d7b4b38..2a7c6fd 100644
> --- a/arch/arm64/include/asm/cpu_ops.h
> +++ b/arch/arm64/include/asm/cpu_ops.h
> @@ -61,7 +61,14 @@ struct cpu_operations {
>  };
> 
>  extern const struct cpu_operations *cpu_ops[NR_CPUS];
> -extern int __init cpu_read_ops(struct device_node *dn, int cpu);
> +extern int __init cpu_of_read_ops(struct device_node *dn, int cpu);
> +
> +#ifdef CONFIG_ACPI
> +extern int __init cpu_acpi_read_ops(int cpu);
> +#else
> +static inline int __init cpu_acpi_read_ops(int cpu) { return -ENODEV; }
> +#endif
> +
>  extern void __init cpu_read_bootcpu_ops(void);
> 
>  #endif /* ifndef __ASM_CPU_OPS_H */
> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index a498f2c..a5cea56 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -39,7 +39,7 @@ extern void show_ipi_list(struct seq_file *p, int prec);
>  extern void handle_IPI(int ipinr, struct pt_regs *regs);
> 
>  /*
> - * Setup the set of possible CPUs (via set_cpu_possible)
> + * Platform specific SMP operations
>   */
>  extern void smp_init_cpus(void);

While the originial comment is out of date, the new form is plain wrong.

Something like "Discover the set of possible CPUs and determine their
SMP operations" would be a better description of what's going on here.

> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index ff0f6a0..2af6662 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -184,6 +184,15 @@ static int __init acpi_parse_madt_gic_cpu_interface_entries(void)
>         return 0;
>  }
> 
> +/* Protocol to bring up secondary CPUs */
> +enum acpi_smp_boot_protocol smp_boot_protocol(void)
> +{
> +       if (acpi_psci_present)
> +               return ACPI_SMP_BOOT_PSCI;
> +       else
> +               return ACPI_SMP_BOOT_PARKING_PROTOCOL;
> +}
> +
>  static int __init acpi_parse_fadt(struct acpi_table_header *table)
>  {
>         struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
> diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
> index d62d12f..4d9b3cf 100644
> --- a/arch/arm64/kernel/cpu_ops.c
> +++ b/arch/arm64/kernel/cpu_ops.c
> @@ -16,11 +16,13 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
> 
> -#include <asm/cpu_ops.h>
> -#include <asm/smp_plat.h>
>  #include <linux/errno.h>
>  #include <linux/of.h>
>  #include <linux/string.h>
> +#include <linux/acpi.h>
> +
> +#include <asm/cpu_ops.h>
> +#include <asm/smp_plat.h>

Was the header move just for consistency with other files, or is there
some ordering requirement here?

> 
>  extern const struct cpu_operations smp_spin_table_ops;
>  extern const struct cpu_operations cpu_psci_ops;
> @@ -52,7 +54,7 @@ static const struct cpu_operations * __init cpu_get_ops(const char *name)
>  /*
>   * Read a cpu's enable method from the device tree and record it in cpu_ops.
>   */
> -int __init cpu_read_ops(struct device_node *dn, int cpu)
> +int __init cpu_of_read_ops(struct device_node *dn, int cpu)
>  {
>         const char *enable_method = of_get_property(dn, "enable-method", NULL);
>         if (!enable_method) {
> @@ -76,12 +78,52 @@ int __init cpu_read_ops(struct device_node *dn, int cpu)
>         return 0;
>  }
> 
> +#ifdef CONFIG_ACPI
> +/*
> + * Read a cpu's enable method in the ACPI way and record it in cpu_ops.
> + */
> +int __init cpu_acpi_read_ops(int cpu)
> +{
> +       /*
> +        * For ACPI 5.1, only two kind of methods are provided,
> +        * Parking protocol and PSCI, but Parking protocol is
> +        * used on ARMv7 only, so make PSCI as the only method
> +        * for SMP initialization before the ACPI spec or Parking
> +        * protocol spec is updated.
> +        */

That comment is a little misleading. The parking protocol is _specified_
for ARMv7 only.

> +       switch (smp_boot_protocol()) {
> +       case ACPI_SMP_BOOT_PSCI:
> +               cpu_ops[cpu] = cpu_get_ops("psci");
> +               break;
> +       case ACPI_SMP_BOOT_PARKING_PROTOCOL:
> +       default:
> +               cpu_ops[cpu] = NULL;
> +               break;
> +       }
> +
> +       if (!cpu_ops[cpu]) {
> +               pr_warn("CPU %d: unsupported enable-method, only PSCI is supported\n",
> +                       cpu);
> +               return -EOPNOTSUPP;
> +       }

That's going to require changes as things get updated, and
"enable-method" is a term from DT rather than ACPI.

How about:

	"CPU%d: boot protocol unsupported or unknown\n".

Cheers,
Mark.
