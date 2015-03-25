From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 5/5] ARM64: kernel: acpi: honour acpi=force command line parameter
Date: Wed, 25 Mar 2015 07:20:35 +0100
Message-ID: <CAKv+Gu9E2DCy29QSWK4gQLE+YPMbZhSfyg_TN6xDFfekJ27dFA@mail.gmail.com>
References: <1427219940-27201-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1427219940-27201-6-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35674 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbbCYGUg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Mar 2015 02:20:36 -0400
Received: by igcau2 with SMTP id au2so92716309igc.0
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2015 23:20:35 -0700 (PDT)
In-Reply-To: <1427219940-27201-6-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>

On 24 March 2015 at 18:58, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> If acpi=force is passed on the command line, it forces ACPI to be
> the only available boot method, hence it must be left enabled even
> if the initialization and sanity checks on ACPI tables fails.
>
> This patch refactors ACPI initialization to prevent disabling ACPI
> if acpi=force is passed on the command line.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---

Yes, much better

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

>  arch/arm64/include/asm/acpi.h | 3 ---
>  arch/arm64/kernel/acpi.c      | 6 ++++--
>  arch/arm64/kernel/setup.c     | 2 +-
>  3 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index e1a8965..59c05d8 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -38,7 +38,6 @@ typedef u64 phys_cpuid_t;
>  extern int acpi_disabled;
>  extern int acpi_noirq;
>  extern int acpi_pci_disabled;
> -extern bool param_acpi_force;
>
>  /* 1 to indicate PSCI 0.2+ is implemented */
>  static inline bool acpi_psci_present(void)
> @@ -92,8 +91,6 @@ void __init acpi_init_cpus(void);
>  static inline bool acpi_psci_present(void) { return false; }
>  static inline bool acpi_psci_use_hvc(void) { return false; }
>  static inline void acpi_init_cpus(void) { }
> -
> -#define param_acpi_force false
>  #endif /* CONFIG_ACPI */
>
>  #endif /*_ASM_ACPI_H*/
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 542f045..789994a 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -43,7 +43,7 @@ static int enabled_cpus;
>  static bool bootcpu_valid  __initdata;
>
>  static bool param_acpi_off __initdata;
> -bool param_acpi_force __initdata;
> +static bool param_acpi_force __initdata;
>
>  static int __init parse_acpi(char *arg)
>  {
> @@ -324,8 +324,10 @@ out:
>          * If ACPI tables are initialized and FADT sanity checks passed,
>          * leave ACPI enabled and carry on booting; otherwise disable ACPI
>          * on initialization error.
> +        * If acpi=force was passed on the command line it forces ACPI
> +        * to be enabled even if its initialization failed.
>          */
> -       if (err)
> +       if (err && !param_acpi_force)
>                 disable_acpi();
>  }
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index d60b1ad..b278311 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -390,7 +390,7 @@ void __init setup_arch(char **cmdline_p)
>
>         early_ioremap_reset();
>
> -       if (acpi_disabled  && !param_acpi_force) {
> +       if (acpi_disabled) {
>                 unflatten_device_tree();
>                 psci_dt_init();
>                 cpu_read_bootcpu_ops();
> --
> 2.2.1
>
