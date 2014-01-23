From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 07/20] ARM64 / ACPI: Enable ARM64 in Kconfig
Date: Thu, 23 Jan 2014 16:39:39 +0000
Message-ID: <20140123163939.GB25927@localhost>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-8-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1389961514-13562-8-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, graeme.gregory@lin
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 17, 2014 at 12:25:01PM +0000, Hanjun Guo wrote:
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

Could be better as def_bool ARM64

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

And remove this select here.

-- 
Catalin
