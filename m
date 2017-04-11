From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4] mfd: intel_soc_pmic: Fix a mess with compilation units
Date: Tue, 11 Apr 2017 14:54:12 +0100
Message-ID: <20170411135412.qnepq52p3m44zqkq@dell>
References: <20170404123856.3052-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170404123856.3052-1-andriy.shevchenko@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

On Tue, 04 Apr 2017, Andy Shevchenko wrote:

> Crystal Cove and Whiskey Cove are two different PMICs which are
> installed on Intel Atom SoC based platforms.
> 
> Moreover there are two independent drivers that by some reason were
> supposed (*) to get into one kernel module.
> 
> Fix the mess by clarifying Kconfig option for Crystal Cove and split
> Whiskey Cove out of it.
> 
> (*) It looks like the configuration was never tested with
>     INTEL_SOC_PMIC=n. The line in Makefile is actually wrong.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net> (supporter:ACPI)
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  - fix dependency for now, proper fix is to provide headers in platform_data/x86
>  - add tags
>  drivers/acpi/Kconfig         |  2 +-
>  drivers/gpio/Kconfig         |  2 +-
>  drivers/mfd/Kconfig          | 15 +++++++++++++--
>  drivers/mfd/Makefile         |  2 +-
>  drivers/platform/x86/Kconfig |  2 +-
>  drivers/thermal/Kconfig      |  2 +-
>  6 files changed, 18 insertions(+), 7 deletions(-)

Applied, thanks.

> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 3e15bf8f99f7..47d4e7be7a46 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -512,7 +512,7 @@ config XPOWER_PMIC_OPREGION
>  
>  config BXT_WC_PMIC_OPREGION
>  	bool "ACPI operation region support for BXT WhiskeyCove PMIC"
> -	depends on INTEL_SOC_PMIC
> +	depends on INTEL_SOC_PMIC_BXTWC
>  	help
>  	  This config adds ACPI operation region support for BXT WhiskeyCove PMIC.
>  
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 63ceed246b6f..05e8fbfb3d85 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1053,7 +1053,7 @@ config GPIO_UCB1400
>  
>  config GPIO_WHISKEY_COVE
>  	tristate "GPIO support for Whiskey Cove PMIC"
> -	depends on (X86 || COMPILE_TEST) && INTEL_SOC_PMIC
> +	depends on (X86 || COMPILE_TEST) && INTEL_SOC_PMIC_BXTWC
>  	select GPIOLIB_IRQCHIP
>  	help
>  	  Support for GPIO pins on Whiskey Cove PMIC.
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index ce3a9180a765..a48176eb9b48 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -446,18 +446,29 @@ config LPC_SCH
>  	  System Management Bus and General Purpose I/O.
>  
>  config INTEL_SOC_PMIC
> -	bool "Support for Intel Atom SoC PMIC"
> +	bool "Support for Crystal Cove PMIC"
>  	depends on GPIOLIB
>  	depends on I2C=y
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	select REGMAP_IRQ
>  	help
> -	  Select this option to enable support for the PMIC device
> +	  Select this option to enable support for Crystal Cove PMIC
>  	  on some Intel SoC systems. The PMIC provides ADC, GPIO,
>  	  thermal, charger and related power management functions
>  	  on these systems.
>  
> +config INTEL_SOC_PMIC_BXTWC
> +	tristate "Support for Intel Broxton Whiskey Cove PMIC"
> +	depends on INTEL_PMC_IPC
> +	select MFD_CORE
> +	select REGMAP_IRQ
> +	help
> +	  Select this option to enable support for Whiskey Cove PMIC
> +	  on Intel Broxton systems. The PMIC provides ADC, GPIO,
> +	  thermal, charger and related power management functions
> +	  on these systems.
> +
>  config MFD_INTEL_LPSS
>  	tristate
>  	select COMMON_CLK
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index fa86dbe65e52..c16bf1ea0ea9 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -212,8 +212,8 @@ obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
>  obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
>  
>  intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
> -intel-soc-pmic-$(CONFIG_INTEL_PMC_IPC)	+= intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
> +obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)	+= intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
>  
>  obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 5602bdfcad65..4c0933174cd9 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1020,7 +1020,7 @@ config INTEL_PMC_IPC
>  config INTEL_BXTWC_PMIC_TMU
>  	tristate "Intel BXT Whiskey Cove TMU Driver"
>  	depends on REGMAP
> -	depends on INTEL_SOC_PMIC && INTEL_PMC_IPC
> +	depends on INTEL_SOC_PMIC_BXTWC && INTEL_PMC_IPC
>  	---help---
>  	  Select this driver to use Intel BXT Whiskey Cove PMIC TMU feature.
>  	  This driver enables the alarm wakeup functionality in the TMU unit
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 93474015bb1d..8e47cfaa9aab 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -353,7 +353,7 @@ endmenu
>  
>  config INTEL_BXT_PMIC_THERMAL
>  	tristate "Intel Broxton PMIC thermal driver"
> -	depends on X86 && INTEL_SOC_PMIC && REGMAP
> +	depends on X86 && INTEL_SOC_PMIC_BXTWC && REGMAP
>  	help
>  	  Select this driver for Intel Broxton PMIC with ADC channels monitoring
>  	  system temperature measurements and alerts.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
