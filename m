From: Sudeep Holla <Sudeep.Holla@arm.com>
Subject: Re: [PATCH 07/20] ARM64 / ACPI: Enable ARM64 in Kconfig
Date: Fri, 17 Jan 2014 14:34:48 +0000
Message-ID: <52D93F88.8090801@arm.com>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-8-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1389961514-13562-8-git-send-email-hanjun.guo@linaro.org>
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

On 17/01/14 12:25, Hanjun Guo wrote:
> Add Kconfigs to build ACPI on ARM64, and make ACPI runable on ARM64.
> 
> acpi_idle driver is x86/IA64 dependent now, so make CONFIG_ACPI_PROCESSOR
> depends on X86 || IA64, and implement it on ARM/ARM64 in the furture.
> 
> In order to make arm-core.c can both run on ARM and ARM64, introduce
> CONFIG_ACPI_ARM to support it.
> 
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/Kconfig         |    2 ++
>  drivers/acpi/Kconfig       |   11 ++++++++---
>  drivers/acpi/plat/Makefile |    2 +-
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6d4dd22..2b1fb1d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -279,6 +279,8 @@ source "net/Kconfig"
>  
>  source "drivers/Kconfig"
>  
> +source "drivers/acpi/Kconfig"
> +
>  source "fs/Kconfig"
>  
>  source "arch/arm64/kvm/Kconfig"
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 4770de5..cae5dc9 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -2,13 +2,16 @@
>  # ACPI Configuration
>  #
>  
> +config ACPI_ARM
> +	bool
> +
>  menuconfig ACPI
>  	bool "ACPI (Advanced Configuration and Power Interface) Support"
>  	depends on !IA64_HP_SIM
> -	depends on IA64 || X86
> -	depends on PCI
> +	depends on ((IA64 || X86) && PCI) || ARM64
>  	select PNP
> -	default y
> +	select ACPI_ARM if ARM64
> +	default y if !ARM64
>  	help
>  	  Advanced Configuration and Power Interface (ACPI) support for 
>  	  Linux requires an ACPI-compliant platform (hardware/firmware),
> @@ -149,6 +152,7 @@ config ACPI_PROCESSOR
>  	tristate "Processor"
>  	select THERMAL
>  	select CPU_IDLE
> +	depends on X86 || IA64

This doesn't look correct to me. You are disabling Perf/Idle/Thermal/Throttling
support for ARM64. Any particular reason ?

Also this is conflicting with other change where you are adding/exporting
boot_option_idle_override which is mainly used in processor_idle and that's
disabled for ARM64 here.

Regards,
Sudeep
