From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 1/2] mce: acpi/apei: Honour Firmware First for MCA
 banks listed in APEI HEST CMC
Date: Thu, 20 Jun 2013 09:39:43 +0200
Message-ID: <20130620073943.GE32694@pd.tnic>
References: <20130619175438.2852.93449.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56146 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753968Ab3FTHjy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Jun 2013 03:39:54 -0400
Content-Disposition: inline
In-Reply-To: <20130619175438.2852.93449.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: tony.luck@intel.com, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com

On Wed, Jun 19, 2013 at 11:27:17PM +0530, Naveen N. Rao wrote:
> The Corrected Machine Check structure (CMC) in HEST has a flag which =
can be
> set by the firmware to indicate to the OS that it prefers to process =
the
> corrected error events first. In this scenario, the OS is expected to=
 not
> monitor for corrected errors (through CMCI/polling). Instead, the fir=
mware
> notifies the OS on corrected error events through GHES.
>=20
> Linux already has support for GHES. This patch adds support for parsi=
ng CMC
> structure and to disable CMCI/polling if the firmware first flag is s=
et.
>=20
> Further, the list of machine check bank structures at the end of CMC =
is used
> to determine which MCA banks function in FF mode, so that we continue=
 to
> monitor error events on the other banks.
>=20
>=20
> - Naveen
>=20
> --
> Changes:
> - Incorporated comments from Boris and Tony from the previous thread =
at
>   http://thread.gmane.org/gmane.linux.acpi.devel/60802
> - Added patch to disable firmware first mode through a boot option.
>=20
>=20
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/x86/include/asm/mce.h                |    3 ++
>  arch/x86/kernel/cpu/mcheck/mce-internal.h |    3 ++
>  arch/x86/kernel/cpu/mcheck/mce.c          |   25 ++++++++++++++++++
>  arch/x86/kernel/cpu/mcheck/mce_intel.c    |   40 +++++++++++++++++++=
++++------
>  drivers/acpi/apei/hest.c                  |   36 +++++++++++++++++++=
+++++++
>  5 files changed, 99 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index fa5f71e..380fff8 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -188,6 +188,9 @@ extern void register_mce_write_callback(ssize_t (=
*)(struct file *filp,
>  				    const char __user *ubuf,
>  				    size_t usize, loff_t *off));
> =20
> +/* Disable CMCI/polling for MCA bank claimed by firmware */
> +extern void mce_disable_ce_bank(int bank);
> +
>  /*
>   * Exception handler
>   */
> diff --git a/arch/x86/kernel/cpu/mcheck/mce-internal.h b/arch/x86/ker=
nel/cpu/mcheck/mce-internal.h
> index 5b7d4fa..193edc1 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce-internal.h
> +++ b/arch/x86/kernel/cpu/mcheck/mce-internal.h
> @@ -25,6 +25,9 @@ int mce_severity(struct mce *a, int tolerant, char =
**msg);
>  struct dentry *mce_get_debugfs_dir(void);
> =20
>  extern struct mce_bank *mce_banks;
> +extern mce_banks_t mce_banks_ce_disabled;
> +
> +void cmci_disable_bank(int bank);
> =20
>  #ifdef CONFIG_X86_MCE_INTEL
>  unsigned long mce_intel_adjust_timer(unsigned long interval);
> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/m=
check/mce.c
> index 9239504..9512034 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> @@ -94,6 +94,9 @@ DEFINE_PER_CPU(mce_banks_t, mce_poll_banks) =3D {
>  	[0 ... BITS_TO_LONGS(MAX_NR_BANKS)-1] =3D ~0UL
>  };
> =20
> +/* MCA banks controlled through firmware first for corrected errors =
*/
> +mce_banks_t mce_banks_ce_disabled;

Why the second bitfield? The cleared bits in mce_poll_banks should be
the banks which are handled in FF mode, no?

> +
>  static DEFINE_PER_CPU(struct work_struct, mce_work);
> =20
>  static void (*quirk_no_way_out)(int bank, struct mce *m, struct pt_r=
egs *regs);
> @@ -1932,6 +1935,28 @@ static struct miscdevice mce_chrdev_device =3D=
 {
>  	&mce_chrdev_ops,
>  };
> =20
> +static void __mce_disable_ce_bank(void *arg)
> +{
> +	int bank =3D *((int *)arg);
> +
> +	/* Ensure we don't poll this bank */

No need for that comment.

> +	__clear_bit(bank, __get_cpu_var(mce_poll_banks));
> +	/* Disable CMCI */

No need for that comment either - function name cannot be more
descriptive :-)

> +	cmci_disable_bank(bank);
> +}
> +
> +void mce_disable_ce_bank(int bank)

Yeah, let's call it ...disable_poll_bank because we're disabling pollin=
g
for those banks. And yes, we poll for errors for which no MCE exception
is generated and those happen to be corrected but still...

