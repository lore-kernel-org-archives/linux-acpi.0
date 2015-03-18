From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [update][PATCH v10 06/21] ACPI / sleep: Introduce CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
Date: Wed, 18 Mar 2015 15:36:01 +0100
Message-ID: <356700098.jFZbVDoYAQ@vostro.rjw.lan>
References: <1426661211-14272-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65430 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S934003AbbCROMH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Mar 2015 10:12:07 -0400
In-Reply-To: <1426661211-14272-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>

On Wednesday, March 18, 2015 02:46:51 PM Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> ACPI 5.1 does not currently support S states for ARM64 hardware but
> ACPI code will call acpi_target_system_state() and acpi_sleep_init()
> for device power management, so introduce
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT and select it for x86 and
> ia64 only to make sleep functions available, and also introduce stub
> function to allow other drivers to function until S states are defined
> for ARM64.
> 
> It will be no functional change for x86 and IA64.
> 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Hi Lorenzo,
> 
> Since this patch only updated the config name with no fucntion
> change, I assume your ACK still apply, if not, please let me
> know.
> 
> Thanks
> Hanjun
> ---
>  arch/ia64/Kconfig       | 1 +
>  arch/x86/Kconfig        | 1 +
>  drivers/acpi/Kconfig    | 4 ++++
>  drivers/acpi/Makefile   | 2 +-
>  drivers/acpi/internal.h | 4 ++++
>  5 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index 074e52b..cc3414f 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -10,6 +10,7 @@ config IA64
>  	select ARCH_MIGHT_HAVE_PC_SERIO
>  	select PCI if (!IA64_HP_SIM)
>  	select ACPI if (!IA64_HP_SIM)
> +	select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
>  	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
>  	select HAVE_UNSTABLE_SCHED_CLOCK
>  	select HAVE_IDE
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b7d31ca..c3ea9f9 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -22,6 +22,7 @@ config X86_64
>  ### Arch settings
>  config X86
>  	def_bool y
> +	select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
>  	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
>  	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
>  	select ARCH_HAS_FAST_MULTIPLIER
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index e6c3ddd..a726381 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -48,9 +48,13 @@ config ACPI_LEGACY_TABLES_LOOKUP
>  config ARCH_MIGHT_HAVE_ACPI_PDC
>  	bool
>  
> +config ACPI_SYSTEM_POWER_STATES_SUPPORT
> +	bool
> +
>  config ACPI_SLEEP
>  	bool
>  	depends on SUSPEND || HIBERNATION
> +	depends on ACPI_SYSTEM_POWER_STATES_SUPPORT
>  	default y
>  
>  config ACPI_PROCFS_POWER
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 623b117..db153c6 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -23,7 +23,7 @@ acpi-y				+= nvs.o
>  
>  # Power management related files
>  acpi-y				+= wakeup.o
> -acpi-y				+= sleep.o
> +acpi-$(CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT) += sleep.o
>  acpi-y				+= device_pm.o
>  acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o
>  
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 56b321a..ba4a61e 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -161,7 +161,11 @@ void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit);
>  /*--------------------------------------------------------------------------
>                                    Suspend/Resume
>    -------------------------------------------------------------------------- */
> +#ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
>  extern int acpi_sleep_init(void);
> +#else
> +static inline int acpi_sleep_init(void) { return -ENXIO; }
> +#endif
>  
>  #ifdef CONFIG_ACPI_SLEEP
>  int acpi_sleep_proc_init(void);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