> +{
> +	if (bank >=3D mca_cfg.banks) {
> +		pr_warning(FW_BUG=20
> +			"Ignoring request to disable invalid MCA bank %d.\n",
> +			bank);
> +		return;
> +	}
> +	set_bit(bank, mce_banks_ce_disabled);
> +	on_each_cpu(__mce_disable_ce_bank, &bank, 1);
> +}
> +
>  /*
>   * mce=3Doff Disables machine check
>   * mce=3Dno_cmci Disables CMCI
> diff --git a/arch/x86/kernel/cpu/mcheck/mce_intel.c b/arch/x86/kernel=
/cpu/mcheck/mce_intel.c
> index ae1697c..78256c0 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce_intel.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce_intel.c
> @@ -191,6 +191,10 @@ static void cmci_discover(int banks)
>  		if (test_bit(i, owned))
>  			continue;
> =20
> +		/* Skip banks in firmware first mode */
> +		if (test_bit(i, mce_banks_ce_disabled))
> +			continue;
> +
>  		rdmsrl(MSR_IA32_MCx_CTL2(i), val);
> =20
>  		/* Already owned by someone else? */
> @@ -259,6 +263,20 @@ void cmci_recheck(void)
>  	local_irq_restore(flags);
>  }
> =20
> +/* Caller must hold the lock on cmci_discover_lock */
> +static void __cmci_disable_bank(int bank)
> +{
> +	u64 val;
> +
> +	if (!test_bit(bank, __get_cpu_var(mce_banks_owned)))
> +		return;
> +	/* Disable CMCI */
> +	rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
> +	val &=3D ~MCI_CTL2_CMCI_EN;
> +	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
> +	__clear_bit(bank, __get_cpu_var(mce_banks_owned));
> +}
> +
>  /*
>   * Disable CMCI on this CPU for all banks it owns when it goes down.
>   * This allows other CPUs to claim the banks on rediscovery.
> @@ -268,19 +286,12 @@ void cmci_clear(void)
>  	unsigned long flags;
>  	int i;
>  	int banks;
> -	u64 val;
> =20
>  	if (!cmci_supported(&banks))
>  		return;
>  	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
>  	for (i =3D 0; i < banks; i++) {
> -		if (!test_bit(i, __get_cpu_var(mce_banks_owned)))
> -			continue;
> -		/* Disable CMCI */
> -		rdmsrl(MSR_IA32_MCx_CTL2(i), val);
> -		val &=3D ~MCI_CTL2_CMCI_EN;
> -		wrmsrl(MSR_IA32_MCx_CTL2(i), val);
> -		__clear_bit(i, __get_cpu_var(mce_banks_owned));
> +		__cmci_disable_bank(i);
>  	}

This leaves only one line so no need for the {} braces anymore.

>  	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
>  }
> @@ -315,6 +326,19 @@ void cmci_reenable(void)
>  		cmci_discover(banks);
>  }
> =20
> +void cmci_disable_bank(int bank)
> +{
> +	int banks;
> +	unsigned long flags;
> +
> +	if (!cmci_supported(&banks))
> +		return;
> +
> +	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
> +	__cmci_disable_bank(bank);
> +	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
> +}

You need a prototype for that if you're going to call it from mce.c but
CONFIG_X86_MCE_INTEL is not set:

arch/x86/built-in.o: In function `__mce_disable_ce_bank':
/home/boris/kernel/linux-2.6/arch/x86/kernel/cpu/mcheck/mce.c:1945: und=
efined reference to `cmci_disable_bank'
make: *** [vmlinux] Error 1

> +
>  static void intel_init_cmci(void)
>  {
>  	int banks;
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index f5ef5d5..d8c69ba 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -36,6 +36,7 @@
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
>  #include <acpi/apei.h>
> +#include <asm/mce.h>
> =20
>  #include "apei-internal.h"
> =20
> @@ -121,6 +122,39 @@ int apei_hest_parse(apei_hest_func_t func, void =
*data)
>  }
>  EXPORT_SYMBOL_GPL(apei_hest_parse);
> =20
> +/*
> + * Check if firmware advertises firmware first mode. We need FF bit =
to be set
> + * along with a set of MC banks which work in FF mode.
> + */
> +static int __init hest_parse_cmc(struct acpi_hest_header *hest_hdr, =
void *data)
> +{
> +	int i;
> +	struct acpi_hest_ia_corrected *cmc;
> +	struct acpi_hest_ia_error_bank *mc_bank;
> +
> +	if (hest_hdr->type !=3D ACPI_HEST_TYPE_IA32_CORRECTED_CHECK)
> +		return 0;
> +
> +	cmc =3D (struct acpi_hest_ia_corrected *)hest_hdr;
> +	if (!cmc->enabled || !(cmc->flags & ACPI_HEST_FIRMWARE_FIRST))
> +		return 0;
> +
> +	/*
> +	 * We expect HEST to provide a list of MC banks that
> +	 * report errors through firmware first mode.

		     ... in firmware first mode.

> +	 */
> +	if (cmc->num_hardware_banks =3D=3D 0)

	if (!cmc->num_hardware_banks)

> +		return 0;

Err, why does this function return 0 when the sanity checks above fail?
apei_hest_parse actually looks at the retval and advances the hest_hdr.

> +
> +	pr_info(HEST_PFX "Enabling Firmware First mode for corrected errors=
=2E\n");
> +
> +	mc_bank =3D (struct acpi_hest_ia_error_bank *)(cmc + 1);
> +	for (i =3D 0; i < cmc->num_hardware_banks; i++, mc_bank++)
> +		mce_disable_ce_bank(mc_bank->bank_number);
> +
> +	return 0;

IOW, we should return 0 only here.

[ =E2=80=A6 ]

--=20
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
